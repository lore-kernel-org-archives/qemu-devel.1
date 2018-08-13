Received: from eggs.gnu.org ([2001:4830:134:3::10]:59777)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fpH3F-0005iV-Q2
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 13:54:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fpH38-0007CP-5y
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 13:54:45 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:55831 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1fpH37-00079a-Hs
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 13:54:37 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Mon, 13 Aug 2018 19:53:33 +0200
Message-Id: <1534182832-554-69-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1534182832-554-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1534182832-554-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v8 68/87] linux-user: Add target_signal.h
 header for nanoMIPS
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

nanoMIPS signal handling is much closer to the signal handling in
other mainstream platforms than to the signal handling in preceding
MIPS platforms.

Signed-off-by: Aleksandar Rikalo <arikalo@wavecomp.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
---
 linux-user/nanomips/target_signal.h | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)
 create mode 100644 linux-user/nanomips/target_signal.h

diff --git a/linux-user/nanomips/target_signal.h b/linux-user/nanomips/target_signal.h
new file mode 100644
index 0000000..604e853
--- /dev/null
+++ b/linux-user/nanomips/target_signal.h
@@ -0,0 +1,22 @@
+#ifndef NANOMIPS_TARGET_SIGNAL_H
+#define NANOMIPS_TARGET_SIGNAL_H
+
+#include "../generic/signal.h"
+#undef TARGET_SIGRTMIN
+#define TARGET_SIGRTMIN       35
+
+/* this struct defines a stack used during syscall handling */
+typedef struct target_sigaltstack {
+    abi_long ss_sp;
+    abi_ulong ss_size;
+    abi_long ss_flags;
+} target_stack_t;
+
+/* sigaltstack controls */
+#define TARGET_SS_ONSTACK     1
+#define TARGET_SS_DISABLE     2
+
+#define TARGET_MINSIGSTKSZ    6144
+#define TARGET_SIGSTKSZ       12288
+
+#endif
-- 
2.7.4
