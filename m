Return-Path: <SRS0=tv2o=EM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2A87C2D0A3
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 03:55:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBBF820756
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 03:55:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hWfZw76t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBBF820756
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48796 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kasqV-00075u-UF
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 22:55:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47438)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kasSM-0005tm-Mt
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 22:30:30 -0500
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:46562)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kasSC-0007ED-Vm
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 22:30:30 -0500
Received: by mail-pg1-x541.google.com with SMTP id w4so2858770pgg.13
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2020 19:30:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=X069CiQ8RfhdePwhlJh4L+vOpoRIhJZjo/+F//DMvos=;
 b=hWfZw76tIAopRt9JUUbxhcXJJAXWvF265V5ztFcYBz/B0G5dw0hCti5EyxYA8ipGKS
 WIyY9hDDSs4GDP1xAECR+P9T6qA935U3ZjFaqG2ITyrjT2MmrX6HERdon/7ZeLLqUVeb
 jLUrJ6mO8OcONSVS+euwjko/N9SUhsuaJBkZOsBk0coag/rkHxod2bcrPsnvX+URAejs
 NBsUk9pbtAJIfoJgPoEsransOcxUB558okPrVhYtxBLGrqnJsWlzCKUPPua70qliW6f6
 IdIpYRVaGUZQHR78oVdQxPK6IUzKT8nrHr1ZhZaDGsmc01bE0Hj8v5u/tttKj4LfApos
 IXSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=X069CiQ8RfhdePwhlJh4L+vOpoRIhJZjo/+F//DMvos=;
 b=DZFKDpVngJWsqPLTygXAakhAtVWXj1RUzNEbeG6KecTONP4vZTA+q+uSDgt1m9dkqy
 D5NIAfJwBQiVukMbZqTNhcHYndLPVToBKv2gUVdfUn0ETtWsP31URWqByACWp1fxk/uj
 BUeXgJuvyvE9Bzca8ig0hsyT9m0IirEzKBJOwKNpMP4qnOeD+zxTxfftzuEacXeYtoH3
 pGTzSpsm+UVWZ1B5Y+8/0XP98787qNFtTW6zxh8IrxBc2SVxtDJhEZEUKTZnJ9DnL3tu
 3uVmBUQfdzbw48GCzEA8zrwSGH++6umjWiIIyxM4bpMQKft5VZNjVE4xDjA+6DUvAW5F
 JP2Q==
X-Gm-Message-State: AOAM533p1k6REMxSrxDxOjg2Emc+S9N9JRTfnGtzbdMuCmETestrzuy2
 crwWK688SQnoGAnXtYAEVqUBO0A07CmC3Q==
X-Google-Smtp-Source: ABdhPJwiOrYh7BphkTVTM4tS63LVlREuywa6wrj2QGtbWHGAbZifzlePD4PC2dVB7OdJ+XR90DwohA==
X-Received: by 2002:a17:90a:e997:: with SMTP id
 v23mr129407pjy.195.1604633411905; 
 Thu, 05 Nov 2020 19:30:11 -0800 (PST)
Received: from localhost.localdomain (76-14-210-194.or.wavecable.com.
 [76.14.210.194])
 by smtp.gmail.com with ESMTPSA id i10sm40773pfd.60.2020.11.05.19.30.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2020 19:30:10 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 34/41] tcg/riscv: Support split-wx code generation
Date: Thu,  5 Nov 2020 19:29:14 -0800
Message-Id: <20201106032921.600200-35-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201106032921.600200-1-richard.henderson@linaro.org>
References: <20201106032921.600200-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::541;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x541.google.com
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
Cc: j@getutm.app
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/riscv/tcg-target.h     |  2 +-
 tcg/riscv/tcg-target.c.inc | 41 +++++++++++++++++++++-----------------
 2 files changed, 24 insertions(+), 19 deletions(-)

diff --git a/tcg/riscv/tcg-target.h b/tcg/riscv/tcg-target.h
index 3c2e8305b0..0eb19f2b11 100644
--- a/tcg/riscv/tcg-target.h
+++ b/tcg/riscv/tcg-target.h
@@ -179,6 +179,6 @@ void tb_target_set_jmp_target(uintptr_t, uintptr_t, uintptr_t, uintptr_t);
 #define TCG_TARGET_NEED_POOL_LABELS
 
 #define TCG_TARGET_HAS_MEMORY_BSWAP 0
-#define TCG_TARGET_SUPPORT_MIRROR   0
+#define TCG_TARGET_SUPPORT_MIRROR   1
 
 #endif
diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
index 02beb86977..5c1e0f8fc1 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -425,41 +425,44 @@ static void tcg_out_nop_fill(tcg_insn_unit *p, int count)
  * Relocations
  */
 
-static bool reloc_sbimm12(tcg_insn_unit *code_ptr, tcg_insn_unit *target)
+static bool reloc_sbimm12(tcg_insn_unit *src_rw, const tcg_insn_unit *target)
 {
-    intptr_t offset = (intptr_t)target - (intptr_t)code_ptr;
+    const tcg_insn_unit *src_rx = tcg_splitwx_to_rx(src_rw);
+    intptr_t offset = (intptr_t)target - (intptr_t)src_rx;
 
     tcg_debug_assert((offset & 1) == 0);
     if (offset == sextreg(offset, 0, 12)) {
-        code_ptr[0] |= encode_sbimm12(offset);
+        *src_rw |= encode_sbimm12(offset);
         return true;
     }
 
     return false;
 }
 
