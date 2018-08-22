Received: from eggs.gnu.org ([2001:4830:134:3::10]:36503)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fsHk3-00073U-Va
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 21:15:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fsHjv-0001ui-2a
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 21:15:20 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:41147)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1fsHjs-0001rs-Nu
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 21:15:14 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Wed, 22 Aug 2018 03:14:11 +0200
Message-Id: <20180822011417.11608-2-laurent@vivier.eu>
In-Reply-To: <20180822011417.11608-1-laurent@vivier.eu>
References: <20180822011417.11608-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 1/7] linux-user: Remove DEBUG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>, Richard Henderson <richard.henderson@linaro.org>

From: Richard Henderson <richard.henderson@linaro.org>

This is redundant with both -strace and actual tracing.

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20180818190118.12911-2-richard.henderson@linaro.org>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/syscall.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 202aa777ad..2e45f854f7 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -163,7 +163,6 @@
  * (The one remaining unallocated bit is 0x1000 which used to be CLONE_PID.)
  */
 
-//#define DEBUG
 /* Define DEBUG_ERESTARTSYS to force every syscall to be restarted
  * once. This exercises the codepaths for restart.
  */
@@ -5884,9 +5883,6 @@ static abi_long do_ioctl(int fd, int cmd, abi_long arg)
         ie++;
     }
     arg_type = ie->arg_type;
-#if defined(DEBUG)
-    gemu_log("ioctl: cmd=0x%04lx (%s)\n", (long)cmd, ie->name);
-#endif
     if (ie->do_ioctl) {
         return ie->do_ioctl(ie, buf_temp, fd, cmd, arg);
     } else if (!ie->host_cmd) {
@@ -8132,9 +8128,6 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
     }
 #endif
 
-#ifdef DEBUG
-    gemu_log("syscall %d", num);
-#endif
     trace_guest_user_syscall(cpu, num, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
     if(do_strace)
         print_syscall(num, arg1, arg2, arg3, arg4, arg5, arg6);
@@ -12949,9 +12942,6 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
         break;
     }
 fail:
-#ifdef DEBUG
-    gemu_log(" = " TARGET_ABI_FMT_ld "\n", ret);
-#endif
     if(do_strace)
         print_syscall_ret(num, ret);
     trace_guest_user_syscall_ret(cpu, num, ret);
-- 
2.17.1
