Received: from eggs.gnu.org ([2001:4830:134:3::10]:34373)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fIGnE-0001gl-1v
	for qemu-devel@nongnu.org; Mon, 14 May 2018 12:57:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fIGnD-0007Pk-BN
	for qemu-devel@nongnu.org; Mon, 14 May 2018 12:57:48 -0400
References: <20180509162637.15575-1-kwolf@redhat.com>
	<20180509162637.15575-20-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <317e9f17-0545-3dbf-b509-f48d681f540b@redhat.com>
Date: Mon, 14 May 2018 18:57:34 +0200
MIME-Version: 1.0
In-Reply-To: <20180509162637.15575-20-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Ptz1KxhYu7eUDioAIulrQdlgo566AlHTZ"
Subject: Re: [Qemu-devel] [PATCH 19/42] job: Add job_sleep_ns()
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
--Ptz1KxhYu7eUDioAIulrQdlgo566AlHTZ
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: eblake@redhat.com, jsnow@redhat.com, armbru@redhat.com, jcody@redhat.com,
 qemu-devel@nongnu.org
Message-ID: <317e9f17-0545-3dbf-b509-f48d681f540b@redhat.com>
Subject: Re: [PATCH 19/42] job: Add job_sleep_ns()
References: <20180509162637.15575-1-kwolf@redhat.com>
 <20180509162637.15575-20-kwolf@redhat.com>
In-Reply-To: <20180509162637.15575-20-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-05-09 18:26, Kevin Wolf wrote:
> There is nothing block layer specific about block_job_sleep_ns(), so
> move the function to Job.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  include/block/blockjob_int.h | 11 -----------
>  include/qemu/job.h           | 17 +++++++++++++++++
>  block/backup.c               |  2 +-
>  block/commit.c               |  2 +-
>  block/mirror.c               |  4 ++--
>  block/stream.c               |  2 +-
>  blockjob.c                   | 27 ---------------------------
>  job.c                        | 32 ++++++++++++++++++++++++++++++++
>  tests/test-bdrv-drain.c      |  8 ++++----
>  tests/test-blockjob-txn.c    |  2 +-
>  tests/test-blockjob.c        |  2 +-
>  11 files changed, 60 insertions(+), 49 deletions(-)

The Job.sleep_timer documentation should be adjusted.  With that done:

Reviewed-by: Max Reitz <mreitz@redhat.com>


--Ptz1KxhYu7eUDioAIulrQdlgo566AlHTZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlr5v/4ACgkQ9AfbAGHV
z0Bxvgf/dGSbCiTGvX2EDvFcLDtKZvyrG7LSuYazQQrCUwjhLxzENZUbN6cjJRSn
zO4eWMPErQeAD44AS0kJrZOPegGsHjuaJ4FoB/RjCHS7ZzI9hmVqdMEmbwH1amtO
3+VKodzFusYTmJNe3noYSSI5DRHA1SRdkcSJ2cr7yzBQ7lJFSbcKd62DZbuz0jXT
MEVfntCbWdIzApwRuPNJpartmFyU3AshhOh2q5y4Amu936EWoVgP5lKxtUTa3vRD
4/uJLgroQPlkR2b4E6SjES6kpRRfQeFPGqQnNSlXeIEM7JVy2Lc7xZLDq2dRAJYh
4WxcTGG/GPZ/hZAbrOIu5M5TxTupAQ==
=RtdD
-----END PGP SIGNATURE-----

--Ptz1KxhYu7eUDioAIulrQdlgo566AlHTZ--
