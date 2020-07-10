Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6312EC433E4
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 13:05:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F54320748
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 13:05:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="MTY70OgS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F54320748
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45830 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtsik-0000xO-GS
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 09:05:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39036)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1jtqg1-0006JL-FS
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 06:54:45 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031]:54884)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1jtqfz-00073g-Mg
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 06:54:45 -0400
Received: by mail-pj1-x1031.google.com with SMTP id mn17so2457115pjb.4
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2020 03:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=dzueMtfSoUxoNXtog0oLoApUQLNpkmASka89C67kCXk=;
 b=MTY70OgSRr940IwbKL588JtbnzCDe2h5Fn99+eu3iJE9kd5+7zHs5JXgZpGNR9fY9Z
 P3fsk2Vd/hyqQJGYXvSOA/yYgtFHsVVeL6SywSiN0hNc8irmMzNbR1tdBkY+OVYoYpqI
 Nxrqj6enwaWyRrJpikruGyexWlcQRaf8oOwFSl+PNnPadiPbbMXCY4HxulBNPUsXXT3g
 i07HhRnnc6fVhPVO8Ed+GZi+JriCm9epfilSFrE9Fb7JgZUTXgTNt5EkQ5WuXSNF7V/r
 rEf0vT3rRv91kYOfy7pSksVvTmkkk3esGDwIgUihGDuBBf4/I0oU0Mfk/z1kIb+DsK5x
 IzRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=dzueMtfSoUxoNXtog0oLoApUQLNpkmASka89C67kCXk=;
 b=Nv42nmf/OU4WXSfGtW8n0v+3hI3Uxwpn3HDQ9MIEEDqym8LFDYSFpblf/v7nQx1Ogg
 24s974QsWMmKysAihGSULUDLyW/eX4HSg6nLUP4OqndalYEaQ2ybM66SeXE4U1hYiQC7
 WNUnm3ldyq6voRvO8AzYVy2NLcxwriGX9RCcrBWYl1PutQKwBjGfacaDUJMpio9NxhUD
 itEjxwcVsJnNzBwsXNTPkKomvQgbW9L1Crf5lPnlLh7jM1N9jx6brv9I6HtLLlbFgM+W
 EA2czxRWkKpbPuduGlp3ECDAYV7+ksDHXd/oml2nOcH1uOhUr4CE6HaCh/GoQEjmHlO3
 yvoQ==
X-Gm-Message-State: AOAM533/J9sxtUH9Ras5uO+DH/3ajSN47pZWFgMW2Qwv6ilQ6kRLRKxY
 VltCM5M7xrLMKfdB8z0DMvmzE8jN0uEiCg==
X-Google-Smtp-Source: ABdhPJzCPhX2gxu6VpHm4J288zp+VDKNRJKoDyV/vj+v18DoXpk15oGDuzgvdAe3DdAjx4jr7biVaA==
X-Received: by 2002:a17:90b:3684:: with SMTP id
 mj4mr5255245pjb.66.1594378482386; 
 Fri, 10 Jul 2020 03:54:42 -0700 (PDT)
Received: from frankchang-ThinkPad-T490.internal.sifive.com
 (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
 by smtp.gmail.com with ESMTPSA id r191sm5519406pfr.181.2020.07.10.03.54.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2020 03:54:42 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [RFC 62/65] fpu: add api to handle alternative sNaN propagation
Date: Fri, 10 Jul 2020 18:49:16 +0800
Message-Id: <20200710104920.13550-63-frank.chang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200710104920.13550-1-frank.chang@sifive.com>
References: <20200710104920.13550-1-frank.chang@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=frank.chang@sifive.com; helo=mail-pj1-x1031.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 10 Jul 2020 08:57:18 -0400
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
Cc: Frank Chang <frank.chang@sifive.com>,
 Chih-Min Chao <chihmin.chao@sifive.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Chih-Min Chao <chihmin.chao@sifive.com>

Signed-off-by: Chih-Min Chao <chihmin.chao@sifive.com>
Signed-off-by: Frank Chang <frank.chang@sifive.com>
---
 fpu/softfloat.c         | 68 +++++++++++++++++++++++++----------------
 include/fpu/softfloat.h |  6 ++++
 2 files changed, 48 insertions(+), 26 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index fa1c99c03e..028b857167 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -2777,23 +2777,32 @@ float64 uint16_to_float64(uint16_t a, float_status *status)
  * and minNumMag() from the IEEE-754 2008.
  */
 static FloatParts minmax_floats(FloatParts a, FloatParts b, bool ismin,
-                                bool ieee, bool ismag, float_status *s)
+                                bool ieee, bool ismag, bool issnan_prop,
+                                float_status *s)
 {
     if (unlikely(is_nan(a.cls) || is_nan(b.cls))) {
         if (ieee) {
             /* Takes two floating-point values `a' and `b', one of
              * which is a NaN, and returns the appropriate NaN
              * result. If either `a' or `b' is a signaling NaN,
-             * the invalid exception is raised.
+             * the invalid exception is raised but the NaN
+             * propagation is 'shall'.
              */
             if (is_snan(a.cls) || is_snan(b.cls)) {
-                return pick_nan(a, b, s);
-            } else if (is_nan(a.cls) && !is_nan(b.cls)) {
+                if (issnan_prop) {
+                    pick_nan(a, b, s);
+                } else {
+                    return pick_nan(a, b, s);
+                }
+            }
+
+            if (is_nan(a.cls) && !is_nan(b.cls)) {
                 return b;
             } else if (is_nan(b.cls) && !is_nan(a.cls)) {
                 return a;
             }
         }
+
         return pick_nan(a, b, s);
     } else {
         int a_exp, b_exp;
@@ -2847,37 +2856,44 @@ static FloatParts minmax_floats(FloatParts a, FloatParts b, bool ismin,
     }
 }
 
-#define MINMAX(sz, name, ismin, isiee, ismag)                           \
+#define MINMAX(sz, name, ismin, isiee, ismag, issnan_prop)              \
 float ## sz float ## sz ## _ ## name(float ## sz a, float ## sz b,      \
                                      float_status *s)                   \
 {                                                                       \
     FloatParts pa = float ## sz ## _unpack_canonical(a, s);             \
     FloatParts pb = float ## sz ## _unpack_canonical(b, s);             \
-    FloatParts pr = minmax_floats(pa, pb, ismin, isiee, ismag, s);      \
+    FloatParts pr = minmax_floats(pa, pb, ismin, isiee, ismag,          \
+                                  issnan_prop, s);                      \
                                                                         \
     return float ## sz ## _round_pack_canonical(pr, s);                 \
 }
 
