Return-Path: <SRS0=tv2o=EM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65B91C2D0A3
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 03:52:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2BE420756
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 03:52:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mwiMtw+l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2BE420756
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42702 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaso4-0004Zp-OE
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 22:52:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47352)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kasSH-0005gg-3H
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 22:30:25 -0500
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:35355)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kasSC-0007Gu-On
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 22:30:24 -0500
Received: by mail-pf1-x442.google.com with SMTP id g7so61102pfc.2
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2020 19:30:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=9/TRkK1ohPG7NzFVdGar1E3FliGdhxt5t+NNXefLhVw=;
 b=mwiMtw+lFgR/O0zFthRkLlkc6VdyBFETItDbjPnbZv5EDLYGkfx7E9IKMknuaghZAE
 oR2PEuwR6CqcOxU+Ydivn2j6Y0zen0lrIDDnORUR89fAmQX1ken3at/Jfp8lfMaCr9XX
 IK/G7ZUMoQvzn73Mf4EueRPdnXCA1ui32LSICTMa+x3VKNjBVvNsQ2QEzmsGql6uZM9d
 SWxNgw6osY3ZwPOVrIPyD3J6sPgExQkpp9LLXb1hMAyCJTQQBgEQ0iMtK/Z5gcJrw+nA
 Ha3jn/wDT9Iwa3A1NpLxPEnBGFGUhN98jqSc1HIRm6simJIdGOuyGu1dl2Ue40+UgleC
 kwAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=9/TRkK1ohPG7NzFVdGar1E3FliGdhxt5t+NNXefLhVw=;
 b=OBX+URQLe+jsVbC5NvlKBwDiKcJnoxKEg00bRmK2Jm9fRrny3xx7AIEus34rQPIFh+
 oNGqpurd+wJWsr3oXPJg1iQiXdwgWK2JH5ZVdrpbzgrD2UfmFNeFew8RKUpAtnbQSsSk
 gkMdIgFidDUy7mHxHznz7K0qBItdMxroItHctFTRw1c7Xnb9HYBCJ/+0BHF5wdnSIFiY
 9NG7dMxoep6lwfyqQ8apDD/jq/qM4BWlotiFXq/4K8g5+MkgXvmYu1yjA/B9xfd13zuw
 z7n9pnBhB++yRTnBlnbhqUoVGQSpxVfARo28QlfNgz9Dex9shkrk21dzPYNT75Na8dmY
 YkZg==
X-Gm-Message-State: AOAM530hP32Y7D2XWOOgcImaoie6VawHHPq7vGQxqix1RmKP3LbGtw6j
 +DRdJ+tPoaNgoIAy2fcsWAywVV5kfbY/RA==
X-Google-Smtp-Source: ABdhPJxYmFL/86db9Ukr4SZl1iUX+UJeI//C8EnzkJI74D167lON3to7kQZMxyiyJ/JPzawOs7PsPA==
X-Received: by 2002:a17:90a:c201:: with SMTP id e1mr180377pjt.16.1604633416671; 
 Thu, 05 Nov 2020 19:30:16 -0800 (PST)
Received: from localhost.localdomain (76-14-210-194.or.wavecable.com.
 [76.14.210.194])
 by smtp.gmail.com with ESMTPSA id i10sm40773pfd.60.2020.11.05.19.30.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2020 19:30:15 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 36/41] tcg/mips: Do not assert on relocation overflow
Date: Thu,  5 Nov 2020 19:29:16 -0800
Message-Id: <20201106032921.600200-37-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201106032921.600200-1-richard.henderson@linaro.org>
References: <20201106032921.600200-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::442;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x442.google.com
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

This target was not updated with 7ecd02a06f8, and so did
not allow re-compilation with relocation overflow.

Remove reloc_26 and reloc_26_val as unused.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/mips/tcg-target.c.inc | 53 ++++++++++++++-------------------------
 1 file changed, 19 insertions(+), 34 deletions(-)

diff --git a/tcg/mips/tcg-target.c.inc b/tcg/mips/tcg-target.c.inc
index 52638e920c..37faf1356c 100644
--- a/tcg/mips/tcg-target.c.inc
+++ b/tcg/mips/tcg-target.c.inc
@@ -144,29 +144,15 @@ static tcg_insn_unit *bswap32_addr;
 static tcg_insn_unit *bswap32u_addr;
 static tcg_insn_unit *bswap64_addr;
 
