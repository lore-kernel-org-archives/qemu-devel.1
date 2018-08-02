Received: from eggs.gnu.org ([2001:4830:134:3::10]:34604)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefan.markovic@rt-rk.com>) id 1flEof-0005V0-6c
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 10:43:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefan.markovic@rt-rk.com>) id 1flEod-0004oo-UL
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 10:43:01 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:55853 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefan.markovic@rt-rk.com>)
	id 1flEod-0004nm-MI
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 10:42:59 -0400
From: Stefan Markovic <stefan.markovic@rt-rk.com>
Date: Thu,  2 Aug 2018 16:16:55 +0200
Message-Id: <1533219424-7627-69-git-send-email-stefan.markovic@rt-rk.com>
In-Reply-To: <1533219424-7627-1-git-send-email-stefan.markovic@rt-rk.com>
References: <1533219424-7627-1-git-send-email-stefan.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v6 68/77] linux-user: Add target_cpu.h header
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
Cc: laurent@vivier.eu, riku.voipio@iki.fi, philippe.mathieu.daude@gmail.com, aurelien@aurel32.net, richard.henderson@linaro.org, amarkovic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com, pburton@wavecomp.com, arikalo@wavecomp.com

From: Dimitrije Nikolic <dnikolic@wavecomp.com>

Add target_cpu.h header for nanoMIPS.

Signed-off-by: Aleksandar Rikalo <arikalo@wavecomp.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
---
 linux-user/nanomips/target_cpu.h | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)
 create mode 100644 linux-user/nanomips/target_cpu.h

diff --git a/linux-user/nanomips/target_cpu.h b/linux-user/nanomips/target_cpu.h
new file mode 100644
index 0000000..bbb51de
--- /dev/null
+++ b/linux-user/nanomips/target_cpu.h
@@ -0,0 +1,21 @@
+#ifndef NANOMIPS_TARGET_CPU_H
+#define NANOMIPS_TARGET_CPU_H
+
+static inline void cpu_clone_regs(CPUMIPSState *env, target_ulong newsp)
+{
+    if (newsp) {
+        env->active_tc.gpr[29] = newsp;
+    }
+    env->active_tc.gpr[4] = 0;
+}
+
+static inline void cpu_set_tls(CPUMIPSState *env, target_ulong newtls)
+{
+    env->active_tc.CP0_UserLocal = newtls;
+}
+
+static inline abi_ulong get_sp_from_cpustate(CPUMIPSState *state)
+{
+    return state->active_tc.gpr[29];
+}
+#endif
-- 
1.9.1
