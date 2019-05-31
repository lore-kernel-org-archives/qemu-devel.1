Return-Path: <SRS0=hY9S=T7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57BFBC04AB6
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 13:59:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 157B3269F1
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 13:59:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oy8pd4wK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 157B3269F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43994 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWi49-0002cX-8V
	for qemu-devel@archiver.kernel.org; Fri, 31 May 2019 09:59:29 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34614)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hWhoy-0007eg-VW
	for qemu-devel@nongnu.org; Fri, 31 May 2019 09:43:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hWhox-0000cP-CK
	for qemu-devel@nongnu.org; Fri, 31 May 2019 09:43:48 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:35687)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hWhox-0000bl-65
	for qemu-devel@nongnu.org; Fri, 31 May 2019 09:43:47 -0400
Received: by mail-oi1-x241.google.com with SMTP id y6so4117189oix.2
	for <qemu-devel@nongnu.org>; Fri, 31 May 2019 06:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=AkeIjKQ3QX7qSl6BEC0GfsTf3NeYWJRVW4M+I7Ueb/Y=;
	b=oy8pd4wKfo0j30oc0pGP/wPK9hOaoIRmQ70K0fHcmu/GTGImuvqP4+sseZiW15v3Ax
	YmW5HbkWLW0OhDY9ffhsgSKuY1LtTb0BaoLfEnXhJLAMHx6YzfoafMwSO2IPknsyBWWc
	VW0Edzh/OX3ORt1jkO1oSv0j+llJSWnaa2XgtVQfulPuR/Nra2luDF0/eOdIMR6mqqyd
	K4ouXsYHfIHtWDwHq53oZ1mz73Bm9Lt14L5czX3Vvzs5760Y42oNBjM5vJQzijn3ftfO
	x2omtxbiObJlL9IRmdbcygBfGltP0+jwisT51uFFnGapw/1PI528I+7so/VqOD8fL7r9
	bQgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=AkeIjKQ3QX7qSl6BEC0GfsTf3NeYWJRVW4M+I7Ueb/Y=;
	b=JKetJ2c6PaFXHx+81PbSlzPHBdDWs/3RLp6TYaFhX9MWlSl9FGFh6BelTqQZyUj4ai
	q2kppNX6+GeQ3T1ZwblKCAxzPc73+AXcHU8U2yHwhdtWz3D56sVr1HWNTA1VGzKJqDov
	6Xuw1Dn7juN0sd7aJJUTZKIqZWQFSHxXbGz+BS/HARMZG9gK6Bmg9eJ+OTPVS5LJpNIT
	MEm5tb1Qv4GLAMiiocTtZuKvE7br14Y00lz5wHNBqCd5AKluMNKXzpMJWo5x57mkE+7F
	wDxpjOc55dFhl04Oxm3zu6OzS5b+C+vU5MIlUY1gNQOWJYD4qESesEhY5g5gtLfA0eMy
	usFQ==
X-Gm-Message-State: APjAAAWJMvRPHzk0VUCpnBB02EmAqlubtzFDh2fbLcqvK2dTJK5lb1wC
	nhF1eOIpE2MfoIqpV6Duq7i3biHGAGelNw==
X-Google-Smtp-Source: APXvYqx1dIwgMen5SJ/H1+cSHsLczlXZ8pBK8Kcpw/TZvtXGo7+RpSyPMm1zcrmfhmLjaFw5CQkXQw==
X-Received: by 2002:aca:b3d7:: with SMTP id c206mr6378788oif.97.1559310226249; 
	Fri, 31 May 2019 06:43:46 -0700 (PDT)
Received: from localhost.localdomain (168.189-204-159.bestelclientes.com.mx.
	[189.204.159.168]) by smtp.gmail.com with ESMTPSA id
	r23sm2391176otg.49.2019.05.31.06.43.45
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 31 May 2019 06:43:45 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 31 May 2019 08:43:11 -0500
Message-Id: <20190531134315.4109-20-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190531134315.4109-1-richard.henderson@linaro.org>
References: <20190531134315.4109-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::241
Subject: [Qemu-devel] [PATCH v16 19/23] target/rx: Replace operand with
 prt_ldmi in disassembler
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
Cc: philmd@redhat.com, ysato@users.sourceforge.jp
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This has consistency with prt_ri().  It loads all data before
beginning output.  It uses exactly one call to prt() to emit
the full instruction.

