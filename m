Received: from eggs.gnu.org ([2001:4830:134:3::10]:43702)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dTfpo-0001aZ-Ld
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 22:51:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dTfpm-00053A-KN
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 22:51:04 -0400
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Fri,  7 Jul 2017 16:50:30 -1000
Message-Id: <20170708025030.15845-4-rth@twiddle.net>
In-Reply-To: <20170708025030.15845-1-rth@twiddle.net>
References: <20170708025030.15845-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH 3/3] linux-user/sh4: Reduce
 TARGET_VIRT_ADDR_SPACE_BITS to 31
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: riku.voipio@iki.fi, laurent@vivier.eu, qemu-arm@nongnu.org, aurelien@aurel32.net

The real kernel has TASK_SIZE as 0x7c000000, due to quirks with
a couple of SH parts.  But nominally user-space is limited to 2GB.

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/sh4/cpu.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/target/sh4/cpu.h b/target/sh4/cpu.h
index e3abb6a..3121d1e 100644
--- a/target/sh4/cpu.h
+++ b/target/sh4/cpu.h
@@ -45,7 +45,11 @@
 #define TARGET_PAGE_BITS 12	/* 4k XXXXX */
 
 #define TARGET_PHYS_ADDR_SPACE_BITS 32
-#define TARGET_VIRT_ADDR_SPACE_BITS 32
+#ifdef CONFIG_USER_ONLY
+# define TARGET_VIRT_ADDR_SPACE_BITS 31
+#else
+# define TARGET_VIRT_ADDR_SPACE_BITS 32
+#endif
 
 #define SR_MD 30
 #define SR_RB 29
-- 
2.9.4
