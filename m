Return-Path: <SRS0=Y1tr=UJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86218C28EBD
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 02:47:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C101207E0
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 02:47:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NqkcScGM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C101207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39942 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1haALS-000123-Oa
	for qemu-devel@archiver.kernel.org; Sun, 09 Jun 2019 22:47:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53445)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1ha9eT-0006yy-F3
 for qemu-devel@nongnu.org; Sun, 09 Jun 2019 22:03:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ha9eR-000281-Fq
 for qemu-devel@nongnu.org; Sun, 09 Jun 2019 22:03:13 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:35214)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ha9eP-00024t-Bv
 for qemu-devel@nongnu.org; Sun, 09 Jun 2019 22:03:11 -0400
Received: by mail-pl1-x641.google.com with SMTP id p1so2996990plo.2
 for <qemu-devel@nongnu.org>; Sun, 09 Jun 2019 19:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=QijkDJtJCb3/ABVATHwY/gk3S5ygpJmh45wVvvS3fgY=;
 b=NqkcScGM4d/uvBM/Vx7fPMZN9A72FgbmP57fcjXm/qntEZHCZDEyVo0XYlGdHwaqw+
 +/IN7AOkfjozkFANSjRW48rZyylYP50EmAIJQ17VZehvvrTbK95csA4S3ENKsMU5nO9g
 wwUoFZ63cXnezVXwlXNlKKwOpg6icFyiWWKCIh2LJazLQgt7OBxhZTkVAJRl18fUwLbk
 4lBPgD1GbPF/a2MNsD3/8ogHvknu/e0npS29QEL0/LrM8vCYVR2jV6/oDtGnenCT3jHJ
 ZRJMJT9wyE9yWSYODLaOiFa421crrqF4JPNvRDRGSO3TU5UlY32SrZ48lTAt3/0ZKXke
 Ikhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=QijkDJtJCb3/ABVATHwY/gk3S5ygpJmh45wVvvS3fgY=;
 b=iGSNLsAzc1yVVXiOkDlHvSfN7WbGEHfRoRATheIjLZsOIFMA78Bd2rch64J1l8jTeR
 9Y4HSokmOo9XtHx7w3GgH22IDyTq7VDcaQZ8Ah1msmLno2xayfK4gIgofeOQGXQl6pcf
 J8wN+j73fAuyhCqngbG2I0CNRuBTbKEN7oizhfA+64F3MjYY4ka4hL+tqMTsun3gssOv
 S7rwDEZ3HUuhOOHqJ+nPJ/qJ3QW4JPHrm+XRfxR6ocsqcvaVrenWam4CGmSYWlUBIL5e
 rKNkN6CJhW9yN9Vi4Rp+nBgDUOlUFarNm5BR7+z+j2i8+gPOVbz0jfuGtPsCc8QZ7FY7
 HVNA==
X-Gm-Message-State: APjAAAWagKcIrhzyPTxlEKXL0PbZ2UHxjJ6WHreNGaN3Mt4p9448bOcT
 pcTf5/moXULnkup2kbxTgXITZ/hZYJI=
