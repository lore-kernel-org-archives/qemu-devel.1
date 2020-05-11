Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BD88C47255
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 13:43:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC946206B7
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 13:43:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tR5nuJmu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC946206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51024 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jY8i5-0002Yt-33
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 09:43:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49012)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jY8Zh-000263-Et
 for qemu-devel@nongnu.org; Mon, 11 May 2020 09:34:29 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b]:37586)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jY8Ze-00073w-6H
 for qemu-devel@nongnu.org; Mon, 11 May 2020 09:34:29 -0400
Received: by mail-wr1-x42b.google.com with SMTP id k1so11002244wrx.4
 for <qemu-devel@nongnu.org>; Mon, 11 May 2020 06:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=Du43sqI4TNRbw2ibtMce80G4lFxFLuU9nAqSLElfUqM=;
 b=tR5nuJmuClyTBBV3DuwecWJZXYpjq+d0TJRCIeDLq2LoOm3FA++akw3CA25TyRMDSm
 1UlusSmPt9RmcQ7iEOwn7WtG7gKzaiLSKlTJg8uqf2fjRjrklRr4u9SLUiFXYZAKnx9Q
 /agLRfU5YK4XNTxD9WrvYKsmmzuGHT90vbE7mflMqmqbzKJlvsuQy1NSdV1trywp/bh9
 uVYxTQJsGQkCQDes+QZCm1AH5T9AP/l8EO1N/Lhw+pRa7UcMSpVpJgOEfbFU672c5UAf
 WJPIrTWxmbmytht0qzD2oNKD4jwT8IqK2RB4z3EvhXDhycinb6cobMgmFFEEyqhhJlng
 9mzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Du43sqI4TNRbw2ibtMce80G4lFxFLuU9nAqSLElfUqM=;
 b=tuFR98tiW/g5Q6LDCeVKf+GJc9zn2cZYTd38IYX0r1e5BWaZJgUvdIHOeCa6MmdtHk
 awiBcJChBcQM9jflrUw9to7o/ozcLV3iNiDYdHfhOcF2GtfjbQonkhU8pqxhYxf2pYOt
 kKfT7AKjvXuK2NMheP4O77AfFxe7bxok1eD+zkSvBXD9EEr3cpHnX2K6EN3umaVYnCbN
 gsrl4pn394hvHDONwXjhn6KC8LEhw20X8ppwhYYtLOvUzjiFEJHGeQ7Wv/xt7aYQBrSv
 //3r/RDKjDhm2zM8VUt9dU6Uhl8btH+CMOnal5yB56RM4s//R5IpWHF1AJKv5BpE3Y8U
 rF7g==
X-Gm-Message-State: AGi0PuZW1jnn1vfUAiHexwEddxjVFVZ0oPuCT+mR2BZdY+UNObWHWss5
 G79iSIZti2NAuctbiR6wO/FNnUsCSu8tvg==
X-Google-Smtp-Source: APiQypJCzx1hWAnebFggio8I/f/oMh/IAKTEbBX7hHZnL9VQvQiMJcyboAjaZYkz9m+Rb8VrbBFdBg==
X-Received: by 2002:a5d:6690:: with SMTP id l16mr820047wru.115.1589204063977; 
 Mon, 11 May 2020 06:34:23 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id m3sm2154818wrn.96.2020.05.11.06.34.22
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2020 06:34:23 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 14/34] target/arm: Use cpu_*_data_ra for sve_ldst_tlb_fn
Date: Mon, 11 May 2020 14:33:45 +0100
Message-Id: <20200511133405.5275-15-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200511133405.5275-1-peter.maydell@linaro.org>
References: <20200511133405.5275-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42b.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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

From: Richard Henderson <richard.henderson@linaro.org>

Use the "normal" memory access functions, rather than the
softmmu internal helper functions directly.

Since fb901c905dc3, cpu_mem_index is now a simple extract
from env->hflags and not a large computation.  Which means
that it's now more work to pass around this value than it
is to recompute it.

This only adjusts the primitives, and does not clean up
all of the uses within sve_helper.c.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200508154359.7494-8-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/sve_helper.c | 221 ++++++++++++++++------------------------
 1 file changed, 86 insertions(+), 135 deletions(-)

diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
index fdfa6520946..655bc9476f4 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -3991,9 +3991,8 @@ typedef intptr_t sve_ld1_host_fn(void *vd, void *vg, void *host,
  * Load one element into @vd + @reg_off from (@env, @vaddr, @ra).
  * The controlling predicate is known to be true.
  */
-typedef void sve_ld1_tlb_fn(CPUARMState *env, void *vd, intptr_t reg_off,
-                            target_ulong vaddr, TCGMemOpIdx oi, uintptr_t ra);
-typedef sve_ld1_tlb_fn sve_st1_tlb_fn;
+typedef void sve_ldst1_tlb_fn(CPUARMState *env, void *vd, intptr_t reg_off,
+                              target_ulong vaddr, uintptr_t retaddr);
 
 /*
  * Generate the above primitives.
@@ -4016,27 +4015,23 @@ static intptr_t sve_##NAME##_host(void *vd, void *vg, void *host,           \
     return mem_off;                                                         \
 }
 
-#ifdef CONFIG_SOFTMMU
-#define DO_LD_TLB(NAME, H, TYPEE, TYPEM, HOST, MOEND, TLB) \
+#define DO_LD_TLB(NAME, H, TYPEE, TYPEM, TLB) \
 static void sve_##NAME##_tlb(CPUARMState *env, void *vd, intptr_t reg_off,  \
-                             target_ulong addr, TCGMemOpIdx oi, uintptr_t ra)  \
+                             target_ulong addr, uintptr_t ra)               \
 {                                                                           \
-    TYPEM val = TLB(env, addr, oi, ra);                                     \
-    *(TYPEE *)(vd + H(reg_off)) = val;                                      \
+    *(TYPEE *)(vd + H(reg_off)) = (TYPEM)TLB(env, addr, ra);                \
 }
-#else
-#define DO_LD_TLB(NAME, H, TYPEE, TYPEM, HOST, MOEND, TLB)                  \
+
+#define DO_ST_TLB(NAME, H, TYPEE, TYPEM, TLB) \
 static void sve_##NAME##_tlb(CPUARMState *env, void *vd, intptr_t reg_off,  \
-                             target_ulong addr, TCGMemOpIdx oi, uintptr_t ra)  \
+                             target_ulong addr, uintptr_t ra)               \
 {                                                                           \
-    TYPEM val = HOST(g2h(addr));                                            \
-    *(TYPEE *)(vd + H(reg_off)) = val;                                      \
+    TLB(env, addr, (TYPEM)*(TYPEE *)(vd + H(reg_off)), ra);                 \
 }
-#endif
 
 #define DO_LD_PRIM_1(NAME, H, TE, TM)                   \
     DO_LD_HOST(NAME, H, TE, TM, ldub_p)                 \
-    DO_LD_TLB(NAME, H, TE, TM, ldub_p, 0, helper_ret_ldub_mmu)
+    DO_LD_TLB(NAME, H, TE, TM, cpu_ldub_data_ra)
 
 DO_LD_PRIM_1(ld1bb,  H1,   uint8_t,  uint8_t)
 DO_LD_PRIM_1(ld1bhu, H1_2, uint16_t, uint8_t)
@@ -4046,39 +4041,51 @@ DO_LD_PRIM_1(ld1bss, H1_4, uint32_t,  int8_t)
 DO_LD_PRIM_1(ld1bdu,     , uint64_t, uint8_t)
 DO_LD_PRIM_1(ld1bds,     , uint64_t,  int8_t)
 
-#define DO_LD_PRIM_2(NAME, end, MOEND, H, TE, TM, PH, PT)  \
-    DO_LD_HOST(NAME##_##end, H, TE, TM, PH##_##end##_p)    \
-    DO_LD_TLB(NAME##_##end, H, TE, TM, PH##_##end##_p,     \
-              MOEND, helper_##end##_##PT##_mmu)
+#define DO_ST_PRIM_1(NAME, H, TE, TM)                   \
+    DO_ST_TLB(st1##NAME, H, TE, TM, cpu_stb_data_ra)
 
-DO_LD_PRIM_2(ld1hh,  le, MO_LE, H1_2, uint16_t, uint16_t, lduw, lduw)
-DO_LD_PRIM_2(ld1hsu, le, MO_LE, H1_4, uint32_t, uint16_t, lduw, lduw)
-DO_LD_PRIM_2(ld1hss, le, MO_LE, H1_4, uint32_t,  int16_t, lduw, lduw)
-DO_LD_PRIM_2(ld1hdu, le, MO_LE,     , uint64_t, uint16_t, lduw, lduw)
-DO_LD_PRIM_2(ld1hds, le, MO_LE,     , uint64_t,  int16_t, lduw, lduw)
+DO_ST_PRIM_1(bb,   H1,  uint8_t, uint8_t)
+DO_ST_PRIM_1(bh, H1_2, uint16_t, uint8_t)
+DO_ST_PRIM_1(bs, H1_4, uint32_t, uint8_t)
+DO_ST_PRIM_1(bd,     , uint64_t, uint8_t)
 
-DO_LD_PRIM_2(ld1ss,  le, MO_LE, H1_4, uint32_t, uint32_t, ldl, ldul)
-DO_LD_PRIM_2(ld1sdu, le, MO_LE,     , uint64_t, uint32_t, ldl, ldul)
-DO_LD_PRIM_2(ld1sds, le, MO_LE,     , uint64_t,  int32_t, ldl, ldul)
+#define DO_LD_PRIM_2(NAME, H, TE, TM, LD) \
+    DO_LD_HOST(ld1##NAME##_be, H, TE, TM, LD##_be_p)    \
+    DO_LD_HOST(ld1##NAME##_le, H, TE, TM, LD##_le_p)    \
+    DO_LD_TLB(ld1##NAME##_be, H, TE, TM, cpu_##LD##_be_data_ra) \
+    DO_LD_TLB(ld1##NAME##_le, H, TE, TM, cpu_##LD##_le_data_ra)
 
-DO_LD_PRIM_2(ld1dd,  le, MO_LE,     , uint64_t, uint64_t, ldq, ldq)
+#define DO_ST_PRIM_2(NAME, H, TE, TM, ST) \
+    DO_ST_TLB(st1##NAME##_be, H, TE, TM, cpu_##ST##_be_data_ra) \
+    DO_ST_TLB(st1##NAME##_le, H, TE, TM, cpu_##ST##_le_data_ra)
 
-DO_LD_PRIM_2(ld1hh,  be, MO_BE, H1_2, uint16_t, uint16_t, lduw, lduw)
-DO_LD_PRIM_2(ld1hsu, be, MO_BE, H1_4, uint32_t, uint16_t, lduw, lduw)
-DO_LD_PRIM_2(ld1hss, be, MO_BE, H1_4, uint32_t,  int16_t, lduw, lduw)
-DO_LD_PRIM_2(ld1hdu, be, MO_BE,     , uint64_t, uint16_t, lduw, lduw)
-DO_LD_PRIM_2(ld1hds, be, MO_BE,     , uint64_t,  int16_t, lduw, lduw)
+DO_LD_PRIM_2(hh,  H1_2, uint16_t, uint16_t, lduw)
+DO_LD_PRIM_2(hsu, H1_4, uint32_t, uint16_t, lduw)
+DO_LD_PRIM_2(hss, H1_4, uint32_t,  int16_t, lduw)
+DO_LD_PRIM_2(hdu,     , uint64_t, uint16_t, lduw)
+DO_LD_PRIM_2(hds,     , uint64_t,  int16_t, lduw)
 
-DO_LD_PRIM_2(ld1ss,  be, MO_BE, H1_4, uint32_t, uint32_t, ldl, ldul)
-DO_LD_PRIM_2(ld1sdu, be, MO_BE,     , uint64_t, uint32_t, ldl, ldul)
-DO_LD_PRIM_2(ld1sds, be, MO_BE,     , uint64_t,  int32_t, ldl, ldul)
+DO_ST_PRIM_2(hh, H1_2, uint16_t, uint16_t, stw)
+DO_ST_PRIM_2(hs, H1_4, uint32_t, uint16_t, stw)
+DO_ST_PRIM_2(hd,     , uint64_t, uint16_t, stw)
 
-DO_LD_PRIM_2(ld1dd,  be, MO_BE,     , uint64_t, uint64_t, ldq, ldq)
+DO_LD_PRIM_2(ss,  H1_4, uint32_t, uint32_t, ldl)
+DO_LD_PRIM_2(sdu,     , uint64_t, uint32_t, ldl)
+DO_LD_PRIM_2(sds,     , uint64_t,  int32_t, ldl)
+
+DO_ST_PRIM_2(ss, H1_4, uint32_t, uint32_t, stl)
+DO_ST_PRIM_2(sd,     , uint64_t, uint32_t, stl)
+
+DO_LD_PRIM_2(dd,     , uint64_t, uint64_t, ldq)
+DO_ST_PRIM_2(dd,     , uint64_t, uint64_t, stq)
 
 #undef DO_LD_TLB
+#undef DO_ST_TLB
 #undef DO_LD_HOST
 #undef DO_LD_PRIM_1
+#undef DO_ST_PRIM_1
 #undef DO_LD_PRIM_2
+#undef DO_ST_PRIM_2
 
 /*
  * Skip through a sequence of inactive elements in the guarding predicate @vg,
@@ -4152,7 +4159,7 @@ static void sve_ld1_r(CPUARMState *env, void *vg, const target_ulong addr,
                       uint32_t desc, const uintptr_t retaddr,
                       const int esz, const int msz,
                       sve_ld1_host_fn *host_fn,
-                      sve_ld1_tlb_fn *tlb_fn)
+                      sve_ldst1_tlb_fn *tlb_fn)
 {
     const TCGMemOpIdx oi = extract32(desc, SIMD_DATA_SHIFT, MEMOPIDX_SHIFT);
     const int mmu_idx = get_mmuidx(oi);
@@ -4234,7 +4241,7 @@ static void sve_ld1_r(CPUARMState *env, void *vg, const target_ulong addr,
          * on I/O memory, it may succeed but not bring in the TLB entry.
          * But even then we have still made forward progress.
          */
-        tlb_fn(env, &scratch, reg_off, addr + mem_off, oi, retaddr);
+        tlb_fn(env, &scratch, reg_off, addr + mem_off, retaddr);
         reg_off += 1 << esz;
     }
 #endif
