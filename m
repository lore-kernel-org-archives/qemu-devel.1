Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 471D1C38A2A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 18:39:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 117762173E
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 18:39:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Loojpcaw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 117762173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52270 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jX7tp-0008Nu-8J
	for qemu-devel@archiver.kernel.org; Fri, 08 May 2020 14:39:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33812)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jX7hs-00077y-7d
 for qemu-devel@nongnu.org; Fri, 08 May 2020 14:26:44 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:35972)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jX7hr-0007UX-At
 for qemu-devel@nongnu.org; Fri, 08 May 2020 14:26:43 -0400
Received: by mail-pf1-x441.google.com with SMTP id z1so1377723pfn.3
 for <qemu-devel@nongnu.org>; Fri, 08 May 2020 11:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Kyd75dQ6HSF4Bc6As5SxJ/ajmbJCQUS6r+6XFxFF4i4=;
 b=LoojpcawHiizoQXXDcp5uFA2/3TLmpEYVh/oz1cwEvg5d2LS9lCMt/MddB4bxu91p4
 bMfxf0TTcbvOwwzpo/I7nybIc7kFtF9uXUAKfbXyAH/R9iHp6IZJU+bGmSvgZ0P+TMl/
 L4wfbi6KRDxmz6mOQMvrpYeRmTHbSD3JuKKYnHczkIB0WHPKst4JbJcaXJyb5tkdjUm2
 DEeJllBeiNGqHxBHimEsXjtrRnl+AP3xatPYRB/JC5v/vQ9hnbc0zZKZRqwQZU+ZlIYz
 25iKOFeCaz3lyhJfB0vVA10tqHmqOn3MHpFzbhQh6ASmz13RJkJ6nEUtxEqVJtr/Cxc2
 xKRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Kyd75dQ6HSF4Bc6As5SxJ/ajmbJCQUS6r+6XFxFF4i4=;
 b=BXblqZu+CkdeTPBEJ6K2dKag3r/xoAFqJvB1qpODRgIfiDLzZBHB0hxOZSp35Htj1i
 X0XWE8PoQOz5xjasCqYo5lEhyLxPSBEjQPKmAw3uceusLWBi8U9tOBDduWam2mR7zFZr
 bbXLPxhK+FjMJvWz9tWyuNAn2ruOmqFqUT4HBB5IjfwXdoV09RNugr1UDJzQ25+ZUkYK
 yAVozmRFStrjpgi1M36tOKKSOHc9uWoAUR3IQwYACcBYkJRjIQfmotm2AIk80jU0xOyf
 zKxFk8Ef1S1j7xFUK2JCv2Uwbfiuo85QZOylCYp39kSnR99wVCEgkB1Sc78p6fDbsCIH
 tY+g==
X-Gm-Message-State: AGi0Pubc+0+k4f+XEIR/dfY5a7VRVQzqkNITGWVeGqV59VIC+fEYAJpx
 Uu5SZux8FwAQNfUidzyFrvWGyO1mV9A=
X-Google-Smtp-Source: APiQypIIfLInFQih1yPlDqj4ThAMew76FVybNHlz4werRNpcZ+0nZknGAylT9D9Sth9ecVeFvxt8IQ==
X-Received: by 2002:a62:6807:: with SMTP id d7mr4298728pfc.296.1588962401460; 
 Fri, 08 May 2020 11:26:41 -0700 (PDT)
Received: from localhost.localdomain (174-21-149-226.tukw.qwest.net.
 [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id u9sm2421775pfn.197.2020.05.08.11.26.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2020 11:26:40 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 17/19] tcg: Add tcg_reg_alloc_dup2
Date: Fri,  8 May 2020 11:26:14 -0700
Message-Id: <20200508182616.18318-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200508182616.18318-1-richard.henderson@linaro.org>
References: <20200508182616.18318-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::441;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x441.google.com
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


