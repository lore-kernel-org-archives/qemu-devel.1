Received: from eggs.gnu.org ([2001:4830:134:3::10]:52699)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fJ3Tc-0000MZ-Ms
	for qemu-devel@nongnu.org; Wed, 16 May 2018 16:56:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fJ3TZ-00049T-Ku
	for qemu-devel@nongnu.org; Wed, 16 May 2018 16:56:48 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:43041)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1fJ3TZ-00048o-Cj
	for qemu-devel@nongnu.org; Wed, 16 May 2018 16:56:45 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Wed, 16 May 2018 22:55:43 +0200
Message-Id: <20180516205543.29305-9-laurent@vivier.eu>
In-Reply-To: <20180516205543.29305-1-laurent@vivier.eu>
References: <20180516205543.29305-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH v2 8/8] linux-user: define TARGET_SO_REUSEPORT
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Richard Henderson <rth@twiddle.net>, Yongbok Kim <yongbok.kim@mips.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/alpha/sockbits.h   | 2 +-
 linux-user/generic/sockbits.h | 2 +-
 linux-user/mips/sockbits.h    | 3 ---
 3 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/linux-user/alpha/sockbits.h b/linux-user/alpha/sockbits.h
index f5397dd875..d54dc98c09 100644
--- a/linux-user/alpha/sockbits.h
+++ b/linux-user/alpha/sockbits.h
@@ -18,7 +18,7 @@
 #define TARGET_SO_BROADCAST 0x0020
 #define TARGET_SO_LINGER    0x0080
 #define TARGET_SO_OOBINLINE 0x0100
-/* To add :#define TARGET_SO_REUSEPORT 0x0200 */
+#define TARGET_SO_REUSEPORT 0x0200
 
 #define TARGET_SO_TYPE      0x1008
 #define TARGET_SO_ERROR 0x1007
diff --git a/linux-user/generic/sockbits.h b/linux-user/generic/sockbits.h
index 5ad43eb0c8..c161f80626 100644
--- a/linux-user/generic/sockbits.h
+++ b/linux-user/generic/sockbits.h
@@ -29,7 +29,7 @@
 #define TARGET_SO_PRIORITY     12
 #define TARGET_SO_LINGER       13
 #define TARGET_SO_BSDCOMPAT    14
-/* To add :#define TARGET_SO_REUSEPORT 15 */
+#define TARGET_SO_REUSEPORT    15
 #ifndef TARGET_SO_PASSCRED /* powerpc only differs in these */
 #define TARGET_SO_PASSCRED     16
 #define TARGET_SO_PEERCRED     17
diff --git a/linux-user/mips/sockbits.h b/linux-user/mips/sockbits.h
index 370d13ed86..0f022cd598 100644
--- a/linux-user/mips/sockbits.h
+++ b/linux-user/mips/sockbits.h
@@ -28,10 +28,7 @@
                                         */
 #define TARGET_SO_OOBINLINE 0x0100     /* Receive out-of-band data in-band.
                                         */
-#if 0
-/* To add: Allow local address and port reuse. */
 #define TARGET_SO_REUSEPORT 0x0200
-#endif
 
 #define TARGET_SO_TYPE         0x1008  /* Compatible name for SO_STYLE. */
 #define TARGET_SO_STYLE        SO_TYPE /* Synonym */
-- 
2.14.3
