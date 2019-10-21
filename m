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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0850CA9EAF
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 22:47:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 565AD2084C
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 22:47:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wl/V/KL3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 565AD2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48596 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMgS9-0004Tm-Fe
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 18:47:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51954)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mrolnik@gmail.com>) id 1iMgJF-0001nB-Qj
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 18:37:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mrolnik@gmail.com>) id 1iMgJC-00010W-06
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 18:37:53 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:33706)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mrolnik@gmail.com>) id 1iMgJB-00010C-LZ
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 18:37:49 -0400
Received: by mail-wm1-x341.google.com with SMTP id 6so2332144wmf.0
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2019 15:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=aawyhmteAoA4eTVwBLshfPsFb23WLn2wHQ8KTF2itNw=;
 b=Wl/V/KL3tZ3mZh+19Ru6M8VzWPhb46HEg2gz2KNS2p1ezgPXbTvrSGg3NUgo41qpFy
 E++3Z6Jghym+WUmyF+QvjASV4tPWBBw7BvuZSoLc+ykKV9dv5xb3W/yTbGVrpDHrO7gR
 Ija4g5uaDQx0Sz/J6Q1SiBElGOZm2NYlcIp2FchF4TQop+P6/lBZo4Tf3q9b6efQ7Gim
 iRzRoXxyyCW0HVFKb6cM8/V3PTmcH0rVus4HSyTH6RgHdjtR00K19SafT+3KRQqYeP4Q
 WRUFPHtYv1E0W6Za0OSAML5XCfm8w/LgeEBBXA2iq2T8MpaCQRN6f0DXvJ4x0qDZD+KI
 hAdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=aawyhmteAoA4eTVwBLshfPsFb23WLn2wHQ8KTF2itNw=;
 b=cnLDL4ZvdHLTLFG8e+kTDTe8O4GO/3dxZ4eM8ysmaW3hKJkdBu+LbM7/cWzLN0C9gs
 uVhoRW8uozMHc+s0L2rb89eh2xjYNsvMovjJ+YqxcHzhckzfX1pNxPfNY3mt70ZDtzse
 iuspiGPE3+ucnhESDAAoArXBC/Cd7IPIzDv/uFenlGeDh/O3471L3ZM3VoXRZ+NftVPz
 Rvwa0V63rh+xeedpx7xbo8cDx/DAuA5gS8KsdkQFaenCd7HnNh8Wfok9ekxbbN2ltNKd
 9dyFkfQH0ffEC7F6JR9yvRwq/Y0Oqxw8ptkHP4E842yOJ+FmPhsOqifulAj+YgZV4Un5
 mdew==
X-Gm-Message-State: APjAAAXn+bR/5qAmzoEhNnO7FmMMy9Yu24iTb2oYiiixteWtfKPs6cLw
 d9CmQDRLPt7nm8pTkPr5cMaISbxIkK7jTQ==
X-Google-Smtp-Source: APXvYqyDufyl+Qn7GIXF16J3rjvOcX8HfrCUi/DoZze+t8JkCcDUt2tiKExuPWBtTBl4ZMZlJHtxZA==
X-Received: by 2002:a05:600c:1107:: with SMTP id
 b7mr196715wma.151.1571697467622; 
 Mon, 21 Oct 2019 15:37:47 -0700 (PDT)
Received: from 8c859074c0ff.ant.amazon.com.com
 (bzq-109-65-50-254.red.bezeqint.net. [109.65.50.254])
 by smtp.gmail.com with ESMTPSA id q66sm16951271wme.39.2019.10.21.15.37.45
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Mon, 21 Oct 2019 15:37:47 -0700 (PDT)
From: Michael Rolnik <mrolnik@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v33 07/13] target/avr: Add instruction translation - Bit and
 Bit-test Instructions
Date: Tue, 22 Oct 2019 01:37:05 +0300
Message-Id: <20191021223711.66955-8-mrolnik@gmail.com>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
In-Reply-To: <20191021223711.66955-1-mrolnik@gmail.com>
References: <20191021223711.66955-1-mrolnik@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
    - LSR, ROR
    - ASR
    - SWAP
    - SBI, CBI
    - BST, BLD
    - BSET, BCLR

Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
---
 target/avr/translate.c | 1123 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 1123 insertions(+)

diff --git a/target/avr/translate.c b/target/avr/translate.c
index 3afd686ee8..19540634df 100644
--- a/target/avr/translate.c
+++ b/target/avr/translate.c
@@ -304,6 +304,15 @@ static void gen_goto_tb(DisasContext *ctx, int n, target_ulong dest)
 }
 
 
