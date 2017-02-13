Received: from eggs.gnu.org ([2001:4830:134:3::10]:33192)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cd6Js-0004QQ-TB
	for qemu-devel@nongnu.org; Sun, 12 Feb 2017 21:24:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cd6Jp-0007ux-PZ
	for qemu-devel@nongnu.org; Sun, 12 Feb 2017 21:24:48 -0500
Date: Mon, 13 Feb 2017 12:40:40 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170213014040.GK25381@umbus>
References: <1486711391-12247-1-git-send-email-bharata@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="mGCtrYeZ202LI9ZG"
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


--mGCtrYeZ202LI9ZG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 10, 2017 at 12:53:04PM +0530, Bharata B Rao wrote:
1;4601;0c> This series contains 2 new instructions (xscvqpudz, xscvqpuwz) a=
nd
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

I've applied 1-3 to ppc-for-2.9, still looking at the rest.

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

--mGCtrYeZ202LI9ZG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYoQ6WAAoJEGw4ysog2bOSP+4P/1/jKyo3c60dQ2gpFCBbZiJE
I8yvSktIthV9esj+F9d1bq3SJq3uuTYwUr5NCpRhaZL7Pds/jmjwJi5DO1EjSIdE
DluYWtKB8kt3egw69iIRoDVK/i3ku79ZSBM9GyO2rzuqcLwHq8RdMEBqevCKH0Gi
RTH3FCSv1/84jiUhVXrHZwaStWSCqyegyDXt4gP/hhkLoHb+ya5Cw9RezkdgxOwd
h7xJWdysTZ+ROVKMiO8awEla8/FvGsKQt0YXU7OcQb3Zx1Ov/ai5SFlObjUw/3hN
cELwxGEN2+2tXsSkPnYr61SmLkiAzkFFs6slSZky+dZH+rRfB+20FuvAPkCOHuTo
jvtaU+xrO3M+4vAiaybsD5cyrMrPkkx46g2BEfa+7bHCQoL1Jkh9+QgEfuV3rq2S
I01i4ZA2/XIWc1Xess35b7rtCl3qEZ0wQ0NLfx4DBiY0N/+Sgw5mLlFbcD0ezFnM
aGC4v8x7Um0HBbjxnez4fNDsqqHWLGxrFeCmPWX43gTSQ+q6hkeoA0N0SeYtVOyj
56EAlIr4DY0ErjQmxU6dzfg4XQiwdGHq4kfb77ZdaAWNB/r3092Fstqb0zGe7j04
HJxGIWV6BqhBSpKWFT123rdS18DdSPWfID0+5mZHRp6gcp/1hA+nIVo4OT8Wq1UZ
+LI0Cdur7c92pjGhXDvN
=LhRc
-----END PGP SIGNATURE-----

--mGCtrYeZ202LI9ZG--
