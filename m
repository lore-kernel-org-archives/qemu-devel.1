Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10355C0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 22:12:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C68C520658
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 22:11:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YxaMQ02W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C68C520658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49906 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDxxn-00016Q-2i
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 18:11:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60708)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1jDxsM-0001Tp-Vj
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 18:06:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1jDxsL-00023U-Cw
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 18:06:22 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435]:42826)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1jDxsL-0001pd-47
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 18:06:21 -0400
Received: by mail-wr1-x435.google.com with SMTP id v11so23241279wrm.9
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 15:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=yHenNl+eoCHqySp7TFHGIkZXlfOPZh2pvlPhF62G69M=;
 b=YxaMQ02WosHLTgreqm6/t9zgsp1IB2Pe5ZRbyK6ql2PlFAsnEZxa20l1NuZhKSZh1A
 xF/R1FlTaROLpl+oMlUwZCJCbvD2fBz7rH2B7/vWwyCSB9uwP7VpAk8K6ESwsfHq5DUv
 uKiPZQoPPeO2ngKpPcibY1aftUGgt4vzo7JyNkU8f0mfWjHnnl58Qd/P/7vNP+ElQidw
 ET0awzI38F6qNaG9NyfwjiUWYa9Js0a5H8jiVvI9IftMsuhoUTnH53NBTPcdUP6DPG2I
 H/eG26PbHDtGfmjEpuroXbfC+ORnqTGO53KN0ELlhuQGXLHa4CD7ENXuk2EB5+FfsoSV
 /LfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=yHenNl+eoCHqySp7TFHGIkZXlfOPZh2pvlPhF62G69M=;
 b=PisY/Xo1YR9V4E9RR4FNzREQRpWfilxTWFK9Of5Qp1v7yZoycL4B6Qjil/1e3jFh3m
 xC1dYzFj2tXvBLXyw7vT3cghhtqWJMuKIceJ18yHfbXlOx7w0/Q7KqZckBVlV3BI6p2Y
 dlctjRFsoptf0qxxGJ8aOxBVDE2zIZikuoTfdfuNSRz6+AC6mMWR4JjmpbWwbCS+R81I
 hGdNATWLdH9qDd+VZSeKgXJ9k4BvHZFjCZWepuUL1rv1lK2u95gQTg8STBMPWI5+CWKb
 Gv6mMcSHINXl4yZM1AaPPUQlgngOsmTk+SvWY6B1edIjj8bsRPcTS6M8Pc0d36V8065m
 liUA==
X-Gm-Message-State: ANhLgQ3G4WhrjyZvONjAJbtYJ/y6X9WDKtN6kjyZHH0RNme8Rnf4TaWq
 NlrCsxxlzCIna1LZ6+AbTMjJNhBp
X-Google-Smtp-Source: ADFU+vupbL0u/gcN55t2Mhd1GUPvG+PkD4Rwv2ImnqgyjiF0E0DhPBmTX/gzX9eyJ415Fc9f7MceeQ==
X-Received: by 2002:a5d:4d86:: with SMTP id b6mr1466946wru.253.1584396378493; 
 Mon, 16 Mar 2020 15:06:18 -0700 (PDT)
Received: from 640k.lan ([93.56.174.5])
 by smtp.gmail.com with ESMTPSA id v10sm1369392wmh.17.2020.03.16.15.06.17
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 16 Mar 2020 15:06:17 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 06/61] util: add util function buffer_zero_avx512()
Date: Mon, 16 Mar 2020 23:06:15 +0100
Message-Id: <1584396375-31278-2-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1584396375-31278-1-git-send-email-pbonzini@redhat.com>
References: <1584396375-31278-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::435
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
Cc: Robert Hoo <robert.hu@linux.intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Robert Hoo <robert.hu@linux.intel.com>

And intialize buffer_is_zero() with it, when Intel AVX512F is
available on host.

This function utilizes Intel AVX512 fundamental instructions which
is faster than its implementation with AVX2 (in my unit test, with
4K buffer, on CascadeLake SP, ~36% faster, buffer_zero_avx512() V.S.
buffer_zero_avx2()).

Signed-off-by: Robert Hoo <robert.hu@linux.intel.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/qemu/cpuid.h |  3 +++
 util/bufferiszero.c  | 71 ++++++++++++++++++++++++++++++++++++++++++++--------
 2 files changed, 64 insertions(+), 10 deletions(-)

diff --git a/include/qemu/cpuid.h b/include/qemu/cpuid.h
index 6930170..09fc245 100644
--- a/include/qemu/cpuid.h
+++ b/include/qemu/cpuid.h
@@ -45,6 +45,9 @@
 #ifndef bit_AVX2
 #define bit_AVX2        (1 << 5)
 #endif
+#ifndef bit_AVX512F
+#define bit_AVX512F        (1 << 16)
+#endif
 #ifndef bit_BMI2
 #define bit_BMI2        (1 << 8)
 #endif
diff --git a/util/bufferiszero.c b/util/bufferiszero.c
index bfb2605..6639035 100644
--- a/util/bufferiszero.c
+++ b/util/bufferiszero.c
@@ -63,11 +63,11 @@ buffer_zero_int(const void *buf, size_t len)
     }
 }
 
-#if defined(CONFIG_AVX2_OPT) || defined(__SSE2__)
+#if defined(CONFIG_AVX512F_OPT) || defined(CONFIG_AVX2_OPT) || defined(__SSE2__)
 /* Do not use push_options pragmas unnecessarily, because clang
  * does not support them.
  */
