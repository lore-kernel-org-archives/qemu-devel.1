Return-Path: <SRS0=5YAC=T2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD7E5C07542
	for <qemu-devel@archiver.kernel.org>; Sun, 26 May 2019 01:47:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F78620815
	for <qemu-devel@archiver.kernel.org>; Sun, 26 May 2019 01:47:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F78620815
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49413 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hUiFZ-0002yp-T0
	for qemu-devel@archiver.kernel.org; Sat, 25 May 2019 21:47:01 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54116)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@dabbelt.com>) id 1hUhxO-0003S6-Sl
	for qemu-devel@nongnu.org; Sat, 25 May 2019 21:28:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@dabbelt.com>) id 1hUhfx-0005pj-14
	for qemu-devel@nongnu.org; Sat, 25 May 2019 21:10:16 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42328)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1hUhfu-0005oR-Lb
	for qemu-devel@nongnu.org; Sat, 25 May 2019 21:10:11 -0400
Received: by mail-pg1-f194.google.com with SMTP id 33so4123101pgv.9
	for <qemu-devel@nongnu.org>; Sat, 25 May 2019 18:10:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:cc:from:to;
	bh=jF0PA9R8NUiDGAz7tTfjlDMUwsEMu8tQxUWNp2LZs14=;
	b=i8ujr4Eq88dk3phWrpT4Eb+MNqwnzGUWN8tuP1SGNKr5skjKEgFRmLBQXDLrW/K0m8
	z1lPo8Q4btue+arSnRAyzTY0edM12fpUKjFnr+dAEg7GMS+jMJLBucBUS6gjvHJfo7J8
	n/Y7Hn+KugiCPT2GrX8e+vZvcHeKm4cY7f8bjfjrCa4Y7Q7Bzaimd6y1p6mz7Np7Pfxz
	CzBEuCkwHyZzmRO7f7ImzP7OKQGN7WZC/s9tzvqSOQu3eMV6e7UbULmYAf1ZR/BpkFJ5
	ls+mzfo1FYMY4EtJSm6CtpuwbuSrxtpwnVYEzoNagry3CQB32VXTP5u156sWpXXp2fKq
	VqOg==
X-Gm-Message-State: APjAAAXAJuQ62puD9jH1sBTqYJOf2VT5C0dvdiC0DIsuVv+9WhrhZksA
	Dv2jtSlcNHKnog6Z+oRSn2/U2Q==
X-Google-Smtp-Source: APXvYqzQ0cqTvTCWwCgRE/T+mFh/MOc+eU0pI5O74O6aHtT9MvppvSp88rLTzJYoHcfTOF+3fLTfvg==
X-Received: by 2002:a63:1e62:: with SMTP id p34mr29943143pgm.49.1558833008421; 
	Sat, 25 May 2019 18:10:08 -0700 (PDT)
Received: from localhost ([12.206.222.5])
	by smtp.gmail.com with ESMTPSA id v93sm6522367pjb.6.2019.05.25.18.10.07
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Sat, 25 May 2019 18:10:07 -0700 (PDT)
Date: Sat, 25 May 2019 18:09:25 -0700
Message-Id: <20190526010948.3923-7-palmer@sifive.com>
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
Subject: [Qemu-devel] [PULL 06/29] target/riscv: Merge argument sets for
 insn32 and insn16
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

In some cases this allows us to directly use the insn32
translator function.  In some cases we still need a shim.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 target/riscv/insn16.decode              |  84 ++++++++------
 target/riscv/insn_trans/trans_rvc.inc.c | 144 ++----------------------
 2 files changed, 58 insertions(+), 170 deletions(-)

diff --git a/target/riscv/insn16.decode b/target/riscv/insn16.decode
index 17cc52cf2ac2..d0cc778bc923 100644
--- a/target/riscv/insn16.decode
+++ b/target/riscv/insn16.decode
@@ -40,17 +40,24 @@
 %imm_lui       12:s1 2:5             !function=ex_shift_12
 
 
