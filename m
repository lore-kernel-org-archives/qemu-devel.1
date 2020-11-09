Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93613C4741F
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 09:10:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCCAB20702
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 09:10:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lIZv3aY3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCCAB20702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46166 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kc3CI-0005RY-Rt
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 04:10:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52190)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kc36H-0007ph-K4
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 04:04:33 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e]:52231)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kc36G-0005Gg-2U
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 04:04:33 -0500
Received: by mail-wm1-x32e.google.com with SMTP id 10so6450449wml.2
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2020 01:04:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=5aSUYg2Mch9yEMUswE4iSf091+MmmBptqeNiWdRkEPc=;
 b=lIZv3aY3Gz3khvYeiLr4vLd86FdoG938AtFtCLgew6LAQ5QhOK7PTxqQixdcYRP/sS
 OZcDa5WQaiTQQeHp8wFGLbTDiSg8H9eOqEBF1aqY4C+XzmFY5ImG/NnHLy+vw3buQVkE
 WTtU6319QNwHVreMiXuWJJPMSA01Ox++vmlL77sxy+tok/sMeSO9eHo1nhUogXHmBQF9
 +zPO1B44Bu/t8PKqvCIUtjJoUq/Gtdbo4hizV9O28lilTMW/d2pvtoDT9ZFY2bhLzTva
 ZY4sgezZolGpKVyetOu27ErIyhxcXbQtovZ0TrZVD3xPAcNGpYne4z8d+e4XI4k6DThq
 UKCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=5aSUYg2Mch9yEMUswE4iSf091+MmmBptqeNiWdRkEPc=;
 b=ZE+WVinZFQeUvf2PP2bnzjewAif7gk833uFKFKxuL4w2KL2ZdI4jEwZ65xppKAvoMG
 YV4HAcEP6R5uI0vxkoJ8ui+5R2KsZGOE+n6be8qJbToEFO1PMdnbvKJ+i/aEW+M6QdEv
 sgch0cVmLhW7Jg9UMPBemLg4LIp7SX3jC/rMYUAxx4F28SWeiQvSMqHt3gu38411UPya
 3Vwnu9J8J8B0m/2bb+CVyCQAZnSPXkDNbnsbr0CqEIl1xUEBU/XA1tIlSQyu0dKVj6c4
 zq+GQtr71utIAzNOJG0b2DDb/AoS83KFXZnmva/mkuOP+m/quUbVrQx9vwceYHT6yjwf
 9Rkg==
X-Gm-Message-State: AOAM530xNNoHp04vZZY5YrMNkmyn1rsszok6Ya9zJTCQZ57DtnFi9bPX
 qZUS0nAXRJtSxHWYtfqh6hTrcWhUY3M=
X-Google-Smtp-Source: ABdhPJx/hVFfIGjxCZwPejObwmTYI5537kNcDShkbsz60iR7H6l0ExEe2kpekgrXoV4WAOFjSCFRZQ==
X-Received: by 2002:a1c:6182:: with SMTP id v124mr13035118wmb.94.1604912670197; 
 Mon, 09 Nov 2020 01:04:30 -0800 (PST)
Received: from localhost.localdomain (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id v189sm12897575wmg.14.2020.11.09.01.04.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2020 01:04:29 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-6.0 1/2] target/mips: Replace magic values by CP0PM_MASK
 or TARGET_PAGE_BITS_MIN
Date: Mon,  9 Nov 2020 10:04:21 +0100
Message-Id: <20201109090422.2445166-2-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201109090422.2445166-1-f4bug@amsat.org>
References: <20201109090422.2445166-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x32e.google.com
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
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Huacai Chen <chenhc@lemote.com>, Aurelien Jarno <aurelien@aurel32.net>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Replace magic values related to page size:

  12 -> TARGET_PAGE_BITS_MIN
  13 -> CP0PM_MASK

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 target/mips/cp0_helper.c | 5 +++--
 target/mips/helper.c     | 4 ++--
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/target/mips/cp0_helper.c b/target/mips/cp0_helper.c
index a1b5140ccaf..e8b9343ec9c 100644
--- a/target/mips/cp0_helper.c
+++ b/target/mips/cp0_helper.c
@@ -904,7 +904,7 @@ void update_pagemask(CPUMIPSState *env, target_ulong arg1, int32_t *pagemask)
         goto invalid;
     }
     /* We don't support VTLB entry smaller than target page */
-    if ((maskbits + 12) < TARGET_PAGE_BITS) {
+    if ((maskbits + TARGET_PAGE_BITS_MIN) < TARGET_PAGE_BITS) {
         goto invalid;
     }
     env->CP0_PageMask = mask << CP0PM_MASK;
@@ -913,7 +913,8 @@ void update_pagemask(CPUMIPSState *env, target_ulong arg1, int32_t *pagemask)
 
 invalid:
     /* When invalid, set to default target page size. */
-    env->CP0_PageMask = (~TARGET_PAGE_MASK >> 12) << CP0PM_MASK;
+    mask = (~TARGET_PAGE_MASK >> TARGET_PAGE_BITS_MIN);
+    env->CP0_PageMask = mask << CP0PM_MASK;
 }
 
 void helper_mtc0_pagemask(CPUMIPSState *env, target_ulong arg1)
diff --git a/target/mips/helper.c b/target/mips/helper.c
index 063b65c0528..041432489d6 100644
--- a/target/mips/helper.c
+++ b/target/mips/helper.c
@@ -858,8 +858,8 @@ refill:
             break;
         }
     }
-    pw_pagemask = m >> 12;
-    update_pagemask(env, pw_pagemask << 13, &pw_pagemask);
+    pw_pagemask = m >> TARGET_PAGE_BITS_MIN;
+    update_pagemask(env, pw_pagemask << CP0PM_MASK, &pw_pagemask);
     pw_entryhi = (address & ~0x1fff) | (env->CP0_EntryHi & 0xFF);
     {
         target_ulong tmp_entryhi = env->CP0_EntryHi;
-- 
2.26.2


