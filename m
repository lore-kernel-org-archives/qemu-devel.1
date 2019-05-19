Return-Path: <SRS0=v56/=TT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 657CCC04AB4
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 21:06:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E98520657
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 21:06:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nACouiip"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E98520657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53522 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hST0Y-0001aC-Bk
	for qemu-devel@archiver.kernel.org; Sun, 19 May 2019 17:06:14 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50421)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hSSZF-0003JD-6b
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:38:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hSSZD-0003uG-RA
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:38:01 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:36600)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hSSZD-0003t0-IC
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:37:59 -0400
Received: by mail-pl1-x642.google.com with SMTP id d21so5723736plr.3
	for <qemu-devel@nongnu.org>; Sun, 19 May 2019 13:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=H4vQIA+B5PMSizbcnaZO+HK/zsI+Heqt+lO8dDvIHmE=;
	b=nACouiip8p+PlsU6WPVxFUhzvBWGxmsSE4WlYsnUrnPAJCG7bxnmI7C3A4X1p6kvHM
	/hu1V+GNRJqJb2i5vHj5DcwV+PkzRBNdYIdn2MJdHWaNue+fNEv3mXBY5lEVhhh+pFeZ
	wao1yG2zYRQAC/d+yh92oPHvegNRGVqO5Jrr9KBSCkdRnBOonXB3VHteftuN8i4qyQcK
	AKlvaNy9cwp5v1wuKzQBTfpwD0ULEDm8zY4k3xzPtlq8bAG7R0fdv+SjIU2jmejygj6i
	2eHnRhRrwevU9pnUCK0JpVzUlOvd58UP888m+NoCCs7ELRQGRt9Wbtq6DpRX0g7qcDax
	Wvtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=H4vQIA+B5PMSizbcnaZO+HK/zsI+Heqt+lO8dDvIHmE=;
	b=p+u0Eieu1BG8P8hOyXL5Fo7MQFDyv4ZAsT71ApyQO9949vZiQaqsgUcCXV7FtGSFLW
	YraHbOQznizbuyIjLf6hBVFJoYjph7nRXrSdp6C5zMdEBpb86Kz4GBkvs4N29eNSIQH7
	8IPiBLpngauTdZJ9/GljJEOvHmw2mFp9gNEj2GGHmp07l+H/zeZ022Tf6fSJZxcXBsAP
	/YeqBn/M0VLpyS/5wXjpKpC7WYvuZL0Q64PbeF08dY3q+xE/Ve4wg5xm9nbGh+Jh6qx7
	C6uRUn4xjX16K6zM+0GbuUfRKWdigdxpfSqCOwTMf+/6MwvjZZJKEKhiehqa19Dx3cjq
	znMw==
X-Gm-Message-State: APjAAAWp5gyiWSs8Yv7FACqwrFk/icdj4K5xZlmZMxmLp3WvciMCIYrW
	c9VD5DNhKF7wWqIcQ8UqIpcJyJ3fvNo=
X-Google-Smtp-Source: APXvYqz3xuzyYYeRKGnw4pR8cCVIxg78fQnnc5EUNUnxjx7z4zlUIxX3USiFGyJnM+D8PsRxguVFXA==
X-Received: by 2002:a17:902:70c6:: with SMTP id
	l6mr54071306plt.84.1558298278338; 
	Sun, 19 May 2019 13:37:58 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231]) by smtp.gmail.com with ESMTPSA id
	i7sm11397448pfo.19.2019.05.19.13.37.57
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sun, 19 May 2019 13:37:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Sun, 19 May 2019 13:36:34 -0700
Message-Id: <20190519203726.20729-23-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190519203726.20729-1-richard.henderson@linaro.org>
References: <20190519203726.20729-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::642
Subject: [Qemu-devel] [PATCH v7 22/74] linux-user: Split out unlink, unlinkat,
 rmdir
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

Note that unlinkat is universally provided.
Implement rmdir in terms of unlinkat.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall-defs.h     |  7 ++++++
 linux-user/syscall.h          |  1 +
 linux-user/strace.c           | 43 ++++-------------------------------
 linux-user/syscall-file.inc.c | 32 ++++++++++++++++++++++++++
 linux-user/syscall.c          | 24 -------------------
 linux-user/strace.list        |  9 --------
 6 files changed, 44 insertions(+), 72 deletions(-)

