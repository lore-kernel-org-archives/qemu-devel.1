Received: from eggs.gnu.org ([2001:4830:134:3::10]:59274)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fSXXZ-00051u-79
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 20:52:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fSXXW-0007KG-Tt
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 20:52:05 -0400
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:42170)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fSXXW-0007Ji-O3
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 20:52:02 -0400
Received: by mail-pf0-x244.google.com with SMTP id w7-v6so11133547pfn.9
	for <qemu-devel@nongnu.org>; Mon, 11 Jun 2018 17:52:02 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 11 Jun 2018 14:51:31 -1000
Message-Id: <20180612005145.3375-6-richard.henderson@linaro.org>
In-Reply-To: <20180612005145.3375-1-richard.henderson@linaro.org>
References: <20180612005145.3375-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 05/19] linux-user: Remove DEBUG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu, peter.maydell@linaro.org

This is redundant with both -strace and actual tracing.

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 7b9ac3b408..c212149245 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -163,7 +163,6 @@
  * (The one remaining unallocated bit is 0x1000 which used to be CLONE_PID.)
  */
 
-//#define DEBUG
 /* Define DEBUG_ERESTARTSYS to force every syscall to be restarted
  * once. This exercises the codepaths for restart.
  */
@@ -5777,9 +5776,6 @@ static abi_long do_ioctl(int fd, int cmd, abi_long arg)
         ie++;
     }
     arg_type = ie->arg_type;
-#if defined(DEBUG)
-    gemu_log("ioctl: cmd=0x%04lx (%s)\n", (long)cmd, ie->name);
-#endif
     if (ie->do_ioctl) {
         return ie->do_ioctl(ie, buf_temp, fd, cmd, arg);
     } else if (!ie->host_cmd) {
@@ -7980,9 +7976,6 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
     }
 #endif
 
-#ifdef DEBUG
-    gemu_log("syscall %d", num);
-#endif
     trace_guest_user_syscall(cpu, num, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
     if(do_strace)
         print_syscall(num, arg1, arg2, arg3, arg4, arg5, arg6);
@@ -12772,9 +12765,6 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
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
