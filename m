Received: from eggs.gnu.org ([2001:4830:134:3::10]:52844)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dXTKO-0000Jo-P9
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 10:18:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dXTKN-0007XA-LT
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 10:18:20 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 18 Jul 2017 16:17:45 +0200
Message-Id: <1500387486-5469-1-git-send-email-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 00/21] Block layer patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

The following changes since commit 718d7f4f9cf772e5784093d8e6085680a235ac=
db:

  Merge remote-tracking branch 'remotes/stefanha/tags/block-pull-request'=
 into staging (2017-07-18 13:09:51 +0100)

are available in the git repository at:


  git://repo.or.cz/qemu/kevin.git tags/for-upstream

for you to fetch changes up to 6e6e55f5c2e5b520d6506c2716287ba3b5d1bbc8:

  qemu-img: Check for backing image if specified during create (2017-07-1=
8 15:27:37 +0200)

----------------------------------------------------------------
Block layer patches

----------------------------------------------------------------
Herv=C3=A9 Poussineau (4):
      vvfat: add constants for special values of name[0]
      vvfat: add a constant for bootsector name
      vvfat: correctly parse non-ASCII short and long file names
      vvfat: initialize memory after allocating it

John Snow (2):
      blockdev: move BDRV_O_NO_BACKING option forward
      qemu-img: Check for backing image if specified during create

Kevin Wolf (10):
      commit: Add NULL check for overlay_bs
      block: Make blk_get_attached_dev_id() public
      block/qapi: Add qdev device name to query-block
      block: Make blk_all_next() public
      block/qapi: Use blk_all_next() for query-block
      block: List anonymous device BBs in query-block
      ide: bdrv_attach_dev() for empty CD-ROM
      scsi-disk: bdrv_attach_dev() for empty CD-ROM
      qemu-iotests: Test 'info block'
      qemu-iotests: Test unplug of -device without drive

Manos Pitsidianakis (2):
      block: add clock_type field to ThrottleGroup
      block: remove timer canceling in throttle_config()

Max Reitz (1):
      block/vvfat: Fix compiler warning with gcc 7

Peter Maydell (2):
      block/vmdk: Report failures in vmdk_read_cid()
      block/vpc.c: Handle write failures in get_image_offset()

 block.c                        |  94 ++++----
 block/block-backend.c          |   5 +-
 block/commit.c                 |   4 +-
 block/qapi.c                   |  20 +-
 block/throttle-groups.c        |  28 +--
 block/vmdk.c                   |  44 +++-
 block/vpc.c                    |  30 ++-
 block/vvfat.c                  |  90 +++++---
 blockdev.c                     |  11 +-
 fsdev/qemu-fsdev-throttle.c    |   2 +-
 hmp.c                          |  11 +-
 hw/ide/qdev.c                  |   3 +
 hw/scsi/scsi-disk.c            |   5 +
 include/qemu/throttle.h        |   2 +-
 include/sysemu/block-backend.h |   2 +
 qapi/block-core.json           |   9 +-
 qemu-img-cmds.hx               |   4 +-
 qemu-img.c                     |  16 +-
 qemu-img.texi                  |   9 +-
 tests/qemu-iotests/067         |  13 ++
 tests/qemu-iotests/067.out     |  40 ++++
 tests/qemu-iotests/082         |   4 +-
 tests/qemu-iotests/082.out     |   4 +-
 tests/qemu-iotests/085         |   2 +-
 tests/qemu-iotests/111.out     |   1 +
 tests/qemu-iotests/139         |   2 +-
 tests/qemu-iotests/156         |   2 +-
 tests/qemu-iotests/158         |   2 +-
 tests/qemu-iotests/186         | 147 +++++++++++++
 tests/qemu-iotests/186.out     | 489 +++++++++++++++++++++++++++++++++++=
++++++
 tests/qemu-iotests/189         |   2 +-
 tests/qemu-iotests/group       |   1 +
 tests/test-throttle.c          |   4 +-
 util/throttle.c                |  18 +-
 34 files changed, 958 insertions(+), 162 deletions(-)
 create mode 100755 tests/qemu-iotests/186
 create mode 100644 tests/qemu-iotests/186.out
