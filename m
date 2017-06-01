Received: from eggs.gnu.org ([2001:4830:134:3::10]:51546)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1dGRoY-0000A3-NN
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 11:15:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1dGRoU-0004eJ-Q9
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 11:15:06 -0400
Received: from mail-eopbgr40133.outbound.protection.outlook.com
	([40.107.4.133]:34349
	helo=EUR03-DB5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <anton.nefedov@virtuozzo.com>)
	id 1dGRoU-0004d9-H1
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 11:15:02 -0400
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Date: Thu, 1 Jun 2017 18:14:21 +0300
Message-ID: <1496330073-51338-4-git-send-email-anton.nefedov@virtuozzo.com>
In-Reply-To: <1496330073-51338-1-git-send-email-anton.nefedov@virtuozzo.com>
References: <1496330073-51338-1-git-send-email-anton.nefedov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v2 03/15] blkdebug: support BDRV_REQ_ALLOCATE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: den@virtuozzo.com, kwolf@redhat.com, mreitz@redhat.com, eblake@redhat.com, Anton Nefedov <anton.nefedov@virtuozzo.com>

Support the flag if the underlying BDS supports it

Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
---
 block/blkdebug.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/blkdebug.c b/block/blkdebug.c
index a5196e8..8b1401b 100644
--- a/block/blkdebug.c
+++ b/block/blkdebug.c
@@ -415,7 +415,8 @@ static int blkdebug_open(BlockDriverState *bs, QDict *options, int flags,
 
     bs->supported_write_flags = BDRV_REQ_FUA &
         bs->file->bs->supported_write_flags;
-    bs->supported_zero_flags = (BDRV_REQ_FUA | BDRV_REQ_MAY_UNMAP) &
+    bs->supported_zero_flags =
+        (BDRV_REQ_FUA | BDRV_REQ_MAY_UNMAP | BDRV_REQ_ALLOCATE) &
         bs->file->bs->supported_zero_flags;
     ret = -EINVAL;
 
-- 
2.7.4
