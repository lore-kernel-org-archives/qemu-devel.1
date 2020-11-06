Return-Path: <SRS0=tv2o=EM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00412C2D0A3
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 03:56:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40886206CB
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 03:56:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JLR5C7+E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40886206CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51698 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kasrP-0008Mv-86
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 22:56:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47440)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kasSM-0005uQ-VM
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 22:30:31 -0500
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d]:42641)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kasSE-0007IK-5L
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 22:30:30 -0500
Received: by mail-pf1-x42d.google.com with SMTP id x13so36544pfa.9
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2020 19:30:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=pyQvpP38RVhGXRmBv3wfEHupXT2MMazBgzWEsDRUfoQ=;
 b=JLR5C7+EAwPEZG5nWaVNoPTsoCXLWB2ZYMvL787b4igdjEUjJPfJqy16Fr33TbcLcq
 jMMIV8o5NRBo/9u1Bj7vbHfGn/kF4pfweysVOyoAp4zJ/1rs2XIx3oVP/yi2GSs5iIOM
 A7CjHbBu2G1UNIwu9SwfSSTcOetMMCskOzlVPigQVYusFgfmYh8ikD0sw6BhjQHOPnky
 JBiEHW6NpiKA943GbbqQU66f+Re3FPUIOMaTCC/fgzlEG6PKC2jKsy7YBvAdh4PJ1nF+
 g8XWb3XCXiICqtzk1FLiSngAEZ1UHbDKVfiB5hNYa6MnkZHgQFjDWglYBb5tFyT6P40f
 KisA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=pyQvpP38RVhGXRmBv3wfEHupXT2MMazBgzWEsDRUfoQ=;
 b=CbhzFi7xNQ5ePYQFZ4H/3MyuuhgRMb4ZWyPjQ+oUm2SOCw37L1y/NipyXPTpz66yFr
 k3QVLFORoktJhc3XOcGo5i9T8fJ7Hr1EAiXGfHzcBgHU/cvzY0exOnSSvVwJ7NZYDM5l
 G/OyaXB8RS5F2te9CsMghn8AWPf+tVsxHXikIjM/DENh0PR7DvGRg+x9/zB3eKrVIBiM
 xUB7thYDTBjiz6+NomTwlCHeX76ahoOMIrm3mfwZatNQo6uc0z70mdGk2Cp18syXbrfj
 po88TWAt9WlUqtRUmWKMQPTxGqkmacOR1TPWmIFN2yPncwzvYAa7AoPe8enh4yno2st0
 CoYA==
X-Gm-Message-State: AOAM532Q6gzrFD9x5KR6Cmn2qHsIuQBnsKV0mp9AZBUv82EcBSxQQV8Y
 QSNyA6FaWzyTt8UA3CAsQqQkD/ulBVYzPg==
X-Google-Smtp-Source: ABdhPJwiE4CZ/OCZ8oQLIB56S2XhpWkjLdqwm4sxEYHnLhgB3uP19kLRYZkbuIUpcKyMVgDPuaAFqA==
X-Received: by 2002:a63:1262:: with SMTP id 34mr5151712pgs.452.1604633420301; 
 Thu, 05 Nov 2020 19:30:20 -0800 (PST)
Received: from localhost.localdomain (76-14-210-194.or.wavecable.com.
 [76.14.210.194])
 by smtp.gmail.com with ESMTPSA id i10sm40773pfd.60.2020.11.05.19.30.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2020 19:30:19 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 38/41] tcg/arm: Support split-wx code generation
Date: Thu,  5 Nov 2020 19:29:18 -0800
Message-Id: <20201106032921.600200-39-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201106032921.600200-1-richard.henderson@linaro.org>
References: <20201106032921.600200-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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
 tcg/arm/tcg-target.h     |  2 +-
 tcg/arm/tcg-target.c.inc | 37 +++++++++++++++++++++----------------
 2 files changed, 22 insertions(+), 17 deletions(-)

diff --git a/tcg/arm/tcg-target.h b/tcg/arm/tcg-target.h
index e355d6a4b2..17f6be9cfc 100644
--- a/tcg/arm/tcg-target.h
+++ b/tcg/arm/tcg-target.h
@@ -150,6 +150,6 @@ void tb_target_set_jmp_target(uintptr_t, uintptr_t, uintptr_t, uintptr_t);
 #define TCG_TARGET_NEED_LDST_LABELS
 #endif
 #define TCG_TARGET_NEED_POOL_LABELS
-#define TCG_TARGET_SUPPORT_MIRROR       0
+#define TCG_TARGET_SUPPORT_MIRROR       1
 
 #endif
diff --git a/tcg/arm/tcg-target.c.inc b/tcg/arm/tcg-target.c.inc
index 9b9400f164..3d2717aeb0 100644
--- a/tcg/arm/tcg-target.c.inc
+++ b/tcg/arm/tcg-target.c.inc
@@ -187,29 +187,32 @@ static const uint8_t tcg_cond_to_arm_cond[] = {
     [TCG_COND_GTU] = COND_HI,
 };
 
