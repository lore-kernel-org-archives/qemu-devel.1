Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB34AC433E7
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 17:08:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 055F62173E
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 17:08:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gE/m1QUy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 055F62173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52674 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSkGP-0000z1-Uc
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 13:08:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42772)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1kSkAS-0002wk-F2; Wed, 14 Oct 2020 13:02:24 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636]:33982)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1kSkAQ-0000oS-7v; Wed, 14 Oct 2020 13:02:24 -0400
Received: by mail-ej1-x636.google.com with SMTP id u8so5905611ejg.1;
 Wed, 14 Oct 2020 10:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=zFyZNYmAPArqhKYRpQMjMOqOT5NmoiPhEcUqJQQcYQk=;
 b=gE/m1QUyEmKdywtM8EbIWZtOVoHFejvrzoBafQSlzcuGEYOaO0sh0CVaQZ6Xn+1ZQV
 v50OcseiKW+edfOHKkJ93W+dnat5LAXj0ndrBabL85UV9qP5hcO1k1gDOyPQWUYLfC0x
 JSUqn4tRQXr/S6gUX2WlLmQepu1jqTxnIvwMNQ2FzI6yDAfu60plCfYAnLJ9npUdipIK
 7CV9thMdMJYCNgOdsrDi+WhR3JpmYhzdvwHR/umqZQgz3/yCABZzVeCDW7EG2mJP0IQp
 utY5ulYnt3jreCZzf7NQB32sK94aj1KtZKHx6/RsOmig+YbaVBEi9OlCuiScTH0j8sOr
 e6Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=zFyZNYmAPArqhKYRpQMjMOqOT5NmoiPhEcUqJQQcYQk=;
 b=MC6R7bc+IeVKSMCteXuagSkQSOigiRPx77rqO4GeulsN3+5EFKvk5TJrpMtAGBL9x7
 DP4jzAz3CQrP4Or9jDrGCjfNyzXmdBGx7rkQNNmmZ2M3H4vfMaIqY8osPEO2tNpcg2of
 u4dzq71j3BvrilDyZpmRXGKCVtUkTiYJVenbz10/R0EaoAY2IsYfRu3nVtEpOhGgwlpV
 E9QdktLvr7KlC+n+6xegAjtDGxpcdrJGmJg3+UmSKl35RmsUyBjakN2zT0tTcVy80az9
 WRVYHatQ5N1f7aI3+9pBCzJ1OW1GarJk6T6JZQFptPj5mSmhlAbPmZl4pRrO7MC5MpgB
 YtCg==
X-Gm-Message-State: AOAM5313wBkJYyiu9iv3dPMp3tlk7AXJmOU0bcDaYsulc/2f6EKFwLUj
 WeT00QukARehSSkafza7VxA=
X-Google-Smtp-Source: ABdhPJzu0Qv5lT2zB6NWJoBg4UF7BfJ6oU/ALvfVIe5lFIDTAw/ZWksfo39aKdrlcS1LCO8zsai3/Q==
X-Received: by 2002:a17:906:4b1a:: with SMTP id
 y26mr6243534eju.350.1602694940384; 
 Wed, 14 Oct 2020 10:02:20 -0700 (PDT)
Received: from neptune.lab ([46.39.229.194])
 by smtp.googlemail.com with ESMTPSA id g3sm76012edy.12.2020.10.14.10.02.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2020 10:02:19 -0700 (PDT)
From: Alexey Baturo <baturo.alexey@gmail.com>
X-Google-Original-From: Alexey Baturo <space.monkey.delivers@gmail.com>
To: 
Subject: [PATCH 4/5] [RISCV_PM] Add address masking functions required for
 RISC-V Pointer Masking extension
Date: Wed, 14 Oct 2020 20:01:58 +0300
Message-Id: <20201014170159.26932-5-space.monkey.delivers@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201014170159.26932-1-space.monkey.delivers@gmail.com>
References: <20201014170159.26932-1-space.monkey.delivers@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=baturo.alexey@gmail.com; helo=mail-ej1-x636.google.com
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
Cc: baturo.alexey@gmail.com,
 "open list:RISC-V TCG CPUs" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 space.monkey.delivers@gmail.com, Alistair Francis <Alistair.Francis@wdc.com>,
 Anatoly Parshintsev <kupokupokupopo@gmail.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Anatoly Parshintsev <kupokupokupopo@gmail.com>

