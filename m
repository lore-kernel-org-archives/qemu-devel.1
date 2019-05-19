Return-Path: <SRS0=v56/=TT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DC21C04AB4
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 20:59:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBD0520657
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 20:59:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="whhRNYqL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBD0520657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53398 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSStY-0003dZ-3A
	for qemu-devel@archiver.kernel.org; Sun, 19 May 2019 16:59:00 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50403)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hSSZD-0003Ie-Q0
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:38:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hSSZC-0003sB-Fo
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:37:59 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:46927)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hSSZC-0003rG-9L
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:37:58 -0400
Received: by mail-pl1-x642.google.com with SMTP id r18so5698617pls.13
	for <qemu-devel@nongnu.org>; Sun, 19 May 2019 13:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=3+YujhkwUcm32OaJhXi3plbLKoShJGj44pRi7jq0BsI=;
	b=whhRNYqLCqx77nzPXcgF2akJz9cqL77znkgo40u5v7pMuGbyH4MZ7ZpSyyTvW7ffxn
	Gq8qIHPRfG86I9UdVpQXIEDmYPZXRAuhGUY+yUtlH8bQvvE/0h/XoLumLp12sw61GjtB
	U8XTDKJ52B7H00PR7p0gnqsuoPjgOulqgODL7d9jdh8LndwCqsiIuOjTNYLpsnmpNaeP
	2hMknugMygzAtE8C4dveJMVKuTb812QfOKapbBh45D5+qOqtAZu4qxaI7yq7B3lwbYHk
	LCVXRE1tg/yPspaRCejZILgy9ORxtU3Djj84JSQDQAwdt3iaSWSwE7DPuk2V0ay2OLb0
	hwGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=3+YujhkwUcm32OaJhXi3plbLKoShJGj44pRi7jq0BsI=;
	b=Xc/YG95coRIDWIq5A+VO8kpZOWB9+ETQv9mmrPkF5xkmJ+K3mWrW0Do7wiw3XhxdJy
	ouSwgCUtBXt8Ar1JA3fzTgkGyRRDK55OJgrNRwBxZ2jqdHxRn2zmKmq1Z/Y6l10HBCSl
	WEbEXGG4Z4LliQW6G4FkopVItAtwbdx0R9rUsCz3lIuoJRxRZ6b19vRoiKPkizBSaKT5
	yjjw4yTUidZbrhuYGXl4hxmJfgFsYpLGR9YIpsxrCQpiwHv3v5ztyNkck6+jbWgR8RmK
	0gUmp74cuxnWLBPv9oBITknlACzEutlGXLwmFSBOi4tNnCZxUU1vJ+Fg3gHmSejg20dT
	mtcg==
X-Gm-Message-State: APjAAAXw1sSEFThHilmbi8TrTsAL3z0XA6smh92a/LLpbgSE+9ygeYCf
	llaWoh/Tf2NZ8xewwVCElSeSPKl6jvE=
X-Google-Smtp-Source: APXvYqwmPsNNWmifxAgZFf87k9hqOGgUdLmBagvn+XEM4ASacN3t69mWQbkeomtC2WUAc2iqOkfe+Q==
X-Received: by 2002:a17:902:59c3:: with SMTP id
	d3mr1083084plj.273.1558298277044; 
	Sun, 19 May 2019 13:37:57 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231]) by smtp.gmail.com with ESMTPSA id
	i7sm11397448pfo.19.2019.05.19.13.37.55
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sun, 19 May 2019 13:37:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Sun, 19 May 2019 13:36:33 -0700
Message-Id: <20190519203726.20729-22-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190519203726.20729-1-richard.henderson@linaro.org>
References: <20190519203726.20729-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::642
Subject: [Qemu-devel] [PATCH v7 21/74] linux-user: Split out link, linkat
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

Note that linkat is universally provided.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall-defs.h     |  4 ++++
 linux-user/strace.c           | 29 -----------------------------
 linux-user/syscall-file.inc.c | 28 ++++++++++++++++++++++++++++
 linux-user/syscall.c          | 32 --------------------------------
 linux-user/strace.list        |  6 ------
 5 files changed, 32 insertions(+), 67 deletions(-)

diff --git a/linux-user/syscall-defs.h b/linux-user/syscall-defs.h
index de7a99f0c6..41dd887dbc 100644
--- a/linux-user/syscall-defs.h
+++ b/linux-user/syscall-defs.h
@@ -31,6 +31,10 @@ SYSCALL_DEF(fork);
 #ifdef TARGET_NR_ipc
 SYSCALL_DEF_ARGS(ipc, ARG_HEX, ARG_DEC, ARG_DEC, ARG_HEX, ARG_PTR, ARG_HEX);
 #endif
