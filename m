Received: from eggs.gnu.org ([2001:4830:134:3::10]:38942)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ddeVH-0001MP-AC
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 11:27:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ddeVG-0003Jj-Db
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 11:27:07 -0400
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri,  4 Aug 2017 17:26:55 +0200
Message-Id: <20170804152655.31510-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH] block: drop bdrv_set_key from BlockDriver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org

This is not used anymore since c01c214b69 ("block: remove all encryption
handling APIs", 2017-07-11).

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/block/block_int.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/block/block_int.h b/include/block/block_int.h
index d4f4ea7584..7571c0aaaf 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -127,7 +127,6 @@ struct BlockDriver {
                           Error **errp);
     void (*bdrv_close)(BlockDriverState *bs);
     int (*bdrv_create)(const char *filename, QemuOpts *opts, Error **errp);
-    int (*bdrv_set_key)(BlockDriverState *bs, const char *key);
     int (*bdrv_make_empty)(BlockDriverState *bs);
 
     void (*bdrv_refresh_filename)(BlockDriverState *bs, QDict *options);
-- 
2.13.3
