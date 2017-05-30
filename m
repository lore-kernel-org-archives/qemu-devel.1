Received: from eggs.gnu.org ([2001:4830:134:3::10]:39739)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dFdPC-0007pI-J5
	for qemu-devel@nongnu.org; Tue, 30 May 2017 05:25:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dFdPB-0004fW-FP
	for qemu-devel@nongnu.org; Tue, 30 May 2017 05:25:34 -0400
Date: Tue, 30 May 2017 10:25:24 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170530092524.GH11362@stefanha-x1.localdomain>
References: <20170526192404.32186-1-jcody@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MGu/vTNewDGZ7tmp"
Content-Disposition: inline
In-Reply-To: <20170526192404.32186-1-jcody@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PULL 00/12] Block patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>
Cc: qemu-block@nongnu.org, peter.maydell@linaro.org, qemu-devel@nongnu.org, stefanha@redhat.com


--MGu/vTNewDGZ7tmp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 26, 2017 at 03:23:52PM -0400, Jeff Cody wrote:
> The following changes since commit 9964e96dc9999cf7f7c936ee854a795415d19b=
60:
>=20
>   Merge remote-tracking branch 'jasowang/tags/net-pull-request' into stag=
ing (2017-05-23 15:01:31 +0100)
>=20
> are available in the git repository at:
>=20
>   git://github.com/codyprime/qemu-kvm-jtc.git tags/block-pull-request
>=20
> for you to fetch changes up to 223a23c198787328ae75bc65d84edf5fde33c0b6:
>=20
>   block/gluster: glfs_lseek() workaround (2017-05-24 16:44:46 -0400)
>=20
> ----------------------------------------------------------------
> Block patches
> ----------------------------------------------------------------
>=20
> Jeff Cody (1):
>   block/gluster: glfs_lseek() workaround
>=20
> Paolo Bonzini (11):
>   blockjob: remove unnecessary check
>   blockjob: remove iostatus_reset callback
>   blockjob: introduce block_job_early_fail
>   blockjob: introduce block_job_pause/resume_all
>   blockjob: separate monitor and blockjob APIs
>   blockjob: move iostatus reset inside block_job_user_resume
>   blockjob: introduce block_job_cancel_async, check iostatus invariants
>   blockjob: group BlockJob transaction functions together
>   blockjob: strengthen a bit test-blockjob-txn
>   blockjob: reorganize block_job_completed_txn_abort
>   blockjob: use deferred_to_main_loop to indicate the coroutine has
>     ended
>=20
>  block/backup.c               |   2 +-
>  block/commit.c               |   2 +-
>  block/gluster.c              |  18 +-
>  block/io.c                   |  19 +-
>  block/mirror.c               |   2 +-
>  blockdev.c                   |   1 -
>  blockjob.c                   | 750 ++++++++++++++++++++++++-------------=
------
>  include/block/blockjob.h     |  16 -
>  include/block/blockjob_int.h |  27 +-
>  tests/test-blockjob-txn.c    |   7 +-
>  tests/test-blockjob.c        |  10 +-
>  11 files changed, 463 insertions(+), 391 deletions(-)
>=20
> --=20
> 2.9.3
>=20
>=20

Thanks, applied to my staging tree:
https://github.com/stefanha/qemu/commits/staging

Stefan

--MGu/vTNewDGZ7tmp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZLTqEAAoJEJykq7OBq3PIruYH/R9LuOHZpw6TC1y+u7H1cvGp
yzhpa/zmLHqZTwPcWYVcxX/138Aju05nfVHDrgzXPuZeulDrqDnlEPHHVg2eDEBQ
D6FrJdKF1ZpD6sGl6KvmEmAbyHsW/v9VpL7bbptlHQz2RPUizaGsVfPvHmo4sRau
6gM1nGCuLIoi99DofM5myh7G5h7e77InyR1JpbjDJmanITgv+le2IDDSlfbQ1FI9
bhcgXcIRnmoMtNYVwCiuqRuPcrqeGaHe0SLsQz5xrr2HE3A3IHinpSNFfEYTDdPL
7kLqa1SWbY64r+TaA6N9jWj6Ro1A6X4ns2saSa7gGRt7qIlMsmpjkclIM3O1LTc=
=jfz5
-----END PGP SIGNATURE-----

--MGu/vTNewDGZ7tmp--