Signed-off-by: Anatoly Parshintsev <kupokupokupopo@gmail.com>
---
 target/riscv/translate.c | 65 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 79dca2291b..338a967e0c 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -63,6 +63,10 @@ typedef struct DisasContext {
     uint16_t vlen;
     uint16_t mlen;
     bool vl_eq_vlmax;
+    /* PointerMasking extension */
+    uint8_t pm_enabled;
+    target_ulong pm_mask;
+    target_ulong pm_base;
 } DisasContext;
 
 #ifdef TARGET_RISCV64
@@ -90,6 +94,38 @@ static inline bool has_ext(DisasContext *ctx, uint32_t ext)
     return ctx->misa & ext;
 }
 
+/* Generates address adjustment for PointerMasking */
+static void gen_pm_adjust_address(DisasContext *s,
+                                  TCGv_i64      dst,
+                                  TCGv_i64      src)
+{
+    if (s->pm_enabled == 0) {
+        /* Load unmodified address */
+        tcg_gen_mov_i64(dst, src);
+    } else {
+        TCGv_i64 mask_neg = tcg_const_i64(~s->pm_mask);
+        TCGv_i64 base     = tcg_const_i64(s->pm_base);
+        /* calculate (addr & ~mask) */
+        TCGv res1 = tcg_temp_new();
+        tcg_gen_and_tl(res1, mask_neg, src);
+        /* calculate (1) | (base) */
+        TCGv res2 = tcg_temp_new();
+        tcg_gen_or_tl(res2, res1, base);
+        /* move result to dst */
+        tcg_gen_mov_i64(dst, res2);
+        /* free allocated temps */
+        tcg_temp_free(res1);
+        tcg_temp_free(res2);
+        tcg_temp_free_i64(mask_neg);
+        tcg_temp_free_i64(base);
+    }
+}
+
+static TCGv_i64 apply_pointer_masking(DisasContext *s, TCGv_i64 addr)
+{
+    gen_pm_adjust_address(s, addr, addr);
+    return addr;
+}
 /*
  * RISC-V requires NaN-boxing of narrower width floating point values.
  * This applies when a 32-bit value is assigned to a 64-bit FP register.
@@ -800,8 +836,36 @@ static void riscv_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
     } else {
         ctx->virt_enabled = false;
     }
+    if (riscv_has_ext(env, RVJ)) {
+        switch (env->priv) {
+        case PRV_U:
+            ctx->pm_enabled = get_field(env->mmte, UMTE_U_PM_ENABLE);
+            ctx->pm_mask = env->upmmask;
+            ctx->pm_base = env->upmbase;
+            break;
+        case PRV_S:
+            ctx->pm_enabled = get_field(env->mmte, SMTE_S_PM_ENABLE);
+            ctx->pm_mask = env->spmmask;
+            ctx->pm_base = env->spmbase;
+            break;
+        case PRV_M:
+            ctx->pm_enabled = get_field(env->mmte, MMTE_M_PM_ENABLE);
+            ctx->pm_mask = env->mpmmask;
+            ctx->pm_base = env->mpmbase;
+            break;
+        default:
+            assert(0 && "Unreachable");
+        }
+    } else {
+        ctx->pm_enabled = 0;
+        ctx->pm_mask = 0;
+        ctx->pm_base = 0;
+    }
 #else
     ctx->virt_enabled = false;
+    ctx->pm_enabled = 0;
+    ctx->pm_mask = 0;
+    ctx->pm_base = 0;
 #endif
     ctx->misa = env->misa;
     ctx->frm = -1;  /* unknown rounding mode */
@@ -932,3 +996,4 @@ void riscv_translate_init(void)
     load_val = tcg_global_mem_new(cpu_env, offsetof(CPURISCVState, load_val),
                              "load_val");
 }
+
-- 
2.20.1


