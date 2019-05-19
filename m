Return-Path: <SRS0=v56/=TT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 521D5C04AB4
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 21:12:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CAC020449
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 21:12:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Tln0sEur"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CAC020449
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53615 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hST6d-0007hy-7t
	for qemu-devel@archiver.kernel.org; Sun, 19 May 2019 17:12:31 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50797)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hSSZh-0003hL-I5
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:38:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hSSZg-0004Ve-7E
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:38:29 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:37308)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hSSZf-0004Tp-U8
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:38:28 -0400
Received: by mail-pg1-x541.google.com with SMTP id n27so3140019pgm.4
	for <qemu-devel@nongnu.org>; Sun, 19 May 2019 13:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=zxww4ylhQcPO6FqWBn/qpIs5WYaAwpNI1B5WcIoosKI=;
	b=Tln0sEurgF+JnTziJnpUITbTY8QogpEjvYOfZlbhDzbziVqwoDEtegx/uwT8JmZPQx
	l14/qnDJ8G0SHw4O7VVXnyu1AHjaAiDq1Wprdh7oGUWZOn0noAitgN62lAlBl6wly1gd
	5vAwwGtWjXJWPQ1U4T05RrzG4cXOcnvQE2KKGx7l7nRDGCI0ffATzqvMYnHuSYgYUl9n
	P6SpkjVT4toExsxO9boPA0wEP//7eAwaQ9VosA88ciaDiFdBplZhJ9TlsUgFpYaEA/Sm
	64uARjnQtGPoLlQsqZACfoTwoaUVh6wthoxcLtWzx2PjK02ayN1YZwmD7WEMatwkUcLG
	TsIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=zxww4ylhQcPO6FqWBn/qpIs5WYaAwpNI1B5WcIoosKI=;
	b=j1wjiWOEphBkKvTaDQeq4XY8Gi9aeftAKx8yQ12Mcq2vRxvli0lQToaAQaeob8IYhJ
	X0+uTm9KLpUU2utOPcbBvFzN7rmJARzCSlW6gI61bMnRmZeLYjih64wLFAfEggs4uUZ9
	pqjegLeb3U/1oi0NQuRnhtTdKLrpyYunKgY0DMuo95Lh7jpM4/qstEXKH1Suu6KY6zoB
	w9vhZveJBHRarfSliCSxbDz1c63bBoHSuktXxSydyVzuJv1Ik/dKsmXnnsl/AJPtxsna
	MJ1szd/OLsqrQfSaLq/tNoDCtqlSX9g3Ap4QPO8Rc6wh9HT7Lv8bGXBSyuMdlz8WS29A
	3NHw==
X-Gm-Message-State: APjAAAUVjDaoC1DdMvnB/vAfZ77SyPXZgAdaGe9acaF+Z2VHVfURR7af
	hHepJFmgmQYwkqeKDhYQ/tvOYb3tdO0=
X-Google-Smtp-Source: APXvYqyvQSsqWUi6GM80EAQOj3+4CpvJPIxalyJyMIXJvkway5/UTRzEQLox///Isn94y9X8fHI2+Q==
X-Received: by 2002:a63:5726:: with SMTP id l38mr10616007pgb.344.1558298306631;
	Sun, 19 May 2019 13:38:26 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231]) by smtp.gmail.com with ESMTPSA id
	i7sm11397448pfo.19.2019.05.19.13.38.25
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sun, 19 May 2019 13:38:25 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Sun, 19 May 2019 13:36:57 -0700
Message-Id: <20190519203726.20729-46-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190519203726.20729-1-richard.henderson@linaro.org>
References: <20190519203726.20729-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::541
Subject: [Qemu-devel] [PATCH v7 45/74] linux-user: Split out acct
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
 linux-user/syscall-file.inc.c | 18 ++++++++++++++++++
 linux-user/syscall.c          | 11 -----------
 linux-user/strace.list        |  3 ---
 4 files changed, 19 insertions(+), 14 deletions(-)

diff --git a/linux-user/syscall-defs.h b/linux-user/syscall-defs.h
index 25d5aaccd1..f8f280f376 100644
--- a/linux-user/syscall-defs.h
+++ b/linux-user/syscall-defs.h
@@ -19,6 +19,7 @@
 #ifdef TARGET_NR_access
 SYSCALL_DEF(access, ARG_STR, ARG_ACCESSFLAG);
 #endif
+SYSCALL_DEF(acct, ARG_STR);
 #ifdef TARGET_NR_alarm
 SYSCALL_DEF(alarm, ARG_DEC);
 #endif
diff --git a/linux-user/syscall-file.inc.c b/linux-user/syscall-file.inc.c
index 5bd9eaa002..4080ab250e 100644
--- a/linux-user/syscall-file.inc.c
+++ b/linux-user/syscall-file.inc.c
@@ -36,6 +36,24 @@ SYSCALL_IMPL(access)
 }
 #endif
 
+SYSCALL_IMPL(acct)
+{
+    abi_ulong target_path = arg1;
+    abi_long ret;
+
+    if (target_path == 0) {
+        ret = get_errno(acct(NULL));
+    } else {
+        char *p = lock_user_string(target_path);
+        if (!p) {
+            return -TARGET_EFAULT;
+        }
+        ret = get_errno(acct(path(p)));
+        unlock_user(p, target_path, 0);
+    }
+    return ret;
+}
+
 SYSCALL_IMPL(chdir)
 {
     abi_ulong target_path = arg1;
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index cdca0dbe4f..5343486a58 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -5346,17 +5346,6 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
     void *p;
 
     switch(num) {
-    case TARGET_NR_acct:
-        if (arg1 == 0) {
-            ret = get_errno(acct(NULL));
-        } else {
-            if (!(p = lock_user_string(arg1))) {
-                return -TARGET_EFAULT;
-            }
-            ret = get_errno(acct(path(p)));
-            unlock_user(p, arg1, 0);
-        }
-        return ret;
     case TARGET_NR_ioctl:
         return do_ioctl(arg1, arg2, arg3);
 #ifdef TARGET_NR_fcntl
diff --git a/linux-user/strace.list b/linux-user/strace.list
index 85e3de87d8..ce5e02975b 100644
--- a/linux-user/strace.list
+++ b/linux-user/strace.list
@@ -9,9 +9,6 @@
 #ifdef TARGET_NR_accept4
 { TARGET_NR_accept4, "accept4" , NULL, NULL, NULL },
 #endif
-#ifdef TARGET_NR_acct
-{ TARGET_NR_acct, "acct" , NULL, NULL, NULL },
-#endif
 #ifdef TARGET_NR_add_key
 { TARGET_NR_add_key, "add_key" , NULL, NULL, NULL },
 #endif
-- 
2.17.1