+# Argument sets imported from insn32.decode:
+&empty                  !extern
+&r         rd rs1 rs2   !extern
+&i         imm rs1 rd   !extern
+&s         imm rs1 rs2  !extern
+&j         imm rd       !extern
+&b         imm rs2 rs1  !extern
+&u         imm rd       !extern
+&shift     shamt rs1 rd !extern
 
 # Argument sets:
 &cl               rs1 rd
 &cl_dw     uimm   rs1 rd
-&ci        imm        rd
 &ciw       nzuimm     rd
 &cs               rs1 rs2
 &cs_dw     uimm   rs1 rs2
 &cb        imm    rs1
 &cr               rd  rs2
-&cj       imm
 &c_shift   shamt      rd
 
 &c_ld      uimm  rd
@@ -61,23 +68,24 @@
 &cfswsp_sdsp    uimm_fswsp uimm_sdsp rs2
 
 # Formats 16:
-@cr        ....  ..... .....  .. &cr                      rs2=%rs2_5  %rd
-@ci        ... . ..... .....  .. &ci     imm=%imm_ci                  %rd
+@cr        ....  ..... .....  .. &r      rs2=%rs2_5       rs1=%rd     %rd
+@ci        ... . ..... .....  .. &i      imm=%imm_ci      rs1=%rd     %rd
 @ciw       ...   ........ ... .. &ciw    nzuimm=%nzuimm_ciw           rd=%rs2_3
-@cl_d      ... ... ... .. ... .. &cl_dw  uimm=%uimm_cl_d  rs1=%rs1_3  rd=%rs2_3
-@cl_w      ... ... ... .. ... .. &cl_dw  uimm=%uimm_cl_w  rs1=%rs1_3  rd=%rs2_3
+@cl_d      ... ... ... .. ... .. &i      imm=%uimm_cl_d   rs1=%rs1_3  rd=%rs2_3
+@cl_w      ... ... ... .. ... .. &i      imm=%uimm_cl_w   rs1=%rs1_3  rd=%rs2_3
 @cl        ... ... ... .. ... .. &cl                      rs1=%rs1_3  rd=%rs2_3
 @cs        ... ... ... .. ... .. &cs                      rs1=%rs1_3  rs2=%rs2_3
-@cs_2      ... ... ... .. ... .. &cr                      rd=%rs1_3   rs2=%rs2_3
-@cs_d      ... ... ... .. ... .. &cs_dw  uimm=%uimm_cl_d  rs1=%rs1_3  rs2=%rs2_3
-@cs_w      ... ... ... .. ... .. &cs_dw  uimm=%uimm_cl_w  rs1=%rs1_3  rs2=%rs2_3
-@cb        ... ... ... .. ... .. &cb     imm=%imm_cb      rs1=%rs1_3
-@cj        ...    ........... .. &cj     imm=%imm_cj
-
-@c_ld      ... . .....  ..... .. &c_ld     uimm=%uimm_6bit_ld  %rd
-@c_lw      ... . .....  ..... .. &c_ld     uimm=%uimm_6bit_lw  %rd
-@c_sd      ... . .....  ..... .. &c_sd     uimm=%uimm_6bit_sd  rs2=%rs2_5
-@c_sw      ... . .....  ..... .. &c_sd     uimm=%uimm_6bit_sw  rs2=%rs2_5
+@cs_2      ... ... ... .. ... .. &r      rs2=%rs2_3       rs1=%rs1_3  rd=%rs1_3
+@cs_d      ... ... ... .. ... .. &s      imm=%uimm_cl_d   rs1=%rs1_3  rs2=%rs2_3
+@cs_w      ... ... ... .. ... .. &s      imm=%uimm_cl_w   rs1=%rs1_3  rs2=%rs2_3
+@cj        ...    ........... .. &j      imm=%imm_cj
+@cb_z      ... ... ... .. ... .. &b      imm=%imm_cb      rs1=%rs1_3  rs2=0
+
+@c_ldsp    ... . .....  ..... .. &i      imm=%uimm_6bit_ld rs1=2 %rd
+@c_lwsp    ... . .....  ..... .. &i      imm=%uimm_6bit_lw rs1=2 %rd
+@c_sdsp    ... . .....  ..... .. &s      imm=%uimm_6bit_sd rs1=2 rs2=%rs2_5
+@c_swsp    ... . .....  ..... .. &s      imm=%uimm_6bit_sw rs1=2 rs2=%rs2_5
+@c_li      ... . .....  ..... .. &i      imm=%imm_ci rs1=0 %rd
 
 @c_addi16sp_lui ... .  ..... ..... .. &caddi16sp_lui %imm_lui %imm_addi16sp %rd
 @c_flwsp_ldsp   ... .  ..... ..... .. &cflwsp_ldsp uimm_flwsp=%uimm_6bit_lw \
