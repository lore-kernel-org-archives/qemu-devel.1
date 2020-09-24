Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3733DC4727E
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 01:28:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C56E021D20
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 01:28:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PjaM2p2I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C56E021D20
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46084 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLG3T-0001GZ-Mx
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 21:28:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43800)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kLG0T-0004yX-PB
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 21:25:10 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:42792)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kLG0Q-0005iB-UE
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 21:25:09 -0400
Received: by mail-pf1-x442.google.com with SMTP id d6so822808pfn.9
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2020 18:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Zem0wYaQsDtFgn41N8malHR+nZOq/vMa+XbyiM3d1r8=;
 b=PjaM2p2I4+bC1TbXtRb/XoTetyId2RQ2/oMO+rBe1TfIGvnJQkBPM4PKpES13uxfER
 PPzbr8tpePMYVYz67onJHEUxH9fE0i6hS4X95U7BpZCFwEyiQu1liA+vvZ0cbqjFdpDA
 otRVX+pLl3t/TauomaOzxpYsjrLLFt/GAx94QUnyqXCPJd8EfJPkOnEGbxdnRlWJexwm
 jEeiAklfL/21Xi5559ONx1J772y92kJOrjBoQp+y12wLfhYZ8dRNcaLjWrqNqQxY2/6n
 F034KBvNc9AGWUuggNS+1s+D2cpbZWSRBabECiZGSw9t/XzqDiz2SGrJREzXL8RXBQC1
 kvyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Zem0wYaQsDtFgn41N8malHR+nZOq/vMa+XbyiM3d1r8=;
 b=UwohB9DTolBgli7LEAoZGeU/+jthVabZ3hBAn/EuQPXBDwDbwILLT4u0/vqhfE6K+E
 VuJPWQ5sVLxli9BsjlhxkZDrYa+OHejSlirXGMB30aA9UyNZ6nCrrvrntL5HtDLdMNZI
 aKacnJgaBc3SMh89adUXkvOYken1hi75NGuao1g7a0Pkzp/15UokPUGOhRBDEf8H/rju
 NoynFPC98KRY3FUb2At2eKF92/ZEFF8uceOMfGcRN1UFfy1dH8LwcfEm3WaZTZglJrUB
 Z3AbgnYygPBiov9Ua7gMwq5KVgyyAO4lMuZppeIQyb6ZY8jyclC2GF41x6BN3YxUlxeV
 3S/A==
X-Gm-Message-State: AOAM533+tZfcKzAnKepto4mkyy3JPee8sUNTMesFLLeLY2HMewbh2/Pb
 C/9J7uzarm24EvS46NPP/OxnY4uTnjVboA==
X-Google-Smtp-Source: ABdhPJyKF/A2/Y9FTAVuEIVGg2nHn3VaP7wnFq8+u2dJRbsZUZvXYZXN0GbYrItN9co87f4zcbQbxA==
X-Received: by 2002:a65:5c8b:: with SMTP id a11mr1951021pgt.272.1600910704930; 
 Wed, 23 Sep 2020 18:25:04 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id k27sm938432pgm.29.2020.09.23.18.25.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2020 18:25:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 8/8] softfloat: Use aarch64 assembly for {add,sub}{192,256}
Date: Wed, 23 Sep 2020 18:24:53 -0700
Message-Id: <20200924012453.659757-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200924012453.659757-1-richard.henderson@linaro.org>
References: <20200924012453.659757-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::442;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x442.google.com
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
 include/fpu/softfloat-macros.h | 14 ++++++++++++++
 fpu/softfloat.c                | 25 +++++++++++++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/include/fpu/softfloat-macros.h b/include/fpu/softfloat-macros.h
index 99fa124e56..969a486fd2 100644
--- a/include/fpu/softfloat-macros.h
+++ b/include/fpu/softfloat-macros.h
@@ -442,6 +442,13 @@ static inline void
         "adc %3, %0"
         : "=&r"(*z0Ptr), "=&r"(*z1Ptr), "=&r"(*z2Ptr)
         : "rm"(b0), "rm"(b1), "rm"(b2), "0"(a0), "1"(a1), "2"(a2));
