Return-Path: <SRS0=v56/=TT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04F65C04AB4
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 21:20:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C50C20449
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 21:20:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hblhk9WW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C50C20449
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53749 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSTEV-0006XA-Eo
	for qemu-devel@archiver.kernel.org; Sun, 19 May 2019 17:20:39 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50974)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hSSZu-0003rC-1r
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:38:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hSSZs-0004kT-Aa
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:38:42 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:43443)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hSSZs-0004jf-1c
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:38:40 -0400
Received: by mail-pl1-x642.google.com with SMTP id gn7so1547889plb.10
	for <qemu-devel@nongnu.org>; Sun, 19 May 2019 13:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=/YpVT18mqqIFScwHIfb0mWiE7uIJJMrlMlrDVbB4UPM=;
	b=hblhk9WWpYxInAWKvveMiaezmyFzVaIhAak7rOQ7Bk1MuxPbXAUsifr203RUG1K0RZ
	3mTJtHa61Pv1PxNbtQz6nEV/uhX/EqSkTtB1PSlbdxbqd5lPQSSFsfHgEs8eLS01tWAJ
	1HmbEjCdkniopLuUnkMV+5UvTUpUIfFusEW2b9vBlRgXy+TlwwaAqns37uMEobp5MkNp
	i1b7gVYW/DE+R1+8tHEXsqyn4rPbWceir9IviNeiHXtc4fgn/wKXGELeSnIDrGTcGCcx
	Wq2e8HeINqGmVUknQzBzZRMzm5goqgvHKAH2itNkmM/JTPY9RWRtAGcA3s1PMXOhTXxD
	zhug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=/YpVT18mqqIFScwHIfb0mWiE7uIJJMrlMlrDVbB4UPM=;
	b=DBiLs47SKVJTArHloHJST/v7gGg3MQiZ+NMALHqKiaL9uQhDaaAa06jImLsAlJOZtQ
	NDgHks5MuvS7xZe7tVgDNpsOTtZewryUyUu4NochWQmpWdZA+V1KvMjRyQD1512SQo2Y
	cFU3CLOAQuA/tg20LQrF1+ohYovQXXH/e18eQqpVzAxfJ5eWNh5WKIJW65qAduqD1lmK
	kyDN96jPnSz5OktHMI/lEkNTMuaS/Ej06C8sN5/AV5A0cb8Ur9sxfxfWHLrNPkCkKRyJ
	p6gZkLsgwzvO8lEn5Fbfr4/L9pXTOVutA45hoBiVBxHzJt7F044hqWhAJD+baqc0w1+V
	HkxQ==
X-Gm-Message-State: APjAAAXp6SYGXiLy3CjMDcsn9fsbBgDZiH+NZU6/abJEOpPHig94rCcc
	UDMCDxhipt/EzrdJhgfH9RLDM5E7zqQ=
X-Google-Smtp-Source: APXvYqwuKKW7yB/so1+a2uR8VMSJDs56uFAfOGlLkM3fLkp9DLSwiA39u5LXjH7blZrP3kIJW1GyWw==
X-Received: by 2002:a17:902:b941:: with SMTP id
	h1mr13227358pls.289.1558298318825; 
	Sun, 19 May 2019 13:38:38 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231]) by smtp.gmail.com with ESMTPSA id
	i7sm11397448pfo.19.2019.05.19.13.38.37
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sun, 19 May 2019 13:38:38 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Sun, 19 May 2019 13:37:08 -0700
Message-Id: <20190519203726.20729-57-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190519203726.20729-1-richard.henderson@linaro.org>
References: <20190519203726.20729-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::642
Subject: [Qemu-devel] [PATCH v7 56/74] linux-user: Split out sigaction,
 rt_sigaction
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
 linux-user/syscall-defs.h    |  10 ++
 linux-user/strace.c          |  14 ---
 linux-user/syscall-sig.inc.c | 172 +++++++++++++++++++++++++++++++++++
 linux-user/syscall.c         | 160 --------------------------------
 linux-user/strace.list       |   6 --
 5 files changed, 182 insertions(+), 180 deletions(-)

diff --git a/linux-user/syscall-defs.h b/linux-user/syscall-defs.h
index cd2c127c41..b62bffeb68 100644
--- a/linux-user/syscall-defs.h
+++ b/linux-user/syscall-defs.h
@@ -187,6 +187,13 @@ SYSCALL_DEF(readv, ARG_DEC, ARG_PTR, ARG_DEC);
 #ifdef TARGET_NR_rmdir
 SYSCALL_DEF(rmdir, ARG_STR);
 #endif
