Return-Path: <SRS0=v56/=TT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB32CC04AB4
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 21:23:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B61B20644
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 21:23:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Edxlms5o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B61B20644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53784 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSTHe-0000wT-F4
	for qemu-devel@archiver.kernel.org; Sun, 19 May 2019 17:23:54 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51026)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hSSZy-0003vO-C3
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:38:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hSSZx-0004q8-3g
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:38:46 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:35287)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hSSZw-0004pR-T1
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:38:45 -0400
Received: by mail-pg1-x544.google.com with SMTP id t1so4322877pgc.2
	for <qemu-devel@nongnu.org>; Sun, 19 May 2019 13:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=76+mjrN9dH89H5/Svkq5qWa063W+g+MfoJgRAxm+Ooc=;
	b=Edxlms5o54PZXlEF5kPdWDXQ4iTGf95k5hqzTjWT+BcEys4GQDYYRXX6bDuMS/HkUZ
	rW08V+EwLSK6Z+sh1Fe05z1zYUErudvuhAAB4ecpPuMou4bY98ZbO0oIjjvNDtE7lqyP
	boenIk/yvjt379MUEK6C3N0uBsy1hgAcUMIUbJxjFfTtQMqG/pZsaamaFoi/btMTjY4V
	NYDQxmIonrxBBgLe79B9vTnhP5j1yssVtfS3JyvBGOSHpYXJbnqrzywyRivvJjb9Azhr
	7ofNQP9aVjO5ksoXar31E0uj9jpvG4/cpDjaiSb8FF0Xe12daTPvnJkG9+R114+e+Lq9
	0Zow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=76+mjrN9dH89H5/Svkq5qWa063W+g+MfoJgRAxm+Ooc=;
	b=Kw7AkimgssylYhsfuIdqpQZbC1Hu2CqeoJCoyhcsjOJckc4qLurFzxonuZ3Ck3CYl3
	fH9BWN6qhebIMIgP6izLNCsblp/07zw+6Pnf507ocKMpwNkovy6QYxg0alwHPLHhEpAv
	wsRL8RsUOWW1rPCQVDdIDh4086eSWwBTIOkyApDXd6iO+XSngcyqFDbOmCswQiquJQe1
	bnEApqpd3ymbDSwhdRey6T9Y3gfb6oYF6vryjWt9z5nfLAJPiaMR9JXzaHNQ0ChvNuhP
	uHFhdGACwLmWnomyyIFTQA/OS4y9V9MCd+GcBUQhlJ4monkBnh/FgJWXEkgRsvUX50Iz
	H1Vg==
X-Gm-Message-State: APjAAAUGDH9Telk523lYL4nv8kI/NODrrDsmYUQzCEKHt6ZXP2OaywOc
	K1SpEmTESaQMcbgTgFs+tjiiX6FRXdY=
X-Google-Smtp-Source: APXvYqyTyHDaPORyWwg7KN7CpY1LHEjClFKVWTB8y+EiA6mpUmfSMCapq+nVnZNyq5MbjjP4x3LeHg==
X-Received: by 2002:a63:d150:: with SMTP id c16mr71008417pgj.439.1558298323712;
	Sun, 19 May 2019 13:38:43 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231]) by smtp.gmail.com with ESMTPSA id
	i7sm11397448pfo.19.2019.05.19.13.38.42
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sun, 19 May 2019 13:38:43 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Sun, 19 May 2019 13:37:12 -0700
Message-Id: <20190519203726.20729-61-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190519203726.20729-1-richard.henderson@linaro.org>
References: <20190519203726.20729-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::544
Subject: [Qemu-devel] [PATCH v7 60/74] linux-user: Split out sigsuspend,
 rt_sigsuspend
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
 linux-user/syscall-defs.h    |  6 +++++
 linux-user/syscall-sig.inc.c | 51 ++++++++++++++++++++++++++++++++++++
 linux-user/syscall.c         | 42 ++---------------------------
 linux-user/strace.list       |  6 -----
 4 files changed, 59 insertions(+), 46 deletions(-)

