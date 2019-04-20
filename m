Return-Path: <SRS0=TjK1=SW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CB9DC282DD
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Apr 2019 07:51:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5725621479
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Apr 2019 07:51:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Lq9jyXh8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5725621479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38299 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hHkmv-00063Q-KQ
	for qemu-devel@archiver.kernel.org; Sat, 20 Apr 2019 03:51:53 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40373)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hHkXG-0000gZ-IK
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 03:35:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hHkXC-0000H0-0t
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 03:35:39 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:42015)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hHkXB-0008U2-Oj
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 03:35:37 -0400
Received: by mail-pl1-x642.google.com with SMTP id cv12so3533292plb.9
	for <qemu-devel@nongnu.org>; Sat, 20 Apr 2019 00:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=BobRUDDq3dnwwt/qXps0agrFTDkezRLKK87vg29L7R4=;
	b=Lq9jyXh8dPQfAeeu4RrTpPeVB2gyMKcVeSZMBgb5+1gQ/oyvIohjbIT9XgDzqxFuLW
	3WdexrYihohU3f2hHtsidux2k6boZnbiC5f5zP1SkMnJmfbhVEQCDUZnToVTYe4NIAJA
	5ICft3oUq+SgsijbfXuWdAzGJFsxF/Na9e53cLT7ha9EcKySJo0LSsGUmGeraVZBpUo/
	KpY1gWMDl3B0gqhQP3islPdYkG2wOgeRXqVNdh32pz9GU0p623qaY7SJpHoDhVB+K6ka
	5+nFUoCwT8BWH0pYcOAvGGqBcR6SYDeRezoWY3VRBfAJgOLtEDuehP59kHnL/RqHEw8P
	Lc2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=BobRUDDq3dnwwt/qXps0agrFTDkezRLKK87vg29L7R4=;
	b=ldVaWplsR1jKH9HhIcZA2LsJrnWPWcZuP/NNpPASTKXtwkYDFTL6ZBtH/xav6kK21L
	7SGl/nZocUmWyisSHiTogry612zdIhrDDDR1oGwSJ5zhTkWr8rkCZPKu+HnrctVKCjFR
	fbN0Tr2WL4LBkuw1Ne4R08o+fvlzxitXFizFjLzag3m4Zy5K+oKAP8K0Pv1EVkuYxnmu
	yTUdLnz0J/BL0waUiBDbW6TB40WWBNcHB02cSAncO1sm8rpDWIPMVVAspkY5raR/VHd/
	mXrH/KHcP1w18SRSDjF77DXZvwhpS1XtkBz6UrcsYmrStcwyptS1EOmhJBSC82af6+ML
	Uz6A==
X-Gm-Message-State: APjAAAVl7g/F7AL28jZg3iSQo57+ALrsVAMedR3aUFbuqeGJOzfBARqQ
	H3RgYSG8uu3TiCjNPhutNL7V3jUGypI=
X-Google-Smtp-Source: APXvYqyruKzEVeVZw1fZQHuZSaox0yDBE5vRpFeyromre/MLinJhm9W4LHsizjhNcBUyyudnyj6J4A==
X-Received: by 2002:a17:902:778d:: with SMTP id
	o13mr2589862pll.314.1555745723146; 
	Sat, 20 Apr 2019 00:35:23 -0700 (PDT)
