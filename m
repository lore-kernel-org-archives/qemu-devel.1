Received: from eggs.gnu.org ([2001:4830:134:3::10]:55265)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cGGyu-0002pN-MO
	for qemu-devel@nongnu.org; Sun, 11 Dec 2016 22:08:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cGGyr-0003OR-IY
	for qemu-devel@nongnu.org; Sun, 11 Dec 2016 22:08:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37770)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cGGyr-0003OK-Ch
	for qemu-devel@nongnu.org; Sun, 11 Dec 2016 22:08:45 -0500
From: Peter Xu <peterx@redhat.com>
Date: Mon, 12 Dec 2016 11:08:12 +0800
Message-Id: <1481512100-10380-7-git-send-email-peterx@redhat.com>
In-Reply-To: <1481512100-10380-1-git-send-email-peterx@redhat.com>
References: <1481512100-10380-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [kvm-unit-tests PATCH v8 06/14] libcflat: moving
 MIN/MAX here
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, kvm@vger.kernel.org
Cc: drjones@redhat.com, agordeev@redhat.com, jan.kiszka@web.de, rkrcmar@redhat.com, pbonzini@redhat.com, peterx@redhat.com

That's something can be used outside alloc.c.

Reviewed-by: Andrew Jones <drjones@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 lib/alloc.c    | 3 ---
 lib/libcflat.h | 3 +++
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/alloc.c b/lib/alloc.c
index e1d7b8a..58af52b 100644
--- a/lib/alloc.c
+++ b/lib/alloc.c
@@ -7,9 +7,6 @@
 #include "asm/spinlock.h"
 #include "asm/io.h"
 
-#define MIN(a, b)		((a) < (b) ? (a) : (b))
-#define MAX(a, b)		((a) > (b) ? (a) : (b))
-
 #define PHYS_ALLOC_NR_REGIONS	256
 
 struct phys_alloc_region {
diff --git a/lib/libcflat.h b/lib/libcflat.h
index 88b10e2..94d2a53 100644
--- a/lib/libcflat.h
+++ b/lib/libcflat.h
@@ -40,6 +40,9 @@
 #define SZ_2M                  (1 << 21)
 #define SZ_1G                  (1 << 30)
 
+#define MIN(a, b)		((a) < (b) ? (a) : (b))
+#define MAX(a, b)		((a) > (b) ? (a) : (b))
+
 typedef uint8_t		u8;
 typedef int8_t		s8;
 typedef uint16_t	u16;
-- 
2.7.4
