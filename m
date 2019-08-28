Return-Path: <SRS0=QQWF=WY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5BC7C3A5A1
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 19:08:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E0C320679
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 19:08:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yMq3/iJI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E0C320679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40886 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i33It-0005ik-VM
	for qemu-devel@archiver.kernel.org; Wed, 28 Aug 2019 15:08:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37470)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i33Fm-00033n-Sv
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 15:05:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i33Fl-0008Bn-BF
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 15:05:10 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:44121)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i33Fl-0008A1-2H
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 15:05:09 -0400
Received: by mail-pf1-x443.google.com with SMTP id c81so371837pfc.11
 for <qemu-devel@nongnu.org>; Wed, 28 Aug 2019 12:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=Y5yPfgEriWWma7y9hU2/xgK2vFUjf1uQUjpsxHdDPIY=;
 b=yMq3/iJIs+X2hHMLBXGUONjwOV07estLLoofNW7mzhCS/ghswkzmTIi3WUGIcYUTY1
 y1eUDawNAjO1pMYfz3OVEneK59MGv/0jvXXD23idfG478JSMENqsjmhKk/+0hO9jmpMs
 TzuhF7InGuX9Q71WkNMmRUTH238lmfyJEQpZpbqoXNDcxjjrDaMoa3gZ74bw/HnRPDy5
 eToc6DPH3Th2Zq6+YdrbImTra3GGD7tD/YZFOrZBzbw9xWyGni9xg6VKwM64CSf6UfaO
 ksBohpHL+SvbOGp2OGv2tV7lvw4PdhqHKNRe3h200BpT6HC6RS7L5wAl+L/y0ok0Fhow
 7XBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=Y5yPfgEriWWma7y9hU2/xgK2vFUjf1uQUjpsxHdDPIY=;
 b=FagH1sApOul13wQXfVGlaQ0snqnJ/EFGLyxxpv15Kz9zjp7JryVv/Mf89KnVAyQ6mC
 6uTihRwZuJ8v9sfjD2cUHTew59YdD6v3D8tXgG1MgMYYBCW4E5O8nSjD/clGNNYKwwxa
 ZA7Ub0jK6t9Bu14gxVzy1rbIng9+Y8uTYqdbUfxK9lKBbPFp/jD2jujh2Nm/k6OEH/oB
 Y9pd2tQPtf1LBPTuthkJuFqSinYOF2e9E0fVuwFZ70vuTrPOgQ3ETugZ3MIl+7gs73X/
 GWD4Xa+8TG5ejKLPjXXqic8aYmsz/I7Hnq9+Z8/4HVp5QDXWW2HHqCmPWAk9gvgEYy2t
 caqA==
X-Gm-Message-State: APjAAAXXDqS2luBLq3hYNMdgrd/JYw0zTjLSanPG3+IiFmjC4XAF4/0N
 I3Qd1qWlVJgU+8j4GTQ705TnJVpxC0A=
X-Google-Smtp-Source: APXvYqyg+3vJy+xt1536W63PlCsaw1VSsi1KCckuDkxhvyn1dmTKHyV6dYJ7VtkBUTQEhdAVnoRihg==
X-Received: by 2002:a63:de4c:: with SMTP id y12mr4869451pgi.264.1567019107645; 
 Wed, 28 Aug 2019 12:05:07 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id f27sm2967944pgm.60.2019.08.28.12.05.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2019 12:05:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 28 Aug 2019 12:03:54 -0700
Message-Id: <20190828190456.30315-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190828190456.30315-1-richard.henderson@linaro.org>
References: <20190828190456.30315-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
Subject: [Qemu-devel] [PATCH v3 07/69] target/arm: Simplify UMAAL
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Since all of the inputs and outputs are i32, dispense with
the intermediate promotion to i64 and use tcg_gen_mulu2_i32
and tcg_gen_add2_i32.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate.c | 34 ++++++++++++----------------------
 1 file changed, 12 insertions(+), 22 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index b7845d825b..17659627b1 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -7320,21 +7320,6 @@ static void gen_storeq_reg(DisasContext *s, int rlow, int rhigh, TCGv_i64 val)
     store_reg(s, rhigh, tmp);
 }
 
-/* load a 32-bit value from a register and perform a 64-bit accumulate.  */
-static void gen_addq_lo(DisasContext *s, TCGv_i64 val, int rlow)
-{
-    TCGv_i64 tmp;
-    TCGv_i32 tmp2;
-
-    /* Load value and extend to 64 bits.  */
-    tmp = tcg_temp_new_i64();
-    tmp2 = load_reg(s, rlow);
-    tcg_gen_extu_i32_i64(tmp, tmp2);
-    tcg_temp_free_i32(tmp2);
-    tcg_gen_add_i64(val, val, tmp);
-    tcg_temp_free_i64(tmp);
-}
-
 /* load and add a 64-bit value from a register pair.  */
 static void gen_addq(DisasContext *s, TCGv_i64 val, int rlow, int rhigh)
 {
@@ -8093,8 +8078,7 @@ static bool trans_SMLAL(DisasContext *s, arg_SMLAL *a)
 
 static bool trans_UMAAL(DisasContext *s, arg_UMAAL *a)
 {
-    TCGv_i32 t0, t1;
-    TCGv_i64 t64;
+    TCGv_i32 t0, t1, t2, zero;
 
     if (s->thumb
         ? !arm_dc_feature(s, ARM_FEATURE_THUMB_DSP)
@@ -8104,11 +8088,17 @@ static bool trans_UMAAL(DisasContext *s, arg_UMAAL *a)
 
     t0 = load_reg(s, a->rm);
     t1 = load_reg(s, a->rn);
-    t64 = gen_mulu_i64_i32(t0, t1);
-    gen_addq_lo(s, t64, a->ra);
-    gen_addq_lo(s, t64, a->rd);
-    gen_storeq_reg(s, a->ra, a->rd, t64);
-    tcg_temp_free_i64(t64);
+    tcg_gen_mulu2_i32(t0, t1, t0, t1);
+    zero = tcg_const_i32(0);
+    t2 = load_reg(s, a->ra);
+    tcg_gen_add2_i32(t0, t1, t0, t1, t2, zero);
+    tcg_temp_free_i32(t2);
+    t2 = load_reg(s, a->rd);
+    tcg_gen_add2_i32(t0, t1, t0, t1, t2, zero);
+    tcg_temp_free_i32(t2);
+    tcg_temp_free_i32(zero);
+    store_reg(s, a->ra, t0);
+    store_reg(s, a->rd, t1);
     return true;
 }
 
-- 
2.17.1


