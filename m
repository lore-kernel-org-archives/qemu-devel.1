Received: from eggs.gnu.org ([209.51.188.92]:49555)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hBLTl-0001eR-TT
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 11:37:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hBLTk-0000V2-L9
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 11:37:37 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Tue,  2 Apr 2019 18:37:22 +0300
Message-Id: <20190402153730.54145-3-vsementsov@virtuozzo.com>
In-Reply-To: <20190402153730.54145-1-vsementsov@virtuozzo.com>
References: <20190402153730.54145-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v5 02/10] qcow2.h: add missing include
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, berto@igalia.com, pbonzini@redhat.com, vsementsov@virtuozzo.com, den@openvz.org, berrange@redhat.com

qcow2.h depends on block_int.h. Compilation isn't broken currently only
due to block_int.h always included before qcow2.h. Though, it seems
better to directly include block_int.h in qcow2.h.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
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
index fdee297f33..ecb026e19a 100644
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
index e53a1609d7..337c0ac680 100644
--- a/block/qcow2-bitmap.c
+++ b/block/qcow2-bitmap.c
@@ -29,7 +29,6 @@
 #include "qapi/error.h"
 #include "qemu/cutils.h"
 
-#include "block/block_int.h"
 #include "qcow2.h"
 
 /* NOTICE: BME here means Bitmaps Extension and used as a namespace for
diff --git a/block/qcow2-cache.c b/block/qcow2-cache.c
index df02e7b20a..b33bcbc984 100644
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
index 974a4e8656..c4965479f6 100644
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
index e0fe322500..ff27b6afd3 100644
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
index a6ffae89a6..d0e7fa9311 100644
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
index d507ee0686..7c68a5b5f9 100644
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
