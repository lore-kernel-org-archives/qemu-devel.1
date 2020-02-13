Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 915C4C2BA83
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 15:11:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C8E020873
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 15:11:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T+vh/geg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C8E020873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54354 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2G9K-0008Su-A8
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 10:11:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60398)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j2Fh7-0004b6-Gs
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 09:42:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j2Fh6-00028k-82
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 09:42:21 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e]:34930)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j2Fh6-00027R-1B
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 09:42:20 -0500
Received: by mail-wm1-x32e.google.com with SMTP id b17so7044898wmb.0
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2020 06:42:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=JVK/7D63GFoiZgv/DDpmGioUcmsvRCEg+fgmQJe/Src=;
 b=T+vh/gegkmEKjrN+Yml+MXRe4MrnXjFVUj+eONjv0EKA+N495xA630UnRx5wpF54qK
 Tx5YxcwLq8yI2yfU0qUZATyqkXPboCO2aZ19lGbV+9VvuThEwlo1J3SEEgvnBvaC8QoG
 TXu7JBHw2FbYqN5helsNauBQtOh5FUTkumZUzwOuWSZ9c0+3EmMCcG0skqcnHzE4kg2P
 rhALq4c9yAGX2w1q3KLdakm7/IlpXqe6mEl9sP6z+HYNZgtIA0ee8YlIufsYTYkzOT+U
 ICTL0FFsU2fmAMDizAfb0OTkSbU2wmOHkSC+5SndzySC6Tf9Nu70w6g0CEcLbR41R+9d
 EzLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=JVK/7D63GFoiZgv/DDpmGioUcmsvRCEg+fgmQJe/Src=;
 b=joBLJSDYCH4IpLvUXPc6wtLvPVTuNQPj0KwbPAzJUVtEUPQhjpr8IDrKgc07TGvPyL
 HypKXQTrw+iIudIM6tY6aR0cTKWvsRD83WFc1pJmdKcxNlaWQ6YYJFJdKDlQYK/+F/vz
 4JMAEBjAYDsSYL2g1yEwz++z4t50uOnHmDwPSr2C8PK1ShWItXF8gzQdYLDsrDosc47P
 x7X9uKBEl5S/pXh6d3wGUVIFAebvO7qqIyeVztGBsbhpiAgQ6WV3yEF8k7GUSurqX2r/
 W3SVKB+pAHGBYJERikAaarqnESG3GYyW8BzdiVvLy7eVJ5ui0Btp05RKcJf3/6f0a0aN
 zKyQ==
X-Gm-Message-State: APjAAAUydP1kpv8zSuQ9j67HB0KHRshht5Xwo5mm9De8osUMj6RQkNcU
 kSD0X4sJAOqhkCqf2gb4kNHad9MSvfQ=
X-Google-Smtp-Source: APXvYqyL5vTxxJvJGM91AfcUGxuQ9vMNGdPsijvmNBcBtfUZi7iKI15Q2YFmzw5Kpc9tNkuxtUOffQ==
X-Received: by 2002:a05:600c:2c13:: with SMTP id
 q19mr6369076wmg.144.1581604938838; 
 Thu, 13 Feb 2020 06:42:18 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id e22sm3362454wme.45.2020.02.13.06.42.18
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2020 06:42:18 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 27/46] target/arm: Update MSR access to UAO
Date: Thu, 13 Feb 2020 14:41:26 +0000
Message-Id: <20200213144145.818-28-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200213144145.818-1-peter.maydell@linaro.org>
References: <20200213144145.818-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32e
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200208125816.14954-19-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h           |  6 ++++++
 target/arm/internals.h     |  3 +++
 target/arm/helper.c        | 21 +++++++++++++++++++++
 target/arm/translate-a64.c | 14 ++++++++++++++
 4 files changed, 44 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 71879393c22..e943ffe8a9a 100644
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
index 4a139644b54..58c4d707c5d 100644
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
index d29722d8acb..11a5f0be52f 100644
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
@@ -7664,6 +7682,9 @@ void register_cp_regs_for_features(ARMCPU *cpu)
         define_arm_cp_regs(cpu, ats1cp_reginfo);
     }
 #endif
+    if (cpu_isar_feature(aa64_uao, cpu)) {
+        define_one_arm_cp_reg(cpu, &uao_reginfo);
+    }
 
     if (arm_feature(env, ARM_FEATURE_EL2) && cpu_isar_feature(aa64_vh, cpu)) {
         define_arm_cp_regs(cpu, vhe_reginfo);
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index d8ba240a155..7c26c3bfebb 100644
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


