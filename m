Received: from eggs.gnu.org ([2001:4830:134:3::10]:35129)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dHxMh-0000Xj-A4
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 15:08:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dHxMg-00041C-DL
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 15:08:35 -0400
From: Eric Blake <eblake@redhat.com>
Date: Mon,  5 Jun 2017 14:08:20 -0500
Message-Id: <20170605190824.25184-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v3 0/4] more blkdebug tweaks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: jsnow@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org

I found a crasher and some odd behavior while rebasing my
bdrv_get_block_status series, so I figured I'd get these things
fixed first.  This is based on top of Max's block branch.

Available as a tag at:
git fetch git://repo.or.cz/qemu/ericb.git nbd-blkdebug-status-v3

Since v2:
- defer the original patch 3 to a later series
- rebase to make sure test 177 passes at all times (I didn't
pinpoint which recent merge caused it, but the test now produces
json:{...} instead of blkdebug:... during patch 2)
- add more documentation of BDRV_BLOCK_RAW
- add R-b where appropriate

001/4:[----] [--] 'qemu-io: Don't die on second open'
002/4:[0002] [FC] 'block: Guarantee that *file is set on bdrv_get_block_status()'
003/4:[0006] [FC] 'block: Simplify use of BDRV_BLOCK_RAW'
004/4:[0002] [FC] 'blkdebug: Support .bdrv_co_get_block_status'

Eric Blake (4):
  qemu-io: Don't die on second open
  block: Guarantee that *file is set on bdrv_get_block_status()
  block: Simplify use of BDRV_BLOCK_RAW
  blkdebug: Support .bdrv_co_get_block_status

 include/block/block.h      |  6 +++---
 block/blkdebug.c           | 11 +++++++++++
 block/commit.c             |  2 +-
 block/io.c                 |  5 +++--
 block/mirror.c             |  2 +-
 block/raw-format.c         |  2 +-
 block/vpc.c                |  2 +-
 qemu-io.c                  |  7 ++++---
 tests/qemu-iotests/177     |  3 +++
 tests/qemu-iotests/177.out |  5 +++++
 10 files changed, 33 insertions(+), 12 deletions(-)

-- 
2.9.4
