Received: from eggs.gnu.org ([2001:4830:134:3::10]:33194)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cd6Js-0004QS-TL
	for qemu-devel@nongnu.org; Sun, 12 Feb 2017 21:24:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cd6Jp-0007v1-PI
	for qemu-devel@nongnu.org; Sun, 12 Feb 2017 21:24:48 -0500
Date: Mon, 13 Feb 2017 12:43:43 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170213014343.GL25381@umbus>
References: <1486711391-12247-1-git-send-email-bharata@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="TnYVF1hk1c8rpHiF"
Content-Disposition: inline
In-Reply-To: <1486711391-12247-1-git-send-email-bharata@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 0/7] POWER9 TCG and softfloat enablements -
 part16 + s390 float fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bharata B Rao <bharata@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, rth@twiddle.net, nikunj@linux.vnet.ibm.com


--TnYVF1hk1c8rpHiF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 10, 2017 at 12:53:04PM +0530, Bharata B Rao wrote:
> This series contains 2 new instructions (xscvqpudz, xscvqpuwz) and
> round-to-odd variants of 6 instructions (xsaddqpo, xsmulqpo, xsdivqpo,
> xscvqpdpo, xssqrtqpo, xssubqpo)
> =20
> This also includes softfloat enhancements that are needed by
> the above instructions. These softfloat patches have been posted
> separately earlier and reviewed. Including them here as the new
> instructions here depend on them.
>=20
> I also saw that target-s390 also needs float128_to_uint64() and
> float128_to_uint32(). Implemented the latter in this series and
> made fixes in s390 code to use them. Note that s390 changes have
> been compile-tested only. The last two patches ideally needn't
> be part of this series, but included them here as s390 fixes
> depend on the softfloat changes that are part of this patchset.

4 & 5 also applied to my tree.  6 & 7 I'll leave to go through the
s390 tree.

>=20
> Bharata B Rao (7):
>   softfloat: Add round-to-odd rounding mode
>   softfloat: Add float128_to_uint64_round_to_zero()
>   softfloat: Add float128_to_uint32_round_to_zero()
>   target-ppc: Implement round to odd variants of quad FP instructions
>   target-ppc: Add xscvqpudz and xscvqpuwz instructions
>   softfloat: Add float128_to_uint32()
>   target-s390: Use float128_to_uint[64/32] where required
>=20
>  fpu/softfloat.c                     | 125 ++++++++++++++++++++++++++++++=
+++++-
>  include/fpu/softfloat.h             |   6 ++
>  target/ppc/fpu_helper.c             |  44 ++++++-------
>  target/ppc/helper.h                 |   2 +
>  target/ppc/translate/vsx-impl.inc.c |   2 +
>  target/ppc/translate/vsx-ops.inc.c  |   4 +-
>  target/s390x/fpu_helper.c           |   6 +-
>  7 files changed, 161 insertions(+), 28 deletions(-)
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--TnYVF1hk1c8rpHiF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYoQ9PAAoJEGw4ysog2bOSfh0QAKalkytjJ8yf1FIE2i3p5CqL
GUTFjPY5ge9/aBK4S6Wf+XMj2CGyD4FbOyenNCNmArIe4MDnuncNXt/27k0SZQM1
WrQPwChEEcTfqKKSfxKXt3wEt2C12pIbVrQQ22zffPSx8t8R8s64yE1KhXMuPWnF
d/BtTDHqnX6n5Ij3ODijys6ZAqpkEsv4Kbxffsf1CGECn3RiP2U/19Br7qtn0MdD
PN1eZHmYHEnRwCRA3RU9+8uRkkww63n2jAecwSmdohm3Nwo/jWzAkrFHxnh5X//P
4bZDHMmxAstQ2e/pwOrtGK4KP1xld4EDxLvivCKSJuFbb37UKZAN9069TU8fnhje
KGyXUdC3uUYy05b0Wg0hDuxiBLiShEqZVnQbdbVo9HZd214edH9E3n6+QYSzyr8P
AB9/AmSvbJ0qzDv+eOgxkQ88XLsYCRI2Dk06MpMsGeMsQUvILJxvsK+cK9E6ZYVb
7ObovcT0rpEaDpVb3im+BPb0gppo3PmcyLHB6zRn5tSTxyPH7C8QbwvQMyYsckWF
slFDtphHSR4rkJWgqa8X7TgN1hU6QbtfjGT9+3o1y2xEDQov7pA/NQUvZUlxnTEb
Wk3XMOFjDZXtI+IIbuM+monE3G6bdFino4AxzJVUcqlFF69C2rmMOX0edFRb8Fy+
RUGVi5jnC6h0yIhzH5Xq
=uYdA
-----END PGP SIGNATURE-----

--TnYVF1hk1c8rpHiF--
