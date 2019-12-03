Return-Path: <SRS0=HheB=ZZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E97ABC432C0
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 23:55:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A90620684
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 23:55:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P4ZZiAfx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A90620684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60678 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icI10-0002ay-Bh
	for qemu-devel@archiver.kernel.org; Tue, 03 Dec 2019 18:55:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38763)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1icHor-000498-RR
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 18:43:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1icHoh-0006Uh-N6
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 18:42:53 -0500
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b]:36311)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1icHoh-0006TE-Fg
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 18:42:51 -0500
Received: by mail-pg1-x52b.google.com with SMTP id k13so2384127pgh.3
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2019 15:42:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=7MVIDNVevAOck6qQcN8WApev5jEl5Rubg+oXUTbOUTk=;
 b=P4ZZiAfxWWEoKunNKcpxLUHv0QjWTix7hf2Dg/+dcPeXA6SF/5rf+m0QydnvoMsnFX
 4ReacV1B0OEsRbeL6+BuF/3qnf0sBZc64mnS5heOC1+PS1DZNZNEClxQoy4FLARKsFc8
 Lrfvt7zdJoVfYUIdU908FDHCYtnusIfPccedqZjwcpUCykPvlcaDSB9l2hmL+t0QX8cP
 gwC0Qejgfk4T8MHQnTYOOrybFGdQPdM15s8KN5T14DCjG7FAZCCKreavbdmq1qV9imZ8
 Usled3xEcqJDkKipJwq+6Iv9LeY1WqgxoMiaqXgFi/4iNCRpMdzPAl03LXssBwm8hpeJ
 KIWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=7MVIDNVevAOck6qQcN8WApev5jEl5Rubg+oXUTbOUTk=;
 b=jFk3XYgAO0/93R+hUIIIl/jw2Ej8pmye77dGGmZnwWNUkkxRD6pM4PGtOtl6ZB0BBQ
 dym+WlXmGIBmXi+b8sOYhbruiBDbwtz7+3wydAhY0tHbHgtmlD23Nveg3LEopNs6630T
 Houf8cHBPYBtC57dOZA6R2mVy5lXIS7Rv8xDQ/FhxDvIFZvivRTaIs5tWOBwYiYv+V4z
 +J6WhV7hYi4Lgz7NTqCu5z290EL3VDPnrZ2NsWlbHmNTB+32KKfXK8oDxchiER33SZ8o
 nqve1TlJoiYAT+Gfd1yw1u4eFvhk+Pcsj4ZZA+mbaSlupqnP8gTx9H5OAuhjioBH8gvA
 y6eQ==
X-Gm-Message-State: APjAAAVF1tUfQ7VXsNKmYxLs9Bgl+nv11DP4ZuA+Lmt6xbAaFVpYOxqN
 Itvugbd3pLvMop0KozDsM5qtlz8rTUg=
X-Google-Smtp-Source: APXvYqyOGOFecK+Ka1VpfQ6KH0eJmPGIycLSY2aLs5WUEv/PBczINSC2uG3FBqMoRHTgxpaVlmASdg==
X-Received: by 2002:a63:d153:: with SMTP id c19mr319473pgj.78.1575416569080;
 Tue, 03 Dec 2019 15:42:49 -0800 (PST)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id k5sm4128256pju.14.2019.12.03.15.42.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Dec 2019 15:42:48 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/4] target/arm: Update MSR access to UAO
Date: Tue,  3 Dec 2019 15:42:42 -0800
Message-Id: <20191203234244.9124-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191203234244.9124-1-richard.henderson@linaro.org>
References: <20191203234244.9124-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::52b
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h           |  6 ++++++
 target/arm/helper.c        | 21 +++++++++++++++++++++
 target/arm/translate-a64.c | 14 ++++++++++++++
 3 files changed, 41 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index cdf6caf869..dd284ba5c7 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1228,6 +1228,7 @@ void pmu_init(ARMCPU *cpu);
 #define PSTATE_IL (1U << 20)
 #define PSTATE_SS (1U << 21)
 #define PSTATE_PAN (1U << 22)
+#define PSTATE_UAO (1U << 23)
 #define PSTATE_V (1U << 28)
 #define PSTATE_C (1U << 29)
 #define PSTATE_Z (1U << 30)
@@ -3598,6 +3599,11 @@ static inline bool isar_feature_aa64_ats1e1(const ARMISARegisters *id)
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
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 70f2db5447..8941a6c10f 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -4131,6 +4131,17 @@ static void aa64_pan_write(CPUARMState *env, const ARMCPRegInfo *ri,
     env->pstate = (env->pstate & ~PSTATE_PAN) | (value & PSTATE_PAN);
 }
 
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
 static CPAccessResult aa64_cacheop_access(CPUARMState *env,
                                           const ARMCPRegInfo *ri,
                                           bool isread)
@@ -7464,6 +7475,16 @@ void register_cp_regs_for_features(ARMCPU *cpu)
         define_arm_cp_regs(cpu, ats1cp_reginfo);
     }
 #endif
+    if (cpu_isar_feature(aa64_uao, cpu)) {
+        static const ARMCPRegInfo uao_reginfo[] = {
+            { .name = "UAO", .state = ARM_CP_STATE_AA64,
+              .opc0 = 3, .opc1 = 0, .crn = 4, .crm = 2, .opc2 = 4,
+              .type = ARM_CP_NO_RAW, .access = PL1_RW,
+              .readfn = aa64_uao_read, .writefn = aa64_uao_write, },
+            REGINFO_SENTINEL
+        };
+        define_arm_cp_regs(cpu, uao_reginfo);
+    }
 
     if (arm_feature(env, ARM_FEATURE_EL2) && cpu_isar_feature(aa64_vh, cpu)) {
         static const ARMCPRegInfo vhe_reginfo[] = {
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 7f5a68106b..2b6846ef01 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -1601,6 +1601,20 @@ static void handle_msr_i(DisasContext *s, uint32_t insn,
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
2.17.1


