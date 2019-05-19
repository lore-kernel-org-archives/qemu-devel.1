Return-Path: <SRS0=v56/=TT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E423CC04AB4
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 21:05:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E13720657
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 21:05:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="saXIpHPF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E13720657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53485 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSSzW-0000d1-TH
	for qemu-devel@archiver.kernel.org; Sun, 19 May 2019 17:05:10 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50501)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hSSZL-0003TC-WA
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:38:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hSSZK-00042Z-P9
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:38:07 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:44491)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hSSZK-00041r-J9
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:38:06 -0400
Received: by mail-pf1-x444.google.com with SMTP id g9so6148914pfo.11
	for <qemu-devel@nongnu.org>; Sun, 19 May 2019 13:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=fRvp/VN2Xlfqmt4nKVHNXMxYTCjiSrkuQdi+a73ymGo=;
	b=saXIpHPF2AKzen0wYa8bg8Wg7/NPOHshxt0TUVYcXLf1To1FkBuGZ6HTgamFMDGvci
	PQfF4jY9aPDPL0kHQQmMpl2PVOM7GzNd6zFE9UZbU39JGbvey/AcgVIJhKP9+gMqZiLJ
	XeR3QA4lXotuv92ui6yEKoYuXScDTKgClGo/V+TzRLUeRXAAte/l6PLTr8koly2Mf5vf
	3/3xZmzyZWc4n42ET7VZrW/2tUs25C6ereWlDFq9Bg8c+JMKGfRtt4wm/3EI+0ijuetT
	ETL632AGiMr0Nadu52EBg87eLH3cfmjH4431/z3/8dQGB9LCQSKVx6AEpIDpWIp05yUI
	b4+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=fRvp/VN2Xlfqmt4nKVHNXMxYTCjiSrkuQdi+a73ymGo=;
	b=Xif5altTVZ9E5QcvKpeKpXo9JluiBYe63tLvbYVJtvpBmyZZfMX2oTtyFEGmVrFaRm
	ITL0mjiygw0CXifXsltZHK9K7GnNaSP4/JJq7CJ4UIJcH1clgh4/Ozhh/mKtjY2AUTwX
	nq/SsovkWC+0TuvgbsJDfcC0htYIfHb66PL4JaVSS5GwtberqAzgXCEqvW8mImljTmYy
	M46fgEL6tahyR7aHxaR34Ml4iWwCjjv2DqzrIBdRFtp0dCJM/qmFGUcDXBTSz274ClWv
	bHagwlTKvfAr2tM8/Df+UUn7NZQN0gTSrsg65Zopmepj5NRsaMJSM5bY0nxXAPWnihrN
	qw6g==
X-Gm-Message-State: APjAAAUDfgM46Y+gBbY0O21Vuby7Zp6T/icyHVjxyLs6OmDHX+Xhwe8e
	LLl2Xs15z6H0sVr8QRqX6XnRCzUrptE=
X-Google-Smtp-Source: APXvYqze9d3JDpIbdy1mVHJfyB6DxyobkyOky0PKiqLL5/pwoL9MzPY9zPyYGDsj2cqZSZ4GGQF5MA==
X-Received: by 2002:a62:38cc:: with SMTP id f195mr76083842pfa.15.1558298285319;
	Sun, 19 May 2019 13:38:05 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231]) by smtp.gmail.com with ESMTPSA id
	i7sm11397448pfo.19.2019.05.19.13.38.03
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sun, 19 May 2019 13:38:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Sun, 19 May 2019 13:36:39 -0700
Message-Id: <20190519203726.20729-28-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190519203726.20729-1-richard.henderson@linaro.org>
References: <20190519203726.20729-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::444
Subject: [Qemu-devel] [PATCH v7 27/74] linux-user: Split out mknod, mknodat
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

Note that mknodat is universally provided.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall-defs.h     |  4 ++++
 linux-user/strace.c           | 39 -----------------------------------
 linux-user/syscall-file.inc.c | 26 +++++++++++++++++++++++
 linux-user/syscall.c          | 16 --------------
 linux-user/strace.list        |  6 ------
 5 files changed, 30 insertions(+), 61 deletions(-)

diff --git a/linux-user/syscall-defs.h b/linux-user/syscall-defs.h
index 9950b73e76..b5951e6911 100644
--- a/linux-user/syscall-defs.h
+++ b/linux-user/syscall-defs.h
@@ -38,6 +38,10 @@ SYSCALL_DEF_ARGS(ipc, ARG_HEX, ARG_DEC, ARG_DEC, ARG_HEX, ARG_PTR, ARG_HEX);
 SYSCALL_DEF(link, ARG_STR, ARG_STR);
 #endif
 SYSCALL_DEF(linkat, ARG_ATDIRFD, ARG_STR, ARG_ATDIRFD, ARG_STR, ARG_ATFLAG);
