Return-Path: <SRS0=v56/=TT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C470C04AB4
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 21:21:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4282F20449
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 21:21:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HlkoJCcc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4282F20449
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53758 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSTFh-0007f7-FI
	for qemu-devel@archiver.kernel.org; Sun, 19 May 2019 17:21:53 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51127)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hSSa4-00040f-C0
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:38:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hSSa3-0004xw-26
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:38:52 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:38314)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hSSa2-0004wx-S0
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:38:51 -0400
Received: by mail-pf1-x442.google.com with SMTP id b76so6171951pfb.5
	for <qemu-devel@nongnu.org>; Sun, 19 May 2019 13:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=C4XNH+VeEXaL+6UuHWZfoss3TaaEPTbmJNRx30bs8d0=;
	b=HlkoJCccjOovpX7qB2H7RM3LLddUnfOgcGNq2r9L7iv7jBhxc4TCfALr2Y0kJQhGLi
	pjcI4vJFA9mvNMBTOvit2RyzS3Qob7XGGdTKwnpXLhQsYKZuy2M8pSLa62n1RTdKIkTT
	WaDGdYAdlGBkk2KOioZ3lOcaJgThBANn7WM6StZ5btJKz13q24nHkg/2GdC/bf/wnDCP
	QMgong0Msl/4hTc/Kpebl7C42rDwkBQVNyY7PWmT5no5HqK77UY1Fqg8XK5vtg/HOuzL
	aJCZ7pLozOS3xLbkRONCiDyhwfbtSSauoLIDJA3mDU59PBr+kr0zgCkQSGyKaTQH7UX1
	RgpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=C4XNH+VeEXaL+6UuHWZfoss3TaaEPTbmJNRx30bs8d0=;
	b=NkVmQrVicfGwbqRlEoBJ01vRuIVLNcHYebUZO7946E7xpqtjLf9RgQZxosLX1LxD5P
	45y/htrNSTQWbSJZ8vB5tpSXDUCO0oWoi+ZelHgRJxgVfIKqoJ2ONnL7H76cJna08yxj
	M0qPqbV6SzJX4GcFWOm5tWlXM3U+qWZSQD7EGC1zcHPx2dcgOYL4grsiGErwXrr2Quc8
	su53dwQ7/bfSEnIhQl1/SjuSqa+eBkvh6J1RWaNqR41gLwx73ik8bnHm9IKUg6oQY5dM
	hXpV/KxOvScIjCPWX/xbUBnxcW93QS/IlHKBCZzclIa489zaDixDqfeLeGde1z8qMZrQ
	nMYg==
X-Gm-Message-State: APjAAAW19lCwXShHSmc01ASaKEk3YyIVYLCmJhWpXZ+ekX6R59EREg44
	62U84PEnQiXwOEjfxnx91IExM+85k+k=
X-Google-Smtp-Source: APXvYqwRibmGPBZo54XXGUUlLz7h9gaOzcKGbe+MteJY0zpvS1tc2MDPCqBQTEnjj4Q0U0lPb0Ej+Q==
X-Received: by 2002:a63:5659:: with SMTP id g25mr72010606pgm.59.1558298329635; 
	Sun, 19 May 2019 13:38:49 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231]) by smtp.gmail.com with ESMTPSA id
	i7sm11397448pfo.19.2019.05.19.13.38.48
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sun, 19 May 2019 13:38:49 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Sun, 19 May 2019 13:37:17 -0700
Message-Id: <20190519203726.20729-66-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190519203726.20729-1-richard.henderson@linaro.org>
References: <20190519203726.20729-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::442
Subject: [Qemu-devel] [PATCH v7 65/74] linux-user: Split out getrlimit,
 setrlimit
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
 linux-user/syscall-defs.h     |  6 ++++
 linux-user/syscall-proc.inc.c | 52 +++++++++++++++++++++++++++++++++++
 linux-user/syscall.c          | 46 -------------------------------
 linux-user/strace.list        |  6 ----
 4 files changed, 58 insertions(+), 52 deletions(-)

