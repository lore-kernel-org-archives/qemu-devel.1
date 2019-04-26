Return-Path: <SRS0=QtPl=S4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B240CC43219
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 17:35:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E5C3208CB
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 17:35:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mPiH9nB+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E5C3208CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50031 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hK4kc-00018S-6h
	for qemu-devel@archiver.kernel.org; Fri, 26 Apr 2019 13:35:06 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48057)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hK4aX-00009M-Nh
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 13:24:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hK4aV-000715-Nv
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 13:24:41 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:38939)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hK4aV-0006ve-EO
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 13:24:39 -0400
Received: by mail-pl1-x642.google.com with SMTP id e92so1881900plb.6
	for <qemu-devel@nongnu.org>; Fri, 26 Apr 2019 10:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=n8SNl7SbB5n04Pd6SexcJw1I8YzVfNG3KGOvvgv8YbI=;
	b=mPiH9nB+jG73WeOqUX/QGWYyS3857I9s9USp68njHW2DVSc1DD4l0FX/s/SdNp+j+2
	6Pjo+NF5YzkS3yYo/ApbAnAGBTWBTCXvUX/nqnJXebC6n2Vsb3RNEUJjyXpQljNmJesu
	cVEncUxxf1zG3OKvuvpQzFRFOdqv1Fm27gh2+ZEtFJFAgoSAJzNFkjBPiJxSklSmZM7+
	KEDPwk5GPu9l6J4pRJqmNw0f+eyN+pPYFHSyXx3lwaGky9gILtC6Uea7ipGLI+4wcpZ2
	mGOkfriy7rFc3UMHF5cpqMec7i9SJt5hGShpm6Zr+i0wtmZzAOP4KAPNOya6AaPVMzsR
	FLrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=n8SNl7SbB5n04Pd6SexcJw1I8YzVfNG3KGOvvgv8YbI=;
	b=YfP8FBAGtf82Yn4ar0Je8FY2zEuT7bj7aA7EpVuEFLAb9LI1625X7lXb71SEpfaOzf
	nmxaDGVB0YId3UMYz/gN5MVCV+4hNsI+lnKGFJ+Ho5aYIAzfxTBBz3jjjP5s9pWnYbmk
	elGLNIQkADM5ovKHvdGpUZrEpUXlSvMHy9GsVafMYVAb8oMt9RvnQg1n/jbDLvoRTRup
	eURh1w6Fci9GFtQu++Zx/63Dp8rGQ7KEqCuz8EDa5uhMhNSrJSh6W7FycOYgU54Gl8rS
	/Rm49+Xfd/prNt+q9rnHXzN9ajoLWLo4e1p5dxUQpy23DQRSadPC383KV3WwgIDg25mS
	Lr8A==
X-Gm-Message-State: APjAAAWw0/H7U5MRgEnpzncKmp7xpHi8ciZPh1+DoQbeg1JhViB5MqOV
	ghX//UhKOzX/IrNI1Gd2JOqc8zUPhiw=
X-Google-Smtp-Source: APXvYqyKBnB5C20kBNOVHjfdUDnWsj/xhM/9BTkqccYjGTKfoCl4EW51+znjWvx1vkfkHd+nq/Vc0A==
X-Received: by 2002:a17:902:e285:: with SMTP id
	cf5mr10523914plb.77.1556299477925; 
	Fri, 26 Apr 2019 10:24:37 -0700 (PDT)
Received: from localhost.localdomain (97-113-179-147.tukw.qwest.net.
	[97.113.179.147]) by smtp.gmail.com with ESMTPSA id
	j5sm7901762pfg.186.2019.04.26.10.24.36
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 26 Apr 2019 10:24:37 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 26 Apr 2019 10:24:18 -0700
Message-Id: <20190426172421.27133-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190426172421.27133-1-richard.henderson@linaro.org>
References: <20190426172421.27133-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::642
Subject: [Qemu-devel] [PULL 12/15] tcg: Restart TB generation after
 out-of-line ldst overflow
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190426172418.8QCOSD528QDDoGnKixLT5GBIuBj99WZ_6EjYQE5OeIE@z>

