Return-Path: <SRS0=v56/=TT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06BAEC04AB4
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 21:19:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B229B20449
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 21:19:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q7VaexYd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B229B20449
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53704 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSTDD-0005Ej-0c
	for qemu-devel@archiver.kernel.org; Sun, 19 May 2019 17:19:19 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51008)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hSSZx-0003uD-2f
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:38:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hSSZv-0004og-Rs
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:38:45 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:40703)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hSSZv-0004np-Lt
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:38:43 -0400
Received: by mail-pf1-x442.google.com with SMTP id u17so6164928pfn.7
	for <qemu-devel@nongnu.org>; Sun, 19 May 2019 13:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=ECmaTCfEAMemyN6xkmuxaTzKq2RyHXzLJFeHp0RKqwc=;
	b=q7VaexYd+7If+cN2hjhaFwAKNkcPwnI0/CufIkGx5LDTc1sAzpKs8XJ+C2gfl+pADo
	JelSOM/p0qBipRdZdeO8FnD7I0Sfl3uduomlcO7xgAptqH+93GIaC/UY2EJNEQc+nc0s
	ais6vaUpRo6PhKvkeLIFBtto7go/wo9GoFnd6J9DGCxP5iImwhOJyGnDu6ejYdAIFbrN
	penQZzl50WLzHt8qszsFQlmrQR4zaiVTsSvbZ19cqsNgKTJ4g4URjeYojzVbsL5N5z1s
	CQ88qFOKGuCeArEIMLxAOInDYdHZi6GvDbbGSSsn5bA0Q+bXkk9RFs4HITNHasWJSwUK
	oboQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=ECmaTCfEAMemyN6xkmuxaTzKq2RyHXzLJFeHp0RKqwc=;
	b=CxvpAYh6jRdUMUSlpLRl0tZ4GS3AIe18vjkFeRlidFzlKM5lGMzXe6/ShrpH/7KKV1
	VgBSCU0nX2k+4NujshiXqSJcIYy81ao56IjP/s0i4+mxpsk+87boHS1d0m7wZkmNfERz
	NGqDZdtRvwN3kfZGtY3Vet0hk7tDLtD1zZ0mqrBUB+iRahqrSdYqO0YS91ycysu72zBY
	2EuTfE9T5GzciKSrcM4NIsJCVjZ68EdN5cIvdkJYP4ben/+b3zWwtnEFFixFAwF3VGip
	5SahACBbFaRl47BGdzYT+byGpET30rfHYUWnR+/kbD+VaaqEvB4u5PyK3jpPCCvWmdfk
	qKRA==
X-Gm-Message-State: APjAAAUtuwL7c1YkIn2FhUTEbx4cTn0JdIUXlUYa9fFxtFC2psShbrq/
	W0oYfpDi4HgkWMWzEf4AbE0MZ0tdESk=
X-Google-Smtp-Source: APXvYqzggcw1zSdAw87EM5N5dtLrHHGvV3GeoHFhPMaI+6JWg8krXfz8lNcTZv3IdbQhDPxZVsNTWg==
X-Received: by 2002:a62:5487:: with SMTP id i129mr75484904pfb.68.1558298322438;
	Sun, 19 May 2019 13:38:42 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231]) by smtp.gmail.com with ESMTPSA id
	i7sm11397448pfo.19.2019.05.19.13.38.41
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sun, 19 May 2019 13:38:41 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Sun, 19 May 2019 13:37:11 -0700
Message-Id: <20190519203726.20729-60-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190519203726.20729-1-richard.henderson@linaro.org>
References: <20190519203726.20729-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::442
Subject: [Qemu-devel] [PATCH v7 59/74] linux-user: Split out sigpending,
 rt_sigpending
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
 linux-user/syscall-defs.h    |  4 ++++
 linux-user/syscall-sig.inc.c | 45 ++++++++++++++++++++++++++++++++++++
 linux-user/syscall.c         | 36 -----------------------------
 linux-user/strace.list       |  6 -----
 4 files changed, 49 insertions(+), 42 deletions(-)

diff --git a/linux-user/syscall-defs.h b/linux-user/syscall-defs.h
index ef77f60524..83a69246d0 100644
--- a/linux-user/syscall-defs.h
+++ b/linux-user/syscall-defs.h
@@ -194,6 +194,7 @@ SYSCALL_DEF(rt_sigaction, ARG_SIGNAL, ARG_PTR, ARG_PTR, ARG_PTR, ARG_DEC);
 #else
 SYSCALL_DEF(rt_sigaction, ARG_SIGNAL, ARG_PTR, ARG_PTR, ARG_DEC);
 #endif
+SYSCALL_DEF(rt_sigpending, ARG_PTR, ARG_DEC);
 SYSCALL_DEF(rt_sigprocmask, ARG_SIGPROCMASKHOW, ARG_PTR, ARG_PTR, ARG_DEC);
 #if !defined(SYSCALL_TABLE) || defined(TARGET_NR_semctl)
 SYSCALL_DEF(semctl, ARG_DEC, ARG_DEC, ARG_DEC, ARG_HEX);
@@ -223,6 +224,9 @@ SYSCALL_DEF(shmget, ARG_DEC, ARG_DEC, ARG_HEX);
 #ifdef TARGET_NR_sigaction
 SYSCALL_DEF(sigaction, ARG_SIGNAL, ARG_PTR, ARG_PTR);
 #endif
