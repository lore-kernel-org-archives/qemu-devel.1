Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88F42C5517A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 04:58:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11D2A20936
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 04:58:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l3RYswcb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11D2A20936
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49492 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kV6Cc-00005g-4k
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 00:58:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57562)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kV66W-0000X8-ON
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 00:52:04 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:40815)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kV66U-0005i5-Lg
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 00:52:04 -0400
Received: by mail-pg1-x541.google.com with SMTP id x13so732798pgp.7
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2020 21:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=0vCw+XiUmQyJyI/l8oaOGKo4MiMqjFivosA30HUmSbA=;
 b=l3RYswcbt+mTW6WFhuP/z62gH/N4XC6AeMoCekWvQyflUKeXAwdcuzGZ+pfAlRZIZt
 75Xl+2lohWg/31FyJ0Zl4J70xw5A6ZLk1QloldQhnvjFxjYqVeu93rp9mSxYJ7sQgdny
 juNw2utfcB5cgOnT/vaGY9MB9ScOrAk2TR0wNOWyyJgwu3hLaB4Fel68F1c/+vZTAVVs
 yBZrr4mL3+ZW+zXgVl49NAYG/AmxXb19o14/ERN1lIVfmH1z5K5WIu3abnlEMwhdOjtB
 4PEvczcrEo2nj9anDZu42fAt4YLOjNGHqzqW4t/l6eXrAux/C3+iXYc4OI7Eo4yKc0AR
 ToXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=0vCw+XiUmQyJyI/l8oaOGKo4MiMqjFivosA30HUmSbA=;
 b=VZPYdrczB7ZfrKIZNPCUb7YZMQfGV8Nv30Ed5hnwLHTcfvBNnNsT/C4WBAdZlQdtJa
 cHXX9i832/wwLe3bRLkwcx5lrDmr2/jgUA6uWMUeiushkxz1yqogA8N639LVnuPLdozc
 m9o14fJeVw4VtrZdPzYM9UoJ/6LYLmuXBM2dVHJRNdW9lmPSCSNyOLrknA6Lximqs+fp
 CcE/NFV5AwNW88V9z4/yE68oerozUvDlqsoswNqzCRGDkqr/svT7WHw4c9b/4039OMrQ
 0+Wpga8lak7CyEN5sKsVhgT79lr4tQog/nyjCiSmsl5gKbuiXMapBq1LpzyWVExDNIV3
 nXwQ==
X-Gm-Message-State: AOAM5325TJ8HwxPzUCzKYYSZvoB5wspHbpEdcdAg+gmYe083aoGmH2L+
 v3VHW3onmDgpaTvcB91pAUdMFyAkB37DkA==
X-Google-Smtp-Source: ABdhPJxvVpzXiVA8J/Dj4aqlyfaRuAOdJzPF9mCaFNXKO4A6NVy6+RrGe8JtkbkaCqoJCZqk9PF5nw==
X-Received: by 2002:a62:ee10:0:b029:142:2501:34e2 with SMTP id
 e16-20020a62ee100000b0290142250134e2mr1424398pfi.59.1603255920735; 
 Tue, 20 Oct 2020 21:52:00 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id j11sm620070pfh.143.2020.10.20.21.51.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2020 21:52:00 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 07/15] softfloat: Use int128.h for some operations
Date: Tue, 20 Oct 2020 21:51:41 -0700
Message-Id: <20201021045149.1582203-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201021045149.1582203-1-richard.henderson@linaro.org>
References: <20201021045149.1582203-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::541;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x541.google.com
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
Cc: alex.bennee@linaro.org, David Hildenbrand <david@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Use our Int128, which wraps the compiler's __int128_t, instead
of open-coding shifts and arithmetic.  We'd need to extend Int128
to to replace more than these four.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/fpu/softfloat-macros.h | 65 ++++++++++++++--------------------
 1 file changed, 26 insertions(+), 39 deletions(-)

diff --git a/include/fpu/softfloat-macros.h b/include/fpu/softfloat-macros.h
index 57845f8af0..e6f05c048e 100644
--- a/include/fpu/softfloat-macros.h
+++ b/include/fpu/softfloat-macros.h
@@ -84,6 +84,7 @@ this code that are retained.
 
 #include "fpu/softfloat-types.h"
 #include "qemu/host-utils.h"
