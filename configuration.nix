{ pkgs, ... }:
let
  py = pkgs.python3Packages;
  plotext528 = py.buildPythonPackage rec {
    pname = "plotext";
    version = "5.2.8";
    format = "setuptools";
    src = pkgs.fetchPypi {
      inherit pname version;
      sha256 = "319a287baabeb8576a711995f973a2eba631c887aa6b0f33ab016f12c50ffebe";
    };
    doCheck = false;
  };
  ccburn = py.buildPythonApplication rec {
    pname = "ccburn";
    version = "0.8.0";
    pyproject = true;
    src = pkgs.fetchPypi {
      inherit pname version;
      sha256 = "9cbee52398f5b95b315f3218dd39579098e955749ce7d4e8526a3a646a056284";
    };
    build-system = [ py.setuptools py.hatchling ];
    dependencies = [ py.typer py.rich py.httpx py.certifi plotext528 ];
    doCheck = false;
    pythonImportsCheck = [ "ccburn" ];
  };
in
{
  environment.systemPackages = [ ccburn ];
}
