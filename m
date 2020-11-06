Return-Path: <SRS0=tv2o=EM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2064EC388F7
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 03:31:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91D4D20729
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 03:31:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cRYekqJq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91D4D20729
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50342 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kasTi-0006XI-Fp
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 22:31:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46892)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kasRU-0004ZD-V7
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 22:29:36 -0500
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b]:46770)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kasRS-0006uo-5e
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 22:29:36 -0500
Received: by mail-pg1-x52b.google.com with SMTP id w4so2857680pgg.13
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2020 19:29:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=NKx3ODzfKfyLFKhuotqig5XnvxrUEP579TW7wok+x2w=;
 b=cRYekqJqe2olIYtTUCMZWetOAsanDiYM0ID1+I+63c6omdTq3Vxy2JxIpplIstpFUJ
 Goh8dGlJNfxwqMcmG1cIAjCRpjjgfV9Xa9LF3w06qLiIcu9aInfYBawy9eBZA/iv78LH
 SCQByACCFj/GMAWtqv275aM3K2IZIBYwe039iKKHs5xIlGW92XlhYukxXeHK/eix1/bt
 C4m/YKS0mvtK2ozS27kQ+0t4lr9orkN4aiO5ci+bMZX5UznxdmNT5l5GS2ZvfBgNQ4Bf
 MziFywqBRnhy4U+TZ5OY6n03KERieTVHCjCSEusbavZOTFYEZSlocPZ7cSpgXTlzQCXu
 EbUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=NKx3ODzfKfyLFKhuotqig5XnvxrUEP579TW7wok+x2w=;
 b=TtwgLgmT4YNficqpOhcNrP0518DU+KkNTZFaevbzvMzhZJBdQU/31cZf/E+v9mObSH
 T6SYJREuTKW3WNZDeKdZbpbTi/3yEezTOWTjOucHWQRsZztI2KfjPIX69T+cbWfV3Tdw
 wJ0rASmDRyGp9nk0mj3CgtuIiKcFezYu6wd022MdmESO7DBQiFpqe4zqqywtWbu13G4c
 dF8rKbiiAawBlYoFvtxQvN2cJuL5Uj0uIt3nyeaAwYgEtD268IOQ5fggHk80/aj9hfNo
 tmHkQEzVjITMwTAK2oYI4CcnvNl+5ghKmVHXX+cNsuK5NRswAU9AY1Inr0i1BJ3utxel
 PK5Q==
X-Gm-Message-State: AOAM531FlA2AtGb60xXCKwI8ZgAI/dlceb6y5kw9aVpQ84ddQfAtZeOS
 E6YchMq9qrFMfZyfehJu3aW1sN+U12p8fA==
X-Google-Smtp-Source: ABdhPJyh4Gj72zvchV5Bxd2HGyklejgSFomFYaBRH99EURI/r5LovaVIfWLeM2diaG1wsXsa20c+2Q==
X-Received: by 2002:a65:44cd:: with SMTP id g13mr5163196pgs.259.1604633372412; 
 Thu, 05 Nov 2020 19:29:32 -0800 (PST)
Received: from localhost.localdomain (76-14-210-194.or.wavecable.com.
 [76.14.210.194])
 by smtp.gmail.com with ESMTPSA id i10sm40773pfd.60.2020.11.05.19.29.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2020 19:29:31 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 07/41] tcg: Adjust tcg_out_call for const
Date: Thu,  5 Nov 2020 19:28:47 -0800
Message-Id: <20201106032921.600200-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201106032921.600200-1-richard.henderson@linaro.org>
References: <20201106032921.600200-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52b.google.com
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

We must change all targets at once, since all must match
the declaration in tcg.c.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg.c                    | 2 +-
 tcg/aarch64/tcg-target.c.inc | 2 +-
 tcg/arm/tcg-target.c.inc     | 2 +-
 tcg/i386/tcg-target.c.inc    | 4 ++--
 tcg/mips/tcg-target.c.inc    | 6 +++---
 tcg/ppc/tcg-target.c.inc     | 8 ++++----
 tcg/riscv/tcg-target.c.inc   | 6 +++---
 tcg/s390/tcg-target.c.inc    | 2 +-
 tcg/sparc/tcg-target.c.inc   | 4 ++--
 tcg/tci/tcg-target.c.inc     | 2 +-
 10 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/tcg/tcg.c b/tcg/tcg.c
index a88b314e97..d3eeea355c 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -148,7 +148,7 @@ static void tcg_out_st(TCGContext *s, TCGType type, TCGReg arg, TCGReg arg1,
                        intptr_t arg2);
 static bool tcg_out_sti(TCGContext *s, TCGType type, TCGArg val,
                         TCGReg base, intptr_t ofs);