diff --git a/linux-user/syscall-defs.h b/linux-user/syscall-defs.h
index 3ba697fd53..34426a2e23 100644
--- a/linux-user/syscall-defs.h
+++ b/linux-user/syscall-defs.h
@@ -72,6 +72,9 @@ SYSCALL_DEF(getpid);
 #ifdef TARGET_NR_getppid
 SYSCALL_DEF(getppid);
 #endif
+#ifdef TARGET_NR_getrlimit
+SYSCALL_DEF(getrlimit, ARG_DEC, ARG_PTR);
+#endif
 SYSCALL_DEF(getsid, ARG_DEC);
 #ifdef TARGET_NR_getxpid
 SYSCALL_DEF(getxpid);
@@ -212,6 +215,9 @@ SYSCALL_DEF(semget, ARG_DEC, ARG_DEC, ARG_HEX);
 #endif
 SYSCALL_DEF(sethostname, ARG_STR);
 SYSCALL_DEF(setpgid, ARG_DEC, ARG_DEC);
+#ifdef TARGET_NR_setrlimit
+SYSCALL_DEF(setrlimit, ARG_DEC, ARG_PTR);
+#endif
 SYSCALL_DEF(setsid);
 #if !defined(SYSCALL_TABLE) || defined(TARGET_NR_semop)
 SYSCALL_DEF(semop, ARG_DEC, ARG_PTR, ARG_DEC);
diff --git a/linux-user/syscall-proc.inc.c b/linux-user/syscall-proc.inc.c
index b1a801fb62..1238b08191 100644
--- a/linux-user/syscall-proc.inc.c
+++ b/linux-user/syscall-proc.inc.c
@@ -479,6 +479,26 @@ SYSCALL_IMPL(getppid)
 }
 #endif
 
+#ifdef TARGET_NR_getrlimit
+SYSCALL_IMPL(getrlimit)
+{
+    int resource = target_to_host_resource(arg1);
+    struct target_rlimit *target_rlim;
+    struct rlimit rlim;
+    abi_long ret;
+
+    ret = get_errno(getrlimit(resource, &rlim));
+    if (!is_error(ret)) {
+        if (!lock_user_struct(VERIFY_WRITE, target_rlim, arg2, 0)) {
+            return -TARGET_EFAULT;
+        }
+        target_rlim->rlim_cur = host_to_target_rlim(rlim.rlim_cur);
+        target_rlim->rlim_max = host_to_target_rlim(rlim.rlim_max);
+        unlock_user_struct(target_rlim, arg2, 1);
+    }
+    return ret;
+}
+#endif
 SYSCALL_IMPL(getsid)
 {
     return get_errno(getsid(arg1));
@@ -518,6 +538,38 @@ SYSCALL_IMPL(setpgid)
     return get_errno(setpgid(arg1, arg2));
 }
 
