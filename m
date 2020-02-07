Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A17DC04EB5
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 14:36:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56FC420720
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 14:36:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c3Uvx0+N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56FC420720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57918 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j04kZ-0005kg-Hz
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 09:36:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51563)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j04ht-0000Pn-03
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 09:34:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j04hn-0002ja-H1
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 09:34:08 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b]:54636)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j04hn-0002iD-9D
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 09:34:03 -0500
Received: by mail-wm1-x32b.google.com with SMTP id g1so2785978wmh.4
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2020 06:34:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=TQPPrtjdwVz41m/9N7UotbrI/z67Nsmq49aMZwnBiso=;
 b=c3Uvx0+NGaZh+EE8H9FXU/5DChd2WqJC0q/0fZYhUeeUroSUHlgH44uO1cu1XMin8/
 vWijA0KT/+n0sHXFECbOWunH2OxrEJBa5cxg7BYPf6kWI9jWm5mz1zVWOLXLM1LLZSAN
 ory2MWqpt4UzzKXKhT6O3bo/vc1rjRK2//8hGFhneF7Jd/lSgkZEeHdXG59T4SYMYIAA
 YYzApejpUd6uyqvqMzPOGqiLo+Ymz3cEVnyBr5dzOxZvG953IoeQn+EBylynzTWRC5Oo
 4ck29Y5boghmdgJA7VfjXg/oht5T/x+96ZFw9BUlvE6p5ueNrk96Ru6cWE1idPrGfWZd
 41Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=TQPPrtjdwVz41m/9N7UotbrI/z67Nsmq49aMZwnBiso=;
 b=eZFIpF1Vj5jSllg17IS4ww26Z/SmGvw7RxPDT5a+Sq1A8dUS9LA1BEbSuz7cY4e5S5
 AAmAJjtIZ3wvjYJi7sdb2Ko15Z9CrIr00c9zPtaaWKhpLVbysQTWqZC2Dqr0OQ/wpk/W
 wmmr9ep0/YdsbOtqLQggX1efWl3wWkxomJfCsXPftIcsUI8lOa2pvIzrInbUtl1CPRtk
 P/wK491U3WwXPzejRaMhbhLpbV1N1E9u18OjNbNiqESml7jEUp85sQwY2gurIUoXlZgH
 1s/9h+uf2M0ciWUeusnarH+2hDc5Wc8iwxNdEKY7Tm45jYjDoVxyF4SFSm7xM1lXmKlP
 c+HQ==
X-Gm-Message-State: APjAAAWNeXnjjPiLDJo54FgH0MirOyGMgFFEYsyGY7gXS7A8PmRDhs+9
 uJxyrjDfiGqMtPqKfHDyxFy6o0nMYTA=
X-Google-Smtp-Source: APXvYqxncHL4VYxNNb9l1QNKg0uV+T7ZaNCEg8CWXxlp7IFZdPq4zBV+ziM+2sxoG7ZgocR0jofccQ==
X-Received: by 2002:a1c:a754:: with SMTP id q81mr4776965wme.139.1581086041888; 
 Fri, 07 Feb 2020 06:34:01 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id w1sm3796430wro.72.2020.02.07.06.34.00
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Feb 2020 06:34:01 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 15/48] target/arm: Rename ARMMMUIdx_S1E2 to ARMMMUIdx_E2
Date: Fri,  7 Feb 2020 14:33:10 +0000
Message-Id: <20200207143343.30322-16-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200207143343.30322-1-peter.maydell@linaro.org>
References: <20200207143343.30322-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32b
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
The non-secure EL2 regime only has a single stage translation;
there is no point in pointing out that the idx is for stage1.

