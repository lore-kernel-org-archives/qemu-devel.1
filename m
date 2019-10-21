Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9AB0CA9EB7
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 22:44:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6F2120882
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 22:44:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bKJ6dcQg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6F2120882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48570 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMgPi-0001u5-Kf
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 18:44:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51919)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mrolnik@gmail.com>) id 1iMgJA-0001fA-Nz
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 18:37:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mrolnik@gmail.com>) id 1iMgJ8-0000zU-4d
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 18:37:48 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335]:39451)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mrolnik@gmail.com>) id 1iMgJ7-0000zG-S5
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 18:37:46 -0400
Received: by mail-wm1-x335.google.com with SMTP id r141so4699717wme.4
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2019 15:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=XG7YdKK9LZ8El7jVSA8PZRo1OwXcCqUg8kDdapoU5bw=;
 b=bKJ6dcQg8q4vCi/oC0M2xeKnAAQQBaCMBAXSuMBhi8ejI2Dnc6qjDFAbXSML6WZ2u5
 oWpe1iW82US/CwejRSIaqDzZSLxRGJGVyTyEV0pyPKno14Nv9xkQSIyUSH9pS5U76XFv
 odhvjEl2Pg2G2PsOB2hvJt4cJPS75+2Or6bN3p1lmlFTFIpVbodU5MQr/bxne2fg1K0x
 ZaYMcHHWGAUdGI2vAdK9g24G1+1/iz5/2JcL+AFA77Ed6tluqpHhPejHgH+GfyV/OO/y
 9TuD+G+1HO5k1PptDe070wPCh9QVBrlioGaL+cSXHlapO1eRq/gbEtsDg4EstzXdHZMO
 iMXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=XG7YdKK9LZ8El7jVSA8PZRo1OwXcCqUg8kDdapoU5bw=;
 b=uQY+GAO6gfs0WcuC08UHIWDdMnTJwBi07v5iVoRCcUbNRugmoLYhr+FbAkoH6fkF43
 z8Xv3wpaBqV99sPQ4XvOpoR8eB8GwgizP1wQN0UP98wrqLxfUcSnSQ6eMPvE0/nbKYL/
 MWghjRquve3PJKZhm4Cg3uWPQ6u6971SNhQnATydBRdTC2E60s7vOaouodNvNrcGAZu8
 /gfzTI5ZmN3oGaq+r1tbpoWYY0RVkLqOBYTL5i3yUhO7k2eq5rbrjuVxj2RGv25Uoqws
 pFO0cf4b6SCaO/9ypmClOZl70nHRztalhaLvun3WXLAi6HNA1bhrcwnUpePBwZ+OKSoj
 xYZA==
X-Gm-Message-State: APjAAAWtZVsNqIjXIPfsFV/IsRK+VNytGBf/oj6lWYAPeUz+BDZV8k7T
 No8HXAXDFjwDu7yy+2w7rAnLw/OvCv61ZQ==
X-Google-Smtp-Source: APXvYqxkeI9M1gdqvvqLZypI36y3yvGRsaKMEcTsXcFvbiwVkhi8Vunj3z2GvqqTsuuw2HCSGsyCxA==
X-Received: by 2002:a1c:a70e:: with SMTP id q14mr193606wme.86.1571697464083;
 Mon, 21 Oct 2019 15:37:44 -0700 (PDT)
Received: from 8c859074c0ff.ant.amazon.com.com
 (bzq-109-65-50-254.red.bezeqint.net. [109.65.50.254])
 by smtp.gmail.com with ESMTPSA id q66sm16951271wme.39.2019.10.21.15.37.42
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Mon, 21 Oct 2019 15:37:43 -0700 (PDT)
From: Michael Rolnik <mrolnik@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v33 05/13] target/avr: Add instruction translation -
 Arithmetic and Logic Instructions
Date: Tue, 22 Oct 2019 01:37:03 +0300
Message-Id: <20191021223711.66955-6-mrolnik@gmail.com>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
In-Reply-To: <20191021223711.66955-1-mrolnik@gmail.com>
References: <20191021223711.66955-1-mrolnik@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::335
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
 richard.henderson@linaro.org, dovgaluk@ispras.ru, imammedo@redhat.com,
 philmd@redhat.com, aleksandar.m.mail@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This includes:
- ADD, ADC, ADIW
- SBIW, SUB, SUBI, SBC, SBCI
- AND, ANDI
- OR, ORI, EOR
- COM, NEG
- INC, DEC
- MUL, MULS, MULSU
- FMUL, FMULS, FMULSU
- DES

Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
---
 target/avr/translate.c | 811 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 811 insertions(+)