-static bool reloc_jimm20(tcg_insn_unit *code_ptr, tcg_insn_unit *target)
+static bool reloc_jimm20(tcg_insn_unit *src_rw, const tcg_insn_unit *target)
 {
-    intptr_t offset = (intptr_t)target - (intptr_t)code_ptr;
+    const tcg_insn_unit *src_rx = tcg_splitwx_to_rx(src_rw);
+    intptr_t offset = (intptr_t)target - (intptr_t)src_rx;
 
     tcg_debug_assert((offset & 1) == 0);
     if (offset == sextreg(offset, 0, 20)) {
-        code_ptr[0] |= encode_ujimm20(offset);
+        *src_rw |= encode_ujimm20(offset);
         return true;
     }
 
     return false;
 }
 
-static bool reloc_call(tcg_insn_unit *code_ptr, const tcg_insn_unit *target)
+static bool reloc_call(tcg_insn_unit *src_rw, const tcg_insn_unit *target)
 {
-    intptr_t offset = (intptr_t)target - (intptr_t)code_ptr;
+    const tcg_insn_unit *src_rx = tcg_splitwx_to_rx(src_rw);
+    intptr_t offset = (intptr_t)target - (intptr_t)src_rx;
     int32_t lo = sextreg(offset, 0, 12);
     int32_t hi = offset - lo;
 
     if (offset == hi + lo) {
-        code_ptr[0] |= encode_uimm20(hi);
-        code_ptr[1] |= encode_imm12(lo);
+        src_rw[0] |= encode_uimm20(hi);
+        src_rw[1] |= encode_imm12(lo);
         return true;
     }
 
@@ -532,7 +535,7 @@ static void tcg_out_movi(TCGContext *s, TCGType type, TCGReg rd,
     if (tmp == (int32_t)tmp) {
         tcg_out_opc_upper(s, OPC_AUIPC, rd, 0);
         tcg_out_opc_imm(s, OPC_ADDI, rd, rd, 0);
-        ret = reloc_call(s->code_ptr - 2, (tcg_insn_unit *)val);
+        ret = reloc_call(s->code_ptr - 2, (const tcg_insn_unit *)val);
         tcg_debug_assert(ret == true);
         return;
     }
@@ -917,7 +920,7 @@ QEMU_BUILD_BUG_ON(TCG_TARGET_REG_BITS < TARGET_LONG_BITS);
 QEMU_BUILD_BUG_ON(TLB_MASK_TABLE_OFS(0) > 0);
 QEMU_BUILD_BUG_ON(TLB_MASK_TABLE_OFS(0) < -(1 << 11));
 
-static void tcg_out_goto(TCGContext *s, tcg_insn_unit *target)
+static void tcg_out_goto(TCGContext *s, const tcg_insn_unit *target)
 {
     tcg_out_opc_jump(s, OPC_JAL, TCG_REG_ZERO, 0);
     bool ok = reloc_jimm20(s->code_ptr - 1, target);
@@ -993,7 +996,8 @@ static void add_qemu_ldst_label(TCGContext *s, int is_ld, TCGMemOpIdx oi,
     label->datahi_reg = datahi;
     label->addrlo_reg = addrlo;
     label->addrhi_reg = addrhi;
-    label->raddr = raddr;
+    /* TODO: Cast goes away when all hosts converted */
+    label->raddr = (void *)tcg_splitwx_to_rx(raddr);
     label->label_ptr[0] = label_ptr[0];
 }
 
@@ -1012,7 +1016,7 @@ static bool tcg_out_qemu_ld_slow_path(TCGContext *s, TCGLabelQemuLdst *l)
     }
 
     /* resolve label address */
-    if (!reloc_sbimm12(l->label_ptr[0], s->code_ptr)) {
+    if (!reloc_sbimm12(l->label_ptr[0], tcg_splitwx_to_rx(s->code_ptr))) {
         return false;
     }
 
@@ -1046,7 +1050,7 @@ static bool tcg_out_qemu_st_slow_path(TCGContext *s, TCGLabelQemuLdst *l)
     }
 
     /* resolve label address */
-    if (!reloc_sbimm12(l->label_ptr[0], s->code_ptr)) {
+    if (!reloc_sbimm12(l->label_ptr[0], tcg_splitwx_to_rx(s->code_ptr))) {
         return false;
     }
 
@@ -1232,7 +1236,7 @@ static void tcg_out_qemu_st(TCGContext *s, const TCGArg *args, bool is_64)
 #endif
 }
 
-static tcg_insn_unit *tb_ret_addr;
+static const tcg_insn_unit *tb_ret_addr;
 
 static void tcg_out_op(TCGContext *s, TCGOpcode opc,
                        const TCGArg *args, const int *const_args)
@@ -1780,11 +1784,12 @@ static void tcg_target_qemu_prologue(TCGContext *s)
     tcg_out_opc_imm(s, OPC_JALR, TCG_REG_ZERO, tcg_target_call_iarg_regs[1], 0);
 
     /* Return path for goto_ptr. Set return value to 0 */
-    tcg_code_gen_epilogue = s->code_ptr;
+    /* TODO: Cast goes away when all hosts converted */
+    tcg_code_gen_epilogue = (void *)tcg_splitwx_to_rx(s->code_ptr);
     tcg_out_mov(s, TCG_TYPE_REG, TCG_REG_A0, TCG_REG_ZERO);
 
     /* TB epilogue */
-    tb_ret_addr = s->code_ptr;
+    tb_ret_addr = tcg_splitwx_to_rx(s->code_ptr);
     for (i = 0; i < ARRAY_SIZE(tcg_target_callee_save_regs); i++) {
         tcg_out_ld(s, TCG_TYPE_REG, tcg_target_callee_save_regs[i],
                    TCG_REG_SP, SAVE_OFS + i * REG_SIZE);
-- 
2.25.1


