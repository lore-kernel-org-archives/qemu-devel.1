Received: from eggs.gnu.org ([2001:4830:134:3::10]:35214)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d6G9E-0004Jo-Hy
	for qemu-devel@nongnu.org; Thu, 04 May 2017 08:46:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d6G9D-0002bg-07
	for qemu-devel@nongnu.org; Thu, 04 May 2017 08:46:20 -0400
Date: Thu, 4 May 2017 13:46:10 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170504124610.GA729@stefanha-x1.localdomain>
References: <1493411622-5343-1-git-send-email-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LZvS9be/3tNcYl/X"
Content-Disposition: inline
In-Reply-To: <1493411622-5343-1-git-send-email-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PULL 00/34] Block layer patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org


--LZvS9be/3tNcYl/X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 28, 2017 at 10:33:08PM +0200, Kevin Wolf wrote:
> The following changes since commit 81b2d5ceb0cfb4cdc2163492e3169ed714b0cd=
a9:
>=20
>   Merge remote-tracking branch 'remotes/rth/tags/pull-tcg-20170426' into =
staging (2017-04-26 20:50:49 +0100)
>=20
> are available in the git repository at:
>=20
>=20
>   git://repo.or.cz/qemu/kevin.git tags/for-upstream
>=20
> for you to fetch changes up to 5fc0fe383fff318b38291dcdf2cf38e329ec232a:
>=20
>   Merge remote-tracking branch 'mreitz/tags/pull-block-2017-04-28' into q=
ueue-block (2017-04-28 20:52:17 +0200)
>=20
> ----------------------------------------------------------------
>=20
> Block layer patches
>=20
> ----------------------------------------------------------------
> Denis V. Lunev (2):
>       block: fix alignment calculations in bdrv_co_do_zero_pwritev
>       block: assert no image modification under BDRV_O_INACTIVE
>=20
> Eric Blake (2):
>       iotests: Fix typo in 026
>       qcow2: Allow discard of final unaligned cluster
>=20
> Fam Zheng (2):
>       block: Remove NULL check in bdrv_co_flush
>       iotests: 109: Filter out "len" of failed jobs
>=20
> John Snow (2):
>       iotests: clarify help text
>       iotests: fix exclusion option
>=20
> Kevin Wolf (8):
>       file-posix: Remove unnecessary includes
>       file-win32: Remove unnecessary include
>       migration: Call blk_resume_after_migration() for postcopy
>       qemu-iotests: Filter HMP readline escape characters
>       qemu-iotests: Test postcopy migration
>       qemu-iotests: Remove PERL_PROG and BC_PROG
>       qemu_iotests: Remove _readlink()
>       Merge remote-tracking branch 'mreitz/tags/pull-block-2017-04-28' in=
to queue-block
>=20
> Klim Kireev (1):
>       block: fix obvious coding style mistakes in block_int.h
>=20
> Krzysztof Kozlowski (1):
>       block: Constify data passed by pointer to blk_name
>=20
> Lidong Chen (1):
>       qemu-img: use blk_co_pwrite_zeroes for zero sectors when compressed
>=20
> Max Reitz (13):
>       Revert "block/io: Comment out permission assertions"
>       block: An empty filename counts as no filename
>       iotests/051: Add test for empty filename
>       iotests: Launch qemu-nbd with -e 42
>       block: Do not unref bs->file on error in BD's open
>       qemu-img/convert: Use @opts for one thing only
>       qemu-img/convert: Move bs_n > 1 && -B check down
>       qemu-img: Document backing options
>       block/vhdx: Make vhdx_create() always set errp
>       block: Add errp to b{lk,drv}_truncate()
>       block: Add errp to BD.bdrv_truncate()
>       block: Add .bdrv_truncate() error messages
>       progress: Show current progress on SIGINFO
>=20
> Peter Lieven (1):
>       qemu-img: simplify img_convert
>=20
> Thomas Huth (1):
>       Issue a deprecation warning if the user specifies the "-hdachs" opt=
ion.
>=20
> Vladimir Sementsov-Ogievskiy (1):
>       qemu-img: improve convert_iteration_sectors()
>=20
>  block.c                            |  26 +--
>  block/blkdebug.c                   |   8 +-
>  block/blkreplay.c                  |   3 -
>  block/blkverify.c                  |   3 -
>  block/block-backend.c              |   7 +-
>  block/commit.c                     |   5 +-
>  block/crypto.c                     |   5 +-
>  block/file-posix.c                 |  21 ++-
>  block/file-win32.c                 |   7 +-
>  block/gluster.c                    |   7 +-
>  block/io.c                         |  16 +-
>  block/iscsi.c                      |   6 +-
>  block/mirror.c                     |   2 +-
>  block/nfs.c                        |  12 +-
>  block/parallels.c                  |  13 +-
>  block/qcow.c                       |   6 +-
>  block/qcow2-refcount.c             |   5 +-
>  block/qcow2.c                      |  31 ++--
>  block/qed.c                        |   8 +-
>  block/raw-format.c                 |   6 +-
>  block/rbd.c                        |   3 +-
>  block/sheepdog.c                   |  14 +-
>  block/vdi.c                        |   4 +-
>  block/vhdx-log.c                   |   2 +-
>  block/vhdx.c                       |  25 ++-
>  block/vmdk.c                       |  13 +-
>  block/vpc.c                        |  13 +-
>  blockdev.c                         |  21 +--
>  include/block/block.h              |   2 +-
>  include/block/block_int.h          |   8 +-
>  include/sysemu/block-backend.h     |   4 +-
>  migration/savevm.c                 |   8 +
>  qemu-img-cmds.hx                   |   8 +-
>  qemu-img.c                         | 313 ++++++++++++++-----------------=
------
>  qemu-img.texi                      |   7 +-
>  qemu-io-cmds.c                     |   5 +-
>  qemu-options.hx                    |   4 +-
>  tests/qemu-iotests/026             |   2 +-
>  tests/qemu-iotests/026.out         |   2 +-
>  tests/qemu-iotests/026.out.nocache |   2 +-
>  tests/qemu-iotests/028.out         |   2 +-
>  tests/qemu-iotests/051             |   4 +-
>  tests/qemu-iotests/051.out         | 109 ++++++-------
>  tests/qemu-iotests/051.pc.out      | 135 ++++++++--------
>  tests/qemu-iotests/066             |  12 +-
>  tests/qemu-iotests/066.out         |  12 +-
>  tests/qemu-iotests/068             |   4 +-
>  tests/qemu-iotests/068.out         |   6 +-
>  tests/qemu-iotests/109             |   6 +-
>  tests/qemu-iotests/109.out         |  20 +--
>  tests/qemu-iotests/122.out         |   4 +-
>  tests/qemu-iotests/130.out         |   4 +-
>  tests/qemu-iotests/142             |   2 +-
>  tests/qemu-iotests/142.out         |  10 +-
>  tests/qemu-iotests/145             |   3 +-
>  tests/qemu-iotests/145.out         |   2 +-
>  tests/qemu-iotests/181             | 119 ++++++++++++++
>  tests/qemu-iotests/181.out         |  38 +++++
>  tests/qemu-iotests/common          |  11 +-
>  tests/qemu-iotests/common.config   |  24 ---
>  tests/qemu-iotests/common.filter   |  13 ++
>  tests/qemu-iotests/common.qemu     |   4 +-
>  tests/qemu-iotests/common.rc       |   4 +-
>  tests/qemu-iotests/group           |   1 +
>  util/qemu-progress.c               |   3 +
>  vl.c                               |   2 +
>  66 files changed, 669 insertions(+), 542 deletions(-)
>  create mode 100755 tests/qemu-iotests/181
>  create mode 100644 tests/qemu-iotests/181.out

