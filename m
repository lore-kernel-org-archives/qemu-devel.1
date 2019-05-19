Return-Path: <SRS0=v56/=TT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BC25C04AB4
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 21:24:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31D8620644
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 21:24:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DoYXlx3P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31D8620644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53786 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSTI3-0001IO-Dn
	for qemu-devel@archiver.kernel.org; Sun, 19 May 2019 17:24:19 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51035)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hSSZz-0003vo-8Y
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:38:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hSSZy-0004rK-4v
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:38:47 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:38181)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hSSZx-0004qY-V9
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:38:46 -0400
Received: by mail-pg1-x541.google.com with SMTP id j26so5741184pgl.5
	for <qemu-devel@nongnu.org>; Sun, 19 May 2019 13:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=Y5HxahaYaY6QYC1uo4aAY7RPOmMGvLOX7tv8PUypEZk=;
	b=DoYXlx3PoHm8K+tZgACald1wGeogE569sqfxk9pncSL5eWSgZiCOOAfBTZUTBk7KuF
	05qBqU1l1+cXBY7RkbZ3GSsZgV/jWVTMILzW3HDstXMXcaRdU+sljGNESKbrz8T91oJN
	RqDb+1eozWltuCG0t8tjjiM8nOZO8jBVL+vqe86sCTwjkc6TorTRvlV1IVNCXzMVLuec
	yXZ7pM1qHmQoeTnurS3HNCXlqIuYrdcTy9zfSb81RJvh85FApQbIaCf5NYdNIY1i4zuM
	P3LW+i1k+52A1bOFnU/9mygqWT9fz4wMoytl5uxThSeXiuPltdpQjfAcKQFjPefsI2FM
	XolA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=Y5HxahaYaY6QYC1uo4aAY7RPOmMGvLOX7tv8PUypEZk=;
	b=p6rTunQPXRxfQkVlcagCD/xHYB45UWkXrA2RXuAZw3/b3jDFjpFtzL95p8dzKhC59v
	5Js0XH5B3r6/0V7bPZSP3KwsF4B3iNB0wS3c0KWYSSi9MxD/BzSGCK1GlqfepmvLrsfV
	ueuv8BN0P8dD7Q8sDSb9BkJJMFI6pfLcFnCzP5aC77uNRUqTGA4SPMzMrIe7NmdWvMbG
	yZ/S2jEodZVctvQXDatqfoIXNmD8rfXqmBUiv6CM/jATvsg5lfQUE0c9SB4YzJoowRbU
	kIdfBgJwkRgB54Nb518NCuhYyOiVxe6Fp3A+AuDOGn65L+O1eKaDv3L15SYGR7MvOhfQ
	8TBQ==
X-Gm-Message-State: APjAAAX9qBBYQARh0cPUnmASYtpG76OcTg/VL+3NYkjsRqYcNlZ7oab6
	P1uizuKFwQ7CZoMNpWE7dODbHap+LZE=
X-Google-Smtp-Source: APXvYqzgchWjEJoori1VjJOXpF6YoQvh0AmSNfpgaarnx1R3pqp4sfDeg/0glECZmJG1VOd2Ad/+sw==
X-Received: by 2002:a62:117:: with SMTP id 23mr47169063pfb.156.1558298324723; 
	Sun, 19 May 2019 13:38:44 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231]) by smtp.gmail.com with ESMTPSA id
	i7sm11397448pfo.19.2019.05.19.13.38.43
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sun, 19 May 2019 13:38:44 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Sun, 19 May 2019 13:37:13 -0700
Message-Id: <20190519203726.20729-62-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190519203726.20729-1-richard.henderson@linaro.org>
References: <20190519203726.20729-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::541
Subject: [Qemu-devel] [PATCH v7 61/74] linux-user: Split out rt_sigtimedwait
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
 linux-user/syscall-defs.h    |  1 +
 linux-user/syscall-sig.inc.c | 37 ++++++++++++++++++++++++++++++++++++
 linux-user/syscall.c         | 36 -----------------------------------
 linux-user/strace.list       |  3 ---
 4 files changed, 38 insertions(+), 39 deletions(-)

diff --git a/linux-user/syscall-defs.h b/linux-user/syscall-defs.h
index 2b930f5599..24289ed413 100644
--- a/linux-user/syscall-defs.h
+++ b/linux-user/syscall-defs.h
@@ -197,6 +197,7 @@ SYSCALL_DEF(rt_sigaction, ARG_SIGNAL, ARG_PTR, ARG_PTR, ARG_DEC);
 SYSCALL_DEF(rt_sigpending, ARG_PTR, ARG_DEC);
 SYSCALL_DEF(rt_sigprocmask, ARG_SIGPROCMASKHOW, ARG_PTR, ARG_PTR, ARG_DEC);
 SYSCALL_DEF(rt_sigsuspend, ARG_PTR, ARG_DEC);
