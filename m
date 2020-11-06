Return-Path: <SRS0=tv2o=EM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3FE2C2D0A3
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 03:54:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37B6420756
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 03:54:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J7etCM5B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37B6420756
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47420 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kasq0-0006V7-6c
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 22:54:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47376)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kasSJ-0005lX-6n
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 22:30:27 -0500
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:34490)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kasSD-0007Hu-9z
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 22:30:26 -0500
Received: by mail-pg1-x543.google.com with SMTP id t14so2896485pgg.1
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2020 19:30:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=i/8RU487BVd0btRakBjFsuP0ajWNBfCw0WmrLKKXBMA=;
 b=J7etCM5BpJaxIICtLqgMhIzoAG5XqPbBJfFqIITXS4ZsX/I6NeoJ6VLn9670OzyBUT
 dUm+ofsW37bnLnHBbUHqevCrBNBPMZK4VKxJVIaMumsVgZWndHb5s5ZthMbk9LEr9n7r
 1xhp53oTaMGe3vr7fLXyWvvkeOmR3FiJfQXAYN8ImJr1A9J1rScJPAhtbtNWgo4zp/G0
 c5XwuFvkdOoHcSCuBLXdzjiQvkFofWBwMfN0jlOLGqi180DT+k5+j7eLXO3LtErisjPF
 0FofQdrpDGbFN3785WZGzjKzpdqMJDF6mb4wwwNzG39vY/CaGZAr2k+8tSApsJIpUEJP
 evhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=i/8RU487BVd0btRakBjFsuP0ajWNBfCw0WmrLKKXBMA=;
 b=RStPSkVM4wDHtwqwyn++xIhsK4PP7oVfjc639AqDImD354UH3MTTzcGrYz9/wMrI3u
 4tjnSa/4xHOOGLkU2rGhwCjXL1RqadQfERAuhH13w553L5RistigKBZKN5peF37+zJl1
 /5GebYDqMIUFrYa//19KkB7BISDTNd+45eoBiD4OcWsjPvERJ4zNdq/lQ417a2Gso/+K
 gt4mKpTrKyu0feTTJvBxTpyrtIqqQOLaCBeO6HlylwtUuwAspKHX5pT4l4ZhcvT4DZee
 exRC7TrNKKqVyYjWtFooxgiQkJtsqq1BS+4Wbl6wOwIcdD1XYyIf/vsxo9lCvM8Zmsdt
 j51Q==
X-Gm-Message-State: AOAM533NzHlsHAWLLigY73NuHmKCEHQx7lsEcAnRiyhVFZ6WQ40LFiVO
 vh0omuLADSMzH+GiUmVzy5Cd7MqCPirrTg==
X-Google-Smtp-Source: ABdhPJy9bz3E2y1BTj3JQbZBYCvNTQNqb+3JOR1zj1pqTx/rdi3kvQn7aOXCwucpLytQRdkXrUHfuA==
X-Received: by 2002:aa7:9e90:0:b029:18b:a94:3498 with SMTP id
 p16-20020aa79e900000b029018b0a943498mr5163436pfq.54.1604633418535; 
 Thu, 05 Nov 2020 19:30:18 -0800 (PST)
Received: from localhost.localdomain (76-14-210-194.or.wavecable.com.
 [76.14.210.194])
 by smtp.gmail.com with ESMTPSA id i10sm40773pfd.60.2020.11.05.19.30.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2020 19:30:17 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 37/41] tcg/mips: Support split-wx code generation
Date: Thu,  5 Nov 2020 19:29:17 -0800
Message-Id: <20201106032921.600200-38-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201106032921.600200-1-richard.henderson@linaro.org>
References: <20201106032921.600200-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::543;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x543.google.com
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
 tcg/mips/tcg-target.h     |  2 +-
 tcg/mips/tcg-target.c.inc | 43 ++++++++++++++++++++++-----------------
 2 files changed, 25 insertions(+), 20 deletions(-)

diff --git a/tcg/mips/tcg-target.h b/tcg/mips/tcg-target.h
index d231522dc9..d7d8e6ea1c 100644
--- a/tcg/mips/tcg-target.h
+++ b/tcg/mips/tcg-target.h
@@ -206,7 +206,7 @@ extern bool use_mips32r2_instructions;
 
 #define TCG_TARGET_DEFAULT_MO (0)
 #define TCG_TARGET_HAS_MEMORY_BSWAP     1
