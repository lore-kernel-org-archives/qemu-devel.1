Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 626ABC7619B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 03:03:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B56120857
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 03:03:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ajgkmnt3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B56120857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39584 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3Wgo-00071h-6O
	for qemu-devel@archiver.kernel.org; Sun, 16 Feb 2020 22:03:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44856)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j3Wdj-0003B5-Eo
 for qemu-devel@nongnu.org; Sun, 16 Feb 2020 22:00:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j3Wdg-0003S7-33
 for qemu-devel@nongnu.org; Sun, 16 Feb 2020 22:00:07 -0500
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:39872)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j3Wdf-0003Qx-Pi
 for qemu-devel@nongnu.org; Sun, 16 Feb 2020 22:00:04 -0500
Received: by mail-pg1-x542.google.com with SMTP id j15so8280390pgm.6
 for <qemu-devel@nongnu.org>; Sun, 16 Feb 2020 19:00:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=slYUgw5gvBDRKGCuyZOigEVgx2Xl8RvJ6zvwjAt2VLY=;
 b=ajgkmnt3mQUAKGaaAe2wUZrVznhszWwda8Z903duI61Yb3MF62S8WPvF/21ly5cGyT
 USWfDGYgW8nxEDeIhLFdY6weTsQBkN/FgAN9RmbLRNDFbm3lqM/h437if79wGd6ZU+Xh
 abrQ+8VbT6GGkBK+HBY6KYPQexjCY0HnoWiQpeTMGsxUSNZ07PoOsgQkhoOmnD+mMI9w
 nRhFOF1p22zZsc5N0EY+PJTv+qvkUpGlv/JRFA/KOKkhhiFvTu5hT4YLxi+ufLoHU8FW
 JJdzRQqvqUqoOFNCudVl8dVR4+KciHGYGk9+/c9uJgeqtrYjMjtoL2wzg/Dg4T+fC9xM
 yVKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=slYUgw5gvBDRKGCuyZOigEVgx2Xl8RvJ6zvwjAt2VLY=;
 b=rYofCOhEAsleAcY84BY3RT8glOjgL+RSNIW9RJdYrCzP5ERxgX9o17XEMFdw+t7ohF
 r1x90Gb5mJ25Pxq/Mp+3BWds/BNFhaigj6kwMLE9rfEBePm9GSi6BGtticwpjvSF0ZQd
 AaALO2adkwZ5mqP+TyQuVMcQAqxAWsYFkctZFmqKW34yZnnllx5j+nuJ16/U29PD2Li5
 mpTcBOoiueYQ2r0qihmSwWjHCIYA+8WM94hmNI619nPSGD7WqZqhMHjletpsN3dJUzLO
 U0w9rTSoi3NQe9Zn5BO9dT9nt1UcCn4IqbHqHAO6P4wnPeop+NRQFhdx+szfoeTcYr8x
 BeCw==
X-Gm-Message-State: APjAAAWxoTL8n/yA3wiZ91H4rUTzHqfwB2GBTRwP7WG+nE9M2upyK8+m
 aML1zEamOH0R8RPIn2wz0t3cHKCKlGA=
X-Google-Smtp-Source: APXvYqw3iRAeOZJKhyGy30tiWOYkAuCvuhuWN7AeXQX2NNvbZ4lLkAfmf840hGDUHy1k/AF0/gOzhw==
X-Received: by 2002:aa7:87d5:: with SMTP id i21mr14771915pfo.143.1581908401524; 
 Sun, 16 Feb 2020 19:00:01 -0800 (PST)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id u2sm14741060pgj.7.2020.02.16.19.00.00
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2020 19:00:00 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/4] tcg: Tidy tcg-runtime-gvec.c types
Date: Sun, 16 Feb 2020 18:59:55 -0800
Message-Id: <20200217025957.12031-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200217025957.12031-1-richard.henderson@linaro.org>
References: <20200217025957.12031-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::542
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

Partial cleanup from the CONFIG_VECTOR16 removal.
Replace the vec* types with their scalar expansions.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/tcg-runtime-gvec.c | 270 +++++++++++++++++------------------
 1 file changed, 130 insertions(+), 140 deletions(-)

diff --git a/accel/tcg/tcg-runtime-gvec.c b/accel/tcg/tcg-runtime-gvec.c
index 00da0938a5..97852b515b 100644
--- a/accel/tcg/tcg-runtime-gvec.c
+++ b/accel/tcg/tcg-runtime-gvec.c
@@ -24,16 +24,6 @@
 #include "tcg/tcg-gvec-desc.h"
 
 
-typedef uint8_t vec8;
-typedef uint16_t vec16;
-typedef uint32_t vec32;
-typedef uint64_t vec64;
-
-typedef int8_t svec8;
-typedef int16_t svec16;
-typedef int32_t svec32;
-typedef int64_t svec64;
-
 #define DUP16(X)  X
 #define DUP8(X)   X
 #define DUP4(X)   X
@@ -56,8 +46,8 @@ void HELPER(gvec_add8)(void *d, void *a, void *b, uint32_t desc)
     intptr_t oprsz = simd_oprsz(desc);
     intptr_t i;
 
-    for (i = 0; i < oprsz; i += sizeof(vec8)) {
-        *(vec8 *)(d + i) = *(vec8 *)(a + i) + *(vec8 *)(b + i);
+    for (i = 0; i < oprsz; i += sizeof(uint8_t)) {
+        *(uint8_t *)(d + i) = *(uint8_t *)(a + i) + *(uint8_t *)(b + i);
     }
     clear_high(d, oprsz, desc);
 }
