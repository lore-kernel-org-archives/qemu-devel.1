Received: from eggs.gnu.org ([2001:4830:134:3::10]:34483)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cPGVo-0008A5-Ml
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 17:27:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cPGVl-0000gL-SD
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 17:27:56 -0500
Date: Fri, 6 Jan 2017 09:27:07 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170105222707.GH13763@umbus.fritz.box>
References: <1483615579-17618-1-git-send-email-nikunj@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="it/zdz3K1bH9Y8/E"
Content-Disposition: inline
In-Reply-To: <1483615579-17618-1-git-send-email-nikunj@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 00/14] POWER9 TCG enablements - part10
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


--it/zdz3K1bH9Y8/E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 05, 2017 at 04:56:05PM +0530, Nikunj A Dadhania wrote:
> This series contains 11 new instructions for POWER9 ISA3.0
>      VSX Vector Insert/Extract Word
>      VSX Scalar Extract Exponent/Significand
>      VSX Scalar Convert
>      VSX Scalar Add QP
>      Various float related improvements
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
>  target-ppc/fpu_helper.c             | 241 +++++++++++++++++++++++++-----=
------
>  target-ppc/helper.h                 |   9 +-
>  target-ppc/int_helper.c             |  51 ++++++++
>  target-ppc/internal.h               |   6 +
>  target-ppc/translate/fp-impl.inc.c  |  20 +--
>  target-ppc/translate/vsx-impl.inc.c | 122 ++++++++++++++++++
>  target-ppc/translate/vsx-ops.inc.c  |  18 +++
>  8 files changed, 405 insertions(+), 82 deletions(-)

These all need rebasing - the path is target/ppc now, rather than
target-ppc.

1/14 and 10..14/14 look otherwise ok, the reset have comments (or
depend on patches which have comments).

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--it/zdz3K1bH9Y8/E
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYbsg7AAoJEGw4ysog2bOSfCwQAIG8yzAEuPrRCG49mOHFef+7
8uuqWuBk3Xyd6C8bA1DBg7jaMMXutHWzd/z4KzIrsc+5DFApwN5J0iqi8/payuHJ
mbAwE8vx2HAODTjJZkT/cgXNfZncn+oTuW1zFJQmHHyy+wSrY2NQ7CgOLkuzkjNG
NxFHfC+OkLncDitmArlV+Wjc4LsBTi4ucPyAbrOTrU67ie3O+t61djm99j4uEqhc
Q7uPlZGhRl+NE4gJRtavhIpnErV5VUHjBWM1yChOMDz+6ye3bJXlv27CqEXFzf8O
cNhlHNPBIdTvWAvhbwT4LHehm8ODzDX8mbOhcOqlSm27y0B+1Xq+SorZo2BbYyqp
QfkVF2fzyZ4khAJEPKSJZuJb/edQLn1LUXPweokR4W/UDdgowXDyxidZWpF23+Nd
yKptfKQIzarMZpbG79zYZeCB1HeXqaXnM0P5p/6evN9VB+YTcq/D4xPBqP01sBx3
aAdm2ue6/O4I5W5GX8Ak2NPmZNtfRGtm2yu95y8zrnniy+1nVbBiYb03I8nHAm8k
9Xrc6xTEn7txZqlpQKVP9hF+K2PogvXh3k5VYfax7xxGXtE9/zGYFTyGoLTzPT/y
Rdkd6qaDt8Hy+/SV6Il1WWM76876J8mWENGGzBrYj6uz+zTRFiIa5DGjIOxtOY5q
F5l2fDMVd70R/+X7QLC6
=Hkcb
-----END PGP SIGNATURE-----

--it/zdz3K1bH9Y8/E--
