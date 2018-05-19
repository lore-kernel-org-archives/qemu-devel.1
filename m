Received: from eggs.gnu.org ([2001:4830:134:3::10]:44355)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fJyCc-0008V6-Ap
	for qemu-devel@nongnu.org; Sat, 19 May 2018 05:31:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fJyCY-0003L7-E7
	for qemu-devel@nongnu.org; Sat, 19 May 2018 05:31:02 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:37683)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1fJyCY-0003Jd-4B
	for qemu-devel@nongnu.org; Sat, 19 May 2018 05:30:58 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Sat, 19 May 2018 11:29:53 +0200
Message-Id: <20180519092956.15134-6-laurent@vivier.eu>
In-Reply-To: <20180519092956.15134-1-laurent@vivier.eu>
References: <20180519092956.15134-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH v3 5/8] linux-user: move ppc socket.h
 definitions to ppc/sockbits.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Peter Maydell <peter.maydell@linaro.org>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Yongbok Kim <yongbok.kim@mips.com>, Riku Voipio <riku.voipio@iki.fi>, Richard Henderson <rth@twiddle.net>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

Change conditional #ifdef part by #undef of the symbols
redefined for PPC relative to generic/socket.h

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/generic/sockbits.h |  9 ---------
 linux-user/ppc/sockbits.h     | 25 +++++++++++++++++++++++++
 2 files changed, 25 insertions(+), 9 deletions(-)

diff --git a/linux-user/generic/sockbits.h b/linux-user/generic/sockbits.h
index 093faf0a48..99505f1f85 100644
--- a/linux-user/generic/sockbits.h
+++ b/linux-user/generic/sockbits.h
@@ -30,21 +30,12 @@
 #define TARGET_SO_LINGER       13
 #define TARGET_SO_BSDCOMPAT    14
 /* To add :#define TARGET_SO_REUSEPORT 15 */
-#if defined(TARGET_PPC)
-#define TARGET_SO_RCVLOWAT     16
-#define TARGET_SO_SNDLOWAT     17
-#define TARGET_SO_RCVTIMEO     18
-#define TARGET_SO_SNDTIMEO     19
-#define TARGET_SO_PASSCRED     20
-#define TARGET_SO_PEERCRED     21
-#else
 #define TARGET_SO_PASSCRED     16
 #define TARGET_SO_PEERCRED     17
 #define TARGET_SO_RCVLOWAT     18
 #define TARGET_SO_SNDLOWAT     19
 #define TARGET_SO_RCVTIMEO     20
 #define TARGET_SO_SNDTIMEO     21
-#endif
 
 /* Security levels - as per NRL IPv6 - don't actually do anything */
 #define TARGET_SO_SECURITY_AUTHENTICATION              22
diff --git a/linux-user/ppc/sockbits.h b/linux-user/ppc/sockbits.h
index 0e4c8f012d..ee453347a3 100644
--- a/linux-user/ppc/sockbits.h
+++ b/linux-user/ppc/sockbits.h
@@ -1 +1,26 @@
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation, or (at your option) any
+ * later version. See the COPYING file in the top-level directory.
+ */
+
+#ifndef PPC_SOCKBITS_H
+#define PPC_SOCKBITS_H
+
 #include "../generic/sockbits.h"
+
+#undef  TARGET_SO_RCVLOWAT
+#define TARGET_SO_RCVLOWAT     16
+#undef  TARGET_SO_SNDLOWAT
+#define TARGET_SO_SNDLOWAT     17
+#undef  TARGET_SO_RCVTIMEO
+#define TARGET_SO_RCVTIMEO     18
+#undef  TARGET_SO_SNDTIMEO
+#define TARGET_SO_SNDTIMEO     19
+#undef  TARGET_SO_PASSCRED
+#define TARGET_SO_PASSCRED     20
+#undef  TARGET_SO_PEERCRED
+#define TARGET_SO_PEERCRED     21
+
+#endif
-- 
2.14.3
