Return-Path: <SRS0=5YAC=T2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5324C07542
	for <qemu-devel@archiver.kernel.org>; Sun, 26 May 2019 01:44:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AAB9120815
	for <qemu-devel@archiver.kernel.org>; Sun, 26 May 2019 01:44:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAB9120815
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49362 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hUiDI-00013K-Vl
	for qemu-devel@archiver.kernel.org; Sat, 25 May 2019 21:44:41 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53938)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@dabbelt.com>) id 1hUhxN-0003Hg-BZ
	for qemu-devel@nongnu.org; Sat, 25 May 2019 21:28:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@dabbelt.com>) id 1hUhg4-0005ws-4z
	for qemu-devel@nongnu.org; Sat, 25 May 2019 21:10:23 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44761)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1hUhg2-0005qF-2c
	for qemu-devel@nongnu.org; Sat, 25 May 2019 21:10:20 -0400
Received: by mail-pg1-f194.google.com with SMTP id n2so7074081pgp.11
	for <qemu-devel@nongnu.org>; Sat, 25 May 2019 18:10:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:cc:from:to;
	bh=TIaBbwyzuMcSLzuMAKVEHd8Cem6BcGVf0J9D6QhrDNU=;
	b=iX+D22WILg22Rr2jnCpMwXLioXlG5aV11pTq5qzXO3dHvC5b79cjELgWuqfOyJDwFY
	lYDi6OrVD2o9950YBx8YB19skxoOzsJkqMC+d9QctQqmaP4lqmrNtCPn+3FY+Cgdw1fl
	yJjnI/PHRZAaA15UP+ixzTvzGtLLUnb8XV/OePJRMgtgJDSG4vMeUIFSlinW2DgEsGVh
	zpXu90MBoxBLySGLGoLRdpdxKmoWoIcFAhBHV3CdoycNSMXwSDRIHzo9mfmU9Y1B/DmE
	rpPbF7LN1fkqyNokSDep6B8tNCI61w65SMOsIAygX6OT3qEXKUsLuG3NARVzLtYgQ3wK
	yA2Q==
X-Gm-Message-State: APjAAAXv5GBkzAfprwATlbtDfdWd7ddrCeC0vtt11Tj7jC68SQnWodxm
	Egol5LvxsA8eUWcst/N3H8475Q==
X-Google-Smtp-Source: APXvYqyozVwDVGxuZXxDxL7n1pCTU1rL4M3t1k4vnCxdbCFAE/WIokda87+02o60vZ7NZzoVN/fV1A==
X-Received: by 2002:a17:90a:350d:: with SMTP id
	q13mr20448242pjb.20.1558833013351; 
	Sat, 25 May 2019 18:10:13 -0700 (PDT)
Received: from localhost ([12.206.222.5])
	by smtp.gmail.com with ESMTPSA id f11sm5425875pjg.1.2019.05.25.18.10.12
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Sat, 25 May 2019 18:10:12 -0700 (PDT)
Date: Sat, 25 May 2019 18:09:28 -0700
Message-Id: <20190526010948.3923-10-palmer@sifive.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190526010948.3923-1-palmer@sifive.com>
References: <20190526010948.3923-1-palmer@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Palmer Dabbelt <palmer@sifive.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.215.194
Subject: [Qemu-devel] [PULL 09/29] target/riscv: Split RVC32 and RVC64 insns
 into separate files
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
	Palmer Dabbelt <palmer@sifive.com>, qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <richard.henderson@linaro.org>

This eliminates all functions in insn_trans/trans_rvc.inc.c,
so the entire file can be removed.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 target/riscv/Makefile.objs              |   9 +-
 target/riscv/insn16-32.decode           |  28 ++++++
 target/riscv/insn16-64.decode           |  30 +++++++
 target/riscv/insn16.decode              |  35 +-------
 target/riscv/insn_trans/trans_rvc.inc.c | 115 ------------------------
 target/riscv/translate.c                |   1 -
 6 files changed, 67 insertions(+), 151 deletions(-)
 create mode 100644 target/riscv/insn16-32.decode
 create mode 100644 target/riscv/insn16-64.decode
 delete mode 100644 target/riscv/insn_trans/trans_rvc.inc.c