-#ifdef CONFIG_AVX2_OPT
+#if defined(CONFIG_AVX512F_OPT) || defined(CONFIG_AVX2_OPT)
 #pragma GCC push_options
 #pragma GCC target("sse2")
 #endif
@@ -104,7 +104,7 @@ buffer_zero_sse2(const void *buf, size_t len)
 
     return _mm_movemask_epi8(_mm_cmpeq_epi8(t, zero)) == 0xFFFF;
 }
-#ifdef CONFIG_AVX2_OPT
+#if defined(CONFIG_AVX512F_OPT) || defined(CONFIG_AVX2_OPT)
 #pragma GCC pop_options
 #endif
 
@@ -187,18 +187,54 @@ buffer_zero_avx2(const void *buf, size_t len)
 #pragma GCC pop_options
 #endif /* CONFIG_AVX2_OPT */
 
+#ifdef CONFIG_AVX512F_OPT
+#pragma GCC push_options
+#pragma GCC target("avx512f")
+#include <immintrin.h>
+
+static bool
+buffer_zero_avx512(const void *buf, size_t len)
+{
+    /* Begin with an unaligned head of 64 bytes.  */
+    __m512i t = _mm512_loadu_si512(buf);
+    __m512i *p = (__m512i *)(((uintptr_t)buf + 5 * 64) & -64);
+    __m512i *e = (__m512i *)(((uintptr_t)buf + len) & -64);
+
+    /* Loop over 64-byte aligned blocks of 256.  */
+    while (p <= e) {
+        __builtin_prefetch(p);
+        if (unlikely(_mm512_test_epi64_mask(t, t))) {
+            return false;
+        }
+        t = p[-4] | p[-3] | p[-2] | p[-1];
+        p += 4;
+    }
+
+    t |= _mm512_loadu_si512(buf + len - 4 * 64);
+    t |= _mm512_loadu_si512(buf + len - 3 * 64);
+    t |= _mm512_loadu_si512(buf + len - 2 * 64);
+    t |= _mm512_loadu_si512(buf + len - 1 * 64);
+
+    return !_mm512_test_epi64_mask(t, t);
+
+}
+#pragma GCC pop_options
+#endif
+
+
 /* Note that for test_buffer_is_zero_next_accel, the most preferred
  * ISA must have the least significant bit.
  */
-#define CACHE_AVX2    1
-#define CACHE_SSE4    2
-#define CACHE_SSE2    4
+#define CACHE_AVX512F 1
+#define CACHE_AVX2    2
+#define CACHE_SSE4    4
+#define CACHE_SSE2    8
 
 /* Make sure that these variables are appropriately initialized when
  * SSE2 is enabled on the compiler command-line, but the compiler is
  * too old to support CONFIG_AVX2_OPT.
  */
-#ifdef CONFIG_AVX2_OPT
+#if defined(CONFIG_AVX512F_OPT) || defined(CONFIG_AVX2_OPT)
 # define INIT_CACHE 0
 # define INIT_ACCEL buffer_zero_int
 #else
@@ -211,6 +247,7 @@ buffer_zero_avx2(const void *buf, size_t len)
 
 static unsigned cpuid_cache = INIT_CACHE;
 static bool (*buffer_accel)(const void *, size_t) = INIT_ACCEL;
+static int length_to_accel = 64;
 
 static void init_accel(unsigned cache)
 {
@@ -226,10 +263,16 @@ static void init_accel(unsigned cache)
         fn = buffer_zero_avx2;
     }
 #endif
+#ifdef CONFIG_AVX512F_OPT
+    if (cache & CACHE_AVX512F) {
+        fn = buffer_zero_avx512;
+        length_to_accel = 256;
+    }
+#endif
     buffer_accel = fn;
 }
 
-#ifdef CONFIG_AVX2_OPT
+#if defined(CONFIG_AVX512F_OPT) || defined(CONFIG_AVX2_OPT)
 #include "qemu/cpuid.h"
 
 static void __attribute__((constructor)) init_cpuid_cache(void)
@@ -252,9 +295,17 @@ static void __attribute__((constructor)) init_cpuid_cache(void)
             int bv;
             __asm("xgetbv" : "=a"(bv), "=d"(d) : "c"(0));
             __cpuid_count(7, 0, a, b, c, d);
-            if ((bv & 6) == 6 && (b & bit_AVX2)) {
+            if ((bv & 0x6) == 0x6 && (b & bit_AVX2)) {
                 cache |= CACHE_AVX2;
             }
+            /* 0xe6:
+            *  XCR0[7:5] = 111b (OPMASK state, upper 256-bit of ZMM0-ZMM15
+            *                    and ZMM16-ZMM31 state are enabled by OS)
+            *  XCR0[2:1] = 11b (XMM state and YMM state are enabled by OS)
+            */
+            if ((bv & 0xe6) == 0xe6 && (b & bit_AVX512F)) {
+                cache |= CACHE_AVX512F;
+            }
         }
     }
     cpuid_cache = cache;
@@ -277,7 +328,7 @@ bool test_buffer_is_zero_next_accel(void)
 
 static bool select_accel_fn(const void *buf, size_t len)
 {
-    if (likely(len >= 64)) {
+    if (likely(len >= length_to_accel)) {
         return buffer_accel(buf, len);
     }
     return buffer_zero_int(buf, len);
-- 
1.8.3.1

