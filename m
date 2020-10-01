Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF526C4727C
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 15:01:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62EB820780
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 15:01:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K0wFdEMA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62EB820780
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42218 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kO05c-0005h8-Gh
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 11:01:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42974)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kNzsT-0004oR-MH
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 10:48:13 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432]:39417)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kNzsR-0002x4-Nv
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 10:48:13 -0400
Received: by mail-wr1-x432.google.com with SMTP id k10so6120356wru.6
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2020 07:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=7IRmJR4QLq1yyKkeN0MLbFHRplQff2bZm6Ce52F5OFc=;
 b=K0wFdEMAOc+stAy/xWe+yZhe/qeJrWcAI6FXxTve7h6UUNibEs0StQhdGiheTC6xLt
 qSW9VrMhNbanDtzH1hbrKnA7a+GUSoPLbppFphN/2GcME/OlXO7PJwa0y8X2/6gSup6b
 nM/3Kv4jofGf/boWd5IKEfNANHuWlwE7PhFL57F/wzC1QJJVAfJMIxj3FYuGmXu63tBo
 5efwdfvpqD/N4+fli7evo0loUFgW6aRg2+JBuO7kgnWFNdtjwWC1QRqgvBTnI4iLnHgt
 GRilFtx1vPk5IX66tkQ0Jd8+XnylOzPcHXGsP/Rf2CkrB+lv86ptiHAQQlGlnl0tZcKm
 8kKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=7IRmJR4QLq1yyKkeN0MLbFHRplQff2bZm6Ce52F5OFc=;
 b=dcpFULG6TGtsl5TQKC/JNZQ7BOpEJ7HGnYZL+cwJX1LyXDPztLhVt5tK4ct00V9N6S
 Rx31g2QMpugqEO8FelPpadfyvGNT7bnzYHAiW4ZnecwVkzGhCHJQmA1E7x9KYBXz+uxu
 VjrbulnrkFkpMYhjjeRzSbH1mUT4IDzCoZjyZCaqx8ZLb+gm9h/MmzMw8HO2fMqBuFLN
 usoY3VrTzprNA/XvaU3LDqrE8Fn0RXA7G+QfYz5J0kmeUFVxPpmEOwGSyKH6T4vz7S2W
 70af1bBdOwB1sY3rF6ExFkJHo+WhFvrp3ECFR9rOn1K9AbwxBWoEfO7+UBBFzZ/X2SfO
 OCeg==
X-Gm-Message-State: AOAM531ozUqWacADIv2/+UlpocXfriiPRGJyweRNrXPdav/hUQLjD+69
 QUysO3CE+RDwUUAPKdXTvuaIqsizXcYEeue/
X-Google-Smtp-Source: ABdhPJy2D0tCtalSgxU8XAvJeJP54toi44akejCLNrejYTQqd+G/yPOOEpoJ4QYu2PoVx5OLqIMIeg==
X-Received: by 2002:a5d:6551:: with SMTP id z17mr9450772wrv.200.1601563689663; 
 Thu, 01 Oct 2020 07:48:09 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id 70sm342052wme.15.2020.10.01.07.48.08
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Oct 2020 07:48:08 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 03/18] hw/intc/armv7m_nvic: Only show ID register values for
 Main Extension CPUs
Date: Thu,  1 Oct 2020 15:47:44 +0100
Message-Id: <20201001144759.5964-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201001144759.5964-1-peter.maydell@linaro.org>
References: <20201001144759.5964-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x432.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

M-profile CPUs only implement the ID registers as guest-visible if
the CPU implements the Main Extension (all our current CPUs except
the Cortex-M0 do).

Currently we handle this by having the Cortex-M0 leave the ID
register values in the ARMCPU struct as zero, but this conflicts with
our design decision to make QEMU behaviour be keyed off ID register
fields wherever possible.

Explicitly code the ID registers in the NVIC to return 0 if the Main
Extension is not implemented, so we can make the M0 model set the
ARMCPU struct fields to obtain the correct behaviour without those
values becoming guest-visible.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200910173855.4068-4-peter.maydell@linaro.org
---
 hw/intc/armv7m_nvic.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
index a28be49c1e9..42b1ad59e65 100644
--- a/hw/intc/armv7m_nvic.c
+++ b/hw/intc/armv7m_nvic.c
@@ -1238,32 +1238,74 @@ static uint32_t nvic_readl(NVICState *s, uint32_t offset, MemTxAttrs attrs)
                       "Aux Fault status registers unimplemented\n");
         return 0;
     case 0xd40: /* PFR0.  */
+        if (!arm_feature(&cpu->env, ARM_FEATURE_M_MAIN)) {
+            goto bad_offset;
+        }
         return cpu->isar.id_pfr0;
     case 0xd44: /* PFR1.  */
+        if (!arm_feature(&cpu->env, ARM_FEATURE_M_MAIN)) {
+            goto bad_offset;
+        }
         return cpu->isar.id_pfr1;
     case 0xd48: /* DFR0.  */
+        if (!arm_feature(&cpu->env, ARM_FEATURE_M_MAIN)) {
+            goto bad_offset;
+        }
         return cpu->isar.id_dfr0;
     case 0xd4c: /* AFR0.  */
+        if (!arm_feature(&cpu->env, ARM_FEATURE_M_MAIN)) {
+            goto bad_offset;
+        }
         return cpu->id_afr0;
     case 0xd50: /* MMFR0.  */
+        if (!arm_feature(&cpu->env, ARM_FEATURE_M_MAIN)) {
+            goto bad_offset;
+        }
         return cpu->isar.id_mmfr0;
     case 0xd54: /* MMFR1.  */
+        if (!arm_feature(&cpu->env, ARM_FEATURE_M_MAIN)) {
+            goto bad_offset;
+        }
         return cpu->isar.id_mmfr1;
     case 0xd58: /* MMFR2.  */
+        if (!arm_feature(&cpu->env, ARM_FEATURE_M_MAIN)) {
+            goto bad_offset;
+        }
         return cpu->isar.id_mmfr2;
     case 0xd5c: /* MMFR3.  */
+        if (!arm_feature(&cpu->env, ARM_FEATURE_M_MAIN)) {
+            goto bad_offset;
+        }
         return cpu->isar.id_mmfr3;
     case 0xd60: /* ISAR0.  */
+        if (!arm_feature(&cpu->env, ARM_FEATURE_M_MAIN)) {
+            goto bad_offset;
+        }
         return cpu->isar.id_isar0;
     case 0xd64: /* ISAR1.  */
+        if (!arm_feature(&cpu->env, ARM_FEATURE_M_MAIN)) {
+            goto bad_offset;
+        }
         return cpu->isar.id_isar1;
     case 0xd68: /* ISAR2.  */
+        if (!arm_feature(&cpu->env, ARM_FEATURE_M_MAIN)) {
+            goto bad_offset;
+        }
         return cpu->isar.id_isar2;
     case 0xd6c: /* ISAR3.  */
+        if (!arm_feature(&cpu->env, ARM_FEATURE_M_MAIN)) {
+            goto bad_offset;
+        }
         return cpu->isar.id_isar3;
     case 0xd70: /* ISAR4.  */
+        if (!arm_feature(&cpu->env, ARM_FEATURE_M_MAIN)) {
+            goto bad_offset;
+        }
         return cpu->isar.id_isar4;
     case 0xd74: /* ISAR5.  */
+        if (!arm_feature(&cpu->env, ARM_FEATURE_M_MAIN)) {
+            goto bad_offset;
+        }
         return cpu->isar.id_isar5;
     case 0xd78: /* CLIDR */
         return cpu->clidr;
-- 
2.20.1


