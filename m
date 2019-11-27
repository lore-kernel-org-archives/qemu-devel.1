Return-Path: <SRS0=bFmd=ZT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 825C4C432C3
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 18:04:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 293CF20871
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 18:04:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BPSN3Vt+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 293CF20871
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41250 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ia1gE-0001EI-U5
	for qemu-devel@archiver.kernel.org; Wed, 27 Nov 2019 13:04:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48449)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mrolnik@gmail.com>) id 1ia1Vc-0002BH-Or
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 12:53:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mrolnik@gmail.com>) id 1ia1Va-0006aq-ER
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 12:53:48 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:35791)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mrolnik@gmail.com>) id 1ia1VZ-0006Yt-WF
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 12:53:46 -0500
Received: by mail-wr1-x443.google.com with SMTP id s5so27729435wrw.2
 for <qemu-devel@nongnu.org>; Wed, 27 Nov 2019 09:53:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=kAhud8sddIA7MNZF3E3To08QyL9Kr5B5kglfeYkKJjI=;
 b=BPSN3Vt+4GgQXFJG41QeDmdfnbNMfU4aFxEVhjQKdmRVmp9l8/eJuAwcMYGMLM3ZAH
 a8vBpRv7n4Aipi6h6FLQyg+d8DStZlXF/vaJqYaHhGxYGxydPB/JANZvXof52qneauq1
 stgCPYOknDQSutkIYLOM6d5hEd+XFx5RiF39k81s5BSxtR5bdALJAA2Ixa28B5gMj6rr
 /FGROegoL/jymbcgrPF8iJqMOYsgozZrXNck81sFA6GtgQyAaY+V7aAXKLQ5pdzlp53i
 1B46yL9HKYW95E971Dxryhel4uX5hs5+T5F2Mn0KDNdBWH/dnjbLDwZMomkkS5N9VsT1
 NimA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=kAhud8sddIA7MNZF3E3To08QyL9Kr5B5kglfeYkKJjI=;
 b=KV+C2ja+JU0sPTTM7ceKt2Hb63AmJg9xhMf9dlyFM0n44SRS7FQKWUIKQN0YO+gUa2
 z+rj0GcJreEv9rowLyVnCsRgv03HvcEfdnv6qPkpW6+1j70bofgv4EW3m3sULFqfYEon
 7ucgi/vGkZDyFjlib7POj4IfrdbS3dSXsk7pvLHM1AJKGMd6Yl2dV16gZEZwqdBlScX+
 Vnxhf/4zq87bLVwrMKBQBOYtxlZHNsP81LTxzgCUy1l+rPDAtv9bn7MIUEYgJ9Mzt+XO
 8SvZa3gQxsVkk4FIvl/cOUhediD16N08BON3k5819ldDX251ZcO2J9mWQVU1ZsuJ2TOP
 nU9w==
X-Gm-Message-State: APjAAAX0LWmnh6QMdUfqmgwhOLSRSX+vKZqkrp63XhSjed17VNuNf7Hw
 IDqfFDeUOtG9/bScebgjQJQctYU1u50uBtP+
X-Google-Smtp-Source: APXvYqxK1oW//5+dte7FT1jBgNmHR37EHe72UjosTqxdwFNUPE3ABvwz0fdQd2uHMNP61L3KgNIxQQ==
X-Received: by 2002:adf:f343:: with SMTP id e3mr24131853wrp.55.1574877224063; 
 Wed, 27 Nov 2019 09:53:44 -0800 (PST)
Received: from 8c859074c0ff.ant.amazon.com.com
 (bzq-79-178-2-87.red.bezeqint.net. [79.178.2.87])
 by smtp.gmail.com with ESMTPSA id b2sm20238295wrr.76.2019.11.27.09.53.42
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Wed, 27 Nov 2019 09:53:43 -0800 (PST)
From: Michael Rolnik <mrolnik@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v37 06/17] target/avr: Add instruction translation - Branch
 Instructions
