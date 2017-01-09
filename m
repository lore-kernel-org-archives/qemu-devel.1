Received: from eggs.gnu.org ([2001:4830:134:3::10]:46851)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cQQ1U-0006BN-T5
	for qemu-devel@nongnu.org; Sun, 08 Jan 2017 21:49:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cQQ1R-0000df-R9
	for qemu-devel@nongnu.org; Sun, 08 Jan 2017 21:49:24 -0500
Date: Mon, 9 Jan 2017 13:49:09 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170109024909.GE12515@umbus.fritz.box>
References: <1483683296-32568-1-git-send-email-nikunj@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ZRyEpB+iJ+qUx0kp"
Content-Disposition: inline
In-Reply-To: <1483683296-32568-1-git-send-email-nikunj@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v1 00/14] POWER9 TCG enablements - part10
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Cc: qemu-ppc@nongnu.org, rth@twiddle.net, qemu-devel@nongnu.org, bharata@linux.vnet.ibm.com


--ZRyEpB+iJ+qUx0kp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 06, 2017 at 11:44:42AM +0530, Nikunj A Dadhania wrote:
> This series contains 11 new instructions for POWER9 ISA3.0
>      VSX Vector Insert/Extract Word
>      VSX Scalar Extract Exponent/Significand
>      VSX Scalar Convert
>      VSX Scalar Add QP
>      Various float related improvements

Applied to ppc-for-2.9, thanks.

>=20
> Changelog:
> v0:
>    Rebase and update reviewed-by
>=20
> Bharata B Rao (8):
>   target-ppc: Use float64 arg in helper_compute_fprf()
>   target-ppc: Replace isden by float64_is_zero_or_denormal
>   target-ppc: Rename helper_compute_fprf to helper_compute_fprf_float64
>   target-ppc: Add xsaddqp instructions
>   target-ppc: Add xscvdphp, xscvhpdp
>   target-ppc: Use correct precision for FPRF setting
>   target-ppc: Add xscvdpqp instruction
>   target-ppc: Add xscvqpdp instruction
>=20
> Nikunj A Dadhania (6):
>   target-ppc: Add xxextractuw instruction
>   target-ppc: Add xxinsertw instruction
>   target-ppc: Add xsxexpdp instruction
>   target-ppc: Add xsxexpqp instruction
>   target-ppc: Add xsxsigdp instruction
>   target-ppc: Add xsxsigqp instructions
>=20
>  include/fpu/softfloat.h             |  20 +++
>  target/ppc/fpu_helper.c             | 241 +++++++++++++++++++++++++-----=
------
>  target/ppc/helper.h                 |   9 +-
>  target/ppc/int_helper.c             |  51 ++++++++
>  target/ppc/internal.h               |   6 +
>  target/ppc/translate/fp-impl.inc.c  |  20 +--
>  target/ppc/translate/vsx-impl.inc.c | 122 ++++++++++++++++++
>  target/ppc/translate/vsx-ops.inc.c  |  18 +++
>  8 files changed, 405 insertions(+), 82 deletions(-)
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--ZRyEpB+iJ+qUx0kp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYcvojAAoJEGw4ysog2bOSHEEP+gKhb1HnzG9TAAee5b9YNwo8
Et7qOItC5UpBfzICckH5PHBNyoykG4ZJA6nXIvJM2D52Fz12aBNYlTDM3bv7eThU
ATibNPnZfG4nin6LoBoaOTKLgjch6Re0ELyMRXftqgo5Iu+jkBed7GZ/7UL+xtXC
VsBqa6BIKCSuPGAc2nRJc0uXuFTmUl4vrBRHO2fj7WJxHBRHjWCdOIXjB/mTZA0A
LzLznzjXspYON99onMpWTGO40IWXXYHH0Lbl5ctXRzI+ZniQfhEPnI4VBm9PFB/W
EN6owRKt2xObqdrW0SPcDYVVWFck+tZQi7zeZDGFKmA564khedGMZVAP3/TcKXbH
DkhaeXOWRSGn0VbXbeh6DLsBRLLadFCwFejq4eddWDb5JV5okNAQOF0Vv8W7eHAB
WZxkWWd4tGCDC5QVN7zINuPbyHBa5YfLxj2mZOesYMUftyLns0g7waTLI3eR4pWb
JPWMn9DGJkprNyrC1W3HaGaLpNvgWZhUsHQAfpo7rg5p2tgdzFwmMkB/WEgyWP52
lqkMywNZ87HPTEoWWbJjBi2pQaye+K4txQs1r51WAfhDPZHk0LvLDvLjY7hgbtJQ
FmTlkgTUJpmLpl7qFwpMSYy0OzQ5kTGYoBNPxfJhaFuqqJ4shrzF5Xdxq9wYbX/j
cLu8joo42q3uTt/T9ssi
=nMdf
-----END PGP SIGNATURE-----

--ZRyEpB+iJ+qUx0kp--
