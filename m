Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9E8BC433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 00:28:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67E682145D
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 00:28:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y694efuf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67E682145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35094 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFnyo-0001w1-FP
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 20:28:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37798)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kFnnl-0000OD-RV
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 20:17:29 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:46095)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kFnnk-0002Ir-0G
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 20:17:29 -0400
Received: by mail-pf1-x444.google.com with SMTP id b124so530199pfg.13
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2020 17:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=w6xHshvWLLck3lt1rEDIti2QJ7z0XrDN3U8gYB8E2NY=;
 b=Y694efufjNhb2dvtkeVzSQ/8mpsOQtfCpS4XEDU79oDboEw3YSXINWYrpvQPqtKvLr
 lCohCdqL1usgkV+MdH+sEOn6fZmC6q1X57ogWyA4a39/dH+OMKK2TF7bX8KSYp0PJdXE
 t5yGF2rVYeBcPrayl9KjgXUYeOWhHBeh63VvqtD2iSfPqOCRqe0zBvBJjFIl8sg0qxTe
 IC+aKHrGnVa37GWsyT0E+PHA8MRMH/7auFEJaGeUKX3DGWcGk4L3Y5zHl/F/TzsI6vJ5
 4gnL0KDEyiIfPf/letLbP5KGly0sJjWfsGq+n0w24rj31N6zx4ZS4VuufjINjYw8713R
 dPYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=w6xHshvWLLck3lt1rEDIti2QJ7z0XrDN3U8gYB8E2NY=;
 b=BOsuSQetMh9S31gcLhx/lJf+hGp98OXh/4ZSOQhXtbeMu3NRNbyNUg+VGQ5ZUeVNA4
 Fk6N7ZVw6bWZa4GosdmDPVufWyS9bVeFLfk49kl/n2Jh5dRWcD2i2gguREQGHCPj0dhB
 kDhKgYuYwdmREP6c/H/qe/Q3QF9GyC0zZa31+t0GSJrR6N8oFU6eIllw9QdCWgiTa7Ye
 hq1rZGkAb9wtUkhLGYp9MKCajWhGkl0a9Ci2ogtFkCznnBo8dOqKw3Yj9qcCVgTWjFmv
 sJs9bbTMZWa552ISXoYFVCmRLVYDsA2BP0t6zU8xvpp06LhWT6+FqRnbJEsQdw/Txyx9
 CR5A==
X-Gm-Message-State: AOAM5336ThPJb5niYL0Ivk1AG8qZDweWLTTLZe1JpMYFpdkSAmZkGGRY
 6lpNkWmohTXJUFX441+XPb6X1KUMd2dx/w==
X-Google-Smtp-Source: ABdhPJyTc0w4WG6UuZl1WiSMloc1KhG2S4NOwa053qITCbJZWynNViKI06uHe5RkxqzDOsZgzwNNSg==
X-Received: by 2002:a65:66c6:: with SMTP id c6mr996275pgw.206.1599610646306;
 Tue, 08 Sep 2020 17:17:26 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id 137sm505437pfu.149.2020.09.08.17.17.25
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2020 17:17:25 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 29/43] tcg: Add tcg_reg_alloc_dup2
Date: Tue,  8 Sep 2020 17:16:33 -0700
Message-Id: <20200909001647.532249-30-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200909001647.532249-1-richard.henderson@linaro.org>
References: <20200909001647.532249-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::444;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

There are several ways we can expand a vector dup of a 64-bit
element on a 32-bit host.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg.c | 97 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 97 insertions(+)

diff --git a/tcg/tcg.c b/tcg/tcg.c
index f9c6450837..507c95cd39 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -3954,6 +3954,100 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
     }
 }
 
