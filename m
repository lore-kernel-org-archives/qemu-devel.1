Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1DC8C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 03:56:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B0BB20767
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 03:56:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kljY/tg6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B0BB20767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46436 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jofTj-0001J5-Mt
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 23:56:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42660)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jof6O-0000po-JI
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 23:32:32 -0400
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:38368)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jof6N-000223-2P
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 23:32:32 -0400
Received: by mail-pj1-x1043.google.com with SMTP id d6so4364180pjs.3
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2020 20:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=2dxpfAALNb5XPHu6yGNW/9lvY8jd7zeVUnhvGixmCRk=;
 b=kljY/tg6Bistn9AWqo8DXLls8tbqdXIGjUwRIYsToIvVMzlbCHSNRC+kwe8m3RN17D
 ohgsa338k+hriVsFYaW635R1rr/PtfFGlGgnojo5oLvpXoDmMtMjzXHEoRxxRdIIDseQ
 3ztNDSjJekgvyFvqGFxRtBOwplSOP04HMLXbVbSnP5vcuHYn9IaTE5Y9cyX8bOsYLJ+z
 UYjihISs6+X3+GsKM03LlxG2mFDM+iD/ShrSftjk0NghDV8sSt9HJNgrjRMSnV0KO6Nd
 rgBo5AO5+ZPf2BzmD1rUz/jK6OH+9v1JzOmEU0UYyNFDZf5AZLZWCehLy+38uPiXbvX/
 pcyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=2dxpfAALNb5XPHu6yGNW/9lvY8jd7zeVUnhvGixmCRk=;
 b=H1Yw4rgnTiqecxtBRLldOQU0a5N7YMm8Yb0/CKZCTZKtwr7/VhYTkSTRx5i7PZcJ4v
 e/u1orY5H1E8BUdEDrv2OkHGRh3P7VRYrQYcgWBGboSkmIdd8FIPeJNj8rMFSmGRZsRb
 yjxPQbQWrGoTqHZBuJcGy9UUszxE+iqaeCg4KmNWqQecmzg0fEDZ8bonOhwFyk0dhrrz
 craBHjZ+pmPpssgD90U7Y05vbl1dUUfl5t+FM0/dRHQQ5XuKQR4NWSVOpxNv8X34x1mu
 Ch3nyZPvwAnR/ckJcZ2urglKJ501ALOzz+dDd9h3FFsRCxTJC5QP+exaO3W0w5wHVs+8
 5c0w==
X-Gm-Message-State: AOAM533LQhhHyJokCpViKtm3YV7HG8yHCmIROdxW3L7DHYZyhgRmfYx3
 Vqe52MhN9FAIyhoAeQh8yLdta/ZEJh0=
X-Google-Smtp-Source: ABdhPJzjBu1F1TiMIGLqD8HVC7eeNTMAtEhAtx2WeBpGENHidUIrYwHcYllTr6+neEEJ2fll47+CXQ==
X-Received: by 2002:a17:902:8a96:: with SMTP id
 p22mr882471plo.281.1593142349428; 
 Thu, 25 Jun 2020 20:32:29 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id y27sm1605256pgc.56.2020.06.25.20.32.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2020 20:32:28 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v9 32/46] target/arm: Add arm_tlb_bti_gp
Date: Thu, 25 Jun 2020 20:31:30 -0700
Message-Id: <20200626033144.790098-33-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200626033144.790098-1-richard.henderson@linaro.org>
References: <20200626033144.790098-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1043;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1043.google.com
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

Introduce an lvalue macro to wrap target_tlb_bit0.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h           | 13 +++++++++++++
 target/arm/helper.c        |  2 +-
 target/arm/translate-a64.c |  2 +-
 3 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index cb4f6ba69f..c54f0ab18a 100644
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
index 33f902387b..44a3f9fb48 100644
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
index a2a8280010..7a3774bfda 100644
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
2.25.1


