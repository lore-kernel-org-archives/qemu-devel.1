Received: from eggs.gnu.org ([2001:4830:134:3::10]:39845)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fkB5P-0007fj-9l
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 12:31:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fkB5O-0004rb-CU
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 12:31:55 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:50018 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1fkB5O-0004rC-5B
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 12:31:54 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Mon, 30 Jul 2018 18:12:42 +0200
Message-Id: <1532967169-22265-70-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1532967169-22265-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1532967169-22265-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v5 69/76] linux-user: Add target_cpu.h header
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
Cc: laurent@vivier.eu, riku.voipio@iki.fi, philippe.mathieu.daude@gmail.com, aurelien@aurel32.net, richard.henderson@linaro.org, amarkovic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com, pburton@wavecomp.com

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
2.7.4
