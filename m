Return-Path: <SRS0=v56/=TT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A17FC04AB4
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 20:52:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D1CE20644
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 20:52:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="knfgDER3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D1CE20644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53312 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSSmy-0006ZD-Fn
	for qemu-devel@archiver.kernel.org; Sun, 19 May 2019 16:52:12 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50198)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hSSYz-0002tD-Ow
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:37:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hSSYy-0003b4-JV
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:37:45 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:36502)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hSSYy-0003aB-Cd
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:37:44 -0400
Received: by mail-pf1-x443.google.com with SMTP id v80so6171244pfa.3
	for <qemu-devel@nongnu.org>; Sun, 19 May 2019 13:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=JWb0gO0FR8omCjsq9CBOm7HqleJuQXyRTIuggbhXR0I=;
	b=knfgDER37TXLkkIf/7urgSaz0r/SfBFbkjvXw/XiP6sLx4w7eklJiFggC3UDYdDaqx
	tUhha63z+Hg5ScSWxjc6KAo1snLcAFEZfsx9RhgITT0zYdt6B6L55bUKfe/oxpk0YCh5
	4UEyMJYIMSpSlIhzNZy2QF6HrMAfzyDWMCYbFVWkB1AMa2Eh8AkQGHAQ0pnyVVeeABki
	CB13GMOWkZWUZ+zWPHpe7qpBnC2H4j8QIcBoTfBOvS1QinQ3bE1LNpaDhg2eNNGYgg+D
	4MxCDiaCljbi0qfnbrwygoTy1droAfjhFvlgEKtYFgOJT14E6lczRaMx/SRMOfiPkU+/
	r+8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=JWb0gO0FR8omCjsq9CBOm7HqleJuQXyRTIuggbhXR0I=;
	b=o0XgaY4O6Owu052mgraC7SvgORdcXjpuyoo/BYpFMwO4us+JRav8Q0lRxBxfYhSD7J
	QH1xqmb/CB3q8Pz56zwZ90txPU4cVMHF5gr2COlWqWIx4+aF5RMgm46Fhv5CYZ2dv7Z8
	nYCWal1YC//pPPBQ4rkVeJSps8S6BcGh8vnKKB29qvsNA/Mqxu/I18iClm+ev7EH5ih3
	qgCGA+1SCQBzTuLS8itoTlywPpmzxhvMNX5IY4QDzbd4Bzw6H4WedMIr+hu/dPgG0Fl1
	vSshQ1e/GFolKuBPPtwK+1/xrv0PqIh1qIYNSwIccJjPJy0kLQbExJR1CoP2uxTYeZSE
	ix/A==
X-Gm-Message-State: APjAAAWtXEwPnraL+053KOK5w+LxN94ZpLnC7ox9to9/XvlBXSHYS/q2
	1JA8JXQBeebpR4EPkLWPnyTR6A3PEyA=
X-Google-Smtp-Source: APXvYqyAZJcngqF2tvZH9/7vdmup1/QLo1BotSTkGU0X9v8tlu3q+nZNvjrMzqe9zIO4234YQO/itQ==
X-Received: by 2002:a62:4281:: with SMTP id h1mr76213248pfd.162.1558298262235; 
	Sun, 19 May 2019 13:37:42 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231]) by smtp.gmail.com with ESMTPSA id
	i7sm11397448pfo.19.2019.05.19.13.37.41
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sun, 19 May 2019 13:37:41 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Sun, 19 May 2019 13:36:21 -0700
Message-Id: <20190519203726.20729-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190519203726.20729-1-richard.henderson@linaro.org>
References: <20190519203726.20729-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::443
Subject: [Qemu-devel] [PATCH v7 09/74] linux-user: Split out readv, writev
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
 linux-user/syscall-defs.h     |  2 ++
 linux-user/syscall-file.inc.c | 34 ++++++++++++++++++++++++++++++++++
 linux-user/syscall.c          | 22 ----------------------
 linux-user/strace.list        |  6 ------
 4 files changed, 36 insertions(+), 28 deletions(-)

diff --git a/linux-user/syscall-defs.h b/linux-user/syscall-defs.h
index b031de1375..130ba7e344 100644
--- a/linux-user/syscall-defs.h
+++ b/linux-user/syscall-defs.h
@@ -28,4 +28,6 @@ SYSCALL_DEF(readlink, ARG_STR, ARG_PTR, ARG_DEC);
 #ifdef TARGET_NR_readlinkat
 SYSCALL_DEF(readlinkat, ARG_ATDIRFD, ARG_STR, ARG_PTR, ARG_DEC);
 #endif
