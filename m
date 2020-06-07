Return-Path: <SRS0=Pynu=7U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19791C433DF
	for <qemu-devel@archiver.kernel.org>; Sun,  7 Jun 2020 20:06:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D44E6206F6
	for <qemu-devel@archiver.kernel.org>; Sun,  7 Jun 2020 20:06:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DpTgdNVk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D44E6206F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52404 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ji1Z9-0001GH-5u
	for qemu-devel@archiver.kernel.org; Sun, 07 Jun 2020 16:06:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59912)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1ji1Fk-0003zc-8q
 for qemu-devel@nongnu.org; Sun, 07 Jun 2020 15:46:45 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335]:50925)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1ji1Fj-0004nd-8y
 for qemu-devel@nongnu.org; Sun, 07 Jun 2020 15:46:43 -0400
Received: by mail-wm1-x335.google.com with SMTP id l17so2112506wmj.0
 for <qemu-devel@nongnu.org>; Sun, 07 Jun 2020 12:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=ujyzI6PK0Cj6j4urUhXNN+eZBMUkCinKRwasIhMry7Y=;
 b=DpTgdNVkT5/xWgXDIYHzSexX0GMMVYEn/MexXB+mesI9PxfNdwFUsY+XXY58sqcTEN
 iAV05BIzbvNRIbxxOyHqjy3DpsCdSzvZ1HdemNWmiHOpc52kpZCGn8miXTSLbkrhi7P7
 gjY6kJ77HsZSn7fue1ViUer1XWNMlvoVxvIz0pbAsajuthkDyQsV3zL/LABa6bkoJdZP
 68pfjmYpGxv13jzWNUSSpDjtPmGhSYscBbf1ZzAkQjXsOg7/nkwgcE0CMaXkGtsLEw5h
 I5e8Uz8qQXEV1Dl3jodj2l13paiPoO7OxQjdMVvit5sF2ruqvDRO9wjcU57/sRam1352
 r5tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=ujyzI6PK0Cj6j4urUhXNN+eZBMUkCinKRwasIhMry7Y=;
 b=q6p2oBwvhiYKjv4m4xYNKH0CkF4r8rpPFSuOVo9yHWQwy78UwWCDBeHlatdiWyi9aN
 ivhFNxXsUUiSlAh2KtCUDik+weCFu196qqDn97iZ2CM3XeZI/OmC/RoYQDI37hRlpLGs
 1m2zj6amvinoqIesyEOQVklbaXD1mpVKMxEwyVM+WwYowpHjBoms6fp6tX/xP1O7QdcS
 6kFejvMxbx8Uj9Tt4TYdv/TG2z5Dpm4gZU6U3pd9VB/805o8VzxhvSQDJmUIKzZ6avER
 dOX1atulUlyI54NRBk2gKwmMvil2FmGRyb0WOP8MFEnPzd1FIbGfpeTHqMXeFunRxz4X
 6z0Q==
X-Gm-Message-State: AOAM532697DH7lo91USiNaAsB1DbWTpHP3I+yph/NcrmHlyCccu4M/S1
 nAT654uACynFHMv5fcGcIFLx6g6A
X-Google-Smtp-Source: ABdhPJzyMKNchnoSpWFrBc+b+POFfslevcnf194RJ2XBGey3u9wShmHUnr9rvw9YMkwRP4WHO2MAxQ==
X-Received: by 2002:a1c:a901:: with SMTP id s1mr13838370wme.66.1591559201371; 
 Sun, 07 Jun 2020 12:46:41 -0700 (PDT)
Received: from rtrkw774-lin.syrmia.com ([46.240.135.226])
 by smtp.gmail.com with ESMTPSA id u130sm21091339wmg.32.2020.06.07.12.46.40
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 07 Jun 2020 12:46:41 -0700 (PDT)
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Subject: [PULL 21/21] target/mips: Enable hardware page table walker and CMGCR
 features for P5600
Date: Sun,  7 Jun 2020 21:46:25 +0200
Message-Id: <1591559185-31287-22-git-send-email-aleksandar.qemu.devel@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1591559185-31287-1-git-send-email-aleksandar.qemu.devel@gmail.com>
References: <1591559185-31287-1-git-send-email-aleksandar.qemu.devel@gmail.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wm1-x335.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: aleksandar.qemu.devel@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Andrea Oliveri <oliveriandrea@gmail.com>

Enable hardware page table walker and CMGCR features for P5600 that
supports both.

Signed-off-by: Andrea Oliveri <oliveriandrea@gmail.com>
Reviewed-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Signed-off-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Message-Id: <de5adcb9fd0dd607b98026f4bfb34205432b6002.camel@gmail.com>
---
 target/mips/translate_init.inc.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/target/mips/translate_init.inc.c b/target/mips/translate_init.inc.c
index ffae10d..637cacc 100644
--- a/target/mips/translate_init.inc.c
+++ b/target/mips/translate_init.inc.c
@@ -366,7 +366,7 @@ const mips_def_t mips_defs[] =
     },
     {
         /* FIXME:
-         * Config3: CMGCR, PW, VZ, CTXTC, CDMM, TL
+         * Config3: VZ, CTXTC, CDMM, TL
          * Config4: MMUExtDef
          * Config5: MRP
          * FIR(FCR0): Has2008
@@ -380,10 +380,11 @@ const mips_def_t mips_defs[] =
                        (2 << CP0C1_DS) | (4 << CP0C1_DL) | (3 << CP0C1_DA) |
                        (1 << CP0C1_PC) | (1 << CP0C1_FP),
         .CP0_Config2 = MIPS_CONFIG2,
-        .CP0_Config3 = MIPS_CONFIG3 | (1U << CP0C3_M) | (1 << CP0C3_MSAP) |
+        .CP0_Config3 = MIPS_CONFIG3 | (1U << CP0C3_M) |
+                       (1 << CP0C3_CMGCR) | (1 << CP0C3_MSAP) |
                        (1 << CP0C3_BP) | (1 << CP0C3_BI) | (1 << CP0C3_SC) |
-                       (1 << CP0C3_ULRI) | (1 << CP0C3_RXI) | (1 << CP0C3_LPA) |
-                       (1 << CP0C3_VInt),
+                       (1 << CP0C3_PW) | (1 << CP0C3_ULRI) | (1 << CP0C3_RXI) |
+                       (1 << CP0C3_LPA) | (1 << CP0C3_VInt),
         .CP0_Config4 = MIPS_CONFIG4 | (1U << CP0C4_M) | (2 << CP0C4_IE) |
                        (0x1c << CP0C4_KScrExist),
         .CP0_Config4_rw_bitmask = 0,
-- 
2.7.4


