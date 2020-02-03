Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A87CFC35247
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 14:56:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7172E2082E
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 14:56:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JXVWnqxv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7172E2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42636 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyd9k-00007a-Gb
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 09:56:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44794)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iyd0l-0007Du-1l
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 09:47:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iyd0j-0003QA-PL
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 09:47:38 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:36604)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iyd0j-0003O3-In
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 09:47:37 -0500
Received: by mail-wr1-x443.google.com with SMTP id z3so18570030wru.3
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2020 06:47:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=IuKBvOWRLR1mygq3KRUQA3yOE5ySqkxN0SbADQ9Z81s=;
 b=JXVWnqxvQ/7nxy9Ez1gIwCk2ia//eXTZ/x/UP0+CnEhTTC9HpBQmDZgxnl1iHbwAhs
 fs2f0591pbxCiLNkF3vMSBztizLf4zvYbik5PpSsPbuXr+7EEYJja2/GpjSOuJC2e3Z5
 yKwq4MQH50Vhaz9pOXBxeG9cXQWD2UGfOnlUqpdz0XBQq1/NgxkEsYnCwPMd5dnDt/XD
 bPfifjmBmoKiJonTvP31i3uZgUToTadZPrEoTp1CBXG1MrXisUtsVwMgGnioPgmJB7fQ
 kscOu1e7Zl+47YJ3+r029qsEgSRwJdUJxlhrRcGVZaf12iSPDimzfy2e744ya7KHVW0A
 pBxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=IuKBvOWRLR1mygq3KRUQA3yOE5ySqkxN0SbADQ9Z81s=;
 b=fl5bLwhyqq3glcQKU7XnJWlULWeQ2P20IwpJvoVNVGdYvKLICre8mbucG9MUPD4aWB
 tdC1WcZQKztWTJNJwmUXgwcMqTY5hnzwZ0NTWKFFZZbCc0C8pYh/iPSFE1mhaT19nUd2
 owzhhfnvetP3tCt9oPUAvZc37IlMqCNLGsQ4+3GdVjP7vyqlB31umhZLdkDHFnMDpijk
 faPSvZh5n4sNhrcMyIwLChAlBB30E/Fm+paUyATi8s3//8PHBKvR8m6Zt65daLl9qqDB
 ujnBYotcjs3iA126iT79w2EzxCMAhiw0BhBNn5o+Ea44oG3THnfSxM0htsCK0pn6KEJ/
 MTnw==
X-Gm-Message-State: APjAAAWN5wrGJZoz7lQaO7wA7SpjRbyHHPS/tmUg04FXODKR5eUd1n5F
 T76x6kmSQKYWv3zOXE3N6PlGrMu04OsoaA==
X-Google-Smtp-Source: APXvYqx5FSbCRrKyFEegipKJwbEhTNX2lM2w+k5F/iTWNeejW7Hm20zGdjS1beKUideMuTZn1RpziA==
X-Received: by 2002:adf:ffc7:: with SMTP id x7mr15753461wrs.159.1580741256340; 
 Mon, 03 Feb 2020 06:47:36 -0800 (PST)
Received: from cloudburst.c.hoisthospitality.com ([135.196.99.211])
 by smtp.gmail.com with ESMTPSA id h2sm26429739wrt.45.2020.02.03.06.47.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2020 06:47:35 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 18/20] target/arm: Update MSR access to UAO
Date: Mon,  3 Feb 2020 14:47:14 +0000
Message-Id: <20200203144716.32204-19-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200203144716.32204-1-richard.henderson@linaro.org>
References: <20200203144716.32204-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
v2: Move reginfo to file scope; avoid setting uao from spsr
    when the feature is not enabled (pmm).
v3: Update for aarch64_pstate_valid_mask
---
 target/arm/cpu.h           |  6 ++++++
 target/arm/internals.h     |  3 +++
 target/arm/helper.c        | 21 +++++++++++++++++++++
 target/arm/translate-a64.c | 14 ++++++++++++++
 4 files changed, 44 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 71879393c2..e943ffe8a9 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1253,6 +1253,7 @@ void pmu_init(ARMCPU *cpu);
 #define PSTATE_IL (1U << 20)
 #define PSTATE_SS (1U << 21)
 #define PSTATE_PAN (1U << 22)
