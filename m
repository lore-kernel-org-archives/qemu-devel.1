Return-Path: <SRS0=PlQC=BZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB7EFC433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2020 15:16:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5EF72310F
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2020 15:16:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X10e0JN1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5EF72310F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51840 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6xv1-00006d-TU
	for qemu-devel@archiver.kernel.org; Sat, 15 Aug 2020 11:16:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57168)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k6xtO-0006o3-NB
 for qemu-devel@nongnu.org; Sat, 15 Aug 2020 11:14:46 -0400
Received: from mail-vs1-xe43.google.com ([2607:f8b0:4864:20::e43]:46489)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k6xtM-000185-M9
 for qemu-devel@nongnu.org; Sat, 15 Aug 2020 11:14:46 -0400
Received: by mail-vs1-xe43.google.com with SMTP id b26so6109234vsa.13
 for <qemu-devel@nongnu.org>; Sat, 15 Aug 2020 08:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=a6sddQ4a7J3ma5R9bNKguwF3w7koXzfGsjqJtD8mfho=;
 b=X10e0JN16bMkT8rBKbYO3BHenJUORxUWQVjak0G+QKgEcbyt4DB0uHnytL7vwpAO+a
 NwxwXz7FjAeGU0LmyKOMB0pMGxPo+UWJ1S4zjb+XaFGjXws9eycSdNF1xZK4Lvu5w7Jr
 Co4tarm7RPg7D/kYnLxijq5KqIKCfBCBSsIksLWNfUQt2DpqKP/oflHZrXhv/LJnPAPP
 SvDhhS1B60DA1iIgr/KirJgUR7yfFrn7gOuixzyJcYTxkFIkB5aO0uN91G8O0sU08ZI2
 8MNM/O42zhLLuCUHlCUZniGqJBMvOB+DKRt4um9BM4KVpsMDkmXG1Cmj8GCz5P1zqBy4
 ri4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=a6sddQ4a7J3ma5R9bNKguwF3w7koXzfGsjqJtD8mfho=;
 b=dcIAT+sCWdB1XuP+SMZfdWszHb+r+Q3BUxTP5B45n33EjJlKtnNMhuNpnJ2gTY8L4i
 OpGFlzf3DUIMe+Uq17sS0NY448HIUMTbWQOO7NBPMZwdrR9F9ibvT7uSXTSwztVtFR1W
 BXQQppZYkpUBXMg8bo4whtUGJOCwJwr/L3zh6nP7dGgdy4+QYzM2001TLZehKsqqATS/
 Stg5MQ3irTBJYOKzLjcU3p6Zxa/DA6mMaxmU31lUwnMXAShdRlxU+oanj3EBbgnn+MwH
 YfrBIJck74UMqghrS2v4UcnTsJKqvWBYwHQ2Lfb0W+GQ/Qq0cItPpqyrIkdVWp0gQM73
 lkVA==
X-Gm-Message-State: AOAM532XjN3mDQmKZVaAIUGp6GutIGNHqe0LGnfX2BQ54u7w0Dwnlo0j
 tbwyZcLE9iSiAUozkSVNTv7Vd2KVbPbJvw==
X-Google-Smtp-Source: ABdhPJzFqQ5HOjkA6XGGVFzA9jk/Ld+5xowspS0FhgWywTjkkzakZnOopaadGnWM4x8MPIvl8UNMfg==
X-Received: by 2002:aa7:924b:: with SMTP id 11mr680979pfp.185.1597455129593;
 Fri, 14 Aug 2020 18:32:09 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id y196sm10625528pfc.202.2020.08.14.18.32.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2020 18:32:08 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 16/20] target/arm: Fix sve_zip_p vs odd vector lengths
Date: Fri, 14 Aug 2020 18:31:41 -0700
Message-Id: <20200815013145.539409-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200815013145.539409-1-richard.henderson@linaro.org>
References: <20200815013145.539409-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::e43;
 envelope-from=richard.henderson@linaro.org; helo=mail-vs1-xe43.google.com
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
Cc: Laurent Desnogues <laurent.desnogues@gmail.com>, peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Wrote too much with low-half zip (zip1) with vl % 512 != 0.

Adjust all of the x + (y << s) to x | (y << s) as a style fix.

Reported-by: Laurent Desnogues <laurent.desnogues@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/sve_helper.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
index fcb46f150f..b8651ae173 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -1870,6 +1870,7 @@ void HELPER(sve_zip_p)(void *vd, void *vn, void *vm, uint32_t pred_desc)
     intptr_t oprsz = extract32(pred_desc, 0, SIMD_OPRSZ_BITS) + 2;
     int esz = extract32(pred_desc, SIMD_DATA_SHIFT, 2);
     intptr_t high = extract32(pred_desc, SIMD_DATA_SHIFT + 2, 1);
+    int esize = 1 << esz;
     uint64_t *d = vd;
     intptr_t i;
 
@@ -1882,33 +1883,35 @@ void HELPER(sve_zip_p)(void *vd, void *vn, void *vm, uint32_t pred_desc)
         mm = extract64(mm, high * half, half);
         nn = expand_bits(nn, esz);
         mm = expand_bits(mm, esz);
-        d[0] = nn + (mm << (1 << esz));
+        d[0] = nn | (mm << esize);
     } else {
-        ARMPredicateReg tmp_n, tmp_m;
+        ARMPredicateReg tmp;
 
         /* We produce output faster than we consume input.
            Therefore we must be mindful of possible overlap.  */
-        if ((vn - vd) < (uintptr_t)oprsz) {
-            vn = memcpy(&tmp_n, vn, oprsz);
-        }
-        if ((vm - vd) < (uintptr_t)oprsz) {
-            vm = memcpy(&tmp_m, vm, oprsz);
+        if (vd == vn) {
+            vn = memcpy(&tmp, vn, oprsz);
+            if (vd == vm) {
+                vm = vn;
+            }
+        } else if (vd == vm) {
+            vm = memcpy(&tmp, vm, oprsz);
         }
         if (high) {
             high = oprsz >> 1;
         }
 
-        if ((high & 3) == 0) {
+        if ((oprsz & 7) == 0) {
             uint32_t *n = vn, *m = vm;
             high >>= 2;
 
-            for (i = 0; i < DIV_ROUND_UP(oprsz, 8); i++) {
+            for (i = 0; i < oprsz / 8; i++) {
                 uint64_t nn = n[H4(high + i)];
                 uint64_t mm = m[H4(high + i)];
 
                 nn = expand_bits(nn, esz);
                 mm = expand_bits(mm, esz);
-                d[i] = nn + (mm << (1 << esz));
+                d[i] = nn | (mm << esize);
             }
         } else {
             uint8_t *n = vn, *m = vm;
@@ -1920,7 +1923,7 @@ void HELPER(sve_zip_p)(void *vd, void *vn, void *vm, uint32_t pred_desc)
 
                 nn = expand_bits(nn, esz);
                 mm = expand_bits(mm, esz);
-                d16[H2(i)] = nn + (mm << (1 << esz));
+                d16[H2(i)] = nn | (mm << esize);
             }
         }
     }
-- 
2.25.1


