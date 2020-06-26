Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADB4DC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 15:37:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7774D20706
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 15:37:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lPfBjQBP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7774D20706
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55108 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joqPf-00087y-Dh
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 11:37:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36134)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1joq4Y-00038j-RB
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 11:15:22 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430]:39840)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1joq4X-0006fb-2a
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 11:15:22 -0400
Received: by mail-wr1-x430.google.com with SMTP id q5so9851399wru.6
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2020 08:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=8K/dkwNIkhX7mCrarFQM1tsE89/FiAwHTCjUY5kBac8=;
 b=lPfBjQBP6rdHkmcKg23Fd+H1zA2Oxfps+2kjceJHaKfD322UYEs5sSRTJpD71tipdd
 xLHxcPRQ7bJoM2lOwE80i08zP5yMleJXUqhsouvq5/lXgzkIPn9X4a7+XpFLzi2cXJG6
 FyrZAYW7sKAHZZrKc03BZ/18H0TU/40WtlkE+vZUv5pxo33vNYh91fn5jBSBhFe0TQUs
 Z/XQZjXQu9ixDfsSZs4wV7FhIJ0AZG2NxvqI+9N3JvRls//DpPGneZL3Q8uU01LUqzPE
 6bWNZ0+Teoh1rJEKrHy1zGwkYMfsoV1WvFFGinLxNBdx6JxnR2x+jJNdsnwZYVwdHnqQ
 Mn5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=8K/dkwNIkhX7mCrarFQM1tsE89/FiAwHTCjUY5kBac8=;
 b=e+SynhbWm6Kj7l4F0FiWAlcwGIkDVULFRxdbMI7rWPL3c9/n0BmjcAE/ccdbDkeWLs
 +t5feYDS74RI9ACf3MeEnbZcNjnoqvTLZKAAOA5p0pTOPmqne3j5pIa2TnJm+LLO6JA3
 2T8RuReUsCqmx3dpwNyEPxc8bw55AYqYGgo4brZ6QoFb4HJxGOGk6rFv2xUxcfyDwnJG
 G+MTDRlrEL+GwkgfrfMg6AhAcLdDjMGu/Z9gUbi8wsG8OoUbNY9EQoviJKA+4tplRBBR
 0B45UHLI5KfME0n/xX37LQoK3gIgcbCEEwl4Wc9nEmp5ZmZO5BuhPBBmcThIqQBgbyMP
 v3Vg==
X-Gm-Message-State: AOAM530ta6nX/OT7k/0RMmz7K45n/ZBTj72JgVageM4RnrCvODVRwTkM
 jl7gIr8DjdaIVsKP5xc78wu1xmGWyylHuA==
X-Google-Smtp-Source: ABdhPJy/+tX7XIuEwF8sT3Af/mBb4CFJgHV8+u6LX4H6yhVlOmeGB47YXroFDe1bH9AUHFe91rdDXQ==
X-Received: by 2002:adf:e908:: with SMTP id f8mr4219043wrm.3.1593184518367;
 Fri, 26 Jun 2020 08:15:18 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id w13sm37838852wrr.67.2020.06.26.08.15.17
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2020 08:15:17 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 44/57] target/arm: Add arm_tlb_bti_gp
Date: Fri, 26 Jun 2020 16:14:11 +0100
Message-Id: <20200626151424.30117-45-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200626151424.30117-1-peter.maydell@linaro.org>
References: <20200626151424.30117-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x430.google.com
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

Introduce an lvalue macro to wrap target_tlb_bit0.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200626033144.790098-33-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h           | 13 +++++++++++++
 target/arm/helper.c        |  2 +-
 target/arm/translate-a64.c |  2 +-
 3 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index cb4f6ba69f2..c54f0ab18a1 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3393,6 +3393,19 @@ static inline uint64_t *aa64_vfp_qreg(CPUARMState *env, unsigned regno)
 /* Shared between translate-sve.c and sve_helper.c.  */
 extern const uint64_t pred_esz_masks[4];
 
+/* Helper for the macros below, validating the argument type. */
+static inline MemTxAttrs *typecheck_memtxattrs(MemTxAttrs *x)
+{
+    return x;
+}
+
+/*
+ * Lvalue macros for ARM TLB bits that we must cache in the TCG TLB.
+ * Using these should be a bit more self-documenting than using the
+ * generic target bits directly.
+ */
+#define arm_tlb_bti_gp(x) (typecheck_memtxattrs(x)->target_tlb_bit0)
+
 /*
  * Naming convention for isar_feature functions:
  * Functions which test 32-bit ID registers should have _aa32_ in
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 33f902387b4..44a3f9fb480 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -11079,7 +11079,7 @@ static bool get_phys_addr_lpae(CPUARMState *env, target_ulong address,
     }
     /* When in aarch64 mode, and BTI is enabled, remember GP in the IOTLB.  */
     if (aarch64 && guarded && cpu_isar_feature(aa64_bti, cpu)) {
-        txattrs->target_tlb_bit0 = true;
+        arm_tlb_bti_gp(txattrs) = true;
     }
 
     if (cacheattrs != NULL) {
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index a2a82800102..7a3774bfda7 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -14434,7 +14434,7 @@ static bool is_guarded_page(CPUARMState *env, DisasContext *s)
      * table entry even for that case.
      */
     return (tlb_hit(entry->addr_code, addr) &&
-            env_tlb(env)->d[mmu_idx].iotlb[index].attrs.target_tlb_bit0);
+            arm_tlb_bti_gp(&env_tlb(env)->d[mmu_idx].iotlb[index].attrs));
 #endif
 }
 
-- 
2.20.1