+#if defined(TARGET_ALPHA)
+SYSCALL_DEF(rt_sigaction, ARG_SIGNAL, ARG_PTR, ARG_PTR, ARG_DEC, ARG_PTR);
+#elif defined(TARGET_SPARC)
+SYSCALL_DEF(rt_sigaction, ARG_SIGNAL, ARG_PTR, ARG_PTR, ARG_PTR, ARG_DEC);
+#else
+SYSCALL_DEF(rt_sigaction, ARG_SIGNAL, ARG_PTR, ARG_PTR, ARG_DEC);
+#endif
 #if !defined(SYSCALL_TABLE) || defined(TARGET_NR_semctl)
 SYSCALL_DEF(semctl, ARG_DEC, ARG_DEC, ARG_DEC, ARG_HEX);
 #endif
@@ -212,6 +219,9 @@ SYSCALL_DEF(shmdt, ARG_PTR);
 #if !defined(SYSCALL_TABLE) || defined(TARGET_NR_shmget)
 SYSCALL_DEF(shmget, ARG_DEC, ARG_DEC, ARG_HEX);
 #endif
+#ifdef TARGET_NR_sigaction
+SYSCALL_DEF(sigaction, ARG_SIGNAL, ARG_PTR, ARG_PTR);
+#endif
 #ifdef TARGET_NR_stime
 SYSCALL_DEF(stime, ARG_PTR);
 #endif
