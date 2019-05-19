Return-Path: <SRS0=v56/=TT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E264C04AB4
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 21:17:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0507020449
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 21:17:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Sh/K3TeN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0507020449
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53694 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSTBq-0003y8-3d
	for qemu-devel@archiver.kernel.org; Sun, 19 May 2019 17:17:54 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50914)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hSSZq-0003pv-12
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:38:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hSSZo-0004gH-VR
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:38:37 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:44240)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hSSZo-0004fA-Ot
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:38:36 -0400
Received: by mail-pl1-x643.google.com with SMTP id c5so5690934pll.11
	for <qemu-devel@nongnu.org>; Sun, 19 May 2019 13:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=7L7bsUhZiRxWJXbYkbn2Jh3ZaH0xfMhZkbZE3Jd/+Dw=;
	b=Sh/K3TeNlrzQweyPs5RsuWLIuhsyEjrp8RDmgd0ctRv5apJNlUDqc3U+eYEtcPr4lf
	K350UkXahxGVZIEJPVx1hjBBh+OUn0clBfjwW+3cLw8/8w0bGbb0VqlcRl/+BwwEGpai
	A8NgRzav+1LoPLKRnTRFCOqEShack4gUCdS19Fy/PItScn2fDCDNvsE3aY3A3LX9ZqKV
	1gSBM5YR+HCmoBxHiPCFqTvm487Y4UrFHT4+2IY56RIN7YtZrVWFHSViOnqtoaa7XN3n
	6IGtOqATAkcyVhhXB5H6vqcBGbGLzIjoU5fw9B92ckhMouLcb4CU2tTqQyoMsnzvocXq
	RYFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=7L7bsUhZiRxWJXbYkbn2Jh3ZaH0xfMhZkbZE3Jd/+Dw=;
	b=N7y7UJ9BsGBelNGj50g6CwBKGK2Vsqy9Z2bPVO0l7QSAvYy53dxb+NhGqS0zhgHbRL
	S1W+2HO6dT3HUrlJJ+Yi0D91+tT7+FgMFwJ9KeZ/aj7RBiIPt8yeZG0nT/vyxK2TRNKD
	ryQuNiDjkCiIGBNomKoo7HQVufEww4KbMgKkW41veRyUw0MvYSeOrIrnrHSqBEabzx0F
	6LNcVZaDB14twxS48mQZ41uV/Ice1m0+3UJ6MbO7skpxSWWUs5bvKrM4J6pVKAMI/YAE
	0X+yG929hUbjCP/fP4c2wImPR80TwDxB6hRGK5sGTAZfwGCJhq2cpC8bmEmfua4dtOsl
	Gryg==
X-Gm-Message-State: APjAAAXlVM3epFQcX/Mo86JGlXhmq9Ghgac/LaSoqj4R+iLDUimeATPy
	1bXksEvrmVIQnhK/HVksi7Aebvu+jzs=
X-Google-Smtp-Source: APXvYqwKFyhMYZjOoT+d63FJWNx6YbFVi9a1vaIAo5Np8RjehN8JWK0EC3cS5j0cO1FIeiKk58iXbQ==
X-Received: by 2002:a17:902:59c3:: with SMTP id
	d3mr1085000plj.273.1558298315567; 
	Sun, 19 May 2019 13:38:35 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231]) by smtp.gmail.com with ESMTPSA id
	i7sm11397448pfo.19.2019.05.19.13.38.34
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sun, 19 May 2019 13:38:34 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Sun, 19 May 2019 13:37:05 -0700
Message-Id: <20190519203726.20729-54-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190519203726.20729-1-richard.henderson@linaro.org>
References: <20190519203726.20729-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::643
Subject: [Qemu-devel] [PATCH v7 53/74] linux-user: Split out chroot
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
 linux-user/syscall-defs.h     |  1 +
 linux-user/strace.c           | 12 ------------
 linux-user/syscall-file.inc.c | 13 +++++++++++++
 linux-user/syscall.c          |  6 ------
 linux-user/strace.list        |  3 ---
 5 files changed, 14 insertions(+), 21 deletions(-)

diff --git a/linux-user/syscall-defs.h b/linux-user/syscall-defs.h
index b6538350a3..b93ca1f78a 100644
--- a/linux-user/syscall-defs.h
+++ b/linux-user/syscall-defs.h
@@ -30,6 +30,7 @@ SYSCALL_DEF(chdir, ARG_STR);
 #ifdef TARGET_NR_chmod
 SYSCALL_DEF(chmod, ARG_STR, ARG_MODEFLAG);
 #endif
+SYSCALL_DEF(chroot, ARG_STR);
 SYSCALL_DEF_ARGS(clone, ARG_CLONEFLAG, ARG_PTR, ARG_PTR, ARG_PTR, ARG_PTR);
 SYSCALL_DEF(close, ARG_DEC);
 #ifdef TARGET_NR_creat
diff --git a/linux-user/strace.c b/linux-user/strace.c
index 560284b3c3..787bf41307 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -1130,18 +1130,6 @@ print_accept(const struct syscallname *name,
 }
 #endif
 
-#ifdef TARGET_NR_chroot
-static void
-print_chroot(const struct syscallname *name,
-    abi_long arg0, abi_long arg1, abi_long arg2,
-    abi_long arg3, abi_long arg4, abi_long arg5)
-{
-    print_syscall_prologue(name);
-    print_string(arg0, 1);
-    print_syscall_epilogue(name);
-}
-#endif
-
 #ifdef TARGET_NR_clock_adjtime
 static void
 print_clock_adjtime(const struct syscallname *name,
diff --git a/linux-user/syscall-file.inc.c b/linux-user/syscall-file.inc.c
index cbde6d906f..6e730e3152 100644
--- a/linux-user/syscall-file.inc.c
+++ b/linux-user/syscall-file.inc.c
@@ -88,6 +88,19 @@ SYSCALL_IMPL(chmod)
 }
 #endif
 
+SYSCALL_IMPL(chroot)
+{
+    char *p = lock_user_string(arg1);
+    abi_long ret;
+
+    if (!p) {
+        return -TARGET_EFAULT;
+    }
+    ret = get_errno(chroot(p));
+    unlock_user(p, arg1, 0);
+    return ret;
+}
+
 SYSCALL_IMPL(close)
 {
     int fd = arg1;
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 419edceab2..255765aaa7 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -4241,12 +4241,6 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
     void *p;
 
     switch(num) {
-    case TARGET_NR_chroot:
-        if (!(p = lock_user_string(arg1)))
-            return -TARGET_EFAULT;
-        ret = get_errno(chroot(p));
-        unlock_user(p, arg1, 0);
-        return ret;
 #ifdef TARGET_NR_getpgrp
     case TARGET_NR_getpgrp:
         return get_errno(getpgrp());
diff --git a/linux-user/strace.list b/linux-user/strace.list
index 61d22ad16b..7679e844b6 100644
--- a/linux-user/strace.list
+++ b/linux-user/strace.list
@@ -58,9 +58,6 @@
 #ifdef TARGET_NR_chown32
 { TARGET_NR_chown32, "chown32" , NULL, NULL, NULL },
 #endif
-#ifdef TARGET_NR_chroot
-{ TARGET_NR_chroot, "chroot" , NULL, print_chroot, NULL },
-#endif
 #ifdef TARGET_NR_clock_adjtime
 { TARGET_NR_clock_adjtime, "clock_adjtime" , NULL, print_clock_adjtime, NULL },
 #endif
-- 
2.17.1


