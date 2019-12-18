Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E362EC3F68F
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 21:06:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9249F24650
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 21:06:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I1lDxkQl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9249F24650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60651 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihgWk-0003pm-HJ
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 16:06:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48254)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mrolnik@gmail.com>) id 1ihgUT-0001ni-Ki
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 16:04:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mrolnik@gmail.com>) id 1ihgUS-0000tG-39
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 16:04:17 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:38983)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mrolnik@gmail.com>) id 1ihgUR-0000sR-Su
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 16:04:16 -0500
Received: by mail-wm1-x344.google.com with SMTP id 20so3321531wmj.4
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2019 13:04:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=XhTCtaYzNT5b642ZogkdG/OQJA2xpwNFhTjDqMb1thQ=;
 b=I1lDxkQlKddAzRFcpx+t4Ar0LuXFvEu5JNZTc4q9RM1+GKhxgv0IJmx/enam0ir71x
 4fE3YbahAmBFQ/K0qh0aHMx1w4VCE5UuJfPxfuuI5C2e7kRacTm98zCT/OqEnl3wQNTL
 dbNF5zesv/l4M2BXROdHBekuhMP1/lUJ2GGnskqgusgN57k3MXsojuYZXraUWEryTP7N
 vCLsnegw38H/r4KgDG4xLE3Pdgm1RkS+ecG10IvHfnkXLicInXC5Ecz20c56evy6VcMN
 qvnC/F0UJA4ilIVSVP5moOj1TZCon5e9aP/q//O7p6ld7zT/YextxLbRGbYEeVdoZbwh
 wzDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=XhTCtaYzNT5b642ZogkdG/OQJA2xpwNFhTjDqMb1thQ=;
 b=C0FjkJQ4BZtrK1JF3fIVxFEMF3X5LQuuAYge2C4yGQuQe7e5N9GKtWKFgi8pg2rIRX
 fGeLBohzckw0vPPKEytXdxG//GR1Bn0S+OpmR4H5+yM4KWdUWA6oW9G1B9zO3xGmZCWh
 45tEGxp6c+2kDsIZSzOBgfn2JcMG4ECu2fznBmKnlUgDiAVXLAcmg2wEIp5ioL1yEXS+
 rnfZYbd1WPNphn0ozjy7xICmmNz+0xzzt+pnzPXURlmf8Y6JLBTLaf94IoRv3NEcn9wf
 TptMMmPBcmLczfZPUHttmblcJxAwYm9JG5WE4IfsqeEt4KbafLNBaC5/ebihVfMIp38h
 BLzQ==
X-Gm-Message-State: APjAAAU8yxuvm/AVNvZSZsc8zfOgp8RImjuNZ1W9EdaptbmohTpsaK8j
 29k70wln5D/mGwdDlHv7OuzfY2hZnNJCcg==
X-Google-Smtp-Source: APXvYqyuEsNJId5ItUtiEggKwfc68om6ue6Fdh9+oOI+Apotdihcdgu5LDJx69SGQgWKQCYUnnWnMg==
X-Received: by 2002:a05:600c:2c0b:: with SMTP id
 q11mr5358270wmg.2.1576703054523; 
 Wed, 18 Dec 2019 13:04:14 -0800 (PST)
Received: from 8c859074c0ff.ant.amazon.com.com
 (bzq-109-65-2-109.red.bezeqint.net. [109.65.2.109])
 by smtp.gmail.com with ESMTPSA id a133sm3808933wme.29.2019.12.18.13.04.11
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Wed, 18 Dec 2019 13:04:14 -0800 (PST)
From: Michael Rolnik <mrolnik@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v39 08/22] target/avr: Add instruction translation - Bit and
 Bit-test Instructions
Date: Wed, 18 Dec 2019 23:03:15 +0200
Message-Id: <20191218210329.1960-9-mrolnik@gmail.com>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
In-Reply-To: <20191218210329.1960-1-mrolnik@gmail.com>
References: <20191218210329.1960-1-mrolnik@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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
    - LSR, ROR
    - ASR
    - SWAP
    - SBI, CBI
    - BST, BLD
    - BSET, BCLR

Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
---
 target/avr/translate.c | 235 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 235 insertions(+)

diff --git a/target/avr/translate.c b/target/avr/translate.c
index 950504f7d0..e303a1f4cc 100644
--- a/target/avr/translate.c
+++ b/target/avr/translate.c
@@ -2371,3 +2371,238 @@ static bool trans_LAT(DisasContext *ctx, arg_LAT *a)
 
     return true;
 }
