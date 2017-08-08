Received: from eggs.gnu.org ([2001:4830:134:3::10]:42414)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1df52K-0000Dj-8N
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 09:59:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1df52F-00027A-BK
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 09:59:08 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue,  8 Aug 2017 15:58:27 +0200
Message-Id: <20170808135838.11525-8-kwolf@redhat.com>
In-Reply-To: <20170808135838.11525-1-kwolf@redhat.com>
References: <20170808135838.11525-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 07/18] block: drop bdrv_set_key from BlockDriver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, peter.maydell@linaro.org

From: Paolo Bonzini <pbonzini@redhat.com>

This is not used anymore since c01c214b69 ("block: remove all encryption
handling APIs", 2017-07-11).

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
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
2.13.4
