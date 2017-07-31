Received: from eggs.gnu.org ([2001:4830:134:3::10]:39385)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1dcDSk-0004nu-Hh
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 12:22:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1dcDSj-0005QA-HN
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 12:22:34 -0400
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Date: Mon, 31 Jul 2017 19:21:58 +0300
Message-Id: <1501518125-29851-7-git-send-email-anton.nefedov@virtuozzo.com>
In-Reply-To: <1501518125-29851-1-git-send-email-anton.nefedov@virtuozzo.com>
References: <1501518125-29851-1-git-send-email-anton.nefedov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v3 06/13] qcow2: set inactive flag
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, kwolf@redhat.com, mreitz@redhat.com, eblake@redhat.com, Anton Nefedov <anton.nefedov@virtuozzo.com>

Qcow2State and BlockDriverState flags have to be in sync

Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
---
 block/qcow2.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/qcow2.c b/block/qcow2.c
index 1939d9b..b11dc48 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -2135,6 +2135,7 @@ static int qcow2_inactivate(BlockDriverState *bs)
 
     if (result == 0) {
         qcow2_mark_clean(bs);
+        s->flags |= BDRV_O_INACTIVE;
     }
 
     return result;
-- 
2.7.4
