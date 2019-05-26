Return-Path: <SRS0=5YAC=T2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A801EC07542
	for <qemu-devel@archiver.kernel.org>; Sun, 26 May 2019 01:33:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F9A420644
	for <qemu-devel@archiver.kernel.org>; Sun, 26 May 2019 01:33:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F9A420644
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49167 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hUi2s-0008C6-Kj
	for qemu-devel@archiver.kernel.org; Sat, 25 May 2019 21:33:54 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53756)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@dabbelt.com>) id 1hUhxN-0003GC-S2
	for qemu-devel@nongnu.org; Sat, 25 May 2019 21:28:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@dabbelt.com>) id 1hUhg2-0005sH-4i
	for qemu-devel@nongnu.org; Sat, 25 May 2019 21:10:20 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38104)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1hUhfy-0005pW-Bm
	for qemu-devel@nongnu.org; Sat, 25 May 2019 21:10:16 -0400
Received: by mail-pg1-f195.google.com with SMTP id v11so7092029pgl.5
	for <qemu-devel@nongnu.org>; Sat, 25 May 2019 18:10:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:cc:from:to;
	bh=eOXAXFFSJfATTExwJ4CqguE04SpAoRo5k7qmw0rhDJQ=;
	b=DKkVtZoBd+afWyilmZbJHHXfna/c5Nhd9u4veLfWqyEKMQq/3iGPJuYFYx2Q7cuHgS
	InMXOTBzua4+uPIV1OomIubqs5vzjsN0zj+kwsSr6W4Be6xTZsFg2oQDgSv6qBC2uPft
	ll+DmMfALDa8Bm9ARJKHnM7AdJnb51qyOuxQN3xQ0NOOpDiPfXei/XfyvA9bqr00qNQu
	DnP94c4gsNHrLSUcTrkj58Ag3lwqBnrMmgiHsIqE96u1hPq33m/2liUiqX/oMeKSp5eU
	MjH/lW5yK/deqV3DgMtq5RNwro1tmhItpD0LrqX4w/kzzNcbSiMHduhPTA7iOM/VtJmR
	tNrw==
X-Gm-Message-State: APjAAAUgVrcJkUT1Qhq5GipGBH+0fRdSe9+FM4Fz/ry+n5BTu6M/StyT
	0hXkHHc+DGCB2xSFyk05ILrDtg==
X-Google-Smtp-Source: APXvYqw94B84craz3Awrnoe6OMIkxgh5TJZYTqSwbSG1G8+L6sYNVwXagFdMi9tWwdM4CwoT8Sx+eA==
X-Received: by 2002:a62:1990:: with SMTP id 138mr26327169pfz.133.1558833011593;
	Sat, 25 May 2019 18:10:11 -0700 (PDT)
Received: from localhost ([12.206.222.5]) by smtp.gmail.com with ESMTPSA id
	206sm5605493pfy.90.2019.05.25.18.10.10
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Sat, 25 May 2019 18:10:10 -0700 (PDT)
Date: Sat, 25 May 2019 18:09:27 -0700
Message-Id: <20190526010948.3923-9-palmer@sifive.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190526010948.3923-1-palmer@sifive.com>
References: <20190526010948.3923-1-palmer@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Palmer Dabbelt <palmer@sifive.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.215.195
Subject: [Qemu-devel] [PULL 08/29] target/riscv: Use pattern groups in
 insn16.decode
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

This eliminates about half of the complicated decode
bits within insn_trans/trans_rvc.inc.c.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 target/riscv/insn16.decode              | 29 +++++++++---
 target/riscv/insn_trans/trans_rvc.inc.c | 63 -------------------------
 target/riscv/insn_trans/trans_rvi.inc.c |  6 +++
 3 files changed, 29 insertions(+), 69 deletions(-)

diff --git a/target/riscv/insn16.decode b/target/riscv/insn16.decode
index add9cf3923a1..3c79edf1c996 100644
--- a/target/riscv/insn16.decode
+++ b/target/riscv/insn16.decode
@@ -70,7 +70,6 @@
 # Formats 16:
 @cr        ....  ..... .....  .. &r      rs2=%rs2_5       rs1=%rd     %rd
 @ci        ... . ..... .....  .. &i      imm=%imm_ci      rs1=%rd     %rd
