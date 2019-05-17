Return-Path: <SRS0=PxdI=TR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA6D5C04AB4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 22:14:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 748772087E
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 22:14:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="YJK1BXPm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 748772087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54327 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRl7y-0000hA-Gv
	for qemu-devel@archiver.kernel.org; Fri, 17 May 2019 18:14:58 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37087)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=033a92d29=alistair.francis@wdc.com>)
	id 1hRl61-0007tu-G0
	for qemu-devel@nongnu.org; Fri, 17 May 2019 18:13:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=033a92d29=alistair.francis@wdc.com>)
	id 1hRl5z-0007KV-Nc
	for qemu-devel@nongnu.org; Fri, 17 May 2019 18:12:57 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:41014)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <prvs=033a92d29=alistair.francis@wdc.com>)
	id 1hRl5y-0007GL-25; Fri, 17 May 2019 18:12:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
	d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
	t=1558131175; x=1589667175;
	h=from:to:cc:subject:date:message-id:in-reply-to:
	references:mime-version:content-transfer-encoding;
	bh=RskmDp4j3KgbBIS2jyvrO4SZ54oGm0BoWelhuc13RH0=;
	b=YJK1BXPmIKdlutRMUUjD8WCcMn0mW34O8H+erFZ+HD15dDdGdYHuCrk1
	FSPa5mvUQloL8Abz+yI83o8D3RjZ0FQ3vu/jl2Ibw1XWaT6cwQLagNdbb
	VUJBS8q5qXrTC8A2vZA4qzS24oB22NYV5oANcxCSnpcAZZa4Q/IC1wxem
	/avQ/H9xVBKGSmYiVRizqcH9yhbEv6xgdm6m215E8tTWC++ZgJoNvydSR
	msoSr83txTrLfs0QVgLtkoKLfH2X7rt2nS9s0kkuoIxbyUc5YSaFR6Ibc
	pdtSsYc3l+LA15R9azbsSb0NR2jsUmQJXY1sSGf1l2TvxNDGxdaRtOvJG Q==;
X-IronPort-AV: E=Sophos;i="5.60,481,1549900800"; d="scan'208";a="110242476"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
	([199.255.45.14])
	by ob1.hgst.iphmx.com with ESMTP; 18 May 2019 06:12:48 +0800
IronPort-SDR: /bXG8hyLW+RrqeAataDe9A3bsxqsHkCaqR7AwUKObSk8LheqP0oWwzxZR7Zu+bVUoK4yNdumrK
	gmRWlCpyorVXiDJlRzGrX25LVVbm6tGAudr+IHVPAPYTSqZrBp/aY5JV6GQLlaKBeH4LwdRJsP
	HeUpZFFCWjwEeZcf5GFKUKdQdIHpVbu5bNqs0ASL0kblWFtnJKadRIzneyE2lgRLF2A4NLLjzs
	WbQgnStYJzNPfE0GxSNg93zOEbVQ5pFdBoMgKFfWUmYR/2J5nwNJ5ZlcTYXnUx4OyHtTEm6FOq
	4WHwJaZFeMeIF/wwav3kxaIv
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
	by uls-op-cesaep01.wdc.com with ESMTP; 17 May 2019 14:48:17 -0700
IronPort-SDR: BR8YwXfSNi2NetMtB9HNZmssyDn1SwZoUxyOfj7JmEAyIWXhOizCVGzbsuakeOYNh3Ni/E8x3E
	mbN8bR1HYs2KzVAEP8kqy9dYKBPDlOnr4sBqOiyzR2pNRer2GUkPC0if4QoO5RZcefKwX7O+fq
	hCCPjde8C+OBgHcTgcpWc0imbxsi7X09aXeXWbY8MuMaKUF9+XO9hxCbV1P6KY8dg6/9OrJKn8
	dEcSH5KM10RizvLvfEBC0WNNeaxkCzzqu5s2qaMi1OhYaRUzB8fw0QXCIvDoa5nLyhfxZDQeoP
	+wA=
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
	risc6-mainframe.int.fusionio.com) ([10.196.157.140])
	by uls-op-cesaip01.wdc.com with ESMTP; 17 May 2019 15:12:47 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Date: Fri, 17 May 2019 15:11:01 -0700
Message-Id: <4e552352bb35b1f4b086e260be369464df7c490e.1558131003.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1558131003.git.alistair.francis@wdc.com>
References: <cover.1558131003.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 216.71.154.45
Subject: [Qemu-devel] [PATCH v1 2/4] disas/riscv: Disassemble reserved
 compressed encodings as illegal
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
2.21.0


