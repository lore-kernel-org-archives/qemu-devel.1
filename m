Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB070C4363D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 15:23:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44DF520878
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 15:23:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s8V/9v2c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44DF520878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38040 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLpZH-00031g-EL
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 11:23:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59832)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kLpWx-000196-1n
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 11:21:03 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435]:39080)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kLpWv-0005Rc-4V
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 11:21:02 -0400
Received: by mail-pf1-x435.google.com with SMTP id n14so3504978pff.6
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2020 08:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=3yQCWJz2XvIuWxIxwKUVSmwsGHFnvzDWcrT0q0novuc=;
 b=s8V/9v2c+fxdUT7wzmHcNArfgaI6fis0aoSnwOCIHhHE2VHpQEll+Kh725N7WdJek1
 /w7qyKIWtpWFoHC1gCul7lUc9WML3zQ/8u2pm/fKyMObcXweGaf9in6dFcSR00GDpk1V
 dbmRwlE8rDiWvbnR36RFG5GRsd4fwjwxdCEXvGUAoxe/0cZVpoXIa81tp96lBiWZ5G5E
 FtfH9WO6+zw+XWjcQmsWklseuh1oBAEt6M5d+6M5p8nHNzVd4c1zIyIby09iJuLoGYYH
 zbFZcsbvd3xr7ShpKv3ZPB1DHegpR9Z7sy6LJEgpoa23uA7CTIGGA3JdoYBQ2Mz/JQ0l
 x15g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=3yQCWJz2XvIuWxIxwKUVSmwsGHFnvzDWcrT0q0novuc=;
 b=lnFqaswhbRGeXj8d/KVMa3GogZ0ZKcdADMPBVr1NCiXVUCDwu3TWD1sJ5vmoTpNZKZ
 e6+ryGOhcDeq4p1U2NRVHUn7c6vdFNe3zc7F1XXnFvEhBqJOunA7etkRuMYlnVbQeiKc
 87w9Ubt5i3s/jfhvR3qTZrhwWNjWnY16MIK/Imxxk44vpUYIhs5GODPOc6dCYluFjFE6
 bmQLOpT6vJ7m2DoWfL4L8+pDcH5hU3Gj4DsWMWaQpq39GiegPB+zuL3x8fI+nmC2nQuI
 C+8lxGL0OEuFTwuxltiNf7PwcY/TBE9vXP3pd3HNxQNe3RzSgsV3j20gfwH8rz64kEqE
 7wPw==
X-Gm-Message-State: AOAM5317YdnFUNlEn4Advm9HDFW6hgXpV4w2sylXnhXsDEf1M1SILqdA
 m0YwZFnej+vihfamJMOhLacnZa8MqlOodg==
X-Google-Smtp-Source: ABdhPJymvICOJtSEwIcHtiLNPY3X5CxysTpja1ByzlGLTOg3cA3KB/KkLLhaE6YLlIKj63Nd9N66Mw==
X-Received: by 2002:a17:902:309:b029:d1:e5e7:ca3f with SMTP id
 9-20020a1709020309b02900d1e5e7ca3fmr5065160pld.43.1601047259306; 
 Fri, 25 Sep 2020 08:20:59 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id a5sm2717859pgk.13.2020.09.25.08.20.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2020 08:20:58 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 07/10] softfloat: Use x86_64 assembly for {add, sub}{192,
 256}
Date: Fri, 25 Sep 2020 08:20:44 -0700
Message-Id: <20200925152047.709901-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200925152047.709901-1-richard.henderson@linaro.org>
References: <20200925152047.709901-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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
 fpu/softfloat.c                | 29 +++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+), 2 deletions(-)

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
index 49de31fec2..54d0b210ac 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -7340,6 +7340,15 @@ static inline void shift256RightJamming(UInt256 *p, unsigned count)
 /* R = A - B */
 static void sub256(UInt256 *r, UInt256 *a, UInt256 *b)
 {
+#if defined(__x86_64__)
+    asm("sub %7, %3\n\t"
+        "sbb %6, %2\n\t"
+        "sbb %5, %1\n\t"
+        "sbb %4, %0"
+        : "=&r"(r->w[0]), "=&r"(r->w[1]), "=&r"(r->w[2]), "=&r"(r->w[3])
+        : "rme"(b->w[0]), "rme"(b->w[1]), "rme"(b->w[2]), "rme"(b->w[3]),
+            "0"(a->w[0]),   "1"(a->w[1]),   "2"(a->w[2]),   "3"(a->w[3]));
+#else
     bool borrow = false;
 
     for (int i = 3; i >= 0; --i) {
@@ -7355,11 +7364,21 @@ static void sub256(UInt256 *r, UInt256 *a, UInt256 *b)
         }
         r->w[i] = rt;
     }
+#endif
 }
 
 /* A = -A */
 static void neg256(UInt256 *a)
 {
+#if defined(__x86_64__)
+    asm("negq %3\n\t"
+        "sbb %6, %2\n\t"
+        "sbb %5, %1\n\t"
+        "sbb %4, %0"
+        : "=&r"(a->w[0]), "=&r"(a->w[1]), "=&r"(a->w[2]), "+rm"(a->w[3])
+        : "rme"(a->w[0]), "rme"(a->w[1]), "rme"(a->w[2]),
+          "0"(0), "1"(0), "2"(0));
+#else
     /*
      * Recall that -X - 1 = ~X, and that since this is negation,
      * once we find a non-zero number, all subsequent words will
@@ -7388,11 +7407,20 @@ static void neg256(UInt256 *a)
     a->w[1] = ~a->w[1];
  not0:
     a->w[0] = ~a->w[0];
+#endif
 }
 
 /* A += B */
 static void add256(UInt256 *a, UInt256 *b)
 {
+#if defined(__x86_64__)
+    asm("add %7, %3\n\t"
+        "adc %6, %2\n\t"
+        "adc %5, %1\n\t"
+        "adc %4, %0"
+        :  "+r"(a->w[0]),  "+r"(a->w[1]),  "+r"(a->w[2]),  "+r"(a->w[3])
+        : "rme"(b->w[0]), "rme"(b->w[1]), "rme"(b->w[2]), "rme"(b->w[3]));
+#else
     bool carry = false;
 
     for (int i = 3; i >= 0; --i) {
@@ -7407,6 +7435,7 @@ static void add256(UInt256 *a, UInt256 *b)
         }
         a->w[i] = at;
     }
+#endif
 }
 
 float128 float128_muladd(float128 a_f, float128 b_f, float128 c_f,
-- 
2.25.1


