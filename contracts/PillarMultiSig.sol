pragma solidity ^0.4.15;
import "./MultiSigWallet.sol";
import 'zeppelin-solidity/contracts/token/ERC20.sol';

/// @title PillarMultiSig with customized functions.
/// @author Parthasarathy Ramanujam - <partha@pillarproject.io>
contract PillarMultiSig is MultiSigWallet {
    ERC20 token;

    function transferTokensTo(address tokenAddr,address to,uint256 qty)
    public
    ownerExists(msg.sender)
    returns (bool status) {
      require(tokenAddr != address(0));
      require(to != address(0));
      require(qty > 0);

      token = ERC20(token);
      status = token.transfer(to,qty);
      if(!status)
        revert();
    }

    function transferEther(address to,uint256 qty)
    public
    ownerExists(msg.sender)
    returns (bool status) {
      require(to != address(0));
      require(qty < this.balance);
      bytes data;
      this.submitTransaction(to,qty,data);
    }
}