diff --git a/target/avr/translate.c b/target/avr/translate.c
index 53c9892a60..3eaa3e5099 100644
--- a/target/avr/translate.c
+++ b/target/avr/translate.c
@@ -130,3 +130,814 @@ static bool avr_have_feature(DisasContext *ctx, int feature)
 static bool decode_insn(DisasContext *ctx, uint16_t insn);
 #include "decode_insn.inc.c"
 
+
+static void gen_add_CHf(TCGv R, TCGv Rd, TCGv Rr)
+{
+    TCGv t1 = tcg_temp_new_i32();
+    TCGv t2 = tcg_temp_new_i32();
+    TCGv t3 = tcg_temp_new_i32();
+
+    tcg_gen_and_tl(t1, Rd, Rr); /* t1 = Rd & Rr */
+    tcg_gen_andc_tl(t2, Rd, R); /* t2 = Rd & ~R */
+    tcg_gen_andc_tl(t3, Rr, R); /* t3 = Rr & ~R */
+    tcg_gen_or_tl(t1, t1, t2); /* t1 = t1 | t2 | t3 */
+    tcg_gen_or_tl(t1, t1, t3);
+
+    tcg_gen_shri_tl(cpu_Cf, t1, 7); /* Cf = t1(7) */
+    tcg_gen_shri_tl(cpu_Hf, t1, 3); /* Hf = t1(3) */
+    tcg_gen_andi_tl(cpu_Hf, cpu_Hf, 1);
+
+    tcg_temp_free_i32(t3);
+    tcg_temp_free_i32(t2);
+    tcg_temp_free_i32(t1);
+}
+
+
+static void gen_add_Vf(TCGv R, TCGv Rd, TCGv Rr)
+{
+    TCGv t1 = tcg_temp_new_i32();
+    TCGv t2 = tcg_temp_new_i32();
+
+    /* t1 = Rd & Rr & ~R | ~Rd & ~Rr & R = (Rd ^ R) & ~(Rd ^ Rr) */
+    tcg_gen_xor_tl(t1, Rd, R);
+    tcg_gen_xor_tl(t2, Rd, Rr);
+    tcg_gen_andc_tl(t1, t1, t2);
+
+    tcg_gen_shri_tl(cpu_Vf, t1, 7); /* Vf = t1(7) */
+
+    tcg_temp_free_i32(t2);
+    tcg_temp_free_i32(t1);
+}
+
+
+static void gen_sub_CHf(TCGv R, TCGv Rd, TCGv Rr)
+{
+    TCGv t1 = tcg_temp_new_i32();
+    TCGv t2 = tcg_temp_new_i32();
+    TCGv t3 = tcg_temp_new_i32();
+
+    /* Cf & Hf */
+    tcg_gen_not_tl(t1, Rd); /* t1 = ~Rd */
+    tcg_gen_and_tl(t2, t1, Rr); /* t2 = ~Rd & Rr */
+    tcg_gen_or_tl(t3, t1, Rr); /* t3 = (~Rd | Rr) & R */
+    tcg_gen_and_tl(t3, t3, R);
+    tcg_gen_or_tl(t2, t2, t3); /* t2 = ~Rd & Rr | ~Rd & R | R & Rr */
+    tcg_gen_shri_tl(cpu_Cf, t2, 7); /* Cf = t2(7) */
+    tcg_gen_shri_tl(cpu_Hf, t2, 3); /* Hf = t2(3) */
+    tcg_gen_andi_tl(cpu_Hf, cpu_Hf, 1);
+
+    tcg_temp_free_i32(t3);
+    tcg_temp_free_i32(t2);
+    tcg_temp_free_i32(t1);
+}
+
+
+static void gen_sub_Vf(TCGv R, TCGv Rd, TCGv Rr)
+{
+    TCGv t1 = tcg_temp_new_i32();
+    TCGv t2 = tcg_temp_new_i32();
+
+    /* Vf */
+    /* t1 = Rd & ~Rr & ~R | ~Rd & Rr & R = (Rd ^ R) & (Rd ^ R) */
+    tcg_gen_xor_tl(t1, Rd, R);
+    tcg_gen_xor_tl(t2, Rd, Rr);
+    tcg_gen_and_tl(t1, t1, t2);
+    tcg_gen_shri_tl(cpu_Vf, t1, 7); /* Vf = t1(7) */
+
+    tcg_temp_free_i32(t2);
+    tcg_temp_free_i32(t1);
+}
+
+
+static void gen_NSf(TCGv R)
+{
+    tcg_gen_shri_tl(cpu_Nf, R, 7); /* Nf = R(7) */
+    tcg_gen_xor_tl(cpu_Sf, cpu_Nf, cpu_Vf); /* Sf = Nf ^ Vf */
+}
+
+
+static void gen_ZNSf(TCGv R)
+{
+    tcg_gen_mov_tl(cpu_Zf, R); /* Zf = R */
+    tcg_gen_shri_tl(cpu_Nf, R, 7); /* Nf = R(7) */
+    tcg_gen_xor_tl(cpu_Sf, cpu_Nf, cpu_Vf); /* Sf = Nf ^ Vf */
+}
+
+
+/*
+ *  Adds two registers without the C Flag and places the result in the
+ *  destination register Rd.
+ */
+static bool trans_ADD(DisasContext *ctx, arg_ADD *a)
+{
+    TCGv Rd = cpu_r[a->rd];
+    TCGv Rr = cpu_r[a->rr];
+    TCGv R = tcg_temp_new_i32();
+
+    /* op */
+    tcg_gen_add_tl(R, Rd, Rr); /* Rd = Rd + Rr */
+    tcg_gen_andi_tl(R, R, 0xff); /* make it 8 bits */
+
+    gen_add_CHf(R, Rd, Rr);
+    gen_add_Vf(R, Rd, Rr);
+    gen_ZNSf(R);
+
+    /* R */
+    tcg_gen_mov_tl(Rd, R);
+
+    tcg_temp_free_i32(R);
+
+    return true;
+}
+
+
+/*
+ *  Adds two registers and the contents of the C Flag and places the result in
+ *  the destination register Rd.
+ */
+static bool trans_ADC(DisasContext *ctx, arg_ADC *a)
+{
+    TCGv Rd = cpu_r[a->rd];
+    TCGv Rr = cpu_r[a->rr];
+    TCGv R = tcg_temp_new_i32();
+
+    /* op */
+    tcg_gen_add_tl(R, Rd, Rr); /* R = Rd + Rr + Cf */
+    tcg_gen_add_tl(R, R, cpu_Cf);
+    tcg_gen_andi_tl(R, R, 0xff); /* make it 8 bits */
+
+    gen_add_CHf(R, Rd, Rr);
+    gen_add_Vf(R, Rd, Rr);
+    gen_ZNSf(R);
+
+    /* R */
+    tcg_gen_mov_tl(Rd, R);
+
+    tcg_temp_free_i32(R);
+
+    return true;
+}
+
+
+/*
+ *  Subtracts an immediate value (0-63) from a register pair and places the
+ *  result in the register pair. This instruction operates on the upper four
+ *  register pairs, and is well suited for operations on the Pointer Registers.
+ *  This instruction is not available in all devices. Refer to the device
+ *  specific instruction set summary.
+ */
+static bool trans_SBIW(DisasContext *ctx, arg_SBIW *a)
+{
+    if (!avr_have_feature(ctx, AVR_FEATURE_ADIW_SBIW)) {
+        return true;
+    }
+
+    TCGv RdL = cpu_r[a->rd];
+    TCGv RdH = cpu_r[a->rd + 1];
+    int Imm = (a->imm);
+    TCGv R = tcg_temp_new_i32();
+    TCGv Rd = tcg_temp_new_i32();
+
+    /* op */
+    tcg_gen_deposit_tl(Rd, RdL, RdH, 8, 8); /* Rd = RdH:RdL */
+    tcg_gen_subi_tl(R, Rd, Imm); /* R = Rd - Imm */
+    tcg_gen_andi_tl(R, R, 0xffff); /* make it 16 bits */
+
+    /* Cf */
+    tcg_gen_andc_tl(cpu_Cf, R, Rd);
+    tcg_gen_shri_tl(cpu_Cf, cpu_Cf, 15); /* Cf = R & ~Rd */
+
+    /* Vf */
+    tcg_gen_andc_tl(cpu_Vf, Rd, R);
+    tcg_gen_shri_tl(cpu_Vf, cpu_Vf, 15); /* Vf = Rd & ~R */
+
+    /* Zf */
+    tcg_gen_mov_tl(cpu_Zf, R); /* Zf = R */
+
+    /* Nf */
+    tcg_gen_shri_tl(cpu_Nf, R, 15); /* Nf = R(15) */
+
+    /* Sf */
+    tcg_gen_xor_tl(cpu_Sf, cpu_Nf, cpu_Vf); /* Sf = Nf ^ Vf */
+
+    /* R */
+    tcg_gen_andi_tl(RdL, R, 0xff);
+    tcg_gen_shri_tl(RdH, R, 8);
+
+    tcg_temp_free_i32(Rd);
+    tcg_temp_free_i32(R);
+
+    return true;
+}
+
+
+/*
+ *  Adds an immediate value (0 - 63) to a register pair and places the result
+ *  in the register pair. This instruction operates on the upper four register
+ *  pairs, and is well suited for operations on the pointer registers.  This
+ *  instruction is not available in all devices. Refer to the device specific
+ *  instruction set summary.
+ */
+static bool trans_ADIW(DisasContext *ctx, arg_ADIW *a)
+{
+    if (!avr_have_feature(ctx, AVR_FEATURE_ADIW_SBIW)) {
+        return true;
+    }
+
+    TCGv RdL = cpu_r[a->rd];
+    TCGv RdH = cpu_r[a->rd + 1];
+    int Imm = (a->imm);
+    TCGv R = tcg_temp_new_i32();
+    TCGv Rd = tcg_temp_new_i32();
+
+    /* op */
+    tcg_gen_deposit_tl(Rd, RdL, RdH, 8, 8); /* Rd = RdH:RdL */
+    tcg_gen_addi_tl(R, Rd, Imm); /* R = Rd + Imm */
+    tcg_gen_andi_tl(R, R, 0xffff); /* make it 16 bits */
+
+    /* Cf */
+    tcg_gen_andc_tl(cpu_Cf, Rd, R); /* Cf = Rd & ~R */
+    tcg_gen_shri_tl(cpu_Cf, cpu_Cf, 15);
+
+    /* Vf */
+    tcg_gen_andc_tl(cpu_Vf, R, Rd); /* Vf = R & ~Rd */
+    tcg_gen_shri_tl(cpu_Vf, cpu_Vf, 15);
+
+    /* Zf */
+    tcg_gen_mov_tl(cpu_Zf, R); /* Zf = R */
+
+    /* Nf */
+    tcg_gen_shri_tl(cpu_Nf, R, 15); /* Nf = R(15) */
+
+    /* Sf */
+    tcg_gen_xor_tl(cpu_Sf, cpu_Nf, cpu_Vf);/* Sf = Nf ^ Vf */
+
+    /* R */
+    tcg_gen_andi_tl(RdL, R, 0xff);
+    tcg_gen_shri_tl(RdH, R, 8);
+
+    tcg_temp_free_i32(Rd);
+    tcg_temp_free_i32(R);
+
+    return true;
+}
+
+
+/*
+ *  Subtracts two registers and places the result in the destination
+ *  register Rd.
+ */
+static bool trans_SUB(DisasContext *ctx, arg_SUB *a)
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
+    /* R */
+    tcg_gen_mov_tl(Rd, R);
+
+    tcg_temp_free_i32(R);
+
+    return true;
+}
+
+/*
+ *  Subtracts a register and a constant and places the result in the
+ *  destination register Rd. This instruction is working on Register R16 to R31
+ *  and is very well suited for operations on the X, Y, and Z-pointers.
+ */
+static bool trans_SUBI(DisasContext *ctx, arg_SUBI *a)
+{
+    TCGv Rd = cpu_r[a->rd];
+    TCGv Rr = tcg_const_i32(a->imm);
+    TCGv R = tcg_temp_new_i32();
+
+    /* op */
+    tcg_gen_sub_tl(R, Rd, Rr); /* R = Rd - Imm */
+    tcg_gen_andi_tl(R, R, 0xff); /* make it 8 bits */
+
+    gen_sub_CHf(R, Rd, Rr);
+    gen_sub_Vf(R, Rd, Rr);
+    gen_ZNSf(R);
+
+    /* R */
+    tcg_gen_mov_tl(Rd, R);
+
+    tcg_temp_free_i32(R);
+    tcg_temp_free_i32(Rr);
+
+    return true;
+}
+
+
+/*
+ *  Subtracts two registers and subtracts with the C Flag and places the
+ *  result in the destination register Rd.
+ */
+static bool trans_SBC(DisasContext *ctx, arg_SBC *a)
+{
+    TCGv Rd = cpu_r[a->rd];
+    TCGv Rr = cpu_r[a->rr];
+    TCGv R = tcg_temp_new_i32();
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
+    tcg_gen_or_tl(cpu_Zf, cpu_Zf, R);
+
+    /* R */
+    tcg_gen_mov_tl(Rd, R);
+
+    tcg_temp_free_i32(R);
+
+    return true;
+}
+
+
+/*
+ *  SBCI -- Subtract Immediate with Carry
+ */
+static bool trans_SBCI(DisasContext *ctx, arg_SBCI *a)
+{
+    TCGv Rd = cpu_r[a->rd];
+    TCGv Rr = tcg_const_i32(a->imm);
+    TCGv R = tcg_temp_new_i32();
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
+    tcg_gen_or_tl(cpu_Zf, cpu_Zf, R);
+
+    /* R */
+    tcg_gen_mov_tl(Rd, R);
+
+    tcg_temp_free_i32(R);
+    tcg_temp_free_i32(Rr);
+
+    return true;
+}
+
+
+/*
+ *  Performs the logical AND between the contents of register Rd and register
+ *  Rr and places the result in the destination register Rd.
+ */
+static bool trans_AND(DisasContext *ctx, arg_AND *a)
+{
+    TCGv Rd = cpu_r[a->rd];
+    TCGv Rr = cpu_r[a->rr];
+    TCGv R = tcg_temp_new_i32();
+
+    /* op */
+    tcg_gen_and_tl(R, Rd, Rr); /* Rd = Rd and Rr */
+
+    /* Vf */
+    tcg_gen_movi_tl(cpu_Vf, 0x00); /* Vf = 0 */
+
+    /* Zf */
+    tcg_gen_mov_tl(cpu_Zf, R); /* Zf = R */
+
+    gen_ZNSf(R);
+
+    /* R */
+    tcg_gen_mov_tl(Rd, R);
+
+    tcg_temp_free_i32(R);
+
+    return true;
+}
+
+
+/*
+ *  Performs the logical AND between the contents of register Rd and a constant
+ *  and places the result in the destination register Rd.
+ */
+static bool trans_ANDI(DisasContext *ctx, arg_ANDI *a)
+{
+    TCGv Rd = cpu_r[a->rd];
+    int Imm = (a->imm);
+
+    /* op */
+    tcg_gen_andi_tl(Rd, Rd, Imm); /* Rd = Rd & Imm */
+
+    tcg_gen_movi_tl(cpu_Vf, 0x00); /* Vf = 0 */
+    gen_ZNSf(Rd);
+
+    return true;
+}
+
+
+/*
+ *  Performs the logical OR between the contents of register Rd and register
+ *  Rr and places the result in the destination register Rd.
+ */
+static bool trans_OR(DisasContext *ctx, arg_OR *a)
+{
+    TCGv Rd = cpu_r[a->rd];
+    TCGv Rr = cpu_r[a->rr];
+    TCGv R = tcg_temp_new_i32();
+
+    tcg_gen_or_tl(R, Rd, Rr);
+
+    tcg_gen_movi_tl(cpu_Vf, 0);
+    gen_ZNSf(R);
+
+    tcg_gen_mov_tl(Rd, R);
+
+    tcg_temp_free_i32(R);
+
+    return true;
+}
+
+
+/*
+ *  Performs the logical OR between the contents of register Rd and a
+ *  constant and places the result in the destination register Rd.
+ */
+static bool trans_ORI(DisasContext *ctx, arg_ORI *a)
+{
+    TCGv Rd = cpu_r[a->rd];
+    int Imm = (a->imm);
+
+    tcg_gen_ori_tl(Rd, Rd, Imm); /* Rd = Rd | Imm */
+
+    tcg_gen_movi_tl(cpu_Vf, 0x00); /* Vf = 0 */
+    gen_ZNSf(Rd);
+
+    return true;
+}
+
+
+/*
+ *  Performs the logical EOR between the contents of register Rd and
+ *  register Rr and places the result in the destination register Rd.
+ */
+static bool trans_EOR(DisasContext *ctx, arg_EOR *a)
+{
+    TCGv Rd = cpu_r[a->rd];
+    TCGv Rr = cpu_r[a->rr];
+
+    tcg_gen_xor_tl(Rd, Rd, Rr);
+
+    tcg_gen_movi_tl(cpu_Vf, 0);
+    gen_ZNSf(Rd);
+
+    return true;
+}
+
+
+/*
+ *  Clears the specified bits in register Rd. Performs the logical AND
+ *  between the contents of register Rd and the complement of the constant mask
+ *  K. The result will be placed in register Rd.
+ */
+static bool trans_COM(DisasContext *ctx, arg_COM *a)
+{
+    TCGv Rd = cpu_r[a->rd];
+    TCGv R = tcg_temp_new_i32();
+
+    tcg_gen_xori_tl(Rd, Rd, 0xff);
+
+    tcg_gen_movi_tl(cpu_Cf, 1); /* Cf = 1 */
+    tcg_gen_movi_tl(cpu_Vf, 0); /* Vf = 0 */
+    gen_ZNSf(Rd);
+
+    tcg_temp_free_i32(R);
+
+    return true;
+}
+
+
+/*
+ *  Replaces the contents of register Rd with its two's complement; the
+ *  value $80 is left unchanged.
+ */
+static bool trans_NEG(DisasContext *ctx, arg_NEG *a)
+{
+    TCGv Rd = cpu_r[a->rd];
+    TCGv t0 = tcg_const_i32(0);
+    TCGv R = tcg_temp_new_i32();
+
+    /* op */
+    tcg_gen_sub_tl(R, t0, Rd); /* R = 0 - Rd */
+    tcg_gen_andi_tl(R, R, 0xff); /* make it 8 bits */
+
+    gen_sub_CHf(R, t0, Rd);
+    gen_sub_Vf(R, t0, Rd);
+    gen_ZNSf(R);
+
+    /* R */
+    tcg_gen_mov_tl(Rd, R);
+
+    tcg_temp_free_i32(t0);
+    tcg_temp_free_i32(R);
+
+    return true;
+}
+
+
+/*
+ *  Adds one -1- to the contents of register Rd and places the result in the
+ *  destination register Rd.  The C Flag in SREG is not affected by the
+ *  operation, thus allowing the INC instruction to be used on a loop counter in
+ *  multiple-precision computations.  When operating on unsigned numbers, only
+ *  BREQ and BRNE branches can be expected to perform consistently. When
+ *  operating on two's complement values, all signed branches are available.
+ */
+static bool trans_INC(DisasContext *ctx, arg_INC *a)
+{
+    TCGv Rd = cpu_r[a->rd];
+
+    tcg_gen_addi_tl(Rd, Rd, 1);
+    tcg_gen_andi_tl(Rd, Rd, 0xff);
+
+    /* cpu_Vf = Rd == 0x80 */
+    tcg_gen_setcondi_tl(TCG_COND_EQ, cpu_Vf, Rd, 0x80);
+    gen_ZNSf(Rd);
+
+    return true;
+}
+
+
+/*
+ *  Subtracts one -1- from the contents of register Rd and places the result
+ *  in the destination register Rd.  The C Flag in SREG is not affected by the
+ *  operation, thus allowing the DEC instruction to be used on a loop counter in
+ *  multiple-precision computations.  When operating on unsigned values, only
+ *  BREQ and BRNE branches can be expected to perform consistently.  When
+ *  operating on two's complement values, all signed branches are available.
+ */
+static bool trans_DEC(DisasContext *ctx, arg_DEC *a)
+{
+    TCGv Rd = cpu_r[a->rd];
+
+    tcg_gen_subi_tl(Rd, Rd, 1); /* Rd = Rd - 1 */
+    tcg_gen_andi_tl(Rd, Rd, 0xff); /* make it 8 bits */
+
+    /* cpu_Vf = Rd == 0x7f */
+    tcg_gen_setcondi_tl(TCG_COND_EQ, cpu_Vf, Rd, 0x7f);
+    gen_ZNSf(Rd);
+
+    return true;
+}
+
+
+/*
+ *  This instruction performs 8-bit x 8-bit -> 16-bit unsigned multiplication.
+ */
+static bool trans_MUL(DisasContext *ctx, arg_MUL *a)
+{
+    if (!avr_have_feature(ctx, AVR_FEATURE_MUL)) {
+        return true;
+    }
+
+    TCGv R0 = cpu_r[0];
+    TCGv R1 = cpu_r[1];
+    TCGv Rd = cpu_r[a->rd];
+    TCGv Rr = cpu_r[a->rr];
+    TCGv R = tcg_temp_new_i32();
+
+    tcg_gen_mul_tl(R, Rd, Rr); /* R = Rd *Rr */
+
+    tcg_gen_andi_tl(R0, R, 0xff);
+    tcg_gen_shri_tl(R1, R, 8);
+
+    tcg_gen_shri_tl(cpu_Cf, R, 15); /* Cf = R(16) */
+    tcg_gen_mov_tl(cpu_Zf, R);
+
+    tcg_temp_free_i32(R);
+
+    return true;
+}
+
+
+/*
+ *  This instruction performs 8-bit x 8-bit -> 16-bit signed multiplication.
+ */
+static bool trans_MULS(DisasContext *ctx, arg_MULS *a)
+{
+    if (!avr_have_feature(ctx, AVR_FEATURE_MUL)) {
+        return true;
+    }
+
+    TCGv R0 = cpu_r[0];
+    TCGv R1 = cpu_r[1];
+    TCGv Rd = cpu_r[a->rd];
+    TCGv Rr = cpu_r[a->rr];
+    TCGv R = tcg_temp_new_i32();
+    TCGv t0 = tcg_temp_new_i32();
+    TCGv t1 = tcg_temp_new_i32();
+
+    tcg_gen_ext8s_tl(t0, Rd); /* make Rd full 32 bit signed */
+    tcg_gen_ext8s_tl(t1, Rr); /* make Rr full 32 bit signed */
+    tcg_gen_mul_tl(R, t0, t1); /* R = Rd * Rr */
+
+    tcg_gen_andi_tl(R0, R, 0xff);
+    tcg_gen_shri_tl(R1, R, 8);
+
+    tcg_gen_shri_tl(cpu_Cf, R, 15); /* Cf = R(16) */
+    tcg_gen_mov_tl(cpu_Zf, R);
+
+    tcg_temp_free_i32(t1);
+    tcg_temp_free_i32(t0);
+    tcg_temp_free_i32(R);
+
+    return true;
+}
+
+
+/*
+ *  This instruction performs 8-bit x 8-bit -> 16-bit multiplication of a
+ *  signed and an unsigned number.
+ */
+static bool trans_MULSU(DisasContext *ctx, arg_MULSU *a)
+{
+    if (!avr_have_feature(ctx, AVR_FEATURE_MUL)) {
+        return true;
+    }
+
+    TCGv R0 = cpu_r[0];
+    TCGv R1 = cpu_r[1];
+    TCGv Rd = cpu_r[a->rd];
+    TCGv Rr = cpu_r[a->rr];
+    TCGv R = tcg_temp_new_i32();
+    TCGv t0 = tcg_temp_new_i32();
+
+    tcg_gen_ext8s_tl(t0, Rd); /* make Rd full 32 bit signed */
+    tcg_gen_mul_tl(R, t0, Rr); /* R = Rd *Rr */
+
+    tcg_gen_andi_tl(R0, R, 0xff);
+    tcg_gen_shri_tl(R1, R, 8);
+
+    tcg_gen_shri_tl(cpu_Cf, R, 16); /* Cf = R(16) */
+    tcg_gen_mov_tl(cpu_Zf, R);
+
+    tcg_temp_free_i32(t0);
+    tcg_temp_free_i32(R);
+
+    return true;
+}
+
+
+/*
+ *  This instruction performs 8-bit x 8-bit -> 16-bit unsigned
+ *  multiplication and shifts the result one bit left.
+ */
+static bool trans_FMUL(DisasContext *ctx, arg_FMUL *a)
+{
+    if (!avr_have_feature(ctx, AVR_FEATURE_MUL)) {
+        return true;
+    }
+
+    TCGv R0 = cpu_r[0];
+    TCGv R1 = cpu_r[1];
+    TCGv Rd = cpu_r[a->rd];
+    TCGv Rr = cpu_r[a->rr];
+    TCGv R = tcg_temp_new_i32();
+
+    tcg_gen_mul_tl(R, Rd, Rr); /* R = Rd *Rr */
+    tcg_gen_shli_tl(R, R, 1);
+
+    tcg_gen_andi_tl(R0, R, 0xff);
+    tcg_gen_shri_tl(R1, R, 8);
+    tcg_gen_andi_tl(R1, R1, 0xff);
+
+    tcg_gen_shri_tl(cpu_Cf, R, 16); /* Cf = R(16) */
+    tcg_gen_andi_tl(cpu_Zf, R, 0x0000ffff);
+
+    tcg_temp_free_i32(R);
+
+    return true;
+}
+
+
+/*
+ *  This instruction performs 8-bit x 8-bit -> 16-bit signed multiplication
+ *  and shifts the result one bit left.
+ */
+static bool trans_FMULS(DisasContext *ctx, arg_FMULS *a)
+{
+    if (!avr_have_feature(ctx, AVR_FEATURE_MUL)) {
+        return true;
+    }
+
+    TCGv R0 = cpu_r[0];
+    TCGv R1 = cpu_r[1];
+    TCGv Rd = cpu_r[a->rd];
+    TCGv Rr = cpu_r[a->rr];
+    TCGv R = tcg_temp_new_i32();
+    TCGv t0 = tcg_temp_new_i32();
+    TCGv t1 = tcg_temp_new_i32();
+
+    tcg_gen_ext8s_tl(t0, Rd); /* make Rd full 32 bit signed */
+    tcg_gen_ext8s_tl(t1, Rr); /* make Rr full 32 bit signed */
+    tcg_gen_mul_tl(R, t0, t1); /* R = Rd *Rr */
+    tcg_gen_shli_tl(R, R, 1);
+
+    tcg_gen_andi_tl(R0, R, 0xff);
+    tcg_gen_shri_tl(R1, R, 8);
+    tcg_gen_andi_tl(R1, R1, 0xff);
+
+    tcg_gen_shri_tl(cpu_Cf, R, 16); /* Cf = R(16) */
+    tcg_gen_andi_tl(cpu_Zf, R, 0x0000ffff);
+
+    tcg_temp_free_i32(t1);
+    tcg_temp_free_i32(t0);
+    tcg_temp_free_i32(R);
+
+    return true;
+}
+
+
+/*
+ *  This instruction performs 8-bit x 8-bit -> 16-bit signed multiplication
+ *  and shifts the result one bit left.
+ */
+static bool trans_FMULSU(DisasContext *ctx, arg_FMULSU *a)
+{
+    if (!avr_have_feature(ctx, AVR_FEATURE_MUL)) {
+        return true;
+    }
+
+    TCGv R0 = cpu_r[0];
+    TCGv R1 = cpu_r[1];
+    TCGv Rd = cpu_r[a->rd];
+    TCGv Rr = cpu_r[a->rr];
+    TCGv R = tcg_temp_new_i32();
+    TCGv t0 = tcg_temp_new_i32();
+
+    tcg_gen_ext8s_tl(t0, Rd); /* make Rd full 32 bit signed */
+    tcg_gen_mul_tl(R, t0, Rr); /* R = Rd *Rr */
+    tcg_gen_shli_tl(R, R, 1);
+
+    tcg_gen_andi_tl(R0, R, 0xff);
+    tcg_gen_shri_tl(R1, R, 8);
+    tcg_gen_andi_tl(R1, R1, 0xff);
+
+    tcg_gen_shri_tl(cpu_Cf, R, 16); /* Cf = R(16) */
+    tcg_gen_andi_tl(cpu_Zf, R, 0x0000ffff);
+
+    tcg_temp_free_i32(t0);
+    tcg_temp_free_i32(R);
+
+    return true;
+}
+
+
+/*
+ *  The module is an instruction set extension to the AVR CPU, performing
+ *  DES iterations. The 64-bit data block (plaintext or ciphertext) is placed in
+ *  the CPU register file, registers R0-R7, where LSB of data is placed in LSB
+ *  of R0 and MSB of data is placed in MSB of R7. The full 64-bit key (including
+ *  parity bits) is placed in registers R8- R15, organized in the register file
+ *  with LSB of key in LSB of R8 and MSB of key in MSB of R15. Executing one DES
+ *  instruction performs one round in the DES algorithm. Sixteen rounds must be
+ *  executed in increasing order to form the correct DES ciphertext or
+ *  plaintext. Intermediate results are stored in the register file (R0-R15)
+ *  after each DES instruction. The instruction's operand (K) determines which
+ *  round is executed, and the half carry flag (H) determines whether encryption
+ *  or decryption is performed.  The DES algorithm is described in
+ *  "Specifications for the Data Encryption Standard" (Federal Information
+ *  Processing Standards Publication 46). Intermediate results in this
+ *  implementation differ from the standard because the initial permutation and
+ *  the inverse initial permutation are performed each iteration. This does not
+ *  affect the result in the final ciphertext or plaintext, but reduces
+ *  execution time.
+ */
+static bool trans_DES(DisasContext *ctx, arg_DES *a)
+{
+    /* TODO */
+    if (!avr_have_feature(ctx, AVR_FEATURE_DES)) {
+        return true;
+    }
+
+    return true;
+}
-- 
2.17.2 (Apple Git-113)


