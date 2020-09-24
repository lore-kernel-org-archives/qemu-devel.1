Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AF3DC4363D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 01:31:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D63AF208E4
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 01:31:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UihMbbKm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D63AF208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52936 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLG6M-0004KF-VU
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 21:31:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43798)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kLG0S-0004y9-Kw
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 21:25:09 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:39721)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kLG0P-0005i5-FD
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 21:25:08 -0400
Received: by mail-pl1-x644.google.com with SMTP id y17so736495plb.6
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2020 18:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=vy0IYhtMJlbLw9gdq1ziCf1I+pv44OHn8TCjYGrXMYs=;
 b=UihMbbKmm/b21VcXJg+9EvqbtQRAsYWblMSbvgFCoNSGweKfBAPSqrMjTm5oUY7piF
 SvOvafKWV87UtJ4BOvjwcXsvBYbxfILQHIjBLe9dDBUX+Dbu3nVHjKo1A7u6LnE96TBv
 hIWa9aHdM1iI/lbDu0JPk20KrqK1LfnCbSqIkheaULMMfRoqIZXs3jHQtvhWM314zkL0
 9Y57N81tqNeHc3SAqmyycZS/JecXttJ7xhZCEPfUXSLhc5SaBg5Sc1yYQ/Y6i6o9UNFg
 AHwGkIyZuS7O2qLGFSmD3IMfFEn3lHaBIbexxCgb7C5hQYlo0hMWWYUBDIIpMwvSoczI
 4pcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=vy0IYhtMJlbLw9gdq1ziCf1I+pv44OHn8TCjYGrXMYs=;
 b=A6tfEAGkNJaTlSjN1NB/MAeejXu6Ge3x6EWSd2j+sPobl0WHgeYGW2M/L/TxRw/YIX
 25+RAe9DP/yw1lnpnqRhUyjtMZM3OLIZ+1zwsirRnd2Cj+K4US1amQfpEyr9kmHYqsMD
 lGKARazVsN1WK2DF9G0Bos1Zz+WM2hH1SGGm9ioqbgF9jnv/OI/Xt/8R4uV18mK1kcjz
 0H69kQOX4xOxGfR+I8CWdmIy2RC1McIu4GiB5GY/khMB9EfCB0z3T4nVjJ0q9sA5f25N
 7ngXe+DZ1aIc7hJ1EvozVxPKEZ+wj+QxAlfrzLwwJk8d4a5wlvPW+u+Ur/WXpg+2pnqG
 us9g==
X-Gm-Message-State: AOAM532UIXMuWX+NVOgZlRClpLfIs2fu/6MsvNlsauUF6y2dTWf0BQsi
 9al9KxGGlRMsVrIGK5DSLM62oFhs4QRViQ==
X-Google-Smtp-Source: ABdhPJwRJzZPjBJvPeyHZfwKgSq3UYDtXNDHXZWJT1PnmU9YsF8X0D0dilH4uEgGXjM2PYxTn9R0Fg==
X-Received: by 2002:a17:902:ff07:b029:d1:e5fa:aa1d with SMTP id
 f7-20020a170902ff07b02900d1e5faaa1dmr2281500plj.84.1600910703742; 
 Wed, 23 Sep 2020 18:25:03 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id k27sm938432pgm.29.2020.09.23.18.25.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2020 18:25:03 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 7/8] softfloat: Use x86_64 assembly for {add,sub}{192,256}
Date: Wed, 23 Sep 2020 18:24:52 -0700
Message-Id: <20200924012453.659757-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200924012453.659757-1-richard.henderson@linaro.org>
References: <20200924012453.659757-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::644;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x644.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: bharata@linux.ibm.com, alex.bennee@linaro.org, david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The compiler cannot chain more than two additions together.
Use inline assembly for 3 or 4 additions.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/fpu/softfloat-macros.h | 18 ++++++++++++++++--
 fpu/softfloat.c                | 28 ++++++++++++++++++++++++++++
 2 files changed, 44 insertions(+), 2 deletions(-)

