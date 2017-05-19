Received: from eggs.gnu.org ([2001:4830:134:3::10]:48247)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1dBeJY-0006k2-RU
	for qemu-devel@nongnu.org; Fri, 19 May 2017 05:35:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1dBeJV-0006n5-9g
	for qemu-devel@nongnu.org; Fri, 19 May 2017 05:35:16 -0400
Received: from mail-db5eur01on0136.outbound.protection.outlook.com
	([104.47.2.136]:35055
	helo=EUR01-DB5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <anton.nefedov@virtuozzo.com>)
	id 1dBeJV-0006mU-2s
	for qemu-devel@nongnu.org; Fri, 19 May 2017 05:35:13 -0400
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Date: Fri, 19 May 2017 12:34:32 +0300
Message-ID: <1495186480-114192-6-git-send-email-anton.nefedov@virtuozzo.com>
In-Reply-To: <1495186480-114192-1-git-send-email-anton.nefedov@virtuozzo.com>
References: <1495186480-114192-1-git-send-email-anton.nefedov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v1 05/13] qcow2: set inactive flag
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: den@virtuozzo.com, kwolf@redhat.com, mreitz@redhat.com, Anton Nefedov <anton.nefedov@virtuozzo.com>

Qcow2State and BlockDriverState flags have to be in sync

Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
---
 block/qcow2.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/qcow2.c b/block/qcow2.c
index 6e7ce96..07c1706 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -1939,6 +1939,7 @@ static int qcow2_inactivate(BlockDriverState *bs)
 
     if (result == 0) {
         qcow2_mark_clean(bs);
+        s->flags |= BDRV_O_INACTIVE;
     }
 
     return result;
-- 
2.7.4