This is part c of relocation overflow handling.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/aarch64/tcg-target.inc.c | 16 ++++++++++------
 tcg/arm/tcg-target.inc.c     | 16 ++++++++++------
 tcg/i386/tcg-target.inc.c    |  6 ++++--
 tcg/mips/tcg-target.inc.c    |  6 ++++--
 tcg/ppc/tcg-target.inc.c     | 14 ++++++++++----
 tcg/riscv/tcg-target.inc.c   | 16 ++++++++++++----
 tcg/s390/tcg-target.inc.c    | 20 ++++++++++++--------
 tcg/tcg-ldst.inc.c           | 18 +++++++++---------
 tcg/tcg.c                    |  7 ++++---
 9 files changed, 75 insertions(+), 44 deletions(-)

diff --git a/tcg/aarch64/tcg-target.inc.c b/tcg/aarch64/tcg-target.inc.c
index 8b93598bce..eefa929948 100644
--- a/tcg/aarch64/tcg-target.inc.c
+++ b/tcg/aarch64/tcg-target.inc.c
@@ -1395,14 +1395,15 @@ static inline void tcg_out_adr(TCGContext *s, TCGReg rd, void *target)
     tcg_out_insn(s, 3406, ADR, rd, offset);
 }
 
-static void tcg_out_qemu_ld_slow_path(TCGContext *s, TCGLabelQemuLdst *lb)
+static bool tcg_out_qemu_ld_slow_path(TCGContext *s, TCGLabelQemuLdst *lb)
 {
     TCGMemOpIdx oi = lb->oi;
     TCGMemOp opc = get_memop(oi);
     TCGMemOp size = opc & MO_SIZE;
 
-    bool ok = reloc_pc19(lb->label_ptr[0], s->code_ptr);
-    tcg_debug_assert(ok);
+    if (!reloc_pc19(lb->label_ptr[0], s->code_ptr)) {
+        return false;
+    }
 
     tcg_out_mov(s, TCG_TYPE_PTR, TCG_REG_X0, TCG_AREG0);
     tcg_out_mov(s, TARGET_LONG_BITS == 64, TCG_REG_X1, lb->addrlo_reg);
@@ -1416,16 +1417,18 @@ static void tcg_out_qemu_ld_slow_path(TCGContext *s, TCGLabelQemuLdst *lb)
     }
 
     tcg_out_goto(s, lb->raddr);
+    return true;
 }
 
