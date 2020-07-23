Return-Path: <SRS0=cpkI=BC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B8F0C433E4
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 00:29:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63F382071A
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 00:29:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kXUJEkw8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63F382071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53320 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyP6x-0003va-Nd
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 20:29:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59832)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3XdkYXwMKCnIiSmWeeWbU.SecgUck-TUlUbdedWdk.ehW@flex--scw.bounces.google.com>)
 id 1jyP4r-0001i5-0x
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 20:27:13 -0400
Received: from mail-yb1-xb4a.google.com ([2607:f8b0:4864:20::b4a]:54448)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3XdkYXwMKCnIiSmWeeWbU.SecgUck-TUlUbdedWdk.ehW@flex--scw.bounces.google.com>)
 id 1jyP4p-00035U-Dv
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 20:27:12 -0400
Received: by mail-yb1-xb4a.google.com with SMTP id p22so4475462ybg.21
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2020 17:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=sCOftwdnsJ6da9H2SVH18et2O50tZ5Rzg9ttJkK+/9I=;
 b=kXUJEkw8+OjdOAqCX7Qg80IJeQT41lu2DILBcQHueAtEyIiIO+JC9VcXyz6idzC6kU
 y7DRnOp5x/imhvipbdHJ3M/mpDsZokXhH8PoUMVOsMyW/txeeu/hAHI4Q1LOnKz9xE80
 cpTZMS2JJkgCqetGS/8vWFMRsxyLfosLD50a+hJn6C2f+0TQpmjJmir80hCkBdQi6lu2
 6QO65gKax9fm0IwkFekOLfK+5ZeCEp0EPG6CQQ+voZyG2ZT0ybg1fY1kqSmAUbaVQFyw
 BHhqKAWquTxHjuBL/5VhiAvpYT6+dqQWw58f3d145FnkX/tzhEMWQ3LQteScMTSLpIxv
 2Ykg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=sCOftwdnsJ6da9H2SVH18et2O50tZ5Rzg9ttJkK+/9I=;
 b=uczYfY2PaF8g2c1/ujSOHQKVgGZ69EMfED+XpUmI0TyVOTOUDUHnnlplMU922pzkkB
 +3cXBjoCtanW22C4ePEB9yt2pbfjhvhkUylU2kjfbNln++r9CgsOFL385u7l40Al95nI
 HEctvWY7RCXC4t0302L6dxn6xBpNNs7Qrn4xIliN5CbCBrm0ooTf23UFu5AXOdzbRi6M
 OT1j4CWLISmDp/4excxvoPz/7AacVL7leLJXyVgKnKIiPF0ggNmpqhwbx5lBPwL/D9Dx
 3sehH0E90cTZQ8YwjxW1OiYoHLa2RaeOM61pYw/V18td9O0yz2TAPggyApKCvGkzMHZB
 0LMA==
X-Gm-Message-State: AOAM530q185827yfcI2oJf6JcJhZ1Ja7/wonRcywqOwfTHB2hxdjodeo
 zsHN4nVqhE6f8VV8R3ww2nxuWEI=
X-Google-Smtp-Source: ABdhPJwkjhNqCkLPCALkltPyMGelbhaXcQCxMo4fB5Frc3Dk+AGf9EnCaB8IYyguKmJfN6nB1P3WLbE=
X-Received: by 2002:a25:e708:: with SMTP id e8mr3226850ybh.137.1595464029847; 
 Wed, 22 Jul 2020 17:27:09 -0700 (PDT)
Date: Wed, 22 Jul 2020 17:27:04 -0700
In-Reply-To: <cover.1595463707.git.scw@google.com>
Message-Id: <bf706105addcaa3f48391be8f7e5c09c3b1735ae.1595463707.git.scw@google.com>
Mime-Version: 1.0
References: <cover.1595463707.git.scw@google.com>
X-Mailer: git-send-email 2.28.0.rc0.105.gf9edc3c819-goog
Subject: [PATCH 1/2] configure: avx2 and avx512f detection for clang
From: Shu-Chun Weng <scw@google.com>
To: rth@twiddle.net
Cc: Shu-Chun Weng <scw@google.com>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b4a;
 envelope-from=3XdkYXwMKCnIiSmWeeWbU.SecgUck-TUlUbdedWdk.ehW@flex--scw.bounces.google.com;
 helo=mail-yb1-xb4a.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -105
