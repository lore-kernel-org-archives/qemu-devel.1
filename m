Received: from eggs.gnu.org ([2001:4830:134:3::10]:54420)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gB0Vd-0007uQ-LV
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 12:41:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gB0Vd-0002yK-01
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 12:41:53 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:46248 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gB0Vc-0002wg-Ob
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 12:41:52 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Fri, 12 Oct 2018 18:39:13 +0200
Message-Id: <1539362376-12010-6-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1539362376-12010-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1539362376-12010-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v5 05/28] linux-user: Add infrastructure for
 handling MIPS-specific prctl()
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

Add infrastructure for handling MIPS-specific prctl(). This is,
for now, just an empty placeholder. The real handling will be
implemented in subsequent patches.

Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 linux-user/syscall.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index ae3c0df..d2cc971 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -9347,6 +9347,14 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             return ret;
         }
 #endif
+#ifdef TARGET_MIPS
+        case TARGET_PR_GET_FP_MODE:
+            /* TODO: Implement TARGET_PR_SET_FP_MODE handling.*/
+            return -TARGET_EINVAL;
+        case TARGET_PR_SET_FP_MODE:
+            /* TODO: Implement TARGET_PR_GET_FP_MODE handling.*/
+            return -TARGET_EINVAL;
+#endif /* MIPS */
 #ifdef TARGET_AARCH64
         case TARGET_PR_SVE_SET_VL:
             /*
-- 
2.7.4
