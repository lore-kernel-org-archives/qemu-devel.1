Received: from eggs.gnu.org ([2001:4830:134:3::10]:57555)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1edz9c-0003LV-FJ
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 09:02:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1edz9W-0005ix-O0
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 09:02:24 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 23 Jan 2018 15:01:32 +0100
Message-Id: <20180123140201.31163-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 00/29] Block layer patches
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

The following changes since commit ee86981bda9ecd40c8daf81b7307b1d2aff68174:

  migration: Revert postcopy-blocktime commit set (2018-01-23 10:08:05 +0000)

are available in the git repository at:

  git://repo.or.cz/qemu/kevin.git tags/for-upstream

for you to fetch changes up to 8c0c5e636e6b11eaf0556be31fceb68e0baff310:

  Merge remote-tracking branch 'mreitz/tags/pull-block-2018-01-23' into queue-block (2018-01-23 12:40:46 +0100)

----------------------------------------------------------------
Block layer patches

----------------------------------------------------------------
Daniel Henrique Barboza (1):
      tests/qemu-iotests: adding savevm/loadvm with postcopy flag test

Eric Blake (1):
      iotests: Split 177 into two parts for compat=0.10

Fam Zheng (1):
      osdep: Retry SETLK upon EINTR

Hikaru Nishida (1):
      hw/block: Fix pin-based interrupt behaviour of NVMe

Kevin Wolf (2):
      tests/.gitignore: Add test-bdrv-drain
      Merge remote-tracking branch 'mreitz/tags/pull-block-2018-01-23' into queue-block

Max Reitz (24):
      qcow2: Repair unaligned preallocated zero clusters
      iotests: Make BD-{remove,insert}-medium use @id
      tests/ahci: Switch tray and medium commands to @id
      blockdev: Drop BD-{remove,insert}-medium's @device
      blockdev: Mark BD-{remove,insert}-medium stable
      qemu-iotests: Fix locking issue in 102
      block/vmdk: Fix , instead of ; at end of line
      qcow2: No persistent dirty bitmaps for compat=0.10
      block/qcow: Add blkdebug events
      block/vmdk: Add blkdebug events
      iotests: Fix _img_info for backslashes
      iotests: Drop format-specific in _filter_img_info
      iotests: Forbid 020 for non-file protocols
      iotests: Skip 103 for refcount_bits=1
      iotests: Fix 020 for vmdk
      iotests: Fix 051 for compat=0.10
      iotests: Fix 059's reference output
      iotests: Fix 067 for compat=0.10
      iotests: Make 089 compatible with compat=0.10
      iotests: Make 184 image-less
      iotests: Make 191 work with qcow2 options
      iotests: Filter compat-dependent info in 198
      iotests: Make 059 pass on machines with little RAM
      iotests: Disable some tests for compat=0.10

 qapi/block-core.json             |  42 ++----
 hw/block/nvme.h                  |   1 +
 block/qcow.c                     |  16 ++
 block/qcow2-bitmap.c             |  10 ++
 block/qcow2-refcount.c           |  70 +++++++--
 block/qcow2.c                    |  14 +-
 block/vmdk.c                     |  18 ++-
 blockdev.c                       |  30 +++-
 hw/block/nvme.c                  |  39 ++++-
 tests/ahci-test.c                |  16 +-
 util/osdep.c                     |   4 +-
 tests/.gitignore                 |   1 +
 tests/qemu-iotests/020           |  17 +--
 tests/qemu-iotests/020.out       |   6 +-
 tests/qemu-iotests/051           |   2 +
 tests/qemu-iotests/051.out       |   1 +
 tests/qemu-iotests/051.pc.out    |   1 +
 tests/qemu-iotests/059           |   4 +-
 tests/qemu-iotests/059.out       |   2 +-
 tests/qemu-iotests/060           |   3 +-
 tests/qemu-iotests/060.out       |   9 ++
 tests/qemu-iotests/067           |   3 +-
 tests/qemu-iotests/067.out       |  97 ++++--------
 tests/qemu-iotests/080           |   5 +-
 tests/qemu-iotests/089           |   4 +-
 tests/qemu-iotests/089.out       |  10 --
 tests/qemu-iotests/093           |   6 +-
 tests/qemu-iotests/102           |   7 +-
 tests/qemu-iotests/102.out       |   3 +-
 tests/qemu-iotests/103           |   2 +
 tests/qemu-iotests/118           | 184 +++++++++++------------
 tests/qemu-iotests/130           |   2 +
 tests/qemu-iotests/137           |   2 +
 tests/qemu-iotests/139           |   2 +-
 tests/qemu-iotests/155           |  60 ++++----
 tests/qemu-iotests/176           |   2 +
 tests/qemu-iotests/177           |  20 +--
 tests/qemu-iotests/177.out       |  22 +--
 tests/qemu-iotests/184           |  25 +---
 tests/qemu-iotests/184.out       |  63 ++------
 tests/qemu-iotests/191           |   5 +-
 tests/qemu-iotests/191.out       | 313 +++++++++++----------------------------
 tests/qemu-iotests/198           |   8 +-
 tests/qemu-iotests/198.out       |   8 -
 tests/qemu-iotests/201           | 120 +++++++++++++++
 tests/qemu-iotests/201.out       |  23 +++
 tests/qemu-iotests/204           | 119 +++++++++++++++
 tests/qemu-iotests/204.out       |  63 ++++++++
 tests/qemu-iotests/common.filter |  29 +++-
 tests/qemu-iotests/common.rc     |   2 +-
 tests/qemu-iotests/group         |   2 +
 51 files changed, 870 insertions(+), 647 deletions(-)
 create mode 100755 tests/qemu-iotests/201
 create mode 100644 tests/qemu-iotests/201.out
 create mode 100755 tests/qemu-iotests/204
 create mode 100644 tests/qemu-iotests/204.out
