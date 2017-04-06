Received: from eggs.gnu.org ([2001:4830:134:3::10]:52609)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jemmy858585@gmail.com>) id 1cw7Ge-0003C1-Vw
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 09:16:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jemmy858585@gmail.com>) id 1cw7Gb-00034a-18
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 09:16:04 -0400
From: jemmy858585@gmail.com
Date: Thu,  6 Apr 2017 21:15:34 +0800
Message-Id: <1491484536-22776-1-git-send-email-lidongchen@tencent.com>
Subject: [Qemu-devel] [PATCH 0/2] use blk_pwrite_zeroes for each zero cluster
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, famz@redhat.com, kwolf@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org, quintela@redhat.com, dgilbert@redhat.com, Lidong Chen <lidongchen@tencent.com>

From: Lidong Chen <lidongchen@tencent.com>

BLOCK_SIZE is (1 << 20), qcow2 cluster size is 65536 by default,
this maybe cause the qcow2 file size is bigger after migration.
This patch check each cluster, use blk_pwrite_zeroes for each
zero cluster.

Lidong Chen (2):
  block: make bdrv_get_cluster_size public
  migration/block: use blk_pwrite_zeroes for each zero cluster

 block/io.c            |  2 +-
 include/block/block.h |  1 +
 migration/block.c     | 34 ++++++++++++++++++++++++++++++++--
 3 files changed, 34 insertions(+), 3 deletions(-)

-- 
1.8.3.1
