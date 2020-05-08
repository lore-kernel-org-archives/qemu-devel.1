Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 913AFC38A2A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 15:32:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E19521841
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 15:32:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L2JtC1OH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E19521841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49874 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jX4zE-0003Z6-J0
	for qemu-devel@archiver.kernel.org; Fri, 08 May 2020 11:32:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33974)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jX4lU-0006Cj-M7
 for qemu-devel@nongnu.org; Fri, 08 May 2020 11:18:16 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:34388)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jX4lQ-0003F2-Lj
 for qemu-devel@nongnu.org; Fri, 08 May 2020 11:18:16 -0400
Received: by mail-pl1-x642.google.com with SMTP id s10so856698plr.1
 for <qemu-devel@nongnu.org>; Fri, 08 May 2020 08:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Kyd75dQ6HSF4Bc6As5SxJ/ajmbJCQUS6r+6XFxFF4i4=;
 b=L2JtC1OHJja/JFbC8t/jwZOoHqQXOpAkJhI9MUtaF/romDh/Qb4I2eZA0KqKUY3GQ0
 WZxHSlmgJWd4TSZVAQPVACGHU35+rpcXbouvanT+AnZNiDL1BI895cGZoJSc+ytKtRaN
 1XR+7NguW2tlZ9mK0YsHVQ9ABRCL3oVPtlM0YQY8o6C9d4clPykot5lWH1fUAEMfVhPK
 b9NbHYfY7Ygo5Mf2HYtw4lA1pvEXIygfdaT6UfCOAHY2jgzuBidSdHpedTnohXLJCF8y
 gOuBaxDnjcmeFYvbt5ZTM/fk/TK0vHCGDywDVETJyzw6koecs7gdKTPJ/Ld9Sdz3mqlB
 h0Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Kyd75dQ6HSF4Bc6As5SxJ/ajmbJCQUS6r+6XFxFF4i4=;
 b=Q6lnU97+zPechQLezyAoySmtvSrUk6XkHO7cff/2tVPSV+D4RbbQC+7u+U042fr7m9
 /crzK7aIRZdG7RIY7GdLWny1awa4qntSjea3s7MMilCFUULRwNRzc/oVJOgCoV+EgbKr
 2ZqzC513EOo7oquN2v7CeyEkbCXKwEL9p9WHiCGVH0s4/wxqyCr70qSsVGHZDX5W29BB
 jnbfB4NXHIWdZfUK9X9Sk7alBwYNxkDnfk1mvfwPPmFcCAVuR3dS2KxhJEYGl3ZsW08a
 xRxMq+QFUhzAJ5mJRqXVsZf7JhE7cDVs/LM2/xEeQs6eG3fFKXOIgRBGw3lduwKfff/E
 szXQ==
X-Gm-Message-State: AGi0PuZN8/zpA7iFMdZKsVXEX6V118Ne1TvseKrKQ8nozv+8+2wJ15ZN
 M3z1FYXwlJbL8FsuDYGbgS59RlINIUc=
X-Google-Smtp-Source: APiQypLfNouruWAeFRVCv5y4tmWDtC6ZpeQHwkSOT1Hjmwb8DlnUy8xyVlN0lok3jRlSw+PwmHxKvg==
X-Received: by 2002:a17:902:40a:: with SMTP id
 10mr2901923ple.183.1588951090222; 
 Fri, 08 May 2020 08:18:10 -0700 (PDT)
Received: from localhost.localdomain (174-21-149-226.tukw.qwest.net.
 [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id b5sm2125933pfb.190.2020.05.08.08.18.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2020 08:18:09 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 17/19] tcg: Add tcg_reg_alloc_dup2
Date: Fri,  8 May 2020 08:17:45 -0700
Message-Id: <20200508151747.6166-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200508151747.6166-1-richard.henderson@linaro.org>
References: <20200508151747.6166-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::642;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x642.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

There are several ways we can expand a vector dup of a 64-bit
element on a 32-bit host.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg.c | 88 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 88 insertions(+)

diff --git a/tcg/tcg.c b/tcg/tcg.c
index 18ebcc98f6..e8fe2d580b 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -3908,6 +3908,91 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
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
+            tcg_op_defs[INDEX_op_dup_vec].args_ct[0].u.regs;
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
+    if (itsl->val_type == TEMP_VAL_CONST &&
+        itsh->val_type == TEMP_VAL_CONST) {
+        tcg_out_dupi_vec(s, vtype, ots->reg,
+                         (uint32_t)itsl->val | ((uint64_t)itsh->val << 32));
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
@@ -4299,6 +4384,9 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb)
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
2.20.1


