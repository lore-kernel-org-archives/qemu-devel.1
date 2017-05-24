Received: from eggs.gnu.org ([2001:4830:134:3::10]:60585)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dDctn-0003XT-PY
	for qemu-devel@nongnu.org; Wed, 24 May 2017 16:28:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dDctm-0005x8-US
	for qemu-devel@nongnu.org; Wed, 24 May 2017 16:28:51 -0400
From: Eric Blake <eblake@redhat.com>
Date: Wed, 24 May 2017 15:28:37 -0500
Message-Id: <20170524202842.26724-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v2 0/5] more blkdebug tweaks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, jsnow@redhat.com, mreitz@redhat.com

I found a crasher and some odd behavior while rebasing my
bdrv_get_block_status series, so I figured I'd get these things
fixed first.  This is based on top of Max's block branch.

Since v1:
- patch 1: patch open_f instead of openfile [Fam]
- patch 2: drop redundant assignment
- patch 3: new
- patch 4, 5: tweak commit message

(no diff from v1, since I forgot to tag that one)

Available as a tag at:
git fetch git://repo.or.cz/qemu/ericb.git nbd-blkdebug-status-v2

Eric Blake (5):
  qemu-io: Don't die on second open
  block: Guarantee that *file is set on bdrv_get_block_status()
  block: Allow NULL file for bdrv_get_block_status()
  block: Simplify use of BDRV_BLOCK_RAW
  blkdebug: Support .bdrv_co_get_block_status

 block/blkdebug.c           | 11 +++++++++++
 block/commit.c             |  2 +-
 block/io.c                 | 20 ++++++++++++--------
 block/mirror.c             |  5 ++---
 block/qcow2.c              |  4 +---
 block/raw-format.c         |  2 +-
 block/vpc.c                |  2 +-
 qemu-img.c                 | 10 ++++------
 qemu-io.c                  |  7 ++++---
 tests/qemu-iotests/177     |  3 +++
 tests/qemu-iotests/177.out |  5 +++++
 11 files changed, 45 insertions(+), 26 deletions(-)

-- 
2.9.4