+#ifdef TARGET_NR_setrlimit
+SYSCALL_IMPL(setrlimit)
+{
+    int resource = target_to_host_resource(arg1);
+    struct target_rlimit *target_rlim;
+    struct rlimit rlim;
+
+    if (!lock_user_struct(VERIFY_READ, target_rlim, arg2, 1)) {
+        return -TARGET_EFAULT;
+    }
+    rlim.rlim_cur = target_to_host_rlim(target_rlim->rlim_cur);
+    rlim.rlim_max = target_to_host_rlim(target_rlim->rlim_max);
+    unlock_user_struct(target_rlim, arg2, 0);
+
+    /*
+     * If we just passed through resource limit settings for memory then
+     * they would also apply to QEMU's own allocations, and QEMU will
+     * crash or hang or die if its allocations fail. Ideally we would
+     * track the guest allocations in QEMU and apply the limits ourselves.
+     * For now, just tell the guest the call succeeded but don't actually
+     * limit anything.
+     */
+    if (resource != RLIMIT_AS &&
+        resource != RLIMIT_DATA &&
+        resource != RLIMIT_STACK) {
+        return get_errno(setrlimit(resource, &rlim));
+    } else {
+        return 0;
+    }
+}
+#endif
+
 SYSCALL_IMPL(setsid)
 {
     return get_errno(setsid());
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 6dd4196647..401450b0e3 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -4240,52 +4240,6 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
     void *p;
 
     switch(num) {
-#ifdef TARGET_NR_setrlimit
-    case TARGET_NR_setrlimit:
-        {
-            int resource = target_to_host_resource(arg1);
-            struct target_rlimit *target_rlim;
-            struct rlimit rlim;
-            if (!lock_user_struct(VERIFY_READ, target_rlim, arg2, 1))
-                return -TARGET_EFAULT;
-            rlim.rlim_cur = target_to_host_rlim(target_rlim->rlim_cur);
-            rlim.rlim_max = target_to_host_rlim(target_rlim->rlim_max);
-            unlock_user_struct(target_rlim, arg2, 0);
-            /*
-             * If we just passed through resource limit settings for memory then
-             * they would also apply to QEMU's own allocations, and QEMU will
-             * crash or hang or die if its allocations fail. Ideally we would
-             * track the guest allocations in QEMU and apply the limits ourselves.
-             * For now, just tell the guest the call succeeded but don't actually
-             * limit anything.
-             */
-            if (resource != RLIMIT_AS &&
-                resource != RLIMIT_DATA &&
-                resource != RLIMIT_STACK) {
-                return get_errno(setrlimit(resource, &rlim));
-            } else {
-                return 0;
-            }
-        }
-#endif
-#ifdef TARGET_NR_getrlimit
-    case TARGET_NR_getrlimit:
-        {
-            int resource = target_to_host_resource(arg1);
-            struct target_rlimit *target_rlim;
-            struct rlimit rlim;
-
-            ret = get_errno(getrlimit(resource, &rlim));
-            if (!is_error(ret)) {
-                if (!lock_user_struct(VERIFY_WRITE, target_rlim, arg2, 0))
-                    return -TARGET_EFAULT;
-                target_rlim->rlim_cur = host_to_target_rlim(rlim.rlim_cur);
-                target_rlim->rlim_max = host_to_target_rlim(rlim.rlim_max);
-                unlock_user_struct(target_rlim, arg2, 1);
-            }
-        }
-        return ret;
-#endif
     case TARGET_NR_getrusage:
         {
             struct rusage rusage;
diff --git a/linux-user/strace.list b/linux-user/strace.list
index 361ceec853..711ad9c0aa 100644
--- a/linux-user/strace.list
+++ b/linux-user/strace.list
@@ -280,9 +280,6 @@
 #ifdef TARGET_NR_getresuid32
 { TARGET_NR_getresuid32, "getresuid32" , NULL, NULL, NULL },
 #endif
-#ifdef TARGET_NR_getrlimit
-{ TARGET_NR_getrlimit, "getrlimit" , NULL, NULL, NULL },
-#endif
 #ifdef TARGET_NR_get_robust_list
 { TARGET_NR_get_robust_list, "get_robust_list" , NULL, NULL, NULL },
 #endif
@@ -1061,9 +1058,6 @@
 #ifdef TARGET_NR_setreuid32
 { TARGET_NR_setreuid32, "setreuid32" , NULL, NULL, NULL },
 #endif
-#ifdef TARGET_NR_setrlimit
-{ TARGET_NR_setrlimit, "setrlimit" , NULL, NULL, NULL },
-#endif
 #ifdef TARGET_NR_set_robust_list
 { TARGET_NR_set_robust_list, "set_robust_list" , NULL, NULL, NULL },
 #endif
-- 
2.17.1


