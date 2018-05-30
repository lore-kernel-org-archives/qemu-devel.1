Received: from eggs.gnu.org ([2001:4830:134:3::10]:41456)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fNxir-00041D-P8
	for qemu-devel@nongnu.org; Wed, 30 May 2018 05:48:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fNxiq-0008FT-VS
	for qemu-devel@nongnu.org; Wed, 30 May 2018 05:48:49 -0400
References: <20180529203910.7615-1-kwolf@redhat.com>
	<20180529203910.7615-4-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <73859dcf-4a4e-894a-c261-68564fb3a26f@redhat.com>
Date: Wed, 30 May 2018 11:48:34 +0200
MIME-Version: 1.0
In-Reply-To: <20180529203910.7615-4-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="1nAwXmWHaL5ayb8TTlCNEnHiyCo8e5zi7"
Subject: Re: [Qemu-devel] [PATCH v2 03/16] job: Add error message for
 failing jobs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jcody@redhat.com, jsnow@redhat.com, eblake@redhat.com, pkrempa@redhat.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--1nAwXmWHaL5ayb8TTlCNEnHiyCo8e5zi7
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jcody@redhat.com, jsnow@redhat.com, eblake@redhat.com,
 pkrempa@redhat.com, qemu-devel@nongnu.org
Message-ID: <73859dcf-4a4e-894a-c261-68564fb3a26f@redhat.com>
Subject: Re: [PATCH v2 03/16] job: Add error message for failing jobs
References: <20180529203910.7615-1-kwolf@redhat.com>
 <20180529203910.7615-4-kwolf@redhat.com>
In-Reply-To: <20180529203910.7615-4-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-05-29 22:38, Kevin Wolf wrote:
> So far we relied on job->ret and strerror() to produce an error message=

> for failed jobs. Not surprisingly, this tends to result in completely
> useless messages.
>=20
> This adds a Job.error field that can contain an error string for a
> failing job, and a parameter to job_completed() that sets the field. As=

> a default, if NULL is passed, we continue to use strerror(job->ret).
>=20
> All existing callers are changed to pass NULL. They can be improved in
> separate patches.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  include/qemu/job.h        |  7 ++++++-
>  block/backup.c            |  2 +-
>  block/commit.c            |  2 +-
>  block/mirror.c            |  2 +-
>  block/stream.c            |  2 +-
>  job-qmp.c                 |  9 ++-------
>  job.c                     | 16 ++++++++++++++--
>  tests/test-bdrv-drain.c   |  2 +-
>  tests/test-blockjob-txn.c |  2 +-
>  tests/test-blockjob.c     |  2 +-
>  10 files changed, 29 insertions(+), 17 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--1nAwXmWHaL5ayb8TTlCNEnHiyCo8e5zi7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlsOc3IACgkQ9AfbAGHV
z0CmhAf/eADp/k32oxXnqsQM7SzL04eJgDMXxTfLo1xK2X/sfSmIgBlv5Xz6GHSq
iygu5gNB3h/sBhR7SVarGQUwjmW5FcU0kywdZeFLdjFqGFVbTVlnntHfaOD7lKHb
V4RA6SkSnDr+kVZhPpKW3L0PPvh2+OIEdQx36i21mIbF0lW+hO3m9lRXvoc3dtP1
Tp9E0UJ8+E11Rskg22AZ7/51VmsLab8XfqBiUb/FrE0mTQP2lVJy2rWyVctqWJjI
DAY8V9i8Tz/i3be2+wGHq/Ghmg4YLexy3jXZVVMZnFjUP47DT3m21Vndkprz81uw
Fw1mEZbXqOgTCkHZwhx/qrSzKCX3/Q==
=gwc4
-----END PGP SIGNATURE-----

--1nAwXmWHaL5ayb8TTlCNEnHiyCo8e5zi7--
