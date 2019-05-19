Return-Path: <SRS0=v56/=TT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 802B9C04AB4
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 21:38:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C00C206B6
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 21:38:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="z5F6WQF5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C00C206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54054 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSTWB-0004g2-Ic
	for qemu-devel@archiver.kernel.org; Sun, 19 May 2019 17:38:55 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51267)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hSSaE-0004BD-Q1
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:39:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hSSaD-0005Av-Ld
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:39:02 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:38183)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hSSaD-0005AS-FZ
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:39:01 -0400
Received: by mail-pg1-x541.google.com with SMTP id j26so5741300pgl.5
	for <qemu-devel@nongnu.org>; Sun, 19 May 2019 13:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=EjoYPrl44jrQeXa6UK02T5QS4VIgYMGR1w3phRnmDY0=;
	b=z5F6WQF52rpJo3PQhy2+twbWWJQFDoZoEePUHYzj82TmKnjvzvY5uXYPkFCbsuEr07
	HjfI5nNwOrnbdyELuTn3C59hgaV9BZtN8XtBmp3vzq7XPBwCr6KO1we6KNf2gBww9wmZ
	yUcFH6KgkzN+qhIt1Rvz13Ese9e4L0Ai/1SJUamSkRzYOqxG1xE300HxH6VNdAkgVbRX
	sTpU8GlNq/J9/Rk3Ns2+kby1AiO5Z4kTvnCdEK3gp0zMRwAwL2owtrXZ658Nbu1XfIpv
	zcsdgoDBh4yiXc5PBn9S5KIw+l9ff/y0hXOUHOwPdRTESnx0V8ckvrtLspf1lxNcfoVx
	K/IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=EjoYPrl44jrQeXa6UK02T5QS4VIgYMGR1w3phRnmDY0=;
	b=dI4xfd8Nx1rSEjdAP8pklXWylPlaHXnsfu5GDc01SEd/4wtWaQkLPZpeBHgoJbWqf4
	HRSC7M7SNtYgNuSL7pynjYhApB5v+d6uufXUST9GEuRELv4GnmiSTN9Nb3tFVq5R65Dv
	WNQcGYvZYB5eO9yJgVBTQWkCgjIq/O7W484l8mH3FIBoVqfq5V9uW9I0HPOkYUN2VmOz
	qQimN/b6pUkqoa4ZR/1FJeP7bUn1uXOYA19XoIWA4nwU9ml0B+nfwzDJLEfLw0BE7cW3
	YTS7qWIG5WnFBYwuorbyKNXMw5Wey5imz0YII8vltfemWI2Fs2wDEhU+FsB/4W0A2bAz
	WZXw==
X-Gm-Message-State: APjAAAUPoSg01a3b1HhA1AB5qfM3ZWqZ6/ujOrmEuoc5lNZGSYzCTEsG
	VKwINVxMRsJx06E+jiHm43YZFrHfrxI=
X-Google-Smtp-Source: APXvYqxpaTq8MLBN20Ug41nodAifBY6Mtb/Bmf/aU78dCh9S603k9xkI9NaLkjyBWkRv8Y1qe3sC1g==
X-Received: by 2002:a65:5c89:: with SMTP id a9mr71876407pgt.334.1558298340290; 
	Sun, 19 May 2019 13:39:00 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231]) by smtp.gmail.com with ESMTPSA id
	i7sm11397448pfo.19.2019.05.19.13.38.59
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sun, 19 May 2019 13:38:59 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Sun, 19 May 2019 13:37:26 -0700
Message-Id: <20190519203726.20729-75-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190519203726.20729-1-richard.henderson@linaro.org>
References: <20190519203726.20729-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::541
Subject: [Qemu-devel] [PATCH v7 74/74] linux-user: Split out getpriority,
 setpriority
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
 linux-user/syscall-proc.inc.c | 28 ++++++++++++++++++++++++++++
 linux-user/syscall.c          | 18 ------------------
 linux-user/strace.list        |  6 ------
 4 files changed, 30 insertions(+), 24 deletions(-)

diff --git a/linux-user/syscall-defs.h b/linux-user/syscall-defs.h
index 8b2d95d19e..3b45250977 100644
--- a/linux-user/syscall-defs.h
+++ b/linux-user/syscall-defs.h
@@ -80,6 +80,7 @@ SYSCALL_DEF(getpid);
 #ifdef TARGET_NR_getppid
 SYSCALL_DEF(getppid);
 #endif