+SYSCALL_DEF(rt_sigtimedwait, ARG_PTR, ARG_PTR, ARG_PTR, ARG_DEC);
 #if !defined(SYSCALL_TABLE) || defined(TARGET_NR_semctl)
 SYSCALL_DEF(semctl, ARG_DEC, ARG_DEC, ARG_DEC, ARG_HEX);
 #endif
diff --git a/linux-user/syscall-sig.inc.c b/linux-user/syscall-sig.inc.c
index 23ea14e2a6..5f2c0ba499 100644
--- a/linux-user/syscall-sig.inc.c
+++ b/linux-user/syscall-sig.inc.c
@@ -215,6 +215,43 @@ SYSCALL_IMPL(rt_sigsuspend)
     return ret;
 }
 
+SYSCALL_IMPL(rt_sigtimedwait)
+{
+    sigset_t set;
+    struct timespec uts, *puts = NULL;
+    siginfo_t uinfo;
+    abi_long ret;
+    void *p;
+
+    if (arg4 != sizeof(target_sigset_t)) {
+        return -TARGET_EINVAL;
+    }
+    p = lock_user(VERIFY_READ, arg1, sizeof(target_sigset_t), 1);
+    if (!p) {
+        return -TARGET_EFAULT;
+    }
+    target_to_host_sigset(&set, p);
+    unlock_user(p, arg1, 0);
+    if (arg3) {
+        puts = &uts;
+        target_to_host_timespec(puts, arg3);
+    }
+
+    ret = get_errno(safe_rt_sigtimedwait(&set, &uinfo, puts, SIGSET_T_SIZE));
+    if (!is_error(ret)) {
+        if (arg2) {
+            p = lock_user(VERIFY_WRITE, arg2, sizeof(target_siginfo_t), 0);
+            if (!p) {
+                return -TARGET_EFAULT;
+            }
+            host_to_target_siginfo(p, &uinfo);
+            unlock_user(p, arg2, sizeof(target_siginfo_t));
+        }
+        ret = host_to_target_signal(ret);
+    }
+    return ret;
+}
+
 #ifdef TARGET_NR_sigaction
 SYSCALL_IMPL(sigaction)
 {
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 00f4ba8753..8a05d3e32a 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -4240,42 +4240,6 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
     void *p;
 
     switch(num) {
-    case TARGET_NR_rt_sigtimedwait:
-        {
-            sigset_t set;
-            struct timespec uts, *puts;
-            siginfo_t uinfo;
-
-            if (arg4 != sizeof(target_sigset_t)) {
-                return -TARGET_EINVAL;
-            }
-
-            if (!(p = lock_user(VERIFY_READ, arg1, sizeof(target_sigset_t), 1)))
-                return -TARGET_EFAULT;
-            target_to_host_sigset(&set, p);
-            unlock_user(p, arg1, 0);
-            if (arg3) {
-                puts = &uts;
-                target_to_host_timespec(puts, arg3);
-            } else {
-                puts = NULL;
-            }
-            ret = get_errno(safe_rt_sigtimedwait(&set, &uinfo, puts,
-                                                 SIGSET_T_SIZE));
-            if (!is_error(ret)) {
-                if (arg2) {
-                    p = lock_user(VERIFY_WRITE, arg2, sizeof(target_siginfo_t),
-                                  0);
-                    if (!p) {
-                        return -TARGET_EFAULT;
-                    }
-                    host_to_target_siginfo(p, &uinfo);
-                    unlock_user(p, arg2, sizeof(target_siginfo_t));
-                }
-                ret = host_to_target_signal(ret);
-            }
-        }
-        return ret;
     case TARGET_NR_rt_sigqueueinfo:
         {
             siginfo_t uinfo;
diff --git a/linux-user/strace.list b/linux-user/strace.list
index 26df8b25cd..0b2c057673 100644
--- a/linux-user/strace.list
+++ b/linux-user/strace.list
@@ -932,9 +932,6 @@
 #ifdef TARGET_NR_rt_sigreturn
 { TARGET_NR_rt_sigreturn, "rt_sigreturn" , NULL, NULL, NULL },
 #endif
-#ifdef TARGET_NR_rt_sigtimedwait
-{ TARGET_NR_rt_sigtimedwait, "rt_sigtimedwait" , NULL, NULL, NULL },
-#endif
 #ifdef TARGET_NR_rt_tgsigqueueinfo
 { TARGET_NR_rt_tgsigqueueinfo, "rt_tgsigqueueinfo" , NULL, print_rt_tgsigqueueinfo, NULL },
 #endif
-- 
2.17.1


