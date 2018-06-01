Received: from eggs.gnu.org ([2001:4830:134:3::10]:57564)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fOeWx-0005fN-Kp
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 03:31:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fOeWw-0000ak-8C
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 03:31:23 -0400
Received: from mail-pl0-x242.google.com ([2607:f8b0:400e:c01::242]:35484)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fOeWv-0000Zu-W2
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 03:31:22 -0400
Received: by mail-pl0-x242.google.com with SMTP id i5-v6so14820540plt.2
	for <qemu-devel@nongnu.org>; Fri, 01 Jun 2018 00:31:21 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri,  1 Jun 2018 00:30:36 -0700
Message-Id: <20180601073050.8054-20-richard.henderson@linaro.org>
In-Reply-To: <20180601073050.8054-1-richard.henderson@linaro.org>
References: <20180601073050.8054-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 19/33] linux-user: Remove all unimplemented
 entries
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

There is no reason to list these, since -ENOSYS is the default.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall.c | 140 -------------------------------------------
 1 file changed, 140 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 88e0da31ba..6a701ea8f6 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -8460,14 +8460,6 @@ IMPL(everything_else)
     char *fn;
 
     switch(num) {
-#ifdef TARGET_NR_break
-    case TARGET_NR_break:
-        return do_unimplemented(num);
-#endif
-#ifdef TARGET_NR_oldstat
-    case TARGET_NR_oldstat:
-        return do_unimplemented(num);
-#endif
     case TARGET_NR_lseek:
         if (is_hostfd(arg1)) {
             return -TARGET_EBADF;
@@ -8555,16 +8547,10 @@ IMPL(everything_else)
             return get_errno(stime(&host_time));
         }
 #endif
-    case TARGET_NR_ptrace:
-        return do_unimplemented(num);
 #ifdef TARGET_NR_alarm /* not on alpha */
     case TARGET_NR_alarm:
         return alarm(arg1);
 #endif
-#ifdef TARGET_NR_oldfstat
-    case TARGET_NR_oldfstat:
-        return do_unimplemented(num);
-#endif
 #ifdef TARGET_NR_pause /* not on alpha */
     case TARGET_NR_pause:
         if (!block_signals()) {
@@ -8640,14 +8626,6 @@ IMPL(everything_else)
         }
         return ret;
 #endif
-#ifdef TARGET_NR_stty
-    case TARGET_NR_stty:
-        return do_unimplemented(num);
-#endif
-#ifdef TARGET_NR_gtty
-    case TARGET_NR_gtty:
-        return do_unimplemented(num);
-#endif
 #ifdef TARGET_NR_access
     case TARGET_NR_access:
         if (!(fn = lock_user_string(arg1))) {
@@ -8678,10 +8656,6 @@ IMPL(everything_else)
 #ifdef TARGET_NR_nice /* not on alpha */
     case TARGET_NR_nice:
         return get_errno(nice(arg1));
-#endif
-#ifdef TARGET_NR_ftime
-    case TARGET_NR_ftime:
-        return do_unimplemented(num);
 #endif
     case TARGET_NR_sync:
         sync();
@@ -8805,14 +8779,6 @@ IMPL(everything_else)
                 ret = host_to_target_clock_t(ret);
         }
         return ret;
-#ifdef TARGET_NR_prof
-    case TARGET_NR_prof:
-        return do_unimplemented(num);
-#endif
-#ifdef TARGET_NR_signal
-    case TARGET_NR_signal:
-        return do_unimplemented(num);
-#endif
     case TARGET_NR_acct:
         if (arg1 == 0) {
             ret = get_errno(acct(NULL));
@@ -8832,31 +8798,15 @@ IMPL(everything_else)
         ret = get_errno(umount2(p, arg2));
         unlock_user(p, arg1, 0);
         return ret;
-#endif
-#ifdef TARGET_NR_lock
-    case TARGET_NR_lock:
-        return do_unimplemented(num);
 #endif
     case TARGET_NR_ioctl:
         return do_ioctl(arg1, arg2, arg3);
 #ifdef TARGET_NR_fcntl
     case TARGET_NR_fcntl:
         return do_fcntl(arg1, arg2, arg3);
-#endif
-#ifdef TARGET_NR_mpx
-    case TARGET_NR_mpx:
-        return do_unimplemented(num);
 #endif
     case TARGET_NR_setpgid:
         return get_errno(setpgid(arg1, arg2));
-#ifdef TARGET_NR_ulimit
-    case TARGET_NR_ulimit:
-        return do_unimplemented(num);
-#endif
-#ifdef TARGET_NR_oldolduname
-    case TARGET_NR_oldolduname:
-        return do_unimplemented(num);
-#endif
     case TARGET_NR_umask:
         return get_errno(umask(arg1));
     case TARGET_NR_chroot:
@@ -8865,10 +8815,6 @@ IMPL(everything_else)
         ret = get_errno(chroot(p));
         unlock_user(p, arg1, 0);
         return ret;
-#ifdef TARGET_NR_ustat
-    case TARGET_NR_ustat:
-        return do_unimplemented(num);
-#endif
 #ifdef TARGET_NR_dup2
     case TARGET_NR_dup2:
         if (is_hostfd(arg1) || is_hostfd(arg2)) {
@@ -9585,10 +9531,6 @@ IMPL(everything_else)
         }
         return ret;
 #endif
-#ifdef TARGET_NR_oldlstat
-    case TARGET_NR_oldlstat:
-        return do_unimplemented(num);
-#endif
 #ifdef TARGET_NR_readlink
     case TARGET_NR_readlink:
         {
@@ -9650,10 +9592,6 @@ IMPL(everything_else)
         }
         return ret;
 #endif
-#ifdef TARGET_NR_uselib
-    case TARGET_NR_uselib:
-        return do_unimplemented(num);
-#endif
 #ifdef TARGET_NR_swapon
     case TARGET_NR_swapon:
         if (!(p = lock_user_string(arg1)))
@@ -9675,10 +9613,6 @@ IMPL(everything_else)
            ret = get_errno(reboot(arg1, arg2, arg3, NULL));
         }
         return ret;
-#ifdef TARGET_NR_readdir
-    case TARGET_NR_readdir:
-        return do_unimplemented(num);
-#endif
 #ifdef TARGET_NR_mmap
     case TARGET_NR_mmap:
 #if (defined(TARGET_I386) && defined(TARGET_ABI32)) || \
@@ -9813,10 +9747,6 @@ IMPL(everything_else)
         return ret;
     case TARGET_NR_setpriority:
         return get_errno(setpriority(arg1, arg2, arg3));
-#ifdef TARGET_NR_profil
-    case TARGET_NR_profil:
-        return do_unimplemented(num);
-#endif
     case TARGET_NR_statfs:
         if (!(fn = lock_user_string(arg1))) {
             return -TARGET_EFAULT;
@@ -9892,10 +9822,6 @@ IMPL(everything_else)
         ret = get_errno(fstatfs(arg1, &stfs));
         goto convert_statfs64;
 #endif
-#ifdef TARGET_NR_ioperm
-    case TARGET_NR_ioperm:
-        return do_unimplemented(num);
-#endif
 #ifdef TARGET_NR_socketcall
     case TARGET_NR_socketcall:
         return do_socketcall(arg1, arg2);
@@ -10173,20 +10099,8 @@ IMPL(everything_else)
             }
         }
         return ret;