+#elif defined(__aarch64__)
+    asm("adds %2, %x5, %x8\n\t"
+        "adcs %1, %x4, %x7\n\t"
+        "adc  %0, %x3, %x6"
+        : "=&r"(*z0Ptr), "=&r"(*z1Ptr), "=&r"(*z2Ptr)
+        : "rZ"(a0), "rZ"(a1), "rZ"(a2), "rZ"(b0), "rZ"(b1), "rZ"(b2)
+        : "cc");
 #else
     uint64_t z0, z1, z2;
     int8_t carry0, carry1;
@@ -507,6 +514,13 @@ static inline void
         "sbb %3, %0"
         : "=&r"(*z0Ptr), "=&r"(*z1Ptr), "=&r"(*z2Ptr)
         : "rm"(b0), "rm"(b1), "rm"(b2), "0"(a0), "1"(a1), "2"(a2));
+#elif defined(__aarch64__)
+    asm("subs %2, %x5, %x8\n\t"
+        "sbcs %1, %x4, %x7\n\t"
+        "sbc  %0, %x3, %x6"
+        : "=&r"(*z0Ptr), "=&r"(*z1Ptr), "=&r"(*z2Ptr)
+        : "rZ"(a0), "rZ"(a1), "rZ"(a2), "rZ"(b0), "rZ"(b1), "rZ"(b2)
+        : "cc");
 #else
     uint64_t z0, z1, z2;
     int8_t borrow0, borrow1;
diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index d8e5d90fd7..1601095d60 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -7305,6 +7305,16 @@ static void sub256(uint64_t r[4], uint64_t a[4], uint64_t b[4])
         : "=&r"(r[0]), "=&r"(r[1]), "=&r"(r[2]), "=&r"(r[3])
         : "rme"(b[0]), "rme"(b[1]), "rme"(b[2]), "rme"(b[3]),
             "0"(a[0]),   "1"(a[1]),   "2"(a[2]),   "3"(a[3]));
+#elif defined(__aarch64__)
+    asm("subs %[r3], %x[a3], %x[b3]\n\t"
+        "sbcs %[r2], %x[a2], %x[b2]\n\t"
+        "sbcs %[r1], %x[a1], %x[b1]\n\t"
+        "sbc  %[r0], %x[a0], %x[b0]"
+        : [r0] "=&r"(r[0]), [r1] "=&r"(r[1]),
+          [r2] "=&r"(r[2]), [r3] "=&r"(r[3])
+        : [a0] "rZ"(a[0]), [a1] "rZ"(a[1]), [a2] "rZ"(a[2]), [a3] "rZ"(a[3]),
+          [b0] "rZ"(b[0]), [b1] "rZ"(b[1]), [b2] "rZ"(b[2]), [b3] "rZ"(b[3])
+        : "cc");
 #else
     bool borrow = false;
 
@@ -7330,6 +7340,13 @@ static void neg256(uint64_t a[4])
         "sbb %4, %0"
         : "=&r"(a[0]), "=&r"(a[1]), "=&r"(a[2]), "+rm"(a[3])
         : "rme"(a[0]), "rme"(a[1]), "rme"(a[2]), "0"(0), "1"(0), "2"(0));
+#elif defined(__aarch64__)
+    asm("negs %3, %3\n\t"
+        "ngcs %2, %2\n\t"
+        "ngcs %1, %1\n\t"
+        "ngc  %0, %0"
+        : "+r"(a[0]), "+r"(a[1]), "+r"(a[2]), "+r"(a[3])
+        : : "cc");
 #else
     a[3] = -a[3];
     if (likely(a[3])) {
@@ -7364,6 +7381,14 @@ static void add256(uint64_t a[4], uint64_t b[4])
         "adc %4, %0"
         :  "+r"(a[0]),  "+r"(a[1]),  "+r"(a[2]),  "+r"(a[3])
         : "rme"(b[0]), "rme"(b[1]), "rme"(b[2]), "rme"(b[3]));
+#elif defined(__aarch64__)
+    asm("adds %3, %3, %x7\n\t"
+        "adcs %2, %2, %x6\n\t"
+        "adcs %1, %1, %x5\n\t"
+        "adc  %0, %0, %x4"
+        : "+r"(a[0]), "+r"(a[1]), "+r"(a[2]), "+r"(a[3])
+        : "rZ"(b[0]), "rZ"(b[1]), "rZ"(b[2]), "rZ"(b[3])
+        : "cc");
 #else
     bool carry = false;
 
-- 
2.25.1