+static void tcg_reg_alloc_dup2(TCGContext *s, const TCGOp *op)
+{
+    const TCGLifeData arg_life = op->life;
+    TCGTemp *ots, *itsl, *itsh;
+    TCGType vtype = TCGOP_VECL(op) + TCG_TYPE_V64;
+
+    /* This opcode is only valid for 32-bit hosts, for 64-bit elements. */
+    tcg_debug_assert(TCG_TARGET_REG_BITS == 32);
+    tcg_debug_assert(TCGOP_VECE(op) == MO_64);
+
+    ots = arg_temp(op->args[0]);
+    itsl = arg_temp(op->args[1]);
+    itsh = arg_temp(op->args[2]);
+
+    /* ENV should not be modified.  */
+    tcg_debug_assert(!temp_readonly(ots));
+
+    /* Allocate the output register now.  */
+    if (ots->val_type != TEMP_VAL_REG) {
+        TCGRegSet allocated_regs = s->reserved_regs;
+        TCGRegSet dup_out_regs =
+            tcg_op_defs[INDEX_op_dup_vec].args_ct[0].regs;
+
+        /* Make sure to not spill the input registers. */
+        if (!IS_DEAD_ARG(1) && itsl->val_type == TEMP_VAL_REG) {
+            tcg_regset_set_reg(allocated_regs, itsl->reg);
+        }
+        if (!IS_DEAD_ARG(2) && itsh->val_type == TEMP_VAL_REG) {
+            tcg_regset_set_reg(allocated_regs, itsh->reg);
+        }
+
+        ots->reg = tcg_reg_alloc(s, dup_out_regs, allocated_regs,
+                                 op->output_pref[0], ots->indirect_base);
+        ots->val_type = TEMP_VAL_REG;
+        ots->mem_coherent = 0;
+        s->reg_to_temp[ots->reg] = ots;
+    }
+
+    /* Promote dup2 of immediates to dupi_vec. */
+    if (itsl->val_type == TEMP_VAL_CONST && itsh->val_type == TEMP_VAL_CONST) {
+        uint64_t val = deposit64(itsl->val, 32, 32, itsh->val);
+        MemOp vece = MO_64;
+
+        if (val == dup_const(MO_8, val)) {
+            vece = MO_8;
+        } else if (val == dup_const(MO_16, val)) {
+            vece = MO_16;
+        } else if (val == dup_const(MO_32, val)) {
+            vece = MO_32;
+        }
+
+        tcg_out_dupi_vec(s, vtype, vece, ots->reg, val);
+        goto done;
+    }
+
+    /* If the two inputs form one 64-bit value, try dupm_vec. */
+    if (itsl + 1 == itsh &&
+        itsl->base_type == TCG_TYPE_I64 &&
+        itsh->base_type == TCG_TYPE_I64) {
+        if (!itsl->mem_coherent) {
+            temp_sync(s, itsl, s->reserved_regs, 0, 0);
+        }
+        if (!itsl->mem_coherent) {
+            temp_sync(s, itsl, s->reserved_regs, 0, 0);
+        }
+#ifdef HOST_WORDS_BIGENDIAN
+        TCGTemp *its = itsh;
+#else
+        TCGTemp *its = itsl;
+#endif
+        if (tcg_out_dupm_vec(s, vtype, MO_64, ots->reg,
+                             its->mem_base->reg, its->mem_offset)) {
+            goto done;
+        }
+    }
+
+    /* Fall back to generic expansion. */
+    tcg_reg_alloc_op(s, op);
+    return;
+
+ done:
+    if (IS_DEAD_ARG(1)) {
+        temp_dead(s, itsl);
+    }
+    if (IS_DEAD_ARG(2)) {
+        temp_dead(s, itsh);
+    }
+    if (NEED_SYNC_ARG(0)) {
+        temp_sync(s, ots, s->reserved_regs, 0, IS_DEAD_ARG(0));
+    } else if (IS_DEAD_ARG(0)) {
+        temp_dead(s, ots);
+    }
+}
+
 #ifdef TCG_TARGET_STACK_GROWSUP
 #define STACK_DIR(x) (-(x))
 #else
@@ -4345,6 +4439,9 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb)
         case INDEX_op_dup_vec:
             tcg_reg_alloc_dup(s, op);
             break;
+        case INDEX_op_dup2_vec:
+            tcg_reg_alloc_dup2(s, op);
+            break;
         case INDEX_op_insn_start:
             if (num_insns >= 0) {
                 size_t off = tcg_current_code_size(s);
-- 
2.25.1


