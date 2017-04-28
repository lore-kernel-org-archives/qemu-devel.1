Received: from eggs.gnu.org ([2001:4830:134:3::10]:55205)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d4CaR-0001Nd-Og
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 16:33:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d4CaQ-00012j-MC
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 16:33:55 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 28 Apr 2017 22:33:08 +0200
Message-Id: <1493411622-5343-1-git-send-email-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 00/34] Block layer patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

The following changes since commit 81b2d5ceb0cfb4cdc2163492e3169ed714b0cd=
a9:

  Merge remote-tracking branch 'remotes/rth/tags/pull-tcg-20170426' into =
staging (2017-04-26 20:50:49 +0100)

are available in the git repository at:


  git://repo.or.cz/qemu/kevin.git tags/for-upstream

for you to fetch changes up to 5fc0fe383fff318b38291dcdf2cf38e329ec232a:

  Merge remote-tracking branch 'mreitz/tags/pull-block-2017-04-28' into q=
ueue-block (2017-04-28 20:52:17 +0200)

----------------------------------------------------------------

Block layer patches

----------------------------------------------------------------
Denis V. Lunev (2):
      block: fix alignment calculations in bdrv_co_do_zero_pwritev
      block: assert no image modification under BDRV_O_INACTIVE

Eric Blake (2):
      iotests: Fix typo in 026
      qcow2: Allow discard of final unaligned cluster

Fam Zheng (2):
      block: Remove NULL check in bdrv_co_flush
      iotests: 109: Filter out "len" of failed jobs

John Snow (2):
      iotests: clarify help text
      iotests: fix exclusion option

Kevin Wolf (8):
      file-posix: Remove unnecessary includes
      file-win32: Remove unnecessary include
      migration: Call blk_resume_after_migration() for postcopy
      qemu-iotests: Filter HMP readline escape characters
      qemu-iotests: Test postcopy migration
      qemu-iotests: Remove PERL_PROG and BC_PROG
      qemu_iotests: Remove _readlink()
      Merge remote-tracking branch 'mreitz/tags/pull-block-2017-04-28' in=
to queue-block

Klim Kireev (1):
      block: fix obvious coding style mistakes in block_int.h

Krzysztof Kozlowski (1):
      block: Constify data passed by pointer to blk_name

Lidong Chen (1):
      qemu-img: use blk_co_pwrite_zeroes for zero sectors when compressed

Max Reitz (13):
      Revert "block/io: Comment out permission assertions"
      block: An empty filename counts as no filename
      iotests/051: Add test for empty filename
      iotests: Launch qemu-nbd with -e 42
      block: Do not unref bs->file on error in BD's open
      qemu-img/convert: Use @opts for one thing only
      qemu-img/convert: Move bs_n > 1 && -B check down
      qemu-img: Document backing options
      block/vhdx: Make vhdx_create() always set errp
      block: Add errp to b{lk,drv}_truncate()
      block: Add errp to BD.bdrv_truncate()
      block: Add .bdrv_truncate() error messages
      progress: Show current progress on SIGINFO

Peter Lieven (1):
      qemu-img: simplify img_convert

Thomas Huth (1):
      Issue a deprecation warning if the user specifies the "-hdachs" opt=
ion.

Vladimir Sementsov-Ogievskiy (1):
      qemu-img: improve convert_iteration_sectors()

 block.c                            |  26 +--
 block/blkdebug.c                   |   8 +-
 block/blkreplay.c                  |   3 -
 block/blkverify.c                  |   3 -
 block/block-backend.c              |   7 +-
 block/commit.c                     |   5 +-
 block/crypto.c                     |   5 +-
 block/file-posix.c                 |  21 ++-
 block/file-win32.c                 |   7 +-
 block/gluster.c                    |   7 +-
 block/io.c                         |  16 +-
 block/iscsi.c                      |   6 +-
 block/mirror.c                     |   2 +-
 block/nfs.c                        |  12 +-
 block/parallels.c                  |  13 +-
 block/qcow.c                       |   6 +-
 block/qcow2-refcount.c             |   5 +-
 block/qcow2.c                      |  31 ++--
 block/qed.c                        |   8 +-
 block/raw-format.c                 |   6 +-
 block/rbd.c                        |   3 +-
 block/sheepdog.c                   |  14 +-
 block/vdi.c                        |   4 +-
 block/vhdx-log.c                   |   2 +-
 block/vhdx.c                       |  25 ++-
 block/vmdk.c                       |  13 +-
 block/vpc.c                        |  13 +-
 blockdev.c                         |  21 +--
 include/block/block.h              |   2 +-
 include/block/block_int.h          |   8 +-
 include/sysemu/block-backend.h     |   4 +-
 migration/savevm.c                 |   8 +
 qemu-img-cmds.hx                   |   8 +-
 qemu-img.c                         | 313 ++++++++++++++-----------------=
------
 qemu-img.texi                      |   7 +-
 qemu-io-cmds.c                     |   5 +-
 qemu-options.hx                    |   4 +-
 tests/qemu-iotests/026             |   2 +-
 tests/qemu-iotests/026.out         |   2 +-
 tests/qemu-iotests/026.out.nocache |   2 +-
 tests/qemu-iotests/028.out         |   2 +-
 tests/qemu-iotests/051             |   4 +-
 tests/qemu-iotests/051.out         | 109 ++++++-------
 tests/qemu-iotests/051.pc.out      | 135 ++++++++--------
 tests/qemu-iotests/066             |  12 +-
 tests/qemu-iotests/066.out         |  12 +-
 tests/qemu-iotests/068             |   4 +-
 tests/qemu-iotests/068.out         |   6 +-
 tests/qemu-iotests/109             |   6 +-
 tests/qemu-iotests/109.out         |  20 +--
 tests/qemu-iotests/122.out         |   4 +-
 tests/qemu-iotests/130.out         |   4 +-
 tests/qemu-iotests/142             |   2 +-
 tests/qemu-iotests/142.out         |  10 +-
 tests/qemu-iotests/145             |   3 +-
 tests/qemu-iotests/145.out         |   2 +-
 tests/qemu-iotests/181             | 119 ++++++++++++++
 tests/qemu-iotests/181.out         |  38 +++++
 tests/qemu-iotests/common          |  11 +-
 tests/qemu-iotests/common.config   |  24 ---
 tests/qemu-iotests/common.filter   |  13 ++
 tests/qemu-iotests/common.qemu     |   4 +-
 tests/qemu-iotests/common.rc       |   4 +-
 tests/qemu-iotests/group           |   1 +
 util/qemu-progress.c               |   3 +
 vl.c                               |   2 +
 66 files changed, 669 insertions(+), 542 deletions(-)
 create mode 100755 tests/qemu-iotests/181
 create mode 100644 tests/qemu-iotests/181.out
