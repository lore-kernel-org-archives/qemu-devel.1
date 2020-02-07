Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2BBFC352A2
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 02:07:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACDCA214AF
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 02:07:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACDCA214AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49032 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izt34-0001vz-Ss
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 21:07:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59671)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1izsva-0005qW-BZ
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 20:59:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1izsvY-00019f-6L
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 20:59:30 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:53089 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
 id 1izsvX-00018Y-Q3
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 20:59:28 -0500
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id 159561A2055;
 Fri,  7 Feb 2020 02:58:23 +0100 (CET)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
 [10.10.14.106])
 by mail.rt-rk.com (Postfix) with ESMTPSA id CBF4D1A20F2;
 Fri,  7 Feb 2020 02:58:22 +0100 (CET)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org
Subject: [PATCH rc5 14/32] target/avr: Add instruction translation - Bit and
 Bit-test Instructions
Date: Fri,  7 Feb 2020 02:57:42 +0100
Message-Id: <1581040680-308-15-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1581040680-308-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1581040680-308-1-git-send-email-aleksandar.markovic@rt-rk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 89.216.37.149
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Michael Rolnik <mrolnik@gmail.com>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Michael Rolnik <mrolnik@gmail.com>

This includes:
    - LSR, ROR
    - ASR
    - SWAP
    - SBI, CBI
    - BST, BLD
    - BSET, BCLR

Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
---
 target/avr/insn.decode |  14 +++
 target/avr/translate.c | 247 +++++++++++++++++++++++++++++++++++++++++++=
++++++
 2 files changed, 261 insertions(+)

diff --git a/target/avr/insn.decode b/target/avr/insn.decode
index 341b552..8141e18 100644
--- a/target/avr/insn.decode
+++ b/target/avr/insn.decode
@@ -163,3 +163,17 @@ XCH             1001 001 rd:5 0100
 LAC             1001 001 rd:5 0110
 LAS             1001 001 rd:5 0101
 LAT             1001 001 rd:5 0111
+
+#
+# Bit and Bit-test Instructions
+#
+LSR             1001 010 rd:5 0110
+ROR             1001 010 rd:5 0111
+ASR             1001 010 rd:5 0101
+SWAP            1001 010 rd:5 0010
+SBI             1001 1010 reg:5 bit:3
+CBI             1001 1000 reg:5 bit:3
+BST             1111 101 rd:5 0 bit:3
+BLD             1111 100 rd:5 0 bit:3
+BSET            1001 0100 0 bit:3 1000
+BCLR            1001 0100 1 bit:3 1000
diff --git a/target/avr/translate.c b/target/avr/translate.c
index 63b4e16..315f534 100644
--- a/target/avr/translate.c
+++ b/target/avr/translate.c
@@ -2500,3 +2500,250 @@ static bool trans_LAT(DisasContext *ctx, arg_LAT =
*a)
=20
     return true;
 }
