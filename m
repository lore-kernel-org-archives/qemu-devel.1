Received: from eggs.gnu.org ([2001:4830:134:3::10]:53497)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eEewm-0005Ny-Ar
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 12:24:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eEewl-00046T-GQ
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 12:24:28 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Tue, 14 Nov 2017 18:23:57 +0100
Message-Id: <20171114172417.7654-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PULL 00/20] Block patches for 2.11.0-rc1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Kevin Wolf <kwolf@redhat.com>

The following changes since commit 191b5fbfa66e5b23e2150f3c6981d30eb84418a9:

  Merge remote-tracking branch 'remotes/stefanha/tags/block-pull-request' into staging (2017-11-14 16:11:19 +0000)

are available in the git repository at:

  git://github.com/XanClic/qemu.git tags/pull-block-2017-11-14

for you to fetch changes up to 8b2d7c364d9a2491f7501f6688cd722045cf808a:

  qemu-iotests: update unsupported image formats in 194 (2017-11-14 18:06:26 +0100)

----------------------------------------------------------------
Block patches for 2.11.0-rc1

----------------------------------------------------------------
Alberto Garcia (8):
  qcow2: Prevent allocating refcount blocks at offset 0
  qcow2: Prevent allocating L2 tables at offset 0
  qcow2: Prevent allocating compressed clusters at offset 0
  qcow2: Don't open images with header.refcount_table_clusters == 0
  qcow2: Add iotest for an image with header.refcount_table_offset == 0
  qcow2: Add iotest for an empty refcount table
  qcow2: Assert that the crypto header does not overlap other metadata
  qcow2: Check that corrupted images can be repaired in iotest 060

Eric Blake (1):
  iotests: Use new-style NBD connections

Fam Zheng (1):
  iotests: 077: Filter out 'resume' lines

Jeff Cody (4):
  block/vhdx.c: Don't blindly update the header
  block/parallels: Do not update header or truncate image when INMIGRATE
  block/parallels: add migration blocker
  qemu-iotests: update unsupported image formats in 194

Max Reitz (5):
  iotests: Make 030 less flaky
  iotests: Add missing 'blkdebug::' in 040
  iotests: Make 055 less flaky
  iotests: Make 083 less flaky
  iotests: Make 136 less flaky

Vladimir Sementsov-Ogievskiy (1):
  block/snapshot: dirty all dirty bitmaps on snapshot-switch

 block/parallels.c            |  22 ++++++---
 block/qcow2-cluster.c        |   8 ++++
 block/qcow2-refcount.c       |  14 ++++++
 block/qcow2.c                |   7 +++
 block/snapshot.c             |  14 ++++++
 block/vhdx.c                 |   7 ---
 tests/qemu-iotests/030       |   8 +++-
 tests/qemu-iotests/040       |   2 +-
 tests/qemu-iotests/055       |  25 +++++++----
 tests/qemu-iotests/060       |  59 +++++++++++++++++++++++++
 tests/qemu-iotests/060.out   | 103 +++++++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/077       |   3 +-
 tests/qemu-iotests/077.out   |  16 -------
 tests/qemu-iotests/083       |   4 +-
 tests/qemu-iotests/136       |  14 +++++-
 tests/qemu-iotests/194       |   2 +-
 tests/qemu-iotests/common.rc |   2 +-
 17 files changed, 265 insertions(+), 45 deletions(-)

-- 
2.13.6
