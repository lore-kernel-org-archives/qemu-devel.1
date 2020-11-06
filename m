Return-Path: <SRS0=tv2o=EM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 829A3C2D0A3
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 03:45:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBE662072E
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 03:45:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nCoKluwl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBE662072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48844 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kasgg-0003kE-MW
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 22:45:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47212)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kasS5-0005Vb-FH
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 22:30:14 -0500
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:39964)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kasS1-00077M-OR
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 22:30:11 -0500
Received: by mail-pg1-x542.google.com with SMTP id x13so2880672pgp.7
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2020 19:30:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=pY7YptV5jK52/EGSfz+70ZXeLAnSsRhMupI/NGLlfao=;
 b=nCoKluwlNDu2+WsZadTbwfyDuW4VcgCWFPKDcbSQ6yJKvQFdcE6/tpKzIhhw6aYnNu
 2q5WyMOfuIP1SXFZ8QsZV5LNqenkfVQB8POnPWDZyzX/Mbr1yx8mLWNgf+XBF52qPBdF
 W1E752WaFxlSj/9ANVbv7pXw6d6C/RWMN3VC7KBOu9omRXrzPGgdGmxBlSAsA35lsqZ5
 GOFApu/GKMw+vE0YMdZmMLUOZqgbCqZj0lzct7I2XmEu8VljaHg+/kZZneHl5bpWkMSA
 70xB7OMm+jFcD4CVDKJP33SZouJOfBOfxkrcCqL9NBpW5ZSpuKDYwTQyRWB3XAI6JU5L
 niDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=pY7YptV5jK52/EGSfz+70ZXeLAnSsRhMupI/NGLlfao=;
 b=ZMM+zgIpZZWvEc3j+XuTx6k+KjEUgP6ONhyCICcbXKniSPyj35YUisU6EimwcWTWRU
 R47Rxvo8Gumlmlxt4wa4SqZuT6UL2c+KxCchjLq0la2yUCHPUpOKGDONezHbI3ITMByk
 OLiUjD9QMP50CKAQvCYw76QGL/I7MBH4XN/19jIavUYjmc97tsE655B0qi/OVlIuqu5E
 szVzthCZIeh9jGQ3EocUr6gWm06nRjP9lYhL2fM96G54mV3zsWtWYJTj3tpx0agXRnpC
 EBJyp1TxjfO8eTtuTZuI0cocB1+8GwypJ9c6biGydX7amev/lFqXf907P/jH0qtlU0at
 iAOg==
X-Gm-Message-State: AOAM530rXRKgVpQ5T7XdrQkx4Speh/V5UPFZde/QKAJomOKHShMdMssX
 BLk+Xj75HTuh+2lpWSweU6tI4q1voDRrOA==
X-Google-Smtp-Source: ABdhPJwYnH+zP4tJHNiwsPCY34BxnpN42esb6FVkVb1xKT3Mz8oXyJU+qAP/5Rw06kBrG0jF6hGNXw==
X-Received: by 2002:a17:90a:f211:: with SMTP id
 bs17mr138622pjb.153.1604633400809; 
 Thu, 05 Nov 2020 19:30:00 -0800 (PST)
Received: from localhost.localdomain (76-14-210-194.or.wavecable.com.
 [76.14.210.194])
 by smtp.gmail.com with ESMTPSA id i10sm40773pfd.60.2020.11.05.19.29.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2020 19:30:00 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 27/41] tcg/ppc: Support split-wx code generation
Date: Thu,  5 Nov 2020 19:29:07 -0800
Message-Id: <20201106032921.600200-28-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201106032921.600200-1-richard.henderson@linaro.org>
References: <20201106032921.600200-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::542;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x542.google.com
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
 tcg/ppc/tcg-target.h     |  2 +-
 tcg/ppc/tcg-target.c.inc | 53 +++++++++++++++++++++++-----------------
 2 files changed, 31 insertions(+), 24 deletions(-)

diff --git a/tcg/ppc/tcg-target.h b/tcg/ppc/tcg-target.h
index 78d6a5e96f..a8628b6cad 100644
--- a/tcg/ppc/tcg-target.h
+++ b/tcg/ppc/tcg-target.h
@@ -185,6 +185,6 @@ void tb_target_set_jmp_target(uintptr_t, uintptr_t, uintptr_t, uintptr_t);
 #define TCG_TARGET_NEED_LDST_LABELS
 #endif
 #define TCG_TARGET_NEED_POOL_LABELS