Reviewed-by: Yoshinori Sato <ysato@users.sourceforge.jp>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/rx/disas.c | 77 +++++++++++++++++------------------------------
 1 file changed, 27 insertions(+), 50 deletions(-)

diff --git a/target/rx/disas.c b/target/rx/disas.c
index 64342537ee..515b365528 100644
--- a/target/rx/disas.c
+++ b/target/rx/disas.c
@@ -135,18 +135,18 @@ static void rx_index_addr(DisasContext *ctx, char out[8], int ld, int mi)
     sprintf(out, "%u", dsp << (mi < 3 ? mi : 4 - mi));
 }
 
-static void operand(DisasContext *ctx, int ld, int mi, int rs, int rd)
+static void prt_ldmi(DisasContext *ctx, const char *insn,
+                     int ld, int mi, int rs, int rd)
 {
     static const char sizes[][4] = {".b", ".w", ".l", ".uw", ".ub"};
     char dsp[8];
 
     if (ld < 3) {
         rx_index_addr(ctx, dsp, ld, mi);
-        prt("%s[r%d]%s", dsp, rs, sizes[mi]);
+        prt("%s\t%s[r%d]%s, r%d", insn, dsp, rs, sizes[mi], rd);
     } else {
-        prt("r%d", rs);
+        prt("%s\tr%d, r%d", insn, rs, rd);
     }
-    prt(", r%d", rd);
 }
 
 static void prt_ir(DisasContext *ctx, const char *insn, int imm, int rd)
@@ -416,8 +416,7 @@ static bool trans_AND_ir(DisasContext *ctx, arg_AND_ir *a)
 /* and rs,rd */
 static bool trans_AND_mr(DisasContext *ctx, arg_AND_mr *a)
 {
-    prt("and\t");
-    operand(ctx, a->ld, a->mi, a->rs, a->rd);
+    prt_ldmi(ctx, "and", a->ld, a->mi, a->rs, a->rd);
     return true;
 }
 
@@ -440,8 +439,7 @@ static bool trans_OR_ir(DisasContext *ctx, arg_OR_ir *a)
 /* or rs,rd */
 static bool trans_OR_mr(DisasContext *ctx, arg_OR_mr *a)
 {
-    prt("or\t");
-    operand(ctx, a->ld, a->mi, a->rs, a->rd);
+    prt_ldmi(ctx, "or", a->ld, a->mi, a->rs, a->rd);
     return true;
 }
 
@@ -463,8 +461,7 @@ static bool trans_XOR_ir(DisasContext *ctx, arg_XOR_ir *a)
 /* xor rs,rd */
 static bool trans_XOR_mr(DisasContext *ctx, arg_XOR_mr *a)
 {
-    prt("xor\t");
-    operand(ctx, a->ld, a->mi, a->rs, a->rd);
+    prt_ldmi(ctx, "xor", a->ld, a->mi, a->rs, a->rd);
     return true;
 }
 
@@ -479,8 +476,7 @@ static bool trans_TST_ir(DisasContext *ctx, arg_TST_ir *a)
 /* tst rs, rd */
 static bool trans_TST_mr(DisasContext *ctx, arg_TST_mr *a)
 {
-    prt("tst\t");
-    operand(ctx, a->ld, a->mi, a->rs, a->rd);
+    prt_ldmi(ctx, "tst", a->ld, a->mi, a->rs, a->rd);
     return true;
 }
 
@@ -548,8 +544,7 @@ static bool trans_ADD_irr(DisasContext *ctx, arg_ADD_irr *a)
 /* add dsp[rs], rd */
 static bool trans_ADD_mr(DisasContext *ctx, arg_ADD_mr *a)
 {
-    prt("add\t");
-    operand(ctx, a->ld, a->mi, a->rs, a->rd);
+    prt_ldmi(ctx, "add", a->ld, a->mi, a->rs, a->rd);
     return true;
 }
 
@@ -573,8 +568,7 @@ static bool trans_CMP_ir(DisasContext *ctx, arg_CMP_ir *a)
 /* cmp dsp[rs], rs2 */
 static bool trans_CMP_mr(DisasContext *ctx, arg_CMP_mr *a)
 {
-    prt("cmp\t");
-    operand(ctx, a->ld, a->mi, a->rs, a->rd);
+    prt_ldmi(ctx, "cmp", a->ld, a->mi, a->rs, a->rd);
     return true;
 }
 
