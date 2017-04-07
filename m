Received: from eggs.gnu.org ([2001:4830:134:3::10]:50579)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1cwavF-00066n-Nw
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 16:56:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1cwavE-0003TU-Rv
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 16:55:57 -0400
From: Jeff Cody <jcody@redhat.com>
Date: Fri,  7 Apr 2017 16:55:28 -0400
Message-Id: <73b2399459760c32506f9407efb9dddb3a2789de.1491597120.git.jcody@redhat.com>
In-Reply-To: <cover.1491597120.git.jcody@redhat.com>
References: <cover.1491597120.git.jcody@redhat.com>
In-Reply-To: <cover.1491597120.git.jcody@redhat.com>
References: <cover.1491597120.git.jcody@redhat.com>
Subject: [Qemu-devel] [PATCH v2 for-2.10 4/8] block: code movement
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, stefanha@redhat.com, kwolf@redhat.com, jsnow@redhat.com, eblake@redhat.com

Move bdrv_is_read_only() up with its friends.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Signed-off-by: Jeff Cody <jcody@redhat.com>
---
 block.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/block.c b/block.c
index 68a18b0..a05ad48 100644
--- a/block.c
+++ b/block.c
@@ -192,6 +192,11 @@ void path_combine(char *dest, int dest_size,
     }
 }
 
+bool bdrv_is_read_only(BlockDriverState *bs)
+{
+    return bs->read_only;
+}
+
 int bdrv_set_read_only(BlockDriverState *bs, bool read_only, Error **errp)
 {
     /* Do not set read_only if copy_on_read is enabled */
@@ -3367,11 +3372,6 @@ void bdrv_get_geometry(BlockDriverState *bs, uint64_t *nb_sectors_ptr)
     *nb_sectors_ptr = nb_sectors < 0 ? 0 : nb_sectors;
 }
 
-bool bdrv_is_read_only(BlockDriverState *bs)
-{
-    return bs->read_only;
-}
-
 bool bdrv_is_sg(BlockDriverState *bs)
 {
     return bs->sg;
-- 
2.9.3
