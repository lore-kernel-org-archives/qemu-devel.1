Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A6B4C2BB1D
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 19:02:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E088320674
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 19:02:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nLtn+kr4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E088320674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39938 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEHUB-0000cl-2a
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 15:02:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33318)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jEHRw-0007FO-KA
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 15:00:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jEHRu-0004bW-Pw
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 15:00:24 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533]:38851)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jEHRu-0004VA-Iw
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 15:00:22 -0400
Received: by mail-pg1-x533.google.com with SMTP id x7so12235762pgh.5
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2020 12:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=jFLYAZoqwDTEu0F4qEf8cTvEll1bS4pjAF8UeJqCwYI=;
 b=nLtn+kr486UZBruM5UvoTWFA0rO77oPXi86HX5sRkuijkPNTKlurn5/ITkzLCfflAG
 uMUCqc0Kal9B8pic/ICrEpwazoNi8OlXNTqpkbkDLLiO6LVxZpjQDTcRSDivG/0+gB36
 AZKtrz25JQsDle9UGqeDjeIuuwl0bDjCYUyghPTGnuCAneYZ3836uZqBmCKhOmKq6A5L
 pwY/6OQwX1Qf/a4pCoPTIlgLdYthf+mfSIjfLXj5Mem6oaKL8GXrCCoFERvb3JOPTBbH
 I9pF2FlZbtqUbfj5A9ASvLLCP1XmIDsESuTLbdBuN+iEGe0n2yfzw3InH69aOUebA55I
 U7Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=jFLYAZoqwDTEu0F4qEf8cTvEll1bS4pjAF8UeJqCwYI=;
 b=Wgz5gAv31KIs1fngKQ/SvPxo+iXupoJzb2GTymygtGQX9QRcKO1tU48cyeIUfby8OE
 ebHPNmBjSAUI34mwdw35QZWotxwAgsYDilocJIuI3xy8B73cq1JCGkvCRjPShE9RIarB
 OQYKsPsGTN/FvOk1p828xXIwgnKICG0QXpBUtDikmN0EFHXCdjNZNvJdKIJ/q55zqx1y
 MBLT0fknNZW3KyspJ081ZIjv+frvAVVY4xlzaH/ACSOYVI3MBBT3WyfP0qdo/XNI9fCX
 NZVgB8g6vd4mqSdbOZ4DrqXXP2Ecz3h/Z/NBeZw7tuOg1r4Ty4NjBEJKjDLjfT5hdbSN
 qrIQ==
X-Gm-Message-State: ANhLgQ3i2YuEGgtHWPADSpnINw1nAd5X68UYLopm5mX4kZfovtIEpmYH
 A1aZRnWDD+/66EewCO5ai/WP85A3H0c=
X-Google-Smtp-Source: ADFU+vsa5jOrSqMzGcoZVV/UuHDiSq3u84o2nHC3zqj/bk3XKnH3QLyz3VZiNA9LfSY9UTOqlZg5cw==
X-Received: by 2002:a65:6447:: with SMTP id s7mr641993pgv.163.1584471620980;
 Tue, 17 Mar 2020 12:00:20 -0700 (PDT)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id y13sm3738411pfp.88.2020.03.17.12.00.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2020 12:00:20 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 4/5] tcg: Tidy tcg-runtime-gvec.c DUP*
Date: Tue, 17 Mar 2020 12:00:12 -0700
Message-Id: <20200317190013.25036-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200317190013.25036-1-richard.henderson@linaro.org>
References: <20200317190013.25036-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::533
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
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Partial cleanup from the CONFIG_VECTOR16 removal.
Replace the DUP* expansions with the scalar argument.

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/tcg-runtime-gvec.c | 50 +++++++++++-------------------------
 1 file changed, 15 insertions(+), 35 deletions(-)

diff --git a/accel/tcg/tcg-runtime-gvec.c b/accel/tcg/tcg-runtime-gvec.c
index 97852b515b..f2199f14b4 100644
--- a/accel/tcg/tcg-runtime-gvec.c
+++ b/accel/tcg/tcg-runtime-gvec.c
@@ -24,11 +24,6 @@
 #include "tcg/tcg-gvec-desc.h"
 
 