diff --git a/linux-user/syscall-defs.h b/linux-user/syscall-defs.h
index 83a69246d0..2b930f5599 100644
--- a/linux-user/syscall-defs.h
+++ b/linux-user/syscall-defs.h
@@ -196,6 +196,7 @@ SYSCALL_DEF(rt_sigaction, ARG_SIGNAL, ARG_PTR, ARG_PTR, ARG_DEC);
 #endif
 SYSCALL_DEF(rt_sigpending, ARG_PTR, ARG_DEC);
 SYSCALL_DEF(rt_sigprocmask, ARG_SIGPROCMASKHOW, ARG_PTR, ARG_PTR, ARG_DEC);
+SYSCALL_DEF(rt_sigsuspend, ARG_PTR, ARG_DEC);
 #if !defined(SYSCALL_TABLE) || defined(TARGET_NR_semctl)
 SYSCALL_DEF(semctl, ARG_DEC, ARG_DEC, ARG_DEC, ARG_HEX);
 #endif
@@ -232,6 +233,11 @@ SYSCALL_DEF(sigprocmask, ARG_SIGPROCMASKHOW, ARG_HEX);
 #elif defined(TARGET_NR_sigprocmask)
 SYSCALL_DEF(sigprocmask, ARG_SIGPROCMASKHOW, ARG_PTR, ARG_PTR);
 #endif
+#if defined(TARGET_ALPHA)
+SYSCALL_DEF(sigsuspend, ARG_HEX);
+#elif defined(TARGET_NR_sigsuspend)
+SYSCALL_DEF(sigsuspend, ARG_PTR);
+#endif
 #ifdef TARGET_NR_sgetmask
 SYSCALL_DEF(sgetmask);
 #endif
diff --git a/linux-user/syscall-sig.inc.c b/linux-user/syscall-sig.inc.c
index fe717a5121..23ea14e2a6 100644
--- a/linux-user/syscall-sig.inc.c
+++ b/linux-user/syscall-sig.inc.c
@@ -191,6 +191,30 @@ SYSCALL_IMPL(rt_sigprocmask)
     return ret;
 }
 
+SYSCALL_IMPL(rt_sigsuspend)
+{
+    CPUState *cpu = ENV_GET_CPU(cpu_env);
+    TaskState *ts = cpu->opaque;
+    abi_long ret;
+    void *p;
+
+    if (arg2 != sizeof(target_sigset_t)) {
+        return -TARGET_EINVAL;
+    }
+    p = lock_user(VERIFY_READ, arg1, sizeof(target_sigset_t), 1);
+    if (!p) {
+        return -TARGET_EFAULT;
+    }
+    target_to_host_sigset(&ts->sigsuspend_mask, p);
+    unlock_user(p, arg1, 0);
+
+    ret = get_errno(safe_rt_sigsuspend(&ts->sigsuspend_mask, SIGSET_T_SIZE));
+    if (ret != -TARGET_ERESTARTSYS) {
+        ts->in_sigsuspend = 1;
+    }
+    return ret;
+}
+
 #ifdef TARGET_NR_sigaction
 SYSCALL_IMPL(sigaction)
 {
@@ -380,6 +404,33 @@ SYSCALL_IMPL(sigprocmask)
 }
 #endif
 
