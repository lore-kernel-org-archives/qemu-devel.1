Received: from eggs.gnu.org ([2001:4830:134:3::10]:54107)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e9W3g-0002Lz-Tj
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 08:54:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e9W3g-00059U-1d
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 08:54:20 -0400
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:54617)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e9W3f-00058q-R0
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 08:54:19 -0400
Received: by mail-wr0-x243.google.com with SMTP id o44so15815789wrf.11
	for <qemu-devel@nongnu.org>; Tue, 31 Oct 2017 05:54:19 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Tue, 31 Oct 2017 13:53:53 +0100
Message-Id: <20171031125358.23377-3-richard.henderson@linaro.org>
In-Reply-To: <20171031125358.23377-1-richard.henderson@linaro.org>
References: <20171031125358.23377-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 2/7] linux-user/hppa: Fix TARGET_SA_* defines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: riku.voipio@iki.fi, Helge Deller <deller@gmx.de>, Richard Henderson <rth@twiddle.net>

From: Helge Deller <deller@gmx.de>

Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Helge Deller <deller@gmx.de>
Signed-off-by: Richard Henderson <rth@twiddle.net>
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
2.13.6