+static void gen_rshift_ZNVSf(TCGv R)
+{
+    tcg_gen_mov_tl(cpu_Zf, R); /* Zf = R */
+    tcg_gen_shri_tl(cpu_Nf, R, 7); /* Nf = R(7) */
+    tcg_gen_xor_tl(cpu_Vf, cpu_Nf, cpu_Cf);
+    tcg_gen_xor_tl(cpu_Sf, cpu_Nf, cpu_Vf); /* Sf = Nf ^ Vf */
+}
+
+
 /*
  *  Adds two registers without the C Flag and places the result in the
  *  destination register Rd.
@@ -1483,3 +1492,1117 @@ static bool trans_BRBS(DisasContext *ctx, arg_BRBS *a)
     return true;
 }
 
+
+/*
+ *  This instruction makes a copy of one register into another. The source
+ *  register Rr is left unchanged, while the destination register Rd is loaded
+ *  with a copy of Rr.
+ */
+static bool trans_MOV(DisasContext *ctx, arg_MOV *a)
+{
+    TCGv Rd = cpu_r[a->rd];
+    TCGv Rr = cpu_r[a->rr];
+
+    tcg_gen_mov_tl(Rd, Rr);
+
+    return true;
+}
+
+
+/*
+ *  This instruction makes a copy of one register pair into another register
+ *  pair. The source register pair Rr+1:Rr is left unchanged, while the
+ *  destination register pair Rd+1:Rd is loaded with a copy of Rr + 1:Rr.  This
+ *  instruction is not available in all devices. Refer to the device specific
+ *  instruction set summary.
+ */
+static bool trans_MOVW(DisasContext *ctx, arg_MOVW *a)
+{
+    if (!avr_have_feature(ctx, AVR_FEATURE_MOVW)) {
+        return true;
+    }
+
+    TCGv RdL = cpu_r[a->rd];
+    TCGv RdH = cpu_r[a->rd + 1];
+    TCGv RrL = cpu_r[a->rr];
+    TCGv RrH = cpu_r[a->rr + 1];
+
+    tcg_gen_mov_tl(RdH, RrH);
+    tcg_gen_mov_tl(RdL, RrL);
+
+    return true;
+}
+
+
+/*
+ * Loads an 8 bit constant directly to register 16 to 31.
+ */
+static bool trans_LDI(DisasContext *ctx, arg_LDI *a)
+{
+    TCGv Rd = cpu_r[a->rd];
+    int imm = a->imm;
+
+    tcg_gen_movi_tl(Rd, imm);
+
+    return true;
+}
+
+
+/*
+ *  Loads one byte from the data space to a register. For parts with SRAM,
+ *  the data space consists of the Register File, I/O memory and internal SRAM
+ *  (and external SRAM if applicable). For parts without SRAM, the data space
+ *  consists of the register file only. The EEPROM has a separate address space.
+ *  A 16-bit address must be supplied. Memory access is limited to the current
+ *  data segment of 64KB. The LDS instruction uses the RAMPD Register to access
+ *  memory above 64KB. To access another data segment in devices with more than
+ *  64KB data space, the RAMPD in register in the I/O area has to be changed.
+ *  This instruction is not available in all devices. Refer to the device
+ *  specific instruction set summary.
+ */
+static bool trans_LDS(DisasContext *ctx, arg_LDS *a)
+{
+    TCGv Rd = cpu_r[a->rd];
+    TCGv addr = tcg_temp_new_i32();
+    TCGv H = cpu_rampD;
+    a->imm = next_word(ctx);
+
+    tcg_gen_mov_tl(addr, H); /* addr = H:M:L */
+    tcg_gen_shli_tl(addr, addr, 16);
+    tcg_gen_ori_tl(addr, addr, a->imm);
+
+    gen_data_load(ctx, Rd, addr);
+
+    tcg_temp_free_i32(addr);
+
+    return true;
+}
+
+
+/*
+ *  Loads one byte indirect from the data space to a register. For parts
+ *  with SRAM, the data space consists of the Register File, I/O memory and
+ *  internal SRAM (and external SRAM if applicable). For parts without SRAM, the
+ *  data space consists of the Register File only. In some parts the Flash
+ *  Memory has been mapped to the data space and can be read using this command.
+ *  The EEPROM has a separate address space.  The data location is pointed to by
+ *  the X (16 bits) Pointer Register in the Register File. Memory access is
+ *  limited to the current data segment of 64KB. To access another data segment
+ *  in devices with more than 64KB data space, the RAMPX in register in the I/O
+ *  area has to be changed.  The X-pointer Register can either be left unchanged
+ *  by the operation, or it can be post-incremented or predecremented.  These
+ *  features are especially suited for accessing arrays, tables, and Stack
+ *  Pointer usage of the X-pointer Register. Note that only the low byte of the
+ *  X-pointer is updated in devices with no more than 256 bytes data space. For
+ *  such devices, the high byte of the pointer is not used by this instruction
+ *  and can be used for other purposes. The RAMPX Register in the I/O area is
+ *  updated in parts with more than 64KB data space or more than 64KB Program
+ *  memory, and the increment/decrement is added to the entire 24-bit address on
+ *  such devices.  Not all variants of this instruction is available in all
+ *  devices. Refer to the device specific instruction set summary.  In the
+ *  Reduced Core tinyAVR the LD instruction can be used to achieve the same
+ *  operation as LPM since the program memory is mapped to the data memory
+ *  space.
+ */
+static bool trans_LDX1(DisasContext *ctx, arg_LDX1 *a)
+{
+    TCGv Rd = cpu_r[a->rd];
+    TCGv addr = gen_get_xaddr();
+
+    gen_data_load(ctx, Rd, addr);
+
+    tcg_temp_free_i32(addr);
+
+    return true;
+}
+
+
+static bool trans_LDX2(DisasContext *ctx, arg_LDX2 *a)
+{
+    TCGv Rd = cpu_r[a->rd];
+    TCGv addr = gen_get_xaddr();
+
+    gen_data_load(ctx, Rd, addr);
+    tcg_gen_addi_tl(addr, addr, 1); /* addr = addr + 1 */
+
+    gen_set_xaddr(addr);
+
+    tcg_temp_free_i32(addr);
+
+    return true;
+}
+
+
+static bool trans_LDX3(DisasContext *ctx, arg_LDX3 *a)
+{
+    TCGv Rd = cpu_r[a->rd];
+    TCGv addr = gen_get_xaddr();
+
+    tcg_gen_subi_tl(addr, addr, 1); /* addr = addr - 1 */
+    gen_data_load(ctx, Rd, addr);
+    gen_set_xaddr(addr);
+
+    tcg_temp_free_i32(addr);
+
+    return true;
+}
+
+
+static bool trans_STX1(DisasContext *ctx, arg_STX1 *a)
+{
+    TCGv Rd = cpu_r[a->rr];
+    TCGv addr = gen_get_xaddr();
+
+    gen_data_store(ctx, Rd, addr);
+
+    tcg_temp_free_i32(addr);
+
+    return true;
+}
+
+static bool trans_STX2(DisasContext *ctx, arg_STX2 *a)
+{
+    TCGv Rd = cpu_r[a->rr];
+    TCGv addr = gen_get_xaddr();
+
+    gen_data_store(ctx, Rd, addr);
+    tcg_gen_addi_tl(addr, addr, 1); /* addr = addr + 1 */
+    gen_set_xaddr(addr);
+
+    tcg_temp_free_i32(addr);
+
+    return true;
+}
+
+static bool trans_STX3(DisasContext *ctx, arg_STX3 *a)
+{
+    TCGv Rd = cpu_r[a->rr];
+    TCGv addr = gen_get_xaddr();
+
+    tcg_gen_subi_tl(addr, addr, 1); /* addr = addr - 1 */
+    gen_data_store(ctx, Rd, addr);
+    gen_set_xaddr(addr);
+
+    tcg_temp_free_i32(addr);
+
+    return true;
+}
+
+
+/*
+ *  Loads one byte indirect with or without displacement from the data space
+ *  to a register. For parts with SRAM, the data space consists of the Register
+ *  File, I/O memory and internal SRAM (and external SRAM if applicable). For
+ *  parts without SRAM, the data space consists of the Register File only. In
+ *  some parts the Flash Memory has been mapped to the data space and can be
+ *  read using this command. The EEPROM has a separate address space.  The data
+ *  location is pointed to by the Y (16 bits) Pointer Register in the Register
+ *  File. Memory access is limited to the current data segment of 64KB. To
+ *  access another data segment in devices with more than 64KB data space, the
+ *  RAMPY in register in the I/O area has to be changed.  The Y-pointer Register
+ *  can either be left unchanged by the operation, or it can be post-incremented
+ *  or predecremented.  These features are especially suited for accessing
+ *  arrays, tables, and Stack Pointer usage of the Y-pointer Register. Note that
+ *  only the low byte of the Y-pointer is updated in devices with no more than
+ *  256 bytes data space. For such devices, the high byte of the pointer is not
+ *  used by this instruction and can be used for other purposes. The RAMPY
+ *  Register in the I/O area is updated in parts with more than 64KB data space
+ *  or more than 64KB Program memory, and the increment/decrement/displacement
+ *  is added to the entire 24-bit address on such devices.  Not all variants of
+ *  this instruction is available in all devices. Refer to the device specific
+ *  instruction set summary.  In the Reduced Core tinyAVR the LD instruction can
+ *  be used to achieve the same operation as LPM since the program memory is
+ *  mapped to the data memory space.
+ */
+static bool trans_LDY2(DisasContext *ctx, arg_LDY2 *a)
+{
+    TCGv Rd = cpu_r[a->rd];
+    TCGv addr = gen_get_yaddr();
+
+    gen_data_load(ctx, Rd, addr);
+    tcg_gen_addi_tl(addr, addr, 1); /* addr = addr + 1 */
+
+    gen_set_yaddr(addr);
+
+    tcg_temp_free_i32(addr);
+
+    return true;
+}
+
+
+static bool trans_LDY3(DisasContext *ctx, arg_LDY3 *a)
+{
+    TCGv Rd = cpu_r[a->rd];
+    TCGv addr = gen_get_yaddr();
+
+    tcg_gen_subi_tl(addr, addr, 1); /* addr = addr - 1 */
+    gen_data_load(ctx, Rd, addr);
+    gen_set_yaddr(addr);
+
+    tcg_temp_free_i32(addr);
+
+    return true;
+}
+
+
+static bool trans_LDDY(DisasContext *ctx, arg_LDDY *a)
+{
+    TCGv Rd = cpu_r[a->rd];
+    TCGv addr = gen_get_yaddr();
+
+    tcg_gen_addi_tl(addr, addr, a->imm); /* addr = addr + q */
+    gen_data_load(ctx, Rd, addr);
+
+    tcg_temp_free_i32(addr);
+
+    return true;
+}
+
+
+static bool trans_STY2(DisasContext *ctx, arg_STY2 *a)
+{
+    TCGv Rd = cpu_r[a->rd];
+    TCGv addr = gen_get_yaddr();
+
+    gen_data_store(ctx, Rd, addr);
+    tcg_gen_addi_tl(addr, addr, 1); /* addr = addr + 1 */
+    gen_set_yaddr(addr);
+
+    tcg_temp_free_i32(addr);
+
+    return true;
+}
+
+
+static bool trans_STY3(DisasContext *ctx, arg_STY3 *a)
+{
+    TCGv Rd = cpu_r[a->rd];
+    TCGv addr = gen_get_yaddr();
+
+    tcg_gen_subi_tl(addr, addr, 1); /* addr = addr - 1 */
+    gen_data_store(ctx, Rd, addr);
+    gen_set_yaddr(addr);
+
+    tcg_temp_free_i32(addr);
+
+    return true;
+}
+
+
+static bool trans_STDY(DisasContext *ctx, arg_STDY *a)
+{
+    TCGv Rd = cpu_r[a->rd];
+    TCGv addr = gen_get_yaddr();
+
+    tcg_gen_addi_tl(addr, addr, a->imm); /* addr = addr + q */
+    gen_data_store(ctx, Rd, addr);
+
+    tcg_temp_free_i32(addr);
+
+    return true;
+}
+
+
+/*
+ *  Loads one byte indirect with or without displacement from the data space
+ *  to a register. For parts with SRAM, the data space consists of the Register
+ *  File, I/O memory and internal SRAM (and external SRAM if applicable). For
+ *  parts without SRAM, the data space consists of the Register File only. In
+ *  some parts the Flash Memory has been mapped to the data space and can be
+ *  read using this command. The EEPROM has a separate address space.  The data
+ *  location is pointed to by the Z (16 bits) Pointer Register in the Register
+ *  File. Memory access is limited to the current data segment of 64KB. To
+ *  access another data segment in devices with more than 64KB data space, the
+ *  RAMPZ in register in the I/O area has to be changed.  The Z-pointer Register
+ *  can either be left unchanged by the operation, or it can be post-incremented
+ *  or predecremented.  These features are especially suited for Stack Pointer
+ *  usage of the Z-pointer Register, however because the Z-pointer Register can
+ *  be used for indirect subroutine calls, indirect jumps and table lookup, it
+ *  is often more convenient to use the X or Y-pointer as a dedicated Stack
+ *  Pointer. Note that only the low byte of the Z-pointer is updated in devices
+ *  with no more than 256 bytes data space. For such devices, the high byte of
+ *  the pointer is not used by this instruction and can be used for other
+ *  purposes. The RAMPZ Register in the I/O area is updated in parts with more
+ *  than 64KB data space or more than 64KB Program memory, and the
+ *  increment/decrement/displacement is added to the entire 24-bit address on
+ *  such devices.  Not all variants of this instruction is available in all
+ *  devices. Refer to the device specific instruction set summary.  In the
+ *  Reduced Core tinyAVR the LD instruction can be used to achieve the same
+ *  operation as LPM since the program memory is mapped to the data memory
+ *  space.  For using the Z-pointer for table lookup in Program memory see the
+ *  LPM and ELPM instructions.
+ */
+static bool trans_LDZ2(DisasContext *ctx, arg_LDZ2 *a)
+{
+    TCGv Rd = cpu_r[a->rd];
+    TCGv addr = gen_get_zaddr();
+
+    gen_data_load(ctx, Rd, addr);
+    tcg_gen_addi_tl(addr, addr, 1); /* addr = addr + 1 */
+
+    gen_set_zaddr(addr);
+
+    tcg_temp_free_i32(addr);
+
+    return true;
+}
+
+
+static bool trans_LDZ3(DisasContext *ctx, arg_LDZ3 *a)
+{
+    TCGv Rd = cpu_r[a->rd];
+    TCGv addr = gen_get_zaddr();
+
+    tcg_gen_subi_tl(addr, addr, 1); /* addr = addr - 1 */
+    gen_data_load(ctx, Rd, addr);
+
+    gen_set_zaddr(addr);
+
+    tcg_temp_free_i32(addr);
+
+    return true;
+}
+
+
+static bool trans_LDDZ(DisasContext *ctx, arg_LDDZ *a)
+{
+    TCGv Rd = cpu_r[a->rd];
+    TCGv addr = gen_get_zaddr();
+
+    tcg_gen_addi_tl(addr, addr, a->imm); /* addr = addr + q */
+    gen_data_load(ctx, Rd, addr);
+
+    tcg_temp_free_i32(addr);
+
+    return true;
+}
+
+
+static bool trans_STZ2(DisasContext *ctx, arg_STZ2 *a)
+{
+    TCGv Rd = cpu_r[a->rd];
+    TCGv addr = gen_get_zaddr();
+
+    gen_data_store(ctx, Rd, addr);
+    tcg_gen_addi_tl(addr, addr, 1); /* addr = addr + 1 */
+
+    gen_set_zaddr(addr);
+
+    tcg_temp_free_i32(addr);
+
+    return true;
+}
+
+
+static bool trans_STZ3(DisasContext *ctx, arg_STZ3 *a)
+{
+    TCGv Rd = cpu_r[a->rd];
+    TCGv addr = gen_get_zaddr();
+
+    tcg_gen_subi_tl(addr, addr, 1); /* addr = addr - 1 */
+    gen_data_store(ctx, Rd, addr);
+
+    gen_set_zaddr(addr);
+
+    tcg_temp_free_i32(addr);
+
+    return true;
+}
+
+
+static bool trans_STDZ(DisasContext *ctx, arg_STDZ *a)
+{
+    TCGv Rd = cpu_r[a->rd];
+    TCGv addr = gen_get_zaddr();
+
+    tcg_gen_addi_tl(addr, addr, a->imm); /* addr = addr + q */
+    gen_data_store(ctx, Rd, addr);
+
+    tcg_temp_free_i32(addr);
+
+    return true;
+}
+
+
+
+/*
+ *  Stores one byte from a Register to the data space. For parts with SRAM,
+ *  the data space consists of the Register File, I/O memory and internal SRAM
+ *  (and external SRAM if applicable). For parts without SRAM, the data space
+ *  consists of the Register File only. The EEPROM has a separate address space.
+ *  A 16-bit address must be supplied. Memory access is limited to the current
+ *  data segment of 64KB. The STS instruction uses the RAMPD Register to access
+ *  memory above 64KB. To access another data segment in devices with more than
+ *  64KB data space, the RAMPD in register in the I/O area has to be changed.
+ *  This instruction is not available in all devices. Refer to the device
+ *  specific instruction set summary.
+ */
+static bool trans_STS(DisasContext *ctx, arg_STS *a)
+{
+    TCGv Rd = cpu_r[a->rd];
+    TCGv addr = tcg_temp_new_i32();
+    TCGv H = cpu_rampD;
+    a->imm = next_word(ctx);
+
+    tcg_gen_mov_tl(addr, H); /* addr = H:M:L */
+    tcg_gen_shli_tl(addr, addr, 16);
+    tcg_gen_ori_tl(addr, addr, a->imm);
+
+    gen_data_store(ctx, Rd, addr);
+
+    tcg_temp_free_i32(addr);
+
+    return true;
+}
+
+
+/*
+ *  Loads one byte pointed to by the Z-register into the destination
+ *  register Rd. This instruction features a 100% space effective constant
+ *  initialization or constant data fetch. The Program memory is organized in
+ *  16-bit words while the Z-pointer is a byte address. Thus, the least
+ *  significant bit of the Z-pointer selects either low byte (ZLSB = 0) or high
+ *  byte (ZLSB = 1). This instruction can address the first 64KB (32K words) of
+ *  Program memory. The Zpointer Register can either be left unchanged by the
+ *  operation, or it can be incremented. The incrementation does not apply to
+ *  the RAMPZ Register.  Devices with Self-Programming capability can use the
+ *  LPM instruction to read the Fuse and Lock bit values.  Refer to the device
+ *  documentation for a detailed description.  The LPM instruction is not
+ *  available in all devices. Refer to the device specific instruction set
+ *  summary
+ */
+static bool trans_LPM1(DisasContext *ctx, arg_LPM1 *a)
+{
+    if (!avr_have_feature(ctx, AVR_FEATURE_LPM)) {
+        return true;
+    }
+
+    TCGv Rd = cpu_r[0];
+    TCGv addr = tcg_temp_new_i32();
+    TCGv H = cpu_r[31];
+    TCGv L = cpu_r[30];
+
+    tcg_gen_shli_tl(addr, H, 8); /* addr = H:L */
+    tcg_gen_or_tl(addr, addr, L);
+
+    tcg_gen_qemu_ld8u(Rd, addr, MMU_CODE_IDX); /* Rd = mem[addr] */
+
+    tcg_temp_free_i32(addr);
+
+    return true;
+}
+
+
+static bool trans_LPM2(DisasContext *ctx, arg_LPM2 *a)
+{
+    if (!avr_have_feature(ctx, AVR_FEATURE_LPM)) {
+        return true;
+    }
+
+    TCGv Rd = cpu_r[a->rd];
+    TCGv addr = tcg_temp_new_i32();
+    TCGv H = cpu_r[31];
+    TCGv L = cpu_r[30];
+
+    tcg_gen_shli_tl(addr, H, 8); /* addr = H:L */
+    tcg_gen_or_tl(addr, addr, L);
+
+    tcg_gen_qemu_ld8u(Rd, addr, MMU_CODE_IDX); /* Rd = mem[addr] */
+
+    tcg_temp_free_i32(addr);
+
+    return true;
+}
+
+
+static bool trans_LPMX(DisasContext *ctx, arg_LPMX *a)
+{
+    if (!avr_have_feature(ctx, AVR_FEATURE_LPMX)) {
+        return true;
+    }
+
+    TCGv Rd = cpu_r[a->rd];
+    TCGv addr = tcg_temp_new_i32();
+    TCGv H = cpu_r[31];
+    TCGv L = cpu_r[30];
+
+    tcg_gen_shli_tl(addr, H, 8); /* addr = H:L */
+    tcg_gen_or_tl(addr, addr, L);
+
+    tcg_gen_qemu_ld8u(Rd, addr, MMU_CODE_IDX); /* Rd = mem[addr] */
+
+    tcg_gen_addi_tl(addr, addr, 1); /* addr = addr + 1 */
+
+    tcg_gen_andi_tl(L, addr, 0xff);
+
+    tcg_gen_shri_tl(addr, addr, 8);
+    tcg_gen_andi_tl(H, addr, 0xff);
+
+    tcg_temp_free_i32(addr);
+
+    return true;
+}
+
+
+/*
+ *  Loads one byte pointed to by the Z-register and the RAMPZ Register in
+ *  the I/O space, and places this byte in the destination register Rd. This
+ *  instruction features a 100% space effective constant initialization or
+ *  constant data fetch. The Program memory is organized in 16-bit words while
+ *  the Z-pointer is a byte address. Thus, the least significant bit of the
+ *  Z-pointer selects either low byte (ZLSB = 0) or high byte (ZLSB = 1). This
+ *  instruction can address the entire Program memory space. The Z-pointer
+ *  Register can either be left unchanged by the operation, or it can be
+ *  incremented. The incrementation applies to the entire 24-bit concatenation
+ *  of the RAMPZ and Z-pointer Registers.  Devices with Self-Programming
+ *  capability can use the ELPM instruction to read the Fuse and Lock bit value.
+ *  Refer to the device documentation for a detailed description.  This
+ *  instruction is not available in all devices. Refer to the device specific
+ *  instruction set summary.
+ */
+static bool trans_ELPM1(DisasContext *ctx, arg_ELPM1 *a)
+{
+    if (!avr_have_feature(ctx, AVR_FEATURE_ELPM)) {
+        return true;
+    }
+
+    TCGv Rd = cpu_r[0];
+    TCGv addr = gen_get_zaddr();
+
+    tcg_gen_qemu_ld8u(Rd, addr, MMU_CODE_IDX); /* Rd = mem[addr] */
+
+    tcg_temp_free_i32(addr);
+
+    return true;
+}
+
+
+static bool trans_ELPM2(DisasContext *ctx, arg_ELPM2 *a)
+{
+    if (!avr_have_feature(ctx, AVR_FEATURE_ELPM)) {
+        return true;
+    }
+
+    TCGv Rd = cpu_r[a->rd];
+    TCGv addr = gen_get_zaddr();
+
+    tcg_gen_qemu_ld8u(Rd, addr, MMU_CODE_IDX); /* Rd = mem[addr] */
+
+    tcg_temp_free_i32(addr);
+
+    return true;
+}
+
+
+static bool trans_ELPMX(DisasContext *ctx, arg_ELPMX *a)
+{
+    if (!avr_have_feature(ctx, AVR_FEATURE_ELPMX)) {
+        return true;
+    }
+
+    TCGv Rd = cpu_r[a->rd];
+    TCGv addr = gen_get_zaddr();
+
+    tcg_gen_qemu_ld8u(Rd, addr, MMU_CODE_IDX); /* Rd = mem[addr] */
+
+    tcg_gen_addi_tl(addr, addr, 1); /* addr = addr + 1 */
+
+    gen_set_zaddr(addr);
+
+    tcg_temp_free_i32(addr);
+
+    return true;
+}
+
+
+/*
+ *  SPM can be used to erase a page in the Program memory, to write a page
+ *  in the Program memory (that is already erased), and to set Boot Loader Lock
+ *  bits. In some devices, the Program memory can be written one word at a time,
+ *  in other devices an entire page can be programmed simultaneously after first
+ *  filling a temporary page buffer. In all cases, the Program memory must be
+ *  erased one page at a time. When erasing the Program memory, the RAMPZ and
+ *  Z-register are used as page address. When writing the Program memory, the
+ *  RAMPZ and Z-register are used as page or word address, and the R1:R0
+ *  register pair is used as data(1). When setting the Boot Loader Lock bits,
+ *  the R1:R0 register pair is used as data. Refer to the device documentation
+ *  for detailed description of SPM usage. This instruction can address the
+ *  entire Program memory.  The SPM instruction is not available in all devices.
+ *  Refer to the device specific instruction set summary.  Note: 1. R1
+ *  determines the instruction high byte, and R0 determines the instruction low
+ *  byte.
+ */
+static bool trans_SPM(DisasContext *ctx, arg_SPM *a)
+{
+    /* TODO */
+    if (!avr_have_feature(ctx, AVR_FEATURE_SPM)) {
+        return true;
+    }
+
+    return true;
+}
+
+
+static bool trans_SPMX(DisasContext *ctx, arg_SPMX *a)
+{
+    /* TODO */
+    if (!avr_have_feature(ctx, AVR_FEATURE_SPMX)) {
+        return true;
+    }
+
+    return true;
+}
+
+
+/*
+ *  Loads data from the I/O Space (Ports, Timers, Configuration Registers,
+ *  etc.) into register Rd in the Register File.
+ */
+static bool trans_IN(DisasContext *ctx, arg_IN *a)
+{
+    TCGv Rd = cpu_r[a->rd];
+    TCGv port = tcg_const_i32(a->imm);
+
+    gen_helper_inb(Rd, cpu_env, port);
+
+    tcg_temp_free_i32(port);
+
+    return true;
+}
+
+
+/*
+ *  Stores data from register Rr in the Register File to I/O Space (Ports,
+ *  Timers, Configuration Registers, etc.).
+ */
+static bool trans_OUT(DisasContext *ctx, arg_OUT *a)
+{
+    TCGv Rd = cpu_r[a->rd];
+    TCGv port = tcg_const_i32(a->imm);
+
+    gen_helper_outb(cpu_env, port, Rd);
+
+    tcg_temp_free_i32(port);
+
+    return true;
+}
+
+
+/*
+ *  This instruction stores the contents of register Rr on the STACK. The
+ *  Stack Pointer is post-decremented by 1 after the PUSH.  This instruction is
+ *  not available in all devices. Refer to the device specific instruction set
+ *  summary.
+ */
+static bool trans_PUSH(DisasContext *ctx, arg_PUSH *a)
+{
+    TCGv Rd = cpu_r[a->rd];
+
+    gen_data_store(ctx, Rd, cpu_sp);
+    tcg_gen_subi_tl(cpu_sp, cpu_sp, 1);
+
+    return true;
+}
+
+
+/*
+ *  This instruction loads register Rd with a byte from the STACK. The Stack
+ *  Pointer is pre-incremented by 1 before the POP.  This instruction is not
+ *  available in all devices. Refer to the device specific instruction set
+ *  summary.
+ */
+static bool trans_POP(DisasContext *ctx, arg_POP *a)
+{
+    /*
+     * Using a temp to work around some strange behaviour:
+     * tcg_gen_addi_tl(cpu_sp, cpu_sp, 1);
+     * gen_data_load(ctx, Rd, cpu_sp);
+     * seems to cause the add to happen twice.
+     * This doesn't happen if either the add or the load is removed.
+     */
+    TCGv t1 = tcg_temp_new_i32();
+    TCGv Rd = cpu_r[a->rd];
+
+    tcg_gen_addi_tl(t1, cpu_sp, 1);
+    gen_data_load(ctx, Rd, t1);
+    tcg_gen_mov_tl(cpu_sp, t1);
+
+    return true;
+}
+
+
+/*
+ *  Exchanges one byte indirect between register and data space.  The data
+ *  location is pointed to by the Z (16 bits) Pointer Register in the Register
+ *  File. Memory access is limited to the current data segment of 64KB. To
+ *  access another data segment in devices with more than 64KB data space, the
+ *  RAMPZ in register in the I/O area has to be changed.  The Z-pointer Register
+ *  is left unchanged by the operation. This instruction is especially suited
+ *  for writing/reading status bits stored in SRAM.
+ */
+static bool trans_XCH(DisasContext *ctx, arg_XCH *a)
+{
+    if (!avr_have_feature(ctx, AVR_FEATURE_RMW)) {
+        return true;
+    }
+
+    TCGv Rd = cpu_r[a->rd];
+    TCGv t0 = tcg_temp_new_i32();
+    TCGv addr = gen_get_zaddr();
+
+    gen_data_load(ctx, t0, addr);
+    gen_data_store(ctx, Rd, addr);
+    tcg_gen_mov_tl(Rd, t0);
+
+    tcg_temp_free_i32(t0);
+    tcg_temp_free_i32(addr);
+
+    return true;
+}
+
+
+/*
+ *  Load one byte indirect from data space to register and set bits in data
+ *  space specified by the register. The instruction can only be used towards
+ *  internal SRAM.  The data location is pointed to by the Z (16 bits) Pointer
+ *  Register in the Register File. Memory access is limited to the current data
+ *  segment of 64KB. To access another data segment in devices with more than
+ *  64KB data space, the RAMPZ in register in the I/O area has to be changed.
+ *  The Z-pointer Register is left unchanged by the operation. This instruction
+ *  is especially suited for setting status bits stored in SRAM.
+ */
+static bool trans_LAS(DisasContext *ctx, arg_LAS *a)
+{
+    if (!avr_have_feature(ctx, AVR_FEATURE_RMW)) {
+        return true;
+    }
+
+    TCGv Rr = cpu_r[a->rd];
+    TCGv addr = gen_get_zaddr();
+    TCGv t0 = tcg_temp_new_i32();
+    TCGv t1 = tcg_temp_new_i32();
+
+    gen_data_load(ctx, t0, addr); /* t0 = mem[addr] */
+    tcg_gen_or_tl(t1, t0, Rr);
+
+    tcg_gen_mov_tl(Rr, t0); /* Rr = t0 */
+    gen_data_store(ctx, t1, addr); /* mem[addr] = t1 */
+
+    tcg_temp_free_i32(t1);
+    tcg_temp_free_i32(t0);
+    tcg_temp_free_i32(addr);
+
+    return true;
+}
+
+
+/*
+ *  Load one byte indirect from data space to register and stores and clear
+ *  the bits in data space specified by the register. The instruction can
+ *  only be used towards internal SRAM.  The data location is pointed to by
+ *  the Z (16 bits) Pointer Register in the Register File. Memory access is
+ *  limited to the current data segment of 64KB. To access another data
+ *  segment in devices with more than 64KB data space, the RAMPZ in register
+ *  in the I/O area has to be changed.  The Z-pointer Register is left
+ *  unchanged by the operation. This instruction is especially suited for
+ *  clearing status bits stored in SRAM.
+ */
+static bool trans_LAC(DisasContext *ctx, arg_LAC *a)
+{
+    if (!avr_have_feature(ctx, AVR_FEATURE_RMW)) {
+        return true;
+    }
+
+    TCGv Rr = cpu_r[a->rd];
+    TCGv addr = gen_get_zaddr();
+    TCGv t0 = tcg_temp_new_i32();
+    TCGv t1 = tcg_temp_new_i32();
+
+    gen_data_load(ctx, t0, addr); /* t0 = mem[addr] */
+        /* t1 = t0 & (0xff - Rr) = t0 and ~Rr */
+    tcg_gen_andc_tl(t1, t0, Rr);
+
+    tcg_gen_mov_tl(Rr, t0); /* Rr = t0 */
+    gen_data_store(ctx, t1, addr); /* mem[addr] = t1 */
+
+    tcg_temp_free_i32(t1);
+    tcg_temp_free_i32(t0);
+    tcg_temp_free_i32(addr);
+
+    return true;
+}
+
+
+/*
+ *  Load one byte indirect from data space to register and toggles bits in
+ *  the data space specified by the register.  The instruction can only be used
+ *  towards SRAM.  The data location is pointed to by the Z (16 bits) Pointer
+ *  Register in the Register File. Memory access is limited to the current data
+ *  segment of 64KB. To access another data segment in devices with more than
+ *  64KB data space, the RAMPZ in register in the I/O area has to be changed.
+ *  The Z-pointer Register is left unchanged by the operation. This instruction
+ *  is especially suited for changing status bits stored in SRAM.
+ */
+static bool trans_LAT(DisasContext *ctx, arg_LAT *a)
+{
+    if (!avr_have_feature(ctx, AVR_FEATURE_RMW)) {
+        return true;
+    }
+
+    TCGv Rd = cpu_r[a->rd];
+    TCGv addr = gen_get_zaddr();
+    TCGv t0 = tcg_temp_new_i32();
+    TCGv t1 = tcg_temp_new_i32();
+
+    gen_data_load(ctx, t0, addr); /* t0 = mem[addr] */
+    tcg_gen_xor_tl(t1, t0, Rd);
+
+    tcg_gen_mov_tl(Rd, t0); /* Rd = t0 */
+    gen_data_store(ctx, t1, addr); /* mem[addr] = t1 */
+
+    tcg_temp_free_i32(t1);
+    tcg_temp_free_i32(t0);
+    tcg_temp_free_i32(addr);
+
+    return true;
+}
+
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
+
+    tcg_gen_shri_tl(Rd, Rd, 1);
+
+    tcg_gen_mov_tl(cpu_Zf, Rd);
+    tcg_gen_movi_tl(cpu_Nf, 0);
+    tcg_gen_mov_tl(cpu_Vf, cpu_Cf);
+    tcg_gen_mov_tl(cpu_Sf, cpu_Vf);
+
+    return true;
+}
+
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
+
+    gen_rshift_ZNVSf(Rd);
+
+    tcg_temp_free_i32(t0);
+
+    return true;
+}
+
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
+    /* Cf */
+    tcg_gen_andi_tl(cpu_Cf, Rd, 1); /* Cf = Rd(0) */
+
+    /* op */
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
+        tcg_gen_movi_tl(cpu_Zf, 0x00);
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
+        tcg_gen_movi_tl(cpu_Zf, 0x01);
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


