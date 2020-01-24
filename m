Return-Path: <SRS0=z9mi=3N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BC10C35240
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 00:54:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 264772071E
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 00:54:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D7GuR6VO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 264772071E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35984 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iunEv-0006Yg-8Z
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 19:54:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44204)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iunCR-0001MJ-2C
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 19:51:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iunCO-00054P-Hd
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 19:51:50 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:46055)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iunCO-000548-8N; Thu, 23 Jan 2020 19:51:48 -0500
Received: by mail-wr1-x441.google.com with SMTP id j42so44799wrj.12;
 Thu, 23 Jan 2020 16:51:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Pang8HeiRjtMtVwXSQPeTqHwVRGVae2lF4tULpzfSts=;
 b=D7GuR6VO1e+0aWS02JB1d/uJ0cBpJqfKIzKSpReoeA4bmlUZzQaj0jLhNEbbXv4li3
 CzwpB6c8OZoJAW7iTKr2lRjrx6yS/c+qjlL0+Wfvbk7UAKATqH8R0uXjomfmxSExzIkT
 hzElJBRJ1v0zPpUjmDXsx7ZmvENUEW2vYzm8CJc6FGLfT5WLypx9zmt+bw7BCrFA2qDt
 YeACRnkYp0Av68hjyhHl0dlwFSJRV/VZgJX9/+N8x+DkStBVS/BuONGBFqfZaRZ+8X24
 4INCZ7PcLOR6ehtDyN6Fj5IYKaWLqRffT5LUcoAzZSux44ymPQx3vMpEptxJxUG+zZk6
 w/KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=Pang8HeiRjtMtVwXSQPeTqHwVRGVae2lF4tULpzfSts=;
 b=s7msccIHGgyZYTDPaD4NZRvFt+1+9TSi6vrNooOvctj2Y8ZO9gz9FIK5Rg8BiW99re
 Oalrebf1vj16W8KMOvtjB+IEiUOuWSxCHeaZeC1f4euvAuF9VPUzNWdIn283mAKkcR3j
 Su4sIeJpUHlaIoSsT7ihA5dfS14oYIp/RfdBRpqktcM+qWOXmATqf7mo8IoLpHU7FNxs
 953ZezTYsryj7iJLo8Z4JUpmGchl8kvoxrohaLhbwmtmdbJNgkQzVW39fHdB1FostUWS
 73LSpveXBwGemOOgj6Q7Ym4/FtNY1idwhVY6WcOyN1pEwM6BsGAF34eYKTvl0OB5kpiu
 9ieQ==
X-Gm-Message-State: APjAAAXx7reG9Ye0hYP8atAE6nX6gRcBc+1OpL7/doMPja4cbdXl6oM4
 B9Fp7QjHpsazDR9VbsWZ3kPck49O
X-Google-Smtp-Source: APXvYqzps+4QaaBf6EBedldzLR52L3qV1B84NGE4UURtzVci3M3Dm8KxfWvn8kUb1XXv60SCnWFqFg==
X-Received: by 2002:adf:b648:: with SMTP id i8mr828861wre.91.1579827106840;
 Thu, 23 Jan 2020 16:51:46 -0800 (PST)
Received: from x1w.redhat.com (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id s139sm4598271wme.35.2020.01.23.16.51.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jan 2020 16:51:45 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org, mrolnik@gmail.com, richard.henderson@linaro.org,
 me@xcancerberox.com.ar
Subject: [PATCH rc2 05/25] target/avr: Add instruction translation - Branch
 Instructions
Date: Fri, 24 Jan 2020 01:51:11 +0100
Message-Id: <20200124005131.16276-6-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200124005131.16276-1-f4bug@amsat.org>
References: <20200124005131.16276-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
Cc: Laurent Vivier <lvivier@redhat.com>, Fam Zheng <fam@euphon.net>,
 S.E.Harris@kent.ac.uk, qemu-riscv@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, dovgaluk@ispras.ru,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, thuth@redhat.com,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, imammedo@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, aleksandar.m.mail@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Michael Rolnik <mrolnik@gmail.com>

This includes:
    - RJMP, IJMP, EIJMP, JMP
    - RCALL, ICALL, EICALL, CALL
    - RET, RETI
    - CPSE, CP, CPC, CPI
    - SBRC, SBRS, SBIC, SBIS
    - BRBC, BRBS

Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200118191416.19934-6-mrolnik@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/avr/translate.c | 532 +++++++++++++++++++++++++++++++++++++++++
 target/avr/insn.decode |  24 ++
 2 files changed, 556 insertions(+)

diff --git a/target/avr/translate.c b/target/avr/translate.c
index 00fb3f5350..3d4005740a 100644
--- a/target/avr/translate.c
+++ b/target/avr/translate.c
@@ -921,3 +921,535 @@ static bool trans_DES(DisasContext *ctx, arg_DES *a)
 
     return true;
 }
