Return-Path: <SRS0=mdN/=VA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA444C06513
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 09:35:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87A47218A5
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 09:35:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87A47218A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34276 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hibg3-0004LQ-Rq
	for qemu-devel@archiver.kernel.org; Wed, 03 Jul 2019 05:35:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51764)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <palmer@dabbelt.com>) id 1hiaqA-0006VQ-A9
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 04:42:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@dabbelt.com>) id 1hiaq6-0008H5-EL
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 04:42:10 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:38290)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1hiaq6-0007o7-1i
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 04:42:06 -0400
Received: by mail-lf1-f66.google.com with SMTP id b11so1160952lfa.5
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2019 01:41:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:cc:from:to;
 bh=2SpGyiOcwOu2Di4eZ5MXnUZbt0L4DyvH2AZMNviRqJg=;
 b=oc69DQFlRFoRXYZNRmQPnx2ilkritllTsMPnyIdqXL4Y0FZe7EJ2XGTYlCSZfAH+wo
 FD2FVgBnGwngYV+gfQQCx/2FsAuU8pXUfFliWFoIyZLwGL/wyDdpzMJdAVX1WzvSrvxa
 yPdZM3WlOVakZekv4KvBNZGd3jEwsGzChO6RVj4dcl6bgtFNv/PX1db+iG6RyBkkLAti
 SbXR5t5cgMnBieqh8/WgfFwmgMC97tyssz/Fd2taeYf3dPwD++BxJYKjcYNjSb+64L1E
 s06hfG/WHXgpkQQcRSm5qnoIEmDJDSBHk3tvbef2N8QhdF97+KNAFObukv2py94eQwxR
 Btlw==
X-Gm-Message-State: APjAAAVAJL8htQE9SAbJXNBbCJcOxxyYq913+vVfUyee3xfh1gLze3SE
 B23kZMUyBGndMn75fiukEywQ+g7fa7kZEg==
X-Google-Smtp-Source: APXvYqxogBcfg/ptX5tJXPP/3OvZnjspkhImesQ09v2bwsXk5Xq24dYUZkaUxKv4FQ9ocWvMjkM/6w==
X-Received: by 2002:ac2:43bb:: with SMTP id t27mr17510781lfl.187.1562143315563; 
 Wed, 03 Jul 2019 01:41:55 -0700 (PDT)
Received: from localhost ([134.17.27.127])
 by smtp.gmail.com with ESMTPSA id b9sm338389ljj.92.2019.07.03.01.41.54
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 03 Jul 2019 01:41:54 -0700 (PDT)
Date: Wed,  3 Jul 2019 01:40:42 -0700
Message-Id: <20190703084048.6980-27-palmer@sifive.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190703084048.6980-1-palmer@sifive.com>
References: <20190703084048.6980-1-palmer@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Palmer Dabbelt <palmer@sifive.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.167.66
Subject: [Qemu-devel] [PULL 26/32] disas/riscv: Disassemble reserved
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
Cc: Alistair Francis <alistair.francis@wdc.com>, Michael Clark <mjc@sifive.com>,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 Palmer Dabbelt <palmer@sifive.com>
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
[Palmer: Broke long lines]
Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 disas/riscv.c | 62 +++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 45 insertions(+), 17 deletions(-)

