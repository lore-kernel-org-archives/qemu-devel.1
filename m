Received: from eggs.gnu.org ([2001:4830:134:3::10]:42226)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fZp3F-0001Dl-JD
	for qemu-devel@nongnu.org; Sun, 01 Jul 2018 22:58:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fZp3F-0001cB-0T
	for qemu-devel@nongnu.org; Sun, 01 Jul 2018 22:58:53 -0400
From: Fam Zheng <famz@redhat.com>
Date: Mon,  2 Jul 2018 10:58:33 +0800
Message-Id: <20180702025836.20957-2-famz@redhat.com>
In-Reply-To: <20180702025836.20957-1-famz@redhat.com>
References: <20180702025836.20957-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH 1/4] qcow2: Drop unused cluster_data
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

Reported-by: Max Reitz <mreitz@redhat.com>
Signed-off-by: Fam Zheng <famz@redhat.com>
---
 block/qcow2.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index 2f9e58e0c4..3177c72de0 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -3338,7 +3338,6 @@ qcow2_co_copy_range_to(BlockDriverState *bs,
     int ret;
     unsigned int cur_bytes; /* number of sectors in current iteration */
     uint64_t cluster_offset;
-    uint8_t *cluster_data = NULL;
     QCowL2Meta *l2meta = NULL;
 
     assert(!bs->encrypted);
@@ -3397,7 +3396,6 @@ fail:
 
     qemu_co_mutex_unlock(&s->lock);
 
-    qemu_vfree(cluster_data);
     trace_qcow2_writev_done_req(qemu_coroutine_self(), ret);
 
     return ret;
-- 
2.17.1
