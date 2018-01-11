Received: from eggs.gnu.org ([2001:4830:134:3::10]:34503)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1eZk2a-0004uN-Vk
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 16:05:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1eZk2a-0008VY-6D
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 16:05:36 -0500
Received: from mail-lf0-x244.google.com ([2a00:1450:4010:c07::244]:44314)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1eZk2Z-0008Uu-VO
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 16:05:36 -0500
Received: by mail-lf0-x244.google.com with SMTP id w23so3974252lfd.11
	for <qemu-devel@nongnu.org>; Thu, 11 Jan 2018 13:05:35 -0800 (PST)
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Thu, 11 Jan 2018 13:04:57 -0800
Message-Id: <1515704703-10347-4-git-send-email-jcmvbkbc@gmail.com>
In-Reply-To: <1515704703-10347-1-git-send-email-jcmvbkbc@gmail.com>
References: <1515704703-10347-1-git-send-email-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PATCH 3/9] target/xtensa: fix default sysrom/sysram
 addresses
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Max Filippov <jcmvbkbc@gmail.com>

noMMU configs had wrong sysrom and sysram base addresses, fix them.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 target/xtensa/overlay_tool.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/xtensa/overlay_tool.h b/target/xtensa/overlay_tool.h
index 12bde447961d..589dd6285089 100644
--- a/target/xtensa/overlay_tool.h
+++ b/target/xtensa/overlay_tool.h
@@ -342,24 +342,24 @@
     .dtlb = TLB_TEMPLATE
 
 #ifndef XCHAL_SYSROM0_PADDR
-#define XCHAL_SYSROM0_PADDR 0x60000000
+#define XCHAL_SYSROM0_PADDR 0x50000000
 #define XCHAL_SYSROM0_SIZE  0x04000000
 #endif
 
 #ifndef XCHAL_SYSRAM0_PADDR
-#define XCHAL_SYSRAM0_PADDR 0x50000000
+#define XCHAL_SYSRAM0_PADDR 0x60000000
 #define XCHAL_SYSRAM0_SIZE  0x04000000
 #endif
 
 #else
 
 #ifndef XCHAL_SYSROM0_PADDR
-#define XCHAL_SYSROM0_PADDR 0x60000000
+#define XCHAL_SYSROM0_PADDR 0x50000000
 #define XCHAL_SYSROM0_SIZE  0x04000000
 #endif
 
 #ifndef XCHAL_SYSRAM0_PADDR
-#define XCHAL_SYSRAM0_PADDR 0x50000000
+#define XCHAL_SYSRAM0_PADDR 0x60000000
 #define XCHAL_SYSRAM0_SIZE  0x04000000
 #endif
 
-- 
2.1.4
