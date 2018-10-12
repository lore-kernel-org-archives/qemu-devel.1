Received: from eggs.gnu.org ([2001:4830:134:3::10]:54312)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gB0VM-0007h2-3F
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 12:41:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gB0VH-0002d1-4Y
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 12:41:36 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:46163 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gB0VG-0002bO-Su
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 12:41:31 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Fri, 12 Oct 2018 18:39:12 +0200
Message-Id: <1539362376-12010-5-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1539362376-12010-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1539362376-12010-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v5 04/28] linux-user: Add MIPS-specific prctl()
 options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: aurelien@aurel32.net, richard.henderson@linaro.org, amarkovic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com, laurent@vivier.eu, riku.voipio@iki.fi

From: Stefan Markovic <smarkovic@wavecomp.com>

Add MIPS-specific prctl() options TARGET_PR_SET_FP_MODE	and
TARGET_PR_SET_FP_MODE. These values are essentially copied from
linux kernel header include/uapi/linux/prctl.h.

This is done in a way consistent with a similar case of
aarch64-specific prctl() options TARGET_PR_SVE_SET_VL and
TARGET_PR_SVE_GET_VL.

Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 linux-user/mips/target_syscall.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/linux-user/mips/target_syscall.h b/linux-user/mips/target_syscall.h
index 2fca1c6..718680d 100644
--- a/linux-user/mips/target_syscall.h
+++ b/linux-user/mips/target_syscall.h
@@ -239,6 +239,10 @@ struct target_pt_regs {
 
 #define TARGET_FORCE_SHMLBA
 
+/* MIPS-specific prctl() options */
+#define TARGET_PR_SET_FP_MODE  45
+#define TARGET_PR_GET_FP_MODE  46
+
 static inline abi_ulong target_shmlba(CPUMIPSState *env)
 {
     return 0x40000;
-- 
2.7.4
