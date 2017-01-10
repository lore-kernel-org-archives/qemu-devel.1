Received: from eggs.gnu.org ([2001:4830:134:3::10]:40353)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cQmyK-0002Sx-Ez
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 22:19:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cQmyE-0004Ni-UN
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 22:19:40 -0500
Date: Tue, 10 Jan 2017 11:26:37 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170110002637.GI12515@umbus.fritz.box>
References: <1483971975-5612-1-git-send-email-nikunj@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="JIpyCmsTxyPLrmrM"
Content-Disposition: inline
In-Reply-To: <1483971975-5612-1-git-send-email-nikunj@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v2 0/3] POWER9 TCG enablements - part10
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, bharata@linux.vnet.ibm.com


--JIpyCmsTxyPLrmrM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 09, 2017 at 07:56:12PM +0530, Nikunj A Dadhania wrote:
> This series contains 11 new instructions for POWER9 ISA3.0
>      VSX Scalar Convert
>      VSX Scalar Add QP
>=20
> Changelog:
> v1:=20
> * xsaddqp, xscv[dpqp, qpdp] instructions use register numbering 0-31, thi=
s needs
>   to be handled in the decoding. ISA 3.0 documents to use them as VSR[VRA=
 + 32],=20
>   and likewise for other registers.=20
>=20
> v0:
>    Rebase and update reviewed-by

Applied to ppc-for-2.9, replacing the earlier versions.

>=20
>=20
> Bharata B Rao (3):
>   target-ppc: Add xsaddqp instructions
>   target-ppc: Add xscvdpqp instruction
>   target-ppc: Add xscvqpdp instruction
>=20
>  target/ppc/fpu_helper.c             | 109 ++++++++++++++++++++++++++++++=
++++++
>  target/ppc/helper.h                 |   3 +
>  target/ppc/internal.h               |   1 +
>  target/ppc/translate/vsx-impl.inc.c |   3 +
>  target/ppc/translate/vsx-ops.inc.c  |   3 +
>  5 files changed, 119 insertions(+)
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--JIpyCmsTxyPLrmrM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYdCo7AAoJEGw4ysog2bOSjtkQAK65/32u67fUIqdsQlSAlCyM
6dFRzoMWuUosNTOxXMCI9ELRdNNo4OTaFMnvQtuxRQwcuV5eX7w4ci0nzKmgDwuH
daRnWvCZ+8VYX9xadUjk8hAZIYCjseyEj7w1F4EDGOHgzjdw+1mYF78jk9Zwv/B1
OUjFY8j3sayXvinLB7PRdX8aQylF5w8/BSeR9ca7skUWYvDZhTs7vK4BqHZy3RdW
ruJHN8yuBkj1VMBs7Fln6Bjcdam82ybgL8JI0xO/INASdM0o526Y8RonOnlDFS4c
7PGlbisMW8uRxXoBrhAdPW2hh0KapMInMUL5jZVHIWTYDjb7xDy9l2dgfg3C7s60
0pSnfs86AhVRE0YnrCWNpuP5XtFeycly7bQWPyx5yzvhXE4VCQ0/HQikme4LqjVJ
MxSS49REN/59C4ROaEB5aPrVgkEkzh8C76IxZxhrSbK2K8F6GZkrfJEL6DqxUrPo
0qwiVHnFa0uWf8lS9Fgv1B+H9hQRiMCImnzg53jH88SXULekG0qTJTysEu10kVZ/
REr6QBLLdEjJ+NS3n8SgcghwXyNmA3+bhAWuS5v+PwCgqQgVuVeESr4t6dcnwYLJ
7k54AHe9FGt+6XGmQH3wfoS6k678vPPgUD5erUY0KW9ng5ZTikxmrHA7ScB15S8G
7ZqKG/qOiQPhi9jyrFcZ
=/TvW
-----END PGP SIGNATURE-----

--JIpyCmsTxyPLrmrM--
