Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3063C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 15:21:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E758207D8
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 15:21:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j8eXAvb5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E758207D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41672 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joqAe-0004Ua-My
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 11:21:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35568)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1joq41-000298-1q
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 11:14:49 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:50978)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1joq3x-0006Jq-9c
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 11:14:48 -0400
Received: by mail-wm1-x341.google.com with SMTP id l17so9180574wmj.0
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2020 08:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=OiVkZdXmMFp02tYSp5OVNi5864zwIsR2HUEVngWMuuQ=;
 b=j8eXAvb5sSuAv0/OJvaqL2818q0DSyGaB/EjOLiSAvSZahnFjCa7BQSfioYUjAFnaB
 YfLxc9Jx1K4uLXWneasunP5PgdkFj2MufzSIIzp4ooyrG5sA0wTiz1K+N4RofsuwPd29
 lmyvpm9PKaxla9v20ejK8YE0U5hbEku4w+bM73/dkRl+cAP3A2PpMmdLsSFwaQvkvxGD
 nTeXwMQMwzDnzuZm1tUEyJBMO1e4j/3iv8TJ0Hja/Hr467Mow/bdwdLJ9QS50ysCQPbs
 TlF7YigOGEa8/VuAsI6JujW+Mb5onrSIB/3gp3HkQ8C+ILj1VTJ/9v14bjK7lfNHB4W2
 Z+4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=OiVkZdXmMFp02tYSp5OVNi5864zwIsR2HUEVngWMuuQ=;
 b=eRDG8/8DmKx/vqJkNyYUgiingRNnVaKo4ONaJk7YPIts+850VWEaSZQZ0lWielUyYe
 8odqa9ufNA2n7fcp0/VfNV7CQE8H2cqGOgcUwuJgM5+NNW429CIVuXPxYu0Rvzy9mB0C
 a8R0hmzk1oqwsim0pIJv2nCmlM8a58L/tecrkGwCi71HL5sYptxVMRE91zZpcsu2D23F
 Zi4wyGh5Wfq6A4BGKGYpJqzZ02ljN/AiPu0dzaVFBJqUIa0WtTsFucFh2n0o+TrbsMmd
 c3fFbrukDhXB3DmvwA+vNxgeNwl7LxQWIiqqGoMZk8CSGkT8MlbVUTXvLmaabYczzrwU
 tb8A==
X-Gm-Message-State: AOAM5316xaYedoqksxHYfydbPEdbKWBNyQ3TV6UqqMZgHvaX6NN8sPXN
 GpDhHXvVxTV7Bv8oRoERb1ssMeH3VfrtMQ==
X-Google-Smtp-Source: ABdhPJz1RGpx7xdbVYjD1UWsjr95CkTv1/FVN+8rx/wUQd8ZqPzutn+TtBvi25S0iRerQAsOk0pZCw==
X-Received: by 2002:a1c:a949:: with SMTP id s70mr4314261wme.137.1593184483183; 
 Fri, 26 Jun 2020 08:14:43 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id w13sm37838852wrr.67.2020.06.26.08.14.42
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2020 08:14:42 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 15/57] target/arm: Add support for MTE to SCTLR_ELx
Date: Fri, 26 Jun 2020 16:13:42 +0100
Message-Id: <20200626151424.30117-16-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200626151424.30117-1-peter.maydell@linaro.org>
References: <20200626151424.30117-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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

From: Richard Henderson <richard.henderson@linaro.org>

This does not attempt to rectify all of the res0 bits, but does
clear the mte bits when not enabled.  Since there is no high-part
mapping of SCTLR, aa32 mode cannot write to these bits.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200626033144.790098-4-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index a29f0a28d84..8a0fb015819 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -4698,6 +4698,22 @@ static void sctlr_write(CPUARMState *env, const ARMCPRegInfo *ri,
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
@@ -4705,13 +4721,8 @@ static void sctlr_write(CPUARMState *env, const ARMCPRegInfo *ri,
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


