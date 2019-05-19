Return-Path: <SRS0=v56/=TT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B20AC04AB4
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 21:29:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BD3620578
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 21:29:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="brmejX2y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BD3620578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53874 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSTNB-00067J-8K
	for qemu-devel@archiver.kernel.org; Sun, 19 May 2019 17:29:37 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51083)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hSSa1-0003xz-QC
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:38:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hSSa0-0004ub-Lo
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:38:49 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:34651)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hSSa0-0004to-EG
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:38:48 -0400
Received: by mail-pl1-x642.google.com with SMTP id w7so5728149plz.1
	for <qemu-devel@nongnu.org>; Sun, 19 May 2019 13:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=nKLZCrlKSTO+R1LDAJ7MTC0/n6ttp1lefRgjBzvM1II=;
	b=brmejX2yIcPNjbKuVHCqV8AiCa1JJMdtPGr20MMLPBmCbCH8F8nnPJLHfbogkaawYS
	5MWYoLGmRdwxv176WTA+TIj0WRt7ds8eDGCjowF36zkM3oTIhPG3UX5RHX75QmX9g0Bj
	6M/v8WVOfulZJHBQ3O4Ni3A/c7faz1hQuBBJxe2CWZqUR2RsUGvTiCdCspP44hAuJPXJ
	UuiP0ArLKSf57V3ghQKN5nnGFHdcqtHuVz9I/3+VSeeim6MKiAFQ18nIZ2o7OMaOS9mW
	KH5iNAtVlaiVKV5Pa3XDzdIVwYIYTC1HGLWmt8otn3ZeyoyLyHeAYmcBNRWQXUdkuWkD
	Rl4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=nKLZCrlKSTO+R1LDAJ7MTC0/n6ttp1lefRgjBzvM1II=;
	b=VYF5SPZW3eA+olqHHN5qPYjtbo0NHq4eNBh5e7U3Wx+dkXB9x+1kusPmsALi1Gh5zi
	LFVjGi9bpn1wXCfAi381Mx+O5MPywFtD7jYHSjXbh6K6hH1ItkmQ4OHHF3gohT2X4YwQ
	QwloM/C50HRC7OiWoonVnMP4+tTgtmVOR1OiVfskmBjhAptsfPAkt3ZQH67uA/j6u9PJ
	FB55phQ+uQS+jkkjTJkSjOwLq4aLnB59YXF6Sbrg3cQCUxEY3OopYdMLey44X0bNbg7I
	ixXXf37Dzry4Ph8GIoQLqKGxYryM+SC1LufJMzCHsze03HIlqK2KUMqCiCoJ2vY9z0o2
	ByjA==
X-Gm-Message-State: APjAAAW70IJ/xRNSiC+Zp2zcY6Y+afgs/cupL6GVyuoGBKyu+ZYIO1u3
	Lz8ykUumjDzUShHqOSBRafWToesiFNg=
X-Google-Smtp-Source: APXvYqwoY8LIbknPgI3tt0tbzZjCgLVQxU2Mu8tnrIdcxpWjztN2tUOZRLeefEWnWx8tw+TmhxixdQ==
X-Received: by 2002:a17:902:6b8b:: with SMTP id
	p11mr70527578plk.225.1558298327154; 
	Sun, 19 May 2019 13:38:47 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231]) by smtp.gmail.com with ESMTPSA id
	i7sm11397448pfo.19.2019.05.19.13.38.46
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sun, 19 May 2019 13:38:46 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Sun, 19 May 2019 13:37:15 -0700
Message-Id: <20190519203726.20729-64-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190519203726.20729-1-richard.henderson@linaro.org>
References: <20190519203726.20729-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::642
Subject: [Qemu-devel] [PATCH v7 63/74] linux-user: Split out sigreturn,
 rt_sigreturn
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
 linux-user/syscall-defs.h    |  4 ++++
 linux-user/syscall-sig.inc.c | 18 ++++++++++++++++++
 linux-user/syscall.c         | 12 ------------
 linux-user/strace.list       |  6 ------
 4 files changed, 22 insertions(+), 18 deletions(-)

diff --git a/linux-user/syscall-defs.h b/linux-user/syscall-defs.h
index 11851535e1..77d750f66f 100644
--- a/linux-user/syscall-defs.h
+++ b/linux-user/syscall-defs.h
@@ -197,6 +197,7 @@ SYSCALL_DEF(rt_sigaction, ARG_SIGNAL, ARG_PTR, ARG_PTR, ARG_DEC);
 SYSCALL_DEF(rt_sigpending, ARG_PTR, ARG_DEC);
 SYSCALL_DEF(rt_sigprocmask, ARG_SIGPROCMASKHOW, ARG_PTR, ARG_PTR, ARG_DEC);
 SYSCALL_DEF(rt_sigqueueinfo, ARG_DEC, ARG_SIGNAL, ARG_PTR);
