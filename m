Return-Path: <SRS0=5YAC=T2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DE71C07542
	for <qemu-devel@archiver.kernel.org>; Sun, 26 May 2019 01:48:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7425A20815
	for <qemu-devel@archiver.kernel.org>; Sun, 26 May 2019 01:48:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7425A20815
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49421 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hUiGY-0003tM-Nw
	for qemu-devel@archiver.kernel.org; Sat, 25 May 2019 21:48:02 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53756)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@dabbelt.com>) id 1hUhxM-0003GC-Jx
	for qemu-devel@nongnu.org; Sat, 25 May 2019 21:28:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@dabbelt.com>) id 1hUhg6-0005zu-1w
	for qemu-devel@nongnu.org; Sat, 25 May 2019 21:10:23 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36186)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1hUhg5-0005qv-A3
	for qemu-devel@nongnu.org; Sat, 25 May 2019 21:10:21 -0400
Received: by mail-pg1-f193.google.com with SMTP id a3so7092626pgb.3
	for <qemu-devel@nongnu.org>; Sat, 25 May 2019 18:10:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:cc:from:to;
	bh=OmSQFZO3wBvDnHuwPuCqP/gKDSGfC6OxGSJhMV+r43c=;
	b=oVU2f3jQ9M6Oo24orfHDo3nkp/qL2Bp2YAAyYXMLEO1GMKrFgY7qmI6D/8EFhCc+QO
	V8LUOGwEpgNrohcKWx0+SMVmh4PT8NP3/ceCw+OuLpa8/XhmNULqBVznulThRtVdQljx
	RK9g2jZS0XWiNxLSYVofyJcCG0nwuTzEZ4ik6Mq09vpFSAmNiIIPJHNbA1S2GCTS77PM
	K6jlLMZPxdhMgtmoVOZuWcI7gOUsOrq49dP6Ovz/DNsFGB6ntHGwmrqIVtlSeQvu6Z2O
	z/KT4kirMBi6/x1GhQOgUrONZEn361Hef8zhc8w2bMqg+j2snnTXFDzvhZxr8j6vjA9b
	AmBg==
X-Gm-Message-State: APjAAAUjN7LABPrKpIcpIT2M0yA3uQs2R0EdxN8fxJVDQ7EFk2oJXMqu
	pMf+IADKCeZxU2WzsoBa2c07yg==
X-Google-Smtp-Source: APXvYqytK9uAGScqQUE6ES9n4V1QrfbnNuis1mjqLofTtpq+oLyK34ZrHClntDgomJectNXSRDE9TQ==
X-Received: by 2002:aa7:9a99:: with SMTP id w25mr31312977pfi.249.1558833015176;
	Sat, 25 May 2019 18:10:15 -0700 (PDT)
Received: from localhost ([12.206.222.5]) by smtp.gmail.com with ESMTPSA id
	p90sm17592187pfa.18.2019.05.25.18.10.13
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Sat, 25 May 2019 18:10:14 -0700 (PDT)
Date: Sat, 25 May 2019 18:09:29 -0700
Message-Id: <20190526010948.3923-11-palmer@sifive.com>
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
Subject: [Qemu-devel] [PULL 10/29] target/riscv: Split gen_arith_imm into
 functional and temp
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

The tcg_gen_fooi_tl functions have some immediate constant
folding built in, which match up with some of the riscv asm
builtin macros, like mv and not.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 target/riscv/insn_trans/trans_rvi.inc.c | 14 +++++++-------
 target/riscv/translate.c                | 19 +++++++++++++++++--
 2 files changed, 24 insertions(+), 9 deletions(-)

diff --git a/target/riscv/insn_trans/trans_rvi.inc.c b/target/riscv/insn_trans/trans_rvi.inc.c
index b5a5b4a199f8..6cda078ed6ba 100644
--- a/target/riscv/insn_trans/trans_rvi.inc.c
+++ b/target/riscv/insn_trans/trans_rvi.inc.c
@@ -223,7 +223,7 @@ static bool trans_sd(DisasContext *ctx, arg_sd *a)
 
 static bool trans_addi(DisasContext *ctx, arg_addi *a)
 {
-    return gen_arith_imm(ctx, a, &tcg_gen_add_tl);
+    return gen_arith_imm_fn(ctx, a, &tcg_gen_addi_tl);
 }
 
 static void gen_slt(TCGv ret, TCGv s1, TCGv s2)
@@ -239,25 +239,25 @@ static void gen_sltu(TCGv ret, TCGv s1, TCGv s2)
 
 static bool trans_slti(DisasContext *ctx, arg_slti *a)
 {
-    return gen_arith_imm(ctx, a, &gen_slt);
+    return gen_arith_imm_tl(ctx, a, &gen_slt);
 }
 
 static bool trans_sltiu(DisasContext *ctx, arg_sltiu *a)
 {
-    return gen_arith_imm(ctx, a, &gen_sltu);
+    return gen_arith_imm_tl(ctx, a, &gen_sltu);
 }
 
 static bool trans_xori(DisasContext *ctx, arg_xori *a)
 {
-    return gen_arith_imm(ctx, a, &tcg_gen_xor_tl);
+    return gen_arith_imm_fn(ctx, a, &tcg_gen_xori_tl);
 }
 static bool trans_ori(DisasContext *ctx, arg_ori *a)
 {
-    return gen_arith_imm(ctx, a, &tcg_gen_or_tl);
+    return gen_arith_imm_fn(ctx, a, &tcg_gen_ori_tl);
 }
 static bool trans_andi(DisasContext *ctx, arg_andi *a)
 {
-    return gen_arith_imm(ctx, a, &tcg_gen_and_tl);
+    return gen_arith_imm_fn(ctx, a, &tcg_gen_andi_tl);
 }
 static bool trans_slli(DisasContext *ctx, arg_slli *a)
 {
@@ -364,7 +364,7 @@ static bool trans_and(DisasContext *ctx, arg_and *a)
 #ifdef TARGET_RISCV64
 static bool trans_addiw(DisasContext *ctx, arg_addiw *a)
 {
-    return gen_arith_imm(ctx, a, &gen_addw);
+    return gen_arith_imm_tl(ctx, a, &gen_addw);
 }
 
 static bool trans_slliw(DisasContext *ctx, arg_slliw *a)
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 8b37e0928f50..313c27b70073 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -567,8 +567,23 @@ static int ex_rvc_shifti(DisasContext *ctx, int imm)
 /* Include the auto-generated decoder for 32 bit insn */
 #include "decode_insn32.inc.c"
 
-static bool gen_arith_imm(DisasContext *ctx, arg_i *a,
-                          void(*func)(TCGv, TCGv, TCGv))
+static bool gen_arith_imm_fn(DisasContext *ctx, arg_i *a,
+                             void (*func)(TCGv, TCGv, target_long))
+{
+    TCGv source1;
+    source1 = tcg_temp_new();
+
+    gen_get_gpr(source1, a->rs1);
+
+    (*func)(source1, source1, a->imm);
+
+    gen_set_gpr(a->rd, source1);
+    tcg_temp_free(source1);
+    return true;
+}
+
+static bool gen_arith_imm_tl(DisasContext *ctx, arg_i *a,
+                             void (*func)(TCGv, TCGv, TCGv))
 {
     TCGv source1, source2;
     source1 = tcg_temp_new();
-- 
2.21.0


