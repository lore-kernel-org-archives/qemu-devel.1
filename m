Received: from eggs.gnu.org ([2001:4830:134:3::10]:39401)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fIH2J-0007fR-V5
	for qemu-devel@nongnu.org; Mon, 14 May 2018 13:13:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fIH2J-0002F7-1G
	for qemu-devel@nongnu.org; Mon, 14 May 2018 13:13:23 -0400
References: <20180509162637.15575-1-kwolf@redhat.com>
	<20180509162637.15575-21-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <ffdba23a-15ec-5af1-766f-8222e376b5b9@redhat.com>
Date: Mon, 14 May 2018 19:13:14 +0200
MIME-Version: 1.0
In-Reply-To: <20180509162637.15575-21-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="wJf2VF0LnGinzrWkRovzir6kJnYFEa77j"
Subject: Re: [Qemu-devel] [PATCH 20/42] job: Move pause/resume functions to
 Job
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
--wJf2VF0LnGinzrWkRovzir6kJnYFEa77j
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: eblake@redhat.com, jsnow@redhat.com, armbru@redhat.com, jcody@redhat.com,
 qemu-devel@nongnu.org
Message-ID: <ffdba23a-15ec-5af1-766f-8222e376b5b9@redhat.com>
Subject: Re: [PATCH 20/42] job: Move pause/resume functions to Job
References: <20180509162637.15575-1-kwolf@redhat.com>
 <20180509162637.15575-21-kwolf@redhat.com>
In-Reply-To: <20180509162637.15575-21-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-05-09 18:26, Kevin Wolf wrote:
> While we already moved the state related to job pausing to Job, the
> functions to do were still BlockJob only. This commit moves them over t=
o
> Job.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  include/block/blockjob.h     | 32 -------------------
>  include/block/blockjob_int.h |  7 +++++
>  include/qemu/job.h           | 37 ++++++++++++++++++++++
>  block/backup.c               |  1 +
>  block/commit.c               |  1 +
>  block/mirror.c               |  2 ++
>  block/stream.c               |  1 +
>  blockdev.c                   |  6 ++--
>  blockjob.c                   | 73 ++++++++++--------------------------=
--------
>  job.c                        | 51 +++++++++++++++++++++++++++++++
>  tests/test-bdrv-drain.c      |  1 +
>  tests/test-blockjob-txn.c    |  1 +
>  tests/test-blockjob.c        |  6 ++--
>  13 files changed, 125 insertions(+), 94 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--wJf2VF0LnGinzrWkRovzir6kJnYFEa77j
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlr5w6oACgkQ9AfbAGHV
z0BQ1Qf+OP7C2bp5unTdjFFCT7Yb1fWPMArfRV0M/QbQdimOX/drDokAShZBvSg+
d7o5S+zcQVQlEIdUo9e6bSehAD0kNiIqUtkZhdgUVUb6c90N4SvgklaEfMyGPn4L
cswAGAGhSVY7h4mYtSdO8mYStKz0vRv7Q6NuZn+i3XhLT5nuihWIbs2Lh2k5xN5v
uJmqScGrhpKgStILWib4hf4knyweMExOlZtmQzGPxa0ERaLTr+if41v4vLSun3le
DkyTUHjpCBjkrQruubjmOZDYQb0U7/Ri8apJuK0AabXrabONpz7ZK5XlLKpu+2QI
IMihi/mCnu9/FLVlXcjL8cX0zfoyyA==
=m/bf
-----END PGP SIGNATURE-----

--wJf2VF0LnGinzrWkRovzir6kJnYFEa77j--