-@ciw       ...   ........ ... .. &ciw    nzuimm=%nzuimm_ciw           rd=%rs2_3
 @cl_d      ... ... ... .. ... .. &i      imm=%uimm_cl_d   rs1=%rs1_3  rd=%rs2_3
 @cl_w      ... ... ... .. ... .. &i      imm=%uimm_cl_w   rs1=%rs1_3  rd=%rs2_3
 @cl        ... ... ... .. ... .. &cl                      rs1=%rs1_3  rd=%rs2_3
@@ -86,8 +85,12 @@
 @c_sdsp    ... . .....  ..... .. &s      imm=%uimm_6bit_sd rs1=2 rs2=%rs2_5
 @c_swsp    ... . .....  ..... .. &s      imm=%uimm_6bit_sw rs1=2 rs2=%rs2_5
 @c_li      ... . .....  ..... .. &i      imm=%imm_ci rs1=0 %rd
+@c_lui     ... . .....  ..... .. &u      imm=%imm_lui %rd
+@c_jalr    ... . .....  ..... .. &i      imm=0 rs1=%rd
+@c_mv      ... . ..... .....  .. &i      imm=0 rs1=%rs2_5 %rd
 
-@c_addi16sp_lui ... .  ..... ..... .. &caddi16sp_lui %imm_lui %imm_addi16sp %rd
+@c_addi4spn     ... .  ..... ..... .. &i imm=%nzuimm_ciw rs1=2 rd=%rs2_3
+@c_addi16sp     ... .  ..... ..... .. &i imm=%imm_addi16sp rs1=2 rd=2
 @c_flwsp_ldsp   ... .  ..... ..... .. &cflwsp_ldsp uimm_flwsp=%uimm_6bit_lw \
     uimm_ldsp=%uimm_6bit_ld %rd
 @c_fswsp_sdsp   ... .  ..... ..... .. &cfswsp_sdsp uimm_fswsp=%uimm_6bit_sw \
@@ -101,7 +104,11 @@
 @c_andi         ... . .. ... ..... .. &i imm=%imm_ci rs1=%rs1_3 rd=%rs1_3
 
 # *** RV64C Standard Extension (Quadrant 0) ***
-c_addi4spn        000    ........ ... 00 @ciw
+{
+  # Opcode of all zeros is illegal; rd != 0, nzuimm == 0 is reserved.
+  illegal         000  000 000 00 --- 00
+  addi            000  ... ... .. ... 00 @c_addi4spn
+}
 fld               001  ... ... .. ... 00 @cl_d
 lw                010  ... ... .. ... 00 @cl_w
 c_flw_ld          011  --- ... -- ... 00 @cl    #Note: Must parse uimm manually
@@ -113,7 +120,10 @@ c_fsw_sd          111  --- ... -- ... 00 @cs    #Note: Must parse uimm manually
 addi              000 .  .....  ..... 01 @ci
 c_jal_addiw       001 .  .....  ..... 01 @ci #Note: parse rd and/or imm manually
 addi              010 .  .....  ..... 01 @c_li
-c_addi16sp_lui    011 .  .....  ..... 01 @c_addi16sp_lui # shares opc with C.LUI
+{
+  addi            011 .  00010  ..... 01 @c_addi16sp
+  lui             011 .  .....  ..... 01 @c_lui
+}
 srli              100 . 00 ...  ..... 01 @c_shift
 srai              100 . 01 ...  ..... 01 @c_shift
 andi              100 . 10 ...  ..... 01 @c_andi
@@ -132,8 +142,15 @@ slli              000 .  .....  ..... 10 @c_shift2
 fld               001 .  .....  ..... 10 @c_ldsp
 lw                010 .  .....  ..... 10 @c_lwsp
 c_flwsp_ldsp      011 .  .....  ..... 10 @c_flwsp_ldsp #C.LDSP:RV64;C.FLWSP:RV32
-c_jr_mv           100 0  .....  ..... 10 @cr
-c_ebreak_jalr_add 100 1  .....  ..... 10 @cr
+{
+  jalr            100 0  .....  00000 10 @c_jalr rd=0  # C.JR
+  addi            100 0  .....  ..... 10 @c_mv
+}
+{
+  ebreak          100 1  00000  00000 10
+  jalr            100 1  .....  00000 10 @c_jalr rd=1  # C.JALR
+  add             100 1  .....  ..... 10 @cr
+}
 fsd               101   ......  ..... 10 @c_sdsp
 sw                110 .  .....  ..... 10 @c_swsp
 c_fswsp_sdsp      111 .  .....  ..... 10 @c_fswsp_sdsp #C.SDSP:RV64;C.FSWSP:RV32
