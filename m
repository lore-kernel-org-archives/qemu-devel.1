Return-Path: <SRS0=v56/=TT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEBF2C04AB4
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 21:32:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9EBB206B6
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 21:32:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hUrq3AIP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9EBB206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53939 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSTPd-0008Qa-Us
	for qemu-devel@archiver.kernel.org; Sun, 19 May 2019 17:32:10 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51000)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hSSZw-0003tT-8s
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:38:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hSSZu-0004nJ-Oa
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:38:44 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:42365)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hSSZu-0004mR-GS
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:38:42 -0400
Received: by mail-pg1-x541.google.com with SMTP id 145so5730546pgg.9
	for <qemu-devel@nongnu.org>; Sun, 19 May 2019 13:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=eD3ERAgN2Y5dS3+RsjRbX33QhXWDkyWUDS3x/SCrsg8=;
	b=hUrq3AIPxwR1z9E8UTuLi1JhZDec7hoB2OnfvhChro7DkS6v1PNKGntVyMnwXh/hiU
	5jtbvr7jUG1kb40D6gdB+fknv2jwd5jabqHIrmSDf3JKNntnbjenKXBRKa8r/9NEG5B0
	Mw5m6e7nHH6dhGKtO0IYyGo3F1mX+k6sH65THR+taomf2zVtofNttX0qqtxkVAlbItti
	2gCI+x0Dn7oGhGiVF+LXZfBjcS3JRyy7kjBpl6/vM7Oz7koaJ2FDAR099qpJQ0kRv+Xf
	BguZCtPvgox66804ZNNOweMQ6f/zPi2G04oj5U15h9XRR0HRLGJ/b4B4MLdjLrzB6Eql
	ZidA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=eD3ERAgN2Y5dS3+RsjRbX33QhXWDkyWUDS3x/SCrsg8=;
	b=pR3/nabuX23DWV6eZJt1cEkVtz3RkDT9Gj4MCZoscpKpIByht9T07NYgV/i/7MuuXi
	8vbbFYXbSyux9cJHaWiYBr3J4p1FrTRq6mv4po81zDR6VxMMIi2Gh8ni/GHmYOa8kt/c
	JuEOjy0+MKx2nm0tKC8n0MZUiNT+iQsHNquiQvQAn7LG125EtTmeI0WofFyMpbqb/qkR
	qN/A/AxONsQ13D4PHMxSjMlv28DxnlGmkUIXKBZP9BBieJch7RibE0J2+w9EInQlL0lW
	GhgHXB0M/CNO5rlccFt+E+HuPG3SE0JYQpFoBBKiUo8C/Vq1w6LERWJTogKF/faAcrA4
	ai2g==
X-Gm-Message-State: APjAAAUXmhei0GkgxkaDsdHzoXWpMSnK5mx1MNUOSeQUeidsvnalXvaz
	GNApqOZMA7yithRRS7lvkQw3ZVDGXNY=
X-Google-Smtp-Source: APXvYqzz1SrZiHumI4YmdRsi5GPRwHbdxmEkXltyrIthjJ4NAiU3p7HTCuLD483kWBVdfEd2ryryUQ==
X-Received: by 2002:aa7:8c1a:: with SMTP id c26mr75650225pfd.25.1558298321226; 
	Sun, 19 May 2019 13:38:41 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231]) by smtp.gmail.com with ESMTPSA id
	i7sm11397448pfo.19.2019.05.19.13.38.40
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sun, 19 May 2019 13:38:40 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Sun, 19 May 2019 13:37:10 -0700
Message-Id: <20190519203726.20729-59-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190519203726.20729-1-richard.henderson@linaro.org>
References: <20190519203726.20729-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::541
Subject: [Qemu-devel] [PATCH v7 58/74] linux-user: Split out sigprocmask,
 rt_sigprocmask
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall-defs.h    |   6 ++
 linux-user/syscall.h         |   1 +
 linux-user/strace.c          |  44 +++++++------
 linux-user/syscall-sig.inc.c | 123 +++++++++++++++++++++++++++++++++++
 linux-user/syscall.c         | 109 -------------------------------
 linux-user/strace.list       |   6 --
 6 files changed, 154 insertions(+), 135 deletions(-)

diff --git a/linux-user/syscall-defs.h b/linux-user/syscall-defs.h
index 99532f75b2..ef77f60524 100644
--- a/linux-user/syscall-defs.h
+++ b/linux-user/syscall-defs.h
@@ -194,6 +194,7 @@ SYSCALL_DEF(rt_sigaction, ARG_SIGNAL, ARG_PTR, ARG_PTR, ARG_PTR, ARG_DEC);
 #else
 SYSCALL_DEF(rt_sigaction, ARG_SIGNAL, ARG_PTR, ARG_PTR, ARG_DEC);
 #endif
