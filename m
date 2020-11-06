Return-Path: <SRS0=tv2o=EM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DC84C4742C
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 03:38:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6FCB20729
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 03:38:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tcTpOl35"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6FCB20729
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46750 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kasZf-0008F9-MS
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 22:38:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47404)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kasSK-0005pL-Lf
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 22:30:28 -0500
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:37594)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kasSC-0007Dj-NX
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 22:30:28 -0500
Received: by mail-pf1-x441.google.com with SMTP id 13so53329pfy.4
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2020 19:30:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=LiVRLDdLRLwNh3EAfOwsqGZsrXFOtm3LiOx00UdIraE=;
 b=tcTpOl35MRMenBDQkroMiOrRPcQ6qceMjXWca0iYK4BIhZmRmUrP8nIcZG4dmxKycs
 GugXJOEn0a+xOEVnILgLEQ7KRBxhusgEr5l9lxkdueh7/CyDfWk3jEroSXsxgHgyPAsD
 C16goSeskUZOQDsQ25y2Mr91ykRSpv7zVEF6/HK8t5JXdeAJU2NiADJHEO0L+6RRZxab
 qwhwcQa/+Yu55WMj+xXPtPnn4FwhjxE1Q55/OlBHr/D8Ni8worQR5fm7Hfd3A9u0LWw/
 9UODj+w8buq2XD4dnU11qZAhUrfRI+Lvct5G4qdgdUV7XgzrXIbs4FdYKEHKHpUCfkGb
 MzeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=LiVRLDdLRLwNh3EAfOwsqGZsrXFOtm3LiOx00UdIraE=;
 b=sNkIalUcgakOG44XplLEt2BytRkKXwH46oC3EmDtDxbKX8w8eUFN6XYoE2rLODL9j4
 OF8oa+FFQypOIYjRnl1Ww6U2+eVOv/oYpimAajOzvWiEzU7JoYej5yNdfDymS0Am6tnN
 wwYhjcLTUbx6n5ndyfQ1xFhGufDZpKFX7p7ku+3v8zc4hV1cZcD43A/iy9UUZkey8uWg
 UlTTeVp+oGgJbC9i8NsTY4X0sCe4ul9+UfifZP20DMlAa/2BFtTCMwZF18vTOVzbOM6O
 kouU5cYKU4gY9D8HVcrhQdJq/Kn68A/9VDt/sYFEQD+S7HQz156NVqWmj5FmRHpNgvFp
 5XUQ==
X-Gm-Message-State: AOAM53003nOOiuKpHGSZO3Lp9lYtNpn8nlcupjtn2bqs6ZjjclsPWwx+
 57AUgLC0l4THQcTx7LDTKZMwZbfJgyl/Gw==
X-Google-Smtp-Source: ABdhPJz07sfqL3/tvzipxS1AKbfibmdlgwErkVdnQEUQ4Uv9hAI1TJo9OE5USOBeR+sBglGFP1ky0w==
X-Received: by 2002:a17:90a:17ad:: with SMTP id
 q42mr189826pja.36.1604633409703; 
 Thu, 05 Nov 2020 19:30:09 -0800 (PST)
Received: from localhost.localdomain (76-14-210-194.or.wavecable.com.
 [76.14.210.194])
 by smtp.gmail.com with ESMTPSA id i10sm40773pfd.60.2020.11.05.19.30.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2020 19:30:08 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 33/41] tcg/riscv: Remove branch-over-branch fallback
Date: Thu,  5 Nov 2020 19:29:13 -0800
Message-Id: <20201106032921.600200-34-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201106032921.600200-1-richard.henderson@linaro.org>
References: <20201106032921.600200-1-richard.henderson@linaro.org>
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

Since 7ecd02a06f8, we are prepared to re-start code generation
with a smaller TB if a relocation is out of range.  We no longer
need to leave a nop in the stream Just In Case.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/riscv/tcg-target.c.inc | 56 ++++----------------------------------
 1 file changed, 6 insertions(+), 50 deletions(-)

diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
index 195c3eff03..02beb86977 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -469,43 +469,16 @@ static bool reloc_call(tcg_insn_unit *code_ptr, const tcg_insn_unit *target)
 static bool patch_reloc(tcg_insn_unit *code_ptr, int type,
                         intptr_t value, intptr_t addend)
 {
-    uint32_t insn = *code_ptr;
-    intptr_t diff;
-    bool short_jmp;
-
     tcg_debug_assert(addend == 0);
-
     switch (type) {
     case R_RISCV_BRANCH:
-        diff = value - (uintptr_t)code_ptr;
-        short_jmp = diff == sextreg(diff, 0, 12);
-        if (short_jmp) {
-            return reloc_sbimm12(code_ptr, (tcg_insn_unit *)value);
-        } else {
-            /* Invert the condition */
-            insn = insn ^ (1 << 12);
-            /* Clear the offset */
-            insn &= 0x01fff07f;
-            /* Set the offset to the PC + 8 */
-            insn |= encode_sbimm12(8);
-
-            /* Move forward */
-            code_ptr[0] = insn;
-
-            /* Overwrite the NOP with jal x0,value */
-            diff = value - (uintptr_t)(code_ptr + 1);
-            insn = encode_uj(OPC_JAL, TCG_REG_ZERO, diff);
-            code_ptr[1] = insn;
-
-            return true;
-        }
-        break;
+        return reloc_sbimm12(code_ptr, (tcg_insn_unit *)value);
     case R_RISCV_JAL:
         return reloc_jimm20(code_ptr, (tcg_insn_unit *)value);
     case R_RISCV_CALL:
         return reloc_call(code_ptr, (tcg_insn_unit *)value);
     default:
-        tcg_abort();
+        g_assert_not_reached();
     }
 }
 
@@ -779,21 +752,8 @@ static void tcg_out_brcond(TCGContext *s, TCGCond cond, TCGReg arg1,
         arg2 = t;
     }
 
-    if (l->has_value) {
-        intptr_t diff = tcg_pcrel_diff(s, l->u.value_ptr);
-        if (diff == sextreg(diff, 0, 12)) {
-            tcg_out_opc_branch(s, op, arg1, arg2, diff);
-        } else {
-            /* Invert the conditional branch.  */
-            tcg_out_opc_branch(s, op ^ (1 << 12), arg1, arg2, 8);
-            tcg_out_opc_jump(s, OPC_JAL, TCG_REG_ZERO, diff - 4);
-        }
-    } else {
-        tcg_out_reloc(s, s->code_ptr, R_RISCV_BRANCH, l, 0);
-        tcg_out_opc_branch(s, op, arg1, arg2, 0);
-        /* NOP to allow patching later */
-        tcg_out_opc_imm(s, OPC_ADDI, TCG_REG_ZERO, TCG_REG_ZERO, 0);
-    }
+    tcg_out_reloc(s, s->code_ptr, R_RISCV_BRANCH, l, 0);
+    tcg_out_opc_branch(s, op, arg1, arg2, 0);
 }
 
 static void tcg_out_setcond(TCGContext *s, TCGCond cond, TCGReg ret,
@@ -1009,8 +969,6 @@ static void tcg_out_tlb_load(TCGContext *s, TCGReg addrl,
     /* Compare masked address with the TLB entry. */
     label_ptr[0] = s->code_ptr;
     tcg_out_opc_branch(s, OPC_BNE, TCG_REG_TMP0, TCG_REG_TMP1, 0);
-    /* NOP to allow patching later */
-    tcg_out_opc_imm(s, OPC_ADDI, TCG_REG_ZERO, TCG_REG_ZERO, 0);
 
     /* TLB Hit - translate address using addend.  */
     if (TCG_TARGET_REG_BITS > TARGET_LONG_BITS) {
@@ -1054,8 +1012,7 @@ static bool tcg_out_qemu_ld_slow_path(TCGContext *s, TCGLabelQemuLdst *l)
     }
 
     /* resolve label address */
-    if (!patch_reloc(l->label_ptr[0], R_RISCV_BRANCH,
-                     (intptr_t) s->code_ptr, 0)) {
+    if (!reloc_sbimm12(l->label_ptr[0], s->code_ptr)) {
         return false;
     }
 
@@ -1089,8 +1046,7 @@ static bool tcg_out_qemu_st_slow_path(TCGContext *s, TCGLabelQemuLdst *l)
     }
 
     /* resolve label address */
-    if (!patch_reloc(l->label_ptr[0], R_RISCV_BRANCH,
-                     (intptr_t) s->code_ptr, 0)) {
+    if (!reloc_sbimm12(l->label_ptr[0], s->code_ptr)) {
         return false;
     }
 
-- 
2.25.1