diff --git a/include/fpu/softfloat-macros.h b/include/fpu/softfloat-macros.h
index 95d88d05b8..99fa124e56 100644
--- a/include/fpu/softfloat-macros.h
+++ b/include/fpu/softfloat-macros.h
@@ -436,6 +436,13 @@ static inline void
      uint64_t *z2Ptr
  )
 {
+#ifdef __x86_64__
+    asm("add %5, %2\n\t"
+        "adc %4, %1\n\t"
+        "adc %3, %0"
+        : "=&r"(*z0Ptr), "=&r"(*z1Ptr), "=&r"(*z2Ptr)
+        : "rm"(b0), "rm"(b1), "rm"(b2), "0"(a0), "1"(a1), "2"(a2));
+#else
     uint64_t z0, z1, z2;
     int8_t carry0, carry1;
 
@@ -450,7 +457,7 @@ static inline void
     *z2Ptr = z2;
     *z1Ptr = z1;
     *z0Ptr = z0;
-
+#endif
 }
 
 /*----------------------------------------------------------------------------
@@ -494,6 +501,13 @@ static inline void
      uint64_t *z2Ptr
  )
 {
+#ifdef __x86_64__
+    asm("sub %5, %2\n\t"
+        "sbb %4, %1\n\t"
+        "sbb %3, %0"
+        : "=&r"(*z0Ptr), "=&r"(*z1Ptr), "=&r"(*z2Ptr)
+        : "rm"(b0), "rm"(b1), "rm"(b2), "0"(a0), "1"(a1), "2"(a2));
+#else
     uint64_t z0, z1, z2;
     int8_t borrow0, borrow1;
 
@@ -508,7 +522,7 @@ static inline void
     *z2Ptr = z2;
     *z1Ptr = z1;
     *z0Ptr = z0;
-
+#endif
 }
 
 /*----------------------------------------------------------------------------
diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 5b714fbd82..d8e5d90fd7 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -7297,6 +7297,15 @@ static void shift256RightJamming(uint64_t p[4], int count)
 /* R = A - B */
 static void sub256(uint64_t r[4], uint64_t a[4], uint64_t b[4])
 {
+#if defined(__x86_64__)
+    asm("sub %7, %3\n\t"
+        "sbb %6, %2\n\t"
+        "sbb %5, %1\n\t"
+        "sbb %4, %0"
+        : "=&r"(r[0]), "=&r"(r[1]), "=&r"(r[2]), "=&r"(r[3])
+        : "rme"(b[0]), "rme"(b[1]), "rme"(b[2]), "rme"(b[3]),
+            "0"(a[0]),   "1"(a[1]),   "2"(a[2]),   "3"(a[3]));
+#else
     bool borrow = false;
 
     for (int i = 3; i >= 0; --i) {
@@ -7308,11 +7317,20 @@ static void sub256(uint64_t r[4], uint64_t a[4], uint64_t b[4])
             r[i] = a[i] - b[i];
         }
     }
+#endif
 }
 
 /* A = -A */
 static void neg256(uint64_t a[4])
 {
+#if defined(__x86_64__)
+    asm("negq %3\n\t"
+        "sbb %6, %2\n\t"
+        "sbb %5, %1\n\t"
+        "sbb %4, %0"
+        : "=&r"(a[0]), "=&r"(a[1]), "=&r"(a[2]), "+rm"(a[3])
+        : "rme"(a[0]), "rme"(a[1]), "rme"(a[2]), "0"(0), "1"(0), "2"(0));
+#else
     a[3] = -a[3];
     if (likely(a[3])) {
         goto not2;
@@ -7333,11 +7351,20 @@ static void neg256(uint64_t a[4])
     a[1] = ~a[1];
  not0:
     a[0] = ~a[0];
+#endif
 }
 
 /* A += B */
 static void add256(uint64_t a[4], uint64_t b[4])
 {
+#if defined(__x86_64__)
+    asm("add %7, %3\n\t"
+        "adc %6, %2\n\t"
+        "adc %5, %1\n\t"
+        "adc %4, %0"
+        :  "+r"(a[0]),  "+r"(a[1]),  "+r"(a[2]),  "+r"(a[3])
+        : "rme"(b[0]), "rme"(b[1]), "rme"(b[2]), "rme"(b[3]));
+#else
     bool carry = false;
 
     for (int i = 3; i >= 0; --i) {
@@ -7350,6 +7377,7 @@ static void add256(uint64_t a[4], uint64_t b[4])
         }
         a[i] = t;
     }
+#endif
 }
 
 float128 float128_muladd(float128 a_f, float128 b_f, float128 c_f,
-- 
2.25.1


