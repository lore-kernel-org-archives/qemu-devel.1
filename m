Received: from eggs.gnu.org ([2001:4830:134:3::10]:40314)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cbyee-0000MA-2q
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 19:01:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cbyea-0000rO-Ua
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 19:01:36 -0500
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:34024)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cbyea-0000rD-Pj
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 19:01:32 -0500
Received: by mail-pg0-x241.google.com with SMTP id v184so1523153pgv.1
	for <qemu-devel@nongnu.org>; Thu, 09 Feb 2017 16:01:32 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Fri, 10 Feb 2017 10:01:22 +1000
Message-Id: <20170210000122.4173-1-rth@twiddle.net>
In-Reply-To: <20170209045154.16868-1-rth@twiddle.net>
References: <20170209045154.16868-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH 23/22] linux-user: Honor CLONE_SETTLS for
 openrisc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: shorne@gmail.com

Threads work much better when you set the TLS register.
This was fixed in the upstream kernel for Linux 4.9.

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 linux-user/openrisc/target_cpu.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/linux-user/openrisc/target_cpu.h b/linux-user/openrisc/target_cpu.h
index a21ed1a..f283d96 100644
--- a/linux-user/openrisc/target_cpu.h
+++ b/linux-user/openrisc/target_cpu.h
@@ -30,9 +30,7 @@ static inline void cpu_clone_regs(CPUOpenRISCState *env, target_ulong newsp)
 
 static inline void cpu_set_tls(CPUOpenRISCState *env, target_ulong newtls)
 {
-    /* Linux kernel 3.10 does not pay any attention to CLONE_SETTLS
-     * in copy_thread(), so QEMU need not do so either.
-     */
+    env->gpr[10] = newtls;
 }
 
 #endif
-- 
2.9.3
