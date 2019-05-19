Return-Path: <SRS0=v56/=TT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D895C04AB4
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 21:18:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC1F120449
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 21:18:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JchIpMmG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC1F120449
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53698 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSTC5-0004AT-W8
	for qemu-devel@archiver.kernel.org; Sun, 19 May 2019 17:18:10 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50744)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hSSZf-0003et-AW
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:38:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hSSZd-0004QM-OO
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:38:27 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:34263)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hSSZd-0004NW-Fj
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:38:25 -0400
Received: by mail-pf1-x441.google.com with SMTP id n19so6182901pfa.1
	for <qemu-devel@nongnu.org>; Sun, 19 May 2019 13:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=tO0MYq1BfTpb+Rq4mEcLzQaoCNhvveoe+wDeU1tkEl4=;
	b=JchIpMmGQzlbAZh0Xr/Y31cWysRgPDnxvatEZVGc5KkGSEl2yUXMqvnEs+txrnxyC+
	KdzXK7cQVKuDZlXiLAOET5jWNVefAscgas8GkF3SP98bTlJlHJkbW8jUo3VaZdlE+SML
	E9FIS1LLNZiA3vQIF8fgyLbkV+7TA5ahQj7mshVzGARXKUbu3RR7YwHlMkJdhSXXvJ9L
	MccM4nuagbwuR3YzpzvYXhZiqTliEIQ6E+sqwEZT2JnKrPGrRn9Xgz0yfHyDNvbFJu4A
	4/Nl72R2oeUROVd81jfY+/73eYzYdN4tXSs23Lw+BxFayExackAZTKl+OoGyWOVDox//
	7tOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=tO0MYq1BfTpb+Rq4mEcLzQaoCNhvveoe+wDeU1tkEl4=;
	b=QYvrQfURLoO/nM9+W9L0yGVBl9VtTxGFplBQwstuJMbG/vi7RXWNjpTWl9C4NGQk9z
	NWPPDAX2RPa1sN7+MxplUXJSGdT/vT1klibujI3y5cDjASIGeVJnNJmE9qNjKYqVuGqx
	jt+RYt6DteFfV4LS+UApfsKIkmRFDtwoPkk9LNGy5W0pkVdAT9mfGdiT9hyjBXplbuxR
	hoY3dPsFMmZUhkGMZhGZc4lJ6BnkGEw4Dr0/KLn3yYoEAgSQh33XJi3eYxZN2m4TNb2h
	MvjBWJp8/6RlMrO+D+D5OZvS6YbVzfwmxVHeM2q3x7zfDJxKD86+f99Khkrl+sLdNehB
	JEbw==
X-Gm-Message-State: APjAAAWKzRuKxRpz8Z/yCXy3p62U3PqC9usSXHZV4sokW8m0R59/tvK5
	e8/BlbihOL3RqbmuzV9yWR+Uun7XivQ=
X-Google-Smtp-Source: APXvYqyoELX56gHUfCD3HGgaen/oc0rBemdA25wNQp66cpePhFnuStg+y/GZS9tbG/A8WZU0l6YznQ==
X-Received: by 2002:a65:5c89:: with SMTP id a9mr71874534pgt.334.1558298303006; 
	Sun, 19 May 2019 13:38:23 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231]) by smtp.gmail.com with ESMTPSA id
	i7sm11397448pfo.19.2019.05.19.13.38.21
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sun, 19 May 2019 13:38:22 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Sun, 19 May 2019 13:36:54 -0700
Message-Id: <20190519203726.20729-43-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190519203726.20729-1-richard.henderson@linaro.org>
References: <20190519203726.20729-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::441
Subject: [Qemu-devel] [PATCH v7 42/74] linux-user: Split out dup, dup2, dup3
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

Note that dup3 is universally available for guests.
Implement host support with syscall when !CONFIG_DUP3.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall-defs.h     |  5 +++++
 linux-user/syscall-file.inc.c | 42 +++++++++++++++++++++++++++++++++++
 linux-user/syscall.c          | 33 +++------------------------
 linux-user/strace.list        |  6 -----
 4 files changed, 50 insertions(+), 36 deletions(-)

diff --git a/linux-user/syscall-defs.h b/linux-user/syscall-defs.h
index 8b6d8f75ff..062adddd75 100644
--- a/linux-user/syscall-defs.h
+++ b/linux-user/syscall-defs.h
@@ -34,6 +34,11 @@ SYSCALL_DEF(close, ARG_DEC);
 #ifdef TARGET_NR_creat
 SYSCALL_DEF(creat, ARG_STR, ARG_MODEFLAG);
 #endif