+SYSCALL_DEF(rt_sigprocmask, ARG_SIGPROCMASKHOW, ARG_PTR, ARG_PTR, ARG_DEC);
 #if !defined(SYSCALL_TABLE) || defined(TARGET_NR_semctl)
 SYSCALL_DEF(semctl, ARG_DEC, ARG_DEC, ARG_DEC, ARG_HEX);
 #endif
@@ -222,6 +223,11 @@ SYSCALL_DEF(shmget, ARG_DEC, ARG_DEC, ARG_HEX);
 #ifdef TARGET_NR_sigaction
 SYSCALL_DEF(sigaction, ARG_SIGNAL, ARG_PTR, ARG_PTR);
 #endif
+#if defined(TARGET_ALPHA)
+SYSCALL_DEF(sigprocmask, ARG_SIGPROCMASKHOW, ARG_HEX);
+#elif defined(TARGET_NR_sigprocmask)
+SYSCALL_DEF(sigprocmask, ARG_SIGPROCMASKHOW, ARG_PTR, ARG_PTR);
+#endif
 #ifdef TARGET_NR_sgetmask
 SYSCALL_DEF(sgetmask);
 #endif
diff --git a/linux-user/syscall.h b/linux-user/syscall.h
index 7b197840f5..cf9f3e5e55 100644
--- a/linux-user/syscall.h
+++ b/linux-user/syscall.h
@@ -59,6 +59,7 @@ typedef enum {
     ARG_ATDIRFD,
     ARG_SIGNAL,
     ARG_LSEEKWHENCE,
+    ARG_SIGPROCMASKHOW,
 
     /* These print as sets of flags.  */
     ARG_ACCESSFLAG,
diff --git a/linux-user/strace.c b/linux-user/strace.c
index 83dd755c73..886663af2e 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -102,6 +102,27 @@ add_signal(char *buf, int size, int sig)
     }
 }
 
