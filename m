Return-Path: <SRS0=e5mL=UC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ED28C04AB5
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 16:50:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B4B927410
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 16:50:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CKfUyRPF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B4B927410
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38014 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXqAb-0007ZZ-3W
	for qemu-devel@archiver.kernel.org; Mon, 03 Jun 2019 12:50:49 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37990)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hXq9O-00075y-Ub
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 12:49:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hXq9O-0007o5-11
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 12:49:34 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:36682)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hXq9N-0007lO-Pl
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 12:49:33 -0400
Received: by mail-ot1-x342.google.com with SMTP id c3so16723636otr.3
	for <qemu-devel@nongnu.org>; Mon, 03 Jun 2019 09:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id;
	bh=9ZWdKnyaVrx4H/jMG48dGyd2SGruiOzI4OMVe9jItB8=;
	b=CKfUyRPFaMvsn83YdJU0SfdwY/IDzdtQ7sKl/TY8i2F+RgHoZrtemBwCIE9ZJrS5sp
	fuoIyAmTOWX69AUqNKytMD9yKDMCn//0AdaVCp6F6nCi0KQI86YdlbTTRn5vI8tNmErM
	fMCGqTtbZDLzgfTl4WUSrqkNVvF2j05WUL9w/0wiRDvpV1/ygn7/j1YMYHvKpcPKgHBQ
	fqYf62ASuN6XKH5WbtQQkI/kJw772LRp3p+5WvafeLBPLk0XN3q9rm705BEPnkciul3g
	wxVEyIlt3mhdrFScD+1xQWH4HJwzqjnPu39iu72TW7EY35+nZVdGGueolr/hXoPpnuPg
	Tu2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=9ZWdKnyaVrx4H/jMG48dGyd2SGruiOzI4OMVe9jItB8=;
	b=Uo3eB8w2i0aKlSr2b6to4sKBBsGAxH/+V7f1jH2+8jKIw54rv+fmaLO0cCg9VBqavP
	fYb4fYoknuMePXXhy+Cq2PDGqxQmw5FlVmvsWjxx3zaDtrWKdnqxPtWBW+2cO/q1Wqd+
	dLsH9vLUS6jP2Kwo9cmcJKQFvYH1xz+Ie1zv3Kv1Te/aACQU6u/6nYjwf7dJkLCskkLG
	LYkSb4VltsOVxbP+dH1JkX+kgkqkVsH9pCnW7VEVbv9BFdg3FmobOMzsGrFb7iTTtmOo
	I8HmguHzNr5o+faHMKVnct+ZjrJe5eOh8sEODvfncj/c+k7iYE5TUfS1Ha5jZpWdbhul
	pEqA==
X-Gm-Message-State: APjAAAXw4QID7Pe16/RkWUjOWcFP9gktFyeF6t31MJaZW1T+17d7CF31
	POLY7KGT/0h7XAbyHvTvN4zk6MtxmU+lxw==
X-Google-Smtp-Source: APXvYqzFOWqGcy/RmCeh7g/YPiwp21RjPj0BFlDCjWyK+9qEDhvqNWr+hMSji5Gld4ipiFIDMjTbkw==
X-Received: by 2002:a9d:69c2:: with SMTP id v2mr2010938oto.22.1559580571728;
	Mon, 03 Jun 2019 09:49:31 -0700 (PDT)
Received: from localhost.localdomain (200-56-192-86-cable.cybercable.net.mx.
	[200.56.192.86])
	by smtp.gmail.com with ESMTPSA id s4sm847781otp.3.2019.06.03.09.49.30
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 03 Jun 2019 09:49:30 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon,  3 Jun 2019 11:49:27 -0500
Message-Id: <20190603164927.8336-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::342
Subject: [Qemu-devel] [PATCH] target/ppc: Use tcg_gen_gvec_bitsel
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
Cc: david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Replace the target-specific implementation of XXSEL.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/ppc/translate/vsx-impl.inc.c | 24 ++----------------------
 1 file changed, 2 insertions(+), 22 deletions(-)

diff --git a/target/ppc/translate/vsx-impl.inc.c b/target/ppc/translate/vsx-impl.inc.c
index 199d22da97..a7a0a88975 100644
--- a/target/ppc/translate/vsx-impl.inc.c
+++ b/target/ppc/translate/vsx-impl.inc.c
@@ -1338,28 +1338,8 @@ static void glue(gen_, name)(DisasContext *ctx)             \
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
@@ -1369,8 +1349,8 @@ static void gen_xxsel(DisasContext *ctx)
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


