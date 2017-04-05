Received: from eggs.gnu.org ([2001:4830:134:3::10]:33169)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <den@openvz.org>) id 1cvmhb-00032q-6X
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 11:18:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <den@openvz.org>) id 1cvmhY-0001g6-2r
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 11:18:31 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:41612 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <den@openvz.org>) id 1cvmhX-0001eY-OF
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 11:18:28 -0400
From: "Denis V. Lunev" <den@openvz.org>
Date: Wed,  5 Apr 2017 18:18:24 +0300
Message-Id: <1491405505-31620-2-git-send-email-den@openvz.org>
In-Reply-To: <1491405505-31620-1-git-send-email-den@openvz.org>
References: <1491405505-31620-1-git-send-email-den@openvz.org>
Subject: [Qemu-devel] [PATCH 1/2] block: fix obvious coding style mitakes in
 block_int.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Klim Kireev <proffk@virtuozzo.mipt.ru>, "Denis V . Lunev" <den@openvz.org>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

From: Klim Kireev <proffk@virtuozzo.mipt.ru>

Signed-off-by: Klim Kireev <proffk@virtuozzo.mipt.ru>
Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Kevin Wolf <kwolf@redhat.com>
CC: Max Reitz <mreitz@redhat.com>
---
 include/block/block_int.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/block/block_int.h b/include/block/block_int.h
index 59400bd..bf18c5f 100644
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
2.7.4
