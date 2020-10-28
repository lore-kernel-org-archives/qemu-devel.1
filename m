Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 600F8C388F7
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 03:43:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2ADC72242B
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 03:43:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mforney-org.20150623.gappssmtp.com header.i=@mforney-org.20150623.gappssmtp.com header.b="KfFrE6dL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2ADC72242B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mforney.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56886 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXcMy-0003AC-Ut
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 23:43:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34312)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mforney@mforney.org>)
 id 1kXc9S-0008FO-8y
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 23:29:33 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:41300)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mforney@mforney.org>)
 id 1kXc9O-0006Pz-PO
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 23:29:29 -0400
Received: by mail-pg1-x542.google.com with SMTP id g12so1954875pgm.8
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2020 20:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mforney-org.20150623.gappssmtp.com; s=20150623;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=SMLQMh29gPUsiwUvg4LfzpyksxkYmWIU1fC0NjpFTe4=;
 b=KfFrE6dLwIdcQwE8bWeUqe9kqlLn6D8iY1icoIs/xza74f44pz9NGWJ0+jHLknsxQx
 DguTkoUv2gfbb6/Q9wlPEAkXwv6/hv1COVDxr2k/K9Qk7qBqksy8FtpGWVDLgjP5MSa7
 5L/1iQq9/QMOZFHf/qz0PqUeXRwsj6Ro0wH4dg2PZ+046N7Ty+pj2n5zN625VqW4IQ7a
 CRTTfpioCSldwc6LzAWt6Ex1If6bO/CYZkxtnuPE1vrV5YC5zMxUPR8vqN3qI7zjlZil
 0wP9rUX86c8MQdeaN33F/lcNnLTzWInJBMJoAolnL6Lg9Yo4gSe2CUSUnhXrQh3kEfHR
 N7TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=SMLQMh29gPUsiwUvg4LfzpyksxkYmWIU1fC0NjpFTe4=;
 b=OmhykNUP5ytQdowrGM2Xv/syPUdriCg9j0MenU3W2nZaF0S6/1uQQuNAh/6+oOalZC
 moZ3jhYkw4HzQBpwq7Xep9zyuoPLLtlDsUcLvDFRICzD5HwHKnILzmubI/611O+qYWAo
 sJ669U2L23bwewOo5obLHc5mNFMzOSGp7/u5XVB6Px8L1FaTf7/BioiWlc5LGO5bUUZd
 lShdIdiHPr8j12OHpcwv6A/EfVOnQBiBQ+wgw6HojnPK+Iw4pjBlXGEoazzJaPEsWlLU
 QPevvHMlSfHsT3JvAX7d+KB3nRdwtN7ZkO4IpNJ/x0+xI3C0TriiK6RtbBSa99SXuWo0
 lz1g==
X-Gm-Message-State: AOAM531DRjH0kyBHhbnMIfe5HuGEITu1/9+29dfTXqUfXmD7TP0G6ISM
 f5ys3KqCuPrOoRzYFws3QRsVioNYNKL6ENfGTeA=
X-Google-Smtp-Source: ABdhPJwMHNSCeOKdVrN7MyRz0SAmcRHg3LpJWwx94JPKsmWt0XwPNJkPI6RgrDbtqlBwfqccqMPbAA==
X-Received: by 2002:aa7:91c8:0:b029:155:c7c1:3fae with SMTP id
 z8-20020aa791c80000b0290155c7c13faemr5347269pfa.74.1603855762512; 
 Tue, 27 Oct 2020 20:29:22 -0700 (PDT)
Received: from localhost ([2601:647:5180:4570:16dd:a9ff:fee7:6b79])
 by smtp.gmail.com with ESMTPSA id e1sm3997078pfd.198.2020.10.27.20.29.21
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 27 Oct 2020 20:29:21 -0700 (PDT)
From: Michael Forney <mforney@mforney.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] linux-user: Remove obsolete F_SHLCK and F_WRLCK translation
Date: Tue, 27 Oct 2020 20:27:27 -0700
Message-Id: <20201028032727.31326-1-mforney@mforney.org>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::542;
 envelope-from=mforney@mforney.org; helo=mail-pg1-x542.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

These lock types are unsupported by Linux since v2.2[0][1] and
always return EINVAL (except on SPARC up until v2.6, which just
warned).

musl libc does not define these constants, so just remove them from
the translation cases.

[0] https://github.com/mpe/linux-fullhistory/blob/v2.2.0/fs/locks.c#L322-L324
[1] https://github.com/mpe/linux-fullhistory/blob/v2.2.0/fs/locks.c#L429-L445

Signed-off-by: Michael Forney <mforney@mforney.org>
---
 linux-user/alpha/target_fcntl.h | 2 --
 linux-user/generic/fcntl.h      | 5 -----
 linux-user/syscall.c            | 2 --
 3 files changed, 9 deletions(-)

diff --git a/linux-user/alpha/target_fcntl.h b/linux-user/alpha/target_fcntl.h
index 2617e73472..e16ed1d415 100644
--- a/linux-user/alpha/target_fcntl.h
+++ b/linux-user/alpha/target_fcntl.h
@@ -33,8 +33,6 @@
 #define TARGET_F_RDLCK         1
 #define TARGET_F_WRLCK         2
 #define TARGET_F_UNLCK         8
-#define TARGET_F_EXLCK         16
-#define TARGET_F_SHLCK         32
 
 #include "../generic/fcntl.h"
 #endif
diff --git a/linux-user/generic/fcntl.h b/linux-user/generic/fcntl.h
index c85c5b9fed..4568d1f42b 100644
--- a/linux-user/generic/fcntl.h
+++ b/linux-user/generic/fcntl.h
@@ -119,11 +119,6 @@ struct target_f_owner_ex {
 #define TARGET_F_UNLCK         2
 #endif
 
-#ifndef TARGET_F_EXLCK
-#define TARGET_F_EXLCK         4
-#define TARGET_F_SHLCK         8
-#endif
-
 #ifndef TARGET_HAVE_ARCH_STRUCT_FLOCK
 #ifndef TARGET_ARCH_FLOCK_PAD
 #define TARGET_ARCH_FLOCK_PAD
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 897d20c076..56a8380dda 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -6621,8 +6621,6 @@ static int target_to_host_fcntl_cmd(int cmd)
     TRANSTBL_CONVERT(F_RDLCK); \
     TRANSTBL_CONVERT(F_WRLCK); \
     TRANSTBL_CONVERT(F_UNLCK); \
-    TRANSTBL_CONVERT(F_EXLCK); \
-    TRANSTBL_CONVERT(F_SHLCK); \
     }
 
 static int target_to_host_flock(int type)
-- 
2.29.0