@@ -85,45 +93,47 @@
 @c_fswsp_sdsp   ... .  ..... ..... .. &cfswsp_sdsp uimm_fswsp=%uimm_6bit_sw \
     uimm_sdsp=%uimm_6bit_sd rs2=%rs2_5
 
-@c_shift        ... . .. ... ..... .. &c_shift rd=%rs1_3 shamt=%nzuimm_6bit
-@c_shift2       ... . .. ... ..... .. &c_shift rd=%rd    shamt=%nzuimm_6bit
+@c_shift        ... . .. ... ..... .. \
+                &shift rd=%rs1_3 rs1=%rs1_3 shamt=%nzuimm_6bit
+@c_shift2       ... . .. ... ..... .. \
+                &shift rd=%rd rs1=%rd shamt=%nzuimm_6bit
 
-@c_andi         ... . .. ... ..... .. &ci imm=%imm_ci rd=%rs1_3
+@c_andi         ... . .. ... ..... .. &i imm=%imm_ci rs1=%rs1_3 rd=%rs1_3
 
 # *** RV64C Standard Extension (Quadrant 0) ***
 c_addi4spn        000    ........ ... 00 @ciw
-c_fld             001  ... ... .. ... 00 @cl_d
-c_lw              010  ... ... .. ... 00 @cl_w
+fld               001  ... ... .. ... 00 @cl_d
+lw                010  ... ... .. ... 00 @cl_w
 c_flw_ld          011  --- ... -- ... 00 @cl    #Note: Must parse uimm manually
-c_fsd             101  ... ... .. ... 00 @cs_d
-c_sw              110  ... ... .. ... 00 @cs_w
+fsd               101  ... ... .. ... 00 @cs_d
+sw                110  ... ... .. ... 00 @cs_w
 c_fsw_sd          111  --- ... -- ... 00 @cs    #Note: Must parse uimm manually
 
 # *** RV64C Standard Extension (Quadrant 1) ***
-c_addi            000 .  .....  ..... 01 @ci
+addi              000 .  .....  ..... 01 @ci
 c_jal_addiw       001 .  .....  ..... 01 @ci #Note: parse rd and/or imm manually
-c_li              010 .  .....  ..... 01 @ci
+addi              010 .  .....  ..... 01 @c_li
 c_addi16sp_lui    011 .  .....  ..... 01 @c_addi16sp_lui # shares opc with C.LUI
 c_srli            100 . 00 ...  ..... 01 @c_shift
 c_srai            100 . 01 ...  ..... 01 @c_shift
-c_andi            100 . 10 ...  ..... 01 @c_andi
-c_sub             100 0 11 ... 00 ... 01 @cs_2
-c_xor             100 0 11 ... 01 ... 01 @cs_2
-c_or              100 0 11 ... 10 ... 01 @cs_2
-c_and             100 0 11 ... 11 ... 01 @cs_2
+andi              100 . 10 ...  ..... 01 @c_andi
+sub               100 0 11 ... 00 ... 01 @cs_2
+xor               100 0 11 ... 01 ... 01 @cs_2
+or                100 0 11 ... 10 ... 01 @cs_2
+and               100 0 11 ... 11 ... 01 @cs_2
 c_subw            100 1 11 ... 00 ... 01 @cs_2
 c_addw            100 1 11 ... 01 ... 01 @cs_2
