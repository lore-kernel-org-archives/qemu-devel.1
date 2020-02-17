Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 945ECC7619B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 03:04:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EA8420857
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 03:04:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VdZt+kZU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EA8420857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39600 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3Whd-0008Cg-Kn
	for qemu-devel@archiver.kernel.org; Sun, 16 Feb 2020 22:04:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44830)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j3Wdh-00038Z-Ov
 for qemu-devel@nongnu.org; Sun, 16 Feb 2020 22:00:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j3Wdg-0003SG-7Z
 for qemu-devel@nongnu.org; Sun, 16 Feb 2020 22:00:05 -0500
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:42772)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j3Wdf-0003RA-W2
 for qemu-devel@nongnu.org; Sun, 16 Feb 2020 22:00:04 -0500
Received: by mail-pl1-x644.google.com with SMTP id e8so6111167plt.9
 for <qemu-devel@nongnu.org>; Sun, 16 Feb 2020 19:00:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=qammuU2FWPQWuEwjhKHMcn2oQH2Te4EPi/n89dl8dB0=;
 b=VdZt+kZUoxWVvxjEOnK9PaPmOscEKcNmD6OYD93c/BHk9IjO0I5zPO8BxXGOxRrqBf
 hrK8p4YD0ucfN/buM4NndsS6oAzgo66JcHC5VDvxtW85d9ZadKqLFWDfoYI2A3mkUZGY
 p2Fy7COlLA9AWwuMHWQguPh+qBjhUZrqDpOHYxuYHziCXnsAXHoKVctBPmWkP6/y4ZQ9
 YDuw74XBsz+iYa/zVmRpCyqUaNwpxHlgW1WyHMytN3PxCvUxKjLTSUc7RnFoPN9cMxd+
 KCjFMxmnAGcKFPOMRo8uWd5l/c/LD1cBjGFCdrzh2hAqEpKxDiUEI53gRQsb10cuSURb
 8M2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=qammuU2FWPQWuEwjhKHMcn2oQH2Te4EPi/n89dl8dB0=;
 b=GPEattUXzgUpIsBEjJSSWy/z78U5VifvZ4uf2JhCL7y1yQRuv0CnIeS0Fi2gnjGOfF
 cbWcJZUlUeorxX8HLx3arWa2z9NmmODqfrbdYRNX5DWWSzGspAv1FokMZ1TuvVJU5MFl
 O3biLWoYmzLz8+HWiNSkjVHAyaxQcYMkEu7FAIz8mfb++IEwbFC7ZSANT5B8w84BcCkA
 Xv2x/870vTICVSrOpkbQAKKi9U3MVgqtQM55rZepOunTtd3JYeBJxvWzmjHJ8s+HmsWZ
 ELksiaisdief48syQBGiuiZmcuDp/WLck8NKu32E6cbgU8NN94T4Xfs2zNQakQnZDJGO
 37GQ==
X-Gm-Message-State: APjAAAUs5RZpBGJJJzJkkCJ3Tb0e/xulNBMGBYHu6N2G0t9AjAo+eT1A
 b0B8MH58FZDRaMp//ISd5eGeA/L+VxU=
X-Google-Smtp-Source: APXvYqyHrgs4X9Ts4OuaKmx9RBcvTeWsbeSApHO0U4RpThrS74nldH0Oe/UAN7VPabgRco5yqBL2/Q==
X-Received: by 2002:a17:902:760e:: with SMTP id
 k14mr13448579pll.119.1581908402487; 
 Sun, 16 Feb 2020 19:00:02 -0800 (PST)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id u2sm14741060pgj.7.2020.02.16.19.00.01
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2020 19:00:01 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/4] tcg: Tidy tcg-runtime-gvec.c DUP*
Date: Sun, 16 Feb 2020 18:59:56 -0800
Message-Id: <20200217025957.12031-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200217025957.12031-1-richard.henderson@linaro.org>
References: <20200217025957.12031-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::644
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
Replace the DUP* expansions with the scalar argument.

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


