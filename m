Received: from eggs.gnu.org ([2001:4830:134:3::10]:44582)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gCl2k-0001if-Bd
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 08:35:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gCl2h-0006eS-8P
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 08:35:18 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:39282 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gCl2g-0006cX-ST
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 08:35:15 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Wed, 17 Oct 2018 14:33:33 +0200
Message-Id: <1539779635-15445-6-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1539779635-15445-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1539779635-15445-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PULL 05/27] linux-user: Add MIPS-specific prctl()
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
Cc: peter.maydell@linaro.org

From: Stefan Markovic <smarkovic@wavecomp.com>

Add MIPS-specific prctl() options TARGET_PR_SET_FP_MODE	and
TARGET_PR_SET_FP_MODE. These values are essentially copied from
linux kernel header include/uapi/linux/prctl.h.

This is done in a way consistent with a similar case of
aarch64-specific prctl() options TARGET_PR_SVE_SET_VL and
TARGET_PR_SVE_GET_VL.

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 linux-user/mips/target_syscall.h   | 4 ++++
 linux-user/mips64/target_syscall.h | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/linux-user/mips/target_syscall.h b/linux-user/mips/target_syscall.h
index 2fca1c6..33177af 100644
--- a/linux-user/mips/target_syscall.h
+++ b/linux-user/mips/target_syscall.h
@@ -244,4 +244,8 @@ static inline abi_ulong target_shmlba(CPUMIPSState *env)
     return 0x40000;
 }
 
+/* MIPS-specific prctl() options */
+#define TARGET_PR_SET_FP_MODE  45
+#define TARGET_PR_GET_FP_MODE  46
+
 #endif /* MIPS_TARGET_SYSCALL_H */
diff --git a/linux-user/mips64/target_syscall.h b/linux-user/mips64/target_syscall.h
index 078437d..c1160e6 100644
--- a/linux-user/mips64/target_syscall.h
+++ b/linux-user/mips64/target_syscall.h
@@ -241,4 +241,8 @@ static inline abi_ulong target_shmlba(CPUMIPSState *env)
     return 0x40000;
 }
 
+/* MIPS-specific prctl() options */
+#define TARGET_PR_SET_FP_MODE  45
+#define TARGET_PR_GET_FP_MODE  46
+
 #endif /* MIPS64_TARGET_SYSCALL_H */
-- 
2.7.4
