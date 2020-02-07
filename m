Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B124C04EB5
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 14:47:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2524120720
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 14:47:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BTHE/bsf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2524120720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58248 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j04uJ-0001G7-87
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 09:46:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51472)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j04hn-00008z-Hv
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 09:34:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j04hm-0002gu-6C
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 09:34:03 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:39281)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j04hl-0002fJ-Uq
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 09:34:02 -0500
Received: by mail-wr1-x441.google.com with SMTP id y11so2954443wrt.6
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2020 06:34:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=BpVMrjdfRhdeHAGKi2OF43X1WwKXe+FUTiuYluqLizI=;
 b=BTHE/bsfUlgmVDp83zxwSaUkAIAnRY3vSZKwW+0cjImGz8P27xixww24MtR2QAJAWh
 xbfPzO5+EUj780kUgYskwDlqa7Gf/qVgWedXtMS74AQnQVS4DTI7iXg5h+sEOP4W3BzH
 NVDTiCCio6txNK+fO3tC8EK1Si2eYKiPf7SvdpJSEECsoHO5DaAWAIrsDwC6gaMAUz3M
 iwHhmv8YR0bbgvICWOdV6sn8NyPlsCE7VQ1AKT8biVo7iqx0DwX6fwlMiOhH3hYnz+ju
 vDWfr0lsyeZAcJFAG62sH3s4avE07ze2KHNuepfDN6LOk/3JKyueTC3fOZZTSOmviQcG
 VQoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=BpVMrjdfRhdeHAGKi2OF43X1WwKXe+FUTiuYluqLizI=;
 b=cxajCI1lKmDWMVp7W6arujnUBgKl53rnmEGEZsP+yoCd+imiOnQzBykZgQQTs2BVYi
 Kab7i2ChPsBrBQ9X+2XxaiChv4+NY4j0rZOJfMsABl3P10M1pQ56qLxmQwEojLwN2htA
 QvA0mj9aOrx1czRIdyASUWcqjPQx4qPhqYc+4d2zhmagEG46DmLWJElew2+67IGPtfBb
 jEoQXzcERMmOB4bQ2NLhYMIj8U9LC+RMKeRfyL+mvIyvgbdReWtg3B4GCnZJry4zdqfM
 veOVbEW4HAB7151IPcvwbDCbZX4u/+DPkHSYY+5sPHaaKHLzBfSRY6jCP7M7tpdhmuig
 7+TQ==
X-Gm-Message-State: APjAAAU4cUdKMW0SlHibax4WjfYZ8hnNtJ7QArngN2DJzn1jGT/y687X
 FKBMDjQKqj7SlUCiKU+sB/Km1zS1y8A=
X-Google-Smtp-Source: APXvYqz18gIU6dGLMUn1CzdLyQZYHtmwprTzCIHAyG5cQa9PGdJ15eOaNXhWhjmWaisme2RE7qSypQ==
X-Received: by 2002:a5d:484f:: with SMTP id n15mr4990584wrs.365.1581086040546; 
 Fri, 07 Feb 2020 06:34:00 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id w1sm3796430wro.72.2020.02.07.06.33.59
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Feb 2020 06:34:00 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 14/48] target/arm: Rename ARMMMUIdx*_S1E3 to ARMMMUIdx*_SE3
Date: Fri,  7 Feb 2020 14:33:09 +0000
Message-Id: <20200207143343.30322-15-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200207143343.30322-1-peter.maydell@linaro.org>
References: <20200207143343.30322-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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

This is part of a reorganization to the set of mmu_idx.
The EL3 regime only has a single stage translation, and
is always secure.

