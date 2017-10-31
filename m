Received: from eggs.gnu.org ([2001:4830:134:3::10]:54227)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e9W42-0002Yg-Bc
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 08:54:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e9W3y-0005TL-6i
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 08:54:42 -0400
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:48434)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e9W3x-0005Rg-VZ
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 08:54:38 -0400
Received: by mail-wr0-x241.google.com with SMTP id 15so15849621wrb.5
	for <qemu-devel@nongnu.org>; Tue, 31 Oct 2017 05:54:37 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Tue, 31 Oct 2017 13:53:56 +0100
Message-Id: <20171031125358.23377-6-richard.henderson@linaro.org>
In-Reply-To: <20171031125358.23377-1-richard.henderson@linaro.org>
References: <20171031125358.23377-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 5/7] linux-user/hppa: Fix TARGET_MAP_TYPE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: riku.voipio@iki.fi, Helge Deller <deller@gmx.de>, Richard Henderson <rth@twiddle.net>

From: Helge Deller <deller@gmx.de>

TARGET_MAP_TYPE needs to be 0x03 instead of 0x0f on the hppa
architecture, otherwise it conflicts with MAP_FIXED which is 0x04.

Signed-off-by: Helge Deller <deller@gmx.de>
Signed-off-by: Richard Henderson <rth@twiddle.net>
Message-ID: <20170311175019.GA7195@ls3530.fritz.box>
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
2.13.6