@@ -67,8 +57,8 @@ void HELPER(gvec_add16)(void *d, void *a, void *b, uint32_t desc)
     intptr_t oprsz = simd_oprsz(desc);
     intptr_t i;
 
-    for (i = 0; i < oprsz; i += sizeof(vec16)) {
-        *(vec16 *)(d + i) = *(vec16 *)(a + i) + *(vec16 *)(b + i);
+    for (i = 0; i < oprsz; i += sizeof(uint16_t)) {
+        *(uint16_t *)(d + i) = *(uint16_t *)(a + i) + *(uint16_t *)(b + i);
     }
     clear_high(d, oprsz, desc);
 }
@@ -78,8 +68,8 @@ void HELPER(gvec_add32)(void *d, void *a, void *b, uint32_t desc)
     intptr_t oprsz = simd_oprsz(desc);
     intptr_t i;
 
-    for (i = 0; i < oprsz; i += sizeof(vec32)) {
-        *(vec32 *)(d + i) = *(vec32 *)(a + i) + *(vec32 *)(b + i);
+    for (i = 0; i < oprsz; i += sizeof(uint32_t)) {
+        *(uint32_t *)(d + i) = *(uint32_t *)(a + i) + *(uint32_t *)(b + i);
     }
     clear_high(d, oprsz, desc);
 }
@@ -89,8 +79,8 @@ void HELPER(gvec_add64)(void *d, void *a, void *b, uint32_t desc)
     intptr_t oprsz = simd_oprsz(desc);
     intptr_t i;
 
-    for (i = 0; i < oprsz; i += sizeof(vec64)) {
-        *(vec64 *)(d + i) = *(vec64 *)(a + i) + *(vec64 *)(b + i);
+    for (i = 0; i < oprsz; i += sizeof(uint64_t)) {
+        *(uint64_t *)(d + i) = *(uint64_t *)(a + i) + *(uint64_t *)(b + i);
     }
     clear_high(d, oprsz, desc);
 }