diff --git a/target/riscv/Makefile.objs b/target/riscv/Makefile.objs
index c7a1b063edc2..b1c79bc1d172 100644
--- a/target/riscv/Makefile.objs
+++ b/target/riscv/Makefile.objs
@@ -5,16 +5,19 @@ DECODETREE = $(SRC_PATH)/scripts/decodetree.py
 decode32-y = $(SRC_PATH)/target/riscv/insn32.decode
 decode32-$(TARGET_RISCV64) += $(SRC_PATH)/target/riscv/insn32-64.decode
 
+decode16-y = $(SRC_PATH)/target/riscv/insn16.decode
+decode16-$(TARGET_RISCV32) += $(SRC_PATH)/target/riscv/insn16-32.decode
+decode16-$(TARGET_RISCV64) += $(SRC_PATH)/target/riscv/insn16-64.decode
+
 target/riscv/decode_insn32.inc.c: $(decode32-y) $(DECODETREE)
 	$(call quiet-command, \
 	  $(PYTHON) $(DECODETREE) -o $@ --static-decode decode_insn32 \
           $(decode32-y), "GEN", $(TARGET_DIR)$@)
 
-target/riscv/decode_insn16.inc.c: \
-  $(SRC_PATH)/target/riscv/insn16.decode $(DECODETREE)
+target/riscv/decode_insn16.inc.c: $(decode16-y) $(DECODETREE)
 	$(call quiet-command, \
 	  $(PYTHON) $(DECODETREE) -o $@ --static-decode decode_insn16 \
-          --insnwidth 16 $<, "GEN", $(TARGET_DIR)$@)
+          --insnwidth 16 $(decode16-y), "GEN", $(TARGET_DIR)$@)
 
 target/riscv/translate.o: target/riscv/decode_insn32.inc.c \
 	target/riscv/decode_insn16.inc.c
diff --git a/target/riscv/insn16-32.decode b/target/riscv/insn16-32.decode
new file mode 100644
index 000000000000..0819b17028ef
--- /dev/null
+++ b/target/riscv/insn16-32.decode
@@ -0,0 +1,28 @@
+#
+# RISC-V translation routines for the RVXI Base Integer Instruction Set.
+#
+# Copyright (c) 2018 Peer Adelt, peer.adelt@hni.uni-paderborn.de
+#                    Bastian Koppelmann, kbastian@mail.uni-paderborn.de
+#
+# This program is free software; you can redistribute it and/or modify it
+# under the terms and conditions of the GNU General Public License,
+# version 2 or later, as published by the Free Software Foundation.
+#
+# This program is distributed in the hope it will be useful, but WITHOUT
+# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+# FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+# more details.
+#
+# You should have received a copy of the GNU General Public License along with
+# this program.  If not, see <http://www.gnu.org/licenses/>.
+
+# *** RV32C Standard Extension (Quadrant 0) ***
+flw               011  ... ... .. ... 00 @cl_w
+fsw               111  ... ... .. ... 00 @cs_w
+
+# *** RV32C Standard Extension (Quadrant 1) ***
+jal               001     ........... 01 @cj    rd=1  # C.JAL
+
+# *** RV32C Standard Extension (Quadrant 2) ***
+flw               011 .  .....  ..... 10 @c_lwsp
+fsw               111 .  .....  ..... 10 @c_swsp
diff --git a/target/riscv/insn16-64.decode b/target/riscv/insn16-64.decode
new file mode 100644
index 000000000000..055859d29f61
--- /dev/null
+++ b/target/riscv/insn16-64.decode
@@ -0,0 +1,30 @@
+#
+# RISC-V translation routines for the RVXI Base Integer Instruction Set.
+#
+# Copyright (c) 2018 Peer Adelt, peer.adelt@hni.uni-paderborn.de
+#                    Bastian Koppelmann, kbastian@mail.uni-paderborn.de
+#
+# This program is free software; you can redistribute it and/or modify it
+# under the terms and conditions of the GNU General Public License,
+# version 2 or later, as published by the Free Software Foundation.
+#
+# This program is distributed in the hope it will be useful, but WITHOUT
+# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+# FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+# more details.
+#
+# You should have received a copy of the GNU General Public License along with
+# this program.  If not, see <http://www.gnu.org/licenses/>.
+
+# *** RV64C Standard Extension (Quadrant 0) ***
+ld                011  ... ... .. ... 00 @cl_d
+sd                111  ... ... .. ... 00 @cs_d
+
+# *** RV64C Standard Extension (Quadrant 1) ***
+addiw             001 .  .....  ..... 01 @ci
+subw              100 1 11 ... 00 ... 01 @cs_2
+addw              100 1 11 ... 01 ... 01 @cs_2
+
+# *** RV64C Standard Extension (Quadrant 2) ***
+ld                011 .  .....  ..... 10 @c_ldsp
+sd                111 .  .....  ..... 10 @c_sdsp
diff --git a/target/riscv/insn16.decode b/target/riscv/insn16.decode
index 3c79edf1c996..433c0e8c6861 100644
--- a/target/riscv/insn16.decode
+++ b/target/riscv/insn16.decode
@@ -50,30 +50,12 @@
 &u         imm rd       !extern
 &shift     shamt rs1 rd !extern
 
