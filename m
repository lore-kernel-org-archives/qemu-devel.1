Return-Path: <SRS0=v56/=TT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2D9DC04AB4
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 21:09:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89EA920675
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 21:09:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Rd5loNac"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89EA920675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53558 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hST44-00051N-Ne
	for qemu-devel@archiver.kernel.org; Sun, 19 May 2019 17:09:52 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50729)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hSSZe-0003ei-Tf
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:38:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hSSZd-0004Pq-Hs
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:38:26 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:46948)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hSSZd-0004ML-8j
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:38:25 -0400
Received: by mail-pg1-x542.google.com with SMTP id t187so5715973pgb.13
	for <qemu-devel@nongnu.org>; Sun, 19 May 2019 13:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=sj59YrDaOii9L6seogQrj9UiCSK4yTlGx0hQSWmkpdA=;
	b=Rd5loNaceU2JTZWTz70p9BYyr9D2BAwEvrsapMfTqsgfsZKpr5wxUiiXPuVDNBb6/e
	pB7CEE8j/eg6Bhun1IbPfPP3mh2Hmbp3VVy144bY4T9ewk0czfDhbi65i5soJ0JAslvM
	trLfSE7+adcc2u9WGpJHJEJ7uLVMbi0RJDgAWTd3XSUGsNnM5gAoJrFRHusnx2laWzQq
	sbV1S1Ry5ntpOm7MMxSOKHacVR9FO44AC9XGabpeWw3kMwReunuvqk1+kWWGGARrTIQr
	zITZ/W/b/iK8dtWWI/FYxPLukLOX8DzejL+1fsE8v01sYRQ68dolq+uCrQ6unzcnlfdE
	Q+FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=sj59YrDaOii9L6seogQrj9UiCSK4yTlGx0hQSWmkpdA=;
	b=ImbxxclGwugF19YrC3g1qXNcojN8cDKoigZ0ufBBnH+HXpheSzQ8OemNq1AolqgVdO
	/MWc1CZJIkwxIq53oMLk18GBni6cSJOR/3FbVon3G4IgpgVHN28VSJ2VJ2Kw1WftQIRn
	vZvQjXyKC+AX8pG5TZxr/RRZhtRoRmjeO6Ld0iOx99VS+fXLYOMznb+GZi9DygrwAVtx
	G2Pbjyc3SiDt++3owBE2vsDrC3RcG7QwWqypkWXSoq5RIrIzhJD42IJ35YsSaMQ6RZ56
	k7HCIV3mbhaqPBtWHVBrHor1oLojYgvJmSLieSqw6RVQC/D9MHXccIfZOPSMecaBB45/
	trNg==
X-Gm-Message-State: APjAAAUvnwUMfCxvYlndl9FvzL7N3nIDCLXA5hXNxztTUM6FoErTEte6
	+Lg5kCnyQKEr7BnNNs7wyHe+s4WvGMI=
X-Google-Smtp-Source: APXvYqyJxiLNZOTlkzk7WJxJWWd/izu17CGtGMlejQxISH+kAys7abAcxOi44tj1JuzMoCp3+cUKqw==
X-Received: by 2002:a63:fb02:: with SMTP id o2mr70159867pgh.357.1558298301857; 
	Sun, 19 May 2019 13:38:21 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231]) by smtp.gmail.com with ESMTPSA id
	i7sm11397448pfo.19.2019.05.19.13.38.20
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sun, 19 May 2019 13:38:21 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Sun, 19 May 2019 13:36:53 -0700
Message-Id: <20190519203726.20729-42-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190519203726.20729-1-richard.henderson@linaro.org>
References: <20190519203726.20729-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::542
Subject: [Qemu-devel] [PATCH v7 41/74] linux-user: Split out mkdir, mkdirat
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

Note that mkdirat is universally available.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall-defs.h     |  4 ++++
 linux-user/strace.c           | 27 ---------------------------
 linux-user/syscall-file.inc.c | 25 +++++++++++++++++++++++++
 linux-user/syscall.c          | 16 ----------------
 linux-user/strace.list        |  6 ------
 5 files changed, 29 insertions(+), 49 deletions(-)

diff --git a/linux-user/syscall-defs.h b/linux-user/syscall-defs.h
index 0ed01aa100..8b6d8f75ff 100644
--- a/linux-user/syscall-defs.h
+++ b/linux-user/syscall-defs.h
@@ -69,6 +69,10 @@ SYSCALL_DEF(lseek, ARG_DEC, ARG_DEC, ARG_LSEEKWHENCE);
 #ifdef TARGET_NR_llseek
 SYSCALL_DEF_ARGS(llseek, ARG_DEC, ARG_DEC, ARG_PTR, ARG_LSEEKWHENCE);
 #endif
