Return-Path: <SRS0=v56/=TT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CA45C04AB4
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 20:56:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9EDA206B6
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 20:56:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vAxbTJLT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9EDA206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53376 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSSqm-0001B8-Vu
	for qemu-devel@archiver.kernel.org; Sun, 19 May 2019 16:56:09 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50514)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hSSZN-0003UN-2v
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:38:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hSSZL-00043d-RG
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:38:09 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:41408)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hSSZL-000431-Je
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:38:07 -0400
Received: by mail-pl1-x642.google.com with SMTP id f12so5707086plt.8
	for <qemu-devel@nongnu.org>; Sun, 19 May 2019 13:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=1sQg+P8lShstSTQHyJ7jNTozkqlGpcD4AM3YYr8dTII=;
	b=vAxbTJLT9BXhkiEJCEGyKGl8j7CT9eSVY5wjTULP9AeeXtBs84F7LZPWXrSokxv9p/
	D2eFuMuL4jViPFYIvjUyLxxImxybgijNJjWy5ECOlnL/0J0AjEFMbxuKByEWPz9Ndluh
	Ec04vZjE98kXYnS9KochhkEfOuhTOKjX8381fFT4754W7YiUxxNymHf2/YbRnTZU4AXd
	b5C+AkbBIsKf2vHsUMDKyksJ/0g1O2JGifvxJLFTfPxJYAYVcBBA3q/87zkR2GIV14Oo
	xuPDf7JxctcGG9LV9KGEG+fa7cDacPzCj0aYBZfXapz17BQ2ekVB5BkDTy7ZR1KJNxgd
	0g3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=1sQg+P8lShstSTQHyJ7jNTozkqlGpcD4AM3YYr8dTII=;
	b=Z+u+HNIIERViHwoD0uPnf9PFKvHpc6GlHwAkhJRcQ5CTBdhqpy6U7Nt3ROxb+bRGuZ
	0rwVWgGN74tuJcdwAONh4VbzzsMWLYlZqf7KllDMy2b//+10ErApR5Gndv/ko036x+C1
	Hj8iER5Wiuj11q54vPXT97A+YYz2BS7M5tAfAWxvPEGsY9b04FiO5LY+FoG+UH2eflJV
	VmWzkzcBYBf+W8fuWNFkUo+9c3DT0hg+vbf/hmBaSuj3zr/HFWk/PMBhYfCOJY0Bbjm0
	PXz6X2aoUFiogX2ITeObXhZSQqhvaoTDAlqV0owjHWiiPOuE8ECRyccAVT4bDWP29bA1
	wizA==
X-Gm-Message-State: APjAAAU9+L9azPtyRFHGuN1eQeNxQDYiWLvg2nleXjBU2kyiDZR6MuEK
	WKu0HKf7JMzAYTOjCuApLNSCENfyxtE=
X-Google-Smtp-Source: APXvYqylSbE2oCWfqOZ+ciGaVoUwDDjhiydbUmmFipHJwTdL7QyH6lCIvf90GsApC55vcvrIpclbUA==
X-Received: by 2002:a17:902:bd95:: with SMTP id
	q21mr35435241pls.159.1558298286396; 
	Sun, 19 May 2019 13:38:06 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231]) by smtp.gmail.com with ESMTPSA id
	i7sm11397448pfo.19.2019.05.19.13.38.05
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sun, 19 May 2019 13:38:05 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Sun, 19 May 2019 13:36:40 -0700
Message-Id: <20190519203726.20729-29-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190519203726.20729-1-richard.henderson@linaro.org>
References: <20190519203726.20729-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::642
Subject: [Qemu-devel] [PATCH v7 28/74] linux-user: Split out chmod, fchmod,
 fchmodat
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

Note that fchmodat is universally provided.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall-defs.h     |  5 +++++
 linux-user/strace.c           | 28 ----------------------------
 linux-user/syscall-file.inc.c | 30 ++++++++++++++++++++++++++++++
 linux-user/syscall.c          | 18 ------------------
 linux-user/strace.list        |  9 ---------
 5 files changed, 35 insertions(+), 55 deletions(-)

diff --git a/linux-user/syscall-defs.h b/linux-user/syscall-defs.h
index b5951e6911..3ddf8aa0e3 100644
--- a/linux-user/syscall-defs.h
+++ b/linux-user/syscall-defs.h
@@ -20,6 +20,9 @@ SYSCALL_DEF_FULL(brk, .impl = impl_brk,
                  .print_ret = print_syscall_ptr_ret,
                  .arg_type = { ARG_PTR });
 SYSCALL_DEF(chdir, ARG_STR);
+#ifdef TARGET_NR_chmod
+SYSCALL_DEF(chmod, ARG_STR, ARG_MODEFLAG);
+#endif
 SYSCALL_DEF_ARGS(clone, ARG_CLONEFLAG, ARG_PTR, ARG_PTR, ARG_PTR, ARG_PTR);
 SYSCALL_DEF(close, ARG_DEC);
 #ifdef TARGET_NR_creat
@@ -28,6 +31,8 @@ SYSCALL_DEF(creat, ARG_STR, ARG_MODEFLAG);
 SYSCALL_DEF(exit, ARG_DEC);
 SYSCALL_DEF(execve, ARG_STR, ARG_PTR, ARG_PTR);
 SYSCALL_DEF(execveat, ARG_ATDIRFD, ARG_STR, ARG_PTR, ARG_PTR, ARG_ATFLAG);