@@ -589,8 +583,7 @@ static bool trans_SUB_ir(DisasContext *ctx, arg_SUB_ir *a)
 /* sub dsp[rs], rd */
 static bool trans_SUB_mr(DisasContext *ctx, arg_SUB_mr *a)
 {
-    prt("sub\t");
-    operand(ctx, a->ld, a->mi, a->rs, a->rd);
+    prt_ldmi(ctx, "sub", a->ld, a->mi, a->rs, a->rd);
     return true;
 }
 
@@ -611,8 +604,7 @@ static bool trans_SBB_rr(DisasContext *ctx, arg_SBB_rr *a)
 /* sbb dsp[rs], rd */
 static bool trans_SBB_mr(DisasContext *ctx, arg_SBB_mr *a)
 {
-    prt("sbb\t");
-    operand(ctx, a->ld, RX_IM_LONG, a->rs, a->rd);
+    prt_ldmi(ctx, "sbb", a->ld, RX_IM_LONG, a->rs, a->rd);
     return true;
 }
 
@@ -640,8 +632,7 @@ static bool trans_MAX_ir(DisasContext *ctx, arg_MAX_ir *a)
 /* max dsp[rs], rd */
 static bool trans_MAX_mr(DisasContext *ctx, arg_MAX_mr *a)
 {
-    prt("max\t");
-    operand(ctx, a->ld, a->mi, a->rs, a->rd);
+    prt_ldmi(ctx, "max", a->ld, a->mi, a->rs, a->rd);
     return true;
 }
 
@@ -656,8 +647,7 @@ static bool trans_MIN_ir(DisasContext *ctx, arg_MIN_ir *a)
 /* min dsp[rs], rd */
 static bool trans_MIN_mr(DisasContext *ctx, arg_MIN_mr *a)
 {
-    prt("max\t");
-    operand(ctx, a->ld, a->mi, a->rs, a->rd);
+    prt_ldmi(ctx, "min", a->ld, a->mi, a->rs, a->rd);
     return true;
 }
 
@@ -673,8 +663,7 @@ static bool trans_MUL_ir(DisasContext *ctx, arg_MUL_ir *a)
 /* mul dsp[rs], rd */
 static bool trans_MUL_mr(DisasContext *ctx, arg_MUL_mr *a)
 {
-    prt("mul\t");
-    operand(ctx, a->ld, a->mi, a->rs, a->rd);
+    prt_ldmi(ctx, "mul", a->ld, a->mi, a->rs, a->rd);
     return true;
 }
 
@@ -696,8 +685,7 @@ static bool trans_EMUL_ir(DisasContext *ctx, arg_EMUL_ir *a)
 /* emul dsp[rs], rd */
 static bool trans_EMUL_mr(DisasContext *ctx, arg_EMUL_mr *a)
 {
-    prt("emul\t");
-    operand(ctx, a->ld, a->mi, a->rs, a->rd);
+    prt_ldmi(ctx, "emul", a->ld, a->mi, a->rs, a->rd);
     return true;
 }
 
@@ -712,8 +700,7 @@ static bool trans_EMULU_ir(DisasContext *ctx, arg_EMULU_ir *a)
 /* emulu dsp[rs], rd */
 static bool trans_EMULU_mr(DisasContext *ctx, arg_EMULU_mr *a)
 {
-    prt("emulu\t");
-    operand(ctx, a->ld, a->mi, a->rs, a->rd);
+    prt_ldmi(ctx, "emulu", a->ld, a->mi, a->rs, a->rd);
     return true;
 }
 
@@ -728,8 +715,7 @@ static bool trans_DIV_ir(DisasContext *ctx, arg_DIV_ir *a)
 /* div dsp[rs], rd */
 static bool trans_DIV_mr(DisasContext *ctx, arg_DIV_mr *a)
 {
-    prt("div\t");
-    operand(ctx, a->ld, a->mi, a->rs, a->rd);
+    prt_ldmi(ctx, "div", a->ld, a->mi, a->rs, a->rd);
     return true;
 }
 
@@ -744,8 +730,7 @@ static bool trans_DIVU_ir(DisasContext *ctx, arg_DIVU_ir *a)
 /* divu dsp[rs], rd */
 static bool trans_DIVU_mr(DisasContext *ctx, arg_DIVU_mr *a)
 {
-    prt("divu\t");
-    operand(ctx, a->ld, a->mi, a->rs, a->rd);
+    prt_ldmi(ctx, "divu", a->ld, a->mi, a->rs, a->rd);
     return true;
 }
 