-static inline bool reloc_pc24(tcg_insn_unit *code_ptr, tcg_insn_unit *target)
+static bool reloc_pc24(tcg_insn_unit *src_rw, const tcg_insn_unit *target)
 {
-    ptrdiff_t offset = (tcg_ptr_byte_diff(target, code_ptr) - 8) >> 2;
+    const tcg_insn_unit *src_rx = tcg_splitwx_to_rx(src_rw);
+    ptrdiff_t offset = (tcg_ptr_byte_diff(target, src_rx) - 8) >> 2;
+
     if (offset == sextract32(offset, 0, 24)) {
-        *code_ptr = (*code_ptr & ~0xffffff) | (offset & 0xffffff);
+        *src_rw = deposit32(*src_rw, 0, 24, offset);
         return true;
     }
     return false;
 }
 
-static inline bool reloc_pc13(tcg_insn_unit *code_ptr, tcg_insn_unit *target)
+static bool reloc_pc13(tcg_insn_unit *src_rw, const tcg_insn_unit *target)
 {
-    ptrdiff_t offset = tcg_ptr_byte_diff(target, code_ptr) - 8;
+    const tcg_insn_unit *src_rx = tcg_splitwx_to_rx(src_rw);
+    ptrdiff_t offset = tcg_ptr_byte_diff(target, src_rx) - 8;
 
     if (offset >= -0xfff && offset <= 0xfff) {
-        tcg_insn_unit insn = *code_ptr;
+        tcg_insn_unit insn = *src_rw;
         bool u = (offset >= 0);
         if (!u) {
             offset = -offset;
         }
         insn = deposit32(insn, 23, 1, u);
         insn = deposit32(insn, 0, 12, offset);
-        *code_ptr = insn;
+        *src_rw = insn;
         return true;
     }
     return false;
@@ -221,9 +224,9 @@ static bool patch_reloc(tcg_insn_unit *code_ptr, int type,
     tcg_debug_assert(addend == 0);
 
     if (type == R_ARM_PC24) {
-        return reloc_pc24(code_ptr, (tcg_insn_unit *)value);
+        return reloc_pc24(code_ptr, (const tcg_insn_unit *)value);
     } else if (type == R_ARM_PC13) {
-        return reloc_pc13(code_ptr, (tcg_insn_unit *)value);
+        return reloc_pc13(code_ptr, (const tcg_insn_unit *)value);
     } else {
         g_assert_not_reached();
     }
@@ -617,7 +620,7 @@ static void tcg_out_movi32(TCGContext *s, int cond, int rd, uint32_t arg)
 
     /* Check for a pc-relative address.  This will usually be the TB,
        or within the TB, which is immediately before the code block.  */
-    diff = arg - ((intptr_t)s->code_ptr + 8);
+    diff = tcg_pcrel_diff(s, (void *)arg) - 8;
     if (diff >= 0) {
         rot = encode_imm(diff);
         if (rot >= 0) {
@@ -1337,7 +1340,8 @@ static void add_qemu_ldst_label(TCGContext *s, bool is_ld, TCGMemOpIdx oi,
     label->datahi_reg = datahi;
     label->addrlo_reg = addrlo;
     label->addrhi_reg = addrhi;
-    label->raddr = raddr;
+    /* TODO: Cast goes away when all hosts converted */
+    label->raddr = (void *)tcg_splitwx_to_rx(raddr);
     label->label_ptr[0] = label_ptr;
 }
 
@@ -1348,7 +1352,7 @@ static bool tcg_out_qemu_ld_slow_path(TCGContext *s, TCGLabelQemuLdst *lb)
     MemOp opc = get_memop(oi);
     void *func;
 
-    if (!reloc_pc24(lb->label_ptr[0], s->code_ptr)) {
+    if (!reloc_pc24(lb->label_ptr[0], tcg_splitwx_to_rx(s->code_ptr))) {
         return false;
     }
 
@@ -1411,7 +1415,7 @@ static bool tcg_out_qemu_st_slow_path(TCGContext *s, TCGLabelQemuLdst *lb)
     TCGMemOpIdx oi = lb->oi;
     MemOp opc = get_memop(oi);
 
-    if (!reloc_pc24(lb->label_ptr[0], s->code_ptr)) {
+    if (!reloc_pc24(lb->label_ptr[0], tcg_splitwx_to_rx(s->code_ptr))) {
         return false;
     }
 
@@ -1762,8 +1766,8 @@ static inline void tcg_out_op(TCGContext *s, TCGOpcode opc,
             TCGReg base = TCG_REG_PC;
 
             tcg_debug_assert(s->tb_jmp_insn_offset == 0);
-            ptr = (intptr_t)(s->tb_jmp_target_addr + args[0]);
-            dif = ptr - ((intptr_t)s->code_ptr + 8);
+            ptr = (intptr_t)tcg_splitwx_to_rx(s->tb_jmp_target_addr + args[0]);
+            dif = tcg_pcrel_diff(s, (void *)ptr) - 8;
             dil = sextract32(dif, 0, 12);
             if (dif != dil) {
                 /* The TB is close, but outside the 12 bits addressable by
@@ -2297,7 +2301,8 @@ static void tcg_target_qemu_prologue(TCGContext *s)
      * Return path for goto_ptr. Set return value to 0, a-la exit_tb,
      * and fall through to the rest of the epilogue.
      */
-    tcg_code_gen_epilogue = s->code_ptr;
+    /* TODO: Cast goes away when all hosts converted */
+    tcg_code_gen_epilogue = (void *)tcg_splitwx_to_rx(s->code_ptr);
     tcg_out_movi(s, TCG_TYPE_PTR, TCG_REG_R0, 0);
     tcg_out_epilogue(s);
 }
-- 
2.25.1


