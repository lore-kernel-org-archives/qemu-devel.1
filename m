Return-Path: <SRS0=192v=3S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE0BBC2D0DB
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 23:59:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7411205ED
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 23:59:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iwlC429E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7411205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53506 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwxFT-0000qo-U2
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 18:59:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45266)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iwxCF-0003kN-Pj
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 18:56:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iwxCE-0007PO-Cf
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 18:56:35 -0500
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:43135)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iwxCE-0007Nb-5M
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 18:56:34 -0500
Received: by mail-pl1-x642.google.com with SMTP id p11so585346plq.10
 for <qemu-devel@nongnu.org>; Wed, 29 Jan 2020 15:56:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=F97ccFFpgN2jap+4MXDqqZKDp3fVgmtxlSIdCifyU/4=;
 b=iwlC429EWloxYmPTXEIAlUSe2rHfYUk8OaMbcDvUjmy+7Ld6Oap+aq3MiEjoiCgMDC
 XlMihB8xoCnEue+u/g9yChJ3WYDOocY/DCC/CPi8GN5eBqOyvIn8AUtCixmlWPBq1TGY
 7wpIqEgLpDziZkYpqM4lO0lmUN87ekdk1qrp21fMKCB2NCt7F6TT0f3xIREDDJTNfB4X
 2i1gS5Qo3y7W203WuSqL08PNn/fiVxAwA+isif1hBbTN1sVzJyiyLF6Cd6IsY+xp9vYo
 3+JyFVazC5b+GVrOOTsotFwQdBXmSjpv8o39wtCUb/rf/ZnwTHwoGDnmBaAeAIvL2V4K
 qYqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=F97ccFFpgN2jap+4MXDqqZKDp3fVgmtxlSIdCifyU/4=;
 b=hSfPVlXIG3POyN8yWr4WgbFrxjpYUM5To2CnXdeNz881CbfzoKXoWIn3XTrvuXdrXY
 WFTMJszhfHciHoo61VjRUk1KE9sucg/+kNklElUb1qdFLT8lZ2kUH2GGX68GKp/E1+sX
 QsqdkccliBEXhlZCSAiSS3x2FaD2yD9rW97tAsccYY5xF0O4XGJyxlWjt15MEWUmVgJZ
 up6paDOfW61jMA1e1ZDs1NPQ8SEtmp7xW9E8PkraF3qU5uCgpc4tU+CxaqCApPUQlMWM
 G+JiKxmiKJOaqYSLhX+DNFtEMJ/oiHGPXm5N/iChxP4lFchN6Ck4iRDP5xqeXgJPBJiu
 VDsA==
X-Gm-Message-State: APjAAAXOtWMRPNkOrEKdymvkejgyP5VGnnsM5f3Y5mK/fb31GzGcKiOZ
 sfD6h8o0ueNfPtAxFWSmOGTozVMWC/Q=
X-Google-Smtp-Source: APXvYqymTGVWq6M5bzEFjw4W8i7seE4OtR0ePDeBPOd2Y811f3MJDMo6lnJcwLfgII0Kfu8y2Krq5g==
X-Received: by 2002:a17:90b:30c9:: with SMTP id
 hi9mr1478801pjb.81.1580342192197; 
 Wed, 29 Jan 2020 15:56:32 -0800 (PST)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id r3sm3953626pfg.145.2020.01.29.15.56.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jan 2020 15:56:31 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 13/41] target/arm: Rename ARMMMUIdx*_S1E3 to ARMMMUIdx*_SE3
Date: Wed, 29 Jan 2020 15:55:46 -0800
Message-Id: <20200129235614.29829-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200129235614.29829-1-richard.henderson@linaro.org>
References: <20200129235614.29829-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::642
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
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is part of a reorganization to the set of mmu_idx.
The EL3 regime only has a single stage translation, and
is always secure.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h       |  4 ++--
 target/arm/internals.h |  2 +-
 target/arm/helper.c    | 14 +++++++-------
 target/arm/translate.c |  2 +-
 4 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index bfcc83a319..a5133b74c3 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -2901,7 +2901,7 @@ typedef enum ARMMMUIdx {
     ARMMMUIdx_E10_0 = 0 | ARM_MMU_IDX_A,
     ARMMMUIdx_E10_1 = 1 | ARM_MMU_IDX_A,
     ARMMMUIdx_S1E2 = 2 | ARM_MMU_IDX_A,
-    ARMMMUIdx_S1E3 = 3 | ARM_MMU_IDX_A,
+    ARMMMUIdx_SE3 = 3 | ARM_MMU_IDX_A,
     ARMMMUIdx_SE10_0 = 4 | ARM_MMU_IDX_A,
     ARMMMUIdx_SE10_1 = 5 | ARM_MMU_IDX_A,
     ARMMMUIdx_Stage2 = 6 | ARM_MMU_IDX_A,
@@ -2927,7 +2927,7 @@ typedef enum ARMMMUIdxBit {
     ARMMMUIdxBit_E10_0 = 1 << 0,
     ARMMMUIdxBit_E10_1 = 1 << 1,
     ARMMMUIdxBit_S1E2 = 1 << 2,
-    ARMMMUIdxBit_S1E3 = 1 << 3,
+    ARMMMUIdxBit_SE3 = 1 << 3,
     ARMMMUIdxBit_SE10_0 = 1 << 4,
     ARMMMUIdxBit_SE10_1 = 1 << 5,
     ARMMMUIdxBit_Stage2 = 1 << 6,
diff --git a/target/arm/internals.h b/target/arm/internals.h
index eafcd326e1..d8730fbbad 100644
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
index 2b5544e66a..aac117db33 100644
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
@@ -8712,7 +8712,7 @@ static inline uint32_t regime_el(CPUARMState *env, ARMMMUIdx mmu_idx)
     case ARMMMUIdx_Stage2:
     case ARMMMUIdx_S1E2:
         return 2;
-    case ARMMMUIdx_S1E3:
+    case ARMMMUIdx_SE3:
         return 3;
     case ARMMMUIdx_SE10_0:
         return arm_el_is_aa64(env, 3) ? 1 : 3;
diff --git a/target/arm/translate.c b/target/arm/translate.c
index a2019a9b2a..75afcb03fb 100644
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