diff --git a/target/riscv/insn_trans/trans_rvc.inc.c b/target/riscv/insn_trans/trans_rvc.inc.c
index dbe9624e324b..3fe6ad9d4592 100644
--- a/target/riscv/insn_trans/trans_rvc.inc.c
+++ b/target/riscv/insn_trans/trans_rvc.inc.c
@@ -18,16 +18,6 @@
  * this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
-static bool trans_c_addi4spn(DisasContext *ctx, arg_c_addi4spn *a)
-{
-    if (a->nzuimm == 0) {
-        /* Reserved in ISA */
-        return false;
-    }
-    arg_addi arg = { .rd = a->rd, .rs1 = 2, .imm = a->nzuimm };
-    return trans_addi(ctx, &arg);
-}
-
 static bool trans_c_flw_ld(DisasContext *ctx, arg_c_flw_ld *a)
 {
 #ifdef TARGET_RISCV32
@@ -79,25 +69,6 @@ static bool trans_c_jal_addiw(DisasContext *ctx, arg_c_jal_addiw *a)
 #endif
 }
 
-static bool trans_c_addi16sp_lui(DisasContext *ctx, arg_c_addi16sp_lui *a)
-{
-    if (a->rd == 2) {
-        /* C.ADDI16SP */
-        arg_addi arg = { .rd = 2, .rs1 = 2, .imm = a->imm_addi16sp };
-        return trans_addi(ctx, &arg);
-    } else if (a->imm_lui != 0) {
-        /* C.LUI */
-        if (a->rd == 0) {
-            /* Hint: insn is valid but does not affect state */
-            return true;
-        }
-        arg_lui arg = { .rd = a->rd, .imm = a->imm_lui };
-        return trans_lui(ctx, &arg);
-    }
-    return false;
-}
-
-
 static bool trans_c_subw(DisasContext *ctx, arg_c_subw *a)
 {
 #ifdef TARGET_RISCV64
@@ -130,40 +101,6 @@ static bool trans_c_flwsp_ldsp(DisasContext *ctx, arg_c_flwsp_ldsp *a)
     return false;
 }
 
-static bool trans_c_jr_mv(DisasContext *ctx, arg_c_jr_mv *a)
-{
-    if (a->rd != 0 && a->rs2 == 0) {
-        /* C.JR */
-        arg_jalr arg = { .rd = 0, .rs1 = a->rd, .imm = 0 };
-        return trans_jalr(ctx, &arg);
-    } else if (a->rd != 0 && a->rs2 != 0) {
-        /* C.MV */
-        arg_add arg = { .rd = a->rd, .rs1 = 0, .rs2 = a->rs2 };
-        return trans_add(ctx, &arg);
-    }
-    return false;
-}
-
-static bool trans_c_ebreak_jalr_add(DisasContext *ctx, arg_c_ebreak_jalr_add *a)
-{
-    if (a->rd == 0 && a->rs2 == 0) {
-        /* C.EBREAK */
-        arg_ebreak arg = { };
-        return trans_ebreak(ctx, &arg);
-    } else if (a->rd != 0) {
-        if (a->rs2 == 0) {
-            /* C.JALR */
-            arg_jalr arg = { .rd = 1, .rs1 = a->rd, .imm = 0 };
-            return trans_jalr(ctx, &arg);
-        } else {
-            /* C.ADD */
-            arg_add arg = { .rd = a->rd, .rs1 = a->rd, .rs2 = a->rs2 };
-            return trans_add(ctx, &arg);
-        }
-    }
-    return false;
-}
-
 static bool trans_c_fswsp_sdsp(DisasContext *ctx, arg_c_fswsp_sdsp *a)
 {
 #ifdef TARGET_RISCV32
diff --git a/target/riscv/insn_trans/trans_rvi.inc.c b/target/riscv/insn_trans/trans_rvi.inc.c
index 37b0b9dd198e..b5a5b4a199f8 100644
--- a/target/riscv/insn_trans/trans_rvi.inc.c
+++ b/target/riscv/insn_trans/trans_rvi.inc.c
@@ -18,6 +18,12 @@
  * this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
+static bool trans_illegal(DisasContext *ctx, arg_empty *a)
+{
+    gen_exception_illegal(ctx);
+    return true;
+}
+
 static bool trans_lui(DisasContext *ctx, arg_lui *a)
 {
     if (a->rd != 0) {
-- 
2.21.0