-c_j               101     ........... 01 @cj
-c_beqz            110  ... ...  ..... 01 @cb
-c_bnez            111  ... ...  ..... 01 @cb
+jal               101     ........... 01 @cj    rd=0  # C.J
+beq               110  ... ...  ..... 01 @cb_z
+bne               111  ... ...  ..... 01 @cb_z
 
 # *** RV64C Standard Extension (Quadrant 2) ***
 c_slli            000 .  .....  ..... 10 @c_shift2
-c_fldsp           001 .  .....  ..... 10 @c_ld
-c_lwsp            010 .  .....  ..... 10 @c_lw
+fld               001 .  .....  ..... 10 @c_ldsp
+lw                010 .  .....  ..... 10 @c_lwsp
 c_flwsp_ldsp      011 .  .....  ..... 10 @c_flwsp_ldsp #C.LDSP:RV64;C.FLWSP:RV32
 c_jr_mv           100 0  .....  ..... 10 @cr
 c_ebreak_jalr_add 100 1  .....  ..... 10 @cr
-c_fsdsp           101   ......  ..... 10 @c_sd
-c_swsp            110 .  .....  ..... 10 @c_sw
+fsd               101   ......  ..... 10 @c_sdsp
+sw                110 .  .....  ..... 10 @c_swsp
 c_fswsp_sdsp      111 .  .....  ..... 10 @c_fswsp_sdsp #C.SDSP:RV64;C.FSWSP:RV32
diff --git a/target/riscv/insn_trans/trans_rvc.inc.c b/target/riscv/insn_trans/trans_rvc.inc.c
index 3e5d6fd5eaf9..e840ac40dfe2 100644
--- a/target/riscv/insn_trans/trans_rvc.inc.c
+++ b/target/riscv/insn_trans/trans_rvc.inc.c
@@ -28,18 +28,6 @@ static bool trans_c_addi4spn(DisasContext *ctx, arg_c_addi4spn *a)
     return trans_addi(ctx, &arg);
 }
 
-static bool trans_c_fld(DisasContext *ctx, arg_c_fld *a)
-{
-    arg_fld arg = { .rd = a->rd, .rs1 = a->rs1, .imm = a->uimm };
-    return trans_fld(ctx, &arg);
-}
-
-static bool trans_c_lw(DisasContext *ctx, arg_c_lw *a)
-{
-    arg_lw arg = { .rd = a->rd, .rs1 = a->rs1, .imm = a->uimm };
-    return trans_lw(ctx, &arg);
-}
-
 static bool trans_c_flw_ld(DisasContext *ctx, arg_c_flw_ld *a)
 {
 #ifdef TARGET_RISCV32
@@ -47,31 +35,17 @@ static bool trans_c_flw_ld(DisasContext *ctx, arg_c_flw_ld *a)
     REQUIRE_FPU;
     REQUIRE_EXT(ctx, RVF);
 
-    arg_c_lw tmp;
-    decode_insn16_extract_cl_w(ctx, &tmp, ctx->opcode);
-    arg_flw arg = { .rd = tmp.rd, .rs1 = tmp.rs1, .imm = tmp.uimm };
+    arg_i arg;
+    decode_insn16_extract_cl_w(ctx, &arg, ctx->opcode);
     return trans_flw(ctx, &arg);
 #else
     /* C.LD ( RV64C/RV128C-only ) */
-    arg_c_fld tmp;
-    decode_insn16_extract_cl_d(ctx, &tmp, ctx->opcode);
-    arg_ld arg = { .rd = tmp.rd, .rs1 = tmp.rs1, .imm = tmp.uimm };
+    arg_i arg;
+    decode_insn16_extract_cl_d(ctx, &arg, ctx->opcode);
     return trans_ld(ctx, &arg);
 #endif
 }
 