+#define PSTATE_UAO (1U << 23)
 #define PSTATE_V (1U << 28)
 #define PSTATE_C (1U << 29)
 #define PSTATE_Z (1U << 30)
@@ -3642,6 +3643,11 @@ static inline bool isar_feature_aa64_ats1e1(const ARMISARegisters *id)
     return FIELD_EX64(id->id_aa64mmfr1, ID_AA64MMFR1, PAN) >= 2;
 }
 
+static inline bool isar_feature_aa64_uao(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64mmfr2, ID_AA64MMFR2, UAO) != 0;
+}
+
 static inline bool isar_feature_aa64_bti(const ARMISARegisters *id)
 {
     return FIELD_EX64(id->id_aa64pfr1, ID_AA64PFR1, BT) != 0;
diff --git a/target/arm/internals.h b/target/arm/internals.h
index 4a139644b5..58c4d707c5 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1112,6 +1112,9 @@ static inline uint32_t aarch64_pstate_valid_mask(const ARMISARegisters *id)
     if (isar_feature_aa64_pan(id)) {
         valid |= PSTATE_PAN;
     }
+    if (isar_feature_aa64_uao(id)) {
+        valid |= PSTATE_UAO;
+    }
 
     return valid;
 }
diff --git a/target/arm/helper.c b/target/arm/helper.c
index a48f37dc05..d847b0f40b 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -4191,6 +4191,24 @@ static const ARMCPRegInfo pan_reginfo = {
     .readfn = aa64_pan_read, .writefn = aa64_pan_write
 };
 
+static uint64_t aa64_uao_read(CPUARMState *env, const ARMCPRegInfo *ri)
+{
+    return env->pstate & PSTATE_UAO;
+}
+
+static void aa64_uao_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                           uint64_t value)
+{
+    env->pstate = (env->pstate & ~PSTATE_UAO) | (value & PSTATE_UAO);
+}
+
+static const ARMCPRegInfo uao_reginfo = {
+    .name = "UAO", .state = ARM_CP_STATE_AA64,
+    .opc0 = 3, .opc1 = 0, .crn = 4, .crm = 2, .opc2 = 4,
+    .type = ARM_CP_NO_RAW, .access = PL1_RW,
+    .readfn = aa64_uao_read, .writefn = aa64_uao_write
+};
+
 static CPAccessResult aa64_cacheop_access(CPUARMState *env,
                                           const ARMCPRegInfo *ri,
                                           bool isread)
@@ -7673,6 +7691,9 @@ void register_cp_regs_for_features(ARMCPU *cpu)
         define_arm_cp_regs(cpu, ats1cp_reginfo);
     }
 #endif
+    if (cpu_isar_feature(aa64_uao, cpu)) {
+        define_one_arm_cp_reg(cpu, &uao_reginfo);
+    }
 
     if (arm_feature(env, ARM_FEATURE_EL2) && cpu_isar_feature(aa64_vh, cpu)) {
         define_arm_cp_regs(cpu, vhe_reginfo);
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index d8ba240a15..7c26c3bfeb 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -1602,6 +1602,20 @@ static void handle_msr_i(DisasContext *s, uint32_t insn,
         s->base.is_jmp = DISAS_NEXT;
         break;
 
+    case 0x03: /* UAO */
+        if (!dc_isar_feature(aa64_uao, s) || s->current_el == 0) {
+            goto do_unallocated;
+        }
+        if (crm & 1) {
+            set_pstate_bits(PSTATE_UAO);
+        } else {
+            clear_pstate_bits(PSTATE_UAO);
+        }
+        t1 = tcg_const_i32(s->current_el);
+        gen_helper_rebuild_hflags_a64(cpu_env, t1);
+        tcg_temp_free_i32(t1);
+        break;
+
     case 0x04: /* PAN */
         if (!dc_isar_feature(aa64_pan, s) || s->current_el == 0) {
             goto do_unallocated;
-- 
2.20.1


