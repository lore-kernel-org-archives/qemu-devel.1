Received: from eggs.gnu.org ([2001:4830:134:3::10]:47466)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fIHcd-0004nP-2C
	for qemu-devel@nongnu.org; Mon, 14 May 2018 13:50:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fIHcc-0004EW-A7
	for qemu-devel@nongnu.org; Mon, 14 May 2018 13:50:55 -0400
References: <20180509162637.15575-1-kwolf@redhat.com>
	<20180509162637.15575-23-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <ab070586-9a50-443e-da62-579a5343d507@redhat.com>
Date: Mon, 14 May 2018 19:50:44 +0200
MIME-Version: 1.0
In-Reply-To: <20180509162637.15575-23-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="cQeLYVQIaVMZzNBIqu4Vx9ONLK0GWMlld"
Subject: Re: [Qemu-devel] [PATCH 22/42] job: Move BlockJobCreateFlags to Job
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: eblake@redhat.com, jsnow@redhat.com, armbru@redhat.com, jcody@redhat.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--cQeLYVQIaVMZzNBIqu4Vx9ONLK0GWMlld
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: eblake@redhat.com, jsnow@redhat.com, armbru@redhat.com, jcody@redhat.com,
 qemu-devel@nongnu.org
Message-ID: <ab070586-9a50-443e-da62-579a5343d507@redhat.com>
Subject: Re: [PATCH 22/42] job: Move BlockJobCreateFlags to Job
References: <20180509162637.15575-1-kwolf@redhat.com>
 <20180509162637.15575-23-kwolf@redhat.com>
In-Reply-To: <20180509162637.15575-23-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-05-09 18:26, Kevin Wolf wrote:
> This renames the BlockJobCreateFlags constants, moves a few JOB_INTERNA=
L
> checks to job_create() and the auto_{finalize,dismiss} fields from
> BlockJob to Job.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  include/block/blockjob.h     | 17 -----------------
>  include/block/blockjob_int.h |  3 +--
>  include/qemu/job.h           | 20 +++++++++++++++++++-
>  block/commit.c               |  2 +-
>  block/mirror.c               |  2 +-
>  block/replication.c          |  4 ++--
>  block/stream.c               |  2 +-
>  blockdev.c                   | 14 +++++++-------
>  blockjob.c                   | 27 +++++++--------------------
>  job.c                        | 11 ++++++++++-
>  qemu-img.c                   |  2 +-
>  tests/test-blockjob-txn.c    |  2 +-
>  tests/test-blockjob.c        |  4 ++--
>  13 files changed, 53 insertions(+), 57 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--cQeLYVQIaVMZzNBIqu4Vx9ONLK0GWMlld
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlr5zHQACgkQ9AfbAGHV
z0DMtwf/RvmcCaD5pvo+0bu2Wk1vY1mHn8s0sBOnrMGgJgiRLSp5cOg6KanHWcta
Zj/bGzYaHX2U7yN7dlXC1qJ6Ts/3+RyOdbC1gEvp+pBgmOvn4s8LfJ6HRhY7lLbe
9yyLm2OjcHd9pdDYrSUPpIzPmgnWRaDYHFAntZEBKnIoiSoR2Yk4oJmnknn9Issu
SCol3nZpxV7YEZLXvxkecRrUXT2W4fSLQPvGZqJXj4VlTyQJ4uwKC36iGrMO0kdH
B1MGYM/DqTJCqxtnV8ISnxduD5louw4zyDkW+jCkrHdWNd5EvH/jxE35l0L0GGHB
U4XQgoahZp7snuG/cB8gjZhH3OP8wQ==
=kL5H
-----END PGP SIGNATURE-----

--cQeLYVQIaVMZzNBIqu4Vx9ONLK0GWMlld--
