Return-Path: <SRS0=yvcL=DY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00CDBC433E7
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 14:40:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E4B920708
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 14:40:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BlVy2jYZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E4B920708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54752 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTnNg-0007Wj-MZ
	for qemu-devel@archiver.kernel.org; Sat, 17 Oct 2020 10:40:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37566)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kTmqc-0005Xw-Fq
 for qemu-devel@nongnu.org; Sat, 17 Oct 2020 10:06:14 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429]:38949)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kTmqa-000491-KH
 for qemu-devel@nongnu.org; Sat, 17 Oct 2020 10:06:14 -0400
Received: by mail-wr1-x429.google.com with SMTP id y12so6588385wrp.6
 for <qemu-devel@nongnu.org>; Sat, 17 Oct 2020 07:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=7NPFG3sCe3Q0DWcvvpgh0QRrJIh4WkqraUDSbppp/5Q=;
 b=BlVy2jYZOLpKi+x8pl78DPw4PuPFNK5Hr9hii+HYldLiagJTlC0DDGRy7zPWkJs6V3
 ibVI2ftO1N+gt7++lwBGO/Q4pfFz67tJf8/1lom2sc9nmN+VSWw5pKqlYobRAqPoCO2K
 +WMHc9bC2Ysxhl9FINkqzJcMZoZUqkPgzWrAAMgdenB0cxRJhNTKR/yGUFD1hvhdmxDG
 tcPdZMtRE5YtTgG4SNrIlXrjLOmBCsX1oAduAOrBFBIgBG/66SrZXxEiwGuOkJtn1rlc
 FntM/3Xcf2wYrC3zyqe54H7rernF6exXQpT96pyHzSEeWWDdx3obTfl+lAIv1F71RkMd
 dXpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=7NPFG3sCe3Q0DWcvvpgh0QRrJIh4WkqraUDSbppp/5Q=;
 b=FNYJM+nuBwtxij7IyEBgQ6vwuSwwBZOWhRQNuJ+QyRjiv+E2WrLX73AA05pUwZ59oD
 Uwxg9Q0FjFdHAhN8ityhjkSCL2U5g8NpU4BOJojDyH9d10Dj2b80hjaw1YH46aFaHAiR
 nvsmazOi0n9Wql/kVK9awl/JOxzDIT2MwINC9odehOwjYddGUbYhIP66cNbVf/sp1YEd
 ikdAGyhtFMf1Ofo+Z24jqxAEl4QACzGFazmASky+jC/KtFfwQkuuiYL5x5rNDqb+TNvF
 lrb52xKQUnT+SM8lvV8csVB3j4Mj8qrIKiP/39EkcQ7EGjJDlnlg7Oy00wA8n2Zujf45
 zpOQ==
X-Gm-Message-State: AOAM531hvFtUSqBMF3vbTJ7C5HdUJ54ZTdehGqvGdP0MajeqjlRhq8Kh
 9SHHkdhUvLYCXQLu77SfybVKW8rIx1s=
X-Google-Smtp-Source: ABdhPJwvjfQ7VDOjq7eWWyfNjaZNjJPALCxXvEfbifxYhb2RhMAky8HIvmkfSnFx3t13BMNPBposZg==
X-Received: by 2002:a5d:4051:: with SMTP id w17mr10218317wrp.24.1602943571161; 
 Sat, 17 Oct 2020 07:06:11 -0700 (PDT)
Received: from localhost.localdomain
 (117.red-83-52-172.dynamicip.rima-tde.net. [83.52.172.117])
 by smtp.gmail.com with ESMTPSA id y5sm8845509wrw.52.2020.10.17.07.06.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Oct 2020 07:06:10 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PULL 44/44] target/mips: Increase number of TLB entries on the 34Kf
 core (16 -> 64)
Date: Sat, 17 Oct 2020 16:02:43 +0200
Message-Id: <20201017140243.1078718-45-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201017140243.1078718-1-f4bug@amsat.org>
References: <20201017140243.1078718-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x429.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Victor Kamensky <kamensky@cisco.com>, Paul Burton <paulburton@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Huacai Chen <chenhc@lemote.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Per "MIPS32 34K Processor Core Family Software User's Manual,
Revision 01.13" page 8 in "Joint TLB (JTLB)" section:

  "The JTLB is a fully associative TLB cache containing 16, 32,
   or 64-dual-entries mapping up to 128 virtual pages to their
   corresponding physical addresses."

There is no particular reason to restrict the 34Kf core model to
16 TLB entries, so raise its config to 64.

This is helpful for other projects, in particular the Yocto Project:

  Yocto Project uses qemu-system-mips 34Kf cpu model, to run 32bit
  MIPS CI loop. It was observed that in this case CI test execution
  time was almost twice longer than 64bit MIPS variant that runs
  under MIPS64R2-generic model. It was investigated and concluded
  that the difference in number of TLBs 16 in 34Kf case vs 64 in
  MIPS64R2-generic is responsible for most of CI real time execution
  difference. Because with 16 TLBs linux user-land trashes TLB more
  and it needs to execute more instructions in TLB refill handler
  calls, as result it runs much longer.

(https://lists.gnu.org/archive/html/qemu-devel/2020-10/msg03428.html)

Buglink: https://bugzilla.yoctoproject.org/show_bug.cgi?id=13992
Reported-by: Victor Kamensky <kamensky@cisco.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20201016133317.553068-1-f4bug@amsat.org>
---
 target/mips/translate_init.c.inc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/mips/translate_init.c.inc b/target/mips/translate_init.c.inc
index c735b2bf667..fb5a9b38e5d 100644
--- a/target/mips/translate_init.c.inc
+++ b/target/mips/translate_init.c.inc
@@ -254,7 +254,7 @@ const mips_def_t mips_defs[] =
         .CP0_PRid = 0x00019500,
         .CP0_Config0 = MIPS_CONFIG0 | (0x1 << CP0C0_AR) |
                        (MMU_TYPE_R4000 << CP0C0_MT),
-        .CP0_Config1 = MIPS_CONFIG1 | (1 << CP0C1_FP) | (15 << CP0C1_MMU) |
+        .CP0_Config1 = MIPS_CONFIG1 | (1 << CP0C1_FP) | (63 << CP0C1_MMU) |
                        (0 << CP0C1_IS) | (3 << CP0C1_IL) | (1 << CP0C1_IA) |
                        (0 << CP0C1_DS) | (3 << CP0C1_DL) | (1 << CP0C1_DA) |
                        (1 << CP0C1_CA),
-- 
2.26.2