@@ -1089,8 +1074,7 @@ static bool trans_FADD_ir(DisasContext *ctx, arg_FADD_ir *a)
 /* fadd rs, rd */
 static bool trans_FADD_mr(DisasContext *ctx, arg_FADD_mr *a)
 {
-    prt("fadd\t");
-    operand(ctx, a->ld, RX_IM_LONG, a->rs, a->rd);
+    prt_ldmi(ctx, "fadd", a->ld, RX_IM_LONG, a->rs, a->rd);
     return true;
 }
 
@@ -1105,8 +1089,7 @@ static bool trans_FCMP_ir(DisasContext *ctx, arg_FCMP_ir *a)
 /* fcmp rs, rd */
 static bool trans_FCMP_mr(DisasContext *ctx, arg_FCMP_mr *a)
 {
-    prt("fcmp\t");
-    operand(ctx, a->ld, RX_IM_LONG, a->rs, a->rd);
+    prt_ldmi(ctx, "fcmp", a->ld, RX_IM_LONG, a->rs, a->rd);
     return true;
 }
 
@@ -1121,8 +1104,7 @@ static bool trans_FSUB_ir(DisasContext *ctx, arg_FSUB_ir *a)
 /* fsub rs, rd */
 static bool trans_FSUB_mr(DisasContext *ctx, arg_FSUB_mr *a)
 {
-    prt("fsub\t");
-    operand(ctx, a->ld, RX_IM_LONG, a->rs, a->rd);
+    prt_ldmi(ctx, "fsub", a->ld, RX_IM_LONG, a->rs, a->rd);
     return true;
 }
 
@@ -1130,8 +1112,7 @@ static bool trans_FSUB_mr(DisasContext *ctx, arg_FSUB_mr *a)
 /* ftoi rs, rd */
 static bool trans_FTOI(DisasContext *ctx, arg_FTOI *a)
 {
-    prt("ftoi\t");
-    operand(ctx, a->ld, RX_IM_LONG, a->rs, a->rd);
+    prt_ldmi(ctx, "ftoi", a->ld, RX_IM_LONG, a->rs, a->rd);
     return true;
 }
 
@@ -1146,8 +1127,7 @@ static bool trans_FMUL_ir(DisasContext *ctx, arg_FMUL_ir *a)
 /* fmul rs, rd */
 static bool trans_FMUL_mr(DisasContext *ctx, arg_FMUL_mr *a)
 {
-    prt("fmul\t");
-    operand(ctx, a->ld, RX_IM_LONG, a->rs, a->rd);
+    prt_ldmi(ctx, "fmul", a->ld, RX_IM_LONG, a->rs, a->rd);
     return true;
 }
 
@@ -1162,8 +1142,7 @@ static bool trans_FDIV_ir(DisasContext *ctx, arg_FDIV_ir *a)
 /* fdiv rs, rd */
 static bool trans_FDIV_mr(DisasContext *ctx, arg_FDIV_mr *a)
 {
-    prt("fdiv\t");
-    operand(ctx, a->ld, RX_IM_LONG, a->rs, a->rd);
+    prt_ldmi(ctx, "fdiv", a->ld, RX_IM_LONG, a->rs, a->rd);
     return true;
 }
 
@@ -1171,8 +1150,7 @@ static bool trans_FDIV_mr(DisasContext *ctx, arg_FDIV_mr *a)
 /* round rs, rd */
 static bool trans_ROUND(DisasContext *ctx, arg_ROUND *a)
 {
-    prt("round\t");
-    operand(ctx, a->ld, RX_IM_LONG, a->rs, a->rd);
+    prt_ldmi(ctx, "round", a->ld, RX_IM_LONG, a->rs, a->rd);
     return true;
 }
 
@@ -1180,8 +1158,7 @@ static bool trans_ROUND(DisasContext *ctx, arg_ROUND *a)
 /* itof dsp[rs], rd */
 static bool trans_ITOF(DisasContext *ctx, arg_ITOF *a)
 {
-    prt("itof\t");
-    operand(ctx, a->ld, RX_IM_LONG, a->rs, a->rd);
+    prt_ldmi(ctx, "itof", a->ld, RX_IM_LONG, a->rs, a->rd);
     return true;
 }
 
-- 
2.17.1