+#ifdef TARGET_NR_sigsuspend
+SYSCALL_IMPL(sigsuspend)
+{
+    CPUState *cpu = ENV_GET_CPU(cpu_env);
+    TaskState *ts = cpu->opaque;
+    abi_long ret;
+
+#if defined(TARGET_ALPHA)
+    abi_ulong mask = arg1;
+    target_to_host_old_sigset(&ts->sigsuspend_mask, &mask);
+#else
+    void *p = lock_user(VERIFY_READ, arg1, sizeof(target_sigset_t), 1);
+    if (!p) {
+        return -TARGET_EFAULT;
+    }
+    target_to_host_old_sigset(&ts->sigsuspend_mask, p);
+    unlock_user(p, arg1, 0);
+#endif
+
+    ret = get_errno(safe_rt_sigsuspend(&ts->sigsuspend_mask, SIGSET_T_SIZE));
+    if (ret != -TARGET_ERESTARTSYS) {
+        ts->in_sigsuspend = 1;
+    }
+    return ret;
+}
+#endif
+
 #ifdef TARGET_NR_sgetmask
 SYSCALL_IMPL(sgetmask)
 {
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 7dda237c95..00f4ba8753 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -4227,7 +4227,6 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
                             abi_long arg5, abi_long arg6, abi_long arg7,
                             abi_long arg8)
 {
-    CPUState *cpu = ENV_GET_CPU(cpu_env);
     abi_long ret;
 #if defined(TARGET_NR_stat) || defined(TARGET_NR_stat64) \
     || defined(TARGET_NR_lstat) || defined(TARGET_NR_lstat64) \
@@ -4241,45 +4240,6 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
     void *p;
 
     switch(num) {
-#ifdef TARGET_NR_sigsuspend
-    case TARGET_NR_sigsuspend:
-        {
-            TaskState *ts = cpu->opaque;
-#if defined(TARGET_ALPHA)
-            abi_ulong mask = arg1;
-            target_to_host_old_sigset(&ts->sigsuspend_mask, &mask);
-#else
-            if (!(p = lock_user(VERIFY_READ, arg1, sizeof(target_sigset_t), 1)))
-                return -TARGET_EFAULT;
-            target_to_host_old_sigset(&ts->sigsuspend_mask, p);
-            unlock_user(p, arg1, 0);
-#endif
-            ret = get_errno(safe_rt_sigsuspend(&ts->sigsuspend_mask,
-                                               SIGSET_T_SIZE));
-            if (ret != -TARGET_ERESTARTSYS) {
-                ts->in_sigsuspend = 1;
-            }
-        }
-        return ret;
-#endif
-    case TARGET_NR_rt_sigsuspend:
-        {
-            TaskState *ts = cpu->opaque;
-
-            if (arg2 != sizeof(target_sigset_t)) {
-                return -TARGET_EINVAL;
-            }
-            if (!(p = lock_user(VERIFY_READ, arg1, sizeof(target_sigset_t), 1)))
-                return -TARGET_EFAULT;
-            target_to_host_sigset(&ts->sigsuspend_mask, p);
-            unlock_user(p, arg1, 0);
-            ret = get_errno(safe_rt_sigsuspend(&ts->sigsuspend_mask,
-                                               SIGSET_T_SIZE));
-            if (ret != -TARGET_ERESTARTSYS) {
-                ts->in_sigsuspend = 1;
-            }
-        }
-        return ret;
     case TARGET_NR_rt_sigtimedwait:
         {
             sigset_t set;
@@ -6659,6 +6619,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
       return do_set_thread_area(cpu_env, arg1);
 #elif defined(TARGET_M68K)
       {
+          CPUState *cpu = ENV_GET_CPU(cpu_env);
           TaskState *ts = cpu->opaque;
           ts->tp_value = arg1;
           return 0;
@@ -6673,6 +6634,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         return do_get_thread_area(cpu_env, arg1);
 #elif defined(TARGET_M68K)
         {
+            CPUState *cpu = ENV_GET_CPU(cpu_env);
             TaskState *ts = cpu->opaque;
             return ts->tp_value;
         }
diff --git a/linux-user/strace.list b/linux-user/strace.list
index 978e47bf0e..26df8b25cd 100644
--- a/linux-user/strace.list
+++ b/linux-user/strace.list
@@ -932,9 +932,6 @@
 #ifdef TARGET_NR_rt_sigreturn
 { TARGET_NR_rt_sigreturn, "rt_sigreturn" , NULL, NULL, NULL },
 #endif
-#ifdef TARGET_NR_rt_sigsuspend
-{ TARGET_NR_rt_sigsuspend, "rt_sigsuspend" , NULL, NULL, NULL },
-#endif
 #ifdef TARGET_NR_rt_sigtimedwait
 { TARGET_NR_rt_sigtimedwait, "rt_sigtimedwait" , NULL, NULL, NULL },
 #endif
@@ -1128,9 +1125,6 @@
 #ifdef TARGET_NR_sigreturn
 { TARGET_NR_sigreturn, "sigreturn" , NULL, NULL, NULL },
 #endif
-#ifdef TARGET_NR_sigsuspend
-{ TARGET_NR_sigsuspend, "sigsuspend" , NULL, NULL, NULL },
-#endif
 #ifdef TARGET_NR_socket
 { TARGET_NR_socket, "socket" , NULL, print_socket, NULL },
 #endif
-- 
2.17.1


