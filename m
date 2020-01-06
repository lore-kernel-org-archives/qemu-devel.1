Return-Path: <SRS0=kvq2=23=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B3E3C33C8C
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 19:18:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 015E02072E
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 19:18:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CtGRoI1E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 015E02072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58724 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioXt0-0005b0-W5
	for qemu-devel@archiver.kernel.org; Mon, 06 Jan 2020 14:17:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46560)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <danielhb413@gmail.com>) id 1ioX5G-0003zz-61
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 13:26:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <danielhb413@gmail.com>) id 1ioX5E-0005JP-VF
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 13:26:34 -0500
Received: from mail-qv1-xf42.google.com ([2607:f8b0:4864:20::f42]:44709)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <danielhb413@gmail.com>)
 id 1ioX5E-0005J5-RL; Mon, 06 Jan 2020 13:26:32 -0500
Received: by mail-qv1-xf42.google.com with SMTP id n8so19408495qvg.11;
 Mon, 06 Jan 2020 10:26:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=8epzYC9Hx96nC8wKq8nl8igdorRt4UtCgIwD3AuQIS8=;
 b=CtGRoI1EAaFcZ6XoR5d+63MLor+iAEqD2yM88p5EaGJXkcPA9LKw3LiViNE5nDNejI
 ABgUNaD6xhvfr1VYxHN+POKVOR40TVf6QUGvzZCiZJ4xztny9YCi67AyIYgo7pwPwIAD
 CuR/1wIM0q/H/1p+His7K4QoYglHO7cKAJ/HF825HXbChXuByO/OC0ztG4npOytSl2HF
 v7HYadn8fhnmUYifDQ/GAt34Ec23R0aX5h8BGPziaU5JTrsj+BA/wHwo2MdQoXOY9XZB
 2QTp4yefkn51kwf1LkTr+jQRQpiVaAAG2kwg7t4sunaCf32ZidCRVOtFa8JWk4UOVwAH
 EXUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=8epzYC9Hx96nC8wKq8nl8igdorRt4UtCgIwD3AuQIS8=;
 b=cCbz6RrrVbDa6dhTQqfhupqKQfjuF8DFpFjR6+TTDPHm79UkW+KDBz8cTGoO8Yafz4
 +r62rNH3S7CURSLC2dzIJRuDf5QsHnmG/5+DQ/B5+PYr5hyRZvxMll4gi1AKjgjGYuHU
 gTlAqf6iSOo/TcW9Hd7tf75mTcRlww98ncv6B58eYBqYGZZXDeXBxJQTNFXVRlar3897
 s5mWmWfaGw4Vh76SPNgSzO52IZ0Pgfr3A5cgjKo4jlaT/j9CFuAytXv3Gd1S1XsmdhZm
 GvGYVP/V9qKMRZbWe0t3NEMJcO2LpeJ0VdDLvsnFVLvsiBbZZJO16vlIBzMUGGBLTQaR
 PGqA==
X-Gm-Message-State: APjAAAWJop3wiGWg/ajholh2qo/0bKT2kQGGssS+wtq5VKrkWSQXOjKH
 fvM18vpjjLhKxGIrciBvJsSC0jjI
X-Google-Smtp-Source: APXvYqxtyRMbmiEujs6q/5zgBBL/E9J99OUADg6ZgH+EC79ejwTz2kcu9nJQQyNjSHyiW7bCWWSW7Q==
X-Received: by 2002:a0c:a145:: with SMTP id d63mr82830123qva.120.1578335192274; 
 Mon, 06 Jan 2020 10:26:32 -0800 (PST)
Received: from rekt.ibmuc.com ([2804:431:c7c6:655b:9e1c:e865:3705:e1df])
 by smtp.gmail.com with ESMTPSA id b81sm21026522qkc.135.2020.01.06.10.26.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jan 2020 10:26:31 -0800 (PST)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 56/59] linux-user/signal.c: remove unneeded label in
 do_sigaltstack()
Date: Mon,  6 Jan 2020 15:24:22 -0300
Message-Id: <20200106182425.20312-57-danielhb413@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200106182425.20312-1-danielhb413@gmail.com>
References: <20200106182425.20312-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::f42
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-trivial@nongnu.org, Riku Voipio <riku.voipio@iki.fi>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

'out' can be replaced by 'return ret'. Since 'ret' is used
just to set the return value, drop the 'ret' variable and
use 'return' with the appropriate value instead.

CC: Riku Voipio <riku.voipio@iki.fi>
CC: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 linux-user/signal.c | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/linux-user/signal.c b/linux-user/signal.c
index 5ca6d62b15..5efb1b79d9 100644
--- a/linux-user/signal.c
+++ b/linux-user/signal.c
@@ -708,7 +708,6 @@ static void host_signal_handler(int host_signum, siginfo_t *info,
 /* compare linux/kernel/signal.c:do_sigaltstack() */
 abi_long do_sigaltstack(abi_ulong uss_addr, abi_ulong uoss_addr, abi_ulong sp)
 {
-    int ret;
     struct target_sigaltstack oss;
     TaskState *ts = (TaskState *)thread_cpu->opaque;
 
@@ -734,32 +733,28 @@ abi_long do_sigaltstack(abi_ulong uss_addr, abi_ulong uoss_addr, abi_ulong sp)
         }
 #endif
 
-        ret = -TARGET_EFAULT;
         if (!lock_user_struct(VERIFY_READ, uss, uss_addr, 1)) {
-            goto out;
+            return -TARGET_EFAULT;
         }
         __get_user(ss.ss_sp, &uss->ss_sp);
         __get_user(ss.ss_size, &uss->ss_size);
         __get_user(ss.ss_flags, &uss->ss_flags);
         unlock_user_struct(uss, uss_addr, 0);
 
-        ret = -TARGET_EPERM;
         if (on_sig_stack(sp))
-            goto out;
+            return -TARGET_EPERM;
 
-        ret = -TARGET_EINVAL;
         if (ss.ss_flags != TARGET_SS_DISABLE
             && ss.ss_flags != TARGET_SS_ONSTACK
             && ss.ss_flags != 0)
-            goto out;
+            return -TARGET_EINVAL;
 
         if (ss.ss_flags == TARGET_SS_DISABLE) {
             ss.ss_size = 0;
             ss.ss_sp = 0;
         } else {
-            ret = -TARGET_ENOMEM;
             if (ss.ss_size < minstacksize) {
-                goto out;
+                return -TARGET_ENOMEM;
             }
         }
 
@@ -768,14 +763,11 @@ abi_long do_sigaltstack(abi_ulong uss_addr, abi_ulong uoss_addr, abi_ulong sp)
     }
 
     if (uoss_addr) {
-        ret = -TARGET_EFAULT;
         if (copy_to_user(uoss_addr, &oss, sizeof(oss)))
-            goto out;
+            return -TARGET_EFAULT;
     }
 
-    ret = 0;
-out:
-    return ret;
+    return 0;
 }
 
 /* do_sigaction() return target values and host errnos */
-- 
2.24.1


