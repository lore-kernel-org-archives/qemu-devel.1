Received: from eggs.gnu.org ([2001:4830:134:3::10]:52836)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fqfMe-0004nD-Fm
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 10:04:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fqfMX-0007a9-IU
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 10:04:31 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:44957 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1fqfMX-0007WV-1Y
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 10:04:25 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Fri, 17 Aug 2018 16:03:35 +0200
Message-Id: <1534514633-13725-48-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1534514633-13725-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1534514633-13725-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v10 47/65] linux-user: Add termbits.h header
 for nanoMIPS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, laurent@vivier.eu, riku.voipio@iki.fi, philippe.mathieu.daude@gmail.com, aurelien@aurel32.net, richard.henderson@linaro.org, amarkovic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com, pburton@wavecomp.com

From: Aleksandar Rikalo <arikalo@wavecomp.com>

Add termbits.h header for nanoMIPS. Reuse MIPS' termbits.h as
the functionalities are almost identical.

Signed-off-by: Aleksandar Rikalo <arikalo@wavecomp.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
---
 linux-user/mips/termbits.h     | 4 ++++
 linux-user/nanomips/termbits.h | 1 +
 2 files changed, 5 insertions(+)
 create mode 100644 linux-user/nanomips/termbits.h

diff --git a/linux-user/mips/termbits.h b/linux-user/mips/termbits.h
index 49a72c5..c7254f4 100644
--- a/linux-user/mips/termbits.h
+++ b/linux-user/mips/termbits.h
@@ -1,6 +1,10 @@
 /* from asm/termbits.h */
 
+#ifdef TARGET_NANOMIPS
+#define TARGET_NCCS 32
+#else
 #define TARGET_NCCS 23
+#endif
 
 struct target_termios {
     unsigned int c_iflag;               /* input mode flags */
diff --git a/linux-user/nanomips/termbits.h b/linux-user/nanomips/termbits.h
new file mode 100644
index 0000000..ea4e962
--- /dev/null
+++ b/linux-user/nanomips/termbits.h
@@ -0,0 +1 @@
+#include "../mips/termbits.h"
-- 
2.7.4
