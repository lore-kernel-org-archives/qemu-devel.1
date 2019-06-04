Return-Path: <SRS0=GUf1=UD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D731EC282CE
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 21:08:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CF5B2070B
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 21:08:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wjeWu0IJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CF5B2070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58152 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYGfa-0003r5-TN
	for qemu-devel@archiver.kernel.org; Tue, 04 Jun 2019 17:08:34 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36147)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hYG95-0001iH-9c
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 16:35:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hYG93-00051E-Q2
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 16:34:59 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:39555)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hYG93-0004tW-Hg
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 16:34:57 -0400
Received: by mail-ot1-x343.google.com with SMTP id r21so8385618otq.6
	for <qemu-devel@nongnu.org>; Tue, 04 Jun 2019 13:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=553hxqrDAaVUQC3lJivdSjvTJknfLBkowACUKjkFIKU=;
	b=wjeWu0IJC5u7+vcq3j0z0KP4aryrXTRGdY8nNyfuZqKfy2D/7kVgHZbuU7gcivqK2n
	czElBpzY8iwiVD5LZfsHBtcClPqme90IJEKbhj/fsSVlhJeAuCEaWFT8eE9uXcg8Pmz0
	2W9WeCu+843JxGIxDraFqUsVacLwouaMZyO9RCTvVWVo3mlwPgYxjPYATDL1GGU524Lo
	znDkc2PJvErHpapnI0WyKdr1PHJa1agkCnxEbUf5WXHYyUc+U6QIJJI1qkoOiesOxjto
	4iF5rNgAnq3rC/kv+5AaP7o0fEr2krTznwe5sgPJ9ik2xO7RARgEjc0qG0KiwraThFTX
	uWtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=553hxqrDAaVUQC3lJivdSjvTJknfLBkowACUKjkFIKU=;
	b=Nk/yFdujEN+sNiZNQSg/7krgtQBT9V3uFSavOn81A09gCk8xLswUa0Qp1B5Aq0wwZp
	kg/nJyoGM3xtQ5KVVz3+0KoiNLa6v4ScWkZptiyQtPNGqPrDO/t5cb/4t7YP/A+0181V
	DfcngexQQkWPD6X7Cnl75bOQKAMU7sy8uarvVa169nRqBvaZyOYMJM37Nqu/vYfum5aP
	B2gBdvBYycaLjXtbx//1yv9RP0nAkZbFHyk0BZcB2qDgqYglD7R0Mn7yYC1LFVZPHGiN
	SzvwFfd6lVbR3TdeQRRW7OsbIY68tY4zaiVnd4FghYebWH0ckylptx6lAQ4qFeEWDOSf
	oNHg==
X-Gm-Message-State: APjAAAVrF05sCYiBVRlizxpWsAh0KhR5nDYs6kdTa/YL8UgSCdWif1Ee
	PEi12wo4nvYahnF0r6Qxj3dStETMT3eYxw==
X-Google-Smtp-Source: APXvYqwqjgMy1EP0ZmcfaHcdA0RoRcSCmpIsvWsESoVRE7c/fa+vRKiXcefdEm4Y7C0sHJHSTzptlA==
X-Received: by 2002:a9d:27a4:: with SMTP id c33mr6481649otb.113.1559680492813; 
	Tue, 04 Jun 2019 13:34:52 -0700 (PDT)
Received: from localhost.localdomain (200-56-192-86-cable.cybercable.net.mx.
	[200.56.192.86])
	by smtp.gmail.com with ESMTPSA id h1sm5979901otj.78.2019.06.04.13.34.51
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 04 Jun 2019 13:34:52 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue,  4 Jun 2019 15:33:50 -0500
Message-Id: <20190604203351.27778-39-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190604203351.27778-1-richard.henderson@linaro.org>
References: <20190604203351.27778-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::343
Subject: [Qemu-devel] [PATCH v4 38/39] tcg/arm: Use LDRD to load tlb
 mask+table
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
v3: Add QEMU_BUILD_BUG_ON for mask/table ordering; comment fixes.
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