@@ -4293,9 +4300,8 @@ DO_LD1_2(ld1dd,  3, 3)
  */
 static void sve_ld2_r(CPUARMState *env, void *vg, target_ulong addr,
                       uint32_t desc, int size, uintptr_t ra,
-                      sve_ld1_tlb_fn *tlb_fn)
+                      sve_ldst1_tlb_fn *tlb_fn)
 {
-    const TCGMemOpIdx oi = extract32(desc, SIMD_DATA_SHIFT, MEMOPIDX_SHIFT);
     const unsigned rd = extract32(desc, SIMD_DATA_SHIFT + MEMOPIDX_SHIFT, 5);
     intptr_t i, oprsz = simd_oprsz(desc);
     ARMVectorReg scratch[2] = { };
@@ -4305,8 +4311,8 @@ static void sve_ld2_r(CPUARMState *env, void *vg, target_ulong addr,
         uint16_t pg = *(uint16_t *)(vg + H1_2(i >> 3));
         do {
             if (pg & 1) {
-                tlb_fn(env, &scratch[0], i, addr, oi, ra);
-                tlb_fn(env, &scratch[1], i, addr + size, oi, ra);
+                tlb_fn(env, &scratch[0], i, addr, ra);
+                tlb_fn(env, &scratch[1], i, addr + size, ra);
             }
             i += size, pg >>= size;
             addr += 2 * size;
@@ -4321,9 +4327,8 @@ static void sve_ld2_r(CPUARMState *env, void *vg, target_ulong addr,
 
 static void sve_ld3_r(CPUARMState *env, void *vg, target_ulong addr,
                       uint32_t desc, int size, uintptr_t ra,
-                      sve_ld1_tlb_fn *tlb_fn)
+                      sve_ldst1_tlb_fn *tlb_fn)
 {
-    const TCGMemOpIdx oi = extract32(desc, SIMD_DATA_SHIFT, MEMOPIDX_SHIFT);
     const unsigned rd = extract32(desc, SIMD_DATA_SHIFT + MEMOPIDX_SHIFT, 5);
     intptr_t i, oprsz = simd_oprsz(desc);
     ARMVectorReg scratch[3] = { };
@@ -4333,9 +4338,9 @@ static void sve_ld3_r(CPUARMState *env, void *vg, target_ulong addr,
         uint16_t pg = *(uint16_t *)(vg + H1_2(i >> 3));
         do {
             if (pg & 1) {
-                tlb_fn(env, &scratch[0], i, addr, oi, ra);
-                tlb_fn(env, &scratch[1], i, addr + size, oi, ra);
-                tlb_fn(env, &scratch[2], i, addr + 2 * size, oi, ra);
+                tlb_fn(env, &scratch[0], i, addr, ra);
+                tlb_fn(env, &scratch[1], i, addr + size, ra);
+                tlb_fn(env, &scratch[2], i, addr + 2 * size, ra);
             }
             i += size, pg >>= size;
             addr += 3 * size;
@@ -4351,9 +4356,8 @@ static void sve_ld3_r(CPUARMState *env, void *vg, target_ulong addr,
 
 static void sve_ld4_r(CPUARMState *env, void *vg, target_ulong addr,
                       uint32_t desc, int size, uintptr_t ra,
-                      sve_ld1_tlb_fn *tlb_fn)
+                      sve_ldst1_tlb_fn *tlb_fn)
 {
-    const TCGMemOpIdx oi = extract32(desc, SIMD_DATA_SHIFT, MEMOPIDX_SHIFT);
     const unsigned rd = extract32(desc, SIMD_DATA_SHIFT + MEMOPIDX_SHIFT, 5);
     intptr_t i, oprsz = simd_oprsz(desc);
     ARMVectorReg scratch[4] = { };
@@ -4363,10 +4367,10 @@ static void sve_ld4_r(CPUARMState *env, void *vg, target_ulong addr,
         uint16_t pg = *(uint16_t *)(vg + H1_2(i >> 3));
         do {
             if (pg & 1) {
-                tlb_fn(env, &scratch[0], i, addr, oi, ra);
-                tlb_fn(env, &scratch[1], i, addr + size, oi, ra);
-                tlb_fn(env, &scratch[2], i, addr + 2 * size, oi, ra);
-                tlb_fn(env, &scratch[3], i, addr + 3 * size, oi, ra);
+                tlb_fn(env, &scratch[0], i, addr, ra);
+                tlb_fn(env, &scratch[1], i, addr + size, ra);
+                tlb_fn(env, &scratch[2], i, addr + 2 * size, ra);
+                tlb_fn(env, &scratch[3], i, addr + 3 * size, ra);
             }
             i += size, pg >>= size;
             addr += 4 * size;
@@ -4459,7 +4463,7 @@ static void sve_ldff1_r(CPUARMState *env, void *vg, const target_ulong addr,
                         uint32_t desc, const uintptr_t retaddr,
                         const int esz, const int msz,
                         sve_ld1_host_fn *host_fn,
-                        sve_ld1_tlb_fn *tlb_fn)
+                        sve_ldst1_tlb_fn *tlb_fn)
 {
     const TCGMemOpIdx oi = extract32(desc, SIMD_DATA_SHIFT, MEMOPIDX_SHIFT);
     const int mmu_idx = get_mmuidx(oi);
@@ -4519,7 +4523,7 @@ static void sve_ldff1_r(CPUARMState *env, void *vg, const target_ulong addr,
      * Perform one normal read, which will fault or not.
      * But it is likely to bring the page into the tlb.
      */
-    tlb_fn(env, vd, reg_off, addr + mem_off, oi, retaddr);
+    tlb_fn(env, vd, reg_off, addr + mem_off, retaddr);
 
     /* After any fault, zero any leading predicated false elts.  */
     swap_memzero(vd, reg_off);
@@ -4671,60 +4675,14 @@ DO_LDFF1_LDNF1_2(dd,  3, 3)
 #undef DO_LDFF1_LDNF1_1
 #undef DO_LDFF1_LDNF1_2
 
-/*
- * Store contiguous data, protected by a governing predicate.
- */
-
-#ifdef CONFIG_SOFTMMU
-#define DO_ST_TLB(NAME, H, TYPEM, HOST, MOEND, TLB) \
-static void sve_##NAME##_tlb(CPUARMState *env, void *vd, intptr_t reg_off,  \
-                             target_ulong addr, TCGMemOpIdx oi, uintptr_t ra) \
-{                                                                           \
-    TLB(env, addr, *(TYPEM *)(vd + H(reg_off)), oi, ra);                    \
-}
-#else
-#define DO_ST_TLB(NAME, H, TYPEM, HOST, MOEND, TLB) \
-static void sve_##NAME##_tlb(CPUARMState *env, void *vd, intptr_t reg_off,  \
-                             target_ulong addr, TCGMemOpIdx oi, uintptr_t ra) \
-{                                                                           \
-    HOST(g2h(addr), *(TYPEM *)(vd + H(reg_off)));                           \
-}
-#endif
-
-DO_ST_TLB(st1bb,   H1,  uint8_t, stb_p, 0, helper_ret_stb_mmu)
-DO_ST_TLB(st1bh, H1_2, uint16_t, stb_p, 0, helper_ret_stb_mmu)
-DO_ST_TLB(st1bs, H1_4, uint32_t, stb_p, 0, helper_ret_stb_mmu)
-DO_ST_TLB(st1bd,     , uint64_t, stb_p, 0, helper_ret_stb_mmu)
-
-DO_ST_TLB(st1hh_le, H1_2, uint16_t, stw_le_p, MO_LE, helper_le_stw_mmu)
-DO_ST_TLB(st1hs_le, H1_4, uint32_t, stw_le_p, MO_LE, helper_le_stw_mmu)
-DO_ST_TLB(st1hd_le,     , uint64_t, stw_le_p, MO_LE, helper_le_stw_mmu)
-
-DO_ST_TLB(st1ss_le, H1_4, uint32_t, stl_le_p, MO_LE, helper_le_stl_mmu)
-DO_ST_TLB(st1sd_le,     , uint64_t, stl_le_p, MO_LE, helper_le_stl_mmu)
-
-DO_ST_TLB(st1dd_le,     , uint64_t, stq_le_p, MO_LE, helper_le_stq_mmu)
-
-DO_ST_TLB(st1hh_be, H1_2, uint16_t, stw_be_p, MO_BE, helper_be_stw_mmu)
-DO_ST_TLB(st1hs_be, H1_4, uint32_t, stw_be_p, MO_BE, helper_be_stw_mmu)
-DO_ST_TLB(st1hd_be,     , uint64_t, stw_be_p, MO_BE, helper_be_stw_mmu)
-
-DO_ST_TLB(st1ss_be, H1_4, uint32_t, stl_be_p, MO_BE, helper_be_stl_mmu)
-DO_ST_TLB(st1sd_be,     , uint64_t, stl_be_p, MO_BE, helper_be_stl_mmu)
-
-DO_ST_TLB(st1dd_be,     , uint64_t, stq_be_p, MO_BE, helper_be_stq_mmu)
-
-#undef DO_ST_TLB
-
 /*
  * Common helpers for all contiguous 1,2,3,4-register predicated stores.
  */
 static void sve_st1_r(CPUARMState *env, void *vg, target_ulong addr,
                       uint32_t desc, const uintptr_t ra,
                       const int esize, const int msize,
-                      sve_st1_tlb_fn *tlb_fn)
+                      sve_ldst1_tlb_fn *tlb_fn)
 {
-    const TCGMemOpIdx oi = extract32(desc, SIMD_DATA_SHIFT, MEMOPIDX_SHIFT);
     const unsigned rd = extract32(desc, SIMD_DATA_SHIFT + MEMOPIDX_SHIFT, 5);
     intptr_t i, oprsz = simd_oprsz(desc);
     void *vd = &env->vfp.zregs[rd];
@@ -4734,7 +4692,7 @@ static void sve_st1_r(CPUARMState *env, void *vg, target_ulong addr,
         uint16_t pg = *(uint16_t *)(vg + H1_2(i >> 3));
         do {
             if (pg & 1) {
-                tlb_fn(env, vd, i, addr, oi, ra);
+                tlb_fn(env, vd, i, addr, ra);
             }
             i += esize, pg >>= esize;
             addr += msize;
@@ -4746,9 +4704,8 @@ static void sve_st1_r(CPUARMState *env, void *vg, target_ulong addr,
 static void sve_st2_r(CPUARMState *env, void *vg, target_ulong addr,
                       uint32_t desc, const uintptr_t ra,
                       const int esize, const int msize,
-                      sve_st1_tlb_fn *tlb_fn)
+                      sve_ldst1_tlb_fn *tlb_fn)
 {
-    const TCGMemOpIdx oi = extract32(desc, SIMD_DATA_SHIFT, MEMOPIDX_SHIFT);
     const unsigned rd = extract32(desc, SIMD_DATA_SHIFT + MEMOPIDX_SHIFT, 5);
     intptr_t i, oprsz = simd_oprsz(desc);
     void *d1 = &env->vfp.zregs[rd];
@@ -4759,8 +4716,8 @@ static void sve_st2_r(CPUARMState *env, void *vg, target_ulong addr,
         uint16_t pg = *(uint16_t *)(vg + H1_2(i >> 3));
         do {
             if (pg & 1) {
-                tlb_fn(env, d1, i, addr, oi, ra);
-                tlb_fn(env, d2, i, addr + msize, oi, ra);
+                tlb_fn(env, d1, i, addr, ra);
+                tlb_fn(env, d2, i, addr + msize, ra);
             }
             i += esize, pg >>= esize;
             addr += 2 * msize;
@@ -4772,9 +4729,8 @@ static void sve_st2_r(CPUARMState *env, void *vg, target_ulong addr,
 static void sve_st3_r(CPUARMState *env, void *vg, target_ulong addr,
                       uint32_t desc, const uintptr_t ra,
                       const int esize, const int msize,
-                      sve_st1_tlb_fn *tlb_fn)
+                      sve_ldst1_tlb_fn *tlb_fn)
 {
-    const TCGMemOpIdx oi = extract32(desc, SIMD_DATA_SHIFT, MEMOPIDX_SHIFT);
     const unsigned rd = extract32(desc, SIMD_DATA_SHIFT + MEMOPIDX_SHIFT, 5);
     intptr_t i, oprsz = simd_oprsz(desc);
     void *d1 = &env->vfp.zregs[rd];
@@ -4786,9 +4742,9 @@ static void sve_st3_r(CPUARMState *env, void *vg, target_ulong addr,
         uint16_t pg = *(uint16_t *)(vg + H1_2(i >> 3));
         do {
             if (pg & 1) {
-                tlb_fn(env, d1, i, addr, oi, ra);
-                tlb_fn(env, d2, i, addr + msize, oi, ra);
-                tlb_fn(env, d3, i, addr + 2 * msize, oi, ra);
+                tlb_fn(env, d1, i, addr, ra);
+                tlb_fn(env, d2, i, addr + msize, ra);
+                tlb_fn(env, d3, i, addr + 2 * msize, ra);
             }
             i += esize, pg >>= esize;
             addr += 3 * msize;
@@ -4800,9 +4756,8 @@ static void sve_st3_r(CPUARMState *env, void *vg, target_ulong addr,
 static void sve_st4_r(CPUARMState *env, void *vg, target_ulong addr,
                       uint32_t desc, const uintptr_t ra,
                       const int esize, const int msize,
-                      sve_st1_tlb_fn *tlb_fn)
+                      sve_ldst1_tlb_fn *tlb_fn)
 {
-    const TCGMemOpIdx oi = extract32(desc, SIMD_DATA_SHIFT, MEMOPIDX_SHIFT);
     const unsigned rd = extract32(desc, SIMD_DATA_SHIFT + MEMOPIDX_SHIFT, 5);
     intptr_t i, oprsz = simd_oprsz(desc);
     void *d1 = &env->vfp.zregs[rd];
@@ -4815,10 +4770,10 @@ static void sve_st4_r(CPUARMState *env, void *vg, target_ulong addr,
         uint16_t pg = *(uint16_t *)(vg + H1_2(i >> 3));
         do {
             if (pg & 1) {
-                tlb_fn(env, d1, i, addr, oi, ra);
-                tlb_fn(env, d2, i, addr + msize, oi, ra);
-                tlb_fn(env, d3, i, addr + 2 * msize, oi, ra);
-                tlb_fn(env, d4, i, addr + 3 * msize, oi, ra);
+                tlb_fn(env, d1, i, addr, ra);
+                tlb_fn(env, d2, i, addr + msize, ra);
+                tlb_fn(env, d3, i, addr + 2 * msize, ra);
+                tlb_fn(env, d4, i, addr + 3 * msize, ra);
             }
             i += esize, pg >>= esize;
             addr += 4 * msize;
@@ -4914,9 +4869,8 @@ static target_ulong off_zd_d(void *reg, intptr_t reg_ofs)
 
 static void sve_ld1_zs(CPUARMState *env, void *vd, void *vg, void *vm,
                        target_ulong base, uint32_t desc, uintptr_t ra,
-                       zreg_off_fn *off_fn, sve_ld1_tlb_fn *tlb_fn)
+                       zreg_off_fn *off_fn, sve_ldst1_tlb_fn *tlb_fn)
 {
-    const TCGMemOpIdx oi = extract32(desc, SIMD_DATA_SHIFT, MEMOPIDX_SHIFT);
     const int scale = extract32(desc, SIMD_DATA_SHIFT + MEMOPIDX_SHIFT, 2);
     intptr_t i, oprsz = simd_oprsz(desc);
     ARMVectorReg scratch = { };
@@ -4927,7 +4881,7 @@ static void sve_ld1_zs(CPUARMState *env, void *vd, void *vg, void *vm,
         do {
             if (likely(pg & 1)) {
                 target_ulong off = off_fn(vm, i);
-                tlb_fn(env, &scratch, i, base + (off << scale), oi, ra);
+                tlb_fn(env, &scratch, i, base + (off << scale), ra);
             }
             i += 4, pg >>= 4;
         } while (i & 15);
@@ -4940,9 +4894,8 @@ static void sve_ld1_zs(CPUARMState *env, void *vd, void *vg, void *vm,
 
 static void sve_ld1_zd(CPUARMState *env, void *vd, void *vg, void *vm,
                        target_ulong base, uint32_t desc, uintptr_t ra,
-                       zreg_off_fn *off_fn, sve_ld1_tlb_fn *tlb_fn)
+                       zreg_off_fn *off_fn, sve_ldst1_tlb_fn *tlb_fn)
 {
-    const TCGMemOpIdx oi = extract32(desc, SIMD_DATA_SHIFT, MEMOPIDX_SHIFT);
     const int scale = extract32(desc, SIMD_DATA_SHIFT + MEMOPIDX_SHIFT, 2);
     intptr_t i, oprsz = simd_oprsz(desc) / 8;
     ARMVectorReg scratch = { };
@@ -4952,7 +4905,7 @@ static void sve_ld1_zd(CPUARMState *env, void *vd, void *vg, void *vm,
         uint8_t pg = *(uint8_t *)(vg + H1(i));
         if (likely(pg & 1)) {
             target_ulong off = off_fn(vm, i * 8);
-            tlb_fn(env, &scratch, i * 8, base + (off << scale), oi, ra);
+            tlb_fn(env, &scratch, i * 8, base + (off << scale), ra);
         }
     }
     clear_helper_retaddr();
@@ -5114,7 +5067,7 @@ DO_LD_NF(dd_be,      , uint64_t, uint64_t, ldq_be_p)
  */
 static inline void sve_ldff1_zs(CPUARMState *env, void *vd, void *vg, void *vm,
                                 target_ulong base, uint32_t desc, uintptr_t ra,
-                                zreg_off_fn *off_fn, sve_ld1_tlb_fn *tlb_fn,
+                                zreg_off_fn *off_fn, sve_ldst1_tlb_fn *tlb_fn,
                                 sve_ld1_nf_fn *nonfault_fn)
 {
     const TCGMemOpIdx oi = extract32(desc, SIMD_DATA_SHIFT, MEMOPIDX_SHIFT);
@@ -5130,7 +5083,7 @@ static inline void sve_ldff1_zs(CPUARMState *env, void *vd, void *vg, void *vm,
         set_helper_retaddr(ra);
         addr = off_fn(vm, reg_off);
         addr = base + (addr << scale);
-        tlb_fn(env, vd, reg_off, addr, oi, ra);
+        tlb_fn(env, vd, reg_off, addr, ra);
 
         /* The rest of the reads will be non-faulting.  */
         clear_helper_retaddr();
@@ -5156,7 +5109,7 @@ static inline void sve_ldff1_zs(CPUARMState *env, void *vd, void *vg, void *vm,
 
 static inline void sve_ldff1_zd(CPUARMState *env, void *vd, void *vg, void *vm,
                                 target_ulong base, uint32_t desc, uintptr_t ra,
-                                zreg_off_fn *off_fn, sve_ld1_tlb_fn *tlb_fn,
+                                zreg_off_fn *off_fn, sve_ldst1_tlb_fn *tlb_fn,
                                 sve_ld1_nf_fn *nonfault_fn)
 {
     const TCGMemOpIdx oi = extract32(desc, SIMD_DATA_SHIFT, MEMOPIDX_SHIFT);
@@ -5172,7 +5125,7 @@ static inline void sve_ldff1_zd(CPUARMState *env, void *vd, void *vg, void *vm,
         set_helper_retaddr(ra);
         addr = off_fn(vm, reg_off);
         addr = base + (addr << scale);
-        tlb_fn(env, vd, reg_off, addr, oi, ra);
+        tlb_fn(env, vd, reg_off, addr, ra);
 
         /* The rest of the reads will be non-faulting.  */
         clear_helper_retaddr();
@@ -5282,9 +5235,8 @@ DO_LDFF1_ZPZ_D(dd_be, zd)
 
 static void sve_st1_zs(CPUARMState *env, void *vd, void *vg, void *vm,
                        target_ulong base, uint32_t desc, uintptr_t ra,
-                       zreg_off_fn *off_fn, sve_ld1_tlb_fn *tlb_fn)
+                       zreg_off_fn *off_fn, sve_ldst1_tlb_fn *tlb_fn)
 {
-    const TCGMemOpIdx oi = extract32(desc, SIMD_DATA_SHIFT, MEMOPIDX_SHIFT);
     const int scale = extract32(desc, SIMD_DATA_SHIFT + MEMOPIDX_SHIFT, 2);
     intptr_t i, oprsz = simd_oprsz(desc);
 
@@ -5294,7 +5246,7 @@ static void sve_st1_zs(CPUARMState *env, void *vd, void *vg, void *vm,
         do {
             if (likely(pg & 1)) {
                 target_ulong off = off_fn(vm, i);
-                tlb_fn(env, vd, i, base + (off << scale), oi, ra);
+                tlb_fn(env, vd, i, base + (off << scale), ra);
             }
             i += 4, pg >>= 4;
         } while (i & 15);
@@ -5304,9 +5256,8 @@ static void sve_st1_zs(CPUARMState *env, void *vd, void *vg, void *vm,
 
 static void sve_st1_zd(CPUARMState *env, void *vd, void *vg, void *vm,
                        target_ulong base, uint32_t desc, uintptr_t ra,
-                       zreg_off_fn *off_fn, sve_ld1_tlb_fn *tlb_fn)
+                       zreg_off_fn *off_fn, sve_ldst1_tlb_fn *tlb_fn)
 {
-    const TCGMemOpIdx oi = extract32(desc, SIMD_DATA_SHIFT, MEMOPIDX_SHIFT);
     const int scale = extract32(desc, SIMD_DATA_SHIFT + MEMOPIDX_SHIFT, 2);
     intptr_t i, oprsz = simd_oprsz(desc) / 8;
 
@@ -5315,7 +5266,7 @@ static void sve_st1_zd(CPUARMState *env, void *vd, void *vg, void *vm,
         uint8_t pg = *(uint8_t *)(vg + H1(i));
         if (likely(pg & 1)) {
             target_ulong off = off_fn(vm, i * 8);
-            tlb_fn(env, vd, i * 8, base + (off << scale), oi, ra);
+            tlb_fn(env, vd, i * 8, base + (off << scale), ra);
         }
     }
     clear_helper_retaddr();
-- 
2.20.1


