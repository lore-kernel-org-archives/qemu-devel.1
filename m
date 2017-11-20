Received: from eggs.gnu.org ([2001:4830:134:3::10]:58156)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <riku.voipio@linaro.org>) id 1eGtVr-0004Xp-3L
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 16:21:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <riku.voipio@linaro.org>) id 1eGtVq-0007lu-CK
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 16:21:55 -0500
Received: from mail-lf0-x241.google.com ([2a00:1450:4010:c07::241]:33260)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <riku.voipio@linaro.org>)
	id 1eGtVq-0007jO-4d
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 16:21:54 -0500
Received: by mail-lf0-x241.google.com with SMTP id x68so11726863lff.0
	for <qemu-devel@nongnu.org>; Mon, 20 Nov 2017 13:21:54 -0800 (PST)
From: riku.voipio@linaro.org
Date: Mon, 20 Nov 2017 23:21:33 +0200
Message-Id: <e65be6a7cfe5c991d97ef259c6a88e99ca65e875.1511212753.git.riku.voipio@linaro.org>
In-Reply-To: <cover.1511212753.git.riku.voipio@linaro.org>
References: <cover.1511212753.git.riku.voipio@linaro.org>
Subject: [Qemu-devel] [PULL 05/15] linux-user/hppa: Fix TARGET_MAP_TYPE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>

From: Helge Deller <deller@gmx.de>

TARGET_MAP_TYPE needs to be 0x03 instead of 0x0f on the hppa
architecture, otherwise it conflicts with MAP_FIXED which is 0x04.

Signed-off-by: Helge Deller <deller@gmx.de>
Signed-off-by: Richard Henderson <rth@twiddle.net>
Message-ID: <20170311175019.GA7195@ls3530.fritz.box>
Signed-off-by: Riku Voipio <riku.voipio@linaro.org>
---
 linux-user/syscall_defs.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index 38339ecb9a..a6ed30d70e 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -1336,7 +1336,11 @@ struct target_winsize {
 /* Common */
 #define TARGET_MAP_SHARED	0x01		/* Share changes */
 #define TARGET_MAP_PRIVATE	0x02		/* Changes are private */
-#define TARGET_MAP_TYPE		0x0f		/* Mask for type of mapping */
+#if defined(TARGET_HPPA)
+#define TARGET_MAP_TYPE         0x03		/* Mask for type of mapping */
+#else
+#define TARGET_MAP_TYPE         0x0f		/* Mask for type of mapping */
+#endif
 
 /* Target specific */
 #if defined(TARGET_MIPS)
-- 
2.14.2
