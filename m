Received: from eggs.gnu.org ([2001:4830:134:3::10]:42052)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gWl85-0001u4-C0
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 11:43:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gWl83-0004Jd-TI
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 11:43:29 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Tue, 11 Dec 2018 19:43:10 +0300
Message-Id: <20181211164317.32893-2-vsementsov@virtuozzo.com>
In-Reply-To: <20181211164317.32893-1-vsementsov@virtuozzo.com>
References: <20181211164317.32893-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v2 1/8] qcow2.h: add missing include
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, berrange@redhat.com, berto@igalia.com, vsementsov@virtuozzo.com, den@openvz.org

qcow2.h depends on block_int.h. Compilation isn't broken currently only
due to block_int.h always included before qcow2.h. Though, it seems
better to directly include block_int.h in qcow2.h.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/qcow2.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/qcow2.h b/block/qcow2.h
index a98d24500b..5095f893a0 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -28,6 +28,7 @@
 #include "crypto/block.h"
 #include "qemu/coroutine.h"
 #include "qemu/units.h"
+#include "block/block_int.h"
 
 //#define DEBUG_ALLOC
 //#define DEBUG_ALLOC2
-- 
2.18.0
