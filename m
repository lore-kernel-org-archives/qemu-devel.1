Received: from eggs.gnu.org ([2001:4830:134:3::10]:45770)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fhjDh-00028U-5I
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 18:22:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fhjDg-0007wk-6U
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 18:22:21 -0400
From: John Snow <jsnow@redhat.com>
Date: Mon, 23 Jul 2018 18:22:05 -0400
Message-Id: <20180723222210.11077-3-jsnow@redhat.com>
In-Reply-To: <20180723222210.11077-1-jsnow@redhat.com>
References: <20180723222210.11077-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH for-3.0 2/7] block/qcow2: improve error message
 in qcow2_inactivate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, qemu-stable@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, John Snow <jsnow@redhat.com>, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, eblake@redhat.com, Max Reitz <mreitz@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Signed-off-by: John Snow <jsnow@redhat.com>
---
 block/qcow2.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index 6162ed8be2..7444133ccd 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -2127,9 +2127,9 @@ static int qcow2_inactivate(BlockDriverState *bs)
     qcow2_store_persistent_dirty_bitmaps(bs, &local_err);
     if (local_err != NULL) {
         result = -EINVAL;
-        error_report_err(local_err);
-        error_report("Persistent bitmaps are lost for node '%s'",
-                     bdrv_get_device_or_node_name(bs));
+        error_reportf_err(local_err, "Lost persistent bitmaps during "
+                          "inactivation of node '%s': ",
+                          bdrv_get_device_or_node_name(bs));
     }
 
     ret = qcow2_cache_flush(bs, s->l2_table_cache);
-- 
2.14.4
