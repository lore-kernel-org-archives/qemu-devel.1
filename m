Received: from eggs.gnu.org ([2001:4830:134:3::10]:53036)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fsR32-0001yI-Gm
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 07:11:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fsR2y-0002Z3-US
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 07:11:36 -0400
References: <20180817190457.8292-1-jsnow@redhat.com>
	<20180817190457.8292-3-jsnow@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <904aa956-ad1f-4606-f2d5-742501d42f21@redhat.com>
Date: Wed, 22 Aug 2018 13:11:08 +0200
MIME-Version: 1.0
In-Reply-To: <20180817190457.8292-3-jsnow@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="3xOOOiZYtiiQNYBD1SxvzWCMbI4nxbEKe"
Subject: Re: [Qemu-devel] [PATCH 2/7] jobs: canonize Error object
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: Jeff Cody <jcody@redhat.com>, kwolf@redhat.com, jtc@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--3xOOOiZYtiiQNYBD1SxvzWCMbI4nxbEKe
From: Max Reitz <mreitz@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: Jeff Cody <jcody@redhat.com>, kwolf@redhat.com, jtc@redhat.com
Message-ID: <904aa956-ad1f-4606-f2d5-742501d42f21@redhat.com>
Subject: Re: [PATCH 2/7] jobs: canonize Error object
References: <20180817190457.8292-1-jsnow@redhat.com>
 <20180817190457.8292-3-jsnow@redhat.com>
In-Reply-To: <20180817190457.8292-3-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-08-17 21:04, John Snow wrote:
> Jobs presently use both an Error object in the case of the create job,
> and char strings in the case of generic errors elsewhere.
>=20
> Unify the two paths as just j->err, and remove the extra argument from
> job_completed. The integer error code for job_completed is kept for now=

> for use by pre-emptive cancellation.
>=20
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  block/backup.c            |  2 +-
>  block/commit.c            |  2 +-
>  block/create.c            |  5 ++---
>  block/mirror.c            |  2 +-
>  block/stream.c            |  2 +-
>  include/qemu/job.h        | 10 ++++------
>  job-qmp.c                 |  5 +++--
>  job.c                     | 19 ++++++-------------
>  tests/test-bdrv-drain.c   |  2 +-
>  tests/test-blockjob-txn.c |  2 +-
>  tests/test-blockjob.c     |  2 +-
>  11 files changed, 22 insertions(+), 31 deletions(-)

(Accidentally deleted this part from my first reply)

> diff --git a/job.c b/job.c
> index 898260b2b3..c9de1af556 100644
> --- a/job.c
> +++ b/job.c

[...]

> @@ -535,7 +535,6 @@ void job_drain(Job *job)
>      }
>  }
> =20
> -
>  /**
>   * All jobs must allow a pause point before entering their job proper.=
 This
>   * ensures that jobs can be paused prior to being started, then resume=
d later.

If anything, you should remove one empty line after this function. ;-)

Max


--3xOOOiZYtiiQNYBD1SxvzWCMbI4nxbEKe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlt9RMwACgkQ9AfbAGHV
z0Ac3AgAmBsFRVhPETzx3yfp+lbiBYUpSk4y/WoXigIBGkFtl/u9tvrSzIOFI2fO
2K7Xv5btKZ5o86Igd3B6ljProAlMFzuaFbm/FyJ1TujrXqGVNgu910hw2ZWZ+5IH
M1Hvy69MM9skSmjsUSLY7DHxTVPvRncW0lPkQg3j1wkMglH5t80U/rqfUUM7Xdw4
NUsaHVSYK5BSwNX1iR1kxGPnQxi1ZLjyzbiMVtXyPC+pmBQejOF+x10a0KpWiKWM
z9Np7p+a7QGnrsKfMlmMNdmDon2WdgGxLCHufs/PvBPkgPX4crT3MIr//1UHXh4/
s9IW7uEfp1VukU+uYecwYdetuGNU5Q==
=pVvJ
-----END PGP SIGNATURE-----

--3xOOOiZYtiiQNYBD1SxvzWCMbI4nxbEKe--