+
+/*
+ * Bit and Bit-test Instructions
+ */
+static void gen_rshift_ZNVSf(TCGv R)
+{
+    tcg_gen_setcondi_tl(TCG_COND_EQ, cpu_Zf, R, 0); /* Zf = R == 0 */
+    tcg_gen_shri_tl(cpu_Nf, R, 7); /* Nf = R(7) */
+    tcg_gen_xor_tl(cpu_Vf, cpu_Nf, cpu_Cf);
+    tcg_gen_xor_tl(cpu_Sf, cpu_Nf, cpu_Vf); /* Sf = Nf ^ Vf */
+}
+
+/*
+ *  Shifts all bits in Rd one place to the right. Bit 7 is cleared. Bit 0 is
+ *  loaded into the C Flag of the SREG. This operation effectively divides an
+ *  unsigned value by two. The C Flag can be used to round the result.
+ */
+static bool trans_LSR(DisasContext *ctx, arg_LSR *a)
+{
+    TCGv Rd = cpu_r[a->rd];
+
+    tcg_gen_andi_tl(cpu_Cf, Rd, 1);
+    tcg_gen_shri_tl(Rd, Rd, 1);
+    tcg_gen_setcondi_tl(TCG_COND_EQ, cpu_Zf, Rd, 0); /* Zf = Rd == 0 */
+    tcg_gen_movi_tl(cpu_Nf, 0);
+    tcg_gen_mov_tl(cpu_Vf, cpu_Cf);
+    tcg_gen_mov_tl(cpu_Sf, cpu_Vf);
+
+    return true;
+}
+
+/*
+ *  Shifts all bits in Rd one place to the right. The C Flag is shifted into
+ *  bit 7 of Rd. Bit 0 is shifted into the C Flag.  This operation, combined
+ *  with ASR, effectively divides multi-byte signed values by two. Combined with
+ *  LSR it effectively divides multi-byte unsigned values by two. The Carry Flag
+ *  can be used to round the result.
+ */
+static bool trans_ROR(DisasContext *ctx, arg_ROR *a)
+{
+    TCGv Rd = cpu_r[a->rd];
+    TCGv t0 = tcg_temp_new_i32();
+
+    tcg_gen_shli_tl(t0, cpu_Cf, 7);
+    tcg_gen_andi_tl(cpu_Cf, Rd, 1);
+    tcg_gen_shri_tl(Rd, Rd, 1);
+    tcg_gen_or_tl(Rd, Rd, t0);
+    gen_rshift_ZNVSf(Rd);
+
+    tcg_temp_free_i32(t0);
+
+    return true;
+}
+
+/*
+ *  Shifts all bits in Rd one place to the right. Bit 7 is held constant. Bit 0
+ *  is loaded into the C Flag of the SREG. This operation effectively divides a
+ *  signed value by two without changing its sign. The Carry Flag can be used to
+ *  round the result.
+ */
+static bool trans_ASR(DisasContext *ctx, arg_ASR *a)
+{
+    TCGv Rd = cpu_r[a->rd];
+    TCGv t0 = tcg_temp_new_i32();
+
+    tcg_gen_andi_tl(cpu_Cf, Rd, 1); /* Cf = Rd(0) */
+    tcg_gen_andi_tl(t0, Rd, 0x80); /* Rd = (Rd & 0x80) | (Rd >> 1) */
+    tcg_gen_shri_tl(Rd, Rd, 1);
+    tcg_gen_or_tl(Rd, Rd, t0);
+
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
+    TCGv Rd = cpu_r[a->rd];
+    TCGv t0 = tcg_temp_new_i32();
+    TCGv t1 = tcg_temp_new_i32();
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
+ *  Sets a specified bit in an I/O Register. This instruction operates on
+ *  the lower 32 I/O Registers -- addresses 0-31.
+ */
+static bool trans_SBI(DisasContext *ctx, arg_SBI *a)
+{
+    TCGv data = tcg_temp_new_i32();
+    TCGv port = tcg_const_i32(a->reg);
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
+ *  Clears a specified bit in an I/O Register. This instruction operates on
+ *  the lower 32 I/O Registers -- addresses 0-31.
+ */
+static bool trans_CBI(DisasContext *ctx, arg_CBI *a)
+{
+    TCGv data = tcg_temp_new_i32();
+    TCGv port = tcg_const_i32(a->reg);
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
+    TCGv Rd = cpu_r[a->rd];
+
+    tcg_gen_andi_tl(cpu_Tf, Rd, 1 << a->bit);
+    tcg_gen_shri_tl(cpu_Tf, cpu_Tf, a->bit);
+
+    return true;
+}
+
+/*
+ *  Copies the T Flag in the SREG (Status Register) to bit b in register Rd.
+ */
+static bool trans_BLD(DisasContext *ctx, arg_BLD *a)
+{
+    TCGv Rd = cpu_r[a->rd];
+    TCGv t1 = tcg_temp_new_i32();
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
-- 
2.17.2 (Apple Git-113)


