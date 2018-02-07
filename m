Received: from eggs.gnu.org ([2001:4830:134:3::10]:35954)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ejYVE-0002AQ-Vo
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 17:47:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ejYVE-0008B3-5O
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 17:47:45 -0500
References: <20180119205847.7141-1-jsnow@redhat.com>
	<20180119205847.7141-13-jsnow@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <30a7a9d8-10cc-d229-04b8-4e7d263d13d4@redhat.com>
Date: Wed, 7 Feb 2018 23:47:35 +0100
MIME-Version: 1.0
In-Reply-To: <20180119205847.7141-13-jsnow@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="z14ZhJooXh7oadNIurT84rBkX6x3ErYHp"
Subject: Re: [Qemu-devel] [PATCH v2 12/13] blockjob: privatize
 block_job_sleep_ns
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org
Cc: kwolf@redhat.com, jcody@redhat.com, qemu-devel@nongnu.org, stefanha@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--z14ZhJooXh7oadNIurT84rBkX6x3ErYHp
From: Max Reitz <mreitz@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org
Cc: kwolf@redhat.com, jcody@redhat.com, qemu-devel@nongnu.org,
 stefanha@redhat.com
Message-ID: <30a7a9d8-10cc-d229-04b8-4e7d263d13d4@redhat.com>
Subject: Re: [PATCH v2 12/13] blockjob: privatize block_job_sleep_ns
References: <20180119205847.7141-1-jsnow@redhat.com>
 <20180119205847.7141-13-jsnow@redhat.com>
In-Reply-To: <20180119205847.7141-13-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-01-19 21:58, John Snow wrote:
> There's not currently any external caller of it.
>=20
> Except in tests, but we'll fix that here too.
>=20
> Replace usages in test cases with block_job_relax, which functions
> similarly enough to be used as a drop-in replacement.
>=20
> Very technically block_job_sleep_ns(job, 0) behaves differently
> from block_job_relax(job, 0) in that relax may resolve to a no-op,
> but this makes no difference in the test in which it is used.
>=20
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  blockjob.c                   | 11 ++++++++++-
>  include/block/blockjob_int.h | 11 -----------
>  tests/test-bdrv-drain.c      |  2 +-
>  tests/test-blockjob-txn.c    |  2 +-
>  4 files changed, 12 insertions(+), 14 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--z14ZhJooXh7oadNIurT84rBkX6x3ErYHp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlp7ggcSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9Ar6gH/RNR8kJ0E0ZgDXnoi3Mi8suqDpIn+sdV
ZVqC866w+B5rUHO/ORYMe1BXksZBAeudyv02I5Dcl2mmbbx21Gq89mOIrsmYJXMq
rauhLtDeFnFlFTUOqg93Hc8ekYnpxA9rhDc/2xgdI9Oz28Glv7cghm10kIV+/qs+
yDs9GfUDSm63zLsJFZTYFTXQYKKjXBtDy/wOQLCkabUSlFq1xUi9PWwAvnhM6Wdd
tnSHoFIVU+7vY7RouqVyYjxrmHkBH3R0fQSO6xkNefgCu6PhD9AsHqoms/YuicAm
fTwZQjdv69LJcq7PBpxbJPGuRLD8A7Cgs/kgQCS+CiAHwPwB00l7BBQ=
=xMXx
-----END PGP SIGNATURE-----

--z14ZhJooXh7oadNIurT84rBkX6x3ErYHp--