-static void tcg_out_qemu_st_slow_path(TCGContext *s, TCGLabelQemuLdst *lb)
+static bool tcg_out_qemu_st_slow_path(TCGContext *s, TCGLabelQemuLdst *lb)
 {
     TCGMemOpIdx oi = lb->oi;
     TCGMemOp opc = get_memop(oi);
     TCGMemOp size = opc & MO_SIZE;
 
-    bool ok = reloc_pc19(lb->label_ptr[0], s->code_ptr);
-    tcg_debug_assert(ok);
+    if (!reloc_pc19(lb->label_ptr[0], s->code_ptr)) {
+        return false;
+    }
 
     tcg_out_mov(s, TCG_TYPE_PTR, TCG_REG_X0, TCG_AREG0);
     tcg_out_mov(s, TARGET_LONG_BITS == 64, TCG_REG_X1, lb->addrlo_reg);
@@ -1434,6 +1437,7 @@ static void tcg_out_qemu_st_slow_path(TCGContext *s, TCGLabelQemuLdst *lb)
     tcg_out_adr(s, TCG_REG_X4, lb->raddr);
     tcg_out_call(s, qemu_st_helpers[opc & (MO_BSWAP | MO_SIZE)]);
     tcg_out_goto(s, lb->raddr);
+    return true;
 }
 
 static void add_qemu_ldst_label(TCGContext *s, bool is_ld, TCGMemOpIdx oi,
diff --git a/tcg/arm/tcg-target.inc.c b/tcg/arm/tcg-target.inc.c
index 6873b0cf95..12a65cc9a6 100644
--- a/tcg/arm/tcg-target.inc.c
+++ b/tcg/arm/tcg-target.inc.c
@@ -1372,15 +1372,16 @@ static void add_qemu_ldst_label(TCGContext *s, bool is_ld, TCGMemOpIdx oi,
     label->label_ptr[0] = label_ptr;
 }
 
-static void tcg_out_qemu_ld_slow_path(TCGContext *s, TCGLabelQemuLdst *lb)
+static bool tcg_out_qemu_ld_slow_path(TCGContext *s, TCGLabelQemuLdst *lb)
 {
     TCGReg argreg, datalo, datahi;
     TCGMemOpIdx oi = lb->oi;
     TCGMemOp opc = get_memop(oi);
     void *func;
 
-    bool ok = reloc_pc24(lb->label_ptr[0], s->code_ptr);
-    tcg_debug_assert(ok);
+    if (!reloc_pc24(lb->label_ptr[0], s->code_ptr)) {
+        return false;
+    }
 
     argreg = tcg_out_arg_reg32(s, TCG_REG_R0, TCG_AREG0);
     if (TARGET_LONG_BITS == 64) {
@@ -1432,16 +1433,18 @@ static void tcg_out_qemu_ld_slow_path(TCGContext *s, TCGLabelQemuLdst *lb)
     }
 
     tcg_out_goto(s, COND_AL, lb->raddr);
+    return true;
 }
 
-static void tcg_out_qemu_st_slow_path(TCGContext *s, TCGLabelQemuLdst *lb)
+static bool tcg_out_qemu_st_slow_path(TCGContext *s, TCGLabelQemuLdst *lb)
 {
     TCGReg argreg, datalo, datahi;
     TCGMemOpIdx oi = lb->oi;
     TCGMemOp opc = get_memop(oi);
 
-    bool ok = reloc_pc24(lb->label_ptr[0], s->code_ptr);
-    tcg_debug_assert(ok);
+    if (!reloc_pc24(lb->label_ptr[0], s->code_ptr)) {
+        return false;
+    }
 
     argreg = TCG_REG_R0;
     argreg = tcg_out_arg_reg32(s, argreg, TCG_AREG0);
@@ -1474,6 +1477,7 @@ static void tcg_out_qemu_st_slow_path(TCGContext *s, TCGLabelQemuLdst *lb)
 
     /* Tail-call to the helper, which will return to the fast path.  */
     tcg_out_goto(s, COND_AL, qemu_st_helpers[opc & (MO_BSWAP | MO_SIZE)]);
+    return true;
 }
 #endif /* SOFTMMU */
 
diff --git a/tcg/i386/tcg-target.inc.c b/tcg/i386/tcg-target.inc.c
index 1fa833840e..d5ed9f1ffd 100644
--- a/tcg/i386/tcg-target.inc.c
+++ b/tcg/i386/tcg-target.inc.c
@@ -1730,7 +1730,7 @@ static void add_qemu_ldst_label(TCGContext *s, bool is_ld, bool is_64,
 /*
  * Generate code for the slow path for a load at the end of block
  */
-static void tcg_out_qemu_ld_slow_path(TCGContext *s, TCGLabelQemuLdst *l)
+static bool tcg_out_qemu_ld_slow_path(TCGContext *s, TCGLabelQemuLdst *l)
 {
     TCGMemOpIdx oi = l->oi;
     TCGMemOp opc = get_memop(oi);
@@ -1809,12 +1809,13 @@ static void tcg_out_qemu_ld_slow_path(TCGContext *s, TCGLabelQemuLdst *l)
 
     /* Jump to the code corresponding to next IR of qemu_st */
     tcg_out_jmp(s, l->raddr);
+    return true;
 }
 
 /*
  * Generate code for the slow path for a store at the end of block
  */
-static void tcg_out_qemu_st_slow_path(TCGContext *s, TCGLabelQemuLdst *l)
+static bool tcg_out_qemu_st_slow_path(TCGContext *s, TCGLabelQemuLdst *l)
 {
     TCGMemOpIdx oi = l->oi;
     TCGMemOp opc = get_memop(oi);
@@ -1877,6 +1878,7 @@ static void tcg_out_qemu_st_slow_path(TCGContext *s, TCGLabelQemuLdst *l)
     /* "Tail call" to the helper, with the return address back inline.  */
     tcg_out_push(s, retaddr);
     tcg_out_jmp(s, qemu_st_helpers[opc & (MO_BSWAP | MO_SIZE)]);
+    return true;
 }
 #elif TCG_TARGET_REG_BITS == 32
 # define x86_guest_base_seg     0
diff --git a/tcg/mips/tcg-target.inc.c b/tcg/mips/tcg-target.inc.c
index 8a92e916dd..412cacdcb9 100644
--- a/tcg/mips/tcg-target.inc.c
+++ b/tcg/mips/tcg-target.inc.c
@@ -1338,7 +1338,7 @@ static void add_qemu_ldst_label(TCGContext *s, int is_ld, TCGMemOpIdx oi,
     }
 }
 
-static void tcg_out_qemu_ld_slow_path(TCGContext *s, TCGLabelQemuLdst *l)
+static bool tcg_out_qemu_ld_slow_path(TCGContext *s, TCGLabelQemuLdst *l)
 {
     TCGMemOpIdx oi = l->oi;
     TCGMemOp opc = get_memop(oi);
@@ -1385,9 +1385,10 @@ static void tcg_out_qemu_ld_slow_path(TCGContext *s, TCGLabelQemuLdst *l)
     } else {
         tcg_out_opc_reg(s, OPC_OR, v0, TCG_REG_V0, TCG_REG_ZERO);
     }
+    return true;
 }
 