Tested-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200206105448.4726-14-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h       |  4 ++--
 target/arm/internals.h |  2 +-
 target/arm/helper.c    | 14 +++++++-------
 target/arm/translate.c |  2 +-
 4 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 6cf2b3d6fd7..9f01ec8dd24 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -2908,7 +2908,7 @@ typedef enum ARMMMUIdx {
     ARMMMUIdx_E10_0 = 0 | ARM_MMU_IDX_A,
     ARMMMUIdx_E10_1 = 1 | ARM_MMU_IDX_A,
     ARMMMUIdx_S1E2 = 2 | ARM_MMU_IDX_A,
-    ARMMMUIdx_S1E3 = 3 | ARM_MMU_IDX_A,
+    ARMMMUIdx_SE3 = 3 | ARM_MMU_IDX_A,
     ARMMMUIdx_SE10_0 = 4 | ARM_MMU_IDX_A,
     ARMMMUIdx_SE10_1 = 5 | ARM_MMU_IDX_A,
     ARMMMUIdx_Stage2 = 6 | ARM_MMU_IDX_A,
@@ -2934,7 +2934,7 @@ typedef enum ARMMMUIdxBit {
     ARMMMUIdxBit_E10_0 = 1 << 0,
     ARMMMUIdxBit_E10_1 = 1 << 1,
     ARMMMUIdxBit_S1E2 = 1 << 2,
-    ARMMMUIdxBit_S1E3 = 1 << 3,
+    ARMMMUIdxBit_SE3 = 1 << 3,
     ARMMMUIdxBit_SE10_0 = 1 << 4,
     ARMMMUIdxBit_SE10_1 = 1 << 5,
     ARMMMUIdxBit_Stage2 = 1 << 6,
diff --git a/target/arm/internals.h b/target/arm/internals.h
index eafcd326e11..d8730fbbad3 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -819,7 +819,7 @@ static inline bool regime_is_secure(CPUARMState *env, ARMMMUIdx mmu_idx)
     case ARMMMUIdx_MPriv:
     case ARMMMUIdx_MUser:
         return false;
-    case ARMMMUIdx_S1E3:
+    case ARMMMUIdx_SE3:
     case ARMMMUIdx_SE10_0:
     case ARMMMUIdx_SE10_1:
     case ARMMMUIdx_MSPrivNegPri:
diff --git a/target/arm/helper.c b/target/arm/helper.c
index bbceb7a38ed..f5d97da1c48 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -3187,7 +3187,7 @@ static void ats_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
         /* stage 1 current state PL1: ATS1CPR, ATS1CPW */
         switch (el) {
         case 3:
-            mmu_idx = ARMMMUIdx_S1E3;
+            mmu_idx = ARMMMUIdx_SE3;
             break;
         case 2:
             mmu_idx = ARMMMUIdx_Stage1_E1;
@@ -3269,7 +3269,7 @@ static void ats_write64(CPUARMState *env, const ARMCPRegInfo *ri,
             mmu_idx = ARMMMUIdx_S1E2;
             break;
         case 6: /* AT S1E3R, AT S1E3W */
-            mmu_idx = ARMMMUIdx_S1E3;
+            mmu_idx = ARMMMUIdx_SE3;
             break;
         default:
             g_assert_not_reached();
@@ -4013,7 +4013,7 @@ static void tlbi_aa64_alle3_write(CPUARMState *env, const ARMCPRegInfo *ri,
     ARMCPU *cpu = env_archcpu(env);
     CPUState *cs = CPU(cpu);
 
-    tlb_flush_by_mmuidx(cs, ARMMMUIdxBit_S1E3);
+    tlb_flush_by_mmuidx(cs, ARMMMUIdxBit_SE3);
 }
 
 static void tlbi_aa64_alle1is_write(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -4038,7 +4038,7 @@ static void tlbi_aa64_alle3is_write(CPUARMState *env, const ARMCPRegInfo *ri,
 {
     CPUState *cs = env_cpu(env);
 
-    tlb_flush_by_mmuidx_all_cpus_synced(cs, ARMMMUIdxBit_S1E3);
+    tlb_flush_by_mmuidx_all_cpus_synced(cs, ARMMMUIdxBit_SE3);
 }
 
 static void tlbi_aa64_vae2_write(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -4066,7 +4066,7 @@ static void tlbi_aa64_vae3_write(CPUARMState *env, const ARMCPRegInfo *ri,
     CPUState *cs = CPU(cpu);
     uint64_t pageaddr = sextract64(value << 12, 0, 56);
 
-    tlb_flush_page_by_mmuidx(cs, pageaddr, ARMMMUIdxBit_S1E3);
+    tlb_flush_page_by_mmuidx(cs, pageaddr, ARMMMUIdxBit_SE3);
 }
 
 static void tlbi_aa64_vae1is_write(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -4115,7 +4115,7 @@ static void tlbi_aa64_vae3is_write(CPUARMState *env, const ARMCPRegInfo *ri,
     uint64_t pageaddr = sextract64(value << 12, 0, 56);
 
     tlb_flush_page_by_mmuidx_all_cpus_synced(cs, pageaddr,
-                                             ARMMMUIdxBit_S1E3);
+                                             ARMMMUIdxBit_SE3);
 }
 
 static void tlbi_aa64_ipas2e1_write(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -8713,7 +8713,7 @@ static inline uint32_t regime_el(CPUARMState *env, ARMMMUIdx mmu_idx)
     case ARMMMUIdx_Stage2:
     case ARMMMUIdx_S1E2:
         return 2;
-    case ARMMMUIdx_S1E3:
+    case ARMMMUIdx_SE3:
         return 3;
     case ARMMMUIdx_SE10_0:
         return arm_el_is_aa64(env, 3) ? 1 : 3;
diff --git a/target/arm/translate.c b/target/arm/translate.c
index a2019a9b2a9..75afcb03fb4 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -156,7 +156,7 @@ static inline int get_a32_user_mem_index(DisasContext *s)
     case ARMMMUIdx_E10_0:
     case ARMMMUIdx_E10_1:
         return arm_to_core_mmu_idx(ARMMMUIdx_E10_0);
-    case ARMMMUIdx_S1E3:
+    case ARMMMUIdx_SE3:
     case ARMMMUIdx_SE10_0:
     case ARMMMUIdx_SE10_1:
         return arm_to_core_mmu_idx(ARMMMUIdx_SE10_0);
-- 
2.20.1