-#ifdef TARGET_NR_olduname
-    case TARGET_NR_olduname:
-        return do_unimplemented(num);
-#endif
-#ifdef TARGET_NR_iopl
-    case TARGET_NR_iopl:
-        return do_unimplemented(num);
-#endif
     case TARGET_NR_vhangup:
         return get_errno(vhangup());
-#ifdef TARGET_NR_idle
-    case TARGET_NR_idle:
-        return do_unimplemented(num);
-#endif
 #ifdef TARGET_NR_syscall
     case TARGET_NR_syscall:
         return do_syscall(cpu_env, arg1 & 0xffff, arg2, arg3, arg4, arg5,
@@ -10364,8 +10278,6 @@ IMPL(everything_else)
     case TARGET_NR_modify_ldt:
         return do_modify_ldt(cpu_env, arg1, arg2, arg3);
 #if !defined(TARGET_X86_64)
-    case TARGET_NR_vm86old:
-        return do_unimplemented(num);
     case TARGET_NR_vm86:
         return do_vm86(cpu_env, arg1, arg2);
 #endif
@@ -10402,17 +10314,6 @@ IMPL(everything_else)
         }
         return ret;
 #endif
-#ifdef TARGET_NR_create_module
-    case TARGET_NR_create_module:
-#endif
-    case TARGET_NR_init_module:
-    case TARGET_NR_delete_module:
-#ifdef TARGET_NR_get_kernel_syms
-    case TARGET_NR_get_kernel_syms:
-#endif
-        return do_unimplemented(num);
-    case TARGET_NR_quotactl:
-        return do_unimplemented(num);
     case TARGET_NR_getpgid:
         return get_errno(getpgid(arg1));
     case TARGET_NR_fchdir:
