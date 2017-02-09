Received: from eggs.gnu.org ([2001:4830:134:3::10]:46653)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cbepl-0007Vy-Ip
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 21:51:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cbepk-0006wt-Fd
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 21:51:45 -0500
Date: Thu, 9 Feb 2017 12:27:08 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170209012708.GN17644@umbus.fritz.box>
References: <1486377000-25701-1-git-send-email-nikunj@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="BtmVPk+Smchi6n7w"
Content-Disposition: inline
In-Reply-To: <1486377000-25701-1-git-send-email-nikunj@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 0/4] POWER9 TCG enablements - part14
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


--BtmVPk+Smchi6n7w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 06, 2017 at 03:59:56PM +0530, Nikunj A Dadhania wrote:
> This series contains 8 new instructions for POWER9 ISA3.0
>     VSX Scalar Maximum DP
>     VSX Scalar Minimum DP
>     Load/Store Atomic instructions
>=20
> Balamuruhan S (2):
>   target-ppc: implement load atomic instruction
>   target-ppc: implement store atomic instruction
>=20
> Bharata B Rao (2):
>   target-ppc: Add xsmaxcdp and xsmincdp instructions
>   target-ppc: Add xsmaxjdp and xsminjdp instructions
>=20
>  target/ppc/fpu_helper.c             | 93 +++++++++++++++++++++++++++++++=
++++
>  target/ppc/helper.h                 |  4 ++
>  target/ppc/internal.h               |  2 +
>  target/ppc/translate.c              | 98 +++++++++++++++++++++++++++++++=
++++++
>  target/ppc/translate/vsx-impl.inc.c |  4 ++
>  target/ppc/translate/vsx-ops.inc.c  |  4 ++
>  6 files changed, 205 insertions(+)

I've applied 3 & 4 to ppc-for-2.9.  1 & 2 I have a query about.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--BtmVPk+Smchi6n7w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYm8VsAAoJEGw4ysog2bOSihYP/2SSPmDE/OacIfUGyX7NASAG
tzWubN1VCosCSmHopXN+bMC24RYG4Rm03HzoSTkvG1wqY9/77XDTBSXRRulcgY+U
bGOn2GObfcXE50cV0Iav3OJRt45aLmwuVniP4zBPBZceBCOTAU0xZHYRrUvund7R
aSsq43Cjv705mLvA8drpuRyHalpBGsJSwPv9MOBIe2pWqAZYgZLhRgM9cczZ8vKr
FQvykmojqjC9bUD8TyDRZyr98MAn7cbxPB7tCaJh+2XNvuGvzbzt5KDPZmCBy5OX
NBRLFreBsDiRdPiSZ1xP7KTxvvOTH7jHyAF3K/vC4RD2xn3N6C49gzPmq5mlAFuG
2bfrJR3/PQ7SGJMn4QYyNGcAnyht+HtM5nRWMpqyhmrlGhR1ipHA+lPvuUC3IYyR
BStZlZFlRtV6XCn2/XhK/PWRiWnpbkxyGRIb2AgUrRe/IPHKY0k0ZAvU8GuoCFWD
BdVF2nMrLs8g5k9T6/O/UKRNcPzDLvTTh+bbQKLdHa79zifCIKZdDdgnPyXggWMl
z4P6556SOCaDmwbifU4ircwiR3bW4D3vsh5C2sqwTdBHIK0gKYNQ4V5pGTWlKafC
hH3x7F5iQXDT8094XjoKV4gkNZFfgHbkZ7Jq/4ZRabcX49h9eEMWqPYQNCQcMrOO
VHyFq8R8A8+/fBgGyi0M
=dVts
-----END PGP SIGNATURE-----

--BtmVPk+Smchi6n7w--