-#define TCG_TARGET_SUPPORT_MIRROR       0
+#define TCG_TARGET_SUPPORT_MIRROR       1
 
 #endif
diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index 91d5d95ddf..fe33687787 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -62,8 +62,6 @@
 #define TCG_CT_CONST_MONE 0x2000
 #define TCG_CT_CONST_WSZ  0x4000
 
-static tcg_insn_unit *tb_ret_addr;
-
 TCGPowerISA have_isa;
 static bool have_isel;
 bool have_altivec;
@@ -184,35 +182,41 @@ static inline bool in_range_b(tcg_target_long target)
     return target == sextract64(target, 0, 26);
 }
 
-static uint32_t reloc_pc24_val(tcg_insn_unit *pc, const tcg_insn_unit *target)
+static uint32_t reloc_pc24_val(const tcg_insn_unit *pc,
+			       const tcg_insn_unit *target)
 {
     ptrdiff_t disp = tcg_ptr_byte_diff(target, pc);
     tcg_debug_assert(in_range_b(disp));
     return disp & 0x3fffffc;
 }
 
-static bool reloc_pc24(tcg_insn_unit *pc, tcg_insn_unit *target)
+static bool reloc_pc24(tcg_insn_unit *src_rw, const tcg_insn_unit *target)
 {
-    ptrdiff_t disp = tcg_ptr_byte_diff(target, pc);
+    const tcg_insn_unit *src_rx = tcg_splitwx_to_rx(src_rw);
+    ptrdiff_t disp = tcg_ptr_byte_diff(target, src_rx);
+
     if (in_range_b(disp)) {
-        *pc = (*pc & ~0x3fffffc) | (disp & 0x3fffffc);
+        *src_rw = (*src_rw & ~0x3fffffc) | (disp & 0x3fffffc);
         return true;
     }
     return false;
 }
 
-static uint16_t reloc_pc14_val(tcg_insn_unit *pc, const tcg_insn_unit *target)
+static uint16_t reloc_pc14_val(const tcg_insn_unit *pc,
+			       const tcg_insn_unit *target)
 {
     ptrdiff_t disp = tcg_ptr_byte_diff(target, pc);
     tcg_debug_assert(disp == (int16_t) disp);
     return disp & 0xfffc;
 }
 