-#define DUP16(X)  X
-#define DUP8(X)   X
-#define DUP4(X)   X
-#define DUP2(X)   X
-
 static inline void clear_high(void *d, intptr_t oprsz, uint32_t desc)
 {
     intptr_t maxsz = simd_maxsz(desc);
@@ -88,11 +83,10 @@ void HELPER(gvec_add64)(void *d, void *a, void *b, uint32_t desc)
 void HELPER(gvec_adds8)(void *d, void *a, uint64_t b, uint32_t desc)
 {
     intptr_t oprsz = simd_oprsz(desc);
-    uint8_t vecb = (uint8_t)DUP16(b);
     intptr_t i;
 
     for (i = 0; i < oprsz; i += sizeof(uint8_t)) {
-        *(uint8_t *)(d + i) = *(uint8_t *)(a + i) + vecb;
+        *(uint8_t *)(d + i) = *(uint8_t *)(a + i) + (uint8_t)b;
     }
     clear_high(d, oprsz, desc);
 }
@@ -100,11 +94,10 @@ void HELPER(gvec_adds8)(void *d, void *a, uint64_t b, uint32_t desc)
 void HELPER(gvec_adds16)(void *d, void *a, uint64_t b, uint32_t desc)
 {
     intptr_t oprsz = simd_oprsz(desc);
-    uint16_t vecb = (uint16_t)DUP8(b);
     intptr_t i;
 
     for (i = 0; i < oprsz; i += sizeof(uint16_t)) {
-        *(uint16_t *)(d + i) = *(uint16_t *)(a + i) + vecb;
+        *(uint16_t *)(d + i) = *(uint16_t *)(a + i) + (uint16_t)b;
     }
     clear_high(d, oprsz, desc);
 }
@@ -112,11 +105,10 @@ void HELPER(gvec_adds16)(void *d, void *a, uint64_t b, uint32_t desc)
 void HELPER(gvec_adds32)(void *d, void *a, uint64_t b, uint32_t desc)
 {
     intptr_t oprsz = simd_oprsz(desc);
-    uint32_t vecb = (uint32_t)DUP4(b);
     intptr_t i;
 
     for (i = 0; i < oprsz; i += sizeof(uint32_t)) {
-        *(uint32_t *)(d + i) = *(uint32_t *)(a + i) + vecb;
+        *(uint32_t *)(d + i) = *(uint32_t *)(a + i) + (uint32_t)b;
     }
     clear_high(d, oprsz, desc);
 }
@@ -124,11 +116,10 @@ void HELPER(gvec_adds32)(void *d, void *a, uint64_t b, uint32_t desc)
 void HELPER(gvec_adds64)(void *d, void *a, uint64_t b, uint32_t desc)
 {
     intptr_t oprsz = simd_oprsz(desc);
-    uint64_t vecb = (uint64_t)DUP2(b);
     intptr_t i;
 
     for (i = 0; i < oprsz; i += sizeof(uint64_t)) {
-        *(uint64_t *)(d + i) = *(uint64_t *)(a + i) + vecb;
+        *(uint64_t *)(d + i) = *(uint64_t *)(a + i) + b;
     }
     clear_high(d, oprsz, desc);
 }
@@ -180,11 +171,10 @@ void HELPER(gvec_sub64)(void *d, void *a, void *b, uint32_t desc)
 void HELPER(gvec_subs8)(void *d, void *a, uint64_t b, uint32_t desc)
 {
     intptr_t oprsz = simd_oprsz(desc);
-    uint8_t vecb = (uint8_t)DUP16(b);
     intptr_t i;
 
     for (i = 0; i < oprsz; i += sizeof(uint8_t)) {
-        *(uint8_t *)(d + i) = *(uint8_t *)(a + i) - vecb;
+        *(uint8_t *)(d + i) = *(uint8_t *)(a + i) - (uint8_t)b;
     }
     clear_high(d, oprsz, desc);
 }
@@ -192,11 +182,10 @@ void HELPER(gvec_subs8)(void *d, void *a, uint64_t b, uint32_t desc)
 void HELPER(gvec_subs16)(void *d, void *a, uint64_t b, uint32_t desc)
 {
     intptr_t oprsz = simd_oprsz(desc);
-    uint16_t vecb = (uint16_t)DUP8(b);
     intptr_t i;
 
     for (i = 0; i < oprsz; i += sizeof(uint16_t)) {
-        *(uint16_t *)(d + i) = *(uint16_t *)(a + i) - vecb;
+        *(uint16_t *)(d + i) = *(uint16_t *)(a + i) - (uint16_t)b;
     }
     clear_high(d, oprsz, desc);
 }
@@ -204,11 +193,10 @@ void HELPER(gvec_subs16)(void *d, void *a, uint64_t b, uint32_t desc)
 void HELPER(gvec_subs32)(void *d, void *a, uint64_t b, uint32_t desc)
 {
     intptr_t oprsz = simd_oprsz(desc);
-    uint32_t vecb = (uint32_t)DUP4(b);
     intptr_t i;
 
     for (i = 0; i < oprsz; i += sizeof(uint32_t)) {
-        *(uint32_t *)(d + i) = *(uint32_t *)(a + i) - vecb;
+        *(uint32_t *)(d + i) = *(uint32_t *)(a + i) - (uint32_t)b;
     }
     clear_high(d, oprsz, desc);
 }
@@ -216,11 +204,10 @@ void HELPER(gvec_subs32)(void *d, void *a, uint64_t b, uint32_t desc)
 void HELPER(gvec_subs64)(void *d, void *a, uint64_t b, uint32_t desc)
 {
     intptr_t oprsz = simd_oprsz(desc);
-    uint64_t vecb = (uint64_t)DUP2(b);
     intptr_t i;
 
     for (i = 0; i < oprsz; i += sizeof(uint64_t)) {
-        *(uint64_t *)(d + i) = *(uint64_t *)(a + i) - vecb;
+        *(uint64_t *)(d + i) = *(uint64_t *)(a + i) - b;
     }
     clear_high(d, oprsz, desc);
 }
@@ -272,11 +259,10 @@ void HELPER(gvec_mul64)(void *d, void *a, void *b, uint32_t desc)
 void HELPER(gvec_muls8)(void *d, void *a, uint64_t b, uint32_t desc)
 {
     intptr_t oprsz = simd_oprsz(desc);
-    uint8_t vecb = (uint8_t)DUP16(b);
     intptr_t i;
 
     for (i = 0; i < oprsz; i += sizeof(uint8_t)) {
-        *(uint8_t *)(d + i) = *(uint8_t *)(a + i) * vecb;
+        *(uint8_t *)(d + i) = *(uint8_t *)(a + i) * (uint8_t)b;
     }
     clear_high(d, oprsz, desc);
 }
@@ -284,11 +270,10 @@ void HELPER(gvec_muls8)(void *d, void *a, uint64_t b, uint32_t desc)
 void HELPER(gvec_muls16)(void *d, void *a, uint64_t b, uint32_t desc)
 {
     intptr_t oprsz = simd_oprsz(desc);
-    uint16_t vecb = (uint16_t)DUP8(b);
     intptr_t i;
 
     for (i = 0; i < oprsz; i += sizeof(uint16_t)) {
-        *(uint16_t *)(d + i) = *(uint16_t *)(a + i) * vecb;
+        *(uint16_t *)(d + i) = *(uint16_t *)(a + i) * (uint16_t)b;
     }
     clear_high(d, oprsz, desc);
 }
@@ -296,11 +281,10 @@ void HELPER(gvec_muls16)(void *d, void *a, uint64_t b, uint32_t desc)
 void HELPER(gvec_muls32)(void *d, void *a, uint64_t b, uint32_t desc)
 {
     intptr_t oprsz = simd_oprsz(desc);
-    uint32_t vecb = (uint32_t)DUP4(b);
     intptr_t i;
 
     for (i = 0; i < oprsz; i += sizeof(uint32_t)) {
-        *(uint32_t *)(d + i) = *(uint32_t *)(a + i) * vecb;
+        *(uint32_t *)(d + i) = *(uint32_t *)(a + i) * (uint32_t)b;
     }
     clear_high(d, oprsz, desc);
 }
@@ -308,11 +292,10 @@ void HELPER(gvec_muls32)(void *d, void *a, uint64_t b, uint32_t desc)
 void HELPER(gvec_muls64)(void *d, void *a, uint64_t b, uint32_t desc)
 {
     intptr_t oprsz = simd_oprsz(desc);
-    uint64_t vecb = (uint64_t)DUP2(b);
     intptr_t i;
 
     for (i = 0; i < oprsz; i += sizeof(uint64_t)) {
-        *(uint64_t *)(d + i) = *(uint64_t *)(a + i) * vecb;
+        *(uint64_t *)(d + i) = *(uint64_t *)(a + i) * b;
     }
     clear_high(d, oprsz, desc);
 }
@@ -559,11 +542,10 @@ void HELPER(gvec_eqv)(void *d, void *a, void *b, uint32_t desc)
 void HELPER(gvec_ands)(void *d, void *a, uint64_t b, uint32_t desc)
 {
     intptr_t oprsz = simd_oprsz(desc);
-    uint64_t vecb = (uint64_t)DUP2(b);
     intptr_t i;
 
     for (i = 0; i < oprsz; i += sizeof(uint64_t)) {
-        *(uint64_t *)(d + i) = *(uint64_t *)(a + i) & vecb;
+        *(uint64_t *)(d + i) = *(uint64_t *)(a + i) & b;
     }
     clear_high(d, oprsz, desc);
 }
@@ -571,11 +553,10 @@ void HELPER(gvec_ands)(void *d, void *a, uint64_t b, uint32_t desc)
 void HELPER(gvec_xors)(void *d, void *a, uint64_t b, uint32_t desc)
 {
     intptr_t oprsz = simd_oprsz(desc);
-    uint64_t vecb = (uint64_t)DUP2(b);
     intptr_t i;
 
     for (i = 0; i < oprsz; i += sizeof(uint64_t)) {
-        *(uint64_t *)(d + i) = *(uint64_t *)(a + i) ^ vecb;
+        *(uint64_t *)(d + i) = *(uint64_t *)(a + i) ^ b;
     }
     clear_high(d, oprsz, desc);
 }
@@ -583,11 +564,10 @@ void HELPER(gvec_xors)(void *d, void *a, uint64_t b, uint32_t desc)
 void HELPER(gvec_ors)(void *d, void *a, uint64_t b, uint32_t desc)
 {
     intptr_t oprsz = simd_oprsz(desc);
-    uint64_t vecb = (uint64_t)DUP2(b);
     intptr_t i;
 
     for (i = 0; i < oprsz; i += sizeof(uint64_t)) {
-        *(uint64_t *)(d + i) = *(uint64_t *)(a + i) | vecb;
+        *(uint64_t *)(d + i) = *(uint64_t *)(a + i) | b;
     }
     clear_high(d, oprsz, desc);
 }
-- 
2.20.1


