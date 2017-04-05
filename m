Received: from eggs.gnu.org ([2001:4830:134:3::10]:34156)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1cvpgC-0006gv-Th
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 14:29:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1cvpgC-0002AQ-4y
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 14:29:16 -0400
From: Jeff Cody <jcody@redhat.com>
Date: Wed,  5 Apr 2017 14:28:46 -0400
Message-Id: <91ebd19aec29055c98e4658ed5cf3fb50720afe5.1491416061.git.jcody@redhat.com>
In-Reply-To: <cover.1491416061.git.jcody@redhat.com>
References: <cover.1491416061.git.jcody@redhat.com>
In-Reply-To: <cover.1491416061.git.jcody@redhat.com>
References: <cover.1491416061.git.jcody@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.10 4/9] block: code movement
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, jsnow@redhat.com, stefanha@redhat.com, kwolf@redhat.com

Move bdrv_is_read_only() up with its friends.

Signed-off-by: Jeff Cody <jcody@redhat.com>
---
 block.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/block.c b/block.c
index 4a61ff0..8bfe7f4 100644
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
