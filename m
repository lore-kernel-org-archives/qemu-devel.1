Return-Path: <SRS0=v56/=TT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF878C04AB4
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 21:26:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A12D420644
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 21:26:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Zyt1ejbO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A12D420644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53839 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSTKE-0003R8-LU
	for qemu-devel@archiver.kernel.org; Sun, 19 May 2019 17:26:34 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51190)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hSSaA-000470-3A
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:38:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hSSa8-00054w-US
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:38:58 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:37552)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hSSa8-00054H-OA
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:38:56 -0400
Received: by mail-pf1-x441.google.com with SMTP id g3so6171976pfi.4
	for <qemu-devel@nongnu.org>; Sun, 19 May 2019 13:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=uYnsHq9/MDxU+MhAeWsJGfGuVRcPuHSPILqSnflq808=;
	b=Zyt1ejbOQKCVf+XkZU0o42hrxBobvNvTQ5mQdNaqW8Z7iXyO8kgx8f55V6lr4b9tp8
	dFcwC+paPo2Agj1uHZ6Bwdp+X21fNY9b5fSZKIGI3prnirUeVqwZFqx2L9BHux6OhyKs
	r5/S1/gMGxYO9PMTRgCLahsMbOtFD0Kl3OduRsVU3rARg+dKPboZrvPS3sxQJsJU9NfT
	R2s4P0um+Z1SE8vKLOQf0ynfTpo4HtvPjPBXfHxg+q2dgGV5iIBBbqwbmr4U1Riiv6tF
	gQMnwJo5ajOpVUFqoBvkWjp/Smmjd8w5bDWafbCll4HOmuH0n9Lo+kv6zUJKu7/Euw/T
	orbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=uYnsHq9/MDxU+MhAeWsJGfGuVRcPuHSPILqSnflq808=;
	b=eIah9cSOUCQaF8m29ZyH7kB8n1dtoKwFe8V4ffS7BDP498vkPZG8OdwvCgnSKCg8WM
	2rQxaqPvyJzQaGVrPnwm9O6UkIZSelBPStgTVZ1w95DORRBHuyr31QnNwLwzNwefpF0A
	1FVDg6r4ixnGI4KRAaw4pmJ1UIcPsH/ITnGWTZufNv+rj1zehJC2RB+5m1I1E6p/tk/F
	DGM21esxUmcZVzHKQatxDIy4oFG6UJaxNXo3epCCXZg4mjN7gdDnJQMD3VlX7EOd+5Xg
	r9nq9erUpr5T8HzgctvOLvvprzmtTcCUIEcA60sfYqoZ4WWbNXg9N/xfn1h7Bd/O6QjM
	F6lQ==
X-Gm-Message-State: APjAAAVraEhEjyT4vXUrz8/SSuSRP04hUbPW3QbCgBNUDHoejDeQTFpn
	HAdrcruKB5LPfaS2yqhUO/IRvkpGZdY=
X-Google-Smtp-Source: APXvYqz4IyVjzScE+VVKwCcS5tzEOcdkabwMWNMQf6SP8/LRDhPJS+vHc8Qj7HMM1amz1bfaMIsfZA==
X-Received: by 2002:a63:6ac1:: with SMTP id f184mr72586068pgc.25.1558298335548;
	Sun, 19 May 2019 13:38:55 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231]) by smtp.gmail.com with ESMTPSA id
	i7sm11397448pfo.19.2019.05.19.13.38.54
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sun, 19 May 2019 13:38:54 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Sun, 19 May 2019 13:37:22 -0700
Message-Id: <20190519203726.20729-71-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190519203726.20729-1-richard.henderson@linaro.org>
References: <20190519203726.20729-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::441
Subject: [Qemu-devel] [PATCH v7 70/74] linux-user: Split out symlink,
 symlinkat
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
 linux-user/syscall-defs.h     |  4 ++++
 linux-user/strace.c           | 27 ---------------------------
 linux-user/syscall-file.inc.c | 28 ++++++++++++++++++++++++++++
 linux-user/syscall.c          | 30 ------------------------------
 linux-user/strace.list        |  6 ------
 5 files changed, 32 insertions(+), 63 deletions(-)

diff --git a/linux-user/syscall-defs.h b/linux-user/syscall-defs.h
index c179f69d9f..5625c268c3 100644
--- a/linux-user/syscall-defs.h
+++ b/linux-user/syscall-defs.h
@@ -279,6 +279,10 @@ SYSCALL_DEF(ssetmask, ARG_HEX);
 #ifdef TARGET_NR_stime
 SYSCALL_DEF(stime, ARG_PTR);
 #endif
