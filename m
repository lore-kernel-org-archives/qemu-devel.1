Received: from eggs.gnu.org ([2001:4830:134:3::10]:46934)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eKPTK-0001hi-9c
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 09:05:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eKPTE-0000hE-OD
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 09:05:50 -0500
From: Cornelia Huck <cohuck@redhat.com>
Date: Thu, 30 Nov 2017 15:05:36 +0100
Message-Id: <20171130140536.31164-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PATCH] target/s390x: nuke DPRINTF in helper.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: rth@twiddle.net, agraf@suse.de, borntraeger@de.ibm.com, david@redhat.com, thuth@redhat.com, Cornelia Huck <cohuck@redhat.com>

It is not used anywhere.

Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/s390x/helper.c | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/target/s390x/helper.c b/target/s390x/helper.c
index 246ba20f0d..35d9741918 100644
--- a/target/s390x/helper.c
+++ b/target/s390x/helper.c
@@ -31,24 +31,6 @@
 #include "sysemu/sysemu.h"
 #endif
 
-//#define DEBUG_S390
-//#define DEBUG_S390_STDOUT
-
-#ifdef DEBUG_S390
-#ifdef DEBUG_S390_STDOUT
-#define DPRINTF(fmt, ...) \
-    do { fprintf(stderr, fmt, ## __VA_ARGS__); \
-         if (qemu_log_separate()) qemu_log(fmt, ##__VA_ARGS__); } while (0)
-#else
-#define DPRINTF(fmt, ...) \
-    do { qemu_log(fmt, ## __VA_ARGS__); } while (0)
-#endif
-#else
-#define DPRINTF(fmt, ...) \
-    do { } while (0)
-#endif
-
-
 #ifndef CONFIG_USER_ONLY
 void s390x_tod_timer(void *opaque)
 {
-- 
2.13.6
