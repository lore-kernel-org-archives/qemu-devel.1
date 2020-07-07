Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A2ABC433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 18:27:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A740206F6
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 18:27:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p8mvvc9O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A740206F6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46630 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jssJN-000609-JO
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 14:27:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35554)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jss9v-0007u3-Tg
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 14:17:35 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e]:41261)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jss9t-0002tT-3E
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 14:17:35 -0400
Received: by mail-wr1-x42e.google.com with SMTP id z15so34958001wrl.8
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2020 11:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=SkiEvpj1qU7pMjfNmb/mNjoUjaXvT1oW/AWCHEakDzA=;
 b=p8mvvc9OnxLqruyn9KqzonnprpBhYw4KenKgV45j5qLMaGKvUM1FsBj+jTjrizwM9L
 kIYXmL6J4F+X4Oz1f60Le/QcJcxcVJquxdvJOPLJBD3zsTLL6R8cxCd56ekogziKW/vN
 GTqlWoxPs0YNolYII2HSc/O7Q95zLYG8DdLKrmTgiWDd+Rluf83m4ewrKQOCVKXBvqJu
 HGSNfRpbsBJj2jkTxhXk2ycKv+1lmc2Jvdrm3dTFA1wSXhwjQoQvW6KWv6CFj92jY4l3
 ts71Bt/abqGVy6WKyGRTYyV4q0tyI1CoBFifgGoE3prx7HjFpgof+lQtYg+5wCPN6un5
 VMxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=SkiEvpj1qU7pMjfNmb/mNjoUjaXvT1oW/AWCHEakDzA=;
 b=nKy8T/4tdXP/H11AW+5IlGEIJBwZuBWBN36rP52EsvVtbuHl8xDJbwL7mZ/lS2WjNR
 sA8PqpbUaA7YnG2FDbt9iPtbkyXylqQm6i8ILD+XhIi/envjr4sCUL4YvQrm9oMcIvaM
 0h48ptuY28hbd6LAXTOspANWG4axgJvojLE+30moscyHf/f2Z1c0R63/2VG0+OpceZQE
 bsZT0wz7I7FlDVOpCW88urHaVRD+9MvCjggNfTDTpn6Y2u4hc1YLdxWgyEIoICK/czMa
 FjtwZqf7Jw1OCkG1N4amLXYqROnAqBUy8zGY/cJV8BCqBFejn1buGaOh2aVBS00UjYWC
 /wqw==
X-Gm-Message-State: AOAM5329m6FbiMsn9Y5Yav+TymGtnJbVzC3BTH3HLvglX0bFp2CQwO2o
 X1JDOzyEkpu8CKWy49zZok29i5Wq
X-Google-Smtp-Source: ABdhPJwtq86eW2F7gEU+Tk1FTbIttSEb8OhE9BOoNQxTUCU1TxVQBlaY8DuMe7DEWSFBruixTzOGYA==
X-Received: by 2002:a5d:4e8e:: with SMTP id e14mr52197155wru.134.1594145850894; 
 Tue, 07 Jul 2020 11:17:30 -0700 (PDT)
