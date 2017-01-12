Received: from eggs.gnu.org ([2001:4830:134:3::10]:50144)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cRY6H-0001Xg-F6
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 00:39:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cRY6G-0004t3-Do
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 00:39:01 -0500
Date: Thu, 12 Jan 2017 16:38:26 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170112053826.GQ14026@umbus.fritz.box>
References: <1484038243-30314-1-git-send-email-nikunj@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="U/5EjKfnYgGK6hcj"
Content-Disposition: inline
In-Reply-To: <1484038243-30314-1-git-send-email-nikunj@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 00/11] POWER9 TCG enablements - part11
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


--U/5EjKfnYgGK6hcj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 10, 2017 at 02:20:32PM +0530, Nikunj A Dadhania wrote:
> This series contains 10 new instructions for POWER9 ISA3.0
>     VSX Scalar Insert Exponent
>     VSX Vector Insert Exponent
>     VSX Vector Extract Exponent/Significand
>     VSX Scalar Truncate & Convert Quad-Precision
>     Couple of fixes
>=20
> Bharata B Rao (2):
>   softfloat: Fix the default qNAN for target-ppc
>   target-ppc: Add xscvqps[d,w]z instructions
>=20
> Nikunj A Dadhania (9):
>   target-ppc: xscvqpdp zero VSR
>   target-ppc: Add xsiexpdp instruction
>   target-ppc: Add xsiexpqp instruction
>   target-ppc: Add xviexpsp instruction
>   target-ppc: Add xviexpdp instruction
>   target-ppc: Add xvxexpsp instruction
>   target-ppc: Add xvxexpdp instruction
>   target-ppc: Add xvxsigsp instruction
>   target-ppc: Add xvxsigdp instruction
>=20
>  fpu/softfloat-specialize.h          |   2 +-
>  target/ppc/fpu_helper.c             |  62 ++++++++++++-
>  target/ppc/helper.h                 |   3 +
>  target/ppc/translate/vsx-impl.inc.c | 172 ++++++++++++++++++++++++++++++=
++++++
>  target/ppc/translate/vsx-ops.inc.c  |  11 +++
>  5 files changed, 248 insertions(+), 2 deletions(-)

I've now applied the remainder of this series to ppc-for-2.9.


--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--U/5EjKfnYgGK6hcj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYdxZOAAoJEGw4ysog2bOSdEsP+QHniKbAxkFwy+HkInJK8j0Q
OMyBXndZWJwPgEeviWL+w3VedzPG/De8b3OWoEhUgIjwYENQdZv+a8kPzSSM7G/d
x7k9xZ3C+I8WMqXYhRZy7NWEAvQ/zMI43bEm33D0nOrG7WDKM4GRhrcMVKSVSdNW
B7VcXS1mkiJiFnr66G+SwCKSweIJPSvW5D+5g/Snuabi0Kw7RKa0EfLpgSsyImHq
dt+g6ch9c4wkoeffOuIk0euISZlnoAKmh570mWPK57t2rIja6hGST1dZe40ayuQ9
BYc6DLutRycAE/Q4gskLdBET0TIJy2YMsuC4nEewTM6l6cy/EfJizXrh+Xn4WirO
N2q6PsnXd2Ra0vHm2GRu71+UyVWyvHFU+QbVuz3JfNihCRcODZtem8qXIZE4zthr
o9KqktOtGs1lJavqzoqTh3GryD1c8/PezpvcpgtgT/iyYJheI5/N1LeJ8gQRBKzH
sR5KHRN/3qUJ+Vi84d/MoynJtHFeCCUFL+mM9ipJoh/TOUWU4lAHjVZnyl00BxyZ
bmIOIWNVRFHtC+wUHpn7h2HylE7iLhfy9Vkygh8pRnlRzkdl26sT7zikBLkbtnXx
ux+RZIthBEaHYqdr/cYiBpEmLl015czB7ab00TiWnznKDf3J9p9bVbV8caeKVTar
NPrZpO+HNBe9tRaLGhyS
=tQIa
-----END PGP SIGNATURE-----

--U/5EjKfnYgGK6hcj--