-static void tcg_out_qemu_st_slow_path(TCGContext *s, TCGLabelQemuLdst *l)
+static bool tcg_out_qemu_st_slow_path(TCGContext *s, TCGLabelQemuLdst *l)
 {
     TCGMemOpIdx oi = l->oi;
     TCGMemOp opc = get_memop(oi);
@@ -1435,6 +1436,7 @@ static void tcg_out_qemu_st_slow_path(TCGContext *s, TCGLabelQemuLdst *l)
     tcg_out_call_int(s, qemu_st_helpers[opc & (MO_BSWAP | MO_SIZE)], true);
     /* delay slot */
     tcg_out_mov(s, TCG_TYPE_PTR, tcg_target_call_iarg_regs[0], TCG_AREG0);
+    return true;
 }
 #endif
 
diff --git a/tcg/ppc/tcg-target.inc.c b/tcg/ppc/tcg-target.inc.c
index 773690f1d9..c0923ced4f 100644
--- a/tcg/ppc/tcg-target.inc.c
+++ b/tcg/ppc/tcg-target.inc.c
@@ -1653,13 +1653,15 @@ static void add_qemu_ldst_label(TCGContext *s, bool is_ld, TCGMemOpIdx oi,
     label->label_ptr[0] = lptr;
 }
 
-static void tcg_out_qemu_ld_slow_path(TCGContext *s, TCGLabelQemuLdst *lb)
+static bool tcg_out_qemu_ld_slow_path(TCGContext *s, TCGLabelQemuLdst *lb)
 {
     TCGMemOpIdx oi = lb->oi;
     TCGMemOp opc = get_memop(oi);
     TCGReg hi, lo, arg = TCG_REG_R3;
 
-    **lb->label_ptr |= reloc_pc14_val(*lb->label_ptr, s->code_ptr);
+    if (!reloc_pc14(lb->label_ptr[0], s->code_ptr)) {
+        return false;
+    }
 
     tcg_out_mov(s, TCG_TYPE_PTR, arg++, TCG_AREG0);
 
@@ -1695,16 +1697,19 @@ static void tcg_out_qemu_ld_slow_path(TCGContext *s, TCGLabelQemuLdst *lb)
     }
 
     tcg_out_b(s, 0, lb->raddr);
+    return true;
 }
 
-static void tcg_out_qemu_st_slow_path(TCGContext *s, TCGLabelQemuLdst *lb)
+static bool tcg_out_qemu_st_slow_path(TCGContext *s, TCGLabelQemuLdst *lb)
 {
     TCGMemOpIdx oi = lb->oi;
     TCGMemOp opc = get_memop(oi);
     TCGMemOp s_bits = opc & MO_SIZE;
     TCGReg hi, lo, arg = TCG_REG_R3;
 
-    **lb->label_ptr |= reloc_pc14_val(*lb->label_ptr, s->code_ptr);
+    if (!reloc_pc14(lb->label_ptr[0], s->code_ptr)) {
+        return false;
+    }
 
     tcg_out_mov(s, TCG_TYPE_PTR, arg++, TCG_AREG0);
 
@@ -1753,6 +1758,7 @@ static void tcg_out_qemu_st_slow_path(TCGContext *s, TCGLabelQemuLdst *lb)
     tcg_out_call(s, qemu_st_helpers[opc & (MO_BSWAP | MO_SIZE)]);
 
     tcg_out_b(s, 0, lb->raddr);
+    return true;
 }
 #endif /* SOFTMMU */
 
diff --git a/tcg/riscv/tcg-target.inc.c b/tcg/riscv/tcg-target.inc.c
index b785f4acb7..2932505094 100644
--- a/tcg/riscv/tcg-target.inc.c
+++ b/tcg/riscv/tcg-target.inc.c
@@ -1065,7 +1065,7 @@ static void add_qemu_ldst_label(TCGContext *s, int is_ld, TCGMemOpIdx oi,
     label->label_ptr[0] = label_ptr[0];
 }
 
