Received: from eggs.gnu.org ([2001:4830:134:3::10]:48337)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fcm4V-0006ZP-HR
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 02:24:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fcm4R-0005ji-7O
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 02:24:23 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:49310)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1fcm4Q-0005hz-TD
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 02:24:19 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Tue, 10 Jul 2018 08:23:50 +0200
Message-Id: <20180710062352.9843-2-laurent@vivier.eu>
In-Reply-To: <20180710062352.9843-1-laurent@vivier.eu>
References: <20180710062352.9843-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 1/3] linux-user: Do not report "Unsupported
 syscall" by default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

This can still be reported using the "-d unimp" command line option.

Fixes: https://bugs.launchpad.net/qemu/+bug/1777226
Reported-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <20180706155127.7483-2-f4bug@amsat.org>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/syscall.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 5822e03e28..e4b1b7d7da 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -12757,7 +12757,7 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
 
     default:
     unimplemented:
-        gemu_log("qemu: Unsupported syscall: %d\n", num);
+        qemu_log_mask(LOG_UNIMP, "Unsupported syscall: %d\n", num);
 #if defined(TARGET_NR_setxattr) || defined(TARGET_NR_get_thread_area) || defined(TARGET_NR_getdomainname) || defined(TARGET_NR_set_robust_list)
     unimplemented_nowarn:
 #endif
-- 
2.17.1