+#ifdef TARGET_NR_sigpending
+SYSCALL_DEF(sigpending, ARG_PTR);
+#endif
 #if defined(TARGET_ALPHA)
 SYSCALL_DEF(sigprocmask, ARG_SIGPROCMASKHOW, ARG_HEX);
 #elif defined(TARGET_NR_sigprocmask)
diff --git a/linux-user/syscall-sig.inc.c b/linux-user/syscall-sig.inc.c
index 8a6518bdaa..fe717a5121 100644
--- a/linux-user/syscall-sig.inc.c
+++ b/linux-user/syscall-sig.inc.c
@@ -117,6 +117,33 @@ SYSCALL_IMPL(rt_sigaction)
     return ret;
 }
 
+SYSCALL_IMPL(rt_sigpending)
+{
+    sigset_t set;
+    abi_long ret;
+
+    /*
+     * Yes, this check is >, not != like most. We follow the kernel's
+     * logic and it does it like this because it implements
+     * NR_sigpending through the same code path, and in that case
+     * the old_sigset_t is smaller in size.
+     */
+    if (arg2 > sizeof(target_sigset_t)) {
+        return -TARGET_EINVAL;
+    }
+
+    ret = get_errno(sigpending(&set));
+    if (!is_error(ret)) {
+        void *p = lock_user(VERIFY_WRITE, arg1, sizeof(target_sigset_t), 0);
+        if (!p) {
+            return -TARGET_EFAULT;
+        }
+        host_to_target_sigset(p, &set);
+        unlock_user(p, arg1, sizeof(target_sigset_t));
+    }
+    return ret;
+}
+
 SYSCALL_IMPL(rt_sigprocmask)
 {
     int how = 0;
@@ -259,6 +286,24 @@ SYSCALL_IMPL(sigaction)
 }
 #endif
 
+#ifdef TARGET_NR_sigpending
+SYSCALL_IMPL(sigpending)
+{
+    sigset_t set;
+    abi_long ret = get_errno(sigpending(&set));
+
+    if (!is_error(ret)) {
+        void *p = lock_user(VERIFY_WRITE, arg1, sizeof(target_sigset_t), 0);
+        if (!p) {
+            return -TARGET_EFAULT;
+        }
+        host_to_target_old_sigset(p, &set);
+        unlock_user(p, arg1, sizeof(target_sigset_t));
+    }
+    return ret;
+}
+#endif
+
 #ifdef TARGET_NR_sigprocmask
 SYSCALL_IMPL(sigprocmask)
 {
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 11bbdfade4..7dda237c95 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -4241,42 +4241,6 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
     void *p;
 
     switch(num) {
-#ifdef TARGET_NR_sigpending
-    case TARGET_NR_sigpending:
-        {
-            sigset_t set;
-            ret = get_errno(sigpending(&set));
-            if (!is_error(ret)) {
-                if (!(p = lock_user(VERIFY_WRITE, arg1, sizeof(target_sigset_t), 0)))
-                    return -TARGET_EFAULT;
-                host_to_target_old_sigset(p, &set);
-                unlock_user(p, arg1, sizeof(target_sigset_t));
-            }
-        }
-        return ret;
-#endif
-    case TARGET_NR_rt_sigpending:
-        {
-            sigset_t set;
-
-            /* Yes, this check is >, not != like most. We follow the kernel's
-             * logic and it does it like this because it implements
-             * NR_sigpending through the same code path, and in that case
-             * the old_sigset_t is smaller in size.
-             */
-            if (arg2 > sizeof(target_sigset_t)) {
-                return -TARGET_EINVAL;
-            }
-
-            ret = get_errno(sigpending(&set));
-            if (!is_error(ret)) {
-                if (!(p = lock_user(VERIFY_WRITE, arg1, sizeof(target_sigset_t), 0)))
-                    return -TARGET_EFAULT;
-                host_to_target_sigset(p, &set);
-                unlock_user(p, arg1, sizeof(target_sigset_t));
-            }
-        }
-        return ret;
 #ifdef TARGET_NR_sigsuspend
     case TARGET_NR_sigsuspend:
         {
diff --git a/linux-user/strace.list b/linux-user/strace.list
index 7157876302..978e47bf0e 100644
--- a/linux-user/strace.list
+++ b/linux-user/strace.list
@@ -926,9 +926,6 @@
 #ifdef TARGET_NR_rmdir
 { TARGET_NR_rmdir, "rmdir" , NULL, NULL, NULL },
 #endif
-#ifdef TARGET_NR_rt_sigpending
-{ TARGET_NR_rt_sigpending, "rt_sigpending" , NULL, NULL, NULL },
-#endif
 #ifdef TARGET_NR_rt_sigqueueinfo
 { TARGET_NR_rt_sigqueueinfo, "rt_sigqueueinfo" , NULL, print_rt_sigqueueinfo, NULL },
 #endif
@@ -1128,9 +1125,6 @@
 #ifdef TARGET_NR_signalfd4
 { TARGET_NR_signalfd4, "signalfd4" , NULL, NULL, NULL },
 #endif
-#ifdef TARGET_NR_sigpending
-{ TARGET_NR_sigpending, "sigpending" , NULL, NULL, NULL },
-#endif
 #ifdef TARGET_NR_sigreturn
 { TARGET_NR_sigreturn, "sigreturn" , NULL, NULL, NULL },
 #endif
-- 
2.17.1


