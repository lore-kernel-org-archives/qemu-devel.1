Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44DFBC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 19:38:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14FF8207E8
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 19:38:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C37wksQ/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14FF8207E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50312 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnokX-0005vr-AL
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 15:38:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41514)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jnojE-0003CK-5e
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 15:37:08 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:44299)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jnojC-0005Vc-Jv
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 15:37:07 -0400
Received: by mail-pg1-x543.google.com with SMTP id r18so4744pgk.11
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2020 12:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=EvczOnAfxPHKCoq8QmzQnZTQg2ANuenqwvd4b2Y4ULo=;
 b=C37wksQ/ia+O5QNVRIEnqHzhTbw+WDCqLPZFh/ejlfHjeToU0mEElUy6C0gNK5k1dT
 joJ05wjVAPEbqT8E0t/0cuLKHD2/omirCFN0wIC7/nF9RGnEiTfkRbfyrTjaXfIbGVH6
 7IwK+TELeB0BjNwKqyKmvJZ5tI2HuX1dChPHdVomQbdpOhbU8KcMdCaNpZA6VKOeJeVq
 5Lhh7jIiltMxmdyYi42KhKHPeWw0bAf/39hFL6fpuhC2jzsx+sq9TeVt94j0Pcs3frRN
 eQYDRnqjtR6CtUUcobqIoqjlvFHgD+ufaPyifvczodBBG4yNf+7lYMfDryPn5RzwEEUO
 eiGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=EvczOnAfxPHKCoq8QmzQnZTQg2ANuenqwvd4b2Y4ULo=;
 b=J2bZCY4kFm2t37J8QrdAGv6UsVvOoM4JoaNEyxWZwFGK5f6Ris6mnbUZvFNsGq2u+P
 fvckirzSzpY08EnGzAjsWd/xcBoNQ9NmHJHboS7vd5OAXjVlxpwgJOcMzkQywhrQF0YW
 LyZhzo2O9eZqurFIxqspfFaXJLowBNpFTpTfAmUmm1OeavdOmtemG608cLiTsUei584d
 7mPvQKRkBJaf2dlrExc2YR6jOlf3f25Mn6Lk8tBLsSwTvHXEWV9vw+FcT4yXlVgoeddX
 TKLIztkyz9NKfHqcteNVBkHuJmtZNN20iK2GyyqI3XxdZnbf7zvW7AelRiVpKIRMr651
 1b4A==
X-Gm-Message-State: AOAM530fUhQulhL00cHRebBUctN/XCLCjirYPaWB0Bx1irV3n1kVpr6v
 95NgZXj0rbnraAO1LzDiA5LSRE6qifs=
X-Google-Smtp-Source: ABdhPJzkqCJNnRrF1JJMQQumnkjeSdQN5l0TCbcSoWfr6qPX8zmib6BFw39rHhtRj9DdUCy9zIWSxg==
X-Received: by 2002:a63:80c8:: with SMTP id j191mr17689613pgd.38.1592941024867; 
 Tue, 23 Jun 2020 12:37:04 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id p12sm17927642pfq.69.2020.06.23.12.37.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2020 12:37:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 03/45] target/arm: Add support for MTE to SCTLR_ELx
Date: Tue, 23 Jun 2020 12:36:16 -0700
Message-Id: <20200623193658.623279-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200623193658.623279-1-richard.henderson@linaro.org>
References: <20200623193658.623279-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::543;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x543.google.com
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, david.spickett@linaro.org,
 steplong@quicinc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This does not attempt to rectify all of the res0 bits, but does
clear the mte bits when not enabled.  Since there is no high-part
mapping of SCTLR, aa32 mode cannot write to these bits.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index a29f0a28d8..8a0fb01581 100644
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
2.25.1


