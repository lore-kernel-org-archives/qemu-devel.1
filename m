Received: from eggs.gnu.org ([2001:4830:134:3::10]:56463)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fqJle-0006CK-PO
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 11:00:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fqJlS-0001OD-Sp
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 11:00:46 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:45113 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1fqJlE-0000um-VG
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 11:00:33 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Thu, 16 Aug 2018 16:58:03 +0200
Message-Id: <1534431497-1385-71-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1534431497-1385-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1534431497-1385-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v9 70/84] linux-user: Add target_syscall.h
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

Add target_syscall.h header for nanoMIPS.

Signed-off-by: Aleksandar Rikalo <arikalo@wavecomp.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
---
 linux-user/nanomips/target_syscall.h | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)
 create mode 100644 linux-user/nanomips/target_syscall.h

diff --git a/linux-user/nanomips/target_syscall.h b/linux-user/nanomips/target_syscall.h
new file mode 100644
index 0000000..b40e36b
--- /dev/null
+++ b/linux-user/nanomips/target_syscall.h
@@ -0,0 +1,30 @@
+/* this struct defines the way the registers are stored on the
+   stack during a system call. */
+
+struct target_pt_regs {
+    /* Pad bytes for argument save space on the stack. */
+    abi_ulong pad0[6];
+
+    /* Saved main processor registers. */
+    abi_ulong regs[32];
+
+    /* Saved special registers. */
+    abi_ulong cp0_status;
+    abi_ulong lo;
+    abi_ulong hi;
+    abi_ulong cp0_badvaddr;
+    abi_ulong cp0_cause;
+    abi_ulong cp0_epc;
+};
+
+/* Nasty hack: define a fake errno value for use by sigreturn.  */
+#undef TARGET_QEMU_ESIGRETURN
+#define TARGET_QEMU_ESIGRETURN 255
+
+#define UNAME_MACHINE "nanomips"
+#define UNAME_MINIMUM_RELEASE "2.6.32"
+
+#define TARGET_CLONE_BACKWARDS
+#define TARGET_MINSIGSTKSZ 6144
+#define TARGET_MLOCKALL_MCL_CURRENT 1
+#define TARGET_MLOCKALL_MCL_FUTURE  2
-- 
2.7.4