Date: Wed, 27 Nov 2019 19:52:46 +0200
Message-Id: <20191127175257.23480-7-mrolnik@gmail.com>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
In-Reply-To: <20191127175257.23480-1-mrolnik@gmail.com>
References: <20191127175257.23480-1-mrolnik@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
Cc: thuth@redhat.com, Michael Rolnik <mrolnik@gmail.com>,
 me@xcancerberox.com.ar, richard.henderson@linaro.org, dovgaluk@ispras.ru,
 imammedo@redhat.com, philmd@redhat.com, aleksandar.m.mail@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This includes:
    - RJMP, IJMP, EIJMP, JMP
    - RCALL, ICALL, EICALL, CALL
    - RET, RETI
    - CPSE, CP, CPC, CPI
    - SBRC, SBRS, SBIC, SBIS
    - BRBC, BRBS

Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 target/avr/translate.c | 549 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 546 insertions(+), 3 deletions(-)

diff --git a/target/avr/translate.c b/target/avr/translate.c
index 76bfa651b6..48a42c984a 100644
--- a/target/avr/translate.c
+++ b/target/avr/translate.c
@@ -237,6 +237,86 @@ static void gen_ZNSf(TCGv R)
 }
 
 
+static void gen_push_ret(DisasContext *ctx, int ret)
+{
+    if (avr_feature(ctx->env, AVR_FEATURE_1_BYTE_PC)) {
+
+        TCGv t0 = tcg_const_i32((ret & 0x0000ff));
+
+        tcg_gen_qemu_st_tl(t0, cpu_sp, MMU_DATA_IDX, MO_UB);
+        tcg_gen_subi_tl(cpu_sp, cpu_sp, 1);
+
+        tcg_temp_free_i32(t0);
+    } else if (avr_feature(ctx->env, AVR_FEATURE_2_BYTE_PC)) {
+
+        TCGv t0 = tcg_const_i32((ret & 0x00ffff));
+
+        tcg_gen_subi_tl(cpu_sp, cpu_sp, 1);
+        tcg_gen_qemu_st_tl(t0, cpu_sp, MMU_DATA_IDX, MO_BEUW);
+        tcg_gen_subi_tl(cpu_sp, cpu_sp, 1);
+
+        tcg_temp_free_i32(t0);
+
+    } else if (avr_feature(ctx->env, AVR_FEATURE_3_BYTE_PC)) {
+
+        TCGv lo = tcg_const_i32((ret & 0x0000ff));
+        TCGv hi = tcg_const_i32((ret & 0xffff00) >> 8);
+
+        tcg_gen_qemu_st_tl(lo, cpu_sp, MMU_DATA_IDX, MO_UB);
+        tcg_gen_subi_tl(cpu_sp, cpu_sp, 2);
+        tcg_gen_qemu_st_tl(hi, cpu_sp, MMU_DATA_IDX, MO_BEUW);
+        tcg_gen_subi_tl(cpu_sp, cpu_sp, 1);
+
+        tcg_temp_free_i32(lo);
+        tcg_temp_free_i32(hi);
+    }
+}
+
+
+static void gen_pop_ret(DisasContext *ctx, TCGv ret)
+{
+    if (avr_feature(ctx->env, AVR_FEATURE_1_BYTE_PC)) {
+        tcg_gen_addi_tl(cpu_sp, cpu_sp, 1);
+        tcg_gen_qemu_ld_tl(ret, cpu_sp, MMU_DATA_IDX, MO_UB);
+    } else if (avr_feature(ctx->env, AVR_FEATURE_2_BYTE_PC)) {
+        tcg_gen_addi_tl(cpu_sp, cpu_sp, 1);
+        tcg_gen_qemu_ld_tl(ret, cpu_sp, MMU_DATA_IDX, MO_BEUW);
+        tcg_gen_addi_tl(cpu_sp, cpu_sp, 1);
+    } else if (avr_feature(ctx->env, AVR_FEATURE_3_BYTE_PC)) {
+        TCGv lo = tcg_temp_new_i32();
+        TCGv hi = tcg_temp_new_i32();
+
+        tcg_gen_addi_tl(cpu_sp, cpu_sp, 1);
+        tcg_gen_qemu_ld_tl(hi, cpu_sp, MMU_DATA_IDX, MO_BEUW);
+
+        tcg_gen_addi_tl(cpu_sp, cpu_sp, 2);
+        tcg_gen_qemu_ld_tl(lo, cpu_sp, MMU_DATA_IDX, MO_UB);
+
+        tcg_gen_deposit_tl(ret, lo, hi, 8, 16);
+
+        tcg_temp_free_i32(lo);
+        tcg_temp_free_i32(hi);
+    }
+}
+
+
+static void gen_goto_tb(DisasContext *ctx, int n, target_ulong dest)
+{
+    TranslationBlock *tb = ctx->tb;
+
+    if (ctx->singlestep == 0) {
+        tcg_gen_goto_tb(n);
+        tcg_gen_movi_i32(cpu_pc, dest);
+        tcg_gen_exit_tb(tb, n);
+    } else {
+        tcg_gen_movi_i32(cpu_pc, dest);
+        gen_helper_debug(cpu_env);
+        tcg_gen_exit_tb(NULL, 0);
+    }
+    ctx->bstate = DISAS_NORETURN;
+}
+
+
 /*
  *  Adds two registers without the C Flag and places the result in the
  *  destination register Rd.
@@ -810,13 +890,14 @@ static bool trans_MULSU(DisasContext *ctx, arg_MULSU *a)
     TCGv t0 = tcg_temp_new_i32();
 
     tcg_gen_ext8s_tl(t0, Rd); /* make Rd full 32 bit signed */
