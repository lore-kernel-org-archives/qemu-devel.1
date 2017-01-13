Received: from eggs.gnu.org ([2001:4830:134:3::10]:50859)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cRs7e-0006cV-2d
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 22:01:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cRs7d-0004U6-33
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 22:01:46 -0500
Date: Fri, 13 Jan 2017 14:01:31 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170113030131.GM13656@umbus.fritz.box>
References: <1484238251-8096-1-git-send-email-nikunj@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="tDYGg60iReQ7u8wj"
Content-Disposition: inline
In-Reply-To: <1484238251-8096-1-git-send-email-nikunj@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 0/7] POWER9 TCG enablements - part12
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


--tDYGg60iReQ7u8wj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 12, 2017 at 09:54:04PM +0530, Nikunj A Dadhania wrote:
> This series contains 11 new instructions for POWER9 ISA3.0
>     VSX Scalar Test Data Class
>     VSX Vector Test Data Class
>     VSX Vector Convert HP/SP
>     VSX Scalar Multiply/Divide
>     VSX Scalar Convert Unsigned/Signed Doubleword
>=20
> Bharata B Rao (4):
>   target-ppc: Use ppc_vsr_t.f128 in xscmp[o,u,exp]qp
>   target-ppc: Add xscvsdqp and xscvudqp instructions
>   target-ppc: Add xsdivqp instruction
>   target-ppc: Add xsmulqp instruction
>=20
> Nikunj A Dadhania (3):
>   target-ppc: Add xvcv[hpsp, sphp] instructions
>   target-ppc: Add xvtstdc[sp,dp] instructions
>   target-ppc: Add xststdc[sp, dp, qp] instructions
>=20
>  target/ppc/fpu_helper.c             | 253 ++++++++++++++++++++++++++++++=
+++---
>  target/ppc/helper.h                 |  11 ++
>  target/ppc/internal.h               |   6 +-
>  target/ppc/translate/vsx-impl.inc.c |  11 ++
>  target/ppc/translate/vsx-ops.inc.c  |  18 +++
>  5 files changed, 276 insertions(+), 23 deletions(-)

I've merged 1..5.  6 & 7 I've left, pending a reply to rth's comment.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--tDYGg60iReQ7u8wj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYeEMIAAoJEGw4ysog2bOSPNEQAIrOz8g+Sjp7h87R1W/lVrmL
DxDWOiFnOiSyNlGMNVEZfWpPd06K47KARXfyAfhXVBCGcOAFiB+5UwnNwxwIoCob
6e7scETthGbkpoVCmroeD4+ccxUNyrpiUp42MrlO13XOEJ7IAesOoRiwBBlsIYpY
OY6KSUurNRuH2m1dgBGjLlirFPv732rMy5dFBokT0Lknsk5WjA1Dy7cQIB35D1bJ
/dtErBRuauj7eKpAXTiXZ4xoswLCzDS+5H8gP477t5G3jT6Fkz97e4H4CIOhLnqp
tRFcTpEFmaz9tD6QUiCrH7raxv9GxVN+YJ5yf17SHp8ImmNJccjC96lfKb5/WdtR
95A8kT7o2mUvgPyN4FDS18RKJuXTjjL7vTCu/dbH+V4bWdYKlqSHg9XRAnvj2SKA
/++ou0f1i6QezUSeaLvM/zW68XmbItbDRlm0aeYZ5beIavRuGikAnyWgFarnR3pS
xrRE0KpZI+GqBKJKmKY245dr2yhkEM6RMuPJeGB06TpZzf0Bzea53F4fHEQVv/PX
ZM4/nkJI9t7EDyURQDwjm+ISsIN83Z9i716ZvbaHUyRZbjUKb6Yv3AbbZnRLgDFW
gyMG2RY2hbHwF3l+VQR8pYiVG9J6VKseghLfJPvHloyV4+THfSHu7EjioXtlhEJf
PzTsycv4QhVL8cU7Bcsc
=TWEa
-----END PGP SIGNATURE-----

--tDYGg60iReQ7u8wj--
