Return-Path: <SRS0=v56/=TT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B3A8C04AB4
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 21:34:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E16920578
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 21:34:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lpvANjtS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E16920578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53972 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSTRy-0001mM-9F
	for qemu-devel@archiver.kernel.org; Sun, 19 May 2019 17:34:34 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51167)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hSSa8-000451-EZ
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:38:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hSSa6-00052U-PZ
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:38:56 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:39719)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hSSa6-00051F-H0
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:38:54 -0400
Received: by mail-pf1-x444.google.com with SMTP id z26so6167808pfg.6
	for <qemu-devel@nongnu.org>; Sun, 19 May 2019 13:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=o7AFcCu8y5gdO0mRc0XjobU0Yr+t3Strmr55hIlxmiM=;
	b=lpvANjtSI7lKnu/+zJ6QveUZsZDVZlSbyv1cZsxjnyq+A6/wQJlbnJ9YU7g4qE3S8b
	XJ8+pDOjwBKTB291OqqeetSnOEaT0knmxQoRD7OxbeBIheMu61VLTS1CAPXgSg0aUVMA
	cQ1roKveUKIoWkTiqbtQkOflcLxyKTJXVsje/acHiARS73SkNRE9jpUPq9+n5dvgLsLP
	Iopw41bEK5mzpaGI2ghNGp5ONBy3JQcKsSGjzW5u9s/hOvLJLAcx/9b7RsZ60vnYlwSs
	3X9DNgDlwu9GUlfX0bCZZ4PHiugfsVeiLCtDNEb87FtmlbytV9c9fz7N12MUJ3z7ugL/
	uDxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=o7AFcCu8y5gdO0mRc0XjobU0Yr+t3Strmr55hIlxmiM=;
	b=Ki5g+51HSIJ9Q+bwQx7DH3ixIHlHRcFwaPlbNg7d0udg/EzSg594Lx/ZKVaLo2UFvw
	kBx7Aw5Ch0gx1zVqvp5q1sCsfvv1Dm9Ue7C0mBnDOjFGWGB8Wke6obXgyKuH+TEwjH5I
	lyrckssfESjlE7Gy1ErmgOgyfqiJRo2Pf/kX6vbCP03ksu5LEC285KOhOb7wlvqbCF+l
	p+MMruggJPi4HxJ2YqfWeIYw5bKTyqMU/WxaNWOHDL+lMvjCLcJRxGi2shPiXEjUz1Uy
	Y/LJxDoPDvsHbkBwgEcz/5P6gmz9WoBZ6WCfvv+NE7oNoD4+FC+XlM5I+TEoJiB2XCMm
	j0nQ==
X-Gm-Message-State: APjAAAVcQ/8YUYP+M8yQais+xVkdLlz8kJmIOUMrk+Bc/OLzozZit1ef
	+qf6a1hujL8iU9MHe4ObkZBEgUOPOr8=
X-Google-Smtp-Source: APXvYqw8mo4Q/D9t844CXh5TvfA0Cnyv0ka2+AEUYsJ+JPO1lh4kkcF3+LNJucaiUtI24mC5QE3xAw==
X-Received: by 2002:a62:d044:: with SMTP id p65mr55694443pfg.37.1558298333214; 
	Sun, 19 May 2019 13:38:53 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231]) by smtp.gmail.com with ESMTPSA id
	i7sm11397448pfo.19.2019.05.19.13.38.52
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sun, 19 May 2019 13:38:52 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Sun, 19 May 2019 13:37:20 -0700
Message-Id: <20190519203726.20729-69-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190519203726.20729-1-richard.henderson@linaro.org>
References: <20190519203726.20729-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::444
Subject: [Qemu-devel] [PATCH v7 68/74] linux-user: Split out select,
 _newselect
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This removes the printing of the fdset outputs.  It's hard to see how
this could have been reliable in a multi-threaded program, saving
syscall arguments to global variables.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall-defs.h     |  11 ++++
 linux-user/strace.c           |  80 -------------------------
 linux-user/syscall-file.inc.c |  91 ++++++++++++++++++++++++++++
 linux-user/syscall.c          | 110 ++++------------------------------
 linux-user/strace.list        |   6 --
 5 files changed, 112 insertions(+), 186 deletions(-)