+
+/*
+ * Bit and Bit-test Instructions
+ */
+static void gen_rshift_ZNVSf(TCGv R)
+{
+    tcg_gen_setcondi_tl(TCG_COND_EQ, cpu_Zf, R, 0); /* Zf =3D R =3D=3D 0=
 */
+    tcg_gen_shri_tl(cpu_Nf, R, 7); /* Nf =3D R(7) */
+    tcg_gen_xor_tl(cpu_Vf, cpu_Nf, cpu_Cf);
+    tcg_gen_xor_tl(cpu_Sf, cpu_Nf, cpu_Vf); /* Sf =3D Nf ^ Vf */
+}
+
+/*
+ *  Shifts all bits in Rd one place to the right. Bit 7 is cleared. Bit =
0 is
+ *  loaded into the C Flag of the SREG. This operation effectively divid=
es an
+ *  unsigned value by two. The C Flag can be used to round the result.
+ */
+static bool trans_LSR(DisasContext *ctx, arg_LSR *a)
+{
+    TCGv Rd =3D cpu_r[a->rd];
+
+    tcg_gen_andi_tl(cpu_Cf, Rd, 1);
+    tcg_gen_shri_tl(Rd, Rd, 1);
+
+    /* update status register */
+    tcg_gen_setcondi_tl(TCG_COND_EQ, cpu_Zf, Rd, 0); /* Zf =3D Rd =3D=3D=
 0 */
+    tcg_gen_movi_tl(cpu_Nf, 0);
+    tcg_gen_mov_tl(cpu_Vf, cpu_Cf);
+    tcg_gen_mov_tl(cpu_Sf, cpu_Vf);
+
+    return true;
+}
+
+/*
+ *  Shifts all bits in Rd one place to the right. The C Flag is shifted =
into
+ *  bit 7 of Rd. Bit 0 is shifted into the C Flag.  This operation, comb=
ined
+ *  with ASR, effectively divides multi-byte signed values by two. Combi=
ned with
+ *  LSR it effectively divides multi-byte unsigned values by two. The Ca=
rry Flag
+ *  can be used to round the result.
+ */
+static bool trans_ROR(DisasContext *ctx, arg_ROR *a)
+{
+    TCGv Rd =3D cpu_r[a->rd];
+    TCGv t0 =3D tcg_temp_new_i32();
+
+    tcg_gen_shli_tl(t0, cpu_Cf, 7);
+
+    /* update status register */
+    tcg_gen_andi_tl(cpu_Cf, Rd, 1);
+
+    /* update output register */
+    tcg_gen_shri_tl(Rd, Rd, 1);
+    tcg_gen_or_tl(Rd, Rd, t0);
+
+    /* update status register */
+    gen_rshift_ZNVSf(Rd);
+
+    tcg_temp_free_i32(t0);
+
+    return true;
+}
+
+/*
+ *  Shifts all bits in Rd one place to the right. Bit 7 is held constant=
. Bit 0
+ *  is loaded into the C Flag of the SREG. This operation effectively di=
vides a
+ *  signed value by two without changing its sign. The Carry Flag can be=
 used to
+ *  round the result.
+ */
+static bool trans_ASR(DisasContext *ctx, arg_ASR *a)
+{
+    TCGv Rd =3D cpu_r[a->rd];
+    TCGv t0 =3D tcg_temp_new_i32();
+
+    /* update status register */
+    tcg_gen_andi_tl(cpu_Cf, Rd, 1); /* Cf =3D Rd(0) */
+
+    /* update output register */
+    tcg_gen_andi_tl(t0, Rd, 0x80); /* Rd =3D (Rd & 0x80) | (Rd >> 1) */
+    tcg_gen_shri_tl(Rd, Rd, 1);
+    tcg_gen_or_tl(Rd, Rd, t0);
+
+    /* update status register */
+    gen_rshift_ZNVSf(Rd);
+
+    tcg_temp_free_i32(t0);
+
+    return true;
+}
+
+/*
+ *  Swaps high and low nibbles in a register.
+ */
+static bool trans_SWAP(DisasContext *ctx, arg_SWAP *a)
+{
+    TCGv Rd =3D cpu_r[a->rd];
+    TCGv t0 =3D tcg_temp_new_i32();
+    TCGv t1 =3D tcg_temp_new_i32();
+
+    tcg_gen_andi_tl(t0, Rd, 0x0f);
+    tcg_gen_shli_tl(t0, t0, 4);
+    tcg_gen_andi_tl(t1, Rd, 0xf0);
+    tcg_gen_shri_tl(t1, t1, 4);
+    tcg_gen_or_tl(Rd, t0, t1);
+
+    tcg_temp_free_i32(t1);
+    tcg_temp_free_i32(t0);
+
+    return true;
+}
+
+/*
+ *  Sets a specified bit in an I/O Register. This instruction operates o=
n
+ *  the lower 32 I/O Registers -- addresses 0-31.
+ */
+static bool trans_SBI(DisasContext *ctx, arg_SBI *a)
+{
+    TCGv data =3D tcg_temp_new_i32();
+    TCGv port =3D tcg_const_i32(a->reg);
+
+    gen_helper_inb(data, cpu_env, port);
+    tcg_gen_ori_tl(data, data, 1 << a->bit);
+    gen_helper_outb(cpu_env, port, data);
+
+    tcg_temp_free_i32(port);
+    tcg_temp_free_i32(data);
+
+    return true;
+}
+
+/*
+ *  Clears a specified bit in an I/O Register. This instruction operates=
 on
+ *  the lower 32 I/O Registers -- addresses 0-31.
+ */
+static bool trans_CBI(DisasContext *ctx, arg_CBI *a)
+{
+    TCGv data =3D tcg_temp_new_i32();
+    TCGv port =3D tcg_const_i32(a->reg);
+
+    gen_helper_inb(data, cpu_env, port);
+    tcg_gen_andi_tl(data, data, ~(1 << a->bit));
+    gen_helper_outb(cpu_env, port, data);
+
+    tcg_temp_free_i32(data);
+    tcg_temp_free_i32(port);
+
+    return true;
+}
+
+/*
+ *  Stores bit b from Rd to the T Flag in SREG (Status Register).
+ */
+static bool trans_BST(DisasContext *ctx, arg_BST *a)
+{
+    TCGv Rd =3D cpu_r[a->rd];
+
+    tcg_gen_andi_tl(cpu_Tf, Rd, 1 << a->bit);
+    tcg_gen_shri_tl(cpu_Tf, cpu_Tf, a->bit);
+
+    return true;
+}
+
+/*
+ *  Copies the T Flag in the SREG (Status Register) to bit b in register=
 Rd.
+ */
+static bool trans_BLD(DisasContext *ctx, arg_BLD *a)
+{
+    TCGv Rd =3D cpu_r[a->rd];
+    TCGv t1 =3D tcg_temp_new_i32();
+
+    tcg_gen_andi_tl(Rd, Rd, ~(1u << a->bit)); /* clear bit */
+    tcg_gen_shli_tl(t1, cpu_Tf, a->bit); /* create mask */
+    tcg_gen_or_tl(Rd, Rd, t1);
+
+    tcg_temp_free_i32(t1);
+
+    return true;
+}
+
+/*
+ *  Sets a single Flag or bit in SREG.
+ */
+static bool trans_BSET(DisasContext *ctx, arg_BSET *a)
+{
+    switch (a->bit) {
+    case 0x00:
+        tcg_gen_movi_tl(cpu_Cf, 0x01);
+        break;
+    case 0x01:
+        tcg_gen_movi_tl(cpu_Zf, 0x01);
+        break;
+    case 0x02:
+        tcg_gen_movi_tl(cpu_Nf, 0x01);
+        break;
+    case 0x03:
+        tcg_gen_movi_tl(cpu_Vf, 0x01);
+        break;
+    case 0x04:
+        tcg_gen_movi_tl(cpu_Sf, 0x01);
+        break;
+    case 0x05:
+        tcg_gen_movi_tl(cpu_Hf, 0x01);
+        break;
+    case 0x06:
+        tcg_gen_movi_tl(cpu_Tf, 0x01);
+        break;
+    case 0x07:
+        tcg_gen_movi_tl(cpu_If, 0x01);
+        break;
+    }
+
+    return true;
+}
+
+/*
+ *  Clears a single Flag in SREG.
+ */
+static bool trans_BCLR(DisasContext *ctx, arg_BCLR *a)
+{
+    switch (a->bit) {
+    case 0x00:
+        tcg_gen_movi_tl(cpu_Cf, 0x00);
+        break;
+    case 0x01:
+        tcg_gen_movi_tl(cpu_Zf, 0x00);
+        break;
+    case 0x02:
+        tcg_gen_movi_tl(cpu_Nf, 0x00);
+        break;
+    case 0x03:
+        tcg_gen_movi_tl(cpu_Vf, 0x00);
+        break;
+    case 0x04:
+        tcg_gen_movi_tl(cpu_Sf, 0x00);
+        break;
+    case 0x05:
+        tcg_gen_movi_tl(cpu_Hf, 0x00);
+        break;
+    case 0x06:
+        tcg_gen_movi_tl(cpu_Tf, 0x00);
+        break;
+    case 0x07:
+        tcg_gen_movi_tl(cpu_If, 0x00);
+        break;
+    }
+
+    return true;
+}
--=20
2.7.4


