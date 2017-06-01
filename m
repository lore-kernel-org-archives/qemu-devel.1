Received: from eggs.gnu.org ([2001:4830:134:3::10]:51610)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1dGRod-0000Gk-5t
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 11:15:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1dGRoa-0004hZ-0U
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 11:15:11 -0400
Received: from mail-eopbgr40094.outbound.protection.outlook.com
	([40.107.4.94]:49888
	helo=EUR03-DB5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <anton.nefedov@virtuozzo.com>)
	id 1dGRoZ-0004fj-L4
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 11:15:07 -0400
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Date: Thu, 1 Jun 2017 18:14:25 +0300
Message-ID: <1496330073-51338-8-git-send-email-anton.nefedov@virtuozzo.com>
In-Reply-To: <1496330073-51338-1-git-send-email-anton.nefedov@virtuozzo.com>
References: <1496330073-51338-1-git-send-email-anton.nefedov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v2 07/15] qcow2: set inactive flag
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

Qcow2State and BlockDriverState flags have to be in sync

Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
---
 block/qcow2.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/qcow2.c b/block/qcow2.c
index c6fb714..b090833 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -1932,6 +1932,7 @@ static int qcow2_inactivate(BlockDriverState *bs)
 
     if (result == 0) {
         qcow2_mark_clean(bs);
+        s->flags |= BDRV_O_INACTIVE;
     }
 
     return result;
-- 
2.7.4