diff --git a/linux-user/syscall-defs.h b/linux-user/syscall-defs.h
index d109754c5f..01143414c7 100644
--- a/linux-user/syscall-defs.h
+++ b/linux-user/syscall-defs.h
@@ -143,6 +143,10 @@ SYSCALL_DEF(munlockall);
 SYSCALL_DEF(munmap, ARG_PTR, ARG_DEC);
 SYSCALL_DEF(name_to_handle_at,
             ARG_ATDIRFD, ARG_STR, ARG_PTR, ARG_PTR, ARG_ATFLAG);
+#ifdef TARGET_NR__newselect
+SYSCALL_DEF_FULL(_newselect, .impl = impl_select,
+                 .arg_type = { ARG_DEC, ARG_PTR, ARG_PTR, ARG_PTR, ARG_PTR });
+#endif
 #ifdef TARGET_NR_nice
 SYSCALL_DEF(nice, ARG_DEC);
 #endif
@@ -209,6 +213,13 @@ SYSCALL_DEF(rt_sigreturn);
 SYSCALL_DEF(rt_sigsuspend, ARG_PTR, ARG_DEC);
 SYSCALL_DEF(rt_sigtimedwait, ARG_PTR, ARG_PTR, ARG_PTR, ARG_DEC);
 SYSCALL_DEF(rt_tgsigqueueinfo, ARG_DEC, ARG_DEC, ARG_SIGNAL, ARG_PTR);
+#ifdef TARGET_NR_select
+# if defined(TARGET_WANT_NI_OLD_SELECT)
+SYSCALL_DEF_NOSYS(select);
+# else
+SYSCALL_DEF_ARGS(select, ARG_DEC, ARG_PTR, ARG_PTR, ARG_PTR, ARG_PTR);
+# endif
+#endif
 #if !defined(SYSCALL_TABLE) || defined(TARGET_NR_semctl)
 SYSCALL_DEF(semctl, ARG_DEC, ARG_DEC, ARG_DEC, ARG_HEX);
 #endif
diff --git a/linux-user/strace.c b/linux-user/strace.c
index 2e70a3910c..669eca7fa6 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -384,34 +384,6 @@ print_socket_protocol(int domain, int type, int protocol)
 }
 
 
-#ifdef TARGET_NR__newselect
-static void
-print_fdset(int n, abi_ulong target_fds_addr)
-{
-    int i;
-
-    gemu_log("[");
-    if( target_fds_addr ) {
-        abi_long *target_fds;
-
-        target_fds = lock_user(VERIFY_READ,
-                               target_fds_addr,
-                               sizeof(*target_fds)*(n / TARGET_ABI_BITS + 1),
-                               1);
-
-        if (!target_fds)
-            return;
-
-        for (i=n; i>=0; i--) {
-            if ((tswapal(target_fds[i / TARGET_ABI_BITS]) >> (i & (TARGET_ABI_BITS - 1))) & 1)
-                gemu_log("%d,", i );
-            }
-        unlock_user(target_fds, target_fds_addr, 0);
-    }
-    gemu_log("]");
-}
-#endif
-
 #ifdef TARGET_NR_clock_adjtime
 /* IDs of the various system clocks */
 #define TARGET_CLOCK_REALTIME              0
@@ -479,58 +451,6 @@ print_clockid(int clockid, int last)
  * Sysycall specific output functions
  */
 