diff --git a/linux-user/strace.c b/linux-user/strace.c
index 787bf41307..83dd755c73 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -1564,20 +1564,6 @@ print_fstat(const struct syscallname *name,
 #define print_fstat64     print_fstat
 #endif
 
-#ifdef TARGET_NR_rt_sigaction
-static void
-print_rt_sigaction(const struct syscallname *name,
-    abi_long arg0, abi_long arg1, abi_long arg2,
-    abi_long arg3, abi_long arg4, abi_long arg5)
-{
-    print_syscall_prologue(name);
-    print_signal(arg0, 0);
-    print_pointer(arg1, 0);
-    print_pointer(arg2, 1);
-    print_syscall_epilogue(name);
-}
-#endif
-
 #ifdef TARGET_NR_rt_sigprocmask
 static void
 print_rt_sigprocmask(const struct syscallname *name,
diff --git a/linux-user/syscall-sig.inc.c b/linux-user/syscall-sig.inc.c
index a4fbcc567d..918d58878f 100644
--- a/linux-user/syscall-sig.inc.c
+++ b/linux-user/syscall-sig.inc.c
@@ -39,3 +39,175 @@ SYSCALL_IMPL(pause)
     return -TARGET_EINTR;
 }
 #endif
+
+SYSCALL_IMPL(rt_sigaction)
+{
+    abi_long ret;
+#if defined(TARGET_ALPHA)
+    /*
+     * For Alpha and SPARC this is a 5 argument syscall, with
+     * a 'restorer' parameter which must be copied into the
+     * sa_restorer field of the sigaction struct.
+     * For Alpha that 'restorer' is arg5; for SPARC it is arg4,
+     * and arg5 is the sigsetsize.
+     * Alpha also has a separate rt_sigaction struct that it uses
+     * here; SPARC uses the usual sigaction struct.
+     */
+    struct target_rt_sigaction *rt_act;
+    struct target_sigaction act, oact, *pact = NULL;
+
+    if (arg4 != sizeof(target_sigset_t)) {
+        return -TARGET_EINVAL;
+    }
+    if (arg2) {
+        if (!lock_user_struct(VERIFY_READ, rt_act, arg2, 1)) {
+            return -TARGET_EFAULT;
+        }
+        act._sa_handler = rt_act->_sa_handler;
+        act.sa_mask = rt_act->sa_mask;
+        act.sa_flags = rt_act->sa_flags;
+        act.sa_restorer = arg5;
+        unlock_user_struct(rt_act, arg2, 0);
+        pact = &act;
+    }
+    ret = get_errno(do_sigaction(arg1, pact, &oact));
+    if (!is_error(ret) && arg3) {
+        if (!lock_user_struct(VERIFY_WRITE, rt_act, arg3, 0)) {
+            return -TARGET_EFAULT;
+        }
+        rt_act->_sa_handler = oact._sa_handler;
+        rt_act->sa_mask = oact.sa_mask;
+        rt_act->sa_flags = oact.sa_flags;
+        unlock_user_struct(rt_act, arg3, 1);
+    }
+#else
+# ifdef TARGET_SPARC
+    target_ulong restorer = arg4;
+    target_ulong sigsetsize = arg5;
+# else
+    target_ulong sigsetsize = arg4;
+# endif
+    struct target_sigaction act, oact, *pact = NULL;
+
+    if (sigsetsize != sizeof(target_sigset_t)) {
+        return -TARGET_EINVAL;
+    }
+    if (arg2) {
+        if (!lock_user_struct(VERIFY_READ, pact, arg2, 1)) {
+            return -TARGET_EFAULT;
+        }
+        act = *pact;
+        unlock_user_struct(pact, arg2, 0);
+# ifdef TARGET_ARCH_HAS_KA_RESTORER
+        act.ka_restorer = restorer;
+# endif
+        pact = &act;
+    }
+
+    ret = get_errno(do_sigaction(arg1, pact, &oact));
+
+    if (!is_error(ret) && arg3) {
+        if (!lock_user_struct(VERIFY_WRITE, pact, arg3, 0)) {
+            return -TARGET_EFAULT;
+        }
+        *pact = oact;
+        unlock_user_struct(pact, arg3, 1);
+    }
+#endif
+    return ret;
+}
+
+#ifdef TARGET_NR_sigaction
+SYSCALL_IMPL(sigaction)
+{
+    abi_long ret;
+#if defined(TARGET_ALPHA)
+    struct target_sigaction act, oact, *pact = NULL;
+    struct target_old_sigaction *old_act;
+
+    if (arg2) {
+        if (!lock_user_struct(VERIFY_READ, old_act, arg2, 1)) {
+            return -TARGET_EFAULT;
+        }
+        act._sa_handler = old_act->_sa_handler;
+        target_siginitset(&act.sa_mask, old_act->sa_mask);
+        act.sa_flags = old_act->sa_flags;
+        act.sa_restorer = 0;
+        unlock_user_struct(old_act, arg2, 0);
+        pact = &act;
+    }
+
+    ret = get_errno(do_sigaction(arg1, pact, &oact));
+
+    if (!is_error(ret) && arg3) {
+        if (!lock_user_struct(VERIFY_WRITE, old_act, arg3, 0)) {
+            return -TARGET_EFAULT;
+        }
+        old_act->_sa_handler = oact._sa_handler;
+        old_act->sa_mask = oact.sa_mask.sig[0];
+        old_act->sa_flags = oact.sa_flags;
+        unlock_user_struct(old_act, arg3, 1);
+    }
+#elif defined(TARGET_MIPS)
+    struct target_sigaction act, oact, *pact = NULL, *old_act;
+
+    if (arg2) {
+        if (!lock_user_struct(VERIFY_READ, old_act, arg2, 1)) {
+            return -TARGET_EFAULT;
+        }
+        act._sa_handler = old_act->_sa_handler;
+        target_siginitset(&act.sa_mask, old_act->sa_mask.sig[0]);
+        act.sa_flags = old_act->sa_flags;
+        unlock_user_struct(old_act, arg2, 0);
+        pact = &act;
+    }
+
+    ret = get_errno(do_sigaction(arg1, pact, &oact));
+
+    if (!is_error(ret) && arg3) {
+        if (!lock_user_struct(VERIFY_WRITE, old_act, arg3, 0)) {
+            return -TARGET_EFAULT;
+        }
+        old_act->_sa_handler = oact._sa_handler;
+        old_act->sa_flags = oact.sa_flags;
+        old_act->sa_mask.sig[0] = oact.sa_mask.sig[0];
+        old_act->sa_mask.sig[1] = 0;
+        old_act->sa_mask.sig[2] = 0;
+        old_act->sa_mask.sig[3] = 0;
+        unlock_user_struct(old_act, arg3, 1);
+    }
+#else
+    struct target_old_sigaction *old_act;
+    struct target_sigaction act, oact, *pact = NULL;
+
+    if (arg2) {
+        if (!lock_user_struct(VERIFY_READ, old_act, arg2, 1)) {
+            return -TARGET_EFAULT;
+        }
+        act._sa_handler = old_act->_sa_handler;
+        target_siginitset(&act.sa_mask, old_act->sa_mask);
+        act.sa_flags = old_act->sa_flags;
+        act.sa_restorer = old_act->sa_restorer;
+#ifdef TARGET_ARCH_HAS_KA_RESTORER
+        act.ka_restorer = 0;
+#endif
+        unlock_user_struct(old_act, arg2, 0);
+        pact = &act;
+    }
+
+    ret = get_errno(do_sigaction(arg1, pact, &oact));
+
+    if (!is_error(ret) && arg3) {
+        if (!lock_user_struct(VERIFY_WRITE, old_act, arg3, 0)) {
+            return -TARGET_EFAULT;
+        }
+        old_act->_sa_handler = oact._sa_handler;
+        old_act->sa_mask = oact.sa_mask.sig[0];
+        old_act->sa_flags = oact.sa_flags;
+        old_act->sa_restorer = oact.sa_restorer;
+        unlock_user_struct(old_act, arg3, 1);
+    }
+#endif
+    return ret;
+}
+#endif
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 0e9f4fd5ae..3ef1bfb4ec 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -4241,166 +4241,6 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
     void *p;
 
     switch(num) {
-#ifdef TARGET_NR_sigaction
-    case TARGET_NR_sigaction:
-        {
-#if defined(TARGET_ALPHA)
-            struct target_sigaction act, oact, *pact = 0;
-            struct target_old_sigaction *old_act;
-            if (arg2) {
-                if (!lock_user_struct(VERIFY_READ, old_act, arg2, 1))
-                    return -TARGET_EFAULT;
-                act._sa_handler = old_act->_sa_handler;
-                target_siginitset(&act.sa_mask, old_act->sa_mask);
-                act.sa_flags = old_act->sa_flags;
-                act.sa_restorer = 0;
-                unlock_user_struct(old_act, arg2, 0);
-                pact = &act;
-            }
-            ret = get_errno(do_sigaction(arg1, pact, &oact));
-            if (!is_error(ret) && arg3) {
-                if (!lock_user_struct(VERIFY_WRITE, old_act, arg3, 0))
-                    return -TARGET_EFAULT;
-                old_act->_sa_handler = oact._sa_handler;
-                old_act->sa_mask = oact.sa_mask.sig[0];
-                old_act->sa_flags = oact.sa_flags;
-                unlock_user_struct(old_act, arg3, 1);
-            }
-#elif defined(TARGET_MIPS)
-	    struct target_sigaction act, oact, *pact, *old_act;
-
-	    if (arg2) {
-                if (!lock_user_struct(VERIFY_READ, old_act, arg2, 1))
-                    return -TARGET_EFAULT;
-		act._sa_handler = old_act->_sa_handler;
-		target_siginitset(&act.sa_mask, old_act->sa_mask.sig[0]);
-		act.sa_flags = old_act->sa_flags;
-		unlock_user_struct(old_act, arg2, 0);
-		pact = &act;
-	    } else {
-		pact = NULL;
-	    }
-
-	    ret = get_errno(do_sigaction(arg1, pact, &oact));
-
-	    if (!is_error(ret) && arg3) {
-                if (!lock_user_struct(VERIFY_WRITE, old_act, arg3, 0))
-                    return -TARGET_EFAULT;
-		old_act->_sa_handler = oact._sa_handler;
-		old_act->sa_flags = oact.sa_flags;
-		old_act->sa_mask.sig[0] = oact.sa_mask.sig[0];
-		old_act->sa_mask.sig[1] = 0;
-		old_act->sa_mask.sig[2] = 0;
-		old_act->sa_mask.sig[3] = 0;
-		unlock_user_struct(old_act, arg3, 1);
-	    }
-#else
-            struct target_old_sigaction *old_act;
-            struct target_sigaction act, oact, *pact;
-            if (arg2) {
-                if (!lock_user_struct(VERIFY_READ, old_act, arg2, 1))
-                    return -TARGET_EFAULT;
-                act._sa_handler = old_act->_sa_handler;
-                target_siginitset(&act.sa_mask, old_act->sa_mask);
-                act.sa_flags = old_act->sa_flags;
-                act.sa_restorer = old_act->sa_restorer;
-#ifdef TARGET_ARCH_HAS_KA_RESTORER
-                act.ka_restorer = 0;
-#endif
-                unlock_user_struct(old_act, arg2, 0);
-                pact = &act;
-            } else {
-                pact = NULL;
-            }
-            ret = get_errno(do_sigaction(arg1, pact, &oact));
-            if (!is_error(ret) && arg3) {
-                if (!lock_user_struct(VERIFY_WRITE, old_act, arg3, 0))
-                    return -TARGET_EFAULT;
-                old_act->_sa_handler = oact._sa_handler;
-                old_act->sa_mask = oact.sa_mask.sig[0];
-                old_act->sa_flags = oact.sa_flags;
-                old_act->sa_restorer = oact.sa_restorer;
-                unlock_user_struct(old_act, arg3, 1);
-            }
-#endif
-        }
-        return ret;
-#endif
-    case TARGET_NR_rt_sigaction:
-        {
-#if defined(TARGET_ALPHA)
-            /* For Alpha and SPARC this is a 5 argument syscall, with
-             * a 'restorer' parameter which must be copied into the
-             * sa_restorer field of the sigaction struct.
-             * For Alpha that 'restorer' is arg5; for SPARC it is arg4,
-             * and arg5 is the sigsetsize.
-             * Alpha also has a separate rt_sigaction struct that it uses
-             * here; SPARC uses the usual sigaction struct.
-             */
-            struct target_rt_sigaction *rt_act;
-            struct target_sigaction act, oact, *pact = 0;
-
-            if (arg4 != sizeof(target_sigset_t)) {
-                return -TARGET_EINVAL;
-            }
-            if (arg2) {
-                if (!lock_user_struct(VERIFY_READ, rt_act, arg2, 1))
-                    return -TARGET_EFAULT;
-                act._sa_handler = rt_act->_sa_handler;
-                act.sa_mask = rt_act->sa_mask;
-                act.sa_flags = rt_act->sa_flags;
-                act.sa_restorer = arg5;
-                unlock_user_struct(rt_act, arg2, 0);
-                pact = &act;
-            }
-            ret = get_errno(do_sigaction(arg1, pact, &oact));
-            if (!is_error(ret) && arg3) {
-                if (!lock_user_struct(VERIFY_WRITE, rt_act, arg3, 0))
-                    return -TARGET_EFAULT;
-                rt_act->_sa_handler = oact._sa_handler;
-                rt_act->sa_mask = oact.sa_mask;
-                rt_act->sa_flags = oact.sa_flags;
-                unlock_user_struct(rt_act, arg3, 1);
-            }
-#else
-#ifdef TARGET_SPARC
-            target_ulong restorer = arg4;
-            target_ulong sigsetsize = arg5;
-#else
-            target_ulong sigsetsize = arg4;
-#endif
-            struct target_sigaction *act;
-            struct target_sigaction *oact;
-
-            if (sigsetsize != sizeof(target_sigset_t)) {
-                return -TARGET_EINVAL;
-            }
-            if (arg2) {
-                if (!lock_user_struct(VERIFY_READ, act, arg2, 1)) {
-                    return -TARGET_EFAULT;
-                }
-#ifdef TARGET_ARCH_HAS_KA_RESTORER
-                act->ka_restorer = restorer;
-#endif
-            } else {
-                act = NULL;
-            }
-            if (arg3) {
-                if (!lock_user_struct(VERIFY_WRITE, oact, arg3, 0)) {
-                    ret = -TARGET_EFAULT;
-                    goto rt_sigaction_fail;
-                }
-            } else
-                oact = NULL;
-            ret = get_errno(do_sigaction(arg1, act, oact));
-	rt_sigaction_fail:
-            if (act)
-                unlock_user_struct(act, arg2, 0);
-            if (oact)
-                unlock_user_struct(oact, arg3, 1);
-#endif
-        }
-        return ret;
 #ifdef TARGET_NR_sgetmask /* not on alpha */
     case TARGET_NR_sgetmask:
         {
diff --git a/linux-user/strace.list b/linux-user/strace.list
index bf87a6d4cb..20a71adc21 100644
--- a/linux-user/strace.list
+++ b/linux-user/strace.list
@@ -926,9 +926,6 @@
 #ifdef TARGET_NR_rmdir
 { TARGET_NR_rmdir, "rmdir" , NULL, NULL, NULL },
 #endif
-#ifdef TARGET_NR_rt_sigaction
-{ TARGET_NR_rt_sigaction, "rt_sigaction" , NULL, print_rt_sigaction, NULL },
-#endif
 #ifdef TARGET_NR_rt_sigpending
 { TARGET_NR_rt_sigpending, "rt_sigpending" , NULL, NULL, NULL },
 #endif
@@ -1125,9 +1122,6 @@
 #ifdef TARGET_NR_shutdown
 { TARGET_NR_shutdown, "shutdown" , NULL, NULL, NULL },
 #endif
-#ifdef TARGET_NR_sigaction
-{ TARGET_NR_sigaction, "sigaction" , NULL, NULL, NULL },
-#endif
 #ifdef TARGET_NR_sigaltstack
 { TARGET_NR_sigaltstack, "sigaltstack" , "%s(%p,%p)", NULL, NULL },
 #endif
-- 
2.17.1


