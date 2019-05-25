Return-Path: <SRS0=E2zY=TZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3A68C282E1
	for <qemu-devel@archiver.kernel.org>; Sat, 25 May 2019 02:25:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBBAD2081C
	for <qemu-devel@archiver.kernel.org>; Sat, 25 May 2019 02:25:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sh0384or"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBBAD2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:34856 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hUMMz-0002Ya-0e
	for qemu-devel@archiver.kernel.org; Fri, 24 May 2019 22:25:13 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50975)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1hUMJs-0000UP-9N
	for qemu-devel@nongnu.org; Fri, 24 May 2019 22:22:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1hUMIR-0003Yd-IK
	for qemu-devel@nongnu.org; Fri, 24 May 2019 22:20:32 -0400
Received: from mail-it1-x143.google.com ([2607:f8b0:4864:20::143]:56125)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1hUMIR-0003YP-EN
	for qemu-devel@nongnu.org; Fri, 24 May 2019 22:20:31 -0400
Received: by mail-it1-x143.google.com with SMTP id g24so11930159iti.5
	for <qemu-devel@nongnu.org>; Fri, 24 May 2019 19:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=dazARfTasjbAG7BJaYUNqf7X7nG/lCTZKuXZBg0tjNk=;
	b=Sh0384orbtEMajWgYUF/rIzC88j/9d/7yE36n5YQV2Dxlb8EOtPvlppMmA4e+AyqEG
	+NSRRIx6k6saDNNct4RAcXX/uFjVwEtUN24cTafIPNvX6aC1QYcqSRmD/XUhJdF1E6Dy
	6cHhJaRTZybJRWsYOu+aUAcEgfnsWTOQVLwbKT+HLtOVQaJszSYLD5z/PAOntAB+E4LE
	+rKsJeweJxpH6ik3nrvlZhC8IHIPyUrGxz5yrtAv3rFF0Tgwo9CcYxUgeCn3VjdU+OWh
	K7rabvFnAwoEb2fJZf5DauoCQp8R4HuxNx/qxK+POiIje3XJAAe1NdWDaiai+27R69Rq
	PtPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=dazARfTasjbAG7BJaYUNqf7X7nG/lCTZKuXZBg0tjNk=;
	b=Tin2ydObNcvHZ3K/Yi3KAfSdEEjvAkbTa2qwuGBZH8GlX3LSkO13smdIiBC1GLccAw
	1UBDLrL2/odlOqSlVDLuZ4V+R0yoqawgyryL28BEep9tzVdfAK/rwUz6u5tI1Wp9T8Z7
	f909In0TLiXIA8z/W4gftgK7drHvhK2JvmLHfP4Ahl8ggmq4uFQsvcchHiUKYmVQMWcn
	zBbG4jXzu9pBHZKLchyXgXnApf8LGFXvKtVgyYM79OBERlu7N7nnUpqlI5eOVBEZTaXx
	cizcblP1EyemRxMtSIpWQpdll9EKtNUpbxeIx+CUkQNFHdlmJuclUVIH4rwRIiGGNNac
	BHZQ==
X-Gm-Message-State: APjAAAUS1P7utQE0iPPsbXCr3yO1PH+v97T3NDpgcT2nySt1OCUveUbB
	4k+XjqRsZ9842cGqLgJwWRdHqSz5
X-Google-Smtp-Source: APXvYqzEtP96vOP+zyv041NmFTdFxRoXJkulWVPSBAtNyhY/3suG6Oo0UlNHHqJmWl4nSn+aS1E6mw==
X-Received: by 2002:a05:660c:105:: with SMTP id
	w5mr11688342itj.37.1558750831006; 
	Fri, 24 May 2019 19:20:31 -0700 (PDT)
Received: from localhost.localdomain (d14-69-20-184.try.wideopenwest.com.
	[69.14.184.20]) by smtp.gmail.com with ESMTPSA id
	p20sm1575524ioj.63.2019.05.24.19.20.29
	(version=TLS1 cipher=AES128-SHA bits=128/128);
	Fri, 24 May 2019 19:20:30 -0700 (PDT)
From: John Arbuckle <programmingkidx@gmail.com>
To: richard.henderson@linaro.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.orgd,
	david@gibson.dropbear.id.au, mark.cave-ayland@ilande.co.uk
Date: Fri, 24 May 2019 22:20:07 -0400
Message-Id: <20190525022008.24788-2-programmingkidx@gmail.com>
X-Mailer: git-send-email 2.14.3 (Apple Git-98)
In-Reply-To: <20190525022008.24788-1-programmingkidx@gmail.com>
References: <20190525022008.24788-1-programmingkidx@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::143
Subject: [Qemu-devel] [PATCH 1/2] Implement Floating Point flag Fraction
 Rounded
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
Cc: John Arbuckle <programmingkidx@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: John Arbuckle <programmingkidx@gmail.com>
---
 fpu/softfloat.c               | 15 ++++++++++++---
 include/fpu/softfloat-types.h |  1 +
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 2ba36ec370..ac34f6a2de 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -702,7 +702,7 @@ static FloatParts round_canonical(FloatParts p, float_status *s,
     const uint64_t roundeven_mask = parm->roundeven_mask;
     const int exp_max = parm->exp_max;
     const int frac_shift = parm->frac_shift;
-    uint64_t frac, inc;
+    uint64_t frac, inc, rounded;
     int exp, flags = 0;
     bool overflow_norm;
 
@@ -744,7 +744,12 @@ static FloatParts round_canonical(FloatParts p, float_status *s,
         if (likely(exp > 0)) {
             if (frac & round_mask) {
                 flags |= float_flag_inexact;
-                frac += inc;
+                rounded = frac + inc;
+                if ((rounded ^ frac) & frac_lsb) {
+                    flags |= float_flag_rounded;
+                }
+                frac = rounded;
+
                 if (frac & DECOMPOSED_OVERFLOW_BIT) {
                     frac >>= 1;
                     exp++;
@@ -793,7 +798,11 @@ static FloatParts round_canonical(FloatParts p, float_status *s,
                     break;
                 }
                 flags |= float_flag_inexact;
-                frac += inc;
+                rounded = frac + inc;
+                if ((rounded ^ frac) & frac_lsb) {
+                    flags |= float_flag_rounded;
+                }
+                frac = rounded;
             }
 
             exp = (frac & DECOMPOSED_IMPLICIT_BIT ? 1 : 0);
diff --git a/include/fpu/softfloat-types.h b/include/fpu/softfloat-types.h
index 2aae6a89b1..bee576e0fd 100644
--- a/include/fpu/softfloat-types.h
+++ b/include/fpu/softfloat-types.h
@@ -147,6 +147,7 @@ enum {
 
 enum {
     float_flag_invalid   =  1,
+    float_flag_rounded   =  2,
     float_flag_divbyzero =  4,
     float_flag_overflow  =  8,
     float_flag_underflow = 16,
-- 
2.14.3 (Apple Git-98)


