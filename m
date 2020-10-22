Return-Path: <SRS0=9x1+=D5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A0C2C388F7
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 07:46:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 922E02245F
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 07:46:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O150Mi3Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 922E02245F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57804 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVVIh-0005Ap-JG
	for qemu-devel@archiver.kernel.org; Thu, 22 Oct 2020 03:46:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37792)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1kVVFy-00013K-Ud; Thu, 22 Oct 2020 03:43:32 -0400
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144]:45206)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1kVVFr-0007eO-7K; Thu, 22 Oct 2020 03:43:30 -0400
Received: by mail-lf1-x144.google.com with SMTP id r127so1003423lff.12;
 Thu, 22 Oct 2020 00:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=wX2ZkHWZTsLegDRadNX3/LscZ8sVu41yZQYaAwn+M+o=;
 b=O150Mi3Z+iFES1xFesMALZdlhDkbZuLlwEEkZRIbkCGDTMJUR8/WWE2fkkG7YellBO
 kr05sAGUnw2wZpd0OY/M3m+zzCiV6SxlV29IooT7YqCKB2VEI3QP7PZbznl7aqv0TX7m
 mMTKsWdH+gf0WM73vUrr2Z27aOr1R+WzRi59nuJBubvHhfcGYKJyR0YmiFjr/ovYUcHi
 snaDivmcDIgebjkF80ZDSMKUPOe3HdguxKbzb+CpyCp2aJGbl194+mlvr3XCOMwawXbL
 O6Hy2M0oPeAb4i9epUhLZcFIl06TTT4SwYqd1DVr5U+ASCIvsI3zpuYLDvdDqORKbkuC
 RTEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=wX2ZkHWZTsLegDRadNX3/LscZ8sVu41yZQYaAwn+M+o=;
 b=LCU1awahURMmfZG6T+JMH0lXD/gzL7C1hHTrHGCzUr38ytGy94WkL/lCMseqiysKDy
 A6+raK8Ha/vrNcYHc+63IXFlYIdNSaXtPLO0ljd+1rIlPLfiMSQD6tFGW7DXkZHzrFSe
 sBO2FaE0d33rNE2B2qPGd5e/yJrTkPSz1kYtCV833XNB0FXYrcS0KkoFiLbtRTWFMDim
 H65MY4VGYRxtt6fyiaUv6BDzGU+4Myhk5jzGL3+tYKhcQomU3yZQRgH0lSZfhEJwPB46
 Xuf8BLX/eyfYAFL9MK2i2Ioh7d+CP4CSMqt4cmmOldx8VzV8p/0oioCAnPoFUeZP5gjG
 ugvw==
X-Gm-Message-State: AOAM532lAuDXbbJuMeDYp8uIYykBD20o5mgMrhNQ2TQuNnizO4yWAS1J
 2J4WLxDYfi1wkJZhWX0B3is=
X-Google-Smtp-Source: ABdhPJxP/5gvT5cC/9VLF8Raud+8sU8Xa+Bngo+1k+Z4ydhTm4V5AOcip3Uap2hwe43wtSv1pwF29Q==
X-Received: by 2002:a19:c690:: with SMTP id w138mr374616lff.409.1603352600430; 
 Thu, 22 Oct 2020 00:43:20 -0700 (PDT)
Received: from neptune.lab ([46.39.229.104])
 by smtp.googlemail.com with ESMTPSA id n19sm138887lfe.142.2020.10.22.00.43.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2020 00:43:19 -0700 (PDT)
From: Alexey Baturo <baturo.alexey@gmail.com>
X-Google-Original-From: Alexey Baturo <space.monkey.delivers@gmail.com>
To: 
Subject: [PATCH v5 5/6] [RISCV_PM] Implement address masking functions
 required for RISC-V Pointer Masking extension
Date: Thu, 22 Oct 2020 10:43:08 +0300
Message-Id: <20201022074309.3210-6-space.monkey.delivers@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201022074309.3210-1-space.monkey.delivers@gmail.com>
References: <20201022074309.3210-1-space.monkey.delivers@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::144;
 envelope-from=baturo.alexey@gmail.com; helo=mail-lf1-x144.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: baturo.alexey@gmail.com, qemu-riscv@nongnu.org, sagark@eecs.berkeley.edu,
 kbastian@mail.uni-paderborn.de, richard.henderson@linaro.org,
 qemu-devel@nongnu.org, space.monkey.delivers@gmail.com,
 Alistair.Francis@wdc.com, kupokupokupopo@gmail.com, palmer@dabbelt.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Anatoly Parshintsev <kupokupokupopo@gmail.com>

Signed-off-by: Anatoly Parshintsev <kupokupokupopo@gmail.com>
---
 target/riscv/cpu.h       | 19 +++++++++++++++++++
 target/riscv/translate.c | 34 ++++++++++++++++++++++++++++++++--
 2 files changed, 51 insertions(+), 2 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index c236f01fff..13accaa232 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -386,6 +386,7 @@ FIELD(TB_FLAGS, VL_EQ_VLMAX, 2, 1)
 FIELD(TB_FLAGS, LMUL, 3, 2)
 FIELD(TB_FLAGS, SEW, 5, 3)
 FIELD(TB_FLAGS, VILL, 8, 1)