-static void tcg_out_qemu_ld_slow_path(TCGContext *s, TCGLabelQemuLdst *l)
+static bool tcg_out_qemu_ld_slow_path(TCGContext *s, TCGLabelQemuLdst *l)
 {
     TCGMemOpIdx oi = l->oi;
     TCGMemOp opc = get_memop(oi);
@@ -1080,7 +1080,10 @@ static void tcg_out_qemu_ld_slow_path(TCGContext *s, TCGLabelQemuLdst *l)
     }
 
     /* resolve label address */
-    patch_reloc(l->label_ptr[0], R_RISCV_BRANCH, (intptr_t) s->code_ptr, 0);
+    if (!patch_reloc(l->label_ptr[0], R_RISCV_BRANCH,
+                     (intptr_t) s->code_ptr, 0)) {
+        return false;
+    }
 
     /* call load helper */
     tcg_out_mov(s, TCG_TYPE_PTR, a0, TCG_AREG0);
@@ -1092,9 +1095,10 @@ static void tcg_out_qemu_ld_slow_path(TCGContext *s, TCGLabelQemuLdst *l)
     tcg_out_mov(s, (opc & MO_SIZE) == MO_64, l->datalo_reg, a0);
 
     tcg_out_goto(s, l->raddr);
+    return true;
 }
 
-static void tcg_out_qemu_st_slow_path(TCGContext *s, TCGLabelQemuLdst *l)
+static bool tcg_out_qemu_st_slow_path(TCGContext *s, TCGLabelQemuLdst *l)
 {
     TCGMemOpIdx oi = l->oi;
     TCGMemOp opc = get_memop(oi);
@@ -1111,7 +1115,10 @@ static void tcg_out_qemu_st_slow_path(TCGContext *s, TCGLabelQemuLdst *l)
     }
 
     /* resolve label address */
-    patch_reloc(l->label_ptr[0], R_RISCV_BRANCH, (intptr_t) s->code_ptr, 0);
+    if (!patch_reloc(l->label_ptr[0], R_RISCV_BRANCH,
+                     (intptr_t) s->code_ptr, 0)) {
+        return false;
+    }
 
     /* call store helper */
     tcg_out_mov(s, TCG_TYPE_PTR, a0, TCG_AREG0);
@@ -1133,6 +1140,7 @@ static void tcg_out_qemu_st_slow_path(TCGContext *s, TCGLabelQemuLdst *l)
     tcg_out_call(s, qemu_st_helpers[opc & (MO_BSWAP | MO_SSIZE)]);
 
     tcg_out_goto(s, l->raddr);
+    return true;
 }
 #endif /* CONFIG_SOFTMMU */
 
diff --git a/tcg/s390/tcg-target.inc.c b/tcg/s390/tcg-target.inc.c
index 7db90b3bae..3d6150b10e 100644
--- a/tcg/s390/tcg-target.inc.c
+++ b/tcg/s390/tcg-target.inc.c
@@ -1609,16 +1609,17 @@ static void add_qemu_ldst_label(TCGContext *s, bool is_ld, TCGMemOpIdx oi,
     label->label_ptr[0] = label_ptr;
 }
 
