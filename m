Return-Path: <SRS0=tv2o=EM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56103C2D0A3
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 03:50:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C048C20735
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 03:50:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GiHR9fUR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C048C20735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36310 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kasli-0001q0-Ok
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 22:50:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47354)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kasSH-0005go-5R
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 22:30:25 -0500
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435]:39738)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kasSC-0007CG-Uq
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 22:30:24 -0500
Received: by mail-pf1-x435.google.com with SMTP id z3so46255pfz.6
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2020 19:30:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=aArTyFb7Ktq31UPOCddipIoQqJqHp+0fJTTegnZpRQ8=;
 b=GiHR9fURSlcdPxqERsGOqa9+NQjIirDf8iD08SgqCBNvJ6h7mOA/GQ9FGleeAVuBEu
 Bodn2ewrKJXFlxhENZLpnNfFNzziMu9vOVXRt4R8D7YfJYJ3TyGiqPjpJzko26sf1CR7
 K5SWJRzeQORR1iFmaNstE871LrzyR/qN/kuSdN5U+1b6x+lVOOWJ4q16FNKIyjJc0N6h
 tXJwWXqkjFyAbYaOgVN6RMMgtRCo7Yh0g+SWpXncLFysCokNev6Q809IEPJz36L832OU
 4Yo6DM3/Y4jEMNnXrUArNUgE4/gY0XoFrqtSgrKwRcKGYnz9crUB0kqXfvJXbl+dF1SO
 mScg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=aArTyFb7Ktq31UPOCddipIoQqJqHp+0fJTTegnZpRQ8=;
 b=LaruWT5EMptYkDaBNXj5KlJThSqUj8JYleFiYvXzPDnNWnQPoY3B+ZFbBWHKV8Am5W
 oOM6nofhOJrpdaa7ntB0n02IFFuQ7WNgkdai6J5Q6Im3NMHwJo858vYZSjQXqQ09lZDT
 aF5BKopUSTjbYdxBAXQg2zWoMNeZahMa7dlIK4zfmzLKS8CrgkktHajOZee7iZuyF1xa
 aj6RQjVZvfUU5mjWAVDhVDjJ6u/kqeZbn5Cn72Y/cu8yfdBexALQ/QHq1XT4e5YLmZU/
 pnXJye/u1nSVlAJNxXAA8SaYIoBnhR/Xqm7T6CzxO3OHacS4YTXgsIySNbkfWXx5QVjq
 2tJw==
X-Gm-Message-State: AOAM530GkxfloNWk3mdSdHKRYzC6RAf+upGEAJLbQOY+DuZLrDNoC3BD
 pYMPXF7S+88t/M66E9FNhg54XGzf+7RqRg==
X-Google-Smtp-Source: ABdhPJxkSkH+0OlN7DO+Cs103Vp/eys3x10LZxz2ubmOzH3T/Z1KRIcrlCo53usWyrQxYKmPvwiVqQ==
X-Received: by 2002:a05:6a00:1389:b029:18b:2d21:2f1a with SMTP id
 t9-20020a056a001389b029018b2d212f1amr117500pfg.1.1604633406665; 
 Thu, 05 Nov 2020 19:30:06 -0800 (PST)
Received: from localhost.localdomain (76-14-210-194.or.wavecable.com.
 [76.14.210.194])
 by smtp.gmail.com with ESMTPSA id i10sm40773pfd.60.2020.11.05.19.30.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2020 19:30:05 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 31/41] tcg/s390: Support split-wx code generation
Date: Thu,  5 Nov 2020 19:29:11 -0800
Message-Id: <20201106032921.600200-32-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201106032921.600200-1-richard.henderson@linaro.org>
References: <20201106032921.600200-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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
 tcg/s390/tcg-target.h     |  2 +-
 tcg/s390/tcg-target.c.inc | 69 +++++++++++++++++----------------------
 2 files changed, 31 insertions(+), 40 deletions(-)