+FIELD(TB_FLAGS, PM_ENABLED, 9, 1)
 
 /*
  * A simplification for VLMAX
@@ -432,6 +433,24 @@ static inline void cpu_get_tb_cpu_state(CPURISCVState *env, target_ulong *pc,
     if (riscv_cpu_fp_enabled(env)) {
         flags |= env->mstatus & MSTATUS_FS;
     }
+    if (riscv_has_ext(env, RVJ)) {
+        int priv = cpu_mmu_index(env, false);
+        bool pm_enabled = false;
+        switch (priv) {
+        case PRV_U:
+            pm_enabled = env->mmte & U_PM_ENABLE;
+            break;
+        case PRV_S:
+            pm_enabled = env->mmte & S_PM_ENABLE;
+            break;
+        case PRV_M:
+            pm_enabled = env->mmte & M_PM_ENABLE;
+            break;
+        default:
+            g_assert_not_reached();
+        }
+        flags = FIELD_DP32(flags, TB_FLAGS, PM_ENABLED, pm_enabled);
+    }
 #endif
     *pflags = flags;
 }
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index a7cbf909f3..b3e7b93bc9 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -36,6 +36,9 @@ static TCGv cpu_gpr[32], cpu_pc, cpu_vl;
 static TCGv_i64 cpu_fpr[32]; /* assume F and D extensions */
 static TCGv load_res;
 static TCGv load_val;
+/* globals for PM CSRs */
+static TCGv pm_mask[4];
+static TCGv pm_base[4];
 
 #include "exec/gen-icount.h"
 
@@ -63,6 +66,10 @@ typedef struct DisasContext {
     uint16_t vlen;
     uint16_t mlen;
     bool vl_eq_vlmax;
+    /* PointerMasking extension */
+    bool pm_enabled;
+    TCGv pm_mask;
+    TCGv pm_base;
 } DisasContext;
 
 #ifdef TARGET_RISCV64
@@ -102,13 +109,19 @@ static void gen_nanbox_s(TCGv_i64 out, TCGv_i64 in)
 }
 
 /*
- * Temp stub: generates address adjustment for PointerMasking
+ * Generates address adjustment for PointerMasking
  */
 static void gen_pm_adjust_address(DisasContext *s,
                                   TCGv_i64      dst,
                                   TCGv_i64      src)
 {
-    tcg_gen_mov_i64(dst, src);
+    if (!s->pm_enabled) {
+        /* Load unmodified address */
+        tcg_gen_mov_i64(dst, src);
+    } else {
+        tcg_gen_andc_i64(dst, src, s->pm_mask);
+        tcg_gen_or_i64(dst, dst, s->pm_base);
+    }
 }
 
 /*
@@ -826,6 +839,10 @@ static void riscv_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
     ctx->lmul = FIELD_EX32(tb_flags, TB_FLAGS, LMUL);
     ctx->mlen = 1 << (ctx->sew  + 3 - ctx->lmul);
     ctx->vl_eq_vlmax = FIELD_EX32(tb_flags, TB_FLAGS, VL_EQ_VLMAX);
+    ctx->pm_enabled = FIELD_EX32(tb_flags, TB_FLAGS, PM_ENABLED);
+    int priv = cpu_mmu_index(env, false);
+    ctx->pm_mask = pm_mask[priv];
+    ctx->pm_base = pm_base[priv];
 }
 
 static void riscv_tr_tb_start(DisasContextBase *db, CPUState *cpu)
@@ -945,4 +962,17 @@ void riscv_translate_init(void)
                              "load_res");
     load_val = tcg_global_mem_new(cpu_env, offsetof(CPURISCVState, load_val),
                              "load_val");
+    /* Assign PM CSRs to tcg globals */
+    pm_mask[PRV_U] =
+      tcg_global_mem_new(cpu_env, offsetof(CPURISCVState, upmmask), "upmmask");
+    pm_base[PRV_U] =
+      tcg_global_mem_new(cpu_env, offsetof(CPURISCVState, upmbase), "upmbase");
+    pm_mask[PRV_S] =
+      tcg_global_mem_new(cpu_env, offsetof(CPURISCVState, spmmask), "spmmask");
+    pm_base[PRV_S] =
+      tcg_global_mem_new(cpu_env, offsetof(CPURISCVState, spmbase), "spmbase");
+    pm_mask[PRV_M] =
+      tcg_global_mem_new(cpu_env, offsetof(CPURISCVState, mpmmask), "mpmmask");
+    pm_base[PRV_M] =
+      tcg_global_mem_new(cpu_env, offsetof(CPURISCVState, mpmbase), "mpmbase");
 }
-- 
2.20.1


