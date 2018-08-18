Received: from eggs.gnu.org ([2001:4830:134:3::10]:55158)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fr6TX-0005Em-Re
	for qemu-devel@nongnu.org; Sat, 18 Aug 2018 15:01:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fr6TT-000746-GT
	for qemu-devel@nongnu.org; Sat, 18 Aug 2018 15:01:27 -0400
Received: from mail-pl0-x230.google.com ([2607:f8b0:400e:c01::230]:46170)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fr6TT-00073a-3l
	for qemu-devel@nongnu.org; Sat, 18 Aug 2018 15:01:23 -0400
Received: by mail-pl0-x230.google.com with SMTP id a4-v6so1668500plm.13
	for <qemu-devel@nongnu.org>; Sat, 18 Aug 2018 12:01:23 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat, 18 Aug 2018 12:01:03 -0700
Message-Id: <20180818190118.12911-2-richard.henderson@linaro.org>
In-Reply-To: <20180818190118.12911-1-richard.henderson@linaro.org>
References: <20180818190118.12911-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v4 01/16] linux-user: Remove DEBUG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu

This is redundant with both -strace and actual tracing.

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index bb42a225eb..6cd9b33a0d 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -163,7 +163,6 @@
  * (The one remaining unallocated bit is 0x1000 which used to be CLONE_PID.)
  */
 
-//#define DEBUG
 /* Define DEBUG_ERESTARTSYS to force every syscall to be restarted
  * once. This exercises the codepaths for restart.
  */
@@ -5778,9 +5777,6 @@ static abi_long do_ioctl(int fd, int cmd, abi_long arg)
         ie++;
     }
     arg_type = ie->arg_type;
-#if defined(DEBUG)
-    gemu_log("ioctl: cmd=0x%04lx (%s)\n", (long)cmd, ie->name);
-#endif
     if (ie->do_ioctl) {
         return ie->do_ioctl(ie, buf_temp, fd, cmd, arg);
     } else if (!ie->host_cmd) {
@@ -8026,9 +8022,6 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
     }
 #endif
 
-#ifdef DEBUG
-    gemu_log("syscall %d", num);
-#endif
     trace_guest_user_syscall(cpu, num, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
     if(do_strace)
         print_syscall(num, arg1, arg2, arg3, arg4, arg5, arg6);
@@ -12843,9 +12836,6 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
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