+#ifdef TARGET_NR_mknod
+SYSCALL_DEF(mknod, ARG_STR, ARG_MODEFLAG, ARG_HEX);
+#endif
+SYSCALL_DEF(mknodat, ARG_ATDIRFD, ARG_STR, ARG_MODEFLAG, ARG_HEX);
 SYSCALL_DEF(mlock, ARG_PTR, ARG_DEC);
 SYSCALL_DEF(mlockall, ARG_HEX);
 #ifdef TARGET_NR_mmap
diff --git a/linux-user/strace.c b/linux-user/strace.c
index b234274034..c70c06d965 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -1923,45 +1923,6 @@ print_syslog(const struct syscallname *name,
 }
 #endif
 
-#ifdef TARGET_NR_mknod
-static void
-print_mknod(const struct syscallname *name,
-    abi_long arg0, abi_long arg1, abi_long arg2,
-    abi_long arg3, abi_long arg4, abi_long arg5)
-{
-    int hasdev = (arg1 & (S_IFCHR|S_IFBLK));
-
-    print_syscall_prologue(name);
-    print_string(arg0, 0);
-    print_file_mode(arg1, (hasdev == 0));
-    if (hasdev) {
-        print_raw_param("makedev(%d", major(arg2), 0);
-        print_raw_param("%d)", minor(arg2), 1);
-    }
-    print_syscall_epilogue(name);
-}
-#endif
-
-#ifdef TARGET_NR_mknodat
-static void
-print_mknodat(const struct syscallname *name,
-    abi_long arg0, abi_long arg1, abi_long arg2,
-    abi_long arg3, abi_long arg4, abi_long arg5)
-{
-    int hasdev = (arg2 & (S_IFCHR|S_IFBLK));
-
-    print_syscall_prologue(name);
-    print_at_dirfd(arg0, 0);
-    print_string(arg1, 0);
-    print_file_mode(arg2, (hasdev == 0));
-    if (hasdev) {
-        print_raw_param("makedev(%d", major(arg3), 0);
-        print_raw_param("%d)", minor(arg3), 1);
-    }
-    print_syscall_epilogue(name);
-}
-#endif
-
 #ifdef TARGET_NR_mq_open
 static void
 print_mq_open(const struct syscallname *name,
diff --git a/linux-user/syscall-file.inc.c b/linux-user/syscall-file.inc.c
index 76637fe71b..3adb629124 100644
--- a/linux-user/syscall-file.inc.c
+++ b/linux-user/syscall-file.inc.c
@@ -82,6 +82,32 @@ SYSCALL_IMPL(linkat)
     return do_linkat(arg1, arg2, arg3, arg4, arg5);
 }
 
+static abi_long do_mknodat(int dirfd, abi_ulong target_path,
+                           mode_t mode, dev_t dev)
+{
+    char *p = lock_user_string(target_path);
+    abi_long ret;
+
+    if (!p) {
+        return -TARGET_EFAULT;
+    }
+    ret = get_errno(mknodat(dirfd, p, mode, dev));
+    unlock_user(p, target_path, 0);
+    return ret;
+}
+
+#ifdef TARGET_NR_mknod
+SYSCALL_IMPL(mknod)
+{
+    return do_mknodat(AT_FDCWD, arg1, arg2, arg3);
+}
+#endif
+
+SYSCALL_IMPL(mknodat)
+{
+    return do_mknodat(arg1, arg2, arg3, arg4);
+}
+
 /*
  * Helpers for do_openat, manipulating /proc/self/foo.
  */
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index ea89734706..18163f558c 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -5384,22 +5384,6 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
     void *p;
 
     switch(num) {
-#ifdef TARGET_NR_mknod
-    case TARGET_NR_mknod:
-        if (!(p = lock_user_string(arg1)))
-            return -TARGET_EFAULT;
-        ret = get_errno(mknod(p, arg2, arg3));
-        unlock_user(p, arg1, 0);
-        return ret;
-#endif
-#if defined(TARGET_NR_mknodat)
-    case TARGET_NR_mknodat:
-        if (!(p = lock_user_string(arg2)))
-            return -TARGET_EFAULT;
-        ret = get_errno(mknodat(arg1, p, arg3, arg4));
-        unlock_user(p, arg2, 0);
-        return ret;
-#endif
 #ifdef TARGET_NR_chmod
     case TARGET_NR_chmod:
         if (!(p = lock_user_string(arg1)))
diff --git a/linux-user/strace.list b/linux-user/strace.list
index 95706a696b..f56d9acf76 100644
--- a/linux-user/strace.list
+++ b/linux-user/strace.list
@@ -518,12 +518,6 @@
 #ifdef TARGET_NR_mkdirat
 { TARGET_NR_mkdirat, "mkdirat" , NULL, print_mkdirat, NULL },
 #endif
-#ifdef TARGET_NR_mknod
-{ TARGET_NR_mknod, "mknod" , NULL, print_mknod, NULL },
-#endif
-#ifdef TARGET_NR_mknodat
-{ TARGET_NR_mknodat, "mknodat" , NULL, print_mknodat, NULL },
-#endif
 #ifdef TARGET_NR_modify_ldt
 { TARGET_NR_modify_ldt, "modify_ldt" , NULL, NULL, NULL },
 #endif
-- 
2.17.1


