Received: from eggs.gnu.org ([209.51.188.92]:35642)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gguqS-00077L-4k
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 12:07:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gguqL-0004if-5Q
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 12:07:15 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Tue,  8 Jan 2019 20:06:47 +0300
Message-Id: <20190108170655.29766-2-vsementsov@virtuozzo.com>
In-Reply-To: <20190108170655.29766-1-vsementsov@virtuozzo.com>
References: <20190108170655.29766-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v3 1/9] qcow2.h: add missing include
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, berrange@redhat.com, berto@igalia.com, vsementsov@virtuozzo.com, den@openvz.org, pbonzini@redhat.com

qcow2.h depends on block_int.h. Compilation isn't broken currently only
due to block_int.h always included before qcow2.h. Though, it seems
better to directly include block_int.h in qcow2.h.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/qcow2.h          | 1 +
 block/qcow2-bitmap.c   | 1 -
 block/qcow2-cache.c    | 1 -
 block/qcow2-cluster.c  | 1 -
 block/qcow2-refcount.c | 1 -
 block/qcow2-snapshot.c | 1 -
 block/qcow2.c          | 1 -
 7 files changed, 1 insertion(+), 6 deletions(-)

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
diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
index accebef4cf..a12d458d7d 100644
--- a/block/qcow2-bitmap.c
+++ b/block/qcow2-bitmap.c
@@ -29,7 +29,6 @@
 #include "qapi/error.h"
 #include "qemu/cutils.h"
 
-#include "block/block_int.h"
 #include "qcow2.h"
 
 /* NOTICE: BME here means Bitmaps Extension and used as a namespace for
diff --git a/block/qcow2-cache.c b/block/qcow2-cache.c
index d9dafa31e5..00bbc4ce14 100644
--- a/block/qcow2-cache.c
+++ b/block/qcow2-cache.c
@@ -23,7 +23,6 @@
  */
 
 #include "qemu/osdep.h"
-#include "block/block_int.h"
 #include "qemu-common.h"
 #include "qcow2.h"
 #include "trace.h"
diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index e2737429f5..7815772116 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -27,7 +27,6 @@
 
 #include "qapi/error.h"
 #include "qemu-common.h"
-#include "block/block_int.h"
 #include "qcow2.h"
 #include "qemu/bswap.h"
 #include "trace.h"
diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
index 1c63ac244a..d4eee6d350 100644
--- a/block/qcow2-refcount.c
+++ b/block/qcow2-refcount.c
@@ -25,7 +25,6 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "qemu-common.h"
-#include "block/block_int.h"
 #include "qcow2.h"
 #include "qemu/range.h"
 #include "qemu/bswap.h"
diff --git a/block/qcow2-snapshot.c b/block/qcow2-snapshot.c
index bb6a5b7516..733656fa00 100644
--- a/block/qcow2-snapshot.c
+++ b/block/qcow2-snapshot.c
@@ -24,7 +24,6 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "block/block_int.h"
 #include "qcow2.h"
 #include "qemu/bswap.h"
 #include "qemu/error-report.h"
diff --git a/block/qcow2.c b/block/qcow2.c
index 4897abae5e..01789de3ef 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -27,7 +27,6 @@
 #define ZLIB_CONST
 #include <zlib.h>
 
-#include "block/block_int.h"
 #include "block/qdict.h"
 #include "sysemu/block-backend.h"
 #include "qemu/module.h"
-- 
2.18.0