-static bool reloc_pc14(tcg_insn_unit *pc, tcg_insn_unit *target)
+static bool reloc_pc14(tcg_insn_unit *src_rw, const tcg_insn_unit *target)
 {
-    ptrdiff_t disp = tcg_ptr_byte_diff(target, pc);
+    const tcg_insn_unit *src_rx = tcg_splitwx_to_rx(src_rw);
+    ptrdiff_t disp = tcg_ptr_byte_diff(target, src_rx);
+
     if (disp == (int16_t) disp) {
-        *pc = (*pc & ~0xfffc) | (disp & 0xfffc);
+        *src_rw = (*src_rw & ~0xfffc) | (disp & 0xfffc);
         return true;
     }
     return false;
@@ -673,12 +677,12 @@ static const uint32_t tcg_to_isel[] = {
 static bool patch_reloc(tcg_insn_unit *code_ptr, int type,
                         intptr_t value, intptr_t addend)
 {
-    tcg_insn_unit *target;
+    const tcg_insn_unit *target;
     int16_t lo;
     int32_t hi;
 
     value += addend;
-    target = (tcg_insn_unit *)value;
+    target = (const tcg_insn_unit *)value;
 
     switch (type) {
     case R_PPC_REL14:
@@ -1544,7 +1548,7 @@ static void tcg_out_setcond(TCGContext *s, TCGType type, TCGCond cond,
 static void tcg_out_bc(TCGContext *s, int bc, TCGLabel *l)
 {
     if (l->has_value) {
-        bc |= reloc_pc14_val(s->code_ptr, l->u.value_ptr);
+        bc |= reloc_pc14_val(tcg_splitwx_to_rx(s->code_ptr), l->u.value_ptr);
     } else {
         tcg_out_reloc(s, s->code_ptr, R_PPC_REL14, l, 0);
     }
@@ -1997,7 +2001,8 @@ static void add_qemu_ldst_label(TCGContext *s, bool is_ld, TCGMemOpIdx oi,
     label->datahi_reg = datahi_reg;
     label->addrlo_reg = addrlo_reg;
     label->addrhi_reg = addrhi_reg;
-    label->raddr = raddr;
+    /* TODO: Cast goes away when all hosts converted */
+    label->raddr = (void *)tcg_splitwx_to_rx(raddr);
     label->label_ptr[0] = lptr;
 }
 
@@ -2007,7 +2012,7 @@ static bool tcg_out_qemu_ld_slow_path(TCGContext *s, TCGLabelQemuLdst *lb)
     MemOp opc = get_memop(oi);
     TCGReg hi, lo, arg = TCG_REG_R3;
 
-    if (!reloc_pc14(lb->label_ptr[0], s->code_ptr)) {
+    if (!reloc_pc14(lb->label_ptr[0], tcg_splitwx_to_rx(s->code_ptr))) {
         return false;
     }
 
@@ -2055,7 +2060,7 @@ static bool tcg_out_qemu_st_slow_path(TCGContext *s, TCGLabelQemuLdst *lb)
     MemOp s_bits = opc & MO_SIZE;
     TCGReg hi, lo, arg = TCG_REG_R3;
 
-    if (!reloc_pc14(lb->label_ptr[0], s->code_ptr)) {
+    if (!reloc_pc14(lb->label_ptr[0], tcg_splitwx_to_rx(s->code_ptr))) {
         return false;
     }
 
@@ -2306,10 +2311,10 @@ static void tcg_target_qemu_prologue(TCGContext *s)
     int i;
 
 #ifdef _CALL_AIX
-    void **desc = (void **)s->code_ptr;
-    desc[0] = desc + 2;                   /* entry point */
-    desc[1] = 0;                          /* environment pointer */
-    s->code_ptr = (void *)(desc + 2);     /* skip over descriptor */
+    const void **desc = (const void **)s->code_ptr;
+    desc[0] = tcg_splitwx_to_rx(desc + 2);  /* entry point */
+    desc[1] = 0;                            /* environment pointer */
+    s->code_ptr = (void *)(desc + 2);       /* skip over descriptor */
 #endif
 
     tcg_set_frame(s, TCG_REG_CALL_STACK, REG_SAVE_BOT - CPU_TEMP_BUF_SIZE,
@@ -2341,7 +2346,8 @@ static void tcg_target_qemu_prologue(TCGContext *s)
     tcg_out32(s, BCCTR | BO_ALWAYS);
 
     /* Epilogue */
-    tcg_code_gen_epilogue = tb_ret_addr = s->code_ptr;
+    /* TODO: Cast goes away when all hosts converted */
+    tcg_code_gen_epilogue = (void *)tcg_splitwx_to_rx(s->code_ptr);
 
     tcg_out_ld(s, TCG_TYPE_PTR, TCG_REG_R0, TCG_REG_R1, FRAME_SIZE+LR_OFFSET);
     for (i = 0; i < ARRAY_SIZE(tcg_target_callee_save_regs); ++i) {
@@ -2362,7 +2368,7 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, const TCGArg *args,
     switch (opc) {
     case INDEX_op_exit_tb:
         tcg_out_movi(s, TCG_TYPE_PTR, TCG_REG_R3, args[0]);
-        tcg_out_b(s, 0, tb_ret_addr);
+        tcg_out_b(s, 0, tcg_code_gen_epilogue);
         break;
     case INDEX_op_goto_tb:
         if (s->tb_jmp_insn_offset) {
@@ -2410,7 +2416,8 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, const TCGArg *args,
             uint32_t insn = B;
 
             if (l->has_value) {
-                insn |= reloc_pc24_val(s->code_ptr, l->u.value_ptr);
+                insn |= reloc_pc24_val(tcg_splitwx_to_rx(s->code_ptr),
+                                       l->u.value_ptr);
             } else {
                 tcg_out_reloc(s, s->code_ptr, R_PPC_REL24, l, 0);
             }
-- 
2.25.1


