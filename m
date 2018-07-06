Received: from eggs.gnu.org ([2001:4830:134:3::10]:33626)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fbT1S-0002bp-AZ
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 11:51:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fbT1R-0000aT-DM
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 11:51:50 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri,  6 Jul 2018 12:51:25 -0300
Message-Id: <20180706155127.7483-2-f4bug@amsat.org>
In-Reply-To: <20180706155127.7483-1-f4bug@amsat.org>
References: <20180706155127.7483-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH for-3.0 1/3] linux-user: Do not report
 "Unsupported syscall" by default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, Riku Voipio <riku.voipio@iki.fi>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Peter Maydell <peter.maydell@linaro.org>, qemu-trivial@nongnu.org

This can still be reported using the "-d unimp" command line option.

Fixes: https://bugs.launchpad.net/qemu/+bug/1777226
Reported-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
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
2.18.0