X-Spam_score: -10.6
X-Spam_bar: ----------
X-Spam_report: (-10.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Since clang does not support "#pragma GCC", the instruction sets are
always disabled. In this change, we

 1. wrap "#pragma GCC" inside "#ifndef __clang__",
 2. only retain them around "#include <{e,i,s}mmintrin.h>" to work
    around gcc bug,
 3. and annotate each function with `__attribute__((target(*)))` which
    is recognized by both gcc and clang.

Signed-off-by: Shu-Chun Weng <scw@google.com>
---
 configure           | 16 ++++++++++++++--
 util/bufferiszero.c | 33 +++++++++++++++++++++++----------
 2 files changed, 37 insertions(+), 12 deletions(-)

diff --git a/configure b/configure
index 4bd80ed507..d9ce3aa5db 100755
--- a/configure
+++ b/configure
@@ -5808,10 +5808,16 @@ fi
 
 if test "$cpuid_h" = "yes" && test "$avx2_opt" != "no"; then
   cat > $TMPC << EOF
+#include <cpuid.h>
+#ifndef __clang__
 #pragma GCC push_options
 #pragma GCC target("avx2")
-#include <cpuid.h>
+#endif
 #include <immintrin.h>
+#ifndef __clang__
+#pragma GCC pop_options
+#endif
+__attribute__((target("avx2")))
 static int bar(void *a) {
     __m256i x = *(__m256i *)a;
     return _mm256_testz_si256(x, x);
@@ -5835,10 +5841,16 @@ fi
 
 if test "$cpuid_h" = "yes" && test "$avx512f_opt" = "yes"; then
   cat > $TMPC << EOF
+#include <cpuid.h>
+#ifndef __clang__
 #pragma GCC push_options
 #pragma GCC target("avx512f")
-#include <cpuid.h>
+#endif
 #include <immintrin.h>
+#ifndef __clang__
+#pragma GCC pop_options
+#endif
+__attribute__((target("avx512f")))
 static int bar(void *a) {
     __m512i x = *(__m512i *)a;
     return _mm512_test_epi64_mask(x, x);
diff --git a/util/bufferiszero.c b/util/bufferiszero.c
index 695bb4ce28..ca836b6e8c 100644
--- a/util/bufferiszero.c
+++ b/util/bufferiszero.c
@@ -64,17 +64,18 @@ buffer_zero_int(const void *buf, size_t len)
 }
 
 #if defined(CONFIG_AVX512F_OPT) || defined(CONFIG_AVX2_OPT) || defined(__SSE2__)
-/* Do not use push_options pragmas unnecessarily, because clang
- * does not support them.
- */
-#if defined(CONFIG_AVX512F_OPT) || defined(CONFIG_AVX2_OPT)
+#ifndef __clang__
 #pragma GCC push_options
 #pragma GCC target("sse2")
 #endif
 #include <emmintrin.h>
+#ifndef __clang__
+#pragma GCC pop_options
+#endif
 
 /* Note that each of these vectorized functions require len >= 64.  */
 
+__attribute__((target("sse2")))
 static bool
 buffer_zero_sse2(const void *buf, size_t len)
 {
@@ -104,19 +105,22 @@ buffer_zero_sse2(const void *buf, size_t len)
 
     return _mm_movemask_epi8(_mm_cmpeq_epi8(t, zero)) == 0xFFFF;
 }
-#if defined(CONFIG_AVX512F_OPT) || defined(CONFIG_AVX2_OPT)
-#pragma GCC pop_options
-#endif
 
 #ifdef CONFIG_AVX2_OPT
 /* Note that due to restrictions/bugs wrt __builtin functions in gcc <= 4.8,
  * the includes have to be within the corresponding push_options region, and
  * therefore the regions themselves have to be ordered with increasing ISA.
  */
+#ifndef __clang__
 #pragma GCC push_options
 #pragma GCC target("sse4")
+#endif
 #include <smmintrin.h>
+#ifndef __clang__
+#pragma GCC pop_options
+#endif
 
+__attribute__((target("sse4")))
 static bool
 buffer_zero_sse4(const void *buf, size_t len)
 {
@@ -145,11 +149,16 @@ buffer_zero_sse4(const void *buf, size_t len)
     return _mm_testz_si128(t, t);
 }
 
-#pragma GCC pop_options
+#ifndef __clang__
 #pragma GCC push_options
 #pragma GCC target("avx2")
+#endif
 #include <immintrin.h>
+#ifndef __clang__
+#pragma GCC pop_options
+#endif
 
+__attribute__((target("avx2")))
 static bool
 buffer_zero_avx2(const void *buf, size_t len)
 {
@@ -176,14 +185,19 @@ buffer_zero_avx2(const void *buf, size_t len)
 
     return _mm256_testz_si256(t, t);
 }
-#pragma GCC pop_options
 #endif /* CONFIG_AVX2_OPT */
 
 #ifdef CONFIG_AVX512F_OPT
+#ifndef __clang__
 #pragma GCC push_options
 #pragma GCC target("avx512f")
+#endif
 #include <immintrin.h>
+#ifndef __clang__
+#pragma GCC pop_options
+#endif
 
+__attribute__((target("avx512f")))
 static bool
 buffer_zero_avx512(const void *buf, size_t len)
 {
@@ -210,7 +224,6 @@ buffer_zero_avx512(const void *buf, size_t len)
     return !_mm512_test_epi64_mask(t, t);
 
 }
-#pragma GCC pop_options
 #endif
 
 
-- 
2.28.0.rc0.105.gf9edc3c819-goog


