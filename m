Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CB05C4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 16:51:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7A28206DC
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 16:51:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QonyN7yR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7A28206DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50128 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUuqs-0007uf-Et
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 12:51:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49296)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kUudv-0007mA-BQ
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 12:37:47 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b]:52575)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kUudt-0000xv-JV
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 12:37:47 -0400
Received: by mail-wm1-x32b.google.com with SMTP id c194so2488229wme.2
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2020 09:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=nLpmmB1zOrX5GCXrMDbuop25AXmZfJe8hra4fgaIWd0=;
 b=QonyN7yRTAG6bfAQcdXVscZSU0F1Xep4neuChQGQe38azhQFAcmTT7muZMxKmAfnn7
 NHeJYmwz4REvYd0nmwbY1u+hn+GawJ9FSFmVuJKD58/DAiQKd84C0uxymABCuROtyZXy
 68t65wqqKNfVVwUmDcE0NaGCEl79lmWKQj2zYnlLr52/x6IpcfVzkyolaNtTGQK2s8Fw
 msZpmqrQVf9YuDz0xljO+5yXj8wW//7WxsbfuBDfGnehknXt4/mxMq6Ymsl9ZXEoXfku
 n0hf1yPK06V2dbEPE50tzPKon4BB4DeRge77ndN7QmWJjsaiI3oDLNlXUO9DdLpA8P8I
 dzLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=nLpmmB1zOrX5GCXrMDbuop25AXmZfJe8hra4fgaIWd0=;
 b=Np1GOTrNJrUuDpvM/2roSj1Sy0drpXtirvzumxABsiXxLbKCovvoWHigamXLX/9zkj
 CNR1t9oIa8O6YPeZjM3V3Tnblb8RcCh9XwDmhNNU5w6SQg0NQYTJZJxiO2cPuxgjpLvF
 TS3EO+AYc1EQ62Db0YGFWaRsjgiTWnNEFGAVNjoRNADAtFtyTuwszgnlHV7DiRMonHQh
 MfiT+qULIoh5kl7QRjbDWvUMRkb24TwsJQHpnIKHzMmgVxVhjcp4y9OqCNM5SywV7fmh
 iD3xRZ48GuD/E0PMv1h1Ocm3ZxTc8j6Pl0bpj8+ynmapPGwR5f280gEQet+V5IplJMJq
 Lk8Q==
X-Gm-Message-State: AOAM5335lgbR6r2ts0eP2eSC/kIGuEENKUrTr3pPwexYwrIZi6yd6gLt
 t95GqTg6RCHHo91oSWZf09dEqw==
X-Google-Smtp-Source: ABdhPJw2ZMF03y7F+e6uvlRg94jQtX78bXUiHIyLCrsIsieUf1HEjZI6Sq/pb9SgydUDW/cZKuiIGg==
X-Received: by 2002:a1c:3b8a:: with SMTP id i132mr3852324wma.178.1603211864038; 
 Tue, 20 Oct 2020 09:37:44 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id b190sm3469958wmd.35.2020.10.20.09.37.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2020 09:37:40 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 3FA4C1FF8C;
 Tue, 20 Oct 2020 17:37:39 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH  2/8] softfloat: Use int128.h for some operations
Date: Tue, 20 Oct 2020 17:37:32 +0100
Message-Id: <20201020163738.27700-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201020163738.27700-1-alex.bennee@linaro.org>
References: <20201020163738.27700-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32b.google.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 David Hildenbrand <david@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, cota@braap.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <richard.henderson@linaro.org>

Use our Int128, which wraps the compiler's __int128_t,
instead of open-coding left shifts and arithmetic.
We'd need to extend Int128 to have unsigned operations
to replace more than these three.

Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20200925152047.709901-3-richard.henderson@linaro.org>
---
 include/fpu/softfloat-macros.h | 39 +++++++++++++++++-----------------
 1 file changed, 20 insertions(+), 19 deletions(-)

diff --git a/include/fpu/softfloat-macros.h b/include/fpu/softfloat-macros.h
index 57845f8af0..95d88d05b8 100644
--- a/include/fpu/softfloat-macros.h
+++ b/include/fpu/softfloat-macros.h
@@ -84,6 +84,7 @@ this code that are retained.
 
 #include "fpu/softfloat-types.h"
 #include "qemu/host-utils.h"
+#include "qemu/int128.h"
 
 /*----------------------------------------------------------------------------
 | Shifts `a' right by the number of bits given in `count'.  If any nonzero
@@ -352,13 +353,11 @@ static inline void shortShift128Left(uint64_t a0, uint64_t a1, int count,
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
+    Int128 z = int128_lshift(a, count);
+
+    *z0Ptr = int128_gethi(z);
+    *z1Ptr = int128_getlo(z);
 }
 
 /*----------------------------------------------------------------------------
@@ -405,15 +404,15 @@ static inline void
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
@@ -463,13 +462,15 @@ static inline void
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
2.20.1


