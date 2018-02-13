Received: from eggs.gnu.org ([2001:4830:134:3::10]:52330)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ele1j-0002yO-9b
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 12:05:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ele1i-0005M1-Dw
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 12:05:55 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 13 Feb 2018 18:04:51 +0100
Message-Id: <20180213170529.10858-18-kwolf@redhat.com>
In-Reply-To: <20180213170529.10858-1-kwolf@redhat.com>
References: <20180213170529.10858-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 17/55] qcow2: Fix documentation of
 get_cluster_table()
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

From: Alberto Garcia <berto@igalia.com>

This function has not been returning the offset of the L2 table since
commit 3948d1d4876065160583e79533bf604481063833

Signed-off-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Message-id: b498733b6706a859a03678d74ecbd26aeba129aa.1517840876.git.berto@igalia.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/qcow2-cluster.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index f077cd3ac5..e5ab102c29 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -647,8 +647,7 @@ fail:
  * for a given disk offset, load (and allocate if needed)
  * the l2 table.
  *
- * the l2 table offset in the qcow2 file and the cluster index
- * in the l2 table are given to the caller.
+ * the cluster index in the l2 table is given to the caller.
  *
  * Returns 0 on success, -errno in failure case
  */
-- 
2.13.6