+SYSCALL_DEF(dup, ARG_DEC);
+#ifdef TARGET_NR_dup2
+SYSCALL_DEF(dup2, ARG_DEC, ARG_DEC);
+#endif
+SYSCALL_DEF(dup3, ARG_DEC, ARG_DEC, ARG_OPENFLAG);
 SYSCALL_DEF(exit, ARG_DEC);
 SYSCALL_DEF(execve, ARG_STR, ARG_PTR, ARG_PTR);
 SYSCALL_DEF(execveat, ARG_ATDIRFD, ARG_STR, ARG_PTR, ARG_PTR, ARG_ATFLAG);
diff --git a/linux-user/syscall-file.inc.c b/linux-user/syscall-file.inc.c
index 5ed8b78c79..7d97dd1ec1 100644
--- a/linux-user/syscall-file.inc.c
+++ b/linux-user/syscall-file.inc.c
@@ -94,6 +94,48 @@ SYSCALL_IMPL(creat)
 }
 #endif
 
+SYSCALL_IMPL(dup)
+{
+    abi_long ret = get_errno(dup(arg1));
+    if (ret >= 0) {
+        fd_trans_dup(arg1, ret);
+    }
+    return ret;
+}
+
+#ifdef TARGET_NR_dup2
+SYSCALL_IMPL(dup2)
+{
+    abi_long ret = get_errno(dup2(arg1, arg2));
+    if (ret >= 0) {
+        fd_trans_dup(arg1, arg2);
+    }
+    return ret;
+}
+#endif
+
+SYSCALL_IMPL(dup3)
+{
+    int ofd = arg1;
+    int nfd = arg2;
+    int host_flags = target_to_host_bitmask(arg3, fcntl_flags_tbl);
+    abi_long ret;
+
+#ifdef CONFIG_DUP3
+    ret = dup3(ofd, nfd, host_flags);
+#else
+    if (host_flags == 0) {
+        if (ofd == nfd) {
+            return -TARGET_EINVAL;
+        }
+        ret = dup2(ofd, nfd);
+    } else {
+        ret = syscall(__NR_dup3, ofd, nfd, host_flags);
+    }
+#endif
+    return get_errno(ret);
+}
+
 SYSCALL_IMPL(faccessat)
 {
     return do_faccessat(arg1, arg2, arg3);
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 0d6a9b7a6c..bab9a57ee0 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -204,6 +204,9 @@ _syscall0(int, sys_gettid)
  * Performing a bogus syscall is easier than boilerplating
  * the replacement functions here in C.
  */
+#ifndef __NR_dup3
+#define __NR_dup3  -1
+#endif
 #ifndef __NR_syncfs
 #define __NR_syncfs  -1
 #endif
@@ -5373,12 +5376,6 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
     void *p;
 
     switch(num) {
-    case TARGET_NR_dup:
-        ret = get_errno(dup(arg1));
-        if (ret >= 0) {
-            fd_trans_dup(arg1, ret);
-        }
-        return ret;
 #ifdef TARGET_NR_pipe
     case TARGET_NR_pipe:
         return do_pipe(cpu_env, arg1, 0, 0);
@@ -5433,30 +5430,6 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         ret = get_errno(chroot(p));
         unlock_user(p, arg1, 0);
         return ret;
-#ifdef TARGET_NR_dup2
-    case TARGET_NR_dup2:
-        ret = get_errno(dup2(arg1, arg2));
-        if (ret >= 0) {
-            fd_trans_dup(arg1, arg2);
-        }
-        return ret;
-#endif
-#if defined(CONFIG_DUP3) && defined(TARGET_NR_dup3)
-    case TARGET_NR_dup3:
-    {
-        int host_flags;
-
-        if ((arg3 & ~TARGET_O_CLOEXEC) != 0) {
-            return -EINVAL;
-        }
-        host_flags = target_to_host_bitmask(arg3, fcntl_flags_tbl);
-        ret = get_errno(dup3(arg1, arg2, host_flags));
-        if (ret >= 0) {
-            fd_trans_dup(arg1, arg2);
-        }
-        return ret;
-    }
-#endif
 #ifdef TARGET_NR_getpgrp
     case TARGET_NR_getpgrp:
         return get_errno(getpgrp());
diff --git a/linux-user/strace.list b/linux-user/strace.list
index cdbc59bffd..2f78f4685b 100644
--- a/linux-user/strace.list
+++ b/linux-user/strace.list
@@ -91,12 +91,6 @@
 #ifdef TARGET_NR_dipc
 { TARGET_NR_dipc, "dipc" , NULL, NULL, NULL },
 #endif
-#ifdef TARGET_NR_dup
-{ TARGET_NR_dup, "dup" , NULL, NULL, NULL },
-#endif
-#ifdef TARGET_NR_dup2
-{ TARGET_NR_dup2, "dup2" , NULL, NULL, NULL },
-#endif
 #ifdef TARGET_NR_epoll_create
 { TARGET_NR_epoll_create, "epoll_create" , NULL, NULL, NULL },
 #endif
-- 
2.17.1