-static bool trans_c_fsd(DisasContext *ctx, arg_c_fsd *a)
-{
-    arg_fsd arg = { .rs1 = a->rs1, .rs2 = a->rs2, .imm = a->uimm };
-    return trans_fsd(ctx, &arg);
-}
-
-static bool trans_c_sw(DisasContext *ctx, arg_c_sw *a)
-{
-    arg_sw arg = { .rs1 = a->rs1, .rs2 = a->rs2, .imm = a->uimm };
-    return trans_sw(ctx, &arg);
-}
-
 static bool trans_c_fsw_sd(DisasContext *ctx, arg_c_fsw_sd *a)
 {
 #ifdef TARGET_RISCV32
@@ -79,34 +53,22 @@ static bool trans_c_fsw_sd(DisasContext *ctx, arg_c_fsw_sd *a)
     REQUIRE_FPU;
     REQUIRE_EXT(ctx, RVF);
 
-    arg_c_sw tmp;
-    decode_insn16_extract_cs_w(ctx, &tmp, ctx->opcode);
-    arg_fsw arg = { .rs1 = tmp.rs1, .rs2 = tmp.rs2, .imm = tmp.uimm };
+    arg_s arg;
+    decode_insn16_extract_cs_w(ctx, &arg, ctx->opcode);
     return trans_fsw(ctx, &arg);
 #else
     /* C.SD ( RV64C/RV128C-only ) */
-    arg_c_fsd tmp;
-    decode_insn16_extract_cs_d(ctx, &tmp, ctx->opcode);
-    arg_sd arg = { .rs1 = tmp.rs1, .rs2 = tmp.rs2, .imm = tmp.uimm };
+    arg_s arg;
+    decode_insn16_extract_cs_d(ctx, &arg, ctx->opcode);
     return trans_sd(ctx, &arg);
 #endif
 }
 
-static bool trans_c_addi(DisasContext *ctx, arg_c_addi *a)
-{
-    if (a->imm == 0) {
-        /* Hint: insn is valid but does not affect state */
-        return true;
-    }
-    arg_addi arg = { .rd = a->rd, .rs1 = a->rd, .imm = a->imm };
-    return trans_addi(ctx, &arg);
-}
-
 static bool trans_c_jal_addiw(DisasContext *ctx, arg_c_jal_addiw *a)
 {
 #ifdef TARGET_RISCV32
     /* C.JAL */
-    arg_c_j tmp;
+    arg_j tmp;
     decode_insn16_extract_cj(ctx, &tmp, ctx->opcode);
     arg_jal arg = { .rd = 1, .imm = tmp.imm };
     return trans_jal(ctx, &arg);
@@ -117,16 +79,6 @@ static bool trans_c_jal_addiw(DisasContext *ctx, arg_c_jal_addiw *a)
 #endif
 }
 