diff --git a/linux-user/syscall-defs.h b/linux-user/syscall-defs.h
index 41dd887dbc..78d3f600eb 100644
--- a/linux-user/syscall-defs.h
+++ b/linux-user/syscall-defs.h
@@ -98,6 +98,9 @@ SYSCALL_DEF(readlink, ARG_STR, ARG_PTR, ARG_DEC);
 SYSCALL_DEF(readlinkat, ARG_ATDIRFD, ARG_STR, ARG_PTR, ARG_DEC);
 #endif
 SYSCALL_DEF(readv, ARG_DEC, ARG_PTR, ARG_DEC);
+#ifdef TARGET_NR_rmdir
+SYSCALL_DEF(rmdir, ARG_STR);
+#endif
 #if !defined(SYSCALL_TABLE) || defined(TARGET_NR_semctl)
 SYSCALL_DEF(semctl, ARG_DEC, ARG_DEC, ARG_DEC, ARG_HEX);
 #endif
@@ -121,6 +124,10 @@ SYSCALL_DEF(shmdt, ARG_PTR);
 #if !defined(SYSCALL_TABLE) || defined(TARGET_NR_shmget)
 SYSCALL_DEF(shmget, ARG_DEC, ARG_DEC, ARG_HEX);
 #endif
+#ifdef TARGET_NR_unlink
+SYSCALL_DEF(unlink, ARG_STR);
+#endif
+SYSCALL_DEF(unlinkat, ARG_ATDIRFD, ARG_STR, ARG_UNLINKATFLAG);
 #ifdef TARGET_NR_vfork
 /* Emulate vfork() with fork().  */
 SYSCALL_DEF_FULL(vfork, .impl = impl_fork);