@@ -98,11 +88,11 @@ void HELPER(gvec_add64)(void *d, void *a, void *b, uint32_t desc)
 void HELPER(gvec_adds8)(void *d, void *a, uint64_t b, uint32_t desc)
 {
     intptr_t oprsz = simd_oprsz(desc);
-    vec8 vecb = (vec8)DUP16(b);
+    uint8_t vecb = (uint8_t)DUP16(b);
     intptr_t i;
 
-    for (i = 0; i < oprsz; i += sizeof(vec8)) {
-        *(vec8 *)(d + i) = *(vec8 *)(a + i) + vecb;
+    for (i = 0; i < oprsz; i += sizeof(uint8_t)) {
+        *(uint8_t *)(d + i) = *(uint8_t *)(a + i) + vecb;
     }
     clear_high(d, oprsz, desc);
 }
@@ -110,11 +100,11 @@ void HELPER(gvec_adds8)(void *d, void *a, uint64_t b, uint32_t desc)
 void HELPER(gvec_adds16)(void *d, void *a, uint64_t b, uint32_t desc)
 {
     intptr_t oprsz = simd_oprsz(desc);
-    vec16 vecb = (vec16)DUP8(b);
+    uint16_t vecb = (uint16_t)DUP8(b);
     intptr_t i;
 
-    for (i = 0; i < oprsz; i += sizeof(vec16)) {
-        *(vec16 *)(d + i) = *(vec16 *)(a + i) + vecb;
+    for (i = 0; i < oprsz; i += sizeof(uint16_t)) {
+        *(uint16_t *)(d + i) = *(uint16_t *)(a + i) + vecb;
     }
     clear_high(d, oprsz, desc);
 }
@@ -122,11 +112,11 @@ void HELPER(gvec_adds16)(void *d, void *a, uint64_t b, uint32_t desc)
 void HELPER(gvec_adds32)(void *d, void *a, uint64_t b, uint32_t desc)
 {
     intptr_t oprsz = simd_oprsz(desc);
-    vec32 vecb = (vec32)DUP4(b);
+    uint32_t vecb = (uint32_t)DUP4(b);
     intptr_t i;
 
-    for (i = 0; i < oprsz; i += sizeof(vec32)) {
-        *(vec32 *)(d + i) = *(vec32 *)(a + i) + vecb;
+    for (i = 0; i < oprsz; i += sizeof(uint32_t)) {
+        *(uint32_t *)(d + i) = *(uint32_t *)(a + i) + vecb;
     }
     clear_high(d, oprsz, desc);
 }
@@ -134,11 +124,11 @@ void HELPER(gvec_adds32)(void *d, void *a, uint64_t b, uint32_t desc)
 void HELPER(gvec_adds64)(void *d, void *a, uint64_t b, uint32_t desc)
 {
     intptr_t oprsz = simd_oprsz(desc);
-    vec64 vecb = (vec64)DUP2(b);
+    uint64_t vecb = (uint64_t)DUP2(b);
     intptr_t i;
 
-    for (i = 0; i < oprsz; i += sizeof(vec64)) {
-        *(vec64 *)(d + i) = *(vec64 *)(a + i) + vecb;
+    for (i = 0; i < oprsz; i += sizeof(uint64_t)) {
+        *(uint64_t *)(d + i) = *(uint64_t *)(a + i) + vecb;
     }
     clear_high(d, oprsz, desc);
 }
@@ -148,8 +138,8 @@ void HELPER(gvec_sub8)(void *d, void *a, void *b, uint32_t desc)
     intptr_t oprsz = simd_oprsz(desc);
     intptr_t i;
 
-    for (i = 0; i < oprsz; i += sizeof(vec8)) {
-        *(vec8 *)(d + i) = *(vec8 *)(a + i) - *(vec8 *)(b + i);
+    for (i = 0; i < oprsz; i += sizeof(uint8_t)) {
+        *(uint8_t *)(d + i) = *(uint8_t *)(a + i) - *(uint8_t *)(b + i);
     }
     clear_high(d, oprsz, desc);
 }
@@ -159,8 +149,8 @@ void HELPER(gvec_sub16)(void *d, void *a, void *b, uint32_t desc)
     intptr_t oprsz = simd_oprsz(desc);
     intptr_t i;
 
-    for (i = 0; i < oprsz; i += sizeof(vec16)) {
-        *(vec16 *)(d + i) = *(vec16 *)(a + i) - *(vec16 *)(b + i);
+    for (i = 0; i < oprsz; i += sizeof(uint16_t)) {
+        *(uint16_t *)(d + i) = *(uint16_t *)(a + i) - *(uint16_t *)(b + i);
     }
     clear_high(d, oprsz, desc);
 }
@@ -170,8 +160,8 @@ void HELPER(gvec_sub32)(void *d, void *a, void *b, uint32_t desc)
     intptr_t oprsz = simd_oprsz(desc);
     intptr_t i;
 
-    for (i = 0; i < oprsz; i += sizeof(vec32)) {
-        *(vec32 *)(d + i) = *(vec32 *)(a + i) - *(vec32 *)(b + i);
+    for (i = 0; i < oprsz; i += sizeof(uint32_t)) {
+        *(uint32_t *)(d + i) = *(uint32_t *)(a + i) - *(uint32_t *)(b + i);
     }
     clear_high(d, oprsz, desc);
 }
@@ -181,8 +171,8 @@ void HELPER(gvec_sub64)(void *d, void *a, void *b, uint32_t desc)
     intptr_t oprsz = simd_oprsz(desc);
     intptr_t i;
 
-    for (i = 0; i < oprsz; i += sizeof(vec64)) {
-        *(vec64 *)(d + i) = *(vec64 *)(a + i) - *(vec64 *)(b + i);
+    for (i = 0; i < oprsz; i += sizeof(uint64_t)) {
+        *(uint64_t *)(d + i) = *(uint64_t *)(a + i) - *(uint64_t *)(b + i);
     }
     clear_high(d, oprsz, desc);
 }
@@ -190,11 +180,11 @@ void HELPER(gvec_sub64)(void *d, void *a, void *b, uint32_t desc)
 void HELPER(gvec_subs8)(void *d, void *a, uint64_t b, uint32_t desc)
 {
     intptr_t oprsz = simd_oprsz(desc);
-    vec8 vecb = (vec8)DUP16(b);
+    uint8_t vecb = (uint8_t)DUP16(b);
     intptr_t i;
 
-    for (i = 0; i < oprsz; i += sizeof(vec8)) {
-        *(vec8 *)(d + i) = *(vec8 *)(a + i) - vecb;
+    for (i = 0; i < oprsz; i += sizeof(uint8_t)) {
+        *(uint8_t *)(d + i) = *(uint8_t *)(a + i) - vecb;
     }
     clear_high(d, oprsz, desc);
 }
@@ -202,11 +192,11 @@ void HELPER(gvec_subs8)(void *d, void *a, uint64_t b, uint32_t desc)
 void HELPER(gvec_subs16)(void *d, void *a, uint64_t b, uint32_t desc)
 {
     intptr_t oprsz = simd_oprsz(desc);
-    vec16 vecb = (vec16)DUP8(b);
+    uint16_t vecb = (uint16_t)DUP8(b);
     intptr_t i;
 
-    for (i = 0; i < oprsz; i += sizeof(vec16)) {
-        *(vec16 *)(d + i) = *(vec16 *)(a + i) - vecb;
+    for (i = 0; i < oprsz; i += sizeof(uint16_t)) {
+        *(uint16_t *)(d + i) = *(uint16_t *)(a + i) - vecb;
     }
     clear_high(d, oprsz, desc);
 }
@@ -214,11 +204,11 @@ void HELPER(gvec_subs16)(void *d, void *a, uint64_t b, uint32_t desc)
 void HELPER(gvec_subs32)(void *d, void *a, uint64_t b, uint32_t desc)
 {
     intptr_t oprsz = simd_oprsz(desc);
-    vec32 vecb = (vec32)DUP4(b);
+    uint32_t vecb = (uint32_t)DUP4(b);
     intptr_t i;
 
-    for (i = 0; i < oprsz; i += sizeof(vec32)) {
-        *(vec32 *)(d + i) = *(vec32 *)(a + i) - vecb;
+    for (i = 0; i < oprsz; i += sizeof(uint32_t)) {
+        *(uint32_t *)(d + i) = *(uint32_t *)(a + i) - vecb;
     }
     clear_high(d, oprsz, desc);
 }
@@ -226,11 +216,11 @@ void HELPER(gvec_subs32)(void *d, void *a, uint64_t b, uint32_t desc)
 void HELPER(gvec_subs64)(void *d, void *a, uint64_t b, uint32_t desc)
 {
     intptr_t oprsz = simd_oprsz(desc);
-    vec64 vecb = (vec64)DUP2(b);
+    uint64_t vecb = (uint64_t)DUP2(b);
     intptr_t i;
 
-    for (i = 0; i < oprsz; i += sizeof(vec64)) {
-        *(vec64 *)(d + i) = *(vec64 *)(a + i) - vecb;
+    for (i = 0; i < oprsz; i += sizeof(uint64_t)) {
+        *(uint64_t *)(d + i) = *(uint64_t *)(a + i) - vecb;
     }
     clear_high(d, oprsz, desc);
 }
@@ -240,8 +230,8 @@ void HELPER(gvec_mul8)(void *d, void *a, void *b, uint32_t desc)
     intptr_t oprsz = simd_oprsz(desc);
     intptr_t i;
 
-    for (i = 0; i < oprsz; i += sizeof(vec8)) {
-        *(vec8 *)(d + i) = *(vec8 *)(a + i) * *(vec8 *)(b + i);
+    for (i = 0; i < oprsz; i += sizeof(uint8_t)) {
+        *(uint8_t *)(d + i) = *(uint8_t *)(a + i) * *(uint8_t *)(b + i);
     }
     clear_high(d, oprsz, desc);
 }
@@ -251,8 +241,8 @@ void HELPER(gvec_mul16)(void *d, void *a, void *b, uint32_t desc)
     intptr_t oprsz = simd_oprsz(desc);
     intptr_t i;
 
-    for (i = 0; i < oprsz; i += sizeof(vec16)) {
-        *(vec16 *)(d + i) = *(vec16 *)(a + i) * *(vec16 *)(b + i);
+    for (i = 0; i < oprsz; i += sizeof(uint16_t)) {
+        *(uint16_t *)(d + i) = *(uint16_t *)(a + i) * *(uint16_t *)(b + i);
     }
     clear_high(d, oprsz, desc);
 }
@@ -262,8 +252,8 @@ void HELPER(gvec_mul32)(void *d, void *a, void *b, uint32_t desc)
     intptr_t oprsz = simd_oprsz(desc);
     intptr_t i;
 
-    for (i = 0; i < oprsz; i += sizeof(vec32)) {
-        *(vec32 *)(d + i) = *(vec32 *)(a + i) * *(vec32 *)(b + i);
+    for (i = 0; i < oprsz; i += sizeof(uint32_t)) {
+        *(uint32_t *)(d + i) = *(uint32_t *)(a + i) * *(uint32_t *)(b + i);
     }
     clear_high(d, oprsz, desc);
 }
@@ -273,8 +263,8 @@ void HELPER(gvec_mul64)(void *d, void *a, void *b, uint32_t desc)
     intptr_t oprsz = simd_oprsz(desc);
     intptr_t i;
 
-    for (i = 0; i < oprsz; i += sizeof(vec64)) {
-        *(vec64 *)(d + i) = *(vec64 *)(a + i) * *(vec64 *)(b + i);
+    for (i = 0; i < oprsz; i += sizeof(uint64_t)) {
+        *(uint64_t *)(d + i) = *(uint64_t *)(a + i) * *(uint64_t *)(b + i);
     }
     clear_high(d, oprsz, desc);
 }
@@ -282,11 +272,11 @@ void HELPER(gvec_mul64)(void *d, void *a, void *b, uint32_t desc)
 void HELPER(gvec_muls8)(void *d, void *a, uint64_t b, uint32_t desc)
 {
     intptr_t oprsz = simd_oprsz(desc);
-    vec8 vecb = (vec8)DUP16(b);
+    uint8_t vecb = (uint8_t)DUP16(b);
     intptr_t i;
 
-    for (i = 0; i < oprsz; i += sizeof(vec8)) {
-        *(vec8 *)(d + i) = *(vec8 *)(a + i) * vecb;
+    for (i = 0; i < oprsz; i += sizeof(uint8_t)) {
+        *(uint8_t *)(d + i) = *(uint8_t *)(a + i) * vecb;
     }
     clear_high(d, oprsz, desc);
 }
@@ -294,11 +284,11 @@ void HELPER(gvec_muls8)(void *d, void *a, uint64_t b, uint32_t desc)
 void HELPER(gvec_muls16)(void *d, void *a, uint64_t b, uint32_t desc)
 {
     intptr_t oprsz = simd_oprsz(desc);
-    vec16 vecb = (vec16)DUP8(b);
+    uint16_t vecb = (uint16_t)DUP8(b);
     intptr_t i;
 
-    for (i = 0; i < oprsz; i += sizeof(vec16)) {
-        *(vec16 *)(d + i) = *(vec16 *)(a + i) * vecb;
+    for (i = 0; i < oprsz; i += sizeof(uint16_t)) {
+        *(uint16_t *)(d + i) = *(uint16_t *)(a + i) * vecb;
     }
     clear_high(d, oprsz, desc);
 }
@@ -306,11 +296,11 @@ void HELPER(gvec_muls16)(void *d, void *a, uint64_t b, uint32_t desc)
 void HELPER(gvec_muls32)(void *d, void *a, uint64_t b, uint32_t desc)
 {
     intptr_t oprsz = simd_oprsz(desc);
-    vec32 vecb = (vec32)DUP4(b);
+    uint32_t vecb = (uint32_t)DUP4(b);
     intptr_t i;
 
-    for (i = 0; i < oprsz; i += sizeof(vec32)) {
-        *(vec32 *)(d + i) = *(vec32 *)(a + i) * vecb;
+    for (i = 0; i < oprsz; i += sizeof(uint32_t)) {
+        *(uint32_t *)(d + i) = *(uint32_t *)(a + i) * vecb;
     }
     clear_high(d, oprsz, desc);
 }
@@ -318,11 +308,11 @@ void HELPER(gvec_muls32)(void *d, void *a, uint64_t b, uint32_t desc)
 void HELPER(gvec_muls64)(void *d, void *a, uint64_t b, uint32_t desc)
 {
     intptr_t oprsz = simd_oprsz(desc);
-    vec64 vecb = (vec64)DUP2(b);
+    uint64_t vecb = (uint64_t)DUP2(b);
     intptr_t i;
 
-    for (i = 0; i < oprsz; i += sizeof(vec64)) {
-        *(vec64 *)(d + i) = *(vec64 *)(a + i) * vecb;
+    for (i = 0; i < oprsz; i += sizeof(uint64_t)) {
+        *(uint64_t *)(d + i) = *(uint64_t *)(a + i) * vecb;
     }
     clear_high(d, oprsz, desc);
 }
@@ -332,8 +322,8 @@ void HELPER(gvec_neg8)(void *d, void *a, uint32_t desc)
     intptr_t oprsz = simd_oprsz(desc);
     intptr_t i;
 
-    for (i = 0; i < oprsz; i += sizeof(vec8)) {
-        *(vec8 *)(d + i) = -*(vec8 *)(a + i);
+    for (i = 0; i < oprsz; i += sizeof(uint8_t)) {
+        *(uint8_t *)(d + i) = -*(uint8_t *)(a + i);
     }
     clear_high(d, oprsz, desc);
 }
@@ -343,8 +333,8 @@ void HELPER(gvec_neg16)(void *d, void *a, uint32_t desc)
     intptr_t oprsz = simd_oprsz(desc);
     intptr_t i;
 
-    for (i = 0; i < oprsz; i += sizeof(vec16)) {
-        *(vec16 *)(d + i) = -*(vec16 *)(a + i);
+    for (i = 0; i < oprsz; i += sizeof(uint16_t)) {
+        *(uint16_t *)(d + i) = -*(uint16_t *)(a + i);
     }
     clear_high(d, oprsz, desc);
 }
@@ -354,8 +344,8 @@ void HELPER(gvec_neg32)(void *d, void *a, uint32_t desc)
     intptr_t oprsz = simd_oprsz(desc);
     intptr_t i;
 
-    for (i = 0; i < oprsz; i += sizeof(vec32)) {
-        *(vec32 *)(d + i) = -*(vec32 *)(a + i);
+    for (i = 0; i < oprsz; i += sizeof(uint32_t)) {
+        *(uint32_t *)(d + i) = -*(uint32_t *)(a + i);
     }
     clear_high(d, oprsz, desc);
 }
@@ -365,8 +355,8 @@ void HELPER(gvec_neg64)(void *d, void *a, uint32_t desc)
     intptr_t oprsz = simd_oprsz(desc);
     intptr_t i;
 
-    for (i = 0; i < oprsz; i += sizeof(vec64)) {
-        *(vec64 *)(d + i) = -*(vec64 *)(a + i);
+    for (i = 0; i < oprsz; i += sizeof(uint64_t)) {
+        *(uint64_t *)(d + i) = -*(uint64_t *)(a + i);
     }
     clear_high(d, oprsz, desc);
 }
@@ -472,8 +462,8 @@ void HELPER(gvec_not)(void *d, void *a, uint32_t desc)
     intptr_t oprsz = simd_oprsz(desc);
     intptr_t i;
 
-    for (i = 0; i < oprsz; i += sizeof(vec64)) {
-        *(vec64 *)(d + i) = ~*(vec64 *)(a + i);
+    for (i = 0; i < oprsz; i += sizeof(uint64_t)) {
+        *(uint64_t *)(d + i) = ~*(uint64_t *)(a + i);
     }
     clear_high(d, oprsz, desc);
 }
@@ -483,8 +473,8 @@ void HELPER(gvec_and)(void *d, void *a, void *b, uint32_t desc)
     intptr_t oprsz = simd_oprsz(desc);
     intptr_t i;
 
-    for (i = 0; i < oprsz; i += sizeof(vec64)) {
-        *(vec64 *)(d + i) = *(vec64 *)(a + i) & *(vec64 *)(b + i);
+    for (i = 0; i < oprsz; i += sizeof(uint64_t)) {
+        *(uint64_t *)(d + i) = *(uint64_t *)(a + i) & *(uint64_t *)(b + i);
     }
     clear_high(d, oprsz, desc);
 }
@@ -494,8 +484,8 @@ void HELPER(gvec_or)(void *d, void *a, void *b, uint32_t desc)
     intptr_t oprsz = simd_oprsz(desc);
     intptr_t i;
 
-    for (i = 0; i < oprsz; i += sizeof(vec64)) {
-        *(vec64 *)(d + i) = *(vec64 *)(a + i) | *(vec64 *)(b + i);
+    for (i = 0; i < oprsz; i += sizeof(uint64_t)) {
+        *(uint64_t *)(d + i) = *(uint64_t *)(a + i) | *(uint64_t *)(b + i);
     }
     clear_high(d, oprsz, desc);
 }
@@ -505,8 +495,8 @@ void HELPER(gvec_xor)(void *d, void *a, void *b, uint32_t desc)
     intptr_t oprsz = simd_oprsz(desc);
     intptr_t i;
 
-    for (i = 0; i < oprsz; i += sizeof(vec64)) {
-        *(vec64 *)(d + i) = *(vec64 *)(a + i) ^ *(vec64 *)(b + i);
+    for (i = 0; i < oprsz; i += sizeof(uint64_t)) {
+        *(uint64_t *)(d + i) = *(uint64_t *)(a + i) ^ *(uint64_t *)(b + i);
     }
     clear_high(d, oprsz, desc);
 }
@@ -516,8 +506,8 @@ void HELPER(gvec_andc)(void *d, void *a, void *b, uint32_t desc)
     intptr_t oprsz = simd_oprsz(desc);
     intptr_t i;
 
-    for (i = 0; i < oprsz; i += sizeof(vec64)) {
-        *(vec64 *)(d + i) = *(vec64 *)(a + i) &~ *(vec64 *)(b + i);
+    for (i = 0; i < oprsz; i += sizeof(uint64_t)) {
+        *(uint64_t *)(d + i) = *(uint64_t *)(a + i) &~ *(uint64_t *)(b + i);
     }
     clear_high(d, oprsz, desc);
 }
@@ -527,8 +517,8 @@ void HELPER(gvec_orc)(void *d, void *a, void *b, uint32_t desc)
     intptr_t oprsz = simd_oprsz(desc);
     intptr_t i;
 
-    for (i = 0; i < oprsz; i += sizeof(vec64)) {
-        *(vec64 *)(d + i) = *(vec64 *)(a + i) |~ *(vec64 *)(b + i);
+    for (i = 0; i < oprsz; i += sizeof(uint64_t)) {
+        *(uint64_t *)(d + i) = *(uint64_t *)(a + i) |~ *(uint64_t *)(b + i);
     }
     clear_high(d, oprsz, desc);
 }
@@ -538,8 +528,8 @@ void HELPER(gvec_nand)(void *d, void *a, void *b, uint32_t desc)
     intptr_t oprsz = simd_oprsz(desc);
     intptr_t i;
 
-    for (i = 0; i < oprsz; i += sizeof(vec64)) {
-        *(vec64 *)(d + i) = ~(*(vec64 *)(a + i) & *(vec64 *)(b + i));
+    for (i = 0; i < oprsz; i += sizeof(uint64_t)) {
+        *(uint64_t *)(d + i) = ~(*(uint64_t *)(a + i) & *(uint64_t *)(b + i));
     }
     clear_high(d, oprsz, desc);
 }
@@ -549,8 +539,8 @@ void HELPER(gvec_nor)(void *d, void *a, void *b, uint32_t desc)
     intptr_t oprsz = simd_oprsz(desc);
     intptr_t i;
 
-    for (i = 0; i < oprsz; i += sizeof(vec64)) {
-        *(vec64 *)(d + i) = ~(*(vec64 *)(a + i) | *(vec64 *)(b + i));
+    for (i = 0; i < oprsz; i += sizeof(uint64_t)) {
+        *(uint64_t *)(d + i) = ~(*(uint64_t *)(a + i) | *(uint64_t *)(b + i));
     }
     clear_high(d, oprsz, desc);
 }
@@ -560,8 +550,8 @@ void HELPER(gvec_eqv)(void *d, void *a, void *b, uint32_t desc)
     intptr_t oprsz = simd_oprsz(desc);
     intptr_t i;
 
-    for (i = 0; i < oprsz; i += sizeof(vec64)) {
-        *(vec64 *)(d + i) = ~(*(vec64 *)(a + i) ^ *(vec64 *)(b + i));
+    for (i = 0; i < oprsz; i += sizeof(uint64_t)) {
+        *(uint64_t *)(d + i) = ~(*(uint64_t *)(a + i) ^ *(uint64_t *)(b + i));
     }
     clear_high(d, oprsz, desc);
 }
@@ -569,11 +559,11 @@ void HELPER(gvec_eqv)(void *d, void *a, void *b, uint32_t desc)
 void HELPER(gvec_ands)(void *d, void *a, uint64_t b, uint32_t desc)
 {
     intptr_t oprsz = simd_oprsz(desc);
-    vec64 vecb = (vec64)DUP2(b);
+    uint64_t vecb = (uint64_t)DUP2(b);
     intptr_t i;
 
-    for (i = 0; i < oprsz; i += sizeof(vec64)) {
-        *(vec64 *)(d + i) = *(vec64 *)(a + i) & vecb;
+    for (i = 0; i < oprsz; i += sizeof(uint64_t)) {
+        *(uint64_t *)(d + i) = *(uint64_t *)(a + i) & vecb;
     }
     clear_high(d, oprsz, desc);
 }
@@ -581,11 +571,11 @@ void HELPER(gvec_ands)(void *d, void *a, uint64_t b, uint32_t desc)
 void HELPER(gvec_xors)(void *d, void *a, uint64_t b, uint32_t desc)
 {
     intptr_t oprsz = simd_oprsz(desc);
-    vec64 vecb = (vec64)DUP2(b);
+    uint64_t vecb = (uint64_t)DUP2(b);
     intptr_t i;
 
-    for (i = 0; i < oprsz; i += sizeof(vec64)) {
-        *(vec64 *)(d + i) = *(vec64 *)(a + i) ^ vecb;
+    for (i = 0; i < oprsz; i += sizeof(uint64_t)) {
+        *(uint64_t *)(d + i) = *(uint64_t *)(a + i) ^ vecb;
     }
     clear_high(d, oprsz, desc);
 }
@@ -593,11 +583,11 @@ void HELPER(gvec_xors)(void *d, void *a, uint64_t b, uint32_t desc)
 void HELPER(gvec_ors)(void *d, void *a, uint64_t b, uint32_t desc)
 {
     intptr_t oprsz = simd_oprsz(desc);
-    vec64 vecb = (vec64)DUP2(b);
+    uint64_t vecb = (uint64_t)DUP2(b);
     intptr_t i;
 
-    for (i = 0; i < oprsz; i += sizeof(vec64)) {
-        *(vec64 *)(d + i) = *(vec64 *)(a + i) | vecb;
+    for (i = 0; i < oprsz; i += sizeof(uint64_t)) {
+        *(uint64_t *)(d + i) = *(uint64_t *)(a + i) | vecb;
     }
     clear_high(d, oprsz, desc);
 }
@@ -608,8 +598,8 @@ void HELPER(gvec_shl8i)(void *d, void *a, uint32_t desc)
     int shift = simd_data(desc);
     intptr_t i;
 
-    for (i = 0; i < oprsz; i += sizeof(vec8)) {
-        *(vec8 *)(d + i) = *(vec8 *)(a + i) << shift;
+    for (i = 0; i < oprsz; i += sizeof(uint8_t)) {
+        *(uint8_t *)(d + i) = *(uint8_t *)(a + i) << shift;
     }
     clear_high(d, oprsz, desc);
 }
@@ -620,8 +610,8 @@ void HELPER(gvec_shl16i)(void *d, void *a, uint32_t desc)
     int shift = simd_data(desc);
     intptr_t i;
 
-    for (i = 0; i < oprsz; i += sizeof(vec16)) {
-        *(vec16 *)(d + i) = *(vec16 *)(a + i) << shift;
+    for (i = 0; i < oprsz; i += sizeof(uint16_t)) {
+        *(uint16_t *)(d + i) = *(uint16_t *)(a + i) << shift;
     }
     clear_high(d, oprsz, desc);
 }
@@ -632,8 +622,8 @@ void HELPER(gvec_shl32i)(void *d, void *a, uint32_t desc)
     int shift = simd_data(desc);
     intptr_t i;
 
-    for (i = 0; i < oprsz; i += sizeof(vec32)) {
-        *(vec32 *)(d + i) = *(vec32 *)(a + i) << shift;
+    for (i = 0; i < oprsz; i += sizeof(uint32_t)) {
+        *(uint32_t *)(d + i) = *(uint32_t *)(a + i) << shift;
     }
     clear_high(d, oprsz, desc);
 }
@@ -644,8 +634,8 @@ void HELPER(gvec_shl64i)(void *d, void *a, uint32_t desc)
     int shift = simd_data(desc);
     intptr_t i;
 
-    for (i = 0; i < oprsz; i += sizeof(vec64)) {
-        *(vec64 *)(d + i) = *(vec64 *)(a + i) << shift;
+    for (i = 0; i < oprsz; i += sizeof(uint64_t)) {
+        *(uint64_t *)(d + i) = *(uint64_t *)(a + i) << shift;
     }
     clear_high(d, oprsz, desc);
 }
@@ -656,8 +646,8 @@ void HELPER(gvec_shr8i)(void *d, void *a, uint32_t desc)
     int shift = simd_data(desc);
     intptr_t i;
 
-    for (i = 0; i < oprsz; i += sizeof(vec8)) {
-        *(vec8 *)(d + i) = *(vec8 *)(a + i) >> shift;
+    for (i = 0; i < oprsz; i += sizeof(uint8_t)) {
+        *(uint8_t *)(d + i) = *(uint8_t *)(a + i) >> shift;
     }
     clear_high(d, oprsz, desc);
 }
@@ -668,8 +658,8 @@ void HELPER(gvec_shr16i)(void *d, void *a, uint32_t desc)
     int shift = simd_data(desc);
     intptr_t i;
 
-    for (i = 0; i < oprsz; i += sizeof(vec16)) {
-        *(vec16 *)(d + i) = *(vec16 *)(a + i) >> shift;
+    for (i = 0; i < oprsz; i += sizeof(uint16_t)) {
+        *(uint16_t *)(d + i) = *(uint16_t *)(a + i) >> shift;
     }
     clear_high(d, oprsz, desc);
 }
@@ -680,8 +670,8 @@ void HELPER(gvec_shr32i)(void *d, void *a, uint32_t desc)
     int shift = simd_data(desc);
     intptr_t i;
 
-    for (i = 0; i < oprsz; i += sizeof(vec32)) {
-        *(vec32 *)(d + i) = *(vec32 *)(a + i) >> shift;
+    for (i = 0; i < oprsz; i += sizeof(uint32_t)) {
+        *(uint32_t *)(d + i) = *(uint32_t *)(a + i) >> shift;
     }
     clear_high(d, oprsz, desc);
 }
@@ -692,8 +682,8 @@ void HELPER(gvec_shr64i)(void *d, void *a, uint32_t desc)
     int shift = simd_data(desc);
     intptr_t i;
 
-    for (i = 0; i < oprsz; i += sizeof(vec64)) {
-        *(vec64 *)(d + i) = *(vec64 *)(a + i) >> shift;
+    for (i = 0; i < oprsz; i += sizeof(uint64_t)) {
+        *(uint64_t *)(d + i) = *(uint64_t *)(a + i) >> shift;
     }
     clear_high(d, oprsz, desc);
 }
@@ -704,8 +694,8 @@ void HELPER(gvec_sar8i)(void *d, void *a, uint32_t desc)
     int shift = simd_data(desc);
     intptr_t i;
 
-    for (i = 0; i < oprsz; i += sizeof(vec8)) {
-        *(svec8 *)(d + i) = *(svec8 *)(a + i) >> shift;
+    for (i = 0; i < oprsz; i += sizeof(uint8_t)) {
+        *(int8_t *)(d + i) = *(int8_t *)(a + i) >> shift;
     }
     clear_high(d, oprsz, desc);
 }
@@ -716,8 +706,8 @@ void HELPER(gvec_sar16i)(void *d, void *a, uint32_t desc)
     int shift = simd_data(desc);
     intptr_t i;
 
-    for (i = 0; i < oprsz; i += sizeof(vec16)) {
-        *(svec16 *)(d + i) = *(svec16 *)(a + i) >> shift;
+    for (i = 0; i < oprsz; i += sizeof(uint16_t)) {
+        *(int16_t *)(d + i) = *(int16_t *)(a + i) >> shift;
     }
     clear_high(d, oprsz, desc);
 }
@@ -728,8 +718,8 @@ void HELPER(gvec_sar32i)(void *d, void *a, uint32_t desc)
     int shift = simd_data(desc);
     intptr_t i;
 
-    for (i = 0; i < oprsz; i += sizeof(vec32)) {
-        *(svec32 *)(d + i) = *(svec32 *)(a + i) >> shift;
+    for (i = 0; i < oprsz; i += sizeof(uint32_t)) {
+        *(int32_t *)(d + i) = *(int32_t *)(a + i) >> shift;
     }
     clear_high(d, oprsz, desc);
 }
@@ -740,8 +730,8 @@ void HELPER(gvec_sar64i)(void *d, void *a, uint32_t desc)
     int shift = simd_data(desc);
     intptr_t i;
 
-    for (i = 0; i < oprsz; i += sizeof(vec64)) {
-        *(svec64 *)(d + i) = *(svec64 *)(a + i) >> shift;
+    for (i = 0; i < oprsz; i += sizeof(uint64_t)) {
+        *(int64_t *)(d + i) = *(int64_t *)(a + i) >> shift;
     }
     clear_high(d, oprsz, desc);
 }
@@ -904,12 +894,12 @@ void HELPER(NAME)(void *d, void *a, void *b, uint32_t desc)                \
 }
 
 #define DO_CMP2(SZ) \
-    DO_CMP1(gvec_eq##SZ, vec##SZ, ==)    \
-    DO_CMP1(gvec_ne##SZ, vec##SZ, !=)    \
-    DO_CMP1(gvec_lt##SZ, svec##SZ, <)    \
-    DO_CMP1(gvec_le##SZ, svec##SZ, <=)   \
-    DO_CMP1(gvec_ltu##SZ, vec##SZ, <)    \
-    DO_CMP1(gvec_leu##SZ, vec##SZ, <=)
+    DO_CMP1(gvec_eq##SZ, uint##SZ##_t, ==)    \
+    DO_CMP1(gvec_ne##SZ, uint##SZ##_t, !=)    \
+    DO_CMP1(gvec_lt##SZ, int##SZ##_t, <)      \
+    DO_CMP1(gvec_le##SZ, int##SZ##_t, <=)     \
+    DO_CMP1(gvec_ltu##SZ, uint##SZ##_t, <)    \
+    DO_CMP1(gvec_leu##SZ, uint##SZ##_t, <=)
 
 DO_CMP2(8)
 DO_CMP2(16)
@@ -1417,11 +1407,11 @@ void HELPER(gvec_bitsel)(void *d, void *a, void *b, void *c, uint32_t desc)
     intptr_t oprsz = simd_oprsz(desc);
     intptr_t i;
 
-    for (i = 0; i < oprsz; i += sizeof(vec64)) {
-        vec64 aa = *(vec64 *)(a + i);
-        vec64 bb = *(vec64 *)(b + i);
-        vec64 cc = *(vec64 *)(c + i);
-        *(vec64 *)(d + i) = (bb & aa) | (cc & ~aa);
+    for (i = 0; i < oprsz; i += sizeof(uint64_t)) {
+        uint64_t aa = *(uint64_t *)(a + i);
+        uint64_t bb = *(uint64_t *)(b + i);
+        uint64_t cc = *(uint64_t *)(c + i);
+        *(uint64_t *)(d + i) = (bb & aa) | (cc & ~aa);
     }
     clear_high(d, oprsz, desc);
 }
-- 
2.20.1