diff --git a/disas/riscv.c b/disas/riscv.c
index 59a9b0437a5f..d37312705516 100644
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
@@ -1011,7 +1016,8 @@ const rv_opcode_data opcode_data[] = {
     { "fcvt.q.lu", rv_codec_r_m, rv_fmt_rm_frd_rs1, NULL, 0, 0, 0 },
     { "fmv.x.q", rv_codec_r, rv_fmt_rd_frs1, NULL, 0, 0, 0 },
     { "fmv.q.x", rv_codec_r, rv_fmt_frd_rs1, NULL, 0, 0, 0 },
-    { "c.addi4spn", rv_codec_ciw_4spn, rv_fmt_rd_rs1_imm, NULL, rv_op_addi, rv_op_addi, rv_op_addi },
+    { "c.addi4spn", rv_codec_ciw_4spn, rv_fmt_rd_rs1_imm, NULL, rv_op_addi,
+      rv_op_addi, rv_op_addi, rvcd_imm_nz },
     { "c.fld", rv_codec_cl_ld, rv_fmt_frd_offset_rs1, NULL, rv_op_fld, rv_op_fld, 0 },
     { "c.lw", rv_codec_cl_lw, rv_fmt_rd_offset_rs1, NULL, rv_op_lw, rv_op_lw, rv_op_lw },
     { "c.flw", rv_codec_cl_lw, rv_fmt_frd_offset_rs1, NULL, rv_op_flw, 0, 0 },
@@ -1019,14 +1025,20 @@ const rv_opcode_data opcode_data[] = {
     { "c.sw", rv_codec_cs_sw, rv_fmt_rs2_offset_rs1, NULL, rv_op_sw, rv_op_sw, rv_op_sw },
     { "c.fsw", rv_codec_cs_sw, rv_fmt_frs2_offset_rs1, NULL, rv_op_fsw, 0, 0 },
     { "c.nop", rv_codec_ci_none, rv_fmt_none, NULL, rv_op_addi, rv_op_addi, rv_op_addi },
-    { "c.addi", rv_codec_ci, rv_fmt_rd_rs1_imm, NULL, rv_op_addi, rv_op_addi, rv_op_addi },
+    { "c.addi", rv_codec_ci, rv_fmt_rd_rs1_imm, NULL, rv_op_addi, rv_op_addi,
+      rv_op_addi, rvcd_imm_nz },
     { "c.jal", rv_codec_cj_jal, rv_fmt_rd_offset, NULL, rv_op_jal, 0, 0 },
     { "c.li", rv_codec_ci_li, rv_fmt_rd_rs1_imm, NULL, rv_op_addi, rv_op_addi, rv_op_addi },
-    { "c.addi16sp", rv_codec_ci_16sp, rv_fmt_rd_rs1_imm, NULL, rv_op_addi, rv_op_addi, rv_op_addi },
-    { "c.lui", rv_codec_ci_lui, rv_fmt_rd_imm, NULL, rv_op_lui, rv_op_lui, rv_op_lui },
-    { "c.srli", rv_codec_cb_sh6, rv_fmt_rd_rs1_imm, NULL, rv_op_srli, rv_op_srli, rv_op_srli },
-    { "c.srai", rv_codec_cb_sh6, rv_fmt_rd_rs1_imm, NULL, rv_op_srai, rv_op_srai, rv_op_srai },
-    { "c.andi", rv_codec_cb_imm, rv_fmt_rd_rs1_imm, NULL, rv_op_andi, rv_op_andi, rv_op_andi },
+    { "c.addi16sp", rv_codec_ci_16sp, rv_fmt_rd_rs1_imm, NULL, rv_op_addi,
+      rv_op_addi, rv_op_addi, rvcd_imm_nz },
+    { "c.lui", rv_codec_ci_lui, rv_fmt_rd_imm, NULL, rv_op_lui, rv_op_lui,
+      rv_op_lui, rvcd_imm_nz },
+    { "c.srli", rv_codec_cb_sh6, rv_fmt_rd_rs1_imm, NULL, rv_op_srli,
+      rv_op_srli, rv_op_srli, rvcd_imm_nz },
+    { "c.srai", rv_codec_cb_sh6, rv_fmt_rd_rs1_imm, NULL, rv_op_srai,
+      rv_op_srai, rv_op_srai, rvcd_imm_nz },
+    { "c.andi", rv_codec_cb_imm, rv_fmt_rd_rs1_imm, NULL, rv_op_andi,
+      rv_op_andi, rv_op_andi, rvcd_imm_nz },
     { "c.sub", rv_codec_cs, rv_fmt_rd_rs1_rs2, NULL, rv_op_sub, rv_op_sub, rv_op_sub },
     { "c.xor", rv_codec_cs, rv_fmt_rd_rs1_rs2, NULL, rv_op_xor, rv_op_xor, rv_op_xor },
     { "c.or", rv_codec_cs, rv_fmt_rd_rs1_rs2, NULL, rv_op_or, rv_op_or, rv_op_or },
@@ -1036,7 +1048,8 @@ const rv_opcode_data opcode_data[] = {
     { "c.j", rv_codec_cj, rv_fmt_rd_offset, NULL, rv_op_jal, rv_op_jal, rv_op_jal },
     { "c.beqz", rv_codec_cb, rv_fmt_rs1_rs2_offset, NULL, rv_op_beq, rv_op_beq, rv_op_beq },
     { "c.bnez", rv_codec_cb, rv_fmt_rs1_rs2_offset, NULL, rv_op_bne, rv_op_bne, rv_op_bne },
-    { "c.slli", rv_codec_ci_sh6, rv_fmt_rd_rs1_imm, NULL, rv_op_slli, rv_op_slli, rv_op_slli },
+    { "c.slli", rv_codec_ci_sh6, rv_fmt_rd_rs1_imm, NULL, rv_op_slli,
+      rv_op_slli, rv_op_slli, rvcd_imm_nz },
     { "c.fldsp", rv_codec_ci_ldsp, rv_fmt_frd_offset_rs1, NULL, rv_op_fld, rv_op_fld, rv_op_fld },
     { "c.lwsp", rv_codec_ci_lwsp, rv_fmt_rd_offset_rs1, NULL, rv_op_lw, rv_op_lw, rv_op_lw },
     { "c.flwsp", rv_codec_ci_lwsp, rv_fmt_frd_offset_rs1, NULL, rv_op_flw, 0, 0 },
@@ -2795,8 +2808,13 @@ static void decode_inst_decompress_rv32(rv_decode *dec)
 {
     int decomp_op = opcode_data[dec->op].decomp_rv32;
     if (decomp_op != rv_op_illegal) {
-        dec->op = decomp_op;
-        dec->codec = opcode_data[decomp_op].codec;
+        if ((opcode_data[dec->op].decomp_data & rvcd_imm_nz)
+            && dec->imm == 0) {
+            dec->op = rv_op_illegal;
+        } else {
+            dec->op = decomp_op;
+            dec->codec = opcode_data[decomp_op].codec;
+        }
     }
 }
 
@@ -2804,8 +2822,13 @@ static void decode_inst_decompress_rv64(rv_decode *dec)
 {
     int decomp_op = opcode_data[dec->op].decomp_rv64;
     if (decomp_op != rv_op_illegal) {
-        dec->op = decomp_op;
-        dec->codec = opcode_data[decomp_op].codec;
+        if ((opcode_data[dec->op].decomp_data & rvcd_imm_nz)
+            && dec->imm == 0) {
+            dec->op = rv_op_illegal;
+        } else {
+            dec->op = decomp_op;
+            dec->codec = opcode_data[decomp_op].codec;
+        }
     }
 }
 
@@ -2813,8 +2836,13 @@ static void decode_inst_decompress_rv128(rv_decode *dec)
 {
     int decomp_op = opcode_data[dec->op].decomp_rv128;
     if (decomp_op != rv_op_illegal) {
-        dec->op = decomp_op;
-        dec->codec = opcode_data[decomp_op].codec;
+        if ((opcode_data[dec->op].decomp_data & rvcd_imm_nz)
+            && dec->imm == 0) {
+            dec->op = rv_op_illegal;
+        } else {
+            dec->op = decomp_op;
+            dec->codec = opcode_data[decomp_op].codec;
+        }
     }
 }
 
-- 
2.21.0


