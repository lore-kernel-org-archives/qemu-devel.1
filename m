Received: from eggs.gnu.org ([2001:4830:134:3::10]:54097)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ePX1p-0007mp-Ih
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 12:10:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ePX1l-0006HV-Lf
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 12:10:37 -0500
From: Cornelia Huck <cohuck@redhat.com>
Date: Thu, 14 Dec 2017 18:09:23 +0100
Message-Id: <20171214171004.25058-6-cohuck@redhat.com>
In-Reply-To: <20171214171004.25058-1-cohuck@redhat.com>
References: <20171214171004.25058-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 05/46] target/s390x: nuke DPRINTF in helper.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, rth@twiddle.net, agraf@suse.de, thuth@redhat.com, borntraeger@de.ibm.com, david@redhat.com, Cornelia Huck <cohuck@redhat.com>

It is not used anywhere.

Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
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
