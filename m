Return-Path: <SRS0=v56/=TT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A63AC04AB4
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 21:21:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F1D720449
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 21:21:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V1H717ql"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F1D720449
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53755 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSTF5-00074G-Ce
	for qemu-devel@archiver.kernel.org; Sun, 19 May 2019 17:21:15 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50977)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hSSZu-0003rD-Fo
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:38:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hSSZt-0004lf-CO
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:38:42 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:37919)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hSSZt-0004kr-5Q
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:38:41 -0400
Received: by mail-pl1-x643.google.com with SMTP id f97so5703959plb.5
	for <qemu-devel@nongnu.org>; Sun, 19 May 2019 13:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=ZHIm//oI2ZITpFYguBWDThC46F/4JpJyOJc3fr98jRM=;
	b=V1H717qlgfK0j7xr/K+RYpqiyrSw3a5X8rIJyQvsx4ZKaPMHgXjq2nC/xJxbdghty1
	b7140T3IvFhmX24cDwTJv2PBAs9jxLzXpHM4W/IeuE8FenUsUM8YTEtGyTc2KI82fPNg
	zEte2582fTIdNkjIKMkYXquxIvy3aFPyLTkEA/2BbZwyW7aQULkezQTzVO/dS16RU9Hk
	1jxPPc8GeJnECeD8Y8BhYQeJKG0fUbXOQBNvbc3KS5qwDsRlhgpOyLEQuxRm6KTi5bJA
	/8UOTuM61dkVC1XROCMI1ZhZx5SZ8lmi6fFzwhDFgr7pYt2/41ASQEsC/ANYFawBVgFi
	xX8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=ZHIm//oI2ZITpFYguBWDThC46F/4JpJyOJc3fr98jRM=;
	b=lqutc3OBXGPbuP2PR5mvJAS8J3t1Bd7dP+FLn/p9T2KhOiZ96CvohUeDCe+JAD9jGt
	RHxYCmSYYpa+DeKDU9fQV2T1kWI6sLDbkeRfl4aa1CbtrgbHMezcAgy3OxyN2nsm25sP
	pbKdE25/o3+JLkJUjgvUzrxdRiH+8sYzHq5qeEBElViEBMGc2CGWeZkd+Sy++TNBNw+b
	pqKuJszXI9JIStXuqmWSmuHNwu05ePoi2FMV9wdsuz0NxuPUpEhexIJvSeTmnmjiOnWv
	O2YrZav6iYZaaE35vVOyTT5eBK+TUJ/9pN7n786unfoKtPKTDKQYjAdMAWIFcoAKCUBf
	Kfng==
X-Gm-Message-State: APjAAAWNHG6XXlcrimC7AWnfmtMKixslPcsmnIomcm7IE7vu/91N27qZ
	QkGm3vZXI76yMxNHCNuDcN+ruCogNcc=
X-Google-Smtp-Source: APXvYqyH8BmX6Iagc0HRXl0DNv6TQqioo3y7I68t+qOj1meuLt8r9crCRb0tshOYZPBAhmQDolmwwQ==
X-Received: by 2002:a17:902:bd95:: with SMTP id
	q21mr35436912pls.159.1558298319969; 
	Sun, 19 May 2019 13:38:39 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231]) by smtp.gmail.com with ESMTPSA id
	i7sm11397448pfo.19.2019.05.19.13.38.38
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sun, 19 May 2019 13:38:39 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Sun, 19 May 2019 13:37:09 -0700
Message-Id: <20190519203726.20729-58-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190519203726.20729-1-richard.henderson@linaro.org>
References: <20190519203726.20729-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::643
Subject: [Qemu-devel] [PATCH v7 57/74] linux-user: Split out sgetmask,
 ssetmask
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
 linux-user/syscall-defs.h    |  6 ++++++
 linux-user/syscall-sig.inc.c | 32 ++++++++++++++++++++++++++++++++
 linux-user/syscall.c         | 27 ---------------------------
 linux-user/strace.list       |  6 ------
 4 files changed, 38 insertions(+), 33 deletions(-)

