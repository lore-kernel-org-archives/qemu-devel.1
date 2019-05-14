Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29F93C04AA7
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 00:14:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E17D920862
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 00:14:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mWeOPVw8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E17D920862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36683 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQL5s-0000YM-41
	for qemu-devel@archiver.kernel.org; Mon, 13 May 2019 20:14:56 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56181)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hQL0V-0003A9-Ui
	for qemu-devel@nongnu.org; Mon, 13 May 2019 20:09:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hQKxd-0003pb-VA
	for qemu-devel@nongnu.org; Mon, 13 May 2019 20:09:20 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e]:45082)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hQKxb-0003hs-Nu
	for qemu-devel@nongnu.org; Mon, 13 May 2019 20:06:24 -0400
Received: by mail-pl1-x62e.google.com with SMTP id a5so7254778pls.12
	for <qemu-devel@nongnu.org>; Mon, 13 May 2019 17:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=sLhzMGGDR1ZhuOEjkMPl9rWAydAxNvaV/cqSFAgz/Lc=;
	b=mWeOPVw8BrPnhBNWTkiLQ4QHDd/KJRJ5qCgIfVsi37jD5J5U3vuE79UEXwyZ6T+CoW
	RxJ1sBLV/1y02v+Nlq3RHjRBGGFPL8Y6Nx1RBLx+pOQG2tZacXwdspI9M1ghCNFN6dsM
	5DD8hswVfPbLjVdUW5b6YDs2hu5vDWEhYyG7GP65FKh3nryHl1VaVRc571zk8Ok+ljbB
	a+M3Q8tBHsUOGpSDg0Xf4AVYjdR1bL89vScHyxvLL5exxNb9EbBmU1qbH4cbfuG1qbYx
	kqDw1q+T5FoUnxdGuqtlY/0jYtVYrU6ApV8hlgNF2i7+Dnz1q0W4zwz/659P9bF0nVi2
	Pdcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=sLhzMGGDR1ZhuOEjkMPl9rWAydAxNvaV/cqSFAgz/Lc=;
	b=mhWF3yw8hEihGNYKMRTaeW1wrlvcZ9oqffYI1O/LBXjGU3SZnJ3tgkd62OucXKcD3G
	sRIVFyQaqnpTknv29L6KXuWvuDzUA0vPX1Q6Z1352WwxtnJVbnonq8eFYNkwb+Iz3LzC
	ufhcSw12J6Pzv0sFnqegv+clWWldbbNAMnYptblFoCtCSIEOQtEvqZJhHqLiPW7E3uwk
	jZj6WxsyUbswoMhI+K7UJpfsbjcSB0NaDVesPNBWYwARGEcS776oZ+1fuHVg65ttmt59
	MVUuN20gAJdQKIGNWMgDVpUHuZVpdE6SUZwCUNMWKd87KmQN+zDpQS7FF6G+zpACDK42
	EBGg==
X-Gm-Message-State: APjAAAVvhq8Tqv95a6M8XRVUz2jwIl+UuHNhSOgMnJoND5Jori6dUra5
	pWMTgzafzxb6Y1T+lAFj2jEcR6B0vpY=
X-Google-Smtp-Source: APXvYqzjdt0flkZOcTz+my76vGdwIgoxiVAOgpFdVQjyQHvwcPv31f+5TxRjJRzMO4VMQl3J/wWvZw==
X-Received: by 2002:a17:902:a405:: with SMTP id
	p5mr29556378plq.51.1557792377818; 
	Mon, 13 May 2019 17:06:17 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231])
	by smtp.gmail.com with ESMTPSA id u3sm238151pfn.29.2019.05.13.17.06.16
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 13 May 2019 17:06:17 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon, 13 May 2019 17:05:36 -0700
Message-Id: <20190514000540.4313-28-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190514000540.4313-1-richard.henderson@linaro.org>
References: <20190514000540.4313-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::62e
Subject: [Qemu-devel] [PULL 27/31] target/ppc: Use tcg_gen_abs_tl
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
Cc: peter.maydell@linux.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

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