+#ifdef TARGET_NR_link
+SYSCALL_DEF(link, ARG_STR, ARG_STR);
+#endif
+SYSCALL_DEF(linkat, ARG_ATDIRFD, ARG_STR, ARG_ATDIRFD, ARG_STR, ARG_ATFLAG);
 SYSCALL_DEF(mlock, ARG_PTR, ARG_DEC);
 SYSCALL_DEF(mlockall, ARG_HEX);
 #ifdef TARGET_NR_mmap
diff --git a/linux-user/strace.c b/linux-user/strace.c
index 640a80f32b..feb8ec7c09 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -1369,35 +1369,6 @@ print_futimesat(const struct syscallname *name,
 }
 #endif
 
-#ifdef TARGET_NR_link
-static void
-print_link(const struct syscallname *name,
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
-#ifdef TARGET_NR_linkat
-static void
-print_linkat(const struct syscallname *name,
-    abi_long arg0, abi_long arg1, abi_long arg2,
-    abi_long arg3, abi_long arg4, abi_long arg5)
-{
-    print_syscall_prologue(name);
-    print_at_dirfd(arg0, 0);
-    print_string(arg1, 0);
-    print_at_dirfd(arg2, 0);
-    print_string(arg3, 0);
-    print_flags(at_file_flags, arg4, 1);
-    print_syscall_epilogue(name);
-}
-#endif
-
 #ifdef TARGET_NR__llseek
 static void
 print__llseek(const struct syscallname *name,
diff --git a/linux-user/syscall-file.inc.c b/linux-user/syscall-file.inc.c
index 9b966ad627..440ff5ed14 100644
--- a/linux-user/syscall-file.inc.c
+++ b/linux-user/syscall-file.inc.c
@@ -40,6 +40,34 @@ SYSCALL_IMPL(creat)
 }
 #endif
 
+static abi_long do_linkat(int olddirfd, abi_ulong target_oldpath,
+                          int newdirfd, abi_ulong target_newpath,
+                          int flags)
+{
+    char *oldpath = lock_user_string(target_oldpath);
+    char *newpath = lock_user_string(target_newpath);
+    abi_long ret = -TARGET_EFAULT;
+
+    if (oldpath && newpath) {
+        ret = get_errno(linkat(olddirfd, oldpath, newdirfd, newpath, flags));
+    }
+    unlock_user(oldpath, target_oldpath, 0);
+    unlock_user(newpath, target_newpath, 0);
+    return ret;
+}
+
+#ifdef TARGET_NR_link
+SYSCALL_IMPL(link)
+{
+    return do_linkat(AT_FDCWD, arg1, AT_FDCWD, arg2, 0);
+}
+#endif
+
+SYSCALL_IMPL(linkat)
+{
+    return do_linkat(arg1, arg2, arg3, arg4, arg5);
+}
+
 /*
  * Helpers for do_openat, manipulating /proc/self/foo.
  */
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 491e1d7cfb..865129df9e 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -5383,38 +5383,6 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
     void *p;
 
     switch(num) {
-#ifdef TARGET_NR_link
-    case TARGET_NR_link:
-        {
-            void * p2;
-            p = lock_user_string(arg1);
-            p2 = lock_user_string(arg2);
-            if (!p || !p2)
-                ret = -TARGET_EFAULT;
-            else
-                ret = get_errno(link(p, p2));
-            unlock_user(p2, arg2, 0);
-            unlock_user(p, arg1, 0);
-        }
-        return ret;
-#endif
-#if defined(TARGET_NR_linkat)
-    case TARGET_NR_linkat:
-        {
-            void * p2 = NULL;
-            if (!arg2 || !arg4)
-                return -TARGET_EFAULT;
-            p  = lock_user_string(arg2);
-            p2 = lock_user_string(arg4);
-            if (!p || !p2)
-                ret = -TARGET_EFAULT;
-            else
-                ret = get_errno(linkat(arg1, p, arg3, p2, arg5));
-            unlock_user(p, arg2, 0);
-            unlock_user(p2, arg4, 0);
-        }
-        return ret;
-#endif
 #ifdef TARGET_NR_unlink
     case TARGET_NR_unlink:
         if (!(p = lock_user_string(arg1)))
diff --git a/linux-user/strace.list b/linux-user/strace.list
index 41f8f8d0d0..f3c54cec69 100644
--- a/linux-user/strace.list
+++ b/linux-user/strace.list
@@ -461,12 +461,6 @@
 #ifdef TARGET_NR_lgetxattr
 { TARGET_NR_lgetxattr, "lgetxattr" , NULL, NULL, NULL },
 #endif
-#ifdef TARGET_NR_link
-{ TARGET_NR_link, "link" , NULL, print_link, NULL },
-#endif
-#ifdef TARGET_NR_linkat
-{ TARGET_NR_linkat, "linkat" , NULL, print_linkat, NULL },
-#endif
 #ifdef TARGET_NR_Linux
 { TARGET_NR_Linux, "Linux" , NULL, NULL, NULL },
 #endif
-- 
2.17.1


