Return-Path: <SRS0=ZZp+=TS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5670EC04AAF
	for <qemu-devel@archiver.kernel.org>; Sat, 18 May 2019 19:19:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 228B820873
	for <qemu-devel@archiver.kernel.org>; Sat, 18 May 2019 19:19:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Bq6yDrPN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 228B820873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37787 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hS4rp-0006sm-9s
	for qemu-devel@archiver.kernel.org; Sat, 18 May 2019 15:19:37 -0400
Received: from eggs.gnu.org ([209.51.188.92]:32998)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hS4n4-0003HK-J8
	for qemu-devel@nongnu.org; Sat, 18 May 2019 15:14:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hS4n3-0002m5-N3
	for qemu-devel@nongnu.org; Sat, 18 May 2019 15:14:42 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:42795)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hS4n3-0002le-HR
	for qemu-devel@nongnu.org; Sat, 18 May 2019 15:14:41 -0400
Received: by mail-pg1-x544.google.com with SMTP id 145so4831969pgg.9
	for <qemu-devel@nongnu.org>; Sat, 18 May 2019 12:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=kXizO55eLrOiGAHhiV0+/OirBzapZrJT5f+voVJy6MY=;
	b=Bq6yDrPNQuAl4GwDFNbhsnqtkdyx7Z2onUvSG0e4kOr/9M48zb3azhiRqzsjUyuE9Q
	UiUEgm8PK1LV8tQ59UWPvQw+SppJ/v742amAgKMT84XEojXQ4tnY/Yj+B2K7+mROtbVr
	DKMKaQ7K1ws2QdR5xSPyeiNbJko9+TRxaYCuim/uoVBE47wWWsJgAD7WfuxCPa9OBDOP
	I7d6C94bTKAtBQaKOVjkQ0yU0cRB9pYdj/zGQsyW7pEgxBvMPhPegjTOlF7oS+31qOKf
	45juv05xyC/45SeAD4OhBT2ohnae9mkQmYlbPANveMwKw3G6xBoD+bvs2tAzhklQGnEr
	1j3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=kXizO55eLrOiGAHhiV0+/OirBzapZrJT5f+voVJy6MY=;
	b=b2pvzD466Vrnd2h9IP+zPs4e3Lb4dienS+uv1K9366/S6qQEmA8s0nhiLa7nXlnZ9m
	LfEQ7yMWc5FZs0c7gjbHsMTxMzX7YIHLUqmbKqUby+iHGLKZozINguaodiOQa+1TZOqJ
	NEcgJCJTH1stqn78KdTGjeY07lmweudcLKTi5mEKYvhLfc+K6BopjQNqoj6i9oUwD743
	cCrzINeLj6iFKOkReSDLZK6jhe3rBGkGCGTyliRZHdjA8UwbCxbNiwpgFiHHLmak/hs/
	Ntay9fqupIPlPKsLQ57qIpYnfziVLMiemb4IQcIyjE7iPl9A2/xyWfRI9D68SFKbDBYZ
	ZHTg==
X-Gm-Message-State: APjAAAXnQm1CIXqSiaCV7wfwpkXRnstBPP2AyHlw+CkvfT7ctXxbndGI
	aIH4fwyi6Mqd74Ajn9AIgqcGIQ/qOEY=
X-Google-Smtp-Source: APXvYqwOd7rjg86527IDTgp6gzEuoEYGGAgyJiPpVbWPgkTpWpM7Gj40NnS/RP+Ug5UAgtffiSMH4A==
X-Received: by 2002:a65:528b:: with SMTP id y11mr64972423pgp.341.1558206880320;
	Sat, 18 May 2019 12:14:40 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231]) by smtp.gmail.com with ESMTPSA id
	d186sm19206675pfd.183.2019.05.18.12.14.39
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sat, 18 May 2019 12:14:39 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Sat, 18 May 2019 12:14:30 -0700
Message-Id: <20190518191430.21686-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190518191430.21686-1-richard.henderson@linaro.org>
References: <20190518191430.21686-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::544
Subject: [Qemu-devel] [PATCH 2/2] target/ppc: Use tcg_gen_gvec_bitsel
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
Cc: mark.cave-ayland@ilande.co.uk, qemu-ppc@nongnu.org,
	david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Replace the target-specific implementation of XXSEL.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/ppc/translate/vsx-impl.inc.c | 24 ++----------------------
 1 file changed, 2 insertions(+), 22 deletions(-)

diff --git a/target/ppc/translate/vsx-impl.inc.c b/target/ppc/translate/vsx-impl.inc.c
index 11d9b75d01..7a5d0e1f46 100644
--- a/target/ppc/translate/vsx-impl.inc.c
+++ b/target/ppc/translate/vsx-impl.inc.c
@@ -1290,28 +1290,8 @@ static void glue(gen_, name)(DisasContext *ctx)             \
 VSX_XXMRG(xxmrghw, 1)
 VSX_XXMRG(xxmrglw, 0)
 
-static void xxsel_i64(TCGv_i64 t, TCGv_i64 a, TCGv_i64 b, TCGv_i64 c)
-{
-    tcg_gen_and_i64(b, b, c);
-    tcg_gen_andc_i64(a, a, c);
-    tcg_gen_or_i64(t, a, b);
-}
-
-static void xxsel_vec(unsigned vece, TCGv_vec t, TCGv_vec a,
-                      TCGv_vec b, TCGv_vec c)
-{
-    tcg_gen_and_vec(vece, b, b, c);
-    tcg_gen_andc_vec(vece, a, a, c);
-    tcg_gen_or_vec(vece, t, a, b);
-}
-
 static void gen_xxsel(DisasContext *ctx)
 {
-    static const GVecGen4 g = {
-        .fni8 = xxsel_i64,
-        .fniv = xxsel_vec,
-        .vece = MO_64,
-    };
     int rt = xT(ctx->opcode);
     int ra = xA(ctx->opcode);
     int rb = xB(ctx->opcode);
@@ -1321,8 +1301,8 @@ static void gen_xxsel(DisasContext *ctx)
         gen_exception(ctx, POWERPC_EXCP_VSXU);
         return;
     }
-    tcg_gen_gvec_4(vsr_full_offset(rt), vsr_full_offset(ra),
-                   vsr_full_offset(rb), vsr_full_offset(rc), 16, 16, &g);
+    tcg_gen_gvec_bitsel(MO_64, vsr_full_offset(rt), vsr_full_offset(rc),
+                        vsr_full_offset(rb), vsr_full_offset(ra), 16, 16);
 }
 
 static void gen_xxspltw(DisasContext *ctx)
-- 
2.17.1