@@ -10420,20 +10321,8 @@ IMPL(everything_else)
             return -TARGET_EBADF;
         }
         return get_errno(fchdir(arg1));
-#ifdef TARGET_NR_bdflush /* not on x86_64 */
-    case TARGET_NR_bdflush:
-        return do_unimplemented(num);
-#endif
-#ifdef TARGET_NR_sysfs
-    case TARGET_NR_sysfs:
-        return do_unimplemented(num);
-#endif
     case TARGET_NR_personality:
         return get_errno(personality(arg1));
-#ifdef TARGET_NR_afs_syscall
-    case TARGET_NR_afs_syscall:
-        return do_unimplemented(num);
-#endif
 #ifdef TARGET_NR__llseek /* Not on alpha */
     case TARGET_NR__llseek:
         if (is_hostfd(arg1)) {
@@ -10975,14 +10864,6 @@ IMPL(everything_else)
             }
         }
         return ret;
-#ifdef TARGET_NR_query_module
-    case TARGET_NR_query_module:
-        return do_unimplemented(num);
-#endif
-#ifdef TARGET_NR_nfsservctl
-    case TARGET_NR_nfsservctl:
-        return do_unimplemented(num);
-#endif
     case TARGET_NR_prctl:
         switch (arg1) {
         case PR_GET_PDEATHSIG:
@@ -11223,21 +11104,6 @@ IMPL(everything_else)
         return ret;
     }
 #endif
-#else
-    case TARGET_NR_sendfile:
-#ifdef TARGET_NR_sendfile64
-    case TARGET_NR_sendfile64:
-#endif
-        return do_unimplemented(num);
-#endif
-
-#ifdef TARGET_NR_getpmsg
-    case TARGET_NR_getpmsg:
-        return do_unimplemented(num);
-#endif
-#ifdef TARGET_NR_putpmsg
-    case TARGET_NR_putpmsg:
-        return do_unimplemented(num);
 #endif
 #ifdef TARGET_NR_vfork
     case TARGET_NR_vfork:
@@ -11801,8 +11667,6 @@ IMPL(everything_else)
         return get_errno(setfsgid(arg1));
 #endif
 
-    case TARGET_NR_pivot_root:
-        return do_unimplemented(num);
 #ifdef TARGET_NR_mincore
     case TARGET_NR_mincore:
         {
@@ -11972,10 +11836,6 @@ IMPL(everything_else)
         /* self-modifying code is handled automatically, so nothing needed */
         return 0;
 #endif
-#ifdef TARGET_NR_security
-    case TARGET_NR_security:
-        return do_unimplemented(num);
-#endif
 #ifdef TARGET_NR_getpagesize
     case TARGET_NR_getpagesize:
         return TARGET_PAGE_SIZE;
-- 
2.17.0
