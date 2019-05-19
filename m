Return-Path: <SRS0=v56/=TT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66125C04AB4
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 21:29:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3162520578
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 21:29:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="geyLX6mR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3162520578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53878 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSTNI-0006DI-DE
	for qemu-devel@archiver.kernel.org; Sun, 19 May 2019 17:29:44 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51209)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hSSaB-000483-5N
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:39:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hSSaA-00056K-42
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:38:59 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:44494)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hSSa9-00055d-Tl
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:38:58 -0400
Received: by mail-pf1-x443.google.com with SMTP id g9so6149356pfo.11
	for <qemu-devel@nongnu.org>; Sun, 19 May 2019 13:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=AwkKxT6hgxGUbnCawP7ML0rY671AUDoxnoeEokerBT8=;
	b=geyLX6mRxlcwdztvehOJoVihDXVuFrvzPKzOHjfE52+WR6W5LXbZRhSZovgXDjj/s5
	Rpv+56ZNUtlwmLfAdrPaEm5bdgDCVZlGvkJ7JRGMm5oi7Ooo/SEG2AmC6vbTtrSWU2U1
	KHY83aLr+EU0NC/utnT2IFq204cIyERYQ6zXj6X6G6seqxqccTZ5mEPbmR1n8fvQ+eDj
	J/41cojmPZvLot3lmXnjgEBe7eVoj74cioFSiaD3RRQlWwE+Riqr3ZFzv6GCt+U5VupW
	7s0elB2xOG6RvI0p/YlV04Z2Y8hT1yJBL9lKTfElXE8v3237rFFMXSOYO+CcdOPM0uFr
	wfKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=AwkKxT6hgxGUbnCawP7ML0rY671AUDoxnoeEokerBT8=;
	b=Z7eFkQUVLutE06d2qjGsb3fQTHebo05mu9Ef6Y4xAdCjp2wRGi03iCZQFrDjv0quup
	O3zG97xhEdRU3kZYgUO46KFEUmPJFB40vrsJLR8KHbG1YKU/Ta/hXVeO0R4UlxdjVe5O
	LzRM0tMjryoLDObY8x7v6PS9/gnLx74YFkOtFHwdCa8qxxnjH1XgwNt7VVgmYX+LbAvI
	hIBrU1/hPYWa3PjxbUsCPTL+M5IqrnL8BQXXQCt6jaDw1URB0FPC7MuHHTNsBoduby9l
	3z8j/pKvZlgfAzIqLemcK+AKaCw3L3wmbii9IiV6ji+7J5sR+/JlmYYuDn7nJXYsYWFB
	eCfw==
X-Gm-Message-State: APjAAAWQ2vqkhNVPTvKrC5MscUvIeGQlvJS0/YISzCMyA6NPMqBfrnUz
	sw8om7sRw49MN2eI8g4p1eewhVIDkMU=
X-Google-Smtp-Source: APXvYqx6AVKNXkSdU322RfLmkkcvT1LyZSJkcIyfhBdLeyoLZJeJKW2fH5Ir7OJgcEenWQO4enZr3w==
X-Received: by 2002:a65:5cca:: with SMTP id b10mr71649844pgt.444.1558298336768;
	Sun, 19 May 2019 13:38:56 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231]) by smtp.gmail.com with ESMTPSA id
	i7sm11397448pfo.19.2019.05.19.13.38.55
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sun, 19 May 2019 13:38:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Sun, 19 May 2019 13:37:23 -0700
Message-Id: <20190519203726.20729-72-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190519203726.20729-1-richard.henderson@linaro.org>
References: <20190519203726.20729-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::443
Subject: [Qemu-devel] [PATCH v7 71/74] linux-user: Split out swapon, swapoff
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
 linux-user/syscall-file.inc.c | 26 ++++++++++++++++++++++++++
 linux-user/syscall.c          | 16 ----------------
 linux-user/strace.list        |  6 ------
 4 files changed, 28 insertions(+), 22 deletions(-)

