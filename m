Received: from eggs.gnu.org ([2001:4830:134:3::10]:56026)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d4CbO-00028m-LF
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 16:34:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d4CbN-0001Vl-K9
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 16:34:54 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 28 Apr 2017 22:33:36 +0200
Message-Id: <1493411622-5343-29-git-send-email-kwolf@redhat.com>
In-Reply-To: <1493411622-5343-1-git-send-email-kwolf@redhat.com>
References: <1493411622-5343-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 28/34] block: fix obvious coding style mistakes
 in block_int.h
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

From: Klim Kireev <proffk@virtuozzo.mipt.ru>

Signed-off-by: Klim Kireev <proffk@virtuozzo.mipt.ru>
Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Kevin Wolf <kwolf@redhat.com>
CC: Max Reitz <mreitz@redhat.com>
Message-id: 1491405505-31620-2-git-send-email-den@openvz.org
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 include/block/block_int.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/block/block_int.h b/include/block/block_int.h
index dcde90a..8773940 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -252,7 +252,7 @@ struct BlockDriver {
      * Returns 0 for completed check, -errno for internal errors.
      * The check results are stored in result.
      */
-    int (*bdrv_check)(BlockDriverState* bs, BdrvCheckResult *result,
+    int (*bdrv_check)(BlockDriverState *bs, BdrvCheckResult *result,
         BdrvCheckMode fix);
 
     int (*bdrv_amend_options)(BlockDriverState *bs, QemuOpts *opts,
@@ -454,13 +454,13 @@ struct BdrvChildRole {
     /* Returns a name that is supposedly more useful for human users than the
      * node name for identifying the node in question (in particular, a BB
      * name), or NULL if the parent can't provide a better name. */
-    const char* (*get_name)(BdrvChild *child);
+    const char *(*get_name)(BdrvChild *child);
 
     /* Returns a malloced string that describes the parent of the child for a
      * human reader. This could be a node-name, BlockBackend name, qdev ID or
      * QOM path of the device owning the BlockBackend, job type and ID etc. The
      * caller is responsible for freeing the memory. */
-    char* (*get_parent_desc)(BdrvChild *child);
+    char *(*get_parent_desc)(BdrvChild *child);
 
     /*
      * If this pair of functions is implemented, the parent doesn't issue new
-- 
1.8.3.1