+#include "qemu/int128.h"
 
 /*----------------------------------------------------------------------------
 | Shifts `a' right by the number of bits given in `count'.  If any nonzero
@@ -191,28 +192,14 @@ static inline void
 | which are stored at the locations pointed to by `z0Ptr' and `z1Ptr'.
 *----------------------------------------------------------------------------*/
 
-static inline void
- shift128Right(
-     uint64_t a0, uint64_t a1, int count, uint64_t *z0Ptr, uint64_t *z1Ptr)
+static inline void shift128Right(uint64_t a0, uint64_t a1, int count,
+                                 uint64_t *z0Ptr, uint64_t *z1Ptr)
 {
-    uint64_t z0, z1;
-    int8_t negCount = ( - count ) & 63;
-
-    if ( count == 0 ) {
-        z1 = a1;
-        z0 = a0;
-    }
-    else if ( count < 64 ) {
-        z1 = ( a0<<negCount ) | ( a1>>count );
-        z0 = a0>>count;
-    }
-    else {
-        z1 = (count < 128) ? (a0 >> (count & 63)) : 0;
-        z0 = 0;
-    }
-    *z1Ptr = z1;
-    *z0Ptr = z0;
+    Int128 a = int128_make128(a1, a0);
+    Int128 z = int128_shr(a, count);
 
+    *z0Ptr = int128_gethi(z);
+    *z1Ptr = int128_getlo(z);
 }
 
 /*----------------------------------------------------------------------------
@@ -352,13 +339,11 @@ static inline void shortShift128Left(uint64_t a0, uint64_t a1, int count,
 static inline void shift128Left(uint64_t a0, uint64_t a1, int count,
                                 uint64_t *z0Ptr, uint64_t *z1Ptr)
 {
-    if (count < 64) {
-        *z1Ptr = a1 << count;
-        *z0Ptr = count == 0 ? a0 : (a0 << count) | (a1 >> (-count & 63));
-    } else {
-        *z1Ptr = 0;
-        *z0Ptr = a1 << (count - 64);
-    }
+    Int128 a = int128_make128(a1, a0);
+    Int128 z = int128_shl(a, count);
+
+    *z0Ptr = int128_gethi(z);
+    *z1Ptr = int128_getlo(z);
 }
 
 /*----------------------------------------------------------------------------
@@ -405,15 +390,15 @@ static inline void
 *----------------------------------------------------------------------------*/
 
 static inline void
- add128(
-     uint64_t a0, uint64_t a1, uint64_t b0, uint64_t b1, uint64_t *z0Ptr, uint64_t *z1Ptr )
+add128(uint64_t a0, uint64_t a1, uint64_t b0, uint64_t b1,
+       uint64_t *z0Ptr, uint64_t *z1Ptr)
 {
-    uint64_t z1;
-
-    z1 = a1 + b1;
-    *z1Ptr = z1;
-    *z0Ptr = a0 + b0 + ( z1 < a1 );
+    Int128 a = int128_make128(a1, a0);
+    Int128 b = int128_make128(b1, b0);
+    Int128 z = int128_add(a, b);
 
+    *z0Ptr = int128_gethi(z);
+    *z1Ptr = int128_getlo(z);
 }
 
 /*----------------------------------------------------------------------------
@@ -463,13 +448,15 @@ static inline void
 *----------------------------------------------------------------------------*/
 
 static inline void
- sub128(
-     uint64_t a0, uint64_t a1, uint64_t b0, uint64_t b1, uint64_t *z0Ptr, uint64_t *z1Ptr )
+sub128(uint64_t a0, uint64_t a1, uint64_t b0, uint64_t b1,
+       uint64_t *z0Ptr, uint64_t *z1Ptr)
 {
+    Int128 a = int128_make128(a1, a0);
+    Int128 b = int128_make128(b1, b0);
+    Int128 z = int128_sub(a, b);
 
-    *z1Ptr = a1 - b1;
-    *z0Ptr = a0 - b0 - ( a1 < b1 );
-
+    *z0Ptr = int128_gethi(z);
+    *z1Ptr = int128_getlo(z);
 }
 
 /*----------------------------------------------------------------------------
-- 
2.25.1