-static inline uint32_t reloc_pc16_val(tcg_insn_unit *pc,
-                                      const tcg_insn_unit *target)
+static bool reloc_pc16(tcg_insn_unit *pc, const tcg_insn_unit *target)
 {
     /* Let the compiler perform the right-shift as part of the arithmetic.  */
     ptrdiff_t disp = target - (pc + 1);
-    tcg_debug_assert(disp == (int16_t)disp);
-    return disp & 0xffff;
-}
-
-static inline void reloc_pc16(tcg_insn_unit *pc, const tcg_insn_unit *target)
-{
-    *pc = deposit32(*pc, 0, 16, reloc_pc16_val(pc, target));
-}
-
-static inline uint32_t reloc_26_val(tcg_insn_unit *pc, tcg_insn_unit *target)
-{
-    tcg_debug_assert((((uintptr_t)pc ^ (uintptr_t)target) & 0xf0000000) == 0);
-    return ((uintptr_t)target >> 2) & 0x3ffffff;
-}
-
-static inline void reloc_26(tcg_insn_unit *pc, tcg_insn_unit *target)
-{
-    *pc = deposit32(*pc, 0, 26, reloc_26_val(pc, target));
+    if (disp == (int16_t)disp) {
+        *pc = deposit32(*pc, 0, 16, disp);
+        return true;
+    }
+    return false;
 }
 
 static bool patch_reloc(tcg_insn_unit *code_ptr, int type,
@@ -174,8 +160,7 @@ static bool patch_reloc(tcg_insn_unit *code_ptr, int type,
 {
     tcg_debug_assert(type == R_MIPS_PC16);
     tcg_debug_assert(addend == 0);
-    reloc_pc16(code_ptr, (tcg_insn_unit *)value);
-    return true;
+    return reloc_pc16(code_ptr, (const tcg_insn_unit *)value);
 }
 
 #define TCG_CT_CONST_ZERO 0x100
@@ -925,11 +910,7 @@ static void tcg_out_brcond(TCGContext *s, TCGCond cond, TCGReg arg1,
     }
 
     tcg_out_opc_br(s, b_opc, arg1, arg2);
-    if (l->has_value) {
-        reloc_pc16(s->code_ptr - 1, l->u.value_ptr);
-    } else {
-        tcg_out_reloc(s, s->code_ptr - 1, R_MIPS_PC16, l, 0);
-    }
+    tcg_out_reloc(s, s->code_ptr - 1, R_MIPS_PC16, l, 0);
     tcg_out_nop(s);
 }
 
@@ -1316,9 +1297,10 @@ static bool tcg_out_qemu_ld_slow_path(TCGContext *s, TCGLabelQemuLdst *l)
     int i;
 
     /* resolve label address */
-    reloc_pc16(l->label_ptr[0], s->code_ptr);
-    if (TCG_TARGET_REG_BITS < TARGET_LONG_BITS) {
-        reloc_pc16(l->label_ptr[1], s->code_ptr);
+    if (!reloc_pc16(l->label_ptr[0], s->code_ptr)
+        || (TCG_TARGET_REG_BITS < TARGET_LONG_BITS
+            && !reloc_pc16(l->label_ptr[1], s->code_ptr))) {
+        return false;
     }
 
     i = 1;
@@ -1346,7 +1328,9 @@ static bool tcg_out_qemu_ld_slow_path(TCGContext *s, TCGLabelQemuLdst *l)
     }
 
     tcg_out_opc_br(s, OPC_BEQ, TCG_REG_ZERO, TCG_REG_ZERO);
-    reloc_pc16(s->code_ptr - 1, l->raddr);
+    if (!reloc_pc16(s->code_ptr - 1, l->raddr)) {
+        return false;
+    }
 
     /* delay slot */
     if (TCG_TARGET_REG_BITS == 64 && l->type == TCG_TYPE_I32) {
@@ -1366,9 +1350,10 @@ static bool tcg_out_qemu_st_slow_path(TCGContext *s, TCGLabelQemuLdst *l)
     int i;
 
     /* resolve label address */
-    reloc_pc16(l->label_ptr[0], s->code_ptr);
-    if (TCG_TARGET_REG_BITS < TARGET_LONG_BITS) {
-        reloc_pc16(l->label_ptr[1], s->code_ptr);
+    if (!reloc_pc16(l->label_ptr[0], s->code_ptr)
+        || (TCG_TARGET_REG_BITS < TARGET_LONG_BITS
+            && !reloc_pc16(l->label_ptr[1], s->code_ptr))) {
+        return false;
     }
 
     i = 1;
-- 
2.25.1


