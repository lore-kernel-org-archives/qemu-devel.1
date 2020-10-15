Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AB2EC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 15:31:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 830E12222E
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 15:31:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FsuzLpv2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 830E12222E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60636 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kT5Dp-0000Yo-8U
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 11:31:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49940)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1kT54n-0007Tp-E2; Thu, 15 Oct 2020 11:21:57 -0400
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543]:43569)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1kT54l-000618-HQ; Thu, 15 Oct 2020 11:21:57 -0400
Received: by mail-ed1-x543.google.com with SMTP id dn5so3462358edb.10;
 Thu, 15 Oct 2020 08:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=y0+sNljWPSlIYDtdJIgqfgiMKRM+6+hoWhkQxE4OUFs=;
 b=FsuzLpv29wzfg1UA22K+i/Ue/lQRqMM+yrYO+0RzGljmHM0rIQiy4VDgetS19SwP1n
 xp2eKr5BmjF814A1FghHRRtb+1NrP6ltAMV7kND2aNWzfCHL4vJOn0CMWpfiY8JYGeOs
 6QNX+WrWMKCzy+kPHjv2X7dgodmY2crkMCTIowKpBhyKqnBDziBzEk5GoYG+mD/Tnxg0
 lFa/3CXVjmlK70sumYYyLgIZ2jkM93wf0DwqpCrTZJIJJNcDFxVvBYkHFRQrteMTlSkN
 etSHa6KG698hMpXP3+60Kj36D+OeyfHPajoaO32SJLVstAE2IIUGZ9kJGapMg9t28DcV
 dW5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=y0+sNljWPSlIYDtdJIgqfgiMKRM+6+hoWhkQxE4OUFs=;
 b=dEqGsV4TCSeQPo7i9j93DBICCTpihK72aqX4l7JxLfIZbY73cAJd2VRqapOBHqW4L1
 NyBHRiqEy9ccd6nYbA9jk98/j3x+1ZSh9elDfbvdmEXcOnqIJmzQmZUNOccU7DtrAYgh
 PBlB5BmLpxjWQiZUdLVLQUGOm37VCTNoSKhQXd0oCwtczPsGzaVX4cVFpz1C/7vu7ttV
 sXtgLARkDDn0CzGXaT14MIqPHYRdDBMn0Q7seHsjvftCnSKKVD/lOAlrfPrsHkMPhU31
 /uRrdsIg5GZdTlZ2brgBoNEcRFVZEVvO8MNRie4iLl5MnVUUxzZ2FMPLIz60Zc1673sj
 Zy+g==
X-Gm-Message-State: AOAM5326qaWp1wSpgHLEYbgz6hwZmzqDZ9sws0jMj77tTGoHa/CPwIYO
 Kg4GVZIPPwRDg9Ce9O+acpI=
X-Google-Smtp-Source: ABdhPJw3MtKcS+zKaoKYpZu547FchlLHA3txStmwYo9CenblYPZcGb9MpwJrVZq0Qw8SaQZ3GQPftg==
X-Received: by 2002:a05:6402:b31:: with SMTP id
 bo17mr5082654edb.342.1602775313849; 
 Thu, 15 Oct 2020 08:21:53 -0700 (PDT)
Received: from neptune.lab ([46.39.229.194])
 by smtp.googlemail.com with ESMTPSA id i5sm1819539ejv.54.2020.10.15.08.21.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2020 08:21:53 -0700 (PDT)
From: Alexey Baturo <baturo.alexey@gmail.com>
X-Google-Original-From: Alexey Baturo <space.monkey.delivers@gmail.com>
To: 
Subject: [PATCH v2 5/5] [RISCV_PM] Implement address masking functions
 required for RISC-V Pointer Masking extension
Date: Thu, 15 Oct 2020 18:21:39 +0300
Message-Id: <20201015152139.28903-5-space.monkey.delivers@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201015152139.28903-1-space.monkey.delivers@gmail.com>
References: <20201015152139.28903-1-space.monkey.delivers@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::543;
 envelope-from=baturo.alexey@gmail.com; helo=mail-ed1-x543.google.com
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
 target/riscv/translate.c | 39 +++++++++++++++++++++++++++++++++++++--
 2 files changed, 56 insertions(+), 2 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 21e47b8283..6c301b7ab1 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -385,6 +385,7 @@ FIELD(TB_FLAGS, VL_EQ_VLMAX, 2, 1)
 FIELD(TB_FLAGS, LMUL, 3, 2)
 FIELD(TB_FLAGS, SEW, 5, 3)
 FIELD(TB_FLAGS, VILL, 8, 1)
+FIELD(TB_FLAGS, PM_ENABLED, 9, 1)
 
 /*
  * A simplification for VLMAX
@@ -431,6 +432,24 @@ static inline void cpu_get_tb_cpu_state(CPURISCVState *env, target_ulong *pc,
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
+            assert(0 && "Unreachable");
+        }
+        flags = FIELD_DP32(flags, TB_FLAGS, PM_ENABLED, pm_enabled);
+    }
 #endif
     *pflags = flags;
 }
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index a7cbf909f3..58b05ee2c7 100644
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
+    uint8_t pm_enabled;
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
+    if (s->pm_enabled == 0) {
+        /* Load unmodified address */
+        tcg_gen_mov_i64(dst, src);
+    } else {
+        tcg_gen_andc_i64(dst, src, s->pm_mask);
+        tcg_gen_or_i64(dst, dst, s->pm_base);
+    }
 }
 
 /*
@@ -814,8 +827,17 @@ static void riscv_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
     } else {
         ctx->virt_enabled = false;
     }
+    if (riscv_has_ext(env, RVJ)) {
+        ctx->pm_enabled = FIELD_EX32(tb_flags, TB_FLAGS, PM_ENABLED);
+        int priv = cpu_mmu_index(env, false);
+        ctx->pm_mask = pm_mask[priv];
+        ctx->pm_base = pm_base[priv];
+    } else {
+        ctx->pm_enabled = 0;
+    }
 #else
     ctx->virt_enabled = false;
+    ctx->pm_enabled = 0;
 #endif
     ctx->misa = env->misa;
     ctx->frm = -1;  /* unknown rounding mode */
@@ -945,4 +967,17 @@ void riscv_translate_init(void)
                              "load_res");
     load_val = tcg_global_mem_new(cpu_env, offsetof(CPURISCVState, load_val),
                              "load_val");
+    /* Assign PM CSRs to tcg globals */
+    pm_mask[PRV_U] = tcg_global_mem_new(cpu_env, offsetof(CPURISCVState, upmmask),
+                                        "upmmask");
+    pm_base[PRV_U] = tcg_global_mem_new(cpu_env, offsetof(CPURISCVState, upmbase),
+                                        "upmbase");
+    pm_mask[PRV_S] = tcg_global_mem_new(cpu_env, offsetof(CPURISCVState, spmmask),
+                                        "spmmask");
+    pm_base[PRV_S] = tcg_global_mem_new(cpu_env, offsetof(CPURISCVState, spmbase),
+                                        "spmbase");
+    pm_mask[PRV_M] = tcg_global_mem_new(cpu_env, offsetof(CPURISCVState, mpmmask),
+                                        "mpmmask");
+    pm_base[PRV_M] = tcg_global_mem_new(cpu_env, offsetof(CPURISCVState, mpmbase),
+                                        "mpmbase");
 }
-- 
2.20.1