+SYSCALL_DEF(fchmod, ARG_DEC, ARG_MODEFLAG);
+SYSCALL_DEF(fchmodat, ARG_ATDIRFD, ARG_STR, ARG_MODEFLAG);
 #ifdef TARGET_NR_fork
 SYSCALL_DEF(fork);
 #endif
diff --git a/linux-user/strace.c b/linux-user/strace.c
index c70c06d965..4771badeb5 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -1125,19 +1125,6 @@ print_chroot(const struct syscallname *name,
 }
 #endif
 
-#ifdef TARGET_NR_chmod
-static void
-print_chmod(const struct syscallname *name,
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
 #ifdef TARGET_NR_clock_adjtime
 static void
 print_clock_adjtime(const struct syscallname *name,
@@ -1179,21 +1166,6 @@ print_faccessat(const struct syscallname *name,
 }
 #endif
 
-#ifdef TARGET_NR_fchmodat
-static void
-print_fchmodat(const struct syscallname *name,
-    abi_long arg0, abi_long arg1, abi_long arg2,
-    abi_long arg3, abi_long arg4, abi_long arg5)
-{
-    print_syscall_prologue(name);
-    print_at_dirfd(arg0, 0);
-    print_string(arg1, 0);
-    print_file_mode(arg2, 0);
-    print_flags(at_file_flags, arg3, 1);
-    print_syscall_epilogue(name);
-}
-#endif
-
 #ifdef TARGET_NR_fchownat
 static void
 print_fchownat(const struct syscallname *name,
diff --git a/linux-user/syscall-file.inc.c b/linux-user/syscall-file.inc.c
index 3adb629124..fb64d5bd1d 100644
--- a/linux-user/syscall-file.inc.c
+++ b/linux-user/syscall-file.inc.c
@@ -30,6 +30,26 @@ SYSCALL_IMPL(chdir)
     return ret;
 }
 
+static abi_long do_fchmodat(int dirfd, abi_ulong target_path, mode_t mode)
+{
+    char *p = lock_user_string(target_path);
+    abi_long ret;
+
+    if (!p) {
+        return -TARGET_EFAULT;
+    }
+    ret = get_errno(fchmodat(dirfd, p, mode, 0));
+    unlock_user(p, target_path, 0);
+    return ret;
+}
+
+#ifdef TARGET_NR_chmod
+SYSCALL_IMPL(chmod)
+{
+    return do_fchmodat(AT_FDCWD, arg1, arg2);
+}
+#endif
+
 SYSCALL_IMPL(close)
 {
     int fd = arg1;
@@ -54,6 +74,16 @@ SYSCALL_IMPL(creat)
 }
 #endif
 
+SYSCALL_IMPL(fchmod)
+{
+    return get_errno(fchmod(arg1, arg2));
+}
+
+SYSCALL_IMPL(fchmodat)
+{
+    return do_fchmodat(arg1, arg2, arg3);
+}
+
 static abi_long do_linkat(int olddirfd, abi_ulong target_oldpath,
                           int newdirfd, abi_ulong target_newpath,
                           int flags)
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 18163f558c..3c0de73aa4 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -5384,14 +5384,6 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
     void *p;
 
     switch(num) {
-#ifdef TARGET_NR_chmod
-    case TARGET_NR_chmod:
-        if (!(p = lock_user_string(arg1)))
-            return -TARGET_EFAULT;
-        ret = get_errno(chmod(p, arg2));
-        unlock_user(p, arg1, 0);
-        return ret;
-#endif
 #ifdef TARGET_NR_lseek
     case TARGET_NR_lseek:
         return get_errno(lseek(arg1, arg2, arg3));
@@ -6463,16 +6455,6 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
 #ifdef TARGET_NR_ftruncate
     case TARGET_NR_ftruncate:
         return get_errno(ftruncate(arg1, arg2));
-#endif
-    case TARGET_NR_fchmod:
-        return get_errno(fchmod(arg1, arg2));
-#if defined(TARGET_NR_fchmodat)
-    case TARGET_NR_fchmodat:
-        if (!(p = lock_user_string(arg2)))
-            return -TARGET_EFAULT;
-        ret = get_errno(fchmodat(arg1, p, arg3, 0));
-        unlock_user(p, arg2, 0);
-        return ret;
 #endif
     case TARGET_NR_getpriority:
         /* Note that negative values are valid for getpriority, so we must
diff --git a/linux-user/strace.list b/linux-user/strace.list
index f56d9acf76..0906aba812 100644
--- a/linux-user/strace.list
+++ b/linux-user/strace.list
@@ -61,9 +61,6 @@
 #ifdef TARGET_NR_capset
 { TARGET_NR_capset, "capset" , "%s(%p,%p)", NULL, NULL },
 #endif
-#ifdef TARGET_NR_chmod
-{ TARGET_NR_chmod, "chmod" , NULL, print_chmod, NULL },
-#endif
 #ifdef TARGET_NR_chown
 { TARGET_NR_chown, "chown" , NULL, NULL, NULL },
 #endif
@@ -169,12 +166,6 @@
 #ifdef TARGET_NR_fchdir
 { TARGET_NR_fchdir, "fchdir" , NULL, NULL, NULL },
 #endif
-#ifdef TARGET_NR_fchmod
-{ TARGET_NR_fchmod, "fchmod" , "%s(%d,%#o)", NULL, NULL },
-#endif
-#ifdef TARGET_NR_fchmodat
-{ TARGET_NR_fchmodat, "fchmodat" , NULL, print_fchmodat, NULL },
-#endif
 #ifdef TARGET_NR_fchown
 { TARGET_NR_fchown, "fchown" , "%s(%d,%d,%d)", NULL, NULL },
 #endif
-- 
2.17.1