+
+/*
+ * Branch Instructions
+ */
+static void gen_jmp_ez(DisasContext *ctx)
+{
+    tcg_gen_deposit_tl(cpu_pc, cpu_r[30], cpu_r[31], 8, 8);
+    tcg_gen_or_tl(cpu_pc, cpu_pc, cpu_eind);
+    ctx->bstate = DISAS_LOOKUP;
+}
+
+static void gen_jmp_z(DisasContext *ctx)
+{
+    tcg_gen_deposit_tl(cpu_pc, cpu_r[30], cpu_r[31], 8, 8);
+    ctx->bstate = DISAS_LOOKUP;
+}
+
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
+    tcg_gen_sub_tl(R, Rd, Rr); /* R = Rd - Rr */
+    tcg_gen_andi_tl(R, R, 0xff); /* make it 8 bits */
+
+    /* update status register */
+    gen_sub_CHf(R, Rd, Rr);
+    gen_sub_Vf(R, Rd, Rr);
+    gen_ZNSf(R);
+
+    tcg_temp_free_i32(R);
+
+    return true;
+}
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
+    tcg_gen_sub_tl(R, Rd, Rr); /* R = Rd - Rr - Cf */
+    tcg_gen_sub_tl(R, R, cpu_Cf);
+    tcg_gen_andi_tl(R, R, 0xff); /* make it 8 bits */
+    /* update status register */
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
+    tcg_gen_sub_tl(R, Rd, Rr); /* R = Rd - Rr */
+    tcg_gen_andi_tl(R, R, 0xff); /* make it 8 bits */
+    /* update status register */
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
diff --git a/target/avr/insn.decode b/target/avr/insn.decode
index 9c71ed6b2f..32034c10d2 100644
--- a/target/avr/insn.decode
+++ b/target/avr/insn.decode
@@ -91,3 +91,27 @@ FMUL            0000 0011 0 ... 1 ...       @fmul
 FMULS           0000 0011 1 ... 0 ...       @fmul
 FMULSU          0000 0011 1 ... 1 ...       @fmul
 DES             1001 0100 imm:4 1011
+
+#
+# Branch Instructions
+#
+RJMP            1100 imm:s12
+IJMP            1001 0100 0000 1001
+EIJMP           1001 0100 0001 1001
+JMP             1001 010 ..... 110 .        imm=%imm_call
+RCALL           1101 imm:s12
+ICALL           1001 0101 0000 1001
+EICALL          1001 0101 0001 1001
+CALL            1001 010 ..... 111 .        imm=%imm_call
+RET             1001 0101 0000 1000
+RETI            1001 0101 0001 1000
+CPSE            0001 00 . ..... ....        @op_rd_rr
+CP              0001 01 . ..... ....        @op_rd_rr
+CPC             0000 01 . ..... ....        @op_rd_rr
+CPI             0011 .... .... ....         @op_rd_imm8
+SBRC            1111 110 rr:5 0 bit:3
+SBRS            1111 111 rr:5 0 bit:3
+SBIC            1001 1001 reg:5 bit:3
+SBIS            1001 1011 reg:5 bit:3
+BRBS            1111 00 ....... ...         @op_bit_imm
+BRBC            1111 01 ....... ...         @op_bit_imm
-- 
2.21.1


