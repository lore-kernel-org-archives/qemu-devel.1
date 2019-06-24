Return-Path: <SRS0=7PyC=UX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2017C4646C
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 23:48:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84A5D20679
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 23:48:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="mlFqS3CD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84A5D20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55520 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfYhd-0003WD-Mr
	for qemu-devel@archiver.kernel.org; Mon, 24 Jun 2019 19:48:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52001)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <prvs=07161884e=alistair.francis@wdc.com>)
 id 1hfYe6-0001IF-46
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 19:45:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=07161884e=alistair.francis@wdc.com>)
 id 1hfYe2-0001Ex-Pt
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 19:45:08 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:37538)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=07161884e=alistair.francis@wdc.com>)
 id 1hfYe0-00017w-SI; Mon, 24 Jun 2019 19:45:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1561419905; x=1592955905;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=AkXk3+/Cx/HeTEYsri6aN7yfdtd7KRSDpwA15hzxvzw=;
 b=mlFqS3CDUouz/rEUtQGr3w0dvWV06PLfDvvXxtOpZPm3IhOagBnIs9yA
 ALsup9b/yLF7lTnTwmQU3UnylV8rTZQ7U1xvIa0R8XHuHbyoR/LyMGHXy
 SMn3DfYDfMisjlMbHCjgSxH8hOunvNwfNn1vxoX1B3L1iyRsL758AMKqx
 KaGz0bDyfFguX/s9LQE28V2LNlwjVKqWHuDsuIFKwlIuHs1NuJobYIz6a
 og21oyVy7w7RHpGPfVyOXbgIeH17np1uTMbTv4t2JD0XBB8S0j+VqudFJ
 XTAjLfpnWvsPl9enoNUkgPgqS4uaeWzlBRt2FI38M3FA83rN/1L6/zWkO A==;
X-IronPort-AV: E=Sophos;i="5.63,413,1557158400"; d="scan'208";a="116313411"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 25 Jun 2019 07:45:02 +0800
IronPort-SDR: 0y0wQQH5gyYVxRNWHt6ZlWBoBuqJS6jtO7ci5VtCLVSeD6zRZ2gmtKhiT9B9RYOm8VJdx2OL48
 383qOLOXPwWZ2iK5+aBJmsucrIUvCHbenaquxNeyX3KoaAsRJG1/bTWR1arJQhd2AuJmwmoXb9
 TROjq+SYnqOQFwP9GJQjKcvhYo3reEdA2EumR6stpoOPfW0h+w67/0MwgNAbIRs/ecTpeDjLJ0
 MuRw92z2bGBYWFZ4rawgwc1uPmh3jA5qeU0HrMl44VWqL/chBfmw6eRZUCSuINV+byPri3oI14
 67VSCgW/xg3lDGnVfwO5SWqk
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP; 24 Jun 2019 16:44:13 -0700
IronPort-SDR: AD0BVeFmwznA93/zaNrXve0uAS9zI9s19hAEDZ4TBNC0TRTZXkfzKm2rzP1e6404bIwU/3pOXX
 cwW2MH2uR9jvUEQDXInrtdgtyaCex7L30V+zG2RgVvNi0R8OcMXvhT/GMcE0btkv75zpwuabnr
 g9NGO54xNlU5pPugc8i6Y+KxnWBjSPGC8z383UBk8PSbq5cNwc3Q1dAhzLBYN/OVsorHRhyy4c
 gk7K1+VBm7gOBZfVny1VzJxCvozcOOTpb2OyVzIv9VNEM4BEOlf4K5QvxBFYUtnH8cbGUhHkgG
 BsE=
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.157.140])
 by uls-op-cesaip02.wdc.com with ESMTP; 24 Jun 2019 16:45:00 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Date: Mon, 24 Jun 2019 16:42:33 -0700
Message-Id: <7c76d6a9fb6f47db7d0363fbb94bcfe9b6eebcc5.1561419713.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <cover.1561419713.git.alistair.francis@wdc.com>
References: <cover.1561419713.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 216.71.153.141
Subject: [Qemu-devel] [PATCH v2 2/4] disas/riscv: Disassemble reserved
 compressed encodings as illegal
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
Cc: alistair23@gmail.com, palmer@sifive.com, alistair.francis@wdc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Michael Clark <mjc@sifive.com>

Due to the design of the disassembler, the immediate is not
known during decoding of the opcode; so to handle compressed
encodings with reserved immediate values (non-zero), we need
to add an additional check during decompression to match
reserved encodings with zero immediates and translate them
into the illegal instruction.

