Return-Path: <SRS0=aVj3=TB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AF8EC43219
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2019 05:25:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FCE82081C
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2019 05:25:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KBDC2y8h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FCE82081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36510 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLhkG-0005zm-DG
	for qemu-devel@archiver.kernel.org; Wed, 01 May 2019 01:25:28 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38521)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hLhRm-0006lM-5u
	for qemu-devel@nongnu.org; Wed, 01 May 2019 01:06:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hLhRj-00035R-44
	for qemu-devel@nongnu.org; Wed, 01 May 2019 01:06:22 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:39218)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hLhRi-00033z-UW
	for qemu-devel@nongnu.org; Wed, 01 May 2019 01:06:19 -0400
Received: by mail-pl1-x641.google.com with SMTP id e92so7750692plb.6
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 22:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=lPp9ip0cQ55VftFpGYXkoRqMh2/FWH1IUHTaHYTSufE=;
	b=KBDC2y8hv9ok5CTyFuwYt0KAHGVpU2qnT4wC4qETyqvnjGgobEVz0OFYyU5xxaOMR0
	bfeYGiISl6LPpuQtt28rEWmeyNVLQjoq+daKlFv/7Q7o9ZlamTBhyQCV7v5/jqa/1gdl
	SR0bLmsB1bKqfDgYpF4cjAVQxh6CXGY5UiJLkkwhOxkco5gKnE2yT6Y//rFsShBL7W0O
	5V+Wv+m/EyLtCgO1T13RoazsAthfsNXZKVpZkDXcwEvDSmV3FQJwyDZMCI1O3tJOyJA0
	VFjnqsNQH0ikcCn2TvCBH0hLJ1LL9/aSmKLRHeCNuZm+zEw7LISqWZjTFa2w5imabQ8p
	WmqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=lPp9ip0cQ55VftFpGYXkoRqMh2/FWH1IUHTaHYTSufE=;
	b=VBe6ovllVbZul3722umUJdXSckKLihIJR4gZx6UAZaTCTQ96bUN146ixhzqv41m5Pl
	IRnwOJT8GZNRTL1JqHbSkH5PHSObHI9bCKQno0RGYX/SZsj4X7avor46rQdohvoHK3D0
	/yfc6+IyOGK8aManRqp1VrAuIhiIoq9Wbb6qH8KN0XsqEygnZVv2eqO7zB/KzIW6WKL0
	EyabbqGZmIyObMVfd+6cZ4+MFXurrpNzxv/veimP5fsCIJQVyQyDWSyhQShqyjH0ZFtH
	19xzj8Z/ISMXBGNQoedYRYCsR7alC/ddJ5h3LLuCOar4VukuiXX/XIsvZJrtjV3Fbjhy
	T6dg==
X-Gm-Message-State: APjAAAUX7njHER9Ao5adLgRVJB+hOp4RuEjW7DOdT9+Oto4QHDhRAn0h
	07PGNGJ0wZFX08KkxQebw8hL6f0zKW0=
X-Google-Smtp-Source: APXvYqwW9TjBpIdIP9ho2sOWdhhF3TP/iTnPdSGXw85uWCLyKFQq/KzguhJcI9Yj6eP0718NArF7Vg==
X-Received: by 2002:a17:902:b10c:: with SMTP id
	q12mr38637184plr.254.1556687176259; 
	Tue, 30 Apr 2019 22:06:16 -0700 (PDT)
Received: from localhost.localdomain (97-113-189-189.tukw.qwest.net.
	[97.113.189.189]) by smtp.gmail.com with ESMTPSA id
	t127sm9687251pfb.106.2019.04.30.22.06.15
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 30 Apr 2019 22:06:15 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue, 30 Apr 2019 22:05:33 -0700
Message-Id: <20190501050536.15580-27-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190501050536.15580-1-richard.henderson@linaro.org>
References: <20190501050536.15580-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::641
Subject: [Qemu-devel] [PATCH v2 26/29] target/ppc: Use tcg_gen_abs_tl
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
Cc: David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190501050533.jCMVYUl46D8ZxIxbAKDYde8sLQt1SPvENVPL3OYV5Gs@z>

Cc: David Gibson <david@gibson.dropbear.id.au>
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