I'm merging this pull request.  Regarding the discussion about
bisectability on Patch 4:

< kwolf> stefanha: It will reintroduce an assertion failure that we "fixed"=
 by uncommenting the assertion for the 2.9 release. Not sure about bisectab=
ility in this case; what already broke it is really
               the temporary workaround, not reverting it.
< kwolf> stefanha: Do you think we should keep the assertion disabled until=
 the real fix is there? It means that we can't find other problematic cases=
 in the meantime.
< stefanha> kwolf: Depends on how likely it is that other problematic cases=
 exist
< stefanha> kwolf: If you want to go ahead I can merge the pull request.
< kwolf> stefanha: I think it's okay to go ahead, but if you're not sure ab=
out it, I can do a v2 without that patch. I just need to know that you expe=
ct me to send a v2.
< stefanha> kwolf: I will merge it, was just waiting for the discussion on =
Patch 4 to finish.

Thanks, applied to my staging tree:
https://github.com/stefanha/qemu/commits/staging

Stefan

--LZvS9be/3tNcYl/X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZCyKSAAoJEJykq7OBq3PI8b4H/2EKHqAbQuJxl9QYFgYgJJm4
qF8ktCa3ww9A0YbpwD1raCXNGkKGQroOizYLS2/IAmLubPEMhizasuh38p7B3mn+
+A1aNUAP0sNAQwHs8ldNxzEqOEt0ain8BO6iYdNRyvrqbXnviP8LFfSfRBYatEsZ
nBwSSFcjYAT2Gk2KsefuViXF3XyGZewoq/ORSaSQjPgnQdZ9vzurvIwLiro2Bjne
60vvnKJqdGLH/DOVHYAjAyNHGmugCas4y/Fo7H3pgBYK1Hxbnd2XMasbIjhKEuJs
RkCp2H/sqKscZCvNvGcAErcYlD1aPrlPgHDKxkwjwNZ8dJsWs+OajZudMjPksCU=
=jTsC
-----END PGP SIGNATURE-----

--LZvS9be/3tNcYl/X--