diff --git a/linux-user/syscall.h b/linux-user/syscall.h
index f75cd3ddd0..bdc4d653c4 100644
--- a/linux-user/syscall.h
+++ b/linux-user/syscall.h
@@ -63,6 +63,7 @@ typedef enum {
     ARG_MMAPPROT,
     ARG_MODEFLAG,
     ARG_OPENFLAG,
+    ARG_UNLINKATFLAG,
 
     /* These are interpreted as pointers.  */
     ARG_PTR,
diff --git a/linux-user/strace.c b/linux-user/strace.c
index feb8ec7c09..9ac0b859da 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -684,7 +684,7 @@ static struct flags const at_file_flags[] = {
     FLAG_END,
 };
 
-UNUSED static struct flags unlinkat_flags[] = {
+static struct flags const unlinkat_flags[] = {
 #ifdef AT_REMOVEDIR
     FLAG_GENERIC(AT_REMOVEDIR),
 #endif
@@ -1810,18 +1810,6 @@ print_mkdirat(const struct syscallname *name,
 }
 #endif
 
-#ifdef TARGET_NR_rmdir
-static void
-print_rmdir(const struct syscallname *name,
-    abi_long arg0, abi_long arg1, abi_long arg2,
-    abi_long arg3, abi_long arg4, abi_long arg5)
-{
-    print_syscall_prologue(name);
-    print_string(arg0, 0);
-    print_syscall_epilogue(name);
-}
-#endif
-
 #ifdef TARGET_NR_rt_sigaction
 static void
 print_rt_sigaction(const struct syscallname *name,
@@ -2187,32 +2175,6 @@ print_umount2(const struct syscallname *name,
 }
 #endif
 
-#ifdef TARGET_NR_unlink
-static void
-print_unlink(const struct syscallname *name,
-    abi_long arg0, abi_long arg1, abi_long arg2,
-    abi_long arg3, abi_long arg4, abi_long arg5)
-{
-    print_syscall_prologue(name);
-    print_string(arg0, 1);
-    print_syscall_epilogue(name);
-}
-#endif
-
-#ifdef TARGET_NR_unlinkat
-static void
-print_unlinkat(const struct syscallname *name,
-    abi_long arg0, abi_long arg1, abi_long arg2,
-    abi_long arg3, abi_long arg4, abi_long arg5)
-{
-    print_syscall_prologue(name);
-    print_at_dirfd(arg0, 0);
-    print_string(arg1, 0);
-    print_flags(unlinkat_flags, arg2, 1);
-    print_syscall_epilogue(name);
-}
-#endif
-
 #ifdef TARGET_NR_utime
 static void
 print_utime(const struct syscallname *name,
@@ -2475,6 +2437,9 @@ static void print_syscall_def1(const SyscallDef *def, int64_t args[6])
         case ARG_OPENFLAG:
             len = add_open_flags(b, rest, arg);
             break;
+        case ARG_UNLINKATFLAG:
+            len = add_flags(b, rest, unlinkat_flags, arg, true);
+            break;
         case ARG_PTR:
             len = add_pointer(b, rest, arg);
             break;
diff --git a/linux-user/syscall-file.inc.c b/linux-user/syscall-file.inc.c
index 440ff5ed14..5acd8ecc10 100644
--- a/linux-user/syscall-file.inc.c
+++ b/linux-user/syscall-file.inc.c
@@ -662,6 +662,38 @@ SYSCALL_IMPL(readlinkat)
 }
 #endif
 
+static abi_long do_unlinkat(int dirfd, abi_ulong target_path, int flags)
+{
+    char *p = lock_user_string(target_path);
+    abi_long ret;
+
+    if (!p) {
+        return -TARGET_EFAULT;
+    }
+    ret = get_errno(unlinkat(dirfd, p, flags));
+    unlock_user(p, target_path, 0);
+    return ret;
+}
+
+#ifdef TARGET_NR_unlink
+SYSCALL_IMPL(unlink)
+{
+    return do_unlinkat(AT_FDCWD, arg1, 0);
+}
+#endif
+
+#ifdef TARGET_NR_rmdir
+SYSCALL_IMPL(rmdir)
+{
+    return do_unlinkat(AT_FDCWD, arg1, AT_REMOVEDIR);
+}
+#endif
+
+SYSCALL_IMPL(unlinkat)
+{
+    return do_unlinkat(arg1, arg2, arg3);
+}
+
 SYSCALL_IMPL(write)
 {
     int fd = arg1;
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 865129df9e..53e108b614 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -5383,22 +5383,6 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
     void *p;
 
     switch(num) {
-#ifdef TARGET_NR_unlink
-    case TARGET_NR_unlink:
-        if (!(p = lock_user_string(arg1)))
-            return -TARGET_EFAULT;
-        ret = get_errno(unlink(p));
-        unlock_user(p, arg1, 0);
-        return ret;
-#endif
-#if defined(TARGET_NR_unlinkat)
-    case TARGET_NR_unlinkat:
-        if (!(p = lock_user_string(arg2)))
-            return -TARGET_EFAULT;
-        ret = get_errno(unlinkat(arg1, p, arg3));
-        unlock_user(p, arg2, 0);
-        return ret;
-#endif
     case TARGET_NR_execve:
         {
             char **argp, **envp;
@@ -5790,14 +5774,6 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         ret = get_errno(mkdirat(arg1, p, arg3));
         unlock_user(p, arg2, 0);
         return ret;
-#endif
-#ifdef TARGET_NR_rmdir
-    case TARGET_NR_rmdir:
-        if (!(p = lock_user_string(arg1)))
-            return -TARGET_EFAULT;
-        ret = get_errno(rmdir(p));
-        unlock_user(p, arg1, 0);
-        return ret;
 #endif
     case TARGET_NR_dup:
         ret = get_errno(dup(arg1));
diff --git a/linux-user/strace.list b/linux-user/strace.list
index f3c54cec69..f08ddaddac 100644
--- a/linux-user/strace.list
+++ b/linux-user/strace.list
@@ -527,9 +527,6 @@
 #ifdef TARGET_NR_mkdirat
 { TARGET_NR_mkdirat, "mkdirat" , NULL, print_mkdirat, NULL },
 #endif
-#ifdef TARGET_NR_rmdir
-{ TARGET_NR_rmdir, "rmdir" , NULL, print_rmdir, NULL },
-#endif
 #ifdef TARGET_NR_mknod
 { TARGET_NR_mknod, "mknod" , NULL, print_mknod, NULL },
 #endif
@@ -1425,12 +1422,6 @@
 #ifdef TARGET_NR_uname
 { TARGET_NR_uname, "uname" , "%s(%p)", NULL, NULL },
 #endif
-#ifdef TARGET_NR_unlink
-{ TARGET_NR_unlink, "unlink" , NULL, print_unlink, NULL },
-#endif
-#ifdef TARGET_NR_unlinkat
-{ TARGET_NR_unlinkat, "unlinkat" , NULL, print_unlinkat, NULL },
-#endif
 #ifdef TARGET_NR_unshare
 { TARGET_NR_unshare, "unshare" , NULL, NULL, NULL },
 #endif
-- 
2.17.1