Received: from localhost.localdomain
 (138.red-83-57-170.dynamicip.rima-tde.net. [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id 65sm2253337wma.48.2020.07.07.11.17.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2020 11:17:30 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PULL 11/32] target/avr: Add instruction translation - Arithmetic and
 Logic Instructions
Date: Tue,  7 Jul 2020 20:16:49 +0200
Message-Id: <20200707181710.30950-12-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200707181710.30950-1-f4bug@amsat.org>
References: <20200707181710.30950-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x42e.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Laurent Vivier <lvivier@redhat.com>, Sarah Harris <S.E.Harris@kent.ac.uk>,
 Eduardo Habkost <ehabkost@redhat.com>, Thomas Huth <huth@tuxfamily.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Cleber Rosa <crosa@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Michael Rolnik <mrolnik@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Michael Rolnik <mrolnik@gmail.com>

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
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Signed-off-by: Thomas Huth <huth@tuxfamily.org>
Message-Id: <20200705140315.260514-12-huth@tuxfamily.org>
[PMD: Added qemu_log_mask(LOG_UNIMP) in trans_DES()]
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 target/avr/insn.decode |  76 ++++
 target/avr/translate.c | 820 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 896 insertions(+)
 create mode 100644 target/avr/insn.decode

diff --git a/target/avr/insn.decode b/target/avr/insn.decode
new file mode 100644
index 0000000000..94351ca787
--- /dev/null
+++ b/target/avr/insn.decode
@@ -0,0 +1,76 @@
+#
+# AVR instruction decode definitions.
+#
+# Copyright (c) 2019-2020 Michael Rolnik <mrolnik@gmail.com>
+#
+# This library is free software; you can redistribute it and/or
+# modify it under the terms of the GNU Lesser General Public
+# License as published by the Free Software Foundation; either
+# version 2.1 of the License, or (at your option) any later version.
+#
+# This library is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+# Lesser General Public License for more details.
+#
+# You should have received a copy of the GNU Lesser General Public
+# License along with this library; if not, see <http://www.gnu.org/licenses/>.
+#
+
+#
+#   regs_16_31_by_one = [16 .. 31]
+#   regs_16_23_by_one = [16 .. 23]
+#   regs_24_30_by_two = [24, 26, 28, 30]
+#   regs_00_30_by_two = [0, 2, 4, 6, 8, .. 30]
+
+%rd             4:5
+%rr             9:1 0:4
+
+%rd_a           4:4                         !function=to_regs_16_31_by_one
+%rd_b           4:3                         !function=to_regs_16_23_by_one
+%rd_c           4:2                         !function=to_regs_24_30_by_two
+%rr_a           0:4                         !function=to_regs_16_31_by_one
+%rr_b           0:3                         !function=to_regs_16_23_by_one
+
+%imm6           6:2 0:4
+%imm8           8:4 0:4
+
+%io_imm         9:2 0:4
+%ldst_d_imm     13:1 10:2 0:3
+
+
+&rd_rr          rd rr
+&rd_imm         rd imm
+
+@op_rd_rr       .... .. . ..... ....        &rd_rr      rd=%rd rr=%rr
+@op_rd_imm6     .... .... .. .. ....        &rd_imm     rd=%rd_c imm=%imm6
+@op_rd_imm8     .... .... .... ....         &rd_imm     rd=%rd_a imm=%imm8
+@fmul           .... .... . ... . ...       &rd_rr      rd=%rd_b rr=%rr_b
+
+#
+# Arithmetic Instructions
+#
+ADD             0000 11 . ..... ....        @op_rd_rr
+ADC             0001 11 . ..... ....        @op_rd_rr
+ADIW            1001 0110 .. .. ....        @op_rd_imm6
+SUB             0001 10 . ..... ....        @op_rd_rr
+SUBI            0101 .... .... ....         @op_rd_imm8
+SBC             0000 10 . ..... ....        @op_rd_rr
+SBCI            0100 .... .... ....         @op_rd_imm8
+SBIW            1001 0111 .. .. ....        @op_rd_imm6
+AND             0010 00 . ..... ....        @op_rd_rr
+ANDI            0111 .... .... ....         @op_rd_imm8
+OR              0010 10 . ..... ....        @op_rd_rr
+ORI             0110 .... .... ....         @op_rd_imm8
+EOR             0010 01 . ..... ....        @op_rd_rr
+COM             1001 010 rd:5 0000
+NEG             1001 010 rd:5 0001
+INC             1001 010 rd:5 0011
+DEC             1001 010 rd:5 1010
+MUL             1001 11 . ..... ....        @op_rd_rr
+MULS            0000 0010 .... ....         &rd_rr      rd=%rd_a rr=%rr_a
+MULSU           0000 0011 0 ... 0 ...       @fmul
+FMUL            0000 0011 0 ... 1 ...       @fmul
+FMULS           0000 0011 1 ... 0 ...       @fmul
+FMULSU          0000 0011 1 ... 1 ...       @fmul
+DES             1001 0100 imm:4 1011
diff --git a/target/avr/translate.c b/target/avr/translate.c
index f802e6b29c..fae9ed742d 100644
--- a/target/avr/translate.c
+++ b/target/avr/translate.c
@@ -128,6 +128,22 @@ struct DisasContext {
     bool free_skip_var0;
 };
 
+static int to_regs_16_31_by_one(DisasContext *ctx, int indx)
+{
+    return 16 + (indx % 16);
+}
+
+static int to_regs_16_23_by_one(DisasContext *ctx, int indx)
+{
+    return 16 + (indx % 8);
+}
+
+static int to_regs_24_30_by_two(DisasContext *ctx, int indx)
+{
+    return 24 + (indx % 4) * 2;
+}
+
+
 static bool avr_have_feature(DisasContext *ctx, int feature)
 {
     if (!avr_feature(ctx->env, feature)) {
@@ -140,3 +156,807 @@ static bool avr_have_feature(DisasContext *ctx, int feature)
 
 static bool decode_insn(DisasContext *ctx, uint16_t insn);
 #include "decode_insn.inc.c"
+
+/*
+ * Arithmetic Instructions
+ */
+
+/*
+ * Utility functions for updating status registers:
+ *
+ *   - gen_add_CHf()
+ *   - gen_add_Vf()
+ *   - gen_sub_CHf()
+ *   - gen_sub_Vf()
+ *   - gen_NSf()
+ *   - gen_ZNSf()
+ *
+ */
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
+static void gen_add_Vf(TCGv R, TCGv Rd, TCGv Rr)
+{
+    TCGv t1 = tcg_temp_new_i32();
+    TCGv t2 = tcg_temp_new_i32();
+
+    /* t1 = Rd & Rr & ~R | ~Rd & ~Rr & R */
+    /*    = (Rd ^ R) & ~(Rd ^ Rr) */
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
+static void gen_sub_CHf(TCGv R, TCGv Rd, TCGv Rr)
+{
+    TCGv t1 = tcg_temp_new_i32();
+    TCGv t2 = tcg_temp_new_i32();
+    TCGv t3 = tcg_temp_new_i32();
+
+    tcg_gen_not_tl(t1, Rd); /* t1 = ~Rd */
+    tcg_gen_and_tl(t2, t1, Rr); /* t2 = ~Rd & Rr */
+    tcg_gen_or_tl(t3, t1, Rr); /* t3 = (~Rd | Rr) & R */
+    tcg_gen_and_tl(t3, t3, R);
+    tcg_gen_or_tl(t2, t2, t3); /* t2 = ~Rd & Rr | ~Rd & R | R & Rr */
+
+    tcg_gen_shri_tl(cpu_Cf, t2, 7); /* Cf = t2(7) */
+    tcg_gen_shri_tl(cpu_Hf, t2, 3); /* Hf = t2(3) */
+    tcg_gen_andi_tl(cpu_Hf, cpu_Hf, 1);
+
+    tcg_temp_free_i32(t3);
+    tcg_temp_free_i32(t2);
+    tcg_temp_free_i32(t1);
+}
+
+static void gen_sub_Vf(TCGv R, TCGv Rd, TCGv Rr)
+{
+    TCGv t1 = tcg_temp_new_i32();
+    TCGv t2 = tcg_temp_new_i32();
+
+    /* t1 = Rd & ~Rr & ~R | ~Rd & Rr & R */
+    /*    = (Rd ^ R) & (Rd ^ R) */
+    tcg_gen_xor_tl(t1, Rd, R);
+    tcg_gen_xor_tl(t2, Rd, Rr);
+    tcg_gen_and_tl(t1, t1, t2);
+
+    tcg_gen_shri_tl(cpu_Vf, t1, 7); /* Vf = t1(7) */
+
+    tcg_temp_free_i32(t2);
+    tcg_temp_free_i32(t1);
+}
+
+static void gen_NSf(TCGv R)
+{
+    tcg_gen_shri_tl(cpu_Nf, R, 7); /* Nf = R(7) */
+    tcg_gen_xor_tl(cpu_Sf, cpu_Nf, cpu_Vf); /* Sf = Nf ^ Vf */
+}
+
+static void gen_ZNSf(TCGv R)
+{
+    tcg_gen_setcondi_tl(TCG_COND_EQ, cpu_Zf, R, 0); /* Zf = R == 0 */
+
+    /* update status register */
+    tcg_gen_shri_tl(cpu_Nf, R, 7); /* Nf = R(7) */
+    tcg_gen_xor_tl(cpu_Sf, cpu_Nf, cpu_Vf); /* Sf = Nf ^ Vf */
+}
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
+    tcg_gen_add_tl(R, Rd, Rr); /* Rd = Rd + Rr */
+    tcg_gen_andi_tl(R, R, 0xff); /* make it 8 bits */
+
+    /* update status register */
+    gen_add_CHf(R, Rd, Rr);
+    gen_add_Vf(R, Rd, Rr);
+    gen_ZNSf(R);
+
+    /* update output registers */
+    tcg_gen_mov_tl(Rd, R);
+
+    tcg_temp_free_i32(R);
+
+    return true;
+}
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
+    tcg_gen_add_tl(R, Rd, Rr); /* R = Rd + Rr + Cf */
+    tcg_gen_add_tl(R, R, cpu_Cf);
+    tcg_gen_andi_tl(R, R, 0xff); /* make it 8 bits */
+
+    /* update status register */
+    gen_add_CHf(R, Rd, Rr);
+    gen_add_Vf(R, Rd, Rr);
+    gen_ZNSf(R);
+
+    /* update output registers */
+    tcg_gen_mov_tl(Rd, R);
+
+    tcg_temp_free_i32(R);
+
+    return true;
+}
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
+    tcg_gen_deposit_tl(Rd, RdL, RdH, 8, 8); /* Rd = RdH:RdL */
+    tcg_gen_addi_tl(R, Rd, Imm); /* R = Rd + Imm */
+    tcg_gen_andi_tl(R, R, 0xffff); /* make it 16 bits */
+
+    /* update status register */
+    tcg_gen_andc_tl(cpu_Cf, Rd, R); /* Cf = Rd & ~R */
+    tcg_gen_shri_tl(cpu_Cf, cpu_Cf, 15);
+    tcg_gen_andc_tl(cpu_Vf, R, Rd); /* Vf = R & ~Rd */
+    tcg_gen_shri_tl(cpu_Vf, cpu_Vf, 15);
+    tcg_gen_setcondi_tl(TCG_COND_EQ, cpu_Zf, R, 0); /* Zf = R == 0 */
+    tcg_gen_shri_tl(cpu_Nf, R, 15); /* Nf = R(15) */
+    tcg_gen_xor_tl(cpu_Sf, cpu_Nf, cpu_Vf);/* Sf = Nf ^ Vf */
+
+    /* update output registers */
+    tcg_gen_andi_tl(RdL, R, 0xff);
+    tcg_gen_shri_tl(RdH, R, 8);
+
+    tcg_temp_free_i32(Rd);
+    tcg_temp_free_i32(R);
+
+    return true;
+}
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
+    tcg_gen_sub_tl(R, Rd, Rr); /* R = Rd - Rr */
+    tcg_gen_andi_tl(R, R, 0xff); /* make it 8 bits */
+
+    /* update status register */
+    tcg_gen_andc_tl(cpu_Cf, Rd, R); /* Cf = Rd & ~R */
+    gen_sub_CHf(R, Rd, Rr);
+    gen_sub_Vf(R, Rd, Rr);
+    gen_ZNSf(R);
+
+    /* update output registers */
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
+    tcg_gen_sub_tl(R, Rd, Rr); /* R = Rd - Imm */
+    tcg_gen_andi_tl(R, R, 0xff); /* make it 8 bits */
+
+    /* update status register */
+    gen_sub_CHf(R, Rd, Rr);
+    gen_sub_Vf(R, Rd, Rr);
+    gen_ZNSf(R);
+
+    /* update output registers */
+    tcg_gen_mov_tl(Rd, R);
+
+    tcg_temp_free_i32(R);
+    tcg_temp_free_i32(Rr);
+
+    return true;
+}
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
+    TCGv zero = tcg_const_i32(0);
+
+    tcg_gen_sub_tl(R, Rd, Rr); /* R = Rd - Rr - Cf */
+    tcg_gen_sub_tl(R, R, cpu_Cf);
+    tcg_gen_andi_tl(R, R, 0xff); /* make it 8 bits */
+
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
+    /* update output registers */
+    tcg_gen_mov_tl(Rd, R);
+
+    tcg_temp_free_i32(zero);
+    tcg_temp_free_i32(R);
+
+    return true;
+}
+
+/*
+ *  SBCI -- Subtract Immediate with Carry
+ */
+static bool trans_SBCI(DisasContext *ctx, arg_SBCI *a)
+{
+    TCGv Rd = cpu_r[a->rd];
+    TCGv Rr = tcg_const_i32(a->imm);
+    TCGv R = tcg_temp_new_i32();
+    TCGv zero = tcg_const_i32(0);
+
+    tcg_gen_sub_tl(R, Rd, Rr); /* R = Rd - Rr - Cf */
+    tcg_gen_sub_tl(R, R, cpu_Cf);
+    tcg_gen_andi_tl(R, R, 0xff); /* make it 8 bits */
+
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
+    /* update output registers */
+    tcg_gen_mov_tl(Rd, R);
+
+    tcg_temp_free_i32(zero);
+    tcg_temp_free_i32(R);
+    tcg_temp_free_i32(Rr);
+
+    return true;
+}
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
+    tcg_gen_deposit_tl(Rd, RdL, RdH, 8, 8); /* Rd = RdH:RdL */
+    tcg_gen_subi_tl(R, Rd, Imm); /* R = Rd - Imm */
+    tcg_gen_andi_tl(R, R, 0xffff); /* make it 16 bits */
+
+    /* update status register */
+    tcg_gen_andc_tl(cpu_Cf, R, Rd);
+    tcg_gen_shri_tl(cpu_Cf, cpu_Cf, 15); /* Cf = R & ~Rd */
+    tcg_gen_andc_tl(cpu_Vf, Rd, R);
+    tcg_gen_shri_tl(cpu_Vf, cpu_Vf, 15); /* Vf = Rd & ~R */
+    tcg_gen_setcondi_tl(TCG_COND_EQ, cpu_Zf, R, 0); /* Zf = R == 0 */
+    tcg_gen_shri_tl(cpu_Nf, R, 15); /* Nf = R(15) */
+    tcg_gen_xor_tl(cpu_Sf, cpu_Nf, cpu_Vf); /* Sf = Nf ^ Vf */
+
+    /* update output registers */
+    tcg_gen_andi_tl(RdL, R, 0xff);
+    tcg_gen_shri_tl(RdH, R, 8);
+
+    tcg_temp_free_i32(Rd);
+    tcg_temp_free_i32(R);
+
+    return true;
+}
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
+    tcg_gen_and_tl(R, Rd, Rr); /* Rd = Rd and Rr */
+
+    /* update status register */
+    tcg_gen_movi_tl(cpu_Vf, 0); /* Vf = 0 */
+    tcg_gen_setcondi_tl(TCG_COND_EQ, cpu_Zf, R, 0); /* Zf = R == 0 */
+    gen_ZNSf(R);
+
+    /* update output registers */
+    tcg_gen_mov_tl(Rd, R);
+
+    tcg_temp_free_i32(R);
+
+    return true;
+}
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
+    tcg_gen_andi_tl(Rd, Rd, Imm); /* Rd = Rd & Imm */
+
+    /* update status register */
+    tcg_gen_movi_tl(cpu_Vf, 0x00); /* Vf = 0 */
+    gen_ZNSf(Rd);
+
+    return true;
+}
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
+    /* update status register */
+    tcg_gen_movi_tl(cpu_Vf, 0);
+    gen_ZNSf(R);
+
+    /* update output registers */
+    tcg_gen_mov_tl(Rd, R);
+
+    tcg_temp_free_i32(R);
+
+    return true;
+}
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
+    /* update status register */
+    tcg_gen_movi_tl(cpu_Vf, 0x00); /* Vf = 0 */
+    gen_ZNSf(Rd);
+
+    return true;
+}
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
+    /* update status register */
+    tcg_gen_movi_tl(cpu_Vf, 0);
+    gen_ZNSf(Rd);
+
+    return true;
+}
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
+    /* update status register */
+    tcg_gen_movi_tl(cpu_Cf, 1); /* Cf = 1 */
+    tcg_gen_movi_tl(cpu_Vf, 0); /* Vf = 0 */
+    gen_ZNSf(Rd);
+
+    tcg_temp_free_i32(R);
+
+    return true;
+}
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
+    tcg_gen_sub_tl(R, t0, Rd); /* R = 0 - Rd */
+    tcg_gen_andi_tl(R, R, 0xff); /* make it 8 bits */
+
+    /* update status register */
+    gen_sub_CHf(R, t0, Rd);
+    gen_sub_Vf(R, t0, Rd);
+    gen_ZNSf(R);
+
+    /* update output registers */
+    tcg_gen_mov_tl(Rd, R);
+
+    tcg_temp_free_i32(t0);
+    tcg_temp_free_i32(R);
+
+    return true;
+}
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
+    /* update status register */
+    tcg_gen_setcondi_tl(TCG_COND_EQ, cpu_Vf, Rd, 0x80); /* Vf = Rd == 0x80 */
+    gen_ZNSf(Rd);
+
+    return true;
+}
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
+    /* update status register */
+    tcg_gen_setcondi_tl(TCG_COND_EQ, cpu_Vf, Rd, 0x7f); /* Vf = Rd == 0x7f */
+    gen_ZNSf(Rd);
+
+    return true;
+}
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
+    tcg_gen_mul_tl(R, Rd, Rr); /* R = Rd * Rr */
+    tcg_gen_andi_tl(R0, R, 0xff);
+    tcg_gen_shri_tl(R1, R, 8);
+
+    /* update status register */
+    tcg_gen_shri_tl(cpu_Cf, R, 15); /* Cf = R(15) */
+    tcg_gen_setcondi_tl(TCG_COND_EQ, cpu_Zf, R, 0); /* Zf = R == 0 */
+
+    tcg_temp_free_i32(R);
+
+    return true;
+}
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
+    tcg_gen_andi_tl(R, R, 0xffff); /* make it 16 bits */
+    tcg_gen_andi_tl(R0, R, 0xff);
+    tcg_gen_shri_tl(R1, R, 8);
+
+    /* update status register */
+    tcg_gen_shri_tl(cpu_Cf, R, 15); /* Cf = R(15) */
+    tcg_gen_setcondi_tl(TCG_COND_EQ, cpu_Zf, R, 0); /* Zf = R == 0 */
+
+    tcg_temp_free_i32(t1);
+    tcg_temp_free_i32(t0);
+    tcg_temp_free_i32(R);
+
+    return true;
+}
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
+    tcg_gen_mul_tl(R, t0, Rr); /* R = Rd * Rr */
+    tcg_gen_andi_tl(R, R, 0xffff); /* make R 16 bits */
+    tcg_gen_andi_tl(R0, R, 0xff);
+    tcg_gen_shri_tl(R1, R, 8);
+
+    /* update status register */
+    tcg_gen_shri_tl(cpu_Cf, R, 15); /* Cf = R(15) */
+    tcg_gen_setcondi_tl(TCG_COND_EQ, cpu_Zf, R, 0); /* Zf = R == 0 */
+
+    tcg_temp_free_i32(t0);
+    tcg_temp_free_i32(R);
+
+    return true;
+}
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
+    tcg_gen_mul_tl(R, Rd, Rr); /* R = Rd * Rr */
+
+    /* update status register */
+    tcg_gen_shri_tl(cpu_Cf, R, 15); /* Cf = R(15) */
+    tcg_gen_setcondi_tl(TCG_COND_EQ, cpu_Zf, R, 0); /* Zf = R == 0 */
+
+    /* update output registers */
+    tcg_gen_shli_tl(R, R, 1);
+    tcg_gen_andi_tl(R0, R, 0xff);
+    tcg_gen_shri_tl(R1, R, 8);
+    tcg_gen_andi_tl(R1, R1, 0xff);
+
+
+    tcg_temp_free_i32(R);
+
+    return true;
+}
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
+    tcg_gen_mul_tl(R, t0, t1); /* R = Rd * Rr */
+    tcg_gen_andi_tl(R, R, 0xffff); /* make it 16 bits */
+
+    /* update status register */
+    tcg_gen_shri_tl(cpu_Cf, R, 15); /* Cf = R(15) */
+    tcg_gen_setcondi_tl(TCG_COND_EQ, cpu_Zf, R, 0); /* Zf = R == 0 */
+
+    /* update output registers */
+    tcg_gen_shli_tl(R, R, 1);
+    tcg_gen_andi_tl(R0, R, 0xff);
+    tcg_gen_shri_tl(R1, R, 8);
+    tcg_gen_andi_tl(R1, R1, 0xff);
+
+    tcg_temp_free_i32(t1);
+    tcg_temp_free_i32(t0);
+    tcg_temp_free_i32(R);
+
+    return true;
+}
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
+    tcg_gen_mul_tl(R, t0, Rr); /* R = Rd * Rr */
+    tcg_gen_andi_tl(R, R, 0xffff); /* make it 16 bits */
+
+    /* update status register */
+    tcg_gen_shri_tl(cpu_Cf, R, 15); /* Cf = R(15) */
+    tcg_gen_setcondi_tl(TCG_COND_EQ, cpu_Zf, R, 0); /* Zf = R == 0 */
+
+    /* update output registers */
+    tcg_gen_shli_tl(R, R, 1);
+    tcg_gen_andi_tl(R0, R, 0xff);
+    tcg_gen_shri_tl(R1, R, 8);
+    tcg_gen_andi_tl(R1, R1, 0xff);
+
+    tcg_temp_free_i32(t0);
+    tcg_temp_free_i32(R);
+
+    return true;
+}
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
+    qemu_log_mask(LOG_UNIMP, "%s: not implemented\n", __func__);
+
+    return true;
+}
-- 
2.21.3


