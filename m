Return-Path: <SRS0=w+gu=XN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98B59C4CEC9
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 18:05:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6645A208C0
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 18:05:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uFGlCSOW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6645A208C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33954 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAeKt-0003da-Qb
	for qemu-devel@archiver.kernel.org; Wed, 18 Sep 2019 14:05:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45835)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iAeI5-0001y5-P3
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 14:02:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iAeI4-0000RE-HV
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 14:02:57 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436]:41085)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iAeI4-0000QG-C4
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 14:02:56 -0400
Received: by mail-pf1-x436.google.com with SMTP id q7so487625pfh.8
 for <qemu-devel@nongnu.org>; Wed, 18 Sep 2019 11:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=YucIarDiughcNjItqw4GzM0WuzRRGrmYnyWJbXHK1Xc=;
 b=uFGlCSOWaQ9pQd3SvbCiO9C6FlvhlqZSoeFpvmgEgvp3iwl1XnrYNWgeu3zb5nUqd3
 g2P5J2ghYZUwV2iS7KA3lfqAyOq3Vb/oDz7V7zb3BFWQ1du1w89Q73UzS8ZYRmrUJPdk
 VkAzEkZ9XcoWj0kmsHR+bNH3f9jxmA8jAftVbTBItI+2Ia+C9Qq6IYqrpxzHIfs7atiX
 3n4c+MGZ6TWyd9BnYtbIkr5T1i1dfBvHjhWA8T43KTW8jP2AUKnmFFKi7aCRSNwh2/xq
 jt8xd9JMbz/WFG+97tLpYltfNdmfkVSARZqo1Or9dADhbKdSBM0BsbZ4uBm+f0nKQiVL
 tcow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=YucIarDiughcNjItqw4GzM0WuzRRGrmYnyWJbXHK1Xc=;
 b=dPZOaePNTQuy1AyR2mvzCJahFgOJFKAYCnWmzxpRTOoa9MyjQaH/XvYQI59A7TLHJE
 jGP9vNHK5U2OJ/BZuni+U5NQlVpvxZ0Gh7Q0CDQRf8TKn8rzKAaY5QXUeR3Paeus5I8W
 Ep4IalCshhwKlXIw56mWZq8pCUm3oC91JLvAcrkNIgSxmGTVZFgqObE1gcgkd3PMpyYI
 zze8Uzm1urnVRtO5XeXTs58bFKCnHNB1ANGWHX8tPRebr4+JWX5zzS+BCJmXweYHyXU+
 GCjfBiRcimNkXmOqj1vKzOG63rTp6g95+ll+7vjaDJ4OWtiQBJB/I0XAjk/1LSFpH/xj
 GHNg==
X-Gm-Message-State: APjAAAX8m3hGz2lPSo//HS2VvGPeZ+rda0yXKFwWPhXrvmaJTtO7dH9F
 n4blPaAG6i1r+ZaII59/HwKzx+yZcEI=
X-Google-Smtp-Source: APXvYqxjB8+UqTp0iZwFqovSRuG/3lZJcaCgJvnTQ3VSJlNBpkCkpqAFr1ZivhXzc7i/x0VPM8gBJQ==
X-Received: by 2002:a63:cf0a:: with SMTP id j10mr5032746pgg.388.1568829774491; 
 Wed, 18 Sep 2019 11:02:54 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id b16sm13319518pfb.54.2019.09.18.11.02.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Sep 2019 11:02:53 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 18 Sep 2019 11:02:47 -0700
Message-Id: <20190918180251.32003-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190918180251.32003-1-richard.henderson@linaro.org>
References: <20190918180251.32003-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::436
Subject: [Qemu-devel] [RFC v2 1/5] cputlb: Disable __always_inline__ without
 optimization
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
Cc: pbonzini@redhat.com, alex.bennee@linaro.org, stefanha@redhat.com,
 david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This forced inlining can result in missing symbols,
which makes a debugging build harder to follow.

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/qemu/compiler.h | 11 +++++++++++
 accel/tcg/cputlb.c      |  4 ++--
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/include/qemu/compiler.h b/include/qemu/compiler.h
index 09fc44cca4..d6d400c523 100644
--- a/include/qemu/compiler.h
+++ b/include/qemu/compiler.h
@@ -170,6 +170,17 @@
 # define QEMU_NONSTRING
 #endif
 
+/*
+ * Forced inlining may be desired to encourage constant propagation
+ * of function parameters.  However, it can also make debugging harder,
+ * so disable it for a non-optimizing build.
+ */
+#if defined(__OPTIMIZE__) && __has_attribute(always_inline)
+#define QEMU_ALWAYS_INLINE  __attribute__((always_inline))
+#else
+#define QEMU_ALWAYS_INLINE
+#endif
+
 /* Implement C11 _Generic via GCC builtins.  Example:
  *
  *    QEMU_GENERIC(x, (float, sinf), (long double, sinl), sin) (x)
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index abae79650c..2222b87764 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1281,7 +1281,7 @@ static void *atomic_mmu_lookup(CPUArchState *env, target_ulong addr,
 typedef uint64_t FullLoadHelper(CPUArchState *env, target_ulong addr,
                                 TCGMemOpIdx oi, uintptr_t retaddr);
 
-static inline uint64_t __attribute__((always_inline))
+static inline uint64_t QEMU_ALWAYS_INLINE
 load_helper(CPUArchState *env, target_ulong addr, TCGMemOpIdx oi,
             uintptr_t retaddr, MemOp op, bool code_read,
             FullLoadHelper *full_load)
@@ -1530,7 +1530,7 @@ tcg_target_ulong helper_be_ldsl_mmu(CPUArchState *env, target_ulong addr,
  * Store Helpers
  */
 
-static inline void __attribute__((always_inline))
+static inline void QEMU_ALWAYS_INLINE
 store_helper(CPUArchState *env, target_ulong addr, uint64_t val,
              TCGMemOpIdx oi, uintptr_t retaddr, MemOp op)
 {
-- 
2.17.1