+#ifdef TARGET_NR_mkdir
+SYSCALL_DEF(mkdir, ARG_STR, ARG_MODEFLAG);
+#endif
+SYSCALL_DEF(mkdirat, ARG_ATDIRFD, ARG_STR, ARG_MODEFLAG);
 #ifdef TARGET_NR_mknod
 SYSCALL_DEF(mknod, ARG_STR, ARG_MODEFLAG, ARG_HEX);
 #endif
diff --git a/linux-user/strace.c b/linux-user/strace.c
index 8f871b30ae..2b31998dbd 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -1676,33 +1676,6 @@ print_fstat(const struct syscallname *name,
 #define print_fstat64     print_fstat
 #endif
 
-#ifdef TARGET_NR_mkdir
-static void
-print_mkdir(const struct syscallname *name,
-    abi_long arg0, abi_long arg1, abi_long arg2,
-    abi_long arg3, abi_long arg4, abi_long arg5)
-{
-    print_syscall_prologue(name);
-    print_string(arg0, 0);
-    print_file_mode(arg1, 1);
-    print_syscall_epilogue(name);
-}
-#endif
-
-#ifdef TARGET_NR_mkdirat
-static void
-print_mkdirat(const struct syscallname *name,
-    abi_long arg0, abi_long arg1, abi_long arg2,
-    abi_long arg3, abi_long arg4, abi_long arg5)
-{
-    print_syscall_prologue(name);
-    print_at_dirfd(arg0, 0);
-    print_string(arg1, 0);
-    print_file_mode(arg2, 1);
-    print_syscall_epilogue(name);
-}
-#endif
-
 #ifdef TARGET_NR_rt_sigaction
 static void
 print_rt_sigaction(const struct syscallname *name,
diff --git a/linux-user/syscall-file.inc.c b/linux-user/syscall-file.inc.c
index 18553f055e..5ed8b78c79 100644
--- a/linux-user/syscall-file.inc.c
+++ b/linux-user/syscall-file.inc.c
@@ -205,6 +205,31 @@ SYSCALL_IMPL(llseek)
 }
 #endif
 
+static abi_long do_mkdirat(int dirfd, abi_ulong target_path, mode_t mode)
+{
+    char *p = lock_user_string(target_path);
+    abi_long ret;
+
+    if (!p) {
+        return -TARGET_EFAULT;
+    }
+    ret = get_errno(mkdirat(dirfd, p, mode));
+    unlock_user(p, target_path, 0);
+    return ret;
+}
+
+#ifdef TARGET_NR_mkdir
+SYSCALL_IMPL(mkdir)
+{
+    return do_mkdirat(AT_FDCWD, arg1, arg2);
+}
+#endif
+
+SYSCALL_IMPL(mkdirat)
+{
+    return do_mkdirat(arg1, arg2, arg3);
+}
+
 static abi_long do_mknodat(int dirfd, abi_ulong target_path,
                            mode_t mode, dev_t dev)
 {
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index d8f6da63cc..0d6a9b7a6c 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -5373,22 +5373,6 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
     void *p;
 
     switch(num) {
-#ifdef TARGET_NR_mkdir
-    case TARGET_NR_mkdir:
-        if (!(p = lock_user_string(arg1)))
-            return -TARGET_EFAULT;
-        ret = get_errno(mkdir(p, arg2));
-        unlock_user(p, arg1, 0);
-        return ret;
-#endif
-#if defined(TARGET_NR_mkdirat)
-    case TARGET_NR_mkdirat:
-        if (!(p = lock_user_string(arg2)))
-            return -TARGET_EFAULT;
-        ret = get_errno(mkdirat(arg1, p, arg3));
-        unlock_user(p, arg2, 0);
-        return ret;
-#endif
     case TARGET_NR_dup:
         ret = get_errno(dup(arg1));
         if (ret >= 0) {
diff --git a/linux-user/strace.list b/linux-user/strace.list
index 3b002a0500..cdbc59bffd 100644
--- a/linux-user/strace.list
+++ b/linux-user/strace.list
@@ -473,12 +473,6 @@
 #ifdef TARGET_NR_mincore
 { TARGET_NR_mincore, "mincore" , NULL, NULL, NULL },
 #endif
-#ifdef TARGET_NR_mkdir
-{ TARGET_NR_mkdir, "mkdir" , NULL, print_mkdir, NULL },
-#endif
-#ifdef TARGET_NR_mkdirat
-{ TARGET_NR_mkdirat, "mkdirat" , NULL, print_mkdirat, NULL },
-#endif
 #ifdef TARGET_NR_modify_ldt
 { TARGET_NR_modify_ldt, "modify_ldt" , NULL, NULL, NULL },
 #endif
-- 
2.17.1


