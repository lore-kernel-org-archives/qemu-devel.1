Received: from eggs.gnu.org ([2001:4830:134:3::10]:60067)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fcbMr-0007L2-BC
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 14:58:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fcbMq-0002vo-Lj
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 14:58:37 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Mon,  9 Jul 2018 20:58:22 +0200
Message-Id: <20180709185828.4248-2-mreitz@redhat.com>
In-Reply-To: <20180709185828.4248-1-mreitz@redhat.com>
References: <20180709185828.4248-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PULL 1/7] qcow2: Drop unused cluster_data
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

From: Fam Zheng <famz@redhat.com>

Reported-by: Max Reitz <mreitz@redhat.com>
Signed-off-by: Fam Zheng <famz@redhat.com>
Message-id: 20180702025836.20957-2-famz@redhat.com
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/qcow2.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index 33b61b7480..d4ba0f781a 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -3345,7 +3345,6 @@ qcow2_co_copy_range_to(BlockDriverState *bs,
     int ret;
     unsigned int cur_bytes; /* number of sectors in current iteration */
     uint64_t cluster_offset;
-    uint8_t *cluster_data = NULL;
     QCowL2Meta *l2meta = NULL;
 
     assert(!bs->encrypted);
@@ -3404,7 +3403,6 @@ fail:
 
     qemu_co_mutex_unlock(&s->lock);
 
-    qemu_vfree(cluster_data);
     trace_qcow2_writev_done_req(qemu_coroutine_self(), ret);
 
     return ret;
-- 
2.17.1