The following compressed opcodes have reserved encodings with
zero immediates: c.addi4spn, c.addi, c.lui, c.addi16sp, c.srli,
c.srai, c.andi and c.slli

Signed-off-by: Michael Clark <mjc@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 disas/riscv.c | 51 ++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 34 insertions(+), 17 deletions(-)

diff --git a/disas/riscv.c b/disas/riscv.c
index 59a9b0437a..3ab4586f0a 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -504,14 +504,19 @@ typedef struct {
     const rvc_constraint *constraints;
 } rv_comp_data;
 
+enum {
+    rvcd_imm_nz = 0x1
+};
+
 typedef struct {
     const char * const name;
     const rv_codec codec;
     const char * const format;
     const rv_comp_data *pseudo;
-    const int decomp_rv32;
-    const int decomp_rv64;
-    const int decomp_rv128;
+    const short decomp_rv32;
+    const short decomp_rv64;
+    const short decomp_rv128;
+    const short decomp_data;
 } rv_opcode_data;
 
 /* register names */
@@ -1011,7 +1016,7 @@ const rv_opcode_data opcode_data[] = {
     { "fcvt.q.lu", rv_codec_r_m, rv_fmt_rm_frd_rs1, NULL, 0, 0, 0 },
     { "fmv.x.q", rv_codec_r, rv_fmt_rd_frs1, NULL, 0, 0, 0 },
     { "fmv.q.x", rv_codec_r, rv_fmt_frd_rs1, NULL, 0, 0, 0 },
-    { "c.addi4spn", rv_codec_ciw_4spn, rv_fmt_rd_rs1_imm, NULL, rv_op_addi, rv_op_addi, rv_op_addi },
+    { "c.addi4spn", rv_codec_ciw_4spn, rv_fmt_rd_rs1_imm, NULL, rv_op_addi, rv_op_addi, rv_op_addi, rvcd_imm_nz },
     { "c.fld", rv_codec_cl_ld, rv_fmt_frd_offset_rs1, NULL, rv_op_fld, rv_op_fld, 0 },
     { "c.lw", rv_codec_cl_lw, rv_fmt_rd_offset_rs1, NULL, rv_op_lw, rv_op_lw, rv_op_lw },
     { "c.flw", rv_codec_cl_lw, rv_fmt_frd_offset_rs1, NULL, rv_op_flw, 0, 0 },
@@ -1019,14 +1024,14 @@ const rv_opcode_data opcode_data[] = {
     { "c.sw", rv_codec_cs_sw, rv_fmt_rs2_offset_rs1, NULL, rv_op_sw, rv_op_sw, rv_op_sw },
     { "c.fsw", rv_codec_cs_sw, rv_fmt_frs2_offset_rs1, NULL, rv_op_fsw, 0, 0 },
     { "c.nop", rv_codec_ci_none, rv_fmt_none, NULL, rv_op_addi, rv_op_addi, rv_op_addi },
-    { "c.addi", rv_codec_ci, rv_fmt_rd_rs1_imm, NULL, rv_op_addi, rv_op_addi, rv_op_addi },
+    { "c.addi", rv_codec_ci, rv_fmt_rd_rs1_imm, NULL, rv_op_addi, rv_op_addi, rv_op_addi, rvcd_imm_nz },
     { "c.jal", rv_codec_cj_jal, rv_fmt_rd_offset, NULL, rv_op_jal, 0, 0 },
     { "c.li", rv_codec_ci_li, rv_fmt_rd_rs1_imm, NULL, rv_op_addi, rv_op_addi, rv_op_addi },
-    { "c.addi16sp", rv_codec_ci_16sp, rv_fmt_rd_rs1_imm, NULL, rv_op_addi, rv_op_addi, rv_op_addi },
-    { "c.lui", rv_codec_ci_lui, rv_fmt_rd_imm, NULL, rv_op_lui, rv_op_lui, rv_op_lui },
-    { "c.srli", rv_codec_cb_sh6, rv_fmt_rd_rs1_imm, NULL, rv_op_srli, rv_op_srli, rv_op_srli },
-    { "c.srai", rv_codec_cb_sh6, rv_fmt_rd_rs1_imm, NULL, rv_op_srai, rv_op_srai, rv_op_srai },
-    { "c.andi", rv_codec_cb_imm, rv_fmt_rd_rs1_imm, NULL, rv_op_andi, rv_op_andi, rv_op_andi },
+    { "c.addi16sp", rv_codec_ci_16sp, rv_fmt_rd_rs1_imm, NULL, rv_op_addi, rv_op_addi, rv_op_addi, rvcd_imm_nz },
+    { "c.lui", rv_codec_ci_lui, rv_fmt_rd_imm, NULL, rv_op_lui, rv_op_lui, rv_op_lui, rvcd_imm_nz },
+    { "c.srli", rv_codec_cb_sh6, rv_fmt_rd_rs1_imm, NULL, rv_op_srli, rv_op_srli, rv_op_srli, rvcd_imm_nz },
+    { "c.srai", rv_codec_cb_sh6, rv_fmt_rd_rs1_imm, NULL, rv_op_srai, rv_op_srai, rv_op_srai, rvcd_imm_nz },
+    { "c.andi", rv_codec_cb_imm, rv_fmt_rd_rs1_imm, NULL, rv_op_andi, rv_op_andi, rv_op_andi, rvcd_imm_nz },
     { "c.sub", rv_codec_cs, rv_fmt_rd_rs1_rs2, NULL, rv_op_sub, rv_op_sub, rv_op_sub },
     { "c.xor", rv_codec_cs, rv_fmt_rd_rs1_rs2, NULL, rv_op_xor, rv_op_xor, rv_op_xor },
     { "c.or", rv_codec_cs, rv_fmt_rd_rs1_rs2, NULL, rv_op_or, rv_op_or, rv_op_or },
@@ -1036,7 +1041,7 @@ const rv_opcode_data opcode_data[] = {
     { "c.j", rv_codec_cj, rv_fmt_rd_offset, NULL, rv_op_jal, rv_op_jal, rv_op_jal },
     { "c.beqz", rv_codec_cb, rv_fmt_rs1_rs2_offset, NULL, rv_op_beq, rv_op_beq, rv_op_beq },
     { "c.bnez", rv_codec_cb, rv_fmt_rs1_rs2_offset, NULL, rv_op_bne, rv_op_bne, rv_op_bne },
-    { "c.slli", rv_codec_ci_sh6, rv_fmt_rd_rs1_imm, NULL, rv_op_slli, rv_op_slli, rv_op_slli },
+    { "c.slli", rv_codec_ci_sh6, rv_fmt_rd_rs1_imm, NULL, rv_op_slli, rv_op_slli, rv_op_slli, rvcd_imm_nz },
     { "c.fldsp", rv_codec_ci_ldsp, rv_fmt_frd_offset_rs1, NULL, rv_op_fld, rv_op_fld, rv_op_fld },
     { "c.lwsp", rv_codec_ci_lwsp, rv_fmt_rd_offset_rs1, NULL, rv_op_lw, rv_op_lw, rv_op_lw },
     { "c.flwsp", rv_codec_ci_lwsp, rv_fmt_frd_offset_rs1, NULL, rv_op_flw, 0, 0 },
@@ -2795,8 +2800,12 @@ static void decode_inst_decompress_rv32(rv_decode *dec)
 {
     int decomp_op = opcode_data[dec->op].decomp_rv32;
     if (decomp_op != rv_op_illegal) {
-        dec->op = decomp_op;
-        dec->codec = opcode_data[decomp_op].codec;
+        if ((opcode_data[dec->op].decomp_data & rvcd_imm_nz) && dec->imm == 0) {
+            dec->op = rv_op_illegal;
+        } else {
+            dec->op = decomp_op;
+            dec->codec = opcode_data[decomp_op].codec;
+        }
     }
 }
 
@@ -2804,8 +2813,12 @@ static void decode_inst_decompress_rv64(rv_decode *dec)
 {
     int decomp_op = opcode_data[dec->op].decomp_rv64;
     if (decomp_op != rv_op_illegal) {
-        dec->op = decomp_op;
-        dec->codec = opcode_data[decomp_op].codec;
+        if ((opcode_data[dec->op].decomp_data & rvcd_imm_nz) && dec->imm == 0) {
+            dec->op = rv_op_illegal;
+        } else {
+            dec->op = decomp_op;
+            dec->codec = opcode_data[decomp_op].codec;
+        }
     }
 }
 
@@ -2813,8 +2826,12 @@ static void decode_inst_decompress_rv128(rv_decode *dec)
 {
     int decomp_op = opcode_data[dec->op].decomp_rv128;
     if (decomp_op != rv_op_illegal) {
-        dec->op = decomp_op;
-        dec->codec = opcode_data[decomp_op].codec;
+        if ((opcode_data[dec->op].decomp_data & rvcd_imm_nz) && dec->imm == 0) {
+            dec->op = rv_op_illegal;
+        } else {
+            dec->op = decomp_op;
+            dec->codec = opcode_data[decomp_op].codec;
+        }
     }
 }
 
-- 
2.22.0


