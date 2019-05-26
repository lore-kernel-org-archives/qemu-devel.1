Return-Path: <SRS0=5YAC=T2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADCD2C07542
	for <qemu-devel@archiver.kernel.org>; Sun, 26 May 2019 01:49:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34AB320815
	for <qemu-devel@archiver.kernel.org>; Sun, 26 May 2019 01:49:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34AB320815
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49431 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hUiHd-0004dn-99
	for qemu-devel@archiver.kernel.org; Sat, 25 May 2019 21:49:09 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53756)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@dabbelt.com>) id 1hUhxP-0003GC-I3
	for qemu-devel@nongnu.org; Sat, 25 May 2019 21:28:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@dabbelt.com>) id 1hUhfy-0005qJ-AN
	for qemu-devel@nongnu.org; Sat, 25 May 2019 21:10:16 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40136)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1hUhfw-0005p1-EY
	for qemu-devel@nongnu.org; Sat, 25 May 2019 21:10:13 -0400
Received: by mail-pg1-f193.google.com with SMTP id d30so7080817pgm.7
	for <qemu-devel@nongnu.org>; Sat, 25 May 2019 18:10:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:cc:from:to;
	bh=ytTW1+TTg5W28dEVYeOyH5hBZS9j7YYQ7XabUrTBVLA=;
	b=qEgfadZW6IfMployi46wC92Q+b60eujNL2VHnPYKiZ0qQ/LSMszUBHvGNwUplzvK3F
	scyLgHRfef/5HS2jFa56L9k7CYeDdQih1h0uFPxhc5xfhPBx2gc9ijzzS5BSMtG7shqk
	cXyL71p2drU3zc3pPiSXa1l/P5d1r/P+jTjkbjgHFTmvwCAwIe0LfkS6BH/lVkd9RbtT
	M9nTf8iz8K0WV4k0maRXQOhqq4DTrm2fc3Bv9tYiOm60eEMtzSDmbuirQEyO+O8/V2Y2
	h/7Qp2AkUTFlDD7QrsQ8w6IL0Cg+ZvVol3JyAsoXAM+5tT8+4udLfD/TdZue8L0bcBKi
	IlIg==
X-Gm-Message-State: APjAAAVQfWsAswTvWk9CDAsZzywfFP5jYYYHkH2mE8PvD1EvVu90VTDp
	gV+REk1n7BpwUIKLN5Rk9109Dw==
X-Google-Smtp-Source: APXvYqy8DEKDU0BtKx5q5MumMpyWdTrljBgSvAj/HUyYu3P6XbP9iu6rVMMFuxUFM0EmrdOKZ2kGvw==
X-Received: by 2002:a63:a449:: with SMTP id c9mr27145842pgp.149.1558833010301; 
	Sat, 25 May 2019 18:10:10 -0700 (PDT)
Received: from localhost ([12.206.222.5]) by smtp.gmail.com with ESMTPSA id
	f38sm5276375pgm.85.2019.05.25.18.10.08
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Sat, 25 May 2019 18:10:09 -0700 (PDT)
Date: Sat, 25 May 2019 18:09:26 -0700
Message-Id: <20190526010948.3923-8-palmer@sifive.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190526010948.3923-1-palmer@sifive.com>
References: <20190526010948.3923-1-palmer@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Palmer Dabbelt <palmer@sifive.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.215.193
Subject: [Qemu-devel] [PULL 07/29] target/riscv: Merge argument decode for
 RVC shifti
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

Special handling for IMM==0 is the only difference between
RVC shifti and RVI shifti.  This can be handled with !function.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 target/riscv/insn16.decode              | 12 +++----
 target/riscv/insn_trans/trans_rvc.inc.c | 47 -------------------------
 target/riscv/translate.c                |  6 ++++
 3 files changed, 12 insertions(+), 53 deletions(-)

diff --git a/target/riscv/insn16.decode b/target/riscv/insn16.decode
index d0cc778bc923..add9cf3923a1 100644
--- a/target/riscv/insn16.decode
+++ b/target/riscv/insn16.decode
@@ -30,7 +30,7 @@
 %imm_cb        12:s1 5:2 2:1 10:2 3:2 !function=ex_shift_1
 %imm_cj        12:s1 8:1 9:2 6:1 7:1 2:1 11:1 3:3 !function=ex_shift_1
 
-%nzuimm_6bit   12:1 2:5
+%shimm_6bit   12:1 2:5               !function=ex_rvc_shifti
 %uimm_6bit_ld 2:3 12:1 5:2           !function=ex_shift_3
 %uimm_6bit_lw 2:2 12:1 4:3           !function=ex_shift_2
 %uimm_6bit_sd 7:3 10:3               !function=ex_shift_3
@@ -94,9 +94,9 @@
     uimm_sdsp=%uimm_6bit_sd rs2=%rs2_5
 
 @c_shift        ... . .. ... ..... .. \
-                &shift rd=%rs1_3 rs1=%rs1_3 shamt=%nzuimm_6bit
+                &shift rd=%rs1_3 rs1=%rs1_3 shamt=%shimm_6bit
 @c_shift2       ... . .. ... ..... .. \