-#define TCG_TARGET_SUPPORT_MIRROR       0
+#define TCG_TARGET_SUPPORT_MIRROR       1
 
 /* Flush the dcache at RW, and the icache at RX, as necessary. */
 static inline void flush_idcache_range(uintptr_t rx, uintptr_t rw, size_t len)
diff --git a/tcg/mips/tcg-target.c.inc b/tcg/mips/tcg-target.c.inc
index 37faf1356c..a2201bd1dd 100644
--- a/tcg/mips/tcg-target.c.inc
+++ b/tcg/mips/tcg-target.c.inc
@@ -139,17 +139,18 @@ static const TCGReg tcg_target_call_oarg_regs[2] = {
     TCG_REG_V1
 };
 
-static tcg_insn_unit *tb_ret_addr;
-static tcg_insn_unit *bswap32_addr;
-static tcg_insn_unit *bswap32u_addr;
-static tcg_insn_unit *bswap64_addr;
+static const tcg_insn_unit *tb_ret_addr;
+static const tcg_insn_unit *bswap32_addr;
+static const tcg_insn_unit *bswap32u_addr;
+static const tcg_insn_unit *bswap64_addr;
 
-static bool reloc_pc16(tcg_insn_unit *pc, const tcg_insn_unit *target)
+static bool reloc_pc16(tcg_insn_unit *src_rw, const tcg_insn_unit *target)
 {
     /* Let the compiler perform the right-shift as part of the arithmetic.  */
-    ptrdiff_t disp = target - (pc + 1);
+    const tcg_insn_unit *src_rx = tcg_splitwx_to_rx(src_rw);
+    ptrdiff_t disp = target - (src_rx + 1);
     if (disp == (int16_t)disp) {
-        *pc = deposit32(*pc, 0, 16, disp);
+        *src_rw = deposit32(*src_rw, 0, 16, disp);
         return true;
     }
     return false;
@@ -505,7 +506,7 @@ static void tcg_out_opc_sa64(TCGContext *s, MIPSInsn opc1, MIPSInsn opc2,
 static bool tcg_out_opc_jmp(TCGContext *s, MIPSInsn opc, const void *target)
 {
     uintptr_t dest = (uintptr_t)target;
-    uintptr_t from = (uintptr_t)s->code_ptr + 4;
+    uintptr_t from = (uintptr_t)tcg_splitwx_to_rx(s->code_ptr) + 4;
     int32_t inst;
 
     /* The pc-region branch happens within the 256MB region of
@@ -617,7 +618,7 @@ static inline void tcg_out_bswap16s(TCGContext *s, TCGReg ret, TCGReg arg)
     }
 }
 
-static void tcg_out_bswap_subr(TCGContext *s, tcg_insn_unit *sub)
+static void tcg_out_bswap_subr(TCGContext *s, const tcg_insn_unit *sub)
 {
     bool ok = tcg_out_opc_jmp(s, OPC_JAL, sub);
     tcg_debug_assert(ok);
@@ -1282,7 +1283,8 @@ static void add_qemu_ldst_label(TCGContext *s, int is_ld, TCGMemOpIdx oi,
     label->datahi_reg = datahi;
     label->addrlo_reg = addrlo;
     label->addrhi_reg = addrhi;
-    label->raddr = raddr;
+    /* TODO: Cast goes away when all hosts converted */
+    label->raddr = (void *)tcg_splitwx_to_rx(raddr);
     label->label_ptr[0] = label_ptr[0];
     if (TCG_TARGET_REG_BITS < TARGET_LONG_BITS) {
         label->label_ptr[1] = label_ptr[1];
@@ -1291,15 +1293,16 @@ static void add_qemu_ldst_label(TCGContext *s, int is_ld, TCGMemOpIdx oi,
 
 static bool tcg_out_qemu_ld_slow_path(TCGContext *s, TCGLabelQemuLdst *l)
 {
+    const tcg_insn_unit *tgt_rx = tcg_splitwx_to_rx(s->code_ptr);
     TCGMemOpIdx oi = l->oi;
     MemOp opc = get_memop(oi);
     TCGReg v0;
     int i;
 
     /* resolve label address */
-    if (!reloc_pc16(l->label_ptr[0], s->code_ptr)
+    if (!reloc_pc16(l->label_ptr[0], tgt_rx)
         || (TCG_TARGET_REG_BITS < TARGET_LONG_BITS
-            && !reloc_pc16(l->label_ptr[1], s->code_ptr))) {
+            && !reloc_pc16(l->label_ptr[1], tgt_rx))) {
         return false;
     }
 
@@ -1344,15 +1347,16 @@ static bool tcg_out_qemu_ld_slow_path(TCGContext *s, TCGLabelQemuLdst *l)
 
 static bool tcg_out_qemu_st_slow_path(TCGContext *s, TCGLabelQemuLdst *l)
 {
+    const tcg_insn_unit *tgt_rx = tcg_splitwx_to_rx(s->code_ptr);
     TCGMemOpIdx oi = l->oi;
     MemOp opc = get_memop(oi);
     MemOp s_bits = opc & MO_SIZE;
     int i;
 
     /* resolve label address */
-    if (!reloc_pc16(l->label_ptr[0], s->code_ptr)
+    if (!reloc_pc16(l->label_ptr[0], tgt_rx)
         || (TCG_TARGET_REG_BITS < TARGET_LONG_BITS
-            && !reloc_pc16(l->label_ptr[1], s->code_ptr))) {
+            && !reloc_pc16(l->label_ptr[1], tgt_rx))) {
         return false;
     }
 
@@ -2469,11 +2473,12 @@ static void tcg_target_qemu_prologue(TCGContext *s)
      * Return path for goto_ptr. Set return value to 0, a-la exit_tb,
      * and fall through to the rest of the epilogue.
      */
-    tcg_code_gen_epilogue = s->code_ptr;
+    /* TODO: Cast goes away when all hosts converted */
+    tcg_code_gen_epilogue = (void *)tcg_splitwx_to_rx(s->code_ptr);
     tcg_out_mov(s, TCG_TYPE_REG, TCG_REG_V0, TCG_REG_ZERO);
 
     /* TB epilogue */
-    tb_ret_addr = s->code_ptr;
+    tb_ret_addr = tcg_splitwx_to_rx(s->code_ptr);
     for (i = 0; i < ARRAY_SIZE(tcg_target_callee_save_regs); i++) {
         tcg_out_ld(s, TCG_TYPE_REG, tcg_target_callee_save_regs[i],
                    TCG_REG_SP, SAVE_OFS + i * REG_SIZE);
@@ -2493,7 +2498,7 @@ static void tcg_target_qemu_prologue(TCGContext *s)
     /*
      * bswap32 -- 32-bit swap (signed result for mips64).  a0 = abcd.
      */
-    bswap32_addr = align_code_ptr(s);
+    bswap32_addr = tcg_splitwx_to_rx(align_code_ptr(s));
     /* t3 = (ssss)d000 */
     tcg_out_opc_sa(s, OPC_SLL, TCG_TMP3, TCG_TMP0, 24);
     /* t1 = 000a */
@@ -2521,7 +2526,7 @@ static void tcg_target_qemu_prologue(TCGContext *s)
     /*
      * bswap32u -- unsigned 32-bit swap.  a0 = ....abcd.
      */
-    bswap32u_addr = align_code_ptr(s);
+    bswap32u_addr = tcg_splitwx_to_rx(align_code_ptr(s));
     /* t1 = (0000)000d */
     tcg_out_opc_imm(s, OPC_ANDI, TCG_TMP1, TCG_TMP0, 0xff);
     /* t3 = 000a */
@@ -2547,7 +2552,7 @@ static void tcg_target_qemu_prologue(TCGContext *s)
     /*
      * bswap64 -- 64-bit swap.  a0 = abcdefgh
      */
-    bswap64_addr = align_code_ptr(s);
+    bswap64_addr = tcg_splitwx_to_rx(align_code_ptr(s));
     /* t3 = h0000000 */
     tcg_out_dsll(s, TCG_TMP3, TCG_TMP0, 56);
     /* t1 = 0000000a */
-- 
2.25.1


