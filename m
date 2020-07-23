Return-Path: <SRS0=cpkI=BC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UPPERCASE_50_75,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E98FC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 00:23:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8E5920825
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 00:23:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XuoAYgLp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8E5920825
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42958 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyP0q-0007lB-2w
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 20:23:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58308)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3lNcYXwMKCqUXHbLTTLQJ.HTRVJRZ-IJaJQSTSLSZ.TWL@flex--scw.bounces.google.com>)
 id 1jyOxY-0003GB-M3
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 20:19:40 -0400
Received: from mail-yb1-xb4a.google.com ([2607:f8b0:4864:20::b4a]:49137)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3lNcYXwMKCqUXHbLTTLQJ.HTRVJRZ-IJaJQSTSLSZ.TWL@flex--scw.bounces.google.com>)
 id 1jyOxU-00022f-Uv
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 20:19:40 -0400
Received: by mail-yb1-xb4a.google.com with SMTP id i62so4440096ybc.15
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2020 17:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=TmSug8xbuoh5zw2qHLkIcOCD5svSODwrv4TCUt2Yngg=;
 b=XuoAYgLpvke3Bb7s5pgaZIetrwn7AyG25q3KeXmHm2V0ehRpZsILQmaq2cqvcI1BTG
 9ABQAqgYLwhmz7j/SjYXrJVja0j3fiBP4y7/Dqu0SBii3mfbC0qM2RahjDCpj8myOdGl
 fNbQIACiVtDY6caVOKezklEnvCzoLdgS8FgaP8RFNiYs6XLs8hWYhfmY0kuyWyBylvO4
 iJBCX6Tzb9XG8F4JqZpjQp4P6FlBieVgUD11R+/IO+Tq22Uqv6IgRUDKdfLUxl13hIv9
 UEEowm5KLJdsT8vfBCKPnuqbQSnGge8VlxW5hfni+5PCh6t01zJLYL1H84qwde2WFivQ
 dieQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=TmSug8xbuoh5zw2qHLkIcOCD5svSODwrv4TCUt2Yngg=;
 b=Ltr89s4l3AvveESW+C30lyeNRWVskZA1NFAytP4VZGHSWWa62NluUUyGpbolw3Yeli
 dqQ0JMHRjpMV447TdsKevDUcZUPkctO1gJWShGCiryXPQ4DQQzzeb4T4H1O1Pwx132ZJ
 fwYDjIwumWHeIXjmZMMaSBXbeSyM3037R+0vNZBFjLriZMzB/gworzahL8YO0Q8EYh3+
 DP3sI2GGamjZeZcZeVV1I8ZDmhOjc9JBmBSQ9kwRf1DRiprRS4h9oGIZ0ESZQ+tvXQeP
 Z9rwW/24CVhKmCpBxRWlcThNSvDCZ9hC1zr4B6ZImA9zH8US6ZjzXKMJLpwhtJ2/lGD9
 vJnA==
X-Gm-Message-State: AOAM532KXxaIQOklpbrhUhXnT+TgMTnYYB+lIZWXViCz4X9uQG11APBz
 TCwvx9bL7sBtJNyAl0Wa7c/8009Ha+Fo3bjo8v39b4zYPUpB7PepvT/yXMhCMd3NQLnvQAYlvxw
 ugQiDDEkT4yp8cEjBANeEOAXXYxpVxWfZgWt9GknzsjAU5DdPOGx1
X-Google-Smtp-Source: ABdhPJxfi1u5b9dXFsHs9CNnxbc/UZ801rdSTFSI0Z2YdE4fNR+KkhCrScu3Bd+CiE+W61jpa2RpPWw=
X-Received: by 2002:a25:e708:: with SMTP id e8mr3189824ybh.137.1595463572594; 
 Wed, 22 Jul 2020 17:19:32 -0700 (PDT)
