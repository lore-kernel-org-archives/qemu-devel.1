Received: from eggs.gnu.org ([2001:4830:134:3::10]:46943)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <npes87184@gmail.com>) id 1fkq0n-0001GX-VR
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 08:13:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <npes87184@gmail.com>) id 1fkq0k-0003ox-07
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 08:13:53 -0400
From: npes87184 <npes87184@gmail.com>
Date: Wed,  1 Aug 2018 20:13:31 +0800
Message-Id: <20180801121331.5740-1-npes87184@gmail.com>
Subject: [Qemu-devel] [PATCH] block_int: add missing @ in comment
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org, npes87184 <npes87184@gmail.com>

add missing @ in comment

Signed-off-by: npes87184 <npes87184@gmail.com>
---
 include/block/block_int.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/block/block_int.h b/include/block/block_int.h
index 903b9c1034..2ce016ea94 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -221,7 +221,7 @@ struct BlockDriver {
                                                 BdrvRequestFlags read_flags,
                                                 BdrvRequestFlags write_flags);
 
-    /* Map [offset, offset + nbytes) range onto a child of bs to copy data to,
+    /* Map [offset, offset + nbytes) range onto a child of @bs to copy data to,
      * and invoke bdrv_co_copy_range_to(child, src, ...), or perform the copy
      * operation if @bs is the leaf and @src has the same BlockDriver.  Return
      * -ENOTSUP if @bs is the leaf but @src has a different BlockDriver.
-- 
2.17.1