-    tcg_gen_mul_tl(R, t0, Rr); /* R = Rd *Rr */
+    tcg_gen_mul_tl(R, t0, Rr); /* R = Rd * Rr */
+    tcg_gen_andi_tl(R, R, 0xffff); /* make R 16 bits */
 
     tcg_gen_andi_tl(R0, R, 0xff);
     tcg_gen_shri_tl(R1, R, 8);
 
-    tcg_gen_shri_tl(cpu_Cf, R, 16); /* Cf = R(16) */
-    tcg_gen_mov_tl(cpu_Zf, R);
+    tcg_gen_shri_tl(cpu_Cf, R, 15); /* Cf = R(15) */
+    tcg_gen_setcondi_tl(TCG_COND_EQ, cpu_Zf, R, 0); /* Zf = R == 0 */
 
     tcg_temp_free_i32(t0);
     tcg_temp_free_i32(R);
@@ -965,3 +1046,465 @@ static bool trans_DES(DisasContext *ctx, arg_DES *a)
 
     return true;
 }
+
+
+/*
+ *  Relative jump to an address within PC - 2K +1 and PC + 2K (words). For
+ *  AVR microcontrollers with Program memory not exceeding 4K words (8KB) this
+ *  instruction can address the entire memory from every address location. See
+ *  also JMP.
+ */
+static bool trans_RJMP(DisasContext *ctx, arg_RJMP *a)
+{
+    int dst = ctx->npc + a->imm;
+
+    gen_goto_tb(ctx, 0, dst);
+
+    return true;
+}
+
+
+/*
+ *  Indirect jump to the address pointed to by the Z (16 bits) Pointer
+ *  Register in the Register File. The Z-pointer Register is 16 bits wide and
+ *  allows jump within the lowest 64K words (128KB) section of Program memory.
+ *  This instruction is not available in all devices. Refer to the device
+ *  specific instruction set summary.
+ */
+static bool trans_IJMP(DisasContext *ctx, arg_IJMP *a)
+{
+    if (!avr_have_feature(ctx, AVR_FEATURE_IJMP_ICALL)) {
+        return true;
+    }
+
+    gen_jmp_z(ctx);
+
+    return true;
+}
+
+
+/*
+ *  Indirect jump to the address pointed to by the Z (16 bits) Pointer
+ *  Register in the Register File and the EIND Register in the I/O space. This
+ *  instruction allows for indirect jumps to the entire 4M (words) Program
+ *  memory space. See also IJMP.  This instruction is not available in all
+ *  devices. Refer to the device specific instruction set summary.
+ */
+static bool trans_EIJMP(DisasContext *ctx, arg_EIJMP *a)
+{
+    if (!avr_have_feature(ctx, AVR_FEATURE_EIJMP_EICALL)) {
+        return true;
+    }
+
+    gen_jmp_ez(ctx);
+    return true;
+}
+
+
+/*
+ *  Jump to an address within the entire 4M (words) Program memory. See also
+ *  RJMP.  This instruction is not available in all devices. Refer to the device
+ *  specific instruction set summary.0
+ */
+static bool trans_JMP(DisasContext *ctx, arg_JMP *a)
+{
+    if (!avr_have_feature(ctx, AVR_FEATURE_JMP_CALL)) {
+        return true;
+    }
+
+    gen_goto_tb(ctx, 0, a->imm);
+
+    return true;
+}
+
+
+/*
+ *  Relative call to an address within PC - 2K + 1 and PC + 2K (words). The
+ *  return address (the instruction after the RCALL) is stored onto the Stack.
+ *  See also CALL. For AVR microcontrollers with Program memory not exceeding 4K
+ *  words (8KB) this instruction can address the entire memory from every
+ *  address location. The Stack Pointer uses a post-decrement scheme during
+ *  RCALL.
+ */
+static bool trans_RCALL(DisasContext *ctx, arg_RCALL *a)
+{
+    int ret = ctx->npc;
+    int dst = ctx->npc + a->imm;
+
+    gen_push_ret(ctx, ret);
+    gen_goto_tb(ctx, 0, dst);
+
+    return true;
+}
+
+
+/*
+ *  Calls to a subroutine within the entire 4M (words) Program memory. The
+ *  return address (to the instruction after the CALL) will be stored onto the
+ *  Stack. See also RCALL. The Stack Pointer uses a post-decrement scheme during
+ *  CALL.  This instruction is not available in all devices. Refer to the device
+ *  specific instruction set summary.
+ */
+static bool trans_ICALL(DisasContext *ctx, arg_ICALL *a)
+{
+    if (!avr_have_feature(ctx, AVR_FEATURE_IJMP_ICALL)) {
+        return true;
+    }
+
+    int ret = ctx->npc;
+
+    gen_push_ret(ctx, ret);
+    gen_jmp_z(ctx);
+
+    return true;
+}
+
+
+/*
+ *  Indirect call of a subroutine pointed to by the Z (16 bits) Pointer
+ *  Register in the Register File and the EIND Register in the I/O space. This
+ *  instruction allows for indirect calls to the entire 4M (words) Program
+ *  memory space. See also ICALL. The Stack Pointer uses a post-decrement scheme
+ *  during EICALL.  This instruction is not available in all devices. Refer to
+ *  the device specific instruction set summary.
+ */
+static bool trans_EICALL(DisasContext *ctx, arg_EICALL *a)
+{
+    if (!avr_have_feature(ctx, AVR_FEATURE_EIJMP_EICALL)) {
+        return true;
+    }
+
+    int ret = ctx->npc;
+
+    gen_push_ret(ctx, ret);
+    gen_jmp_ez(ctx);
+    return true;
+}
+
+
+/*
+ *  Calls to a subroutine within the entire Program memory. The return
+ *  address (to the instruction after the CALL) will be stored onto the Stack.
+ *  (See also RCALL). The Stack Pointer uses a post-decrement scheme during
+ *  CALL.  This instruction is not available in all devices. Refer to the device
+ *  specific instruction set summary.
+ */
+static bool trans_CALL(DisasContext *ctx, arg_CALL *a)
+{
+    if (!avr_have_feature(ctx, AVR_FEATURE_JMP_CALL)) {
+        return true;
+    }
+
+    int Imm = a->imm;
+    int ret = ctx->npc;
+
+    gen_push_ret(ctx, ret);
+    gen_goto_tb(ctx, 0, Imm);
+
+    return true;
+}
+
+
+/*
+ *  Returns from subroutine. The return address is loaded from the STACK.
+ *  The Stack Pointer uses a preincrement scheme during RET.
+ */
+static bool trans_RET(DisasContext *ctx, arg_RET *a)
+{
+    gen_pop_ret(ctx, cpu_pc);
+
+    ctx->bstate = DISAS_LOOKUP;
+    return true;
+}
+
+
+/*
+ *  Returns from interrupt. The return address is loaded from the STACK and
+ *  the Global Interrupt Flag is set.  Note that the Status Register is not
+ *  automatically stored when entering an interrupt routine, and it is not
+ *  restored when returning from an interrupt routine. This must be handled by
+ *  the application program. The Stack Pointer uses a pre-increment scheme
+ *  during RETI.
+ */
+static bool trans_RETI(DisasContext *ctx, arg_RETI *a)
+{
+    gen_pop_ret(ctx, cpu_pc);
+    tcg_gen_movi_tl(cpu_If, 1);
+
+    /* Need to return to main loop to re-evaluate interrupts.  */
+    ctx->bstate = DISAS_EXIT;
+    return true;
+}
+
+
+/*
+ *  This instruction performs a compare between two registers Rd and Rr, and
+ *  skips the next instruction if Rd = Rr.
+ */
+static bool trans_CPSE(DisasContext *ctx, arg_CPSE *a)
+{
+    ctx->skip_cond = TCG_COND_EQ;
+    ctx->skip_var0 = cpu_r[a->rd];
+    ctx->skip_var1 = cpu_r[a->rr];
+    return true;
+}
+
+
+/*
+ *  This instruction performs a compare between two registers Rd and Rr.
+ *  None of the registers are changed. All conditional branches can be used
+ *  after this instruction.
+ */
+static bool trans_CP(DisasContext *ctx, arg_CP *a)
+{
+    TCGv Rd = cpu_r[a->rd];
+    TCGv Rr = cpu_r[a->rr];
+    TCGv R = tcg_temp_new_i32();
+
+    /* op */
+    tcg_gen_sub_tl(R, Rd, Rr); /* R = Rd - Rr */
+    tcg_gen_andi_tl(R, R, 0xff); /* make it 8 bits */
+
+    gen_sub_CHf(R, Rd, Rr);
+    gen_sub_Vf(R, Rd, Rr);
+    gen_ZNSf(R);
+
+    tcg_temp_free_i32(R);
+
+    return true;
+}
+
+
+/*
+ *  This instruction performs a compare between two registers Rd and Rr and
+ *  also takes into account the previous carry. None of the registers are
+ *  changed. All conditional branches can be used after this instruction.
+ */
+static bool trans_CPC(DisasContext *ctx, arg_CPC *a)
+{
+    TCGv Rd = cpu_r[a->rd];
+    TCGv Rr = cpu_r[a->rr];
+    TCGv R = tcg_temp_new_i32();
+    TCGv zero = tcg_const_i32(0);
+
+    /* op */
+    tcg_gen_sub_tl(R, Rd, Rr); /* R = Rd - Rr - Cf */
+    tcg_gen_sub_tl(R, R, cpu_Cf);
+    tcg_gen_andi_tl(R, R, 0xff); /* make it 8 bits */
+
+    gen_sub_CHf(R, Rd, Rr);
+    gen_sub_Vf(R, Rd, Rr);
+    gen_NSf(R);
+
+    /*
+     * Previous value remains unchanged when the result is zero;
+     * cleared otherwise.
+     */
+    tcg_gen_movcond_tl(TCG_COND_EQ, cpu_Zf, R, zero, cpu_Zf, zero);
+
+    tcg_temp_free_i32(zero);
+    tcg_temp_free_i32(R);
+
+    return true;
+}
+
+
+/*
+ *  This instruction performs a compare between register Rd and a constant.
+ *  The register is not changed. All conditional branches can be used after this
+ *  instruction.
+ */
+static bool trans_CPI(DisasContext *ctx, arg_CPI *a)
+{
+    TCGv Rd = cpu_r[a->rd];
+    int Imm = a->imm;
+    TCGv Rr = tcg_const_i32(Imm);
+    TCGv R = tcg_temp_new_i32();
+
+    /* op */
+    tcg_gen_sub_tl(R, Rd, Rr); /* R = Rd - Rr */
+    tcg_gen_andi_tl(R, R, 0xff); /* make it 8 bits */
+
+    gen_sub_CHf(R, Rd, Rr);
+    gen_sub_Vf(R, Rd, Rr);
+    gen_ZNSf(R);
+
+    tcg_temp_free_i32(R);
+    tcg_temp_free_i32(Rr);
+
+    return true;
+}
+
+
+/*
+ *  This instruction tests a single bit in a register and skips the next
+ *  instruction if the bit is cleared.
+ */
+static bool trans_SBRC(DisasContext *ctx, arg_SBRC *a)
+{
+    TCGv Rr = cpu_r[a->rr];
+
+    ctx->skip_cond = TCG_COND_EQ;
+    ctx->skip_var0 = tcg_temp_new();
+    ctx->free_skip_var0 = true;
+
+    tcg_gen_andi_tl(ctx->skip_var0, Rr, 1 << a->bit);
+    return true;
+}
+
+
+/*
+ *  This instruction tests a single bit in a register and skips the next
+ *  instruction if the bit is set.
+ */
+static bool trans_SBRS(DisasContext *ctx, arg_SBRS *a)
+{
+    TCGv Rr = cpu_r[a->rr];
+
+    ctx->skip_cond = TCG_COND_NE;
+    ctx->skip_var0 = tcg_temp_new();
+    ctx->free_skip_var0 = true;
+
+    tcg_gen_andi_tl(ctx->skip_var0, Rr, 1 << a->bit);
+    return true;
+}
+
+
+/*
+ *  This instruction tests a single bit in an I/O Register and skips the
+ *  next instruction if the bit is cleared. This instruction operates on the
+ *  lower 32 I/O Registers -- addresses 0-31.
+ */
+static bool trans_SBIC(DisasContext *ctx, arg_SBIC *a)
+{
+    TCGv temp = tcg_const_i32(a->reg);
+
+    gen_helper_inb(temp, cpu_env, temp);
+    tcg_gen_andi_tl(temp, temp, 1 << a->bit);
+    ctx->skip_cond = TCG_COND_EQ;
+    ctx->skip_var0 = temp;
+    ctx->free_skip_var0 = true;
+
+    return true;
+}
+
+
+/*
+ *  This instruction tests a single bit in an I/O Register and skips the
+ *  next instruction if the bit is set. This instruction operates on the lower
+ *  32 I/O Registers -- addresses 0-31.
+ */
+static bool trans_SBIS(DisasContext *ctx, arg_SBIS *a)
+{
+    TCGv temp = tcg_const_i32(a->reg);
+
+    gen_helper_inb(temp, cpu_env, temp);
+    tcg_gen_andi_tl(temp, temp, 1 << a->bit);
+    ctx->skip_cond = TCG_COND_NE;
+    ctx->skip_var0 = temp;
+    ctx->free_skip_var0 = true;
+
+    return true;
+}
+
+
+/*
+ *  Conditional relative branch. Tests a single bit in SREG and branches
+ *  relatively to PC if the bit is cleared. This instruction branches relatively
+ *  to PC in either direction (PC - 63 < = destination <= PC + 64). The
+ *  parameter k is the offset from PC and is represented in two's complement
+ *  form.
+ */
+static bool trans_BRBC(DisasContext *ctx, arg_BRBC *a)
+{
+    TCGLabel *not_taken = gen_new_label();
+
+    TCGv var;
+
+    switch (a->bit) {
+    case 0x00:
+        var = cpu_Cf;
+        break;
+    case 0x01:
+        var = cpu_Zf;
+        break;
+    case 0x02:
+        var = cpu_Nf;
+        break;
+    case 0x03:
+        var = cpu_Vf;
+        break;
+    case 0x04:
+        var = cpu_Sf;
+        break;
+    case 0x05:
+        var = cpu_Hf;
+        break;
+    case 0x06:
+        var = cpu_Tf;
+        break;
+    case 0x07:
+        var = cpu_If;
+        break;
+    default:
+        g_assert_not_reached();
+    }
+
+    tcg_gen_brcondi_i32(TCG_COND_NE, var, 0, not_taken);
+    gen_goto_tb(ctx, 0, ctx->npc + a->imm);
+    gen_set_label(not_taken);
+
+    ctx->bstate = DISAS_CHAIN;
+    return true;
+}
+
+
+/*
+ *  Conditional relative branch. Tests a single bit in SREG and branches
+ *  relatively to PC if the bit is set. This instruction branches relatively to
+ *  PC in either direction (PC - 63 < = destination <= PC + 64). The parameter k
+ *  is the offset from PC and is represented in two's complement form.
+ */
+static bool trans_BRBS(DisasContext *ctx, arg_BRBS *a)
+{
+    TCGLabel *not_taken = gen_new_label();
+
+    TCGv var;
+
+    switch (a->bit) {
+    case 0x00:
+        var = cpu_Cf;
+        break;
+    case 0x01:
+        var = cpu_Zf;
+        break;
+    case 0x02:
+        var = cpu_Nf;
+        break;
+    case 0x03:
+        var = cpu_Vf;
+        break;
+    case 0x04:
+        var = cpu_Sf;
+        break;
+    case 0x05:
+        var = cpu_Hf;
+        break;
+    case 0x06:
+        var = cpu_Tf;
+        break;
+    case 0x07:
+        var = cpu_If;
+        break;
+    default:
+        g_assert_not_reached();
+    }
+
+    tcg_gen_brcondi_i32(TCG_COND_EQ, var, 0, not_taken);
+    gen_goto_tb(ctx, 0, ctx->npc + a->imm);
+    gen_set_label(not_taken);
+
+    ctx->bstate = DISAS_CHAIN;
+    return true;
+}
+
-- 
2.17.2 (Apple Git-113)