Date: Wed, 22 Jul 2020 17:19:10 -0700
In-Reply-To: <cover.1595461447.git.scw@google.com>
Message-Id: <827d9ab425cb0c580722c48fe7471b14cbb1a57d.1595461447.git.scw@google.com>
Mime-Version: 1.0
References: <cover.1595461447.git.scw@google.com>
X-Mailer: git-send-email 2.28.0.rc0.105.gf9edc3c819-goog
Subject: [PATCH 1/6] linux-user: Support F_ADD_SEALS and F_GET_SEALS fcntls
From: Shu-Chun Weng <scw@google.com>
To: qemu-devel@nongnu.org
Cc: Shu-Chun Weng <scw@google.com>, laurent@vivier.eu
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b4a;
 envelope-from=3lNcYXwMKCqUXHbLTTLQJ.HTRVJRZ-IJaJQSTSLSZ.TWL@flex--scw.bounces.google.com;
 helo=mail-yb1-xb4a.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -105
X-Spam_score: -10.6
X-Spam_bar: ----------
X-Spam_report: (-10.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UPPERCASE_50_75=0.008,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Shu-Chun Weng <scw@google.com>
---
 linux-user/syscall.c      | 10 ++++++++++
 linux-user/syscall_defs.h | 14 ++++++++------
 2 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 1211e759c2..f97337b0b4 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -6312,6 +6312,14 @@ static int target_to_host_fcntl_cmd(int cmd)
     case TARGET_F_GETPIPE_SZ:
         ret = F_GETPIPE_SZ;
         break;
+#endif
+#ifdef F_ADD_SEALS
+    case TARGET_F_ADD_SEALS:
+        ret = F_ADD_SEALS;
+        break;
+    case TARGET_F_GET_SEALS:
+        ret = F_GET_SEALS;
+        break;
 #endif
     default:
         ret = -TARGET_EINVAL;
@@ -6598,6 +6606,8 @@ static abi_long do_fcntl(int fd, int cmd, abi_ulong arg)
     case TARGET_F_GETLEASE:
     case TARGET_F_SETPIPE_SZ:
     case TARGET_F_GETPIPE_SZ:
+    case TARGET_F_ADD_SEALS:
+    case TARGET_F_GET_SEALS:
         ret = get_errno(safe_fcntl(fd, host_cmd, arg));
         break;
 
diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index 3c261cff0e..70df1a94fb 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -2292,12 +2292,14 @@ struct target_statfs64 {
 #endif
 
 #define TARGET_F_LINUX_SPECIFIC_BASE 1024
-#define TARGET_F_SETLEASE (TARGET_F_LINUX_SPECIFIC_BASE + 0)
-#define TARGET_F_GETLEASE (TARGET_F_LINUX_SPECIFIC_BASE + 1)
-#define TARGET_F_DUPFD_CLOEXEC (TARGET_F_LINUX_SPECIFIC_BASE + 6)
-#define TARGET_F_SETPIPE_SZ (TARGET_F_LINUX_SPECIFIC_BASE + 7)
-#define TARGET_F_GETPIPE_SZ (TARGET_F_LINUX_SPECIFIC_BASE + 8)
-#define TARGET_F_NOTIFY  (TARGET_F_LINUX_SPECIFIC_BASE+2)
+#define TARGET_F_SETLEASE            (TARGET_F_LINUX_SPECIFIC_BASE + 0)
+#define TARGET_F_GETLEASE            (TARGET_F_LINUX_SPECIFIC_BASE + 1)
+#define TARGET_F_DUPFD_CLOEXEC       (TARGET_F_LINUX_SPECIFIC_BASE + 6)
+#define TARGET_F_NOTIFY              (TARGET_F_LINUX_SPECIFIC_BASE + 2)
+#define TARGET_F_SETPIPE_SZ          (TARGET_F_LINUX_SPECIFIC_BASE + 7)
+#define TARGET_F_GETPIPE_SZ          (TARGET_F_LINUX_SPECIFIC_BASE + 8)
+#define TARGET_F_ADD_SEALS           (TARGET_F_LINUX_SPECIFIC_BASE + 9)
+#define TARGET_F_GET_SEALS           (TARGET_F_LINUX_SPECIFIC_BASE + 10)
 
 #include "target_fcntl.h"
 
-- 
2.28.0.rc0.105.gf9edc3c819-goog


