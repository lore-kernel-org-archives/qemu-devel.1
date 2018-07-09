Received: from eggs.gnu.org ([2001:4830:134:3::10]:60064)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fcbMr-0007Kz-9k
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 14:58:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fcbMq-0002vg-Dt
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 14:58:37 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Mon,  9 Jul 2018 20:58:21 +0200
Message-Id: <20180709185828.4248-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PULL 0/7] Block patches for 3.0-rc0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

The following changes since commit ec7eb2ae77cc207064e17ace048f7ec0c4b85d6f:

  translate-all: honour CF_NOCACHE in tb_gen_code (2018-07-09 16:14:36 +0100)

are available in the Git repository at:

  https://git.xanclic.moe/XanClic/qemu.git tags/pull-block-2018-07-09

for you to fetch changes up to 0e4e4318eaa56c831001bdf617094807ec6d451c:

  qcow2: add overlap check for bitmap directory (2018-07-09 19:43:24 +0200)

----------------------------------------------------------------
Block patches for 3.0-rc0:
- qcow2 metadata overlap protection for the persistent bitmap directory
- Various bug fixes

----------------------------------------------------------------
Fam Zheng (4):
  qcow2: Drop unused cluster_data
  file-posix: Fix fd_open check in raw_co_copy_range_to
  qcow2: Drop unreachable break
  raw: Drop superfluous semicolon

Max Reitz (2):
  vmdk: Fix possible segfault with non-VMDK backing
  iotests: Add VMDK backing file correlation test

Vladimir Sementsov-Ogievskiy (1):
  qcow2: add overlap check for bitmap directory

 qapi/block-core.json       |  21 +++---
 block/qcow2.h              |  45 +++++++------
 block/file-posix.c         |   2 +-
 block/qcow2-bitmap.c       |   7 +-
 block/qcow2-refcount.c     |  10 +++
 block/qcow2.c              |  25 +++----
 block/raw-format.c         |   2 +-
 block/vmdk.c               |   6 ++
 tests/qemu-iotests/225     | 132 +++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/225.out |  24 +++++++
 tests/qemu-iotests/group   |   1 +
 11 files changed, 231 insertions(+), 44 deletions(-)
 create mode 100755 tests/qemu-iotests/225
 create mode 100644 tests/qemu-iotests/225.out

-- 
2.17.1
