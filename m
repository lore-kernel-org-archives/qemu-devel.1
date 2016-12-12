Received: from eggs.gnu.org ([2001:4830:134:3::10]:36368)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cGEZ8-0004Wp-Il
	for qemu-devel@nongnu.org; Sun, 11 Dec 2016 19:34:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cGEZ4-0005Ov-Dm
	for qemu-devel@nongnu.org; Sun, 11 Dec 2016 19:34:02 -0500
Date: Mon, 12 Dec 2016 11:32:21 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20161212003221.GD12127@umbus.fritz.box>
References: <1481285845-16415-1-git-send-email-nikunj@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qGV0fN9tzfkG3CxV"
Content-Disposition: inline
In-Reply-To: <1481285845-16415-1-git-send-email-nikunj@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v2 ppc-for-2.9 0/6] POWER9 TCG enablements
 - part9
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


--qGV0fN9tzfkG3CxV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 09, 2016 at 05:47:19PM +0530, Nikunj A Dadhania wrote:
> This series contains 6 new instructions for POWER9 ISA3.0
>      VSX Vector Insert/Extract Word
>      VSX Load/Store with length
>=20
> Although, lxvl/lxvll and stxvl/stxvll can be combined as single patch,
> have left it for detailed commit log for instruction explanation.

I've applied patches 1-4 to ppc-for-2.9.  5 & 6 I still have some
questions about.
>=20
> Changelog:
> v1:
> * Combine helpers of lxvl and lxvll
> * Combine helpers of stxvl and stxvll
> * Rework xxextractuw and xxinsertw to simplify helper
>=20
> v0:
> * Fixed lxvl/lxvll and stxvl/stxvll as suggested by Richard
> * Dropped mask_u128, which is not needed anymore
> * Prevent UIMM > 12 in xxextractuw
> * Drop xori from xsnegqp
> * Rewrite xxperm/xxpermr without double copy
>=20
> Nikunj A Dadhania (6):
>   target-ppc: implement lxvl instruction
>   target-ppc: implement lxvll instruction
>   target-ppc: implement stxvl instruction
>   target-ppc: implement stxvll instructions
>   target-ppc: implement xxextractuw instruction
>   target-ppc: implement xxinsertw instruction
>=20
>  target-ppc/helper.h                 |  8 +++++
>  target-ppc/int_helper.c             | 42 +++++++++++++++++++++++
>  target-ppc/mem_helper.c             | 66 +++++++++++++++++++++++++++++++=
++++++
>  target-ppc/translate/vsx-impl.inc.c | 60 +++++++++++++++++++++++++++++++=
++
>  target-ppc/translate/vsx-ops.inc.c  | 14 ++++++++
>  5 files changed, 190 insertions(+)
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--qGV0fN9tzfkG3CxV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYTfAUAAoJEGw4ysog2bOSVDMP/jPpl08RN/L7CGTwUmR0qqbF
ONgbjeNUSfYJB5cPM43IdLmrXrNPbFvi2Kj/2yYm4D9PP7zPfxcgLw5+Ag3Jlo8i
Hbq0XOOuiDq4mnQdjto++Id8x93/oJJWA3l/EqlOJPydjxgdFLS2CZkNRBG4Wj6/
tOPkYP1UJ3gGVe0PqcpoZZENEclVndSM4HafZZ4Kk/lgE+uBJFP24FP9tSu+KbPV
N3NFva3ucE06AzMIFN+lf3+bse/ADfzsv8p8iVE+uDPsLfJOcFbya2eZ35BUMwKT
nLqO2A0fYJodhf4pGiQ97rUSUvMheH1gg0BcsfBEPpfbA93ywIIbgPwEOeaZW5P9
4gRiq+44S5Jp5/9o7s0kMmhUbFS0F9Hl6rs6gpQ2PzxwkAbCErOq3yC72V93mwjl
yw2khdw7qsicnNHWavvnmbQ8y1Tuto+d86gSpUjBmSnaWHsIhg5CISZMN4wZPjdb
fiJQpPJMf61v+bVd4lPNJ/wHkmzG5CV6BjGw4JV2k3dDZbGIQR25QbHGD59hqSoB
ik+A701leSCPwfDZQHOt0jGNsRplpeEHXLq1DtnQ3m2dX4v4MFhCJDKBRxuMol1Q
pbV3bldCNI1dQkUSnRdJM2diOxv9wdMJrnLDK+833ErJQ3UbDaYWkOn2eE1f3cSa
yTwT+XxtVQs7DehYrrZ7
=fIvX
-----END PGP SIGNATURE-----

--qGV0fN9tzfkG3CxV--
