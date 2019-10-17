Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2403CECE58E
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 19:01:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 984B82089C
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 19:01:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SP47lDN9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 984B82089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57110 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLB22-0004GL-Vb
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 15:01:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35285)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iLAs7-0001Hd-TH
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 14:51:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iLAs6-0000w9-Ab
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 14:51:39 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:34765)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iLAs6-0000u6-3P
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 14:51:38 -0400
Received: by mail-pl1-x641.google.com with SMTP id k7so1573844pll.1
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 11:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=PtanC1h+OlQIbLy4htGIe38tBGV1DOrNspWjSEGlJl4=;
 b=SP47lDN9vZ18I31VNt2RCv9GKvJZnOtP7D4EsSAibJZBPpQ83JQMttdGjZQmJTfPJb
 b4j8c7ZOcx7Z88iPlLkbkNHfN+hyv6pMcHTf+mHgmxHMdmKAVYo2tRCyLBRsjpU9FerR
 uueU7kECQJJInWekauxJuzrfWC/0/BZpVIVlaq/0WM5mvM/pmzXGNFiw41WCIsi5rKV3
 Kv6hfS/0PHUlGz2jw5BnEvtkF7u0HpdYy9tEwVGOs/0cz+37cmVdGDDtdfWNoZHoepPn
 MOOUt9h9oFgFHDWOtUUyIYj1J9RYzCxyL0KyUIb7Cb0hRNTAPQya2hWE/Jzr9dWb6Fpt
 HFbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=PtanC1h+OlQIbLy4htGIe38tBGV1DOrNspWjSEGlJl4=;
 b=DUuCJIq6OYnwPglb6dFGUdfgRDVak919CLmQddoPKGJDygHauVLbeUH7SJCbul9BOP
 v8r4SD8aoWfO+qEl0hMM/EFpZzEkDSMeCUmnuyfc22HRV/WbtCH4JUGA/iNgoqNAgmxO
 iUX+yXT43QUNLz77b8XCl5odU1jP2h9jGTWTOx5Usgl78Jp5zwNAzPjG7uom7LMiowRy
 mnAuKdnVRGlPZQKyc5SAOmZhqUa6WoI1yHV4Rd+kNOXpfthr7DQwn7rSsVE+R3AXUPJ2
 HZ/WtgeDaFIOv0PfskY/uypE3/KNytqEtGZLxGFprnOySNIj8GxP73foDLOGKAMzuKUh
 V/Rg==
X-Gm-Message-State: APjAAAW93gxlaRBrQEGgyyt9MqFdgmSoA5ox3rv4yDXHqd+qR3ZNXpL8
 cUVIYY4wJe3NSXVXSHRee7zq54Hez88=
X-Google-Smtp-Source: APXvYqybrj5fYPzFrKLeOo7zrf45TGFbdy0DOefW10vDCRRfx0+FDy3VK/9//Rnp55BK1XAPugyYhw==
X-Received: by 2002:a17:902:8343:: with SMTP id
 z3mr5544054pln.70.1571338288207; 
 Thu, 17 Oct 2019 11:51:28 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id s97sm5009256pjc.4.2019.10.17.11.51.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2019 11:51:27 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 12/20] target/arm: Add arm_rebuild_hflags
Date: Thu, 17 Oct 2019 11:51:02 -0700
Message-Id: <20191017185110.539-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191017185110.539-1-richard.henderson@linaro.org>
References: <20191017185110.539-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::641
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This function assumes nothing about the current state of the cpu,
and writes the computed value to env->hflags.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h    |  6 ++++++
 target/arm/helper.c | 30 ++++++++++++++++++++++--------
 2 files changed, 28 insertions(+), 8 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 9909ff89d4..d844ea21d8 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3297,6 +3297,12 @@ void arm_register_pre_el_change_hook(ARMCPU *cpu, ARMELChangeHookFn *hook,
 void arm_register_el_change_hook(ARMCPU *cpu, ARMELChangeHookFn *hook, void
         *opaque);
 
+/**
+ * arm_rebuild_hflags:
+ * Rebuild the cached TBFLAGS for arbitrary changed processor state.
+ */
+void arm_rebuild_hflags(CPUARMState *env);
+
 /**
  * aa32_vfp_dreg:
  * Return a pointer to the Dn register within env in 32-bit mode.
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 89aa6fd933..85de96d071 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -11198,17 +11198,35 @@ static uint32_t rebuild_hflags_a64(CPUARMState *env, int el, int fp_el,
     return rebuild_hflags_common(env, fp_el, mmu_idx, flags);
 }
 
+static uint32_t rebuild_hflags_internal(CPUARMState *env)
+{
+    int el = arm_current_el(env);
+    int fp_el = fp_exception_el(env, el);
+    ARMMMUIdx mmu_idx = arm_mmu_idx(env);
+
+    if (is_a64(env)) {
+        return rebuild_hflags_a64(env, el, fp_el, mmu_idx);
+    } else if (arm_feature(env, ARM_FEATURE_M)) {
+        return rebuild_hflags_m32(env, fp_el, mmu_idx);
+    } else {
+        return rebuild_hflags_a32(env, fp_el, mmu_idx);
+    }
+}
+
+void arm_rebuild_hflags(CPUARMState *env)
+{
+    env->hflags = rebuild_hflags_internal(env);
+}
+
 void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
                           target_ulong *cs_base, uint32_t *pflags)
 {
-    ARMMMUIdx mmu_idx = arm_mmu_idx(env);
-    int current_el = arm_current_el(env);
-    int fp_el = fp_exception_el(env, current_el);
     uint32_t flags, pstate_for_ss;
 
+    flags = rebuild_hflags_internal(env);
+
     if (is_a64(env)) {
         *pc = env->pc;
-        flags = rebuild_hflags_a64(env, current_el, fp_el, mmu_idx);
         if (cpu_isar_feature(aa64_bti, env_archcpu(env))) {
             flags = FIELD_DP32(flags, TBFLAG_A64, BTYPE, env->btype);
         }
@@ -11217,8 +11235,6 @@ void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
         *pc = env->regs[15];
 
         if (arm_feature(env, ARM_FEATURE_M)) {
-            flags = rebuild_hflags_m32(env, fp_el, mmu_idx);
-
             if (arm_feature(env, ARM_FEATURE_M_SECURITY) &&
                 FIELD_EX32(env->v7m.fpccr[M_REG_S], V7M_FPCCR, S)
                 != env->v7m.secure) {
@@ -11242,8 +11258,6 @@ void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
                 flags = FIELD_DP32(flags, TBFLAG_A32, LSPACT, 1);
             }
         } else {
-            flags = rebuild_hflags_a32(env, fp_el, mmu_idx);
-
             /*
              * Note that XSCALE_CPAR shares bits with VECSTRIDE.
              * Note that VECLEN+VECSTRIDE are RES0 for M-profile.
-- 
2.17.1