-/* select */
-#ifdef TARGET_NR__newselect
-static long newselect_arg1 = 0;
-static long newselect_arg2 = 0;
-static long newselect_arg3 = 0;
-static long newselect_arg4 = 0;
-static long newselect_arg5 = 0;
-
-static void
-print_newselect(const struct syscallname *name,
-                abi_long arg1, abi_long arg2, abi_long arg3,
-                abi_long arg4, abi_long arg5, abi_long arg6)
-{
-    gemu_log("%s(" TARGET_ABI_FMT_ld ",", name->name, arg1);
-    print_fdset(arg1, arg2);
-    gemu_log(",");
-    print_fdset(arg1, arg3);
-    gemu_log(",");
-    print_fdset(arg1, arg4);
-    gemu_log(",");
-    print_timeval(arg5, 1);
-    gemu_log(")");
-
-    /* save for use in the return output function below */
-    newselect_arg1=arg1;
-    newselect_arg2=arg2;
-    newselect_arg3=arg3;
-    newselect_arg4=arg4;
-    newselect_arg5=arg5;
-}
-#endif
-
-/*
- * Variants for the return value output function
- */
-
-#ifdef TARGET_NR__newselect
-static void
-print_syscall_ret_newselect(const struct syscallname *name, abi_long ret)
-{
-    gemu_log(" = 0x" TARGET_ABI_FMT_lx " (", ret);
-    print_fdset(newselect_arg1,newselect_arg2);
-    gemu_log(",");
-    print_fdset(newselect_arg1,newselect_arg3);
-    gemu_log(",");
-    print_fdset(newselect_arg1,newselect_arg4);
-    gemu_log(",");
-    print_timeval(newselect_arg5, 1);
-    gemu_log(")\n");
-}
-#endif
-
 /* special meanings of adjtimex()' non-negative return values */
 #define TARGET_TIME_OK       0   /* clock synchronized, no leap second */
 #define TARGET_TIME_INS      1   /* insert leap second */
diff --git a/linux-user/syscall-file.inc.c b/linux-user/syscall-file.inc.c
index 6e730e3152..1d66dc3323 100644
--- a/linux-user/syscall-file.inc.c
+++ b/linux-user/syscall-file.inc.c
@@ -1067,6 +1067,97 @@ SYSCALL_IMPL(renameat2)
     return do_renameat2(arg1, arg2, arg3, arg4, arg5);
 }
 
