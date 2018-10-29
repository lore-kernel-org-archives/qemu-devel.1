Received: from eggs.gnu.org ([2001:4830:134:3::10]:45253)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gHF29-00041x-BZ
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 17:25:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gHF28-0002IE-4D
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 17:25:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55222)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1gHF27-0002HY-TB
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 17:25:12 -0400
From: John Snow <jsnow@redhat.com>
Date: Mon, 29 Oct 2018 17:24:50 -0400
Message-Id: <20181029212501.5897-9-jsnow@redhat.com>
In-Reply-To: <20181029212501.5897-1-jsnow@redhat.com>
References: <20181029212501.5897-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PULL 08/19] block/qcow2: improve error message in
 qcow2_inactivate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: jsnow@redhat.com, peter.maydell@linaro.org, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
[Maintainer edit -- touched up error message. --js]
Reviewed-by: John Snow <jsnow@redhat.com>
Signed-off-by: John Snow <jsnow@redhat.com>
---
 block/qcow2.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index 4f8d2fa7bd..eeb72ac362 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -2123,9 +2123,9 @@ static int qcow2_inactivate(BlockDriverState *bs)
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
2.14.5