-static void tcg_out_call(TCGContext *s, tcg_insn_unit *target);
+static void tcg_out_call(TCGContext *s, const tcg_insn_unit *target);
 static int tcg_target_const_match(tcg_target_long val, TCGType type,
                                   const TCGArgConstraint *arg_ct);
 #ifdef TCG_TARGET_NEED_LDST_LABELS
diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index 96dc9f4d0b..6d8152c468 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -1329,7 +1329,7 @@ static inline void tcg_out_callr(TCGContext *s, TCGReg reg)
     tcg_out_insn(s, 3207, BLR, reg);
 }
 
-static inline void tcg_out_call(TCGContext *s, tcg_insn_unit *target)
+static inline void tcg_out_call(TCGContext *s, const tcg_insn_unit *target)
 {
     ptrdiff_t offset = target - s->code_ptr;
     if (offset == sextract64(offset, 0, 26)) {
diff --git a/tcg/arm/tcg-target.c.inc b/tcg/arm/tcg-target.c.inc
index f8f485d807..a197e6bc45 100644
--- a/tcg/arm/tcg-target.c.inc
+++ b/tcg/arm/tcg-target.c.inc
@@ -1033,7 +1033,7 @@ static void tcg_out_goto(TCGContext *s, int cond, const tcg_insn_unit *addr)
 
 /* The call case is mostly used for helpers - so it's not unreasonable
  * for them to be beyond branch range */
-static void tcg_out_call(TCGContext *s, tcg_insn_unit *addr)
+static void tcg_out_call(TCGContext *s, const tcg_insn_unit *addr)
 {
     intptr_t addri = (intptr_t)addr;
     ptrdiff_t disp = tcg_pcrel_diff(s, addr);
diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index 424dd1cdcf..095553ce28 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -1591,7 +1591,7 @@ static void tcg_out_clz(TCGContext *s, int rexw, TCGReg dest, TCGReg arg1,
     }
 }
 
-static void tcg_out_branch(TCGContext *s, int call, tcg_insn_unit *dest)
+static void tcg_out_branch(TCGContext *s, int call, const tcg_insn_unit *dest)
 {
     intptr_t disp = tcg_pcrel_diff(s, dest) - 5;
 
@@ -1610,7 +1610,7 @@ static void tcg_out_branch(TCGContext *s, int call, tcg_insn_unit *dest)
     }
 }
 
-static inline void tcg_out_call(TCGContext *s, tcg_insn_unit *dest)
+static inline void tcg_out_call(TCGContext *s, const tcg_insn_unit *dest)
 {
     tcg_out_branch(s, 1, dest);
 }
diff --git a/tcg/mips/tcg-target.c.inc b/tcg/mips/tcg-target.c.inc
index a3f838fa51..6d2c369a85 100644
--- a/tcg/mips/tcg-target.c.inc
+++ b/tcg/mips/tcg-target.c.inc
@@ -517,7 +517,7 @@ static void tcg_out_opc_sa64(TCGContext *s, MIPSInsn opc1, MIPSInsn opc2,
  * Type jump.
  * Returns true if the branch was in range and the insn was emitted.
  */
-static bool tcg_out_opc_jmp(TCGContext *s, MIPSInsn opc, void *target)
+static bool tcg_out_opc_jmp(TCGContext *s, MIPSInsn opc, const void *target)
 {
     uintptr_t dest = (uintptr_t)target;
     uintptr_t from = (uintptr_t)s->code_ptr + 4;
@@ -1080,7 +1080,7 @@ static void tcg_out_movcond(TCGContext *s, TCGCond cond, TCGReg ret,
     }
 }
 
-static void tcg_out_call_int(TCGContext *s, tcg_insn_unit *arg, bool tail)
+static void tcg_out_call_int(TCGContext *s, const tcg_insn_unit *arg, bool tail)
 {
     /* Note that the ABI requires the called function's address to be
        loaded into T9, even if a direct branch is in range.  */
@@ -1098,7 +1098,7 @@ static void tcg_out_call_int(TCGContext *s, tcg_insn_unit *arg, bool tail)
     }
 }
 
-static void tcg_out_call(TCGContext *s, tcg_insn_unit *arg)
+static void tcg_out_call(TCGContext *s, const tcg_insn_unit *arg)
 {
     tcg_out_call_int(s, arg, false);
     tcg_out_nop(s);
diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index 8a0b20a86b..36129b976f 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -1106,7 +1106,7 @@ static void tcg_out_xori32(TCGContext *s, TCGReg dst, TCGReg src, uint32_t c)
     tcg_out_zori32(s, dst, src, c, XORI, XORIS);
 }
 
-static void tcg_out_b(TCGContext *s, int mask, tcg_insn_unit *target)
+static void tcg_out_b(TCGContext *s, int mask, const tcg_insn_unit *target)
 {
     ptrdiff_t disp = tcg_pcrel_diff(s, target);
     if (in_range_b(disp)) {
@@ -1762,13 +1762,13 @@ void tb_target_set_jmp_target(uintptr_t tc_ptr, uintptr_t jmp_addr,
     }
 }
 
-static void tcg_out_call(TCGContext *s, tcg_insn_unit *target)
+static void tcg_out_call(TCGContext *s, const tcg_insn_unit *target)
 {
 #ifdef _CALL_AIX
     /* Look through the descriptor.  If the branch is in range, and we
        don't have to spend too much effort on building the toc.  */
-    void *tgt = ((void **)target)[0];
-    uintptr_t toc = ((uintptr_t *)target)[1];
+    const void *tgt = ((const void * const *)target)[0];
+    uintptr_t toc = ((const uintptr_t *)target)[1];
     intptr_t diff = tcg_pcrel_diff(s, tgt);
 
     if (in_range_b(diff) && toc == (uint32_t)toc) {
diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
index ab08af7457..4416a93e1f 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -449,7 +449,7 @@ static bool reloc_jimm20(tcg_insn_unit *code_ptr, tcg_insn_unit *target)
     return false;
 }
 
-static bool reloc_call(tcg_insn_unit *code_ptr, tcg_insn_unit *target)
+static bool reloc_call(tcg_insn_unit *code_ptr, const tcg_insn_unit *target)
 {
     intptr_t offset = (intptr_t)target - (intptr_t)code_ptr;
     int32_t lo = sextreg(offset, 0, 12);
@@ -861,7 +861,7 @@ static inline void tcg_out_goto(TCGContext *s, tcg_insn_unit *target)
     tcg_out_opc_jump(s, OPC_JAL, TCG_REG_ZERO, offset);
 }
 
-static void tcg_out_call_int(TCGContext *s, tcg_insn_unit *arg, bool tail)
+static void tcg_out_call_int(TCGContext *s, const tcg_insn_unit *arg, bool tail)
 {
     TCGReg link = tail ? TCG_REG_ZERO : TCG_REG_RA;
     ptrdiff_t offset = tcg_pcrel_diff(s, arg);
@@ -888,7 +888,7 @@ static void tcg_out_call_int(TCGContext *s, tcg_insn_unit *arg, bool tail)
     }
 }
 
-static void tcg_out_call(TCGContext *s, tcg_insn_unit *arg)
+static void tcg_out_call(TCGContext *s, const tcg_insn_unit *arg)
 {
     tcg_out_call_int(s, arg, false);
 }
diff --git a/tcg/s390/tcg-target.c.inc b/tcg/s390/tcg-target.c.inc
index 1b5c4f0ab0..37f4dc4cfd 100644
--- a/tcg/s390/tcg-target.c.inc
+++ b/tcg/s390/tcg-target.c.inc
@@ -1415,7 +1415,7 @@ static void tgen_brcond(TCGContext *s, TCGType type, TCGCond c,
     tgen_branch(s, cc, l);
 }
 
-static void tcg_out_call(TCGContext *s, tcg_insn_unit *dest)
+static void tcg_out_call(TCGContext *s, const tcg_insn_unit *dest)
 {
     ptrdiff_t off = dest - s->code_ptr;
     if (off == (int32_t)off) {
diff --git a/tcg/sparc/tcg-target.c.inc b/tcg/sparc/tcg-target.c.inc
index 5b3bc91b05..1a40911660 100644
--- a/tcg/sparc/tcg-target.c.inc
+++ b/tcg/sparc/tcg-target.c.inc
@@ -840,7 +840,7 @@ static void tcg_out_addsub2_i64(TCGContext *s, TCGReg rl, TCGReg rh,
     tcg_out_mov(s, TCG_TYPE_I64, rl, tmp);
 }
 
-static void tcg_out_call_nodelay(TCGContext *s, tcg_insn_unit *dest,
+static void tcg_out_call_nodelay(TCGContext *s, const tcg_insn_unit *dest,
                                  bool in_prologue)
 {
     ptrdiff_t disp = tcg_pcrel_diff(s, dest);
@@ -855,7 +855,7 @@ static void tcg_out_call_nodelay(TCGContext *s, tcg_insn_unit *dest,
     }
 }
 
-static void tcg_out_call(TCGContext *s, tcg_insn_unit *dest)
+static void tcg_out_call(TCGContext *s, const tcg_insn_unit *dest)
 {
     tcg_out_call_nodelay(s, dest, false);
     tcg_out_nop(s);
diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index 231b9b1775..d5a4d9d37c 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -545,7 +545,7 @@ static void tcg_out_movi(TCGContext *s, TCGType type,
     old_code_ptr[1] = s->code_ptr - old_code_ptr;
 }
 
-static inline void tcg_out_call(TCGContext *s, tcg_insn_unit *arg)
+static inline void tcg_out_call(TCGContext *s, const tcg_insn_unit *arg)
 {
     uint8_t *old_code_ptr = s->code_ptr;
     tcg_out_op_t(s, INDEX_op_call);
-- 
2.25.1