-# Argument sets:
-&cl               rs1 rd
-&cl_dw     uimm   rs1 rd
-&ciw       nzuimm     rd
-&cs               rs1 rs2
-&cs_dw     uimm   rs1 rs2
-&cb        imm    rs1
-&cr               rd  rs2
-&c_shift   shamt      rd
-
-&c_ld      uimm  rd
-&c_sd      uimm  rs2
-
-&caddi16sp_lui  imm_lui imm_addi16sp rd
-&cflwsp_ldsp    uimm_flwsp uimm_ldsp rd
-&cfswsp_sdsp    uimm_fswsp uimm_sdsp rs2
 
 # Formats 16:
 @cr        ....  ..... .....  .. &r      rs2=%rs2_5       rs1=%rd     %rd
 @ci        ... . ..... .....  .. &i      imm=%imm_ci      rs1=%rd     %rd
 @cl_d      ... ... ... .. ... .. &i      imm=%uimm_cl_d   rs1=%rs1_3  rd=%rs2_3
 @cl_w      ... ... ... .. ... .. &i      imm=%uimm_cl_w   rs1=%rs1_3  rd=%rs2_3
-@cl        ... ... ... .. ... .. &cl                      rs1=%rs1_3  rd=%rs2_3
-@cs        ... ... ... .. ... .. &cs                      rs1=%rs1_3  rs2=%rs2_3
 @cs_2      ... ... ... .. ... .. &r      rs2=%rs2_3       rs1=%rs1_3  rd=%rs1_3
 @cs_d      ... ... ... .. ... .. &s      imm=%uimm_cl_d   rs1=%rs1_3  rs2=%rs2_3
 @cs_w      ... ... ... .. ... .. &s      imm=%uimm_cl_w   rs1=%rs1_3  rs2=%rs2_3
@@ -91,10 +73,6 @@
 
 @c_addi4spn     ... .  ..... ..... .. &i imm=%nzuimm_ciw rs1=2 rd=%rs2_3
 @c_addi16sp     ... .  ..... ..... .. &i imm=%imm_addi16sp rs1=2 rd=2
-@c_flwsp_ldsp   ... .  ..... ..... .. &cflwsp_ldsp uimm_flwsp=%uimm_6bit_lw \
-    uimm_ldsp=%uimm_6bit_ld %rd
-@c_fswsp_sdsp   ... .  ..... ..... .. &cfswsp_sdsp uimm_fswsp=%uimm_6bit_sw \
-    uimm_sdsp=%uimm_6bit_sd rs2=%rs2_5
 
 @c_shift        ... . .. ... ..... .. \
                 &shift rd=%rs1_3 rs1=%rs1_3 shamt=%shimm_6bit