+static int
+add_sigprocmaskhow(char *buf, int size, int how)
+{
+    const char *str;
+
+    switch (how) {
+    case TARGET_SIG_BLOCK:
+        str = "SIG_BLOCK";
+        break;
+    case TARGET_SIG_UNBLOCK:
+        str = "SIG_UNBLOCK";
+        break;
+    case TARGET_SIG_SETMASK:
+        str = "SIG_SETMASK";
+        break;
+    default:
+        return snprintf(buf, size, "%d", how);
+    }
+    return snprintf(buf, size, "%s", str);
+}
+
 static void
 print_signal(abi_ulong arg, int last)
 {
@@ -1564,26 +1585,6 @@ print_fstat(const struct syscallname *name,
 #define print_fstat64     print_fstat
 #endif
 
-#ifdef TARGET_NR_rt_sigprocmask
-static void
-print_rt_sigprocmask(const struct syscallname *name,
-    abi_long arg0, abi_long arg1, abi_long arg2,
-    abi_long arg3, abi_long arg4, abi_long arg5)
-{
-    const char *how = "UNKNOWN";
-    print_syscall_prologue(name);
-    switch(arg0) {
-    case TARGET_SIG_BLOCK: how = "SIG_BLOCK"; break;
-    case TARGET_SIG_UNBLOCK: how = "SIG_UNBLOCK"; break;
-    case TARGET_SIG_SETMASK: how = "SIG_SETMASK"; break;
-    }
-    gemu_log("%s,",how);
-    print_pointer(arg1, 0);
-    print_pointer(arg2, 1);
-    print_syscall_epilogue(name);
-}
-#endif
-
 #ifdef TARGET_NR_rt_sigqueueinfo
 static void
 print_rt_sigqueueinfo(const struct syscallname *name,
@@ -2015,6 +2016,9 @@ static void print_syscall_def1(const SyscallDef *def, int64_t args[6])
         case ARG_SIGNAL:
             len = add_signal(b, rest, arg);
             break;
+        case ARG_SIGPROCMASKHOW:
+            len = add_sigprocmaskhow(b, rest, arg);
+            break;
         case ARG_ACCESSFLAG:
             len = add_flags(b, rest, access_flags, arg, false);
             break;
diff --git a/linux-user/syscall-sig.inc.c b/linux-user/syscall-sig.inc.c
index f50ed16b74..8a6518bdaa 100644
--- a/linux-user/syscall-sig.inc.c
+++ b/linux-user/syscall-sig.inc.c
@@ -117,6 +117,53 @@ SYSCALL_IMPL(rt_sigaction)
     return ret;
 }
 
+SYSCALL_IMPL(rt_sigprocmask)
+{
+    int how = 0;
+    sigset_t set, oldset, *set_ptr = NULL;
+    abi_long ret;
+    void *p;
+
+    if (arg4 != sizeof(target_sigset_t)) {
+        return -TARGET_EINVAL;
+    }
+
+    if (arg2) {
+        switch (arg1) {
+        case TARGET_SIG_BLOCK:
+            how = SIG_BLOCK;
+            break;
+        case TARGET_SIG_UNBLOCK:
+            how = SIG_UNBLOCK;
+            break;
+        case TARGET_SIG_SETMASK:
+            how = SIG_SETMASK;
+            break;
+        default:
+            return -TARGET_EINVAL;
+        }
+        p = lock_user(VERIFY_READ, arg2, sizeof(target_sigset_t), 1);
+        if (!p) {
+            return -TARGET_EFAULT;
+        }
+        target_to_host_sigset(&set, p);
+        unlock_user(p, arg2, 0);
+        set_ptr = &set;
+    }
+
+    ret = do_sigprocmask(how, set_ptr, &oldset);
+
+    if (!is_error(ret) && arg3) {
+        p = lock_user(VERIFY_WRITE, arg3, sizeof(target_sigset_t), 0);
+        if (!p) {
+            return -TARGET_EFAULT;
+        }
+        host_to_target_sigset(p, &oldset);
+        unlock_user(p, arg3, sizeof(target_sigset_t));
+    }
+    return ret;
+}
+
 #ifdef TARGET_NR_sigaction
 SYSCALL_IMPL(sigaction)
 {
@@ -212,6 +259,82 @@ SYSCALL_IMPL(sigaction)
 }
 #endif
 
+#ifdef TARGET_NR_sigprocmask
+SYSCALL_IMPL(sigprocmask)
+{
+#if defined(TARGET_ALPHA)
+    sigset_t set, oldset;
+    abi_ulong mask;
+    int how;
+    abi_long ret;
+
+    switch (arg1) {
+    case TARGET_SIG_BLOCK:
+        how = SIG_BLOCK;
+        break;
+    case TARGET_SIG_UNBLOCK:
+        how = SIG_UNBLOCK;
+        break;
+    case TARGET_SIG_SETMASK:
+        how = SIG_SETMASK;
+        break;
+    default:
+        return -TARGET_EINVAL;
+    }
+    mask = arg2;
+    target_to_host_old_sigset(&set, &mask);
+
+    ret = do_sigprocmask(how, &set, &oldset);
+
+    if (!is_error(ret)) {
+        host_to_target_old_sigset(&mask, &oldset);
+        ret = mask;
+        ((CPUAlphaState *)cpu_env)->ir[IR_V0] = 0; /* force no error */
+    }
+#else
+    sigset_t set, oldset, *set_ptr = NULL;
+    int how = 0;
+    abi_long ret;
+    void *p;
+
+    if (arg2) {
+        switch (arg1) {
+        case TARGET_SIG_BLOCK:
+            how = SIG_BLOCK;
+            break;
+        case TARGET_SIG_UNBLOCK:
+            how = SIG_UNBLOCK;
+            break;
+        case TARGET_SIG_SETMASK:
+            how = SIG_SETMASK;
+            break;
+        default:
+            return -TARGET_EINVAL;
+        }
+        p = lock_user(VERIFY_READ, arg2, sizeof(target_sigset_t), 1);
+        if (!p) {
+            return -TARGET_EFAULT;
+        }
+        target_to_host_old_sigset(&set, p);
+        unlock_user(p, arg2, 0);
+        set_ptr = &set;
+    }
+
+    ret = do_sigprocmask(how, set_ptr, &oldset);
+
+    if (!is_error(ret) && arg3) {
+        p = lock_user(VERIFY_WRITE, arg3, sizeof(target_sigset_t), 0);
+        if (!p) {
+            return -TARGET_EFAULT;
+        }
+        host_to_target_old_sigset(p, &oldset);
+        unlock_user(p, arg3, sizeof(target_sigset_t));
+    }
+#endif
+    return ret;
+}
+#endif
+
 #ifdef TARGET_NR_sgetmask
 SYSCALL_IMPL(sgetmask)
 {
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 7bd410bcf0..11bbdfade4 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -4241,115 +4241,6 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
     void *p;
 
     switch(num) {
-#ifdef TARGET_NR_sigprocmask
-    case TARGET_NR_sigprocmask:
-        {
-#if defined(TARGET_ALPHA)
-            sigset_t set, oldset;
-            abi_ulong mask;
-            int how;
-
-            switch (arg1) {
-            case TARGET_SIG_BLOCK:
-                how = SIG_BLOCK;
-                break;
-            case TARGET_SIG_UNBLOCK:
-                how = SIG_UNBLOCK;
-                break;
-            case TARGET_SIG_SETMASK:
-                how = SIG_SETMASK;
-                break;
-            default:
-                return -TARGET_EINVAL;
-            }
-            mask = arg2;
-            target_to_host_old_sigset(&set, &mask);
-
-            ret = do_sigprocmask(how, &set, &oldset);
-            if (!is_error(ret)) {
-                host_to_target_old_sigset(&mask, &oldset);
-                ret = mask;
-                ((CPUAlphaState *)cpu_env)->ir[IR_V0] = 0; /* force no error */
-            }
-#else
-            sigset_t set, oldset, *set_ptr;
-            int how;
-
-            if (arg2) {
-                switch (arg1) {
-                case TARGET_SIG_BLOCK:
-                    how = SIG_BLOCK;
-                    break;
-                case TARGET_SIG_UNBLOCK:
-                    how = SIG_UNBLOCK;
-                    break;
-                case TARGET_SIG_SETMASK:
-                    how = SIG_SETMASK;
-                    break;
-                default:
-                    return -TARGET_EINVAL;
-                }
-                if (!(p = lock_user(VERIFY_READ, arg2, sizeof(target_sigset_t), 1)))
-                    return -TARGET_EFAULT;
-                target_to_host_old_sigset(&set, p);
-                unlock_user(p, arg2, 0);
-                set_ptr = &set;
-            } else {
-                how = 0;
-                set_ptr = NULL;
-            }
-            ret = do_sigprocmask(how, set_ptr, &oldset);
-            if (!is_error(ret) && arg3) {
-                if (!(p = lock_user(VERIFY_WRITE, arg3, sizeof(target_sigset_t), 0)))
-                    return -TARGET_EFAULT;
-                host_to_target_old_sigset(p, &oldset);
-                unlock_user(p, arg3, sizeof(target_sigset_t));
-            }
-#endif
-        }
-        return ret;
-#endif
-    case TARGET_NR_rt_sigprocmask:
-        {
-            int how = arg1;
-            sigset_t set, oldset, *set_ptr;
-
-            if (arg4 != sizeof(target_sigset_t)) {
-                return -TARGET_EINVAL;
-            }
-
-            if (arg2) {
-                switch(how) {
-                case TARGET_SIG_BLOCK:
-                    how = SIG_BLOCK;
-                    break;
-                case TARGET_SIG_UNBLOCK:
-                    how = SIG_UNBLOCK;
-                    break;
-                case TARGET_SIG_SETMASK:
-                    how = SIG_SETMASK;
-                    break;
-                default:
-                    return -TARGET_EINVAL;
-                }
-                if (!(p = lock_user(VERIFY_READ, arg2, sizeof(target_sigset_t), 1)))
-                    return -TARGET_EFAULT;
-                target_to_host_sigset(&set, p);
-                unlock_user(p, arg2, 0);
-                set_ptr = &set;
-            } else {
-                how = 0;
-                set_ptr = NULL;
-            }
-            ret = do_sigprocmask(how, set_ptr, &oldset);
-            if (!is_error(ret) && arg3) {
-                if (!(p = lock_user(VERIFY_WRITE, arg3, sizeof(target_sigset_t), 0)))
-                    return -TARGET_EFAULT;
-                host_to_target_sigset(p, &oldset);
-                unlock_user(p, arg3, sizeof(target_sigset_t));
-            }
-        }
-        return ret;
 #ifdef TARGET_NR_sigpending
     case TARGET_NR_sigpending:
         {
diff --git a/linux-user/strace.list b/linux-user/strace.list
index 3cad68e081..7157876302 100644
--- a/linux-user/strace.list
+++ b/linux-user/strace.list
@@ -929,9 +929,6 @@
 #ifdef TARGET_NR_rt_sigpending
 { TARGET_NR_rt_sigpending, "rt_sigpending" , NULL, NULL, NULL },
 #endif
-#ifdef TARGET_NR_rt_sigprocmask
-{ TARGET_NR_rt_sigprocmask, "rt_sigprocmask" , NULL, print_rt_sigprocmask, NULL },
-#endif
 #ifdef TARGET_NR_rt_sigqueueinfo
 { TARGET_NR_rt_sigqueueinfo, "rt_sigqueueinfo" , NULL, print_rt_sigqueueinfo, NULL },
 #endif
@@ -1134,9 +1131,6 @@
 #ifdef TARGET_NR_sigpending
 { TARGET_NR_sigpending, "sigpending" , NULL, NULL, NULL },
 #endif
-#ifdef TARGET_NR_sigprocmask
-{ TARGET_NR_sigprocmask, "sigprocmask" , NULL, NULL, NULL },
-#endif
 #ifdef TARGET_NR_sigreturn
 { TARGET_NR_sigreturn, "sigreturn" , NULL, NULL, NULL },
 #endif
-- 
2.17.1


