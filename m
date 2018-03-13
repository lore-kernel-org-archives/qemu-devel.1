Received: from eggs.gnu.org ([2001:4830:134:3::10]:55195)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1evnoU-0008NH-IM
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 13:34:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1evnoR-0007gs-W6
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 13:34:14 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:51583)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1evnoR-0007ff-MW
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 13:34:11 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Tue, 13 Mar 2018 18:33:39 +0100
Message-Id: <20180313173355.4468-3-laurent@vivier.eu>
In-Reply-To: <20180313173355.4468-1-laurent@vivier.eu>
References: <20180313173355.4468-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PULL 02/18] linux-user: Remove the unused "not
 implemented" signal handling stubs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Riku Voipio <riku.voipio@iki.fi>, Peter Maydell <peter.maydell@linaro.org>

From: Peter Maydell <peter.maydell@linaro.org>

Now we've dropped unicore32, all of the architectures we support
for linux-user implement the signal handling routines. The
dummy "just print a message" versions are unimplemented, so we
can drop them entirely.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20180308144733.25615-3-peter.maydell@linaro.org>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/signal.c | 27 +--------------------------
 1 file changed, 1 insertion(+), 26 deletions(-)

diff --git a/linux-user/signal.c b/linux-user/signal.c
index 3a5bd2732a..513bc7e1ed 100644
--- a/linux-user/signal.c
+++ b/linux-user/signal.c
@@ -6772,32 +6772,7 @@ long do_rt_sigreturn(CPUArchState *env)
 }
 
 #else
-
-static void setup_frame(int sig, struct target_sigaction *ka,
-                        target_sigset_t *set, CPUArchState *env)
-{
-    fprintf(stderr, "setup_frame: not implemented\n");
-}
-
-static void setup_rt_frame(int sig, struct target_sigaction *ka,
-                           target_siginfo_t *info,
-                           target_sigset_t *set, CPUArchState *env)
-{
-    fprintf(stderr, "setup_rt_frame: not implemented\n");
-}
-
-long do_sigreturn(CPUArchState *env)
-{
-    fprintf(stderr, "do_sigreturn: not implemented\n");
-    return -TARGET_ENOSYS;
-}
-
-long do_rt_sigreturn(CPUArchState *env)
-{
-    fprintf(stderr, "do_rt_sigreturn: not implemented\n");
-    return -TARGET_ENOSYS;
-}
-
+#error Target needs to add support for signal handling
 #endif
 
 static void handle_pending_signal(CPUArchState *cpu_env, int sig,
-- 
2.14.3
