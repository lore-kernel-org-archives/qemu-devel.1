Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDBBFC2D0A3
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 01:13:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3598720731
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 01:13:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tdAZMwKz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3598720731
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60378 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYIyf-0007WL-4G
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 21:13:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46726)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kYIbo-00048d-Cz
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 20:49:36 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629]:37756)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kYIbk-0001qB-Jd
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 20:49:36 -0400
Received: by mail-pl1-x629.google.com with SMTP id b12so2154434plr.4
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2020 17:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=9ySIqRhIpRIHgLwMCzTPZ3rHxc/sVvkWy/2sGdv9pSM=;
 b=tdAZMwKznO6VOQ5F+PNHRVB639nr60ruZTRrrGDI4rrT4AEljAi/gTBvsjjB3WK/Ba
 /8SiFm7stulevv2FX7wqjUcXEG92f/SUhh0DJYKCHkRdUwgyZkhZ32y01JywqCNB+wWQ
 hrL08hMplli7xKZVnuzF3amWdOaVg4fRSTBGFUQyS7M13EMagyAhTQHorYH01DgAKlIV
 BAEmk6Gn2bbNc3pBADYB1FCxNyyoCnWzG7j0WMFOoTmP/Lu6n/zyJIin4hTM9ZpbrzhE
 bGAS/+eO6yTKglzZxbz6KGE6GMuhEF8zL+/wjqD0qG5OEk7HdolOZfRgQqwuhbbkuERx
 I6gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=9ySIqRhIpRIHgLwMCzTPZ3rHxc/sVvkWy/2sGdv9pSM=;
 b=ArcQa6LrXNzluhTGplyhd8KkeEuMaqW8ju8dLtk6Fr1UljAcNhvM0rAlq6oXN8bOvi
 F1RXl+uvNau++7QFSZgmdHob0ymxpMnyAxFzy0h3rCHZgG13barQ3eLjh8qUvCSe7mSB
 WLxyPfFCE2XBywzQTzwi8REttITHpeAkaciKFXYrGLwo3gFVC6Mu4iokP6hB+9CNXLQ5
 J+SPL0lOCQjz7GX7vq1H0Zr2vov2o4r3cee70ivrTCS+nXiFHk8OdwGA33FckRNWDaFn
 uYeX6r4S4CoHaruEa64Kvobu1vK3+SWI5uNZzzXObeHyxqoA2M3uTOUc4pt+a9MpbLL7
 D3zw==
X-Gm-Message-State: AOAM531o2rxoy0bAnZK9mixiMULPUk/5FIzLqWihrZ7Sr3KHn+/SWAvA
 OrujA1i0WpXQXbUZqhlYBgUbFiD0nztX3Q==
X-Google-Smtp-Source: ABdhPJzIpL/c5QwGw5h0qF3A3YTr8XJLtfwlkyQ910168xQRhy7haF229Sx4iZ0e8M4L78MLaEAX3w==
X-Received: by 2002:a17:902:8b86:b029:d4:c98b:c314 with SMTP id
 ay6-20020a1709028b86b02900d4c98bc314mr6425605plb.48.1604018970316; 
 Thu, 29 Oct 2020 17:49:30 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id b6sm3557264pgq.58.2020.10.29.17.49.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2020 17:49:29 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 05/19] tcg: Adjust tcg_out_call for const
Date: Thu, 29 Oct 2020 17:49:07 -0700
Message-Id: <20201030004921.721096-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201030004921.721096-1-richard.henderson@linaro.org>
References: <20201030004921.721096-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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
Cc: pbonzini@redhat.com, j@getutm.app, laurent@vivier.eu
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
index 88b13b9321..ddc38b8c50 100644
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
index 1e32bf42b8..d6dfe2b428 100644
--- a/tcg/arm/tcg-target.c.inc
+++ b/tcg/arm/tcg-target.c.inc
@@ -1033,7 +1033,7 @@ static void tcg_out_goto(TCGContext *s, int cond, tcg_insn_unit *addr)
 
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
index f641105f9a..064f46fc6d 100644
--- a/tcg/mips/tcg-target.c.inc
+++ b/tcg/mips/tcg-target.c.inc
@@ -516,7 +516,7 @@ static void tcg_out_opc_sa64(TCGContext *s, MIPSInsn opc1, MIPSInsn opc2,
  * Type jump.
  * Returns true if the branch was in range and the insn was emitted.
  */
-static bool tcg_out_opc_jmp(TCGContext *s, MIPSInsn opc, void *target)
+static bool tcg_out_opc_jmp(TCGContext *s, MIPSInsn opc, const void *target)
 {
     uintptr_t dest = (uintptr_t)target;
     uintptr_t from = (uintptr_t)s->code_ptr + 4;
@@ -1079,7 +1079,7 @@ static void tcg_out_movcond(TCGContext *s, TCGCond cond, TCGReg ret,
     }
 }
 
-static void tcg_out_call_int(TCGContext *s, tcg_insn_unit *arg, bool tail)
+static void tcg_out_call_int(TCGContext *s, const tcg_insn_unit *arg, bool tail)
 {
     /* Note that the ABI requires the called function's address to be
        loaded into T9, even if a direct branch is in range.  */
@@ -1097,7 +1097,7 @@ static void tcg_out_call_int(TCGContext *s, tcg_insn_unit *arg, bool tail)
     }
 }
 
-static void tcg_out_call(TCGContext *s, tcg_insn_unit *arg)
+static void tcg_out_call(TCGContext *s, const tcg_insn_unit *arg)
 {
     tcg_out_call_int(s, arg, false);
     tcg_out_nop(s);
diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index be116c6164..513d784a83 100644
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
index ac99ccea73..7983befd96 100644
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