diff --git a/linux-user/syscall-defs.h b/linux-user/syscall-defs.h
index 5625c268c3..34e799d206 100644
--- a/linux-user/syscall-defs.h
+++ b/linux-user/syscall-defs.h
@@ -279,6 +279,8 @@ SYSCALL_DEF(ssetmask, ARG_HEX);
 #ifdef TARGET_NR_stime
 SYSCALL_DEF(stime, ARG_PTR);
 #endif
+SYSCALL_DEF(swapoff, ARG_STR);
+SYSCALL_DEF(swapon, ARG_STR, ARG_HEX);
 #ifdef TARGET_NR_symlink
 SYSCALL_DEF(symlink, ARG_STR, ARG_STR);
 #endif
diff --git a/linux-user/syscall-file.inc.c b/linux-user/syscall-file.inc.c
index e3749f0fb4..bdf42ad437 100644
--- a/linux-user/syscall-file.inc.c
+++ b/linux-user/syscall-file.inc.c
@@ -1254,6 +1254,32 @@ SYSCALL_IMPL(select)
 }
 #endif
 
+SYSCALL_IMPL(swapoff)
+{
+    char *p = lock_user_string(arg1);
+    abi_long ret;
+
+    if (!p) {
+        return -TARGET_EFAULT;
+    }
+    ret = get_errno(swapoff(p));
+    unlock_user(p, arg1, 0);
+    return ret;
+}
+
+SYSCALL_IMPL(swapon)
+{
+    char *p = lock_user_string(arg1);
+    abi_long ret;
+
+    if (!p) {
+        return -TARGET_EFAULT;
+    }
+    ret = get_errno(swapon(p, arg2));
+    unlock_user(p, arg1, 0);
+    return ret;
+}
+
 static abi_long do_symlinkat(abi_ulong guest_target, int dirfd,
                              abi_ulong guest_path)
 {
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index fccf9ee184..ead2e5c2b8 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -4158,14 +4158,6 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
     void *p;
 
     switch(num) {
-#ifdef TARGET_NR_swapon
-    case TARGET_NR_swapon:
-        if (!(p = lock_user_string(arg1)))
-            return -TARGET_EFAULT;
-        ret = get_errno(swapon(p, arg2));
-        unlock_user(p, arg1, 0);
-        return ret;
-#endif
     case TARGET_NR_reboot:
         if (arg3 == LINUX_REBOOT_CMD_RESTART2) {
            /* arg4 must be ignored in all other cases */
@@ -4503,14 +4495,6 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
     case TARGET_NR_syscall:
         return do_syscall(cpu_env, arg1 & 0xffff, arg2, arg3, arg4, arg5,
                           arg6, arg7, arg8, 0);
-#endif
-#ifdef TARGET_NR_swapoff
-    case TARGET_NR_swapoff:
-        if (!(p = lock_user_string(arg1)))
-            return -TARGET_EFAULT;
-        ret = get_errno(swapoff(p));
-        unlock_user(p, arg1, 0);
-        return ret;
 #endif
     case TARGET_NR_sysinfo:
         {
diff --git a/linux-user/strace.list b/linux-user/strace.list
index d9db80335d..3d2e398439 100644
--- a/linux-user/strace.list
+++ b/linux-user/strace.list
@@ -1116,12 +1116,6 @@
 #ifdef TARGET_NR_swapcontext
 { TARGET_NR_swapcontext, "swapcontext" , NULL, NULL, NULL },
 #endif
-#ifdef TARGET_NR_swapoff
-{ TARGET_NR_swapoff, "swapoff" , NULL, NULL, NULL },
-#endif
-#ifdef TARGET_NR_swapon
-{ TARGET_NR_swapon, "swapon" , NULL, NULL, NULL },
-#endif
 #ifdef TARGET_NR_syscall
 { TARGET_NR_syscall, "syscall" , NULL, NULL, NULL },
 #endif
-- 
2.17.1