+SYSCALL_DEF(readv, ARG_DEC, ARG_PTR, ARG_DEC);
 SYSCALL_DEF(write, ARG_DEC, ARG_PTR, ARG_DEC);
+SYSCALL_DEF(writev, ARG_DEC, ARG_PTR, ARG_DEC);
diff --git a/linux-user/syscall-file.inc.c b/linux-user/syscall-file.inc.c
index e6adcc351c..2297ca1760 100644
--- a/linux-user/syscall-file.inc.c
+++ b/linux-user/syscall-file.inc.c
@@ -349,6 +349,23 @@ SYSCALL_IMPL(read)
     return ret;
 }
 
+SYSCALL_IMPL(readv)
+{
+    int fd = arg1;
+    abi_ulong target_vec = arg2;
+    int count = arg3;
+    struct iovec *vec = lock_iovec(VERIFY_WRITE, target_vec, count, 0);
+    abi_long ret;
+
+    if (vec != NULL) {
+        ret = get_errno(safe_readv(fd, vec, count));
+        unlock_iovec(vec, target_vec, count, 1);
+    } else {
+        ret = -host_to_target_errno(errno);
+    }
+    return ret;
+}
+
 static abi_long do_readlinkat(int dirfd, abi_ulong target_path,
                               abi_ulong target_buf, abi_ulong bufsiz)
 {
@@ -425,3 +442,20 @@ SYSCALL_IMPL(write)
     unlock_user(p, target_p, 0);
     return ret;
 }
+
+SYSCALL_IMPL(writev)
+{
+    int fd = arg1;
+    abi_ulong target_vec = arg2;
+    int count = arg3;
+    struct iovec *vec = lock_iovec(VERIFY_READ, target_vec, count, 1);
+    abi_long ret;
+
+    if (vec != NULL) {
+        ret = get_errno(safe_writev(fd, vec, count));
+        unlock_iovec(vec, target_vec, count, 0);
+    } else {
+        ret = -host_to_target_errno(errno);
+    }
+    return ret;
+}
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 61cd73db26..8086626707 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -9005,28 +9005,6 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         /* NOTE: the flock constant seems to be the same for every
            Linux platform */
         return get_errno(safe_flock(arg1, arg2));
-    case TARGET_NR_readv:
-        {
-            struct iovec *vec = lock_iovec(VERIFY_WRITE, arg2, arg3, 0);
-            if (vec != NULL) {
-                ret = get_errno(safe_readv(arg1, vec, arg3));
-                unlock_iovec(vec, arg2, arg3, 1);
-            } else {
-                ret = -host_to_target_errno(errno);
-            }
-        }
-        return ret;
-    case TARGET_NR_writev:
-        {
-            struct iovec *vec = lock_iovec(VERIFY_READ, arg2, arg3, 1);
-            if (vec != NULL) {
-                ret = get_errno(safe_writev(arg1, vec, arg3));
-                unlock_iovec(vec, arg2, arg3, 0);
-            } else {
-                ret = -host_to_target_errno(errno);
-            }
-        }
-        return ret;
 #if defined(TARGET_NR_preadv)
     case TARGET_NR_preadv:
         {
diff --git a/linux-user/strace.list b/linux-user/strace.list
index 2d6bfec692..c4ae70b485 100644
--- a/linux-user/strace.list
+++ b/linux-user/strace.list
@@ -1073,9 +1073,6 @@
 #ifdef TARGET_NR_readdir
 { TARGET_NR_readdir, "readdir" , NULL, NULL, NULL },
 #endif
-#ifdef TARGET_NR_readv
-{ TARGET_NR_readv, "readv" , NULL, NULL, NULL },
-#endif
 #ifdef TARGET_NR_reboot
 { TARGET_NR_reboot, "reboot" , NULL, NULL, NULL },
 #endif
@@ -1608,9 +1605,6 @@
 #ifdef TARGET_NR_waitpid
 { TARGET_NR_waitpid, "waitpid" , "%s(%d,%p,%#x)", NULL, NULL },
 #endif
-#ifdef TARGET_NR_writev
-{ TARGET_NR_writev, "writev" , "%s(%d,%p,%#x)", NULL, NULL },
-#endif
 #ifdef TARGET_NR_utimensat
 { TARGET_NR_utimensat, "utimensat", NULL, print_utimensat, NULL },
 #endif
-- 
2.17.1