-static bool trans_c_li(DisasContext *ctx, arg_c_li *a)
-{
-    if (a->rd == 0) {
-        /* Hint: insn is valid but does not affect state */
-        return true;
-    }
-    arg_addi arg = { .rd = a->rd, .rs1 = 0, .imm = a->imm };
-    return trans_addi(ctx, &arg);
-}
-
 static bool trans_c_addi16sp_lui(DisasContext *ctx, arg_c_addi16sp_lui *a)
 {
     if (a->rd == 2) {
@@ -177,41 +129,10 @@ static bool trans_c_srai(DisasContext *ctx, arg_c_srai *a)
     return trans_srai(ctx, &arg);
 }
 
-static bool trans_c_andi(DisasContext *ctx, arg_c_andi *a)
-{
-    arg_andi arg = { .rd = a->rd, .rs1 = a->rd, .imm = a->imm };
-    return trans_andi(ctx, &arg);
-}
-
-static bool trans_c_sub(DisasContext *ctx, arg_c_sub *a)
-{
-    arg_sub arg = { .rd = a->rd, .rs1 = a->rd, .rs2 = a->rs2 };
-    return trans_sub(ctx, &arg);
-}
-
-static bool trans_c_xor(DisasContext *ctx, arg_c_xor *a)
-{
-    arg_xor arg = { .rd = a->rd, .rs1 = a->rd, .rs2 = a->rs2 };
-    return trans_xor(ctx, &arg);
-}
-
-static bool trans_c_or(DisasContext *ctx, arg_c_or *a)
-{
-    arg_or arg = { .rd = a->rd, .rs1 = a->rd, .rs2 = a->rs2 };
-    return trans_or(ctx, &arg);
-}
-
-static bool trans_c_and(DisasContext *ctx, arg_c_and *a)
-{
-    arg_and arg = { .rd = a->rd, .rs1 = a->rd, .rs2 = a->rs2 };
-    return trans_and(ctx, &arg);
-}
-
 static bool trans_c_subw(DisasContext *ctx, arg_c_subw *a)
 {
 #ifdef TARGET_RISCV64
-    arg_subw arg = { .rd = a->rd, .rs1 = a->rd, .rs2 = a->rs2 };
-    return trans_subw(ctx, &arg);
+    return trans_subw(ctx, a);
 #else
     return false;
 #endif
@@ -220,31 +141,12 @@ static bool trans_c_subw(DisasContext *ctx, arg_c_subw *a)
 static bool trans_c_addw(DisasContext *ctx, arg_c_addw *a)
 {
 #ifdef TARGET_RISCV64
-    arg_addw arg = { .rd = a->rd, .rs1 = a->rd, .rs2 = a->rs2 };
-    return trans_addw(ctx, &arg);
+    return trans_addw(ctx, a);
 #else
     return false;
 #endif
 }
 
-static bool trans_c_j(DisasContext *ctx, arg_c_j *a)
-{
-    arg_jal arg = { .rd = 0, .imm = a->imm };
-    return trans_jal(ctx, &arg);
-}
-
-static bool trans_c_beqz(DisasContext *ctx, arg_c_beqz *a)
-{
-    arg_beq arg = { .rs1 = a->rs1, .rs2 = 0, .imm = a->imm };
-    return trans_beq(ctx, &arg);
-}
-
-static bool trans_c_bnez(DisasContext *ctx, arg_c_bnez *a)
-{
-    arg_bne arg = { .rs1 = a->rs1, .rs2 = 0, .imm = a->imm };
-    return trans_bne(ctx, &arg);
-}
-
 static bool trans_c_slli(DisasContext *ctx, arg_c_slli *a)
 {
     int shamt = a->shamt;
@@ -261,18 +163,6 @@ static bool trans_c_slli(DisasContext *ctx, arg_c_slli *a)
     return trans_slli(ctx, &arg);
 }
 
-static bool trans_c_fldsp(DisasContext *ctx, arg_c_fldsp *a)
-{
-    arg_fld arg = { .rd = a->rd, .rs1 = 2, .imm = a->uimm };
-    return trans_fld(ctx, &arg);
-}
-
-static bool trans_c_lwsp(DisasContext *ctx, arg_c_lwsp *a)
-{
-    arg_lw arg = { .rd = a->rd, .rs1 = 2, .imm = a->uimm };
-    return trans_lw(ctx, &arg);
-}
-
 static bool trans_c_flwsp_ldsp(DisasContext *ctx, arg_c_flwsp_ldsp *a)
 {
 #ifdef TARGET_RISCV32
@@ -321,18 +211,6 @@ static bool trans_c_ebreak_jalr_add(DisasContext *ctx, arg_c_ebreak_jalr_add *a)
     return false;
 }
 
-static bool trans_c_fsdsp(DisasContext *ctx, arg_c_fsdsp *a)
-{
-    arg_fsd arg = { .rs1 = 2, .rs2 = a->rs2, .imm = a->uimm };
-    return trans_fsd(ctx, &arg);
-}
-
-static bool trans_c_swsp(DisasContext *ctx, arg_c_swsp *a)
-{
-    arg_sw arg = { .rs1 = 2, .rs2 = a->rs2, .imm = a->uimm };
-    return trans_sw(ctx, &arg);
-}
-
 static bool trans_c_fswsp_sdsp(DisasContext *ctx, arg_c_fswsp_sdsp *a)
 {
 #ifdef TARGET_RISCV32
-- 
2.21.0


