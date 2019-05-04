Return-Path: <SRS0=Uyhh=TE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC24CC43219
	for <qemu-devel@archiver.kernel.org>; Sat,  4 May 2019 06:12:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83F5D206BB
	for <qemu-devel@archiver.kernel.org>; Sat,  4 May 2019 06:12:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OXbI95IV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83F5D206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51880 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMnua-0007sO-J1
	for qemu-devel@archiver.kernel.org; Sat, 04 May 2019 02:12:40 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42060)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hMnc9-00087Z-0Z
	for qemu-devel@nongnu.org; Sat, 04 May 2019 01:53:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hMnc7-0004aJ-TA
	for qemu-devel@nongnu.org; Sat, 04 May 2019 01:53:36 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:37245)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hMnc7-0004a0-Mm
	for qemu-devel@nongnu.org; Sat, 04 May 2019 01:53:35 -0400
Received: by mail-pf1-x441.google.com with SMTP id g3so3975798pfi.4
	for <qemu-devel@nongnu.org>; Fri, 03 May 2019 22:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=sLhzMGGDR1ZhuOEjkMPl9rWAydAxNvaV/cqSFAgz/Lc=;
	b=OXbI95IVET/MEyrfHbeMzCG8LiGf9O1EJzXSaZK5vhQ7iImliEW3rJq787eWSlpcYy
	LKdbnv1wIEfTJc2pP1/DLLn9LKnem03MnmG6Q2lwMbp3Wg7sYr94sKGZtIAW1ypAB4D+
	nLKUQG5CSVFkov65+/3/J273IbdinuJH+GZr14dzsfEzlrCodOcLUWb7QvJzcElNbObZ
	haFbfwiH87fDQHV9OeLo5SK2XqZgdEDjaPCKIf7lmJQd3B13hrtRrVz2espU+qHb4u5I
	RyVLpR9edov1lOC+V04Bp1oHPgHoRpm7Eaf2ZuAW5d6mDEozDjbhG3l3RVeaFoeUn6GR
	8SFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=sLhzMGGDR1ZhuOEjkMPl9rWAydAxNvaV/cqSFAgz/Lc=;
	b=ed38oUncH+1YXVb3kJz37U987wgDKSna+idCtjLWYeCzxvU233ZAhu2dES2VUtRan/
	4eWFZLB6MjqVfegq5mlVhTK9JjmLqngN5Ym7Ww19NXDWgIzsJLuxDC+WkOr7EfVbNcjS
	dRFxZWKzzwrh6kBl96k9qxUNWAsbnT4PComP9QoVQzrytqk03w3l6P+LbftRCjd062gl
	ZCrecWDZavdHVTYQJGJWXUHjRi0mzYgjX3P1j/NlhlP4pbjOdpIpev1xBjYYSC7DPink
	P5JeD3lC1nz4pRdxATPvtarSfCLD2/jxTYzr6FfN1xYrsn8gXgfcKIFSX0MDU6l2F3GH
	a7qg==
X-Gm-Message-State: APjAAAWjt1HpGo3aQXauJ6TFlHHvOCYeE/uLBzBPgZw40EWn/grRCGcV
	UnhDn+nqP2WvXuvZNnY/lZUYUM0irDY=
X-Google-Smtp-Source: APXvYqwhQmIm2stQ00CWajbJBWq4D1Mfv4XqJYjxBRG42M67y4IdT+tq3pRWJIMSNwSxcdkT9LKleA==
X-Received: by 2002:a65:528b:: with SMTP id y11mr5097163pgp.341.1556949214547; 
	Fri, 03 May 2019 22:53:34 -0700 (PDT)
Received: from localhost.localdomain (97-113-189-189.tukw.qwest.net.
	[97.113.189.189]) by smtp.gmail.com with ESMTPSA id
	15sm6680423pfo.117.2019.05.03.22.53.33
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 03 May 2019 22:53:33 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri,  3 May 2019 22:52:56 -0700
Message-Id: <20190504055300.18426-28-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190504055300.18426-1-richard.henderson@linaro.org>
References: <20190504055300.18426-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::441
Subject: [Qemu-devel] [PATCH v3 27/31] target/ppc: Use tcg_gen_abs_tl
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
Cc: alex.bennee@linaro.org, david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190504055256.HvOoPOAIFmJmPxxcm4-V_yvP9H3EKzgBOgIJtHBIfdM@z>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/ppc/translate.c | 68 +++++++++++++++---------------------------
 1 file changed, 24 insertions(+), 44 deletions(-)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 8d08625c33..b5217f632f 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -5075,40 +5075,26 @@ static void gen_ecowx(DisasContext *ctx)
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
+    TCGv d = cpu_gpr[rD(ctx->opcode)];
+    TCGv a = cpu_gpr[rA(ctx->opcode)];
+
+    tcg_gen_abs_tl(d, a);
     if (unlikely(Rc(ctx->opcode) != 0)) {
-        gen_set_Rc0(ctx, cpu_gpr[rD(ctx->opcode)]);
+        gen_set_Rc0(ctx, d);
     }
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
+    TCGv d = cpu_gpr[rD(ctx->opcode)];
+    TCGv a = cpu_gpr[rA(ctx->opcode)];
+
+    tcg_gen_setcondi_tl(TCG_COND_EQ, cpu_ov, a, 0x80000000);
+    tcg_gen_abs_tl(d, a);
+    tcg_gen_or_tl(cpu_so, cpu_so, cpu_ov);
     if (unlikely(Rc(ctx->opcode) != 0)) {
-        gen_set_Rc0(ctx, cpu_gpr[rD(ctx->opcode)]);
+        gen_set_Rc0(ctx, d);
     }
 }
 
@@ -5344,34 +5330,28 @@ static void gen_mulo(DisasContext *ctx)
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
+    TCGv d = cpu_gpr[rD(ctx->opcode)];
+    TCGv a = cpu_gpr[rA(ctx->opcode)];
+
+    tcg_gen_abs_tl(d, a);
+    tcg_gen_neg_tl(d, d);
     if (unlikely(Rc(ctx->opcode) != 0)) {
-        gen_set_Rc0(ctx, cpu_gpr[rD(ctx->opcode)]);
+        gen_set_Rc0(ctx, d);
     }
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
     if (unlikely(Rc(ctx->opcode) != 0)) {
-        gen_set_Rc0(ctx, cpu_gpr[rD(ctx->opcode)]);
+        gen_set_Rc0(ctx, d);
     }
 }
 
-- 
2.17.1


