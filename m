Received: from eggs.gnu.org ([2001:4830:134:3::10]:50177)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dXYjh-00078w-Th
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 16:04:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dXYjf-0005Gi-4N
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 16:04:49 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:34372)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dXYjf-0005GX-04
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 16:04:47 -0400
Received: by mail-qt0-x243.google.com with SMTP id 19so3683754qty.1
	for <qemu-devel@nongnu.org>; Tue, 18 Jul 2017 13:04:46 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Tue, 18 Jul 2017 10:02:55 -1000
Message-Id: <20170718200255.31647-31-rth@twiddle.net>
In-Reply-To: <20170718200255.31647-1-rth@twiddle.net>
References: <20170718200255.31647-1-rth@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 30/30] linux-user/sh4: Reduce
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
Cc: aurelien@aurel32.net

The real kernel has TASK_SIZE as 0x7c000000, due to quirks with
a couple of SH parts.  But nominally user-space is limited to 2GB.

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
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