-                &shift rd=%rd rs1=%rd shamt=%nzuimm_6bit
+                &shift rd=%rd rs1=%rd shamt=%shimm_6bit
 
 @c_andi         ... . .. ... ..... .. &i imm=%imm_ci rs1=%rs1_3 rd=%rs1_3
 
@@ -114,8 +114,8 @@ addi              000 .  .....  ..... 01 @ci
 c_jal_addiw       001 .  .....  ..... 01 @ci #Note: parse rd and/or imm manually
 addi              010 .  .....  ..... 01 @c_li
 c_addi16sp_lui    011 .  .....  ..... 01 @c_addi16sp_lui # shares opc with C.LUI
-c_srli            100 . 00 ...  ..... 01 @c_shift
-c_srai            100 . 01 ...  ..... 01 @c_shift
+srli              100 . 00 ...  ..... 01 @c_shift
+srai              100 . 01 ...  ..... 01 @c_shift
 andi              100 . 10 ...  ..... 01 @c_andi
 sub               100 0 11 ... 00 ... 01 @cs_2
 xor               100 0 11 ... 01 ... 01 @cs_2
@@ -128,7 +128,7 @@ beq               110  ... ...  ..... 01 @cb_z
 bne               111  ... ...  ..... 01 @cb_z
 
 # *** RV64C Standard Extension (Quadrant 2) ***
-c_slli            000 .  .....  ..... 10 @c_shift2
+slli              000 .  .....  ..... 10 @c_shift2
 fld               001 .  .....  ..... 10 @c_ldsp
 lw                010 .  .....  ..... 10 @c_lwsp
 c_flwsp_ldsp      011 .  .....  ..... 10 @c_flwsp_ldsp #C.LDSP:RV64;C.FLWSP:RV32
diff --git a/target/riscv/insn_trans/trans_rvc.inc.c b/target/riscv/insn_trans/trans_rvc.inc.c
index e840ac40dfe2..dbe9624e324b 100644
--- a/target/riscv/insn_trans/trans_rvc.inc.c
+++ b/target/riscv/insn_trans/trans_rvc.inc.c
@@ -97,37 +97,6 @@ static bool trans_c_addi16sp_lui(DisasContext *ctx, arg_c_addi16sp_lui *a)
     return false;
 }
 
-static bool trans_c_srli(DisasContext *ctx, arg_c_srli *a)
-{
-    int shamt = a->shamt;
-    if (shamt == 0) {
-        /* For RV128 a shamt of 0 means a shift by 64 */
-        shamt = 64;
-    }
-    /* Ensure, that shamt[5] is zero for RV32 */
-    if (shamt >= TARGET_LONG_BITS) {
-        return false;
-    }
-
-    arg_srli arg = { .rd = a->rd, .rs1 = a->rd, .shamt = a->shamt };
-    return trans_srli(ctx, &arg);
-}
-
-static bool trans_c_srai(DisasContext *ctx, arg_c_srai *a)
-{
-    int shamt = a->shamt;
-    if (shamt == 0) {
-        /* For RV128 a shamt of 0 means a shift by 64 */
-        shamt = 64;
-    }
-    /* Ensure, that shamt[5] is zero for RV32 */
-    if (shamt >= TARGET_LONG_BITS) {
-        return false;
-    }
-
-    arg_srai arg = { .rd = a->rd, .rs1 = a->rd, .shamt = a->shamt };
-    return trans_srai(ctx, &arg);
-}
 
 static bool trans_c_subw(DisasContext *ctx, arg_c_subw *a)
 {
@@ -147,22 +116,6 @@ static bool trans_c_addw(DisasContext *ctx, arg_c_addw *a)
 #endif
 }
 
-static bool trans_c_slli(DisasContext *ctx, arg_c_slli *a)
-{
-    int shamt = a->shamt;
-    if (shamt == 0) {
-        /* For RV128 a shamt of 0 means a shift by 64 */
-        shamt = 64;
-    }
-    /* Ensure, that shamt[5] is zero for RV32 */
-    if (shamt >= TARGET_LONG_BITS) {
-        return false;
-    }
-
-    arg_slli arg = { .rd = a->rd, .rs1 = a->rd, .shamt = a->shamt };
-    return trans_slli(ctx, &arg);
-}
-
 static bool trans_c_flwsp_ldsp(DisasContext *ctx, arg_c_flwsp_ldsp *a)
 {
 #ifdef TARGET_RISCV32
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index b09158117f32..4cdffb23a475 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -558,6 +558,12 @@ static int ex_rvc_register(DisasContext *ctx, int reg)
     return 8 + reg;
 }
 
+static int ex_rvc_shifti(DisasContext *ctx, int imm)
+{
+    /* For RV128 a shamt of 0 means a shift by 64. */
+    return imm ? imm : 64;
+}
+
 /* Include the auto-generated decoder for 32 bit insn */
 #include "decode_insn32.inc.c"
 
-- 
2.21.0