+SYSCALL_DEF(rt_sigreturn);
 SYSCALL_DEF(rt_sigsuspend, ARG_PTR, ARG_DEC);
 SYSCALL_DEF(rt_sigtimedwait, ARG_PTR, ARG_PTR, ARG_PTR, ARG_DEC);
 SYSCALL_DEF(rt_tgsigqueueinfo, ARG_DEC, ARG_DEC, ARG_SIGNAL, ARG_PTR);
@@ -236,6 +237,9 @@ SYSCALL_DEF(sigprocmask, ARG_SIGPROCMASKHOW, ARG_HEX);
 #elif defined(TARGET_NR_sigprocmask)
 SYSCALL_DEF(sigprocmask, ARG_SIGPROCMASKHOW, ARG_PTR, ARG_PTR);
 #endif
+#ifdef TARGET_NR_sigreturn
+SYSCALL_DEF(sigreturn);
+#endif
 #if defined(TARGET_ALPHA)
 SYSCALL_DEF(sigsuspend, ARG_HEX);
 #elif defined(TARGET_NR_sigsuspend)
diff --git a/linux-user/syscall-sig.inc.c b/linux-user/syscall-sig.inc.c
index 774346838b..d5c0ccdcc3 100644
--- a/linux-user/syscall-sig.inc.c
+++ b/linux-user/syscall-sig.inc.c
@@ -206,6 +206,14 @@ SYSCALL_IMPL(rt_sigqueueinfo)
     return get_errno(sys_rt_sigqueueinfo(arg1, arg2, &uinfo));
 }
 
+SYSCALL_IMPL(rt_sigreturn)
+{
+    if (block_signals()) {
+        return -TARGET_ERESTARTSYS;
+    }
+    return do_rt_sigreturn(cpu_env);
+}
+
 SYSCALL_IMPL(rt_sigsuspend)
 {
     CPUState *cpu = ENV_GET_CPU(cpu_env);
@@ -471,6 +479,16 @@ SYSCALL_IMPL(sigprocmask)
 }
 #endif
 
+#ifdef TARGET_NR_sigreturn
+SYSCALL_IMPL(sigreturn)
+{
+    if (block_signals()) {
+        return -TARGET_ERESTARTSYS;
+    }
+    return do_sigreturn(cpu_env);
+}
+#endif
+
 #ifdef TARGET_NR_sigsuspend
 SYSCALL_IMPL(sigsuspend)
 {
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index e489d12103..b8b18ac1de 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -4240,18 +4240,6 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
     void *p;
 
     switch(num) {
-#ifdef TARGET_NR_sigreturn
-    case TARGET_NR_sigreturn:
-        if (block_signals()) {
-            return -TARGET_ERESTARTSYS;
-        }
-        return do_sigreturn(cpu_env);
-#endif
-    case TARGET_NR_rt_sigreturn:
-        if (block_signals()) {
-            return -TARGET_ERESTARTSYS;
-        }
-        return do_rt_sigreturn(cpu_env);
     case TARGET_NR_sethostname:
         if (!(p = lock_user_string(arg1)))
             return -TARGET_EFAULT;
diff --git a/linux-user/strace.list b/linux-user/strace.list
index 57445a8d81..b1c2f7851e 100644
--- a/linux-user/strace.list
+++ b/linux-user/strace.list
@@ -926,9 +926,6 @@
 #ifdef TARGET_NR_rmdir
 { TARGET_NR_rmdir, "rmdir" , NULL, NULL, NULL },
 #endif
-#ifdef TARGET_NR_rt_sigreturn
-{ TARGET_NR_rt_sigreturn, "rt_sigreturn" , NULL, NULL, NULL },
-#endif
 #ifdef TARGET_NR_sched_getaffinity
 { TARGET_NR_sched_getaffinity, "sched_getaffinity" , NULL, NULL, NULL },
 #endif
@@ -1113,9 +1110,6 @@
 #ifdef TARGET_NR_signalfd4
 { TARGET_NR_signalfd4, "signalfd4" , NULL, NULL, NULL },
 #endif
-#ifdef TARGET_NR_sigreturn
-{ TARGET_NR_sigreturn, "sigreturn" , NULL, NULL, NULL },
-#endif
 #ifdef TARGET_NR_socket
 { TARGET_NR_socket, "socket" , NULL, print_socket, NULL },
 #endif
-- 
2.17.1