-static void tcg_out_qemu_ld_slow_path(TCGContext *s, TCGLabelQemuLdst *lb)
+static bool tcg_out_qemu_ld_slow_path(TCGContext *s, TCGLabelQemuLdst *lb)
 {
     TCGReg addr_reg = lb->addrlo_reg;
     TCGReg data_reg = lb->datalo_reg;
     TCGMemOpIdx oi = lb->oi;
     TCGMemOp opc = get_memop(oi);
 
-    bool ok = patch_reloc(lb->label_ptr[0], R_390_PC16DBL,
-                          (intptr_t)s->code_ptr, 2);
-    tcg_debug_assert(ok);
+    if (!patch_reloc(lb->label_ptr[0], R_390_PC16DBL,
+                     (intptr_t)s->code_ptr, 2)) {
+        return false;
+    }
 
     tcg_out_mov(s, TCG_TYPE_PTR, TCG_REG_R2, TCG_AREG0);
     if (TARGET_LONG_BITS == 64) {
@@ -1630,18 +1631,20 @@ static void tcg_out_qemu_ld_slow_path(TCGContext *s, TCGLabelQemuLdst *lb)
     tcg_out_mov(s, TCG_TYPE_I64, data_reg, TCG_REG_R2);
 
     tgen_gotoi(s, S390_CC_ALWAYS, lb->raddr);
+    return true;
 }
 
-static void tcg_out_qemu_st_slow_path(TCGContext *s, TCGLabelQemuLdst *lb)
+static bool tcg_out_qemu_st_slow_path(TCGContext *s, TCGLabelQemuLdst *lb)
 {
     TCGReg addr_reg = lb->addrlo_reg;
     TCGReg data_reg = lb->datalo_reg;
     TCGMemOpIdx oi = lb->oi;
     TCGMemOp opc = get_memop(oi);
 
-    bool ok = patch_reloc(lb->label_ptr[0], R_390_PC16DBL,
-                          (intptr_t)s->code_ptr, 2);
-    tcg_debug_assert(ok);
+    if (!patch_reloc(lb->label_ptr[0], R_390_PC16DBL,
+                     (intptr_t)s->code_ptr, 2)) {
+        return false;
+    }
 
     tcg_out_mov(s, TCG_TYPE_PTR, TCG_REG_R2, TCG_AREG0);
     if (TARGET_LONG_BITS == 64) {
@@ -1668,6 +1671,7 @@ static void tcg_out_qemu_st_slow_path(TCGContext *s, TCGLabelQemuLdst *lb)
     tcg_out_call(s, qemu_st_helpers[opc & (MO_BSWAP | MO_SIZE)]);
 
     tgen_gotoi(s, S390_CC_ALWAYS, lb->raddr);
+    return true;
 }
 #else
 static void tcg_prepare_user_ldst(TCGContext *s, TCGReg *addr_reg,
diff --git a/tcg/tcg-ldst.inc.c b/tcg/tcg-ldst.inc.c
index 47f41b921b..05f9b3ccd6 100644
--- a/tcg/tcg-ldst.inc.c
+++ b/tcg/tcg-ldst.inc.c
@@ -38,19 +38,19 @@ typedef struct TCGLabelQemuLdst {
  * Generate TB finalization at the end of block
  */
 
-static void tcg_out_qemu_ld_slow_path(TCGContext *s, TCGLabelQemuLdst *l);
-static void tcg_out_qemu_st_slow_path(TCGContext *s, TCGLabelQemuLdst *l);
+static bool tcg_out_qemu_ld_slow_path(TCGContext *s, TCGLabelQemuLdst *l);
+static bool tcg_out_qemu_st_slow_path(TCGContext *s, TCGLabelQemuLdst *l);
 
-static bool tcg_out_ldst_finalize(TCGContext *s)
+static int tcg_out_ldst_finalize(TCGContext *s)
 {
     TCGLabelQemuLdst *lb;
 
     /* qemu_ld/st slow paths */
     QSIMPLEQ_FOREACH(lb, &s->ldst_labels, next) {
-        if (lb->is_ld) {
-            tcg_out_qemu_ld_slow_path(s, lb);
-        } else {
-            tcg_out_qemu_st_slow_path(s, lb);
+        if (lb->is_ld
+            ? !tcg_out_qemu_ld_slow_path(s, lb)
+            : !tcg_out_qemu_st_slow_path(s, lb)) {
+            return -2;
         }
 
         /* Test for (pending) buffer overflow.  The assumption is that any
@@ -58,10 +58,10 @@ static bool tcg_out_ldst_finalize(TCGContext *s)
            the buffer completely.  Thus we can test for overflow after
            generating code without having to check during generation.  */
         if (unlikely((void *)s->code_ptr > s->code_gen_highwater)) {
-            return false;
+            return -1;
         }
     }
-    return true;
+    return 0;
 }
 
 /*
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 0394e8ab34..f7bef51de8 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -128,7 +128,7 @@ static void tcg_out_call(TCGContext *s, tcg_insn_unit *target);
 static int tcg_target_const_match(tcg_target_long val, TCGType type,
                                   const TCGArgConstraint *arg_ct);
 #ifdef TCG_TARGET_NEED_LDST_LABELS
-static bool tcg_out_ldst_finalize(TCGContext *s);
+static int tcg_out_ldst_finalize(TCGContext *s);
 #endif
 
 #define TCG_HIGHWATER 1024
@@ -4000,8 +4000,9 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb)
 
     /* Generate TB finalization at the end of block */
 #ifdef TCG_TARGET_NEED_LDST_LABELS
-    if (!tcg_out_ldst_finalize(s)) {
-        return -1;
+    i = tcg_out_ldst_finalize(s);
+    if (i < 0) {
+        return i;
     }
 #endif
 #ifdef TCG_TARGET_NEED_POOL_LABELS
-- 
2.17.1