+SYSCALL_DEF(getpriority, ARG_DEC, ARG_DEC);
 #ifdef TARGET_NR_getrlimit
 SYSCALL_DEF(getrlimit, ARG_DEC, ARG_PTR);
 #endif
@@ -238,6 +239,7 @@ SYSCALL_DEF(semget, ARG_DEC, ARG_DEC, ARG_HEX);
 #endif
 SYSCALL_DEF(sethostname, ARG_STR);
 SYSCALL_DEF(setpgid, ARG_DEC, ARG_DEC);
+SYSCALL_DEF(setpriority, ARG_DEC, ARG_DEC, ARG_DEC);
 #ifdef TARGET_NR_setrlimit
 SYSCALL_DEF(setrlimit, ARG_DEC, ARG_PTR);
 #endif
diff --git a/linux-user/syscall-proc.inc.c b/linux-user/syscall-proc.inc.c
index 408e96a834..e85151cc2e 100644
--- a/linux-user/syscall-proc.inc.c
+++ b/linux-user/syscall-proc.inc.c
@@ -479,6 +479,29 @@ SYSCALL_IMPL(getppid)
 }
 #endif
 
+SYSCALL_IMPL(getpriority)
+{
+    abi_long ret;
+
+    /*
+     * Note that negative values are valid for getpriority, so we must
+     * differentiate based on errno settings.
+     */
+    errno = 0;
+    ret = getpriority(arg1, arg2);
+    if (ret == -1 && errno != 0) {
+        return -host_to_target_errno(errno);
+    }
+#ifdef TARGET_ALPHA
+    /* Return value is the unbiased priority.  Signal no error.  */
+    ((CPUAlphaState *)cpu_env)->ir[IR_V0] = 0;
+#else
+    /* Return value is a biased priority to avoid negative numbers.  */
+    ret = 20 - ret;
+#endif
+    return ret;
+}
+
 #ifdef TARGET_NR_getrlimit
 SYSCALL_IMPL(getrlimit)
 {
@@ -568,6 +591,11 @@ SYSCALL_IMPL(setpgid)
     return get_errno(setpgid(arg1, arg2));
 }
 
+SYSCALL_IMPL(setpriority)
+{
+    return get_errno(setpriority(arg1, arg2, arg3));
+}
+
 #ifdef TARGET_NR_setrlimit
 SYSCALL_IMPL(setrlimit)
 {
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 1b1d44bf32..6e7cccbdd5 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -4144,24 +4144,6 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
     void *p;
 
     switch(num) {
-    case TARGET_NR_getpriority:
-        /* Note that negative values are valid for getpriority, so we must
-           differentiate based on errno settings.  */
-        errno = 0;
-        ret = getpriority(arg1, arg2);
-        if (ret == -1 && errno != 0) {
-            return -host_to_target_errno(errno);
-        }
-#ifdef TARGET_ALPHA
-        /* Return value is the unbiased priority.  Signal no error.  */
-        ((CPUAlphaState *)cpu_env)->ir[IR_V0] = 0;
-#else
-        /* Return value is a biased priority to avoid negative numbers.  */
-        ret = 20 - ret;
-#endif
-        return ret;
-    case TARGET_NR_setpriority:
-        return get_errno(setpriority(arg1, arg2, arg3));
 #ifdef TARGET_NR_statfs
     case TARGET_NR_statfs:
         if (!(p = lock_user_string(arg1))) {
diff --git a/linux-user/strace.list b/linux-user/strace.list
index 55b617239c..a0d2b3f9c5 100644
--- a/linux-user/strace.list
+++ b/linux-user/strace.list
@@ -256,9 +256,6 @@
 #ifdef TARGET_NR_getpmsg
 { TARGET_NR_getpmsg, "getpmsg" , NULL, NULL, NULL },
 #endif
-#ifdef TARGET_NR_getpriority
-{ TARGET_NR_getpriority, "getpriority", "%s(%#x,%#x)", NULL, NULL },
-#endif
 #ifdef TARGET_NR_getrandom
 { TARGET_NR_getrandom, "getrandom", NULL, NULL, NULL },
 #endif
@@ -1007,9 +1004,6 @@
 #ifdef TARGET_NR_setpgrp
 { TARGET_NR_setpgrp, "setpgrp" , NULL, NULL, NULL },
 #endif
-#ifdef TARGET_NR_setpriority
-{ TARGET_NR_setpriority, "setpriority" , NULL, NULL, NULL },
-#endif
 #ifdef TARGET_NR_setregid
 { TARGET_NR_setregid, "setregid" , NULL, NULL, NULL },
 #endif
-- 
2.17.1