X-Google-Smtp-Source: APXvYqzqBrO3WQWYkqnm7z4Kmglrc16tWzQtyjz4A36I3bGgiHgL22UOgVGa7o/JRFd3BazaGVBv0w==
X-Received: by 2002:a17:902:42a5:: with SMTP id
 h34mr30518154pld.16.1560132186270; 
 Sun, 09 Jun 2019 19:03:06 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
 [97.113.13.231])
 by smtp.gmail.com with ESMTPSA id l63sm9749013pfl.181.2019.06.09.19.03.05
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 09 Jun 2019 19:03:05 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Sun,  9 Jun 2019 19:02:17 -0700
Message-Id: <20190610020218.9228-39-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190610020218.9228-1-richard.henderson@linaro.org>
References: <20190610020218.9228-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::641
Subject: [Qemu-devel] [PULL 38/39] tcg/arm: Use LDRD to load tlb mask+table
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This changes the code generation for the tlb from e.g.

	ldr      ip, [r6, #-0x10]
	ldr      r2, [r6, #-0xc]
	and      ip, ip, r4, lsr #8
	ldrd     r0, r1, [r2, ip]!
	ldr      r2, [r2, #0x18]

to

	ldrd     r0, r1, [r6, #-0x10]
	and      r0, r0, r4, lsr #8
	ldrd     r2, r3, [r1, r0]!
	ldr      r1, [r1, #0x18]

for armv7 hosts.  Rearranging the register allocation in
order to avoid overlap between the two ldrd pairs causes
the patch to be larger than it ordinarily would be.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/arm/tcg-target.inc.c | 92 +++++++++++++++++++++++-----------------
 1 file changed, 53 insertions(+), 39 deletions(-)

diff --git a/tcg/arm/tcg-target.inc.c b/tcg/arm/tcg-target.inc.c
index b066e30f0e..276e843627 100644
--- a/tcg/arm/tcg-target.inc.c
+++ b/tcg/arm/tcg-target.inc.c
@@ -267,6 +267,7 @@ static const char *target_parse_constraint(TCGArgConstraint *ct,
         tcg_regset_reset_reg(ct->u.regs, TCG_REG_R0);
         tcg_regset_reset_reg(ct->u.regs, TCG_REG_R1);
         tcg_regset_reset_reg(ct->u.regs, TCG_REG_R2);
+        tcg_regset_reset_reg(ct->u.regs, TCG_REG_R3);
         tcg_regset_reset_reg(ct->u.regs, TCG_REG_R14);
 #endif
         break;
@@ -1224,6 +1225,10 @@ static TCGReg tcg_out_arg_reg64(TCGContext *s, TCGReg argreg,
 QEMU_BUILD_BUG_ON(TLB_MASK_TABLE_OFS(0) > 0);
 QEMU_BUILD_BUG_ON(TLB_MASK_TABLE_OFS(0) < -256);
 
+/* These offsets are built into the LDRD below.  */
+QEMU_BUILD_BUG_ON(offsetof(CPUTLBDescFast, mask) != 0);
+QEMU_BUILD_BUG_ON(offsetof(CPUTLBDescFast, table) != 4);
+
 /* Load and compare a TLB entry, leaving the flags set.  Returns the register
    containing the addend of the tlb entry.  Clobbers R0, R1, R2, TMP.  */
 
@@ -1238,47 +1243,54 @@ static TCGReg tcg_out_tlb_read(TCGContext *s, TCGReg addrlo, TCGReg addrhi,
     unsigned s_bits = opc & MO_SIZE;
     unsigned a_bits = get_alignment_bits(opc);
 
-    /* Load tlb_mask[mmu_idx] and tlb_table[mmu_idx].  */
-    tcg_out_ld(s, TCG_TYPE_I32, TCG_REG_TMP, TCG_AREG0, mask_off);
-    tcg_out_ld(s, TCG_TYPE_I32, TCG_REG_R2, TCG_AREG0, table_off);
-
-    /* Extract the tlb index from the address into TMP.  */
-    tcg_out_dat_reg(s, COND_AL, ARITH_AND, TCG_REG_TMP, TCG_REG_TMP, addrlo,
-                    SHIFT_IMM_LSR(TARGET_PAGE_BITS - CPU_TLB_ENTRY_BITS));
-
     /*
-     * Add the tlb_table pointer, creating the CPUTLBEntry address in R2.
-     * Load the tlb comparator into R0/R1 and the fast path addend into R2.
+     * We don't support inline unaligned acceses, but we can easily
+     * support overalignment checks.
      */
-    if (cmp_off == 0) {
-	if (use_armv6_instructions && TARGET_LONG_BITS == 64) {
-            tcg_out_ldrd_rwb(s, COND_AL, TCG_REG_R0, TCG_REG_R2, TCG_REG_TMP);
-        } else {
-            tcg_out_ld32_rwb(s, COND_AL, TCG_REG_R0, TCG_REG_R2, TCG_REG_TMP);
-        }
-    } else {
-        tcg_out_dat_reg(s, COND_AL, ARITH_ADD,
-		        TCG_REG_R2, TCG_REG_R2, TCG_REG_TMP, 0);
-        if (use_armv6_instructions && TARGET_LONG_BITS == 64) {
-            tcg_out_ldrd_8(s, COND_AL, TCG_REG_R0, TCG_REG_R2, cmp_off);
-        } else {
-            tcg_out_ld32_12(s, COND_AL, TCG_REG_R0, TCG_REG_R2, cmp_off);
-	}
-    }
-    if (!use_armv6_instructions && TARGET_LONG_BITS == 64) {
-        tcg_out_ld32_12(s, COND_AL, TCG_REG_R1, TCG_REG_R2, cmp_off + 4);
-    }
-
-    /* Load the tlb addend.  */
-    tcg_out_ld32_12(s, COND_AL, TCG_REG_R2, TCG_REG_R2,
-                    offsetof(CPUTLBEntry, addend));
-
-    /* Check alignment.  We don't support inline unaligned acceses,
-       but we can easily support overalignment checks.  */
     if (a_bits < s_bits) {
         a_bits = s_bits;
     }
 
+    /* Load env_tlb(env)->f[mmu_idx].{mask,table} into {r0,r1}.  */
+    if (use_armv6_instructions) {
+        tcg_out_ldrd_8(s, COND_AL, TCG_REG_R0, TCG_AREG0, fast_off);
+    } else {
+        tcg_out_ld(s, TCG_TYPE_I32, TCG_REG_R0, TCG_AREG0, mask_off);
+        tcg_out_ld(s, TCG_TYPE_I32, TCG_REG_R1, TCG_AREG0, table_off);
+    }
+
+    /* Extract the tlb index from the address into R0.  */
+    tcg_out_dat_reg(s, COND_AL, ARITH_AND, TCG_REG_R0, TCG_REG_R0, addrlo,
+                    SHIFT_IMM_LSR(TARGET_PAGE_BITS - CPU_TLB_ENTRY_BITS));
+
+    /*
+     * Add the tlb_table pointer, creating the CPUTLBEntry address in R1.
+     * Load the tlb comparator into R2/R3 and the fast path addend into R1.
+     */
+    if (cmp_off == 0) {
+        if (use_armv6_instructions && TARGET_LONG_BITS == 64) {
+            tcg_out_ldrd_rwb(s, COND_AL, TCG_REG_R2, TCG_REG_R1, TCG_REG_R0);
+        } else {
+            tcg_out_ld32_rwb(s, COND_AL, TCG_REG_R2, TCG_REG_R1, TCG_REG_R0);
+        }
+    } else {
+        tcg_out_dat_reg(s, COND_AL, ARITH_ADD,
+                        TCG_REG_R1, TCG_REG_R1, TCG_REG_R0, 0);
+        if (use_armv6_instructions && TARGET_LONG_BITS == 64) {
+            tcg_out_ldrd_8(s, COND_AL, TCG_REG_R2, TCG_REG_R1, cmp_off);
+        } else {
+            tcg_out_ld32_12(s, COND_AL, TCG_REG_R2, TCG_REG_R1, cmp_off);
+        }
+    }
+    if (!use_armv6_instructions && TARGET_LONG_BITS == 64) {
+        tcg_out_ld32_12(s, COND_AL, TCG_REG_R3, TCG_REG_R1, cmp_off + 4);
+    }
+
+    /* Load the tlb addend.  */
+    tcg_out_ld32_12(s, COND_AL, TCG_REG_R1, TCG_REG_R1,
+                    offsetof(CPUTLBEntry, addend));
+
+    /* Check alignment, check comparators.  */
     if (use_armv7_instructions) {
         tcg_target_ulong mask = ~(TARGET_PAGE_MASK | ((1 << a_bits) - 1));
         int rot = encode_imm(mask);
@@ -1291,22 +1303,24 @@ static TCGReg tcg_out_tlb_read(TCGContext *s, TCGReg addrlo, TCGReg addrhi,
             tcg_out_dat_reg(s, COND_AL, ARITH_BIC, TCG_REG_TMP,
                             addrlo, TCG_REG_TMP, 0);
         }
-        tcg_out_dat_reg(s, COND_AL, ARITH_CMP, 0, TCG_REG_R0, TCG_REG_TMP, 0);
+        tcg_out_dat_reg(s, COND_AL, ARITH_CMP, 0, TCG_REG_R2, TCG_REG_TMP, 0);
     } else {
         if (a_bits) {
             tcg_out_dat_imm(s, COND_AL, ARITH_TST, 0, addrlo,
                             (1 << a_bits) - 1);
         }
+        tcg_out_dat_reg(s, COND_AL, ARITH_MOV, TCG_REG_TMP, 0, addrlo,
+                        SHIFT_IMM_LSR(TARGET_PAGE_BITS));
         tcg_out_dat_reg(s, (a_bits ? COND_EQ : COND_AL), ARITH_CMP,
-                        0, TCG_REG_R0, TCG_REG_TMP,
+                        0, TCG_REG_R2, TCG_REG_TMP,
                         SHIFT_IMM_LSL(TARGET_PAGE_BITS));
     }
 
     if (TARGET_LONG_BITS == 64) {
-        tcg_out_dat_reg(s, COND_EQ, ARITH_CMP, 0, TCG_REG_R1, addrhi, 0);
+        tcg_out_dat_reg(s, COND_EQ, ARITH_CMP, 0, TCG_REG_R3, addrhi, 0);
     }
 
-    return TCG_REG_R2;
+    return TCG_REG_R1;
 }
 
 /* Record the context of a call to the out of line helper code for the slow
-- 
2.17.1


