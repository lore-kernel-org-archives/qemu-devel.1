Return-Path: <SRS0=QAbx=Z6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EFF6C43603
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Dec 2019 18:52:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1B18205F4
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Dec 2019 18:52:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m1OISj/j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1B18205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60834 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ie1fa-0000Ca-N5
	for qemu-devel@archiver.kernel.org; Sun, 08 Dec 2019 13:52:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37373)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mrolnik@gmail.com>) id 1ie1Tc-000291-Nw
 for qemu-devel@nongnu.org; Sun, 08 Dec 2019 13:40:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mrolnik@gmail.com>) id 1ie1Ta-000356-94
 for qemu-devel@nongnu.org; Sun, 08 Dec 2019 13:40:16 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:54354)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mrolnik@gmail.com>) id 1ie1TW-0002wG-7o
 for qemu-devel@nongnu.org; Sun, 08 Dec 2019 13:40:10 -0500
Received: by mail-wm1-x342.google.com with SMTP id b11so13055474wmj.4
 for <qemu-devel@nongnu.org>; Sun, 08 Dec 2019 10:40:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=kZBpxCgzIC+C1X9muObPG8CPgg8VuYI1BqThw6k+0nY=;
 b=m1OISj/jzA6jkFP0HxX4gcoEXtBH+FhzSs32pmiGNpfHe6DcbUe6WKdO5BskecSMMF
 AA4p/C/AB+XrhyI0VNFeKBT7j83t9IU71nw10vCJDB6EfTD7lxe/HhmFgUMtLAEA4EiQ
 Xkv/BqyNtJ59KCi5bwnb3z8viexGsDE+97he2jPlEc+DPfW6TccxWKBHlWtzOrSSBRjp
 qAEdIy0VoXTog5ZB2PuCdS8Gohlv4MIaerabw8UjxnR3cwVZh1cfdelL2leJBwnAnEHJ
 8aR4CgBWY6EmDk6NCSAWfvoLL0E7VJT8ztSIZEpsd9bxrRVuOJQzqeEo3souBMIGfA3b
 j+WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=kZBpxCgzIC+C1X9muObPG8CPgg8VuYI1BqThw6k+0nY=;
 b=XEqYAXg2xUhvyo60kjWsZM1km0HielGRyYudRbUZKku/QJ+C+GPmS1Y1gjpMweZY4i
 jLRK6dD3/xvcUnh2Ped8tiQ+2cp5sNYTmPXV7wbLfCx6lY1NLEqiwq46VhiDhC2xxHK3
 axcSU5y83L73AfGUUDkysmE0AcP20dt9+y/7Cks6rXEF9K0YCDa5yfE+hZhnv5NCPDXn
 NFL/5M3uYSAuHOBHee/AaY/HMrcXrz1MlWA2kAbcr/UHioHjlYa/clSHCWldVSvU3BBF
 RKI4VawerZXTQhDaww7o48I68Bn8BotJvqJON93Pk2lzmzrz8Ol45bEHmQ+LxSb5vG0J
 HAIw==
X-Gm-Message-State: APjAAAW9UN1vKdjSTjAhrneC0/AM9B0PcYGEWZgFTxjVowKCdtDHYBi6
 FEdOq9Cac9WLjZwH+ijxphzhHeVkcuaOZDHH
X-Google-Smtp-Source: APXvYqy5AGKBhfdlxnh0VUQmil0RWpc9ZQIK8BxKxLCUvTXX/0XLynVKv3xJRrDbQ+KMdl+HSNnTig==
X-Received: by 2002:a1c:81c9:: with SMTP id c192mr20970484wmd.44.1575830405550; 
 Sun, 08 Dec 2019 10:40:05 -0800 (PST)
Received: from 8c859074c0ff.ant.amazon.com.com
 (bzq-79-180-52-3.red.bezeqint.net. [79.180.52.3])
 by smtp.gmail.com with ESMTPSA id h17sm25289717wrs.18.2019.12.08.10.40.03
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Sun, 08 Dec 2019 10:40:05 -0800 (PST)
From: Michael Rolnik <mrolnik@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v38 06/22] target/avr: Add instruction translation - Branch
 Instructions
Date: Sun,  8 Dec 2019 20:39:06 +0200
Message-Id: <20191208183922.13757-7-mrolnik@gmail.com>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
In-Reply-To: <20191208183922.13757-1-mrolnik@gmail.com>
References: <20191208183922.13757-1-mrolnik@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
 target/avr/translate.c | 537 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 537 insertions(+)

diff --git a/target/avr/translate.c b/target/avr/translate.c
index 1d6e4a55f2..8eb39a868d 100644
--- a/target/avr/translate.c
+++ b/target/avr/translate.c
@@ -233,6 +233,86 @@ static void gen_ZNSf(TCGv R)
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
@@ -875,3 +955,460 @@ static bool trans_DES(DisasContext *ctx, arg_DES *a)
 
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
+    tcg_gen_sub_tl(R, Rd, Rr); /* R = Rd - Rr - Cf */
+    tcg_gen_sub_tl(R, R, cpu_Cf);
+    tcg_gen_andi_tl(R, R, 0xff); /* make it 8 bits */
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
+    tcg_gen_sub_tl(R, Rd, Rr); /* R = Rd - Rr */
+    tcg_gen_andi_tl(R, R, 0xff); /* make it 8 bits */
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