@@ -103,7 +81,7 @@
 
 @c_andi         ... . .. ... ..... .. &i imm=%imm_ci rs1=%rs1_3 rd=%rs1_3
 
-# *** RV64C Standard Extension (Quadrant 0) ***
+# *** RV32/64C Standard Extension (Quadrant 0) ***
 {
   # Opcode of all zeros is illegal; rd != 0, nzuimm == 0 is reserved.
   illegal         000  000 000 00 --- 00
@@ -111,14 +89,11 @@
 }
 fld               001  ... ... .. ... 00 @cl_d
 lw                010  ... ... .. ... 00 @cl_w
-c_flw_ld          011  --- ... -- ... 00 @cl    #Note: Must parse uimm manually
 fsd               101  ... ... .. ... 00 @cs_d
 sw                110  ... ... .. ... 00 @cs_w
-c_fsw_sd          111  --- ... -- ... 00 @cs    #Note: Must parse uimm manually
 
-# *** RV64C Standard Extension (Quadrant 1) ***
+# *** RV32/64C Standard Extension (Quadrant 1) ***
 addi              000 .  .....  ..... 01 @ci
-c_jal_addiw       001 .  .....  ..... 01 @ci #Note: parse rd and/or imm manually
 addi              010 .  .....  ..... 01 @c_li
 {
   addi            011 .  00010  ..... 01 @c_addi16sp
@@ -131,17 +106,14 @@ sub               100 0 11 ... 00 ... 01 @cs_2
 xor               100 0 11 ... 01 ... 01 @cs_2
 or                100 0 11 ... 10 ... 01 @cs_2
 and               100 0 11 ... 11 ... 01 @cs_2
-c_subw            100 1 11 ... 00 ... 01 @cs_2
-c_addw            100 1 11 ... 01 ... 01 @cs_2
 jal               101     ........... 01 @cj    rd=0  # C.J
 beq               110  ... ...  ..... 01 @cb_z
 bne               111  ... ...  ..... 01 @cb_z
 
-# *** RV64C Standard Extension (Quadrant 2) ***
+# *** RV32/64C Standard Extension (Quadrant 2) ***
 slli              000 .  .....  ..... 10 @c_shift2
 fld               001 .  .....  ..... 10 @c_ldsp
 lw                010 .  .....  ..... 10 @c_lwsp
-c_flwsp_ldsp      011 .  .....  ..... 10 @c_flwsp_ldsp #C.LDSP:RV64;C.FLWSP:RV32
 {
   jalr            100 0  .....  00000 10 @c_jalr rd=0  # C.JR
   addi            100 0  .....  ..... 10 @c_mv
@@ -153,4 +125,3 @@ c_flwsp_ldsp      011 .  .....  ..... 10 @c_flwsp_ldsp #C.LDSP:RV64;C.FLWSP:RV32
 }
 fsd               101   ......  ..... 10 @c_sdsp
 sw                110 .  .....  ..... 10 @c_swsp
-c_fswsp_sdsp      111 .  .....  ..... 10 @c_fswsp_sdsp #C.SDSP:RV64;C.FSWSP:RV32
diff --git a/target/riscv/insn_trans/trans_rvc.inc.c b/target/riscv/insn_trans/trans_rvc.inc.c
deleted file mode 100644
index 3fe6ad9d4592..000000000000
--- a/target/riscv/insn_trans/trans_rvc.inc.c
+++ /dev/null
@@ -1,115 +0,0 @@
-/*
- * RISC-V translation routines for the RVC Compressed Instruction Set.
- *
- * Copyright (c) 2016-2017 Sagar Karandikar, sagark@eecs.berkeley.edu
- * Copyright (c) 2018 Peer Adelt, peer.adelt@hni.uni-paderborn.de
- *                    Bastian Koppelmann, kbastian@mail.uni-paderborn.de
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms and conditions of the GNU General Public License,
- * version 2 or later, as published by the Free Software Foundation.
- *
- * This program is distributed in the hope it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program.  If not, see <http://www.gnu.org/licenses/>.
- */
-
-static bool trans_c_flw_ld(DisasContext *ctx, arg_c_flw_ld *a)
-{
-#ifdef TARGET_RISCV32
-    /* C.FLW ( RV32FC-only ) */
-    REQUIRE_FPU;
-    REQUIRE_EXT(ctx, RVF);
-
-    arg_i arg;
-    decode_insn16_extract_cl_w(ctx, &arg, ctx->opcode);
-    return trans_flw(ctx, &arg);
-#else
-    /* C.LD ( RV64C/RV128C-only ) */
-    arg_i arg;
-    decode_insn16_extract_cl_d(ctx, &arg, ctx->opcode);
-    return trans_ld(ctx, &arg);
-#endif
-}
-
-static bool trans_c_fsw_sd(DisasContext *ctx, arg_c_fsw_sd *a)
-{
-#ifdef TARGET_RISCV32
-    /* C.FSW ( RV32FC-only ) */
-    REQUIRE_FPU;
-    REQUIRE_EXT(ctx, RVF);
-
-    arg_s arg;
-    decode_insn16_extract_cs_w(ctx, &arg, ctx->opcode);
-    return trans_fsw(ctx, &arg);
-#else
-    /* C.SD ( RV64C/RV128C-only ) */
-    arg_s arg;
-    decode_insn16_extract_cs_d(ctx, &arg, ctx->opcode);
-    return trans_sd(ctx, &arg);
-#endif
-}
-
-static bool trans_c_jal_addiw(DisasContext *ctx, arg_c_jal_addiw *a)
-{
-#ifdef TARGET_RISCV32
-    /* C.JAL */
-    arg_j tmp;
-    decode_insn16_extract_cj(ctx, &tmp, ctx->opcode);
-    arg_jal arg = { .rd = 1, .imm = tmp.imm };
-    return trans_jal(ctx, &arg);
-#else
-    /* C.ADDIW */
-    arg_addiw arg = { .rd = a->rd, .rs1 = a->rd, .imm = a->imm };
-    return trans_addiw(ctx, &arg);
-#endif
-}
-
-static bool trans_c_subw(DisasContext *ctx, arg_c_subw *a)
-{
-#ifdef TARGET_RISCV64
-    return trans_subw(ctx, a);
-#else
-    return false;
-#endif
-}
-
-static bool trans_c_addw(DisasContext *ctx, arg_c_addw *a)
-{
-#ifdef TARGET_RISCV64
-    return trans_addw(ctx, a);
-#else
-    return false;
-#endif
-}
-
-static bool trans_c_flwsp_ldsp(DisasContext *ctx, arg_c_flwsp_ldsp *a)
-{
-#ifdef TARGET_RISCV32
-    /* C.FLWSP */
-    arg_flw arg_flw = { .rd = a->rd, .rs1 = 2, .imm = a->uimm_flwsp };
-    return trans_flw(ctx, &arg_flw);
-#else
-    /* C.LDSP */
-    arg_ld arg_ld = { .rd = a->rd, .rs1 = 2, .imm = a->uimm_ldsp };
-    return trans_ld(ctx, &arg_ld);
-#endif
-    return false;
-}
-
-static bool trans_c_fswsp_sdsp(DisasContext *ctx, arg_c_fswsp_sdsp *a)
-{
-#ifdef TARGET_RISCV32
-    /* C.FSWSP */
-    arg_fsw a_fsw = { .rs1 = 2, .rs2 = a->rs2, .imm = a->uimm_fswsp };
-    return trans_fsw(ctx, &a_fsw);
-#else
-    /* C.SDSP */
-    arg_sd a_sd = { .rs1 = 2, .rs2 = a->rs2, .imm = a->uimm_sdsp };
-    return trans_sd(ctx, &a_sd);
-#endif
-}
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 4cdffb23a475..8b37e0928f50 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -707,7 +707,6 @@ static bool gen_shift(DisasContext *ctx, arg_r *a,
 #endif
 
 #include "decode_insn16.inc.c"
-#include "insn_trans/trans_rvc.inc.c"
 
 #ifdef CONFIG_PRAGMA_DIAGNOSTIC_AVAILABLE
 # pragma GCC diagnostic pop
-- 
2.21.0