Tested-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200206105448.4726-15-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h       |  4 ++--
 target/arm/internals.h |  2 +-
 target/arm/helper.c    | 22 +++++++++++-----------
 target/arm/translate.c |  2 +-
 4 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 9f01ec8dd24..a188398b03e 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -2907,7 +2907,7 @@ static inline bool arm_excp_unmasked(CPUState *cs, unsigned int excp_idx,
 typedef enum ARMMMUIdx {
     ARMMMUIdx_E10_0 = 0 | ARM_MMU_IDX_A,
     ARMMMUIdx_E10_1 = 1 | ARM_MMU_IDX_A,
-    ARMMMUIdx_S1E2 = 2 | ARM_MMU_IDX_A,
+    ARMMMUIdx_E2 = 2 | ARM_MMU_IDX_A,
     ARMMMUIdx_SE3 = 3 | ARM_MMU_IDX_A,
     ARMMMUIdx_SE10_0 = 4 | ARM_MMU_IDX_A,
     ARMMMUIdx_SE10_1 = 5 | ARM_MMU_IDX_A,
@@ -2933,7 +2933,7 @@ typedef enum ARMMMUIdx {
 typedef enum ARMMMUIdxBit {
     ARMMMUIdxBit_E10_0 = 1 << 0,
     ARMMMUIdxBit_E10_1 = 1 << 1,
-    ARMMMUIdxBit_S1E2 = 1 << 2,
+    ARMMMUIdxBit_E2 = 1 << 2,
     ARMMMUIdxBit_SE3 = 1 << 3,
     ARMMMUIdxBit_SE10_0 = 1 << 4,
     ARMMMUIdxBit_SE10_1 = 1 << 5,
diff --git a/target/arm/internals.h b/target/arm/internals.h
index d8730fbbad3..5b8b9c233fe 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -812,7 +812,7 @@ static inline bool regime_is_secure(CPUARMState *env, ARMMMUIdx mmu_idx)
     case ARMMMUIdx_E10_1:
     case ARMMMUIdx_Stage1_E0:
     case ARMMMUIdx_Stage1_E1:
-    case ARMMMUIdx_S1E2:
+    case ARMMMUIdx_E2:
     case ARMMMUIdx_Stage2:
     case ARMMMUIdx_MPrivNegPri:
     case ARMMMUIdx_MUserNegPri:
diff --git a/target/arm/helper.c b/target/arm/helper.c
index f5d97da1c48..7ee41974566 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -728,7 +728,7 @@ static void tlbiall_hyp_write(CPUARMState *env, const ARMCPRegInfo *ri,
 {
     CPUState *cs = env_cpu(env);
 
-    tlb_flush_by_mmuidx(cs, ARMMMUIdxBit_S1E2);
+    tlb_flush_by_mmuidx(cs, ARMMMUIdxBit_E2);
 }
 
 static void tlbiall_hyp_is_write(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -736,7 +736,7 @@ static void tlbiall_hyp_is_write(CPUARMState *env, const ARMCPRegInfo *ri,
 {
     CPUState *cs = env_cpu(env);
 
-    tlb_flush_by_mmuidx_all_cpus_synced(cs, ARMMMUIdxBit_S1E2);
+    tlb_flush_by_mmuidx_all_cpus_synced(cs, ARMMMUIdxBit_E2);
 }
 
 static void tlbimva_hyp_write(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -745,7 +745,7 @@ static void tlbimva_hyp_write(CPUARMState *env, const ARMCPRegInfo *ri,
     CPUState *cs = env_cpu(env);
     uint64_t pageaddr = value & ~MAKE_64BIT_MASK(0, 12);
 
-    tlb_flush_page_by_mmuidx(cs, pageaddr, ARMMMUIdxBit_S1E2);
+    tlb_flush_page_by_mmuidx(cs, pageaddr, ARMMMUIdxBit_E2);
 }
 
 static void tlbimva_hyp_is_write(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -755,7 +755,7 @@ static void tlbimva_hyp_is_write(CPUARMState *env, const ARMCPRegInfo *ri,
     uint64_t pageaddr = value & ~MAKE_64BIT_MASK(0, 12);
 
     tlb_flush_page_by_mmuidx_all_cpus_synced(cs, pageaddr,
-                                             ARMMMUIdxBit_S1E2);
+                                             ARMMMUIdxBit_E2);
 }
 
 static const ARMCPRegInfo cp_reginfo[] = {
@@ -3238,7 +3238,7 @@ static void ats1h_write(CPUARMState *env, const ARMCPRegInfo *ri,
     MMUAccessType access_type = ri->opc2 & 1 ? MMU_DATA_STORE : MMU_DATA_LOAD;
     uint64_t par64;
 
-    par64 = do_ats_write(env, value, access_type, ARMMMUIdx_S1E2);
+    par64 = do_ats_write(env, value, access_type, ARMMMUIdx_E2);
 
     A32_BANKED_CURRENT_REG_SET(env, par, par64);
 }
@@ -3266,7 +3266,7 @@ static void ats_write64(CPUARMState *env, const ARMCPRegInfo *ri,
             mmu_idx = secure ? ARMMMUIdx_SE10_1 : ARMMMUIdx_Stage1_E1;
             break;
         case 4: /* AT S1E2R, AT S1E2W */
-            mmu_idx = ARMMMUIdx_S1E2;
+            mmu_idx = ARMMMUIdx_E2;
             break;
         case 6: /* AT S1E3R, AT S1E3W */
             mmu_idx = ARMMMUIdx_SE3;
@@ -4004,7 +4004,7 @@ static void tlbi_aa64_alle2_write(CPUARMState *env, const ARMCPRegInfo *ri,
     ARMCPU *cpu = env_archcpu(env);
     CPUState *cs = CPU(cpu);
 
-    tlb_flush_by_mmuidx(cs, ARMMMUIdxBit_S1E2);
+    tlb_flush_by_mmuidx(cs, ARMMMUIdxBit_E2);
 }
 
 static void tlbi_aa64_alle3_write(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -4030,7 +4030,7 @@ static void tlbi_aa64_alle2is_write(CPUARMState *env, const ARMCPRegInfo *ri,
 {
     CPUState *cs = env_cpu(env);
 
-    tlb_flush_by_mmuidx_all_cpus_synced(cs, ARMMMUIdxBit_S1E2);
+    tlb_flush_by_mmuidx_all_cpus_synced(cs, ARMMMUIdxBit_E2);
 }
 
 static void tlbi_aa64_alle3is_write(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -4052,7 +4052,7 @@ static void tlbi_aa64_vae2_write(CPUARMState *env, const ARMCPRegInfo *ri,
     CPUState *cs = CPU(cpu);
     uint64_t pageaddr = sextract64(value << 12, 0, 56);
 
-    tlb_flush_page_by_mmuidx(cs, pageaddr, ARMMMUIdxBit_S1E2);
+    tlb_flush_page_by_mmuidx(cs, pageaddr, ARMMMUIdxBit_E2);
 }
 
 static void tlbi_aa64_vae3_write(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -4105,7 +4105,7 @@ static void tlbi_aa64_vae2is_write(CPUARMState *env, const ARMCPRegInfo *ri,
     uint64_t pageaddr = sextract64(value << 12, 0, 56);
 
     tlb_flush_page_by_mmuidx_all_cpus_synced(cs, pageaddr,
-                                             ARMMMUIdxBit_S1E2);
+                                             ARMMMUIdxBit_E2);
 }
 
 static void tlbi_aa64_vae3is_write(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -8711,7 +8711,7 @@ static inline uint32_t regime_el(CPUARMState *env, ARMMMUIdx mmu_idx)
 {
     switch (mmu_idx) {
     case ARMMMUIdx_Stage2:
-    case ARMMMUIdx_S1E2:
+    case ARMMMUIdx_E2:
         return 2;
     case ARMMMUIdx_SE3:
         return 3;
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 75afcb03fb4..91e2ca55154 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -152,7 +152,7 @@ static inline int get_a32_user_mem_index(DisasContext *s)
      *  otherwise, access as if at PL0.
      */
     switch (s->mmu_idx) {
-    case ARMMMUIdx_S1E2:        /* this one is UNPREDICTABLE */
+    case ARMMMUIdx_E2:        /* this one is UNPREDICTABLE */
     case ARMMMUIdx_E10_0:
     case ARMMMUIdx_E10_1:
         return arm_to_core_mmu_idx(ARMMMUIdx_E10_0);
-- 
2.20.1


