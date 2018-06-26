Received: from eggs.gnu.org ([2001:4830:134:3::10]:34186)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fXoMp-00043Y-K7
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 09:50:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fXoMo-0006Hz-WD
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 09:50:47 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Tue, 26 Jun 2018 16:50:31 +0300
Message-Id: <20180626135035.133432-3-vsementsov@virtuozzo.com>
In-Reply-To: <20180626135035.133432-1-vsementsov@virtuozzo.com>
References: <20180626135035.133432-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 2/6] block/qcow2: improve error message in
 qcow2_inactivate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: dgilbert@redhat.com, quintela@redhat.com, stefanha@redhat.com, jsnow@redhat.com, famz@redhat.com, mreitz@redhat.com, kwolf@redhat.com, vsementsov@virtuozzo.com, den@openvz.org

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/qcow2.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index 945132f692..46194a33ca 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -2114,9 +2114,9 @@ static int qcow2_inactivate(BlockDriverState *bs)
     qcow2_store_persistent_dirty_bitmaps(bs, &local_err);
     if (local_err != NULL) {
         result = -EINVAL;
-        error_report_err(local_err);
-        error_report("Persistent bitmaps are lost for node '%s'",
-                     bdrv_get_device_or_node_name(bs));
+        error_reportf_err(local_err, "Persistent bitmaps are lost for node "
+                          "'%s', because failed to store them on qcow2 "
+                          "inactivation: ", bdrv_get_device_or_node_name(bs));
     }
 
     ret = qcow2_cache_flush(bs, s->l2_table_cache);
-- 
2.11.1
