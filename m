Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1836AC10DCE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 19:43:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF322206E2
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 19:43:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Cz2ajr5/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF322206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49124 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCTk4-0007Ie-3L
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 15:43:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45006)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jCTit-0004cj-G0
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 15:42:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jCTis-0001hb-HB
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 15:42:27 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:35525)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jCTis-0001gg-C2
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 15:42:26 -0400
Received: by mail-pl1-x643.google.com with SMTP id g6so3078474plt.2
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2020 12:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=KU/VVN1rk+40NYMvd20F10ZZXWCOkzDc6Y3oZJm23Fo=;
 b=Cz2ajr5/QhOAnzaaP6LKFM/3V0FBVWWtBqjbIelavFdcxqV1qnJgcG7tdIVS6WSv9T
 C4NDHG5s254YD00fYJ9ultRocjlZjJF0NUe//z7LgtxCX14jFzS2eggRfCKZzmKx8RsU
 49ibsWAqiaXa+x5hWr7PTQyWi4WuMd3mlcmqYftWf5CqRCg8av1mbyFrWtt76pnSEmWc
 cdR9fK4xrFhl+9JK4OaPicpSsUUckh6jOfL0nBHTWZ5CvD/upDTj336VTyP1qpTax5GN
 tYFhQYge8gIwebyMQg7LP5fOsTyJLrWuEI1k/heKgFxZByjrar28TVLMD3UocDus+oJO
 bnmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=KU/VVN1rk+40NYMvd20F10ZZXWCOkzDc6Y3oZJm23Fo=;
 b=bsPR1Sku2s4g6c8VPPu4lO2xhRzgdPK1Y65Bz4BEIriR6oDF9eDbGtzovdW5UF6jdM
 oRWCdF/DphLij/LtcqXj1uH0SFyD9D5LRDtoRfPZJeei99Ku0Ki2CAAdP7WXPfXUsLpy
 /Ve76HOeyqVzjdPug1DoI7hD3U4MTakN+sz6zNFZ9ly+GtuH8s+1j6LAMWA2aTwU35O9
 Ylb+b82Kx4Tcqza2NnBbXihCX/3OHxPEA1IbJD+rqctvpWzCgbkkG3fE/hn9aNCev2+X
 Aa0fs+FbZN0wLXqgjXd2w4LnZw07BR/9s1fuwC2s99kpaKzId0gQuDpBYwJorxV9N5tu
 kbEg==
X-Gm-Message-State: ANhLgQ3wYWhqJLM7nK0uJc95Cm8/rfJa/gVrCa5ErqnK4E2karIBGdm+
 SFJVLYYWsEHKjFZUknVMh2pRdFamhGA=
X-Google-Smtp-Source: ADFU+vuNYQpVaziTeFLpSohDOCt+7OJpcMgPu1XaeC4O/XKlipx6MtFuJsrVoBWbsleyU39EjPHICw==
X-Received: by 2002:a17:90a:5d85:: with SMTP id
 t5mr5788826pji.126.1584042144949; 
 Thu, 12 Mar 2020 12:42:24 -0700 (PDT)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id g69sm6824842pje.34.2020.03.12.12.42.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Mar 2020 12:42:24 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 03/42] target/arm: Add support for MTE to SCTLR_ELx
Date: Thu, 12 Mar 2020 12:41:40 -0700
Message-Id: <20200312194219.24406-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200312194219.24406-1-richard.henderson@linaro.org>
References: <20200312194219.24406-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::643
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This does not attempt to rectify all of the res0 bits, but does
clear the mte bits when not enabled.  Since there is no high-part
mapping of SCTLR, aa32 mode cannot write to these bits.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index d04fc0a140..97272502ce 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -4680,6 +4680,22 @@ static void sctlr_write(CPUARMState *env, const ARMCPRegInfo *ri,
 {
     ARMCPU *cpu = env_archcpu(env);
 
+    if (arm_feature(env, ARM_FEATURE_PMSA) && !cpu->has_mpu) {
+        /* M bit is RAZ/WI for PMSA with no MPU implemented */
+        value &= ~SCTLR_M;
+    }
+
+    /* ??? Lots of these bits are not implemented.  */
+
+    if (ri->state == ARM_CP_STATE_AA64 && !cpu_isar_feature(aa64_mte, cpu)) {
+        if (ri->opc1 == 6) { /* SCTLR_EL3 */
+            value &= ~(SCTLR_ITFSB | SCTLR_TCF | SCTLR_ATA);
+        } else {
+            value &= ~(SCTLR_ITFSB | SCTLR_TCF0 | SCTLR_TCF |
+                       SCTLR_ATA0 | SCTLR_ATA);
+        }
+    }
+
     if (raw_read(env, ri) == value) {
         /* Skip the TLB flush if nothing actually changed; Linux likes
          * to do a lot of pointless SCTLR writes.
@@ -4687,13 +4703,8 @@ static void sctlr_write(CPUARMState *env, const ARMCPRegInfo *ri,
         return;
     }
 
-    if (arm_feature(env, ARM_FEATURE_PMSA) && !cpu->has_mpu) {
-        /* M bit is RAZ/WI for PMSA with no MPU implemented */
-        value &= ~SCTLR_M;
-    }
-
     raw_write(env, ri, value);
-    /* ??? Lots of these bits are not implemented.  */
+
     /* This may enable/disable the MMU, so do a TLB flush.  */
     tlb_flush(CPU(cpu));
 
-- 
2.20.1