-MINMAX(16, min, true, false, false)
-MINMAX(16, minnum, true, true, false)
-MINMAX(16, minnummag, true, true, true)
-MINMAX(16, max, false, false, false)
-MINMAX(16, maxnum, false, true, false)
-MINMAX(16, maxnummag, false, true, true)
-
-MINMAX(32, min, true, false, false)
-MINMAX(32, minnum, true, true, false)
-MINMAX(32, minnummag, true, true, true)
-MINMAX(32, max, false, false, false)
-MINMAX(32, maxnum, false, true, false)
-MINMAX(32, maxnummag, false, true, true)
-
-MINMAX(64, min, true, false, false)
-MINMAX(64, minnum, true, true, false)
-MINMAX(64, minnummag, true, true, true)
-MINMAX(64, max, false, false, false)
-MINMAX(64, maxnum, false, true, false)
-MINMAX(64, maxnummag, false, true, true)
+MINMAX(16, min, true, false, false, false)
+MINMAX(16, minnum, true, true, false, false)
+MINMAX(16, minnum_noprop, true, true, false, true)
+MINMAX(16, minnummag, true, true, true, false)
+MINMAX(16, max, false, false, false, false)
+MINMAX(16, maxnum, false, true, false, false)
+MINMAX(16, maxnum_noprop, false, true, false, true)
+MINMAX(16, maxnummag, false, true, true, false)
+
+MINMAX(32, min, true, false, false, false)
+MINMAX(32, minnum, true, true, false, false)
+MINMAX(32, minnum_noprop, true, true, false, true)
+MINMAX(32, minnummag, true, true, true, false)
+MINMAX(32, max, false, false, false, false)
+MINMAX(32, maxnum, false, true, false, false)
+MINMAX(32, maxnum_noprop, false, true, false, true)
+MINMAX(32, maxnummag, false, true, true, false)
+
+MINMAX(64, min, true, false, false, false)
+MINMAX(64, minnum, true, true, false, false)
+MINMAX(64, minnum_noprop, true, true, false, true)
+MINMAX(64, minnummag, true, true, true, false)
+MINMAX(64, max, false, false, false, false)
+MINMAX(64, maxnum, false, true, false, false)
+MINMAX(64, maxnum_noprop, false, true, false, true)
+MINMAX(64, maxnummag, false, true, true, false)
 
 #undef MINMAX
 
diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat.h
index b0ae8f6295..075c680456 100644
--- a/include/fpu/softfloat.h
+++ b/include/fpu/softfloat.h
@@ -239,6 +239,8 @@ float16 float16_minnum(float16, float16, float_status *status);
 float16 float16_maxnum(float16, float16, float_status *status);
 float16 float16_minnummag(float16, float16, float_status *status);
 float16 float16_maxnummag(float16, float16, float_status *status);
+float16 float16_minnum_noprop(float16, float16, float_status *status);
+float16 float16_maxnum_noprop(float16, float16, float_status *status);
 float16 float16_sqrt(float16, float_status *status);
 FloatRelation float16_compare(float16, float16, float_status *status);
 FloatRelation float16_compare_quiet(float16, float16, float_status *status);
@@ -359,6 +361,8 @@ float32 float32_minnum(float32, float32, float_status *status);
 float32 float32_maxnum(float32, float32, float_status *status);
 float32 float32_minnummag(float32, float32, float_status *status);
 float32 float32_maxnummag(float32, float32, float_status *status);
+float32 float32_minnum_noprop(float32, float32, float_status *status);
+float32 float32_maxnum_noprop(float32, float32, float_status *status);
 bool float32_is_quiet_nan(float32, float_status *status);
 bool float32_is_signaling_nan(float32, float_status *status);
 float32 float32_silence_nan(float32, float_status *status);
@@ -548,6 +552,8 @@ float64 float64_minnum(float64, float64, float_status *status);
 float64 float64_maxnum(float64, float64, float_status *status);
 float64 float64_minnummag(float64, float64, float_status *status);
 float64 float64_maxnummag(float64, float64, float_status *status);
+float64 float64_minnum_noprop(float64, float64, float_status *status);
+float64 float64_maxnum_noprop(float64, float64, float_status *status);
 bool float64_is_quiet_nan(float64 a, float_status *status);
 bool float64_is_signaling_nan(float64, float_status *status);
 float64 float64_silence_nan(float64, float_status *status);
-- 
2.17.1