diff --git a/tcg/s390/tcg-target.h b/tcg/s390/tcg-target.h
index 8324197127..1fd8b3858e 100644
--- a/tcg/s390/tcg-target.h
+++ b/tcg/s390/tcg-target.h
@@ -163,6 +163,6 @@ static inline void tb_target_set_jmp_target(uintptr_t tc_ptr, uintptr_t jmp_rx,
 #define TCG_TARGET_NEED_LDST_LABELS
 #endif
 #define TCG_TARGET_NEED_POOL_LABELS
-#define TCG_TARGET_SUPPORT_MIRROR       0
+#define TCG_TARGET_SUPPORT_MIRROR       1
 
 #endif
diff --git a/tcg/s390/tcg-target.c.inc b/tcg/s390/tcg-target.c.inc
index e4c61fc014..582a8ef941 100644
--- a/tcg/s390/tcg-target.c.inc
+++ b/tcg/s390/tcg-target.c.inc
@@ -363,36 +363,37 @@ static void * const qemu_st_helpers[16] = {
 };
 #endif
 
-static tcg_insn_unit *tb_ret_addr;
+static const tcg_insn_unit *tb_ret_addr;
 uint64_t s390_facilities;
 
-static bool patch_reloc(tcg_insn_unit *code_ptr, int type,
+static bool patch_reloc(tcg_insn_unit *src_rw, int type,
                         intptr_t value, intptr_t addend)
 {
+    const tcg_insn_unit *src_rx = tcg_splitwx_to_rx(src_rw);
     intptr_t pcrel2;
     uint32_t old;
 
     value += addend;
-    pcrel2 = (tcg_insn_unit *)value - code_ptr;
+    pcrel2 = (tcg_insn_unit *)value - src_rx;
 
     switch (type) {
     case R_390_PC16DBL:
         if (pcrel2 == (int16_t)pcrel2) {
-            tcg_patch16(code_ptr, pcrel2);
+            tcg_patch16(src_rw, pcrel2);
             return true;
         }
         break;
     case R_390_PC32DBL:
         if (pcrel2 == (int32_t)pcrel2) {
-            tcg_patch32(code_ptr, pcrel2);
+            tcg_patch32(src_rw, pcrel2);
             return true;
         }
         break;
     case R_390_20:
         if (value == sextract64(value, 0, 20)) {
-            old = *(uint32_t *)code_ptr & 0xf00000ff;
+            old = *(uint32_t *)src_rw & 0xf00000ff;
             old |= ((value & 0xfff) << 16) | ((value & 0xff000) >> 4);
-            tcg_patch32(code_ptr, old);
+            tcg_patch32(src_rw, old);
             return true;
         }
         break;
@@ -730,7 +731,8 @@ static inline bool tcg_out_sti(TCGContext *s, TCGType type, TCGArg val,
 }
 
 /* load data from an absolute host address */
-static void tcg_out_ld_abs(TCGContext *s, TCGType type, TCGReg dest, void *abs)
+static void tcg_out_ld_abs(TCGContext *s, TCGType type,
+                           TCGReg dest, const void *abs)
 {
     intptr_t addr = (intptr_t)abs;
 
@@ -1304,7 +1306,7 @@ static void tgen_extract(TCGContext *s, TCGReg dest, TCGReg src,
 
 static void tgen_gotoi(TCGContext *s, int cc, const tcg_insn_unit *dest)
 {
-    ptrdiff_t off = dest - s->code_ptr;
+    ptrdiff_t off = tcg_pcrel_diff(s, dest) >> 1;
     if (off == (int16_t)off) {
         tcg_out_insn(s, RI, BRC, cc, off);
     } else if (off == (int32_t)off) {
@@ -1333,34 +1335,18 @@ static void tgen_branch(TCGContext *s, int cc, TCGLabel *l)
 static void tgen_compare_branch(TCGContext *s, S390Opcode opc, int cc,
                                 TCGReg r1, TCGReg r2, TCGLabel *l)
 {
-    intptr_t off = 0;
-
-    if (l->has_value) {
-        off = l->u.value_ptr - s->code_ptr;
-        tcg_debug_assert(off == (int16_t)off);
-    } else {
-        tcg_out_reloc(s, s->code_ptr + 1, R_390_PC16DBL, l, 2);
-    }
-
+    tcg_out_reloc(s, s->code_ptr + 1, R_390_PC16DBL, l, 2);
     tcg_out16(s, (opc & 0xff00) | (r1 << 4) | r2);
-    tcg_out16(s, off);
+    tcg_out16(s, 0);
     tcg_out16(s, cc << 12 | (opc & 0xff));
 }
 
 static void tgen_compare_imm_branch(TCGContext *s, S390Opcode opc, int cc,
                                     TCGReg r1, int i2, TCGLabel *l)
 {
-    tcg_target_long off = 0;
-
-    if (l->has_value) {
-        off = l->u.value_ptr - s->code_ptr;
-        tcg_debug_assert(off == (int16_t)off);
-    } else {
-        tcg_out_reloc(s, s->code_ptr + 1, R_390_PC16DBL, l, 2);
-    }
-
+    tcg_out_reloc(s, s->code_ptr + 1, R_390_PC16DBL, l, 2);
     tcg_out16(s, (opc & 0xff00) | (r1 << 4) | cc);
-    tcg_out16(s, off);
+    tcg_out16(s, 0);
     tcg_out16(s, (i2 << 8) | (opc & 0xff));
 }
 
@@ -1417,7 +1403,7 @@ static void tgen_brcond(TCGContext *s, TCGType type, TCGCond c,
 
 static void tcg_out_call(TCGContext *s, const tcg_insn_unit *dest)
 {
-    ptrdiff_t off = dest - s->code_ptr;
+    ptrdiff_t off = tcg_pcrel_diff(s, dest) >> 1;
     if (off == (int32_t)off) {
         tcg_out_insn(s, RIL, BRASL, TCG_REG_R14, off);
     } else {
@@ -1601,7 +1587,8 @@ static void add_qemu_ldst_label(TCGContext *s, bool is_ld, TCGMemOpIdx oi,
     label->oi = oi;
     label->datalo_reg = data;
     label->addrlo_reg = addr;
-    label->raddr = raddr;
+    /* TODO: Cast goes away when all hosts converted */
+    label->raddr = (void *)tcg_splitwx_to_rx(raddr);
     label->label_ptr[0] = label_ptr;
 }
 
@@ -1613,7 +1600,7 @@ static bool tcg_out_qemu_ld_slow_path(TCGContext *s, TCGLabelQemuLdst *lb)
     MemOp opc = get_memop(oi);
 
     if (!patch_reloc(lb->label_ptr[0], R_390_PC16DBL,
-                     (intptr_t)s->code_ptr, 2)) {
+                     (intptr_t)tcg_splitwx_to_rx(s->code_ptr), 2)) {
         return false;
     }
 
@@ -1638,7 +1625,7 @@ static bool tcg_out_qemu_st_slow_path(TCGContext *s, TCGLabelQemuLdst *lb)
     MemOp opc = get_memop(oi);
 
     if (!patch_reloc(lb->label_ptr[0], R_390_PC16DBL,
-                     (intptr_t)s->code_ptr, 2)) {
+                     (intptr_t)tcg_splitwx_to_rx(s->code_ptr), 2)) {
         return false;
     }
 
@@ -1766,7 +1753,8 @@ static inline void tcg_out_op(TCGContext *s, TCGOpcode opc,
     case INDEX_op_goto_tb:
         a0 = args[0];
         if (s->tb_jmp_insn_offset) {
-            /* branch displacement must be aligned for atomic patching;
+            /*
+             * branch displacement must be aligned for atomic patching;
              * see if we need to add extra nop before branch
              */
             if (!QEMU_PTR_IS_ALIGNED(s->code_ptr + 1, 4)) {
@@ -1779,7 +1767,7 @@ static inline void tcg_out_op(TCGContext *s, TCGOpcode opc,
         } else {
             /* load address stored at s->tb_jmp_target_addr + a0 */
             tcg_out_ld_abs(s, TCG_TYPE_PTR, TCG_REG_TB,
-                           s->tb_jmp_target_addr + a0);
+                           tcg_splitwx_to_rx(s->tb_jmp_target_addr + a0));
             /* and go there */
             tcg_out_insn(s, RR, BCR, S390_CC_ALWAYS, TCG_REG_TB);
         }
@@ -1789,8 +1777,10 @@ static inline void tcg_out_op(TCGContext *s, TCGOpcode opc,
            TCG_REG_TB to the beginning of this TB.  */
         if (USE_REG_TB) {
             int ofs = -tcg_current_code_size(s);
-            assert(ofs == (int16_t)ofs);
-            tcg_out_insn(s, RI, AGHI, TCG_REG_TB, ofs);
+            /* All TB are restricted to 64KiB by unwind info. */
+            tcg_debug_assert(ofs == sextract64(ofs, 0, 20));
+            tcg_out_insn(s, RXY, LAY, TCG_REG_TB,
+                         TCG_REG_TB, TCG_REG_NONE, ofs);
         }
         break;
 
@@ -2561,11 +2551,12 @@ static void tcg_target_qemu_prologue(TCGContext *s)
      * Return path for goto_ptr. Set return value to 0, a-la exit_tb,
      * and fall through to the rest of the epilogue.
      */
-    tcg_code_gen_epilogue = s->code_ptr;
+    /* TODO: Cast goes away when all hosts converted */
+    tcg_code_gen_epilogue = (void *)tcg_splitwx_to_rx(s->code_ptr);
     tcg_out_movi(s, TCG_TYPE_PTR, TCG_REG_R2, 0);
 
     /* TB epilogue */
-    tb_ret_addr = s->code_ptr;
+    tb_ret_addr = tcg_splitwx_to_rx(s->code_ptr);
 
     /* lmg %r6,%r15,fs+48(%r15) (restore registers) */
     tcg_out_insn(s, RXY, LMG, TCG_REG_R6, TCG_REG_R15, TCG_REG_R15,
-- 
2.25.1


