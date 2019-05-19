Return-Path: <SRS0=v56/=TT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E753BC04AB4
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 21:37:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A311206B6
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 21:37:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sTKWJdqs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A311206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54030 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSTUs-0003uJ-BV
	for qemu-devel@archiver.kernel.org; Sun, 19 May 2019 17:37:34 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51232)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hSSaC-00049G-Ch
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:39:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hSSaB-00058F-Cm
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:39:00 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:38185)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hSSaB-00057F-6n
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:38:59 -0400
Received: by mail-pg1-x544.google.com with SMTP id j26so5741282pgl.5
	for <qemu-devel@nongnu.org>; Sun, 19 May 2019 13:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=fHCmInnpNa2F4K91jX190NfL9NDB7tdazRZM5/cuyRM=;
	b=sTKWJdqst8ArJHRiRxt07TQwIJU6RCXBO228h/fitWQRQV+gAWRLw3XhJUQFXbt3OO
	EDh2ENMmYnXniUJJiSmTmPll/n5NHAa/GA+ZwCcsA/Ifhpx9W+f1AvCG9hz1NdUd+a1L
	e8GAFapdATIWLxV3+lUTI8X4WN2qs14xRnJ6TMxsbyd3UTQA3Xgb0nbHF8nIRhisImh8
	kUZNpS2NOoctyHTVHXuSGff1miHNnutSWM/8yHMOdUdp7/nLJWNh2o3NtyJV7CppKxNL
	VaaBMCwSwAKiQvSXUkIw5gMtxYqRhTIxXLtFpHVd01+nbxWxYtWvUBspZwzGIB3olzKa
	oebw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=fHCmInnpNa2F4K91jX190NfL9NDB7tdazRZM5/cuyRM=;
	b=Kzj+cFPwwQpSoYfOpkveRmQiI3wY74CqcZWen0edC8JOnKqastfGT4o9Gq3qqw6MrF
	Y6IsEFDHq8G/WYkL3xNqa9vevOMNn+O2VHq726llD5HzjvITD+XKkVTlYQwkIhGO0Tt4
	m8lw2j3OXcGHUtATJnbD/FoywHeivUQAKh7DnWBIo87VNvYbs617yqJqN9WilA0R0jRP
	BSmjhZvaO6xsoNOl2xyX7ll8e7dSkCnVjI5TnJ4O7md6L4/jTE2YVuzDEx+3pyYfvtqE
	cKMsAZiOs6HzfoXebKu9fQg7IMaFA7NVFsHiXKUF2kdm7j/3OKwbqtkdtQ2szStIlWRq
	3Rrg==
X-Gm-Message-State: APjAAAUHJFmcJ77GaHV6PqXhvjeZWRCuAo3pMQrJNtAYAXB0NwJ4uIDe
	QZmL0iWiEYDhkAc8AgH09P51LOX6bmQ=
X-Google-Smtp-Source: APXvYqycOTSXjG/2xZDFv4fezhz+hvy3BagZ3hG0hURYReQZMB/M1Ip2x7f9rBA0WEryBgONjYfYOg==
X-Received: by 2002:a65:52c3:: with SMTP id z3mr18674927pgp.56.1558298338013; 
	Sun, 19 May 2019 13:38:58 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231]) by smtp.gmail.com with ESMTPSA id
	i7sm11397448pfo.19.2019.05.19.13.38.56
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sun, 19 May 2019 13:38:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Sun, 19 May 2019 13:37:24 -0700
Message-Id: <20190519203726.20729-73-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190519203726.20729-1-richard.henderson@linaro.org>
References: <20190519203726.20729-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::544
Subject: [Qemu-devel] [PATCH v7 72/74] linux-user: Split out reboot
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
 linux-user/syscall-proc.inc.c | 18 ++++++++++++++++++
 linux-user/syscall.c          | 13 -------------
 linux-user/strace.list        |  3 ---
 4 files changed, 19 insertions(+), 16 deletions(-)

diff --git a/linux-user/syscall-defs.h b/linux-user/syscall-defs.h
index 34e799d206..67c908448d 100644
--- a/linux-user/syscall-defs.h
+++ b/linux-user/syscall-defs.h
@@ -188,6 +188,7 @@ SYSCALL_DEF(readlink, ARG_STR, ARG_PTR, ARG_DEC);
 #ifdef TARGET_NR_readlinkat
 SYSCALL_DEF(readlinkat, ARG_ATDIRFD, ARG_STR, ARG_PTR, ARG_DEC);
 #endif
+SYSCALL_DEF(reboot, ARG_HEX, ARG_HEX, ARG_DEC, ARG_PTR);
 #ifdef TARGET_NR_rename
 SYSCALL_DEF(rename, ARG_STR, ARG_STR);
 #endif
diff --git a/linux-user/syscall-proc.inc.c b/linux-user/syscall-proc.inc.c
index bf9e278bf0..408e96a834 100644
--- a/linux-user/syscall-proc.inc.c
+++ b/linux-user/syscall-proc.inc.c
@@ -532,6 +532,24 @@ SYSCALL_IMPL(nice)
 }
 #endif
 
+SYSCALL_IMPL(reboot)
+{
+    abi_long ret;
+
+    if (arg3 == LINUX_REBOOT_CMD_RESTART2) {
+        /* arg4 must be ignored in all other cases */
+        char *p = lock_user_string(arg4);
+        if (!p) {
+            return -TARGET_EFAULT;
+        }
+        ret = get_errno(reboot(arg1, arg2, arg3, p));
+        unlock_user(p, arg4, 0);
+    } else {
+        ret = get_errno(reboot(arg1, arg2, arg3, NULL));
+    }
+    return ret;
+}
+
 SYSCALL_IMPL(sethostname)
 {
     void *p = lock_user_string(arg1);
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index ead2e5c2b8..80e8b360a9 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -4158,19 +4158,6 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
     void *p;
 
     switch(num) {
-    case TARGET_NR_reboot:
-        if (arg3 == LINUX_REBOOT_CMD_RESTART2) {
-           /* arg4 must be ignored in all other cases */
-           p = lock_user_string(arg4);
-           if (!p) {
-               return -TARGET_EFAULT;
-           }
-           ret = get_errno(reboot(arg1, arg2, arg3, p));
-           unlock_user(p, arg4, 0);
-        } else {
-           ret = get_errno(reboot(arg1, arg2, arg3, NULL));
-        }
-        return ret;
 #ifdef TARGET_NR_truncate
     case TARGET_NR_truncate:
         if (!(p = lock_user_string(arg1)))
diff --git a/linux-user/strace.list b/linux-user/strace.list
index 3d2e398439..3326541f17 100644
--- a/linux-user/strace.list
+++ b/linux-user/strace.list
@@ -866,9 +866,6 @@
 #ifdef TARGET_NR_readdir
 { TARGET_NR_readdir, "readdir" , NULL, NULL, NULL },
 #endif
-#ifdef TARGET_NR_reboot
-{ TARGET_NR_reboot, "reboot" , NULL, NULL, NULL },
-#endif
 #ifdef TARGET_NR_recv
 { TARGET_NR_recv, "recv" , NULL, NULL, NULL },
 #endif
-- 
2.17.1