Received: from localhost.localdomain (rrcs-66-91-136-155.west.biz.rr.com.
	[66.91.136.155]) by smtp.gmail.com with ESMTPSA id
	z22sm7025492pgv.23.2019.04.20.00.35.21
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sat, 20 Apr 2019 00:35:22 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 19 Apr 2019 21:34:27 -1000
Message-Id: <20190420073442.7488-24-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190420073442.7488-1-richard.henderson@linaro.org>
References: <20190420073442.7488-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::642
Subject: [Qemu-devel] [PATCH 23/38] target/ppc: Use tcg_gen_abs_tl
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
Cc: david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190420073427.2JcgCeoUBtal7tHoPO_O2u6Sb3Ot04EoaQTHaXKfhLE@z>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/ppc/translate.c | 80 +++++++++++++++++-------------------------
 1 file changed, 32 insertions(+), 48 deletions(-)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index badc1ae1a3..97b8e8ddaf 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -5013,39 +5013,27 @@ static void gen_ecowx(DisasContext *ctx)
 /* abs - abs. */
 static void gen_abs(DisasContext *ctx)
 {
-    TCGLabel *l1 = gen_new_label();
-    TCGLabel *l2 = gen_new_label();
-    tcg_gen_brcondi_tl(TCG_COND_GE, cpu_gpr[rA(ctx->opcode)], 0, l1);
-    tcg_gen_neg_tl(cpu_gpr[rD(ctx->opcode)], cpu_gpr[rA(ctx->opcode)]);
-    tcg_gen_br(l2);
-    gen_set_label(l1);
-    tcg_gen_mov_tl(cpu_gpr[rD(ctx->opcode)], cpu_gpr[rA(ctx->opcode)]);
-    gen_set_label(l2);
-    if (unlikely(Rc(ctx->opcode) != 0))
-        gen_set_Rc0(ctx, cpu_gpr[rD(ctx->opcode)]);
+    TCGv d = cpu_gpr[rD(ctx->opcode)];
+    TCGv a = cpu_gpr[rA(ctx->opcode)];
+
+    tcg_gen_abs_tl(d, a);
+    if (unlikely(Rc(ctx->opcode) != 0)) {
+        gen_set_Rc0(ctx, d);
+    }
 }
 
 /* abso - abso. */
 static void gen_abso(DisasContext *ctx)
 {
-    TCGLabel *l1 = gen_new_label();
-    TCGLabel *l2 = gen_new_label();
-    TCGLabel *l3 = gen_new_label();
-    /* Start with XER OV disabled, the most likely case */
-    tcg_gen_movi_tl(cpu_ov, 0);
-    tcg_gen_brcondi_tl(TCG_COND_GE, cpu_gpr[rA(ctx->opcode)], 0, l2);
-    tcg_gen_brcondi_tl(TCG_COND_NE, cpu_gpr[rA(ctx->opcode)], 0x80000000, l1);
-    tcg_gen_movi_tl(cpu_ov, 1);
-    tcg_gen_movi_tl(cpu_so, 1);
-    tcg_gen_br(l2);
-    gen_set_label(l1);
-    tcg_gen_neg_tl(cpu_gpr[rD(ctx->opcode)], cpu_gpr[rA(ctx->opcode)]);
-    tcg_gen_br(l3);
-    gen_set_label(l2);
-    tcg_gen_mov_tl(cpu_gpr[rD(ctx->opcode)], cpu_gpr[rA(ctx->opcode)]);
-    gen_set_label(l3);
-    if (unlikely(Rc(ctx->opcode) != 0))
-        gen_set_Rc0(ctx, cpu_gpr[rD(ctx->opcode)]);
+    TCGv d = cpu_gpr[rD(ctx->opcode)];
+    TCGv a = cpu_gpr[rA(ctx->opcode)];
+
+    tcg_gen_setcondi_tl(TCG_COND_EQ, cpu_ov, a, 0x80000000);
+    tcg_gen_abs_tl(d, a);
+    tcg_gen_or_tl(cpu_so, cpu_so, cpu_ov);
+    if (unlikely(Rc(ctx->opcode) != 0)) {
+        gen_set_Rc0(ctx, d);
+    }
 }
 
 /* clcs */
@@ -5265,33 +5253,29 @@ static void gen_mulo(DisasContext *ctx)
 /* nabs - nabs. */
 static void gen_nabs(DisasContext *ctx)
 {
-    TCGLabel *l1 = gen_new_label();
-    TCGLabel *l2 = gen_new_label();
-    tcg_gen_brcondi_tl(TCG_COND_GT, cpu_gpr[rA(ctx->opcode)], 0, l1);
-    tcg_gen_mov_tl(cpu_gpr[rD(ctx->opcode)], cpu_gpr[rA(ctx->opcode)]);
-    tcg_gen_br(l2);
-    gen_set_label(l1);
-    tcg_gen_neg_tl(cpu_gpr[rD(ctx->opcode)], cpu_gpr[rA(ctx->opcode)]);
-    gen_set_label(l2);
-    if (unlikely(Rc(ctx->opcode) != 0))
-        gen_set_Rc0(ctx, cpu_gpr[rD(ctx->opcode)]);
+    TCGv d = cpu_gpr[rD(ctx->opcode)];
+    TCGv a = cpu_gpr[rA(ctx->opcode)];
+
+    tcg_gen_abs_tl(d, a);
+    tcg_gen_neg_tl(d, d);
+    if (unlikely(Rc(ctx->opcode) != 0)) {
+        gen_set_Rc0(ctx, d);
+    }
 }
 
 /* nabso - nabso. */
 static void gen_nabso(DisasContext *ctx)
 {
-    TCGLabel *l1 = gen_new_label();
-    TCGLabel *l2 = gen_new_label();
-    tcg_gen_brcondi_tl(TCG_COND_GT, cpu_gpr[rA(ctx->opcode)], 0, l1);
-    tcg_gen_mov_tl(cpu_gpr[rD(ctx->opcode)], cpu_gpr[rA(ctx->opcode)]);
-    tcg_gen_br(l2);
-    gen_set_label(l1);
-    tcg_gen_neg_tl(cpu_gpr[rD(ctx->opcode)], cpu_gpr[rA(ctx->opcode)]);
-    gen_set_label(l2);
+    TCGv d = cpu_gpr[rD(ctx->opcode)];
+    TCGv a = cpu_gpr[rA(ctx->opcode)];
+
+    tcg_gen_abs_tl(d, a);
+    tcg_gen_neg_tl(d, d);
     /* nabs never overflows */
     tcg_gen_movi_tl(cpu_ov, 0);
-    if (unlikely(Rc(ctx->opcode) != 0))
-        gen_set_Rc0(ctx, cpu_gpr[rD(ctx->opcode)]);
+    if (unlikely(Rc(ctx->opcode) != 0)) {
+        gen_set_Rc0(ctx, d);
+    }
 }
 
 /* rlmi - rlmi. */
-- 
2.17.1