diff --git a/linux-user/syscall-defs.h b/linux-user/syscall-defs.h
index b62bffeb68..99532f75b2 100644
--- a/linux-user/syscall-defs.h
+++ b/linux-user/syscall-defs.h
@@ -222,6 +222,12 @@ SYSCALL_DEF(shmget, ARG_DEC, ARG_DEC, ARG_HEX);
 #ifdef TARGET_NR_sigaction
 SYSCALL_DEF(sigaction, ARG_SIGNAL, ARG_PTR, ARG_PTR);
 #endif
+#ifdef TARGET_NR_sgetmask
+SYSCALL_DEF(sgetmask);
+#endif
+#ifdef TARGET_NR_ssetmask
+SYSCALL_DEF(ssetmask, ARG_HEX);
+#endif
 #ifdef TARGET_NR_stime
 SYSCALL_DEF(stime, ARG_PTR);
 #endif
diff --git a/linux-user/syscall-sig.inc.c b/linux-user/syscall-sig.inc.c
index 918d58878f..f50ed16b74 100644
--- a/linux-user/syscall-sig.inc.c
+++ b/linux-user/syscall-sig.inc.c
@@ -211,3 +211,35 @@ SYSCALL_IMPL(sigaction)
     return ret;
 }
 #endif
+
+#ifdef TARGET_NR_sgetmask
+SYSCALL_IMPL(sgetmask)
+{
+    sigset_t cur_set;
+    abi_ulong target_set;
+    abi_long ret = do_sigprocmask(0, NULL, &cur_set);
+
+    if (!ret) {
+        host_to_target_old_sigset(&target_set, &cur_set);
+        ret = target_set;
+    }
+    return ret;
+}
+#endif
+
+#ifdef TARGET_NR_ssetmask
+SYSCALL_IMPL(ssetmask)
+{
+    sigset_t set, oset;
+    abi_ulong target_set = arg1;
+    abi_long ret;
+
+    target_to_host_old_sigset(&set, &target_set);
+    ret = do_sigprocmask(SIG_SETMASK, &set, &oset);
+    if (!ret) {
+        host_to_target_old_sigset(&target_set, &oset);
+        ret = target_set;
+    }
+    return ret;
+}
+#endif
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 3ef1bfb4ec..7bd410bcf0 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -4241,33 +4241,6 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
     void *p;
 
     switch(num) {
-#ifdef TARGET_NR_sgetmask /* not on alpha */
-    case TARGET_NR_sgetmask:
-        {
-            sigset_t cur_set;
-            abi_ulong target_set;
-            ret = do_sigprocmask(0, NULL, &cur_set);
-            if (!ret) {
-                host_to_target_old_sigset(&target_set, &cur_set);
-                ret = target_set;
-            }
-        }
-        return ret;
-#endif
-#ifdef TARGET_NR_ssetmask /* not on alpha */
-    case TARGET_NR_ssetmask:
-        {
-            sigset_t set, oset;
-            abi_ulong target_set = arg1;
-            target_to_host_old_sigset(&set, &target_set);
-            ret = do_sigprocmask(SIG_SETMASK, &set, &oset);
-            if (!ret) {
-                host_to_target_old_sigset(&target_set, &oset);
-                ret = target_set;
-            }
-        }
-        return ret;
-#endif
 #ifdef TARGET_NR_sigprocmask
     case TARGET_NR_sigprocmask:
         {
diff --git a/linux-user/strace.list b/linux-user/strace.list
index 20a71adc21..3cad68e081 100644
--- a/linux-user/strace.list
+++ b/linux-user/strace.list
@@ -1116,9 +1116,6 @@
 #ifdef TARGET_NR_setxattr
 { TARGET_NR_setxattr, "setxattr" , NULL, NULL, NULL },
 #endif
-#ifdef TARGET_NR_sgetmask
-{ TARGET_NR_sgetmask, "sgetmask" , NULL, NULL, NULL },
-#endif
 #ifdef TARGET_NR_shutdown
 { TARGET_NR_shutdown, "shutdown" , NULL, NULL, NULL },
 #endif
@@ -1158,9 +1155,6 @@
 #ifdef TARGET_NR_splice
 { TARGET_NR_splice, "splice" , NULL, NULL, NULL },
 #endif
-#ifdef TARGET_NR_ssetmask
-{ TARGET_NR_ssetmask, "ssetmask" , NULL, NULL, NULL },
-#endif
 #ifdef TARGET_NR_stat
 { TARGET_NR_stat, "stat" , NULL, print_stat, NULL },
 #endif
-- 
2.17.1