+#if defined(TARGET_NR_select) && defined(TARGET_WANT_OLD_SYS_SELECT)
+SYSCALL_ARGS(select)
+{
+    struct target_sel_arg_struct *sel;
+    abi_ulong inp, outp, exp, tvp;
+    abi_long nsel;
+
+    if (!lock_user_struct(VERIFY_READ, sel, in[0], 1)) {
+        errno = EFAULT;
+        return NULL;
+    }
+    nsel = tswapal(sel->n);
+    inp = tswapal(sel->inp);
+    outp = tswapal(sel->outp);
+    exp = tswapal(sel->exp);
+    tvp = tswapal(sel->tvp);
+    unlock_user_struct(sel, in[0], 0);
+
+    out[0] = nsel;
+    out[1] = inp;
+    out[2] = outp;
+    out[3] = exp;
+    out[4] = tvp;
+    return def;
+}
+#else
+# define args_select NULL
+#endif
+
+#if (defined(TARGET_NR_select) && !defined(TARGET_WANT_NI_OLD_SELECT)) \
+    || defined(TARGET_NR__newselect)
+SYSCALL_IMPL(select)
+{
+    int n = arg1;
+    abi_ulong rfd_addr = arg2;
+    abi_ulong wfd_addr = arg3;
+    abi_ulong efd_addr = arg4;
+    abi_ulong target_tv_addr = arg5;
+    fd_set rfds, wfds, efds;
+    fd_set *rfds_ptr, *wfds_ptr, *efds_ptr;
+    struct timeval tv;
+    struct timespec ts, *ts_ptr = NULL;
+    abi_long ret;
+
+    ret = copy_from_user_fdset_ptr(&rfds, &rfds_ptr, rfd_addr, n);
+    if (ret) {
+        return ret;
+    }
+    ret = copy_from_user_fdset_ptr(&wfds, &wfds_ptr, wfd_addr, n);
+    if (ret) {
+        return ret;
+    }
+    ret = copy_from_user_fdset_ptr(&efds, &efds_ptr, efd_addr, n);
+    if (ret) {
+        return ret;
+    }
+
+    if (target_tv_addr) {
+        if (copy_from_user_timeval(&tv, target_tv_addr))
+            return -TARGET_EFAULT;
+        ts.tv_sec = tv.tv_sec;
+        ts.tv_nsec = tv.tv_usec * 1000;
+        ts_ptr = &ts;
+    }
+
+    ret = get_errno(safe_pselect6(n, rfds_ptr, wfds_ptr, efds_ptr,
+                                  ts_ptr, NULL));
+
+    if (!is_error(ret)) {
+        if (rfd_addr && copy_to_user_fdset(rfd_addr, &rfds, n)) {
+            return -TARGET_EFAULT;
+        }
+        if (wfd_addr && copy_to_user_fdset(wfd_addr, &wfds, n)) {
+            return -TARGET_EFAULT;
+        }
+        if (efd_addr && copy_to_user_fdset(efd_addr, &efds, n)) {
+            return -TARGET_EFAULT;
+        }
+        if (target_tv_addr) {
+            tv.tv_sec = ts.tv_sec;
+            tv.tv_usec = ts.tv_nsec / 1000;
+            if (copy_to_user_timeval(target_tv_addr, &tv)) {
+                return -TARGET_EFAULT;
+            }
+        }
+    }
+
+    return ret;
+}
+#endif
+
 SYSCALL_IMPL(sync)
 {
     sync();
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index b8bc44364d..2c8d74a450 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -1055,88 +1055,6 @@ static inline abi_long copy_to_user_mq_attr(abi_ulong target_mq_attr_addr,
 }
 #endif
 
-#if defined(TARGET_NR_select) || defined(TARGET_NR__newselect)
-/* do_select() must return target values and target errnos. */
-static abi_long do_select(int n,
-                          abi_ulong rfd_addr, abi_ulong wfd_addr,
-                          abi_ulong efd_addr, abi_ulong target_tv_addr)
-{
-    fd_set rfds, wfds, efds;
-    fd_set *rfds_ptr, *wfds_ptr, *efds_ptr;
-    struct timeval tv;
-    struct timespec ts, *ts_ptr;
-    abi_long ret;
-
-    ret = copy_from_user_fdset_ptr(&rfds, &rfds_ptr, rfd_addr, n);
-    if (ret) {
-        return ret;
-    }
-    ret = copy_from_user_fdset_ptr(&wfds, &wfds_ptr, wfd_addr, n);
-    if (ret) {
-        return ret;
-    }
-    ret = copy_from_user_fdset_ptr(&efds, &efds_ptr, efd_addr, n);
-    if (ret) {
-        return ret;
-    }
-
-    if (target_tv_addr) {
-        if (copy_from_user_timeval(&tv, target_tv_addr))
-            return -TARGET_EFAULT;
-        ts.tv_sec = tv.tv_sec;
-        ts.tv_nsec = tv.tv_usec * 1000;
-        ts_ptr = &ts;
-    } else {
-        ts_ptr = NULL;
-    }
-
-    ret = get_errno(safe_pselect6(n, rfds_ptr, wfds_ptr, efds_ptr,
-                                  ts_ptr, NULL));
-
-    if (!is_error(ret)) {
-        if (rfd_addr && copy_to_user_fdset(rfd_addr, &rfds, n))
-            return -TARGET_EFAULT;
-        if (wfd_addr && copy_to_user_fdset(wfd_addr, &wfds, n))
-            return -TARGET_EFAULT;
-        if (efd_addr && copy_to_user_fdset(efd_addr, &efds, n))
-            return -TARGET_EFAULT;
-
-        if (target_tv_addr) {
-            tv.tv_sec = ts.tv_sec;
-            tv.tv_usec = ts.tv_nsec / 1000;
-            if (copy_to_user_timeval(target_tv_addr, &tv)) {
-                return -TARGET_EFAULT;
-            }
-        }
-    }
-
-    return ret;
-}
-
-#if defined(TARGET_WANT_OLD_SYS_SELECT)
-static abi_long do_old_select(abi_ulong arg1)
-{
-    struct target_sel_arg_struct *sel;
-    abi_ulong inp, outp, exp, tvp;
-    long nsel;
-
-    if (!lock_user_struct(VERIFY_READ, sel, arg1, 1)) {
-        return -TARGET_EFAULT;
-    }
-
-    nsel = tswapal(sel->n);
-    inp = tswapal(sel->inp);
-    outp = tswapal(sel->outp);
-    exp = tswapal(sel->exp);
-    tvp = tswapal(sel->tvp);
-
-    unlock_user_struct(sel, arg1, 0);
-
-    return do_select(nsel, inp, outp, exp, tvp);
-}
-#endif
-#endif
-
 static inline abi_long target_to_host_ip_mreq(struct ip_mreqn *mreqn,
                                               abi_ulong target_addr,
                                               socklen_t len)
@@ -4240,20 +4158,6 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
     void *p;
 
     switch(num) {
-#if defined(TARGET_NR_select)
-    case TARGET_NR_select:
-#if defined(TARGET_WANT_NI_OLD_SELECT)
-        /* some architectures used to have old_select here
-         * but now ENOSYS it.
-         */
-        ret = -TARGET_ENOSYS;
-#elif defined(TARGET_WANT_OLD_SYS_SELECT)
-        ret = do_old_select(arg1);
-#else
-        ret = do_select(arg1, arg2, arg3, arg4, arg5);
-#endif
-        return ret;
-#endif
 #ifdef TARGET_NR_pselect6
     case TARGET_NR_pselect6:
         {
@@ -5007,10 +4911,6 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         }
         return ret;
 #endif /* TARGET_NR_getdents64 */
-#if defined(TARGET_NR__newselect)
-    case TARGET_NR__newselect:
-        return do_select(arg1, arg2, arg3, arg4, arg5);
-#endif
 #if defined(TARGET_NR_poll) || defined(TARGET_NR_ppoll)
 # ifdef TARGET_NR_poll
     case TARGET_NR_poll:
@@ -7233,6 +7133,12 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
 #include "syscall-sig.inc.c"
 #include "syscall-time.inc.c"
 
+static SyscallImplFn impl_enosys __attribute__((unused));
+SYSCALL_IMPL(enosys)
+{
+    return -TARGET_ENOSYS;
+}
+
 #undef SYSCALL_IMPL
 #undef SYSCALL_ARGS
 
@@ -7254,6 +7160,10 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
     SYSCALL_DEF_FULL(NAME, .impl = impl_##NAME, .args = args_##NAME, \
                      .arg_type = { __VA_ARGS__ })
 
+/* Emit a definition that always produces ENOSYS without logging.  */
+#define SYSCALL_DEF_NOSYS(NAME) \
+    SYSCALL_DEF_FULL(NAME, .impl = impl_enosys)
+
 #include "syscall-defs.h"
 
 #undef SYSCALL_DEF
diff --git a/linux-user/strace.list b/linux-user/strace.list
index 635b952d2f..297180d94f 100644
--- a/linux-user/strace.list
+++ b/linux-user/strace.list
@@ -470,9 +470,6 @@
 #ifdef TARGET_NR_newfstatat
 { TARGET_NR_newfstatat, "newfstatat" , NULL, print_newfstatat, NULL },
 #endif
-#ifdef TARGET_NR__newselect
-{ TARGET_NR__newselect, "_newselect" , NULL, print_newselect, print_syscall_ret_newselect },
-#endif
 #ifdef TARGET_NR_nfsservctl
 { TARGET_NR_nfsservctl, "nfsservctl" , NULL, NULL, NULL },
 #endif
@@ -962,9 +959,6 @@
 #ifdef TARGET_NR_security
 { TARGET_NR_security, "security" , NULL, NULL, NULL },
 #endif
-#ifdef TARGET_NR_select
-{ TARGET_NR_select, "select" , NULL, NULL, NULL },
-#endif
 #ifdef TARGET_NR_send
 { TARGET_NR_send, "send" , NULL, NULL, NULL },
 #endif
-- 
2.17.1