+#ifdef TARGET_NR_symlink
+SYSCALL_DEF(symlink, ARG_STR, ARG_STR);
+#endif
+SYSCALL_DEF(symlinkat, ARG_STR, ARG_ATDIRFD, ARG_STR);
 SYSCALL_DEF(sync);
 SYSCALL_DEF(syncfs, ARG_DEC);
 #ifdef TARGET_NR_time
diff --git a/linux-user/strace.c b/linux-user/strace.c
index 669eca7fa6..97755458d3 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -1563,33 +1563,6 @@ print_statfs64(const struct syscallname *name,
 }
 #endif
 
-#ifdef TARGET_NR_symlink
-static void
-print_symlink(const struct syscallname *name,
-    abi_long arg0, abi_long arg1, abi_long arg2,
-    abi_long arg3, abi_long arg4, abi_long arg5)
-{
-    print_syscall_prologue(name);
-    print_string(arg0, 0);
-    print_string(arg1, 1);
-    print_syscall_epilogue(name);
-}
-#endif
-
-#ifdef TARGET_NR_symlinkat
-static void
-print_symlinkat(const struct syscallname *name,
-    abi_long arg0, abi_long arg1, abi_long arg2,
-    abi_long arg3, abi_long arg4, abi_long arg5)
-{
-    print_syscall_prologue(name);
-    print_string(arg0, 0);
-    print_at_dirfd(arg1, 0);
-    print_string(arg2, 1);
-    print_syscall_epilogue(name);
-}
-#endif
-
 #ifdef TARGET_NR_utimensat
 static void
 print_utimensat(const struct syscallname *name,
diff --git a/linux-user/syscall-file.inc.c b/linux-user/syscall-file.inc.c
index 0a25d39d28..e3749f0fb4 100644
--- a/linux-user/syscall-file.inc.c
+++ b/linux-user/syscall-file.inc.c
@@ -1254,6 +1254,34 @@ SYSCALL_IMPL(select)
 }
 #endif
 
+static abi_long do_symlinkat(abi_ulong guest_target, int dirfd,
+                             abi_ulong guest_path)
+{
+    char *target = lock_user_string(guest_target);
+    char *path = lock_user_string(guest_path);
+    abi_long ret = -TARGET_EFAULT;
+
+    if (target && path) {
+        ret = get_errno(symlinkat(target, dirfd, path));
+    }
+    unlock_user(path, guest_path, 0);
+    unlock_user(target, guest_target, 0);
+
+    return ret;
+}
+
+#ifdef TARGET_NR_symlink
+SYSCALL_IMPL(symlink)
+{
+    return do_symlinkat(arg1, AT_FDCWD, arg2);
+}
+#endif
+
+SYSCALL_IMPL(symlinkat)
+{
+    return do_symlinkat(arg1, arg2, arg3);
+}
+
 SYSCALL_IMPL(sync)
 {
     sync();
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 6355fd62d8..fccf9ee184 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -4158,36 +4158,6 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
     void *p;
 
     switch(num) {
-#ifdef TARGET_NR_symlink
-    case TARGET_NR_symlink:
-        {
-            void *p2;
-            p = lock_user_string(arg1);
-            p2 = lock_user_string(arg2);
-            if (!p || !p2)
-                ret = -TARGET_EFAULT;
-            else
-                ret = get_errno(symlink(p, p2));
-            unlock_user(p2, arg2, 0);
-            unlock_user(p, arg1, 0);
-        }
-        return ret;
-#endif
-#if defined(TARGET_NR_symlinkat)
-    case TARGET_NR_symlinkat:
-        {
-            void *p2;
-            p  = lock_user_string(arg1);
-            p2 = lock_user_string(arg3);
-            if (!p || !p2)
-                ret = -TARGET_EFAULT;
-            else
-                ret = get_errno(symlinkat(p, arg2, p2));
-            unlock_user(p2, arg3, 0);
-            unlock_user(p, arg1, 0);
-        }
-        return ret;
-#endif
 #ifdef TARGET_NR_swapon
     case TARGET_NR_swapon:
         if (!(p = lock_user_string(arg1)))
diff --git a/linux-user/strace.list b/linux-user/strace.list
index 1bb9224b5e..d9db80335d 100644
--- a/linux-user/strace.list
+++ b/linux-user/strace.list
@@ -1122,12 +1122,6 @@
 #ifdef TARGET_NR_swapon
 { TARGET_NR_swapon, "swapon" , NULL, NULL, NULL },
 #endif
-#ifdef TARGET_NR_symlink
-{ TARGET_NR_symlink, "symlink" , NULL, print_symlink, NULL },
-#endif
-#ifdef TARGET_NR_symlinkat
-{ TARGET_NR_symlinkat, "symlinkat", NULL, print_symlinkat, NULL },
-#endif
 #ifdef TARGET_NR_syscall
 { TARGET_NR_syscall, "syscall" , NULL, NULL, NULL },
 #endif
-- 
2.17.1


