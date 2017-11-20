Received: from eggs.gnu.org ([2001:4830:134:3::10]:58095)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <riku.voipio@linaro.org>) id 1eGtVn-0004Te-1z
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 16:21:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <riku.voipio@linaro.org>) id 1eGtVl-0007eX-Uz
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 16:21:51 -0500
Received: from mail-lf0-x241.google.com ([2a00:1450:4010:c07::241]:45017)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <riku.voipio@linaro.org>)
	id 1eGtVl-0007eD-N3
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 16:21:49 -0500
Received: by mail-lf0-x241.google.com with SMTP id w23so11685540lfd.11
	for <qemu-devel@nongnu.org>; Mon, 20 Nov 2017 13:21:49 -0800 (PST)
From: riku.voipio@linaro.org
Date: Mon, 20 Nov 2017 23:21:30 +0200
Message-Id: <2da6e76ccaf5c5aad4192fddaa2062480ad82345.1511212753.git.riku.voipio@linaro.org>
In-Reply-To: <cover.1511212753.git.riku.voipio@linaro.org>
References: <cover.1511212753.git.riku.voipio@linaro.org>
Subject: [Qemu-devel] [PULL 02/15] linux-user/hppa: Fix TARGET_SA_* defines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>

From: Helge Deller <deller@gmx.de>

Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Helge Deller <deller@gmx.de>
Signed-off-by: Richard Henderson <rth@twiddle.net>
Signed-off-by: Riku Voipio <riku.voipio@linaro.org>
---
 linux-user/syscall_defs.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index e366183419..38339ecb9a 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -473,6 +473,14 @@ int do_sigaction(int sig, const struct target_sigaction *act,
 #define TARGET_SA_RESETHAND	0x00000010
 #define TARGET_SA_NOCLDWAIT	0x00000020 /* not supported yet */
 #define TARGET_SA_SIGINFO	0x00000040
+#elif defined(TARGET_HPPA)
+#define TARGET_SA_ONSTACK       0x00000001
+#define TARGET_SA_RESETHAND     0x00000004
+#define TARGET_SA_NOCLDSTOP     0x00000008
+#define TARGET_SA_SIGINFO       0x00000010
+#define TARGET_SA_NODEFER       0x00000020
+#define TARGET_SA_RESTART       0x00000040
+#define TARGET_SA_NOCLDWAIT     0x00000080
 #else
 #define TARGET_SA_NOCLDSTOP	0x00000001
 #define TARGET_SA_NOCLDWAIT	0x00000002 /* not supported yet */
-- 
2.14.2
