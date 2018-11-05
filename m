Received: from eggs.gnu.org ([2001:4830:134:3::10]:50181)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gJht6-0006mm-Ps
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 11:38:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gJht4-0002lo-4U
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 11:38:04 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon,  5 Nov 2018 17:37:08 +0100
Message-Id: <20181105163744.25139-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 00/36] Block layer patches
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

The following changes since commit b2f7a038bb4c4fc5ce6b8486e8513dfd97665e=
2a:

  Merge remote-tracking branch 'remotes/rth/tags/pull-softfloat-20181104'=
 into staging (2018-11-05 10:32:49 +0000)

are available in the Git repository at:

  git://repo.or.cz/qemu/kevin.git tags/for-upstream

for you to fetch changes up to 1240ac558d348f6c7a5752b1a57c1da58e4efe3e:

  include: Add a comment to explain the origin of sizes' lookup table (20=
18-11-05 15:29:59 +0100)

----------------------------------------------------------------
Block layer patches:

- auto-read-only option to fix commit job when used with -blockdev
- Fix help text related qemu-iotests failure (by improving the help text
  and updating the reference output)
- quorum: Add missing checks when adding/removing child nodes
- Don't take address of fields in packed structs
- vvfat: Fix crash when reporting error about too many files in directory

----------------------------------------------------------------
Alberto Garcia (7):
      block: replace "discard" literal with BDRV_OPT_DISCARD macro
      qcow2: Get the request alignment for encrypted images from QCryptoB=
lock
      quorum: Remove quorum_err()
      quorum: Return an error if the blkverify mode has invalid settings
      iotest: Test the blkverify mode of the Quorum driver
      quorum: Forbid adding children in blkverify mode
      iotest: Test x-blockdev-change on a Quorum

Cleber Rosa (1):
      iotests: make 083 specific to raw

Daniel P. Berrang=C3=A9 (1):
      crypto: initialize sector size even when opening with no IO flag

Kevin Wolf (12):
      vpc: Don't leak opts in vpc_open()
      block: Update flags in bdrv_set_read_only()
      block: Add auto-read-only option
      rbd: Close image in qemu_rbd_open() error path
      block: Require auto-read-only for existing fallbacks
      nbd: Support auto-read-only option
      file-posix: Support auto-read-only option
      curl: Support auto-read-only option
      gluster: Support auto-read-only option
      iscsi: Support auto-read-only option
      block: Make auto-read-only=3Don default for -drive
      qemu-iotests: Test auto-read-only with -drive and -blockdev

Leonid Bloch (2):
      vdi: Use a literal number of bytes for DEFAULT_CLUSTER_SIZE
      include: Add a comment to explain the origin of sizes' lookup table

Li Qiang (1):
      block: change some function return type to bool

Max Reitz (5):
      option: Make option help nicer to read
      chardev: Indent list of chardevs
      qdev-monitor: Make device options help nicer
      object: Make option help nicer to read
      fw_cfg: Drop newline in @file description

Peter Maydell (5):
      block/qcow2: Don't take address of fields in packed structs
      block/qcow: Don't take address of fields in packed structs
      block/qcow2-bitmap: Don't take address of fields in packed structs
      block/vhdx: Don't take address of fields in packed structs
      block/vdi: Don't take address of fields in packed structs

Stefan Weil (1):
      qemu-io-cmds: Fix two format strings

Thomas Huth (1):
      block/vvfat: Fix crash when reporting error about too many files in=
 directory

 qapi/block-core.json           |   7 +
 block/vhdx.h                   |  12 +-
 include/block/block.h          |   5 +-
 include/qemu/option.h          |   2 +-
 include/qemu/units.h           |  18 +
 include/sysemu/block-backend.h |   6 +-
 block.c                        |  60 ++-
 block/block-backend.c          |   8 +-
 block/bochs.c                  |  17 +-
 block/cloop.c                  |  16 +-
 block/curl.c                   |   8 +-
 block/dmg.c                    |  16 +-
 block/file-posix.c             |  19 +-
 block/gluster.c                |  12 +-
 block/iscsi.c                  |   8 +-
 block/nbd-client.c             |  10 +-
 block/qcow.c                   |  18 +-
 block/qcow2-bitmap.c           |  24 +-
 block/qcow2.c                  |  66 +--
 block/quorum.c                 |  45 +-
 block/rbd.c                    |  14 +-
 block/vdi.c                    |  68 +--
 block/vhdx-endian.c            | 118 ++---
 block/vhdx-log.c               |   4 +-
 block/vhdx.c                   |  18 +-
 block/vpc.c                    |   2 +
 block/vvfat.c                  |  15 +-
 blockdev.c                     |   3 +-
 chardev/char.c                 |   2 +-
 crypto/block-qcow.c            |   2 +
 qdev-monitor.c                 |  13 +-
 qemu-img.c                     |   4 +-
 qemu-io-cmds.c                 |   4 +-
 util/qemu-option.c             |  32 +-
 vl.c                           |  15 +-
 tests/qemu-iotests/081         | 116 +++++
 tests/qemu-iotests/081.out     |  70 +++
 tests/qemu-iotests/082.out     | 956 ++++++++++++++++++++---------------=
------
 tests/qemu-iotests/083         |   2 +-
 tests/qemu-iotests/232         | 147 +++++++
 tests/qemu-iotests/232.out     |  59 +++
 tests/qemu-iotests/group       |   1 +
 42 files changed, 1266 insertions(+), 776 deletions(-)
 create mode 100755 tests/qemu-iotests/232
 create mode 100644 tests/qemu-iotests/232.out
