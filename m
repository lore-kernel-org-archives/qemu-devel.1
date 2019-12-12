Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42B06C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 04:05:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C77B22527
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 04:05:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tyjPcK4E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C77B22527
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53934 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifFjc-0006LV-3M
	for qemu-devel@archiver.kernel.org; Wed, 11 Dec 2019 23:05:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48328)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ifFes-0000r7-2q
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 23:00:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ifFem-000403-VF
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 23:00:56 -0500
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:40123)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ifFem-0003y5-KK
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 23:00:52 -0500
Received: by mail-pl1-x644.google.com with SMTP id g6so756plp.7
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2019 20:00:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=8YMOjliCdpjOfsXyx7R7DH1pWxj9O80SkuA3OFxkquc=;
 b=tyjPcK4EFLmW4s+b3elPuua40KFJijxOyeA6E5hA1BAYioHoNY790aDeH1P67cRI6t
 BoXTERpaltgtSKLsBFVYpBBca6lgV1OoEi9uGaMx9c9D5tiEvnfoM1eD2CUCzuOwgBJs
 oNoafO1AaPTjyDNBiENr+ySt/m3AYaL4IURpp8vcISjYt4uqS569dYmkZR9ZcX4n9Yp/
 AG9IuahqnjxQ2REjWNQhbYJ0tGDNNJJhuhq0ZptEE6bCtOzWzAwa21J1JJgMd90/Ype5
 77TafLuolcsbuiqr2L6X/W3tk4a5eX726q6wzFTy8cLgiK1fWl9lli9VBXVjPpQoRE45
 wvmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=8YMOjliCdpjOfsXyx7R7DH1pWxj9O80SkuA3OFxkquc=;
 b=CUJVF93UcHW1ZIrrGWLjXoJVQEHgce9cqOtDRcwngTXB9xUABi3h7cOMqiU+LPh5C7
 545cSeSaolU82q5l2/ys/l91jy02WBMKwkVFYV63JzXDqJrcBis3ko+If/3zMjyXVqGM
 0E7a02BaonE313Ve5hONPrA3kQY+7GI8MrnuzzZ10raI4oeSYBueCNI1fi9afQzdYpsr
 /ydW7ITbjAhbZsYtHuNi3IpPx1f0B/Hse54+DPj704u3yJt2CRIBt23RWhGL5UamvhcE
 QDq+ixPMSAr1L3QaDVZOIH9+06hzT7z84hh4drG/GNQSwEYnt+/o7+aouqkSOdZHIAKI
 CTHA==
X-Gm-Message-State: APjAAAWHLVQf2tmTnQ6tGL+3RaWjscLpgk27P0xMyUcHjeMOm0Iwa6sm
 FYzEHKXDrikQUAGqzzxq8m0x9KHmkUw=
X-Google-Smtp-Source: APXvYqz7Pdjc9lMzDWpDpghdNW7QdDgj6SUFa3x24DtARp8plRtz0z0t+gtYvG//sALa2gwi/avg2g==
X-Received: by 2002:a17:902:7287:: with SMTP id
 d7mr7181068pll.17.1576123250094; 
 Wed, 11 Dec 2019 20:00:50 -0800 (PST)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id z130sm4666391pgz.6.2019.12.11.20.00.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2019 20:00:49 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 07/28] cputlb: Provide cpu_(ld,st}*_mmuidx_ra for user-only
Date: Wed, 11 Dec 2019 20:00:18 -0800
Message-Id: <20191212040039.26546-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191212040039.26546-1-richard.henderson@linaro.org>
References: <20191212040039.26546-1-richard.henderson@linaro.org>
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

This finishes the new interface began with the previous patch.
Document the interface and deprecate MMU_MODE<N>_SUFFIX.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/cpu_ldst.h | 84 ++++++++++++++++++++++++++++++++++++++---
 1 file changed, 79 insertions(+), 5 deletions(-)

diff --git a/include/exec/cpu_ldst.h b/include/exec/cpu_ldst.h
index ef59ed61e4..3b2c46bdf4 100644
--- a/include/exec/cpu_ldst.h
+++ b/include/exec/cpu_ldst.h
@@ -25,9 +25,13 @@
  *
  * The syntax for the accessors is:
  *
- * load: cpu_ld{sign}{size}_{mmusuffix}(env, ptr)
+ * load:  cpu_ld{sign}{size}_{mmusuffix}(env, ptr)
+ *        cpu_ld{sign}{size}_{mmusuffix}_ra(env, ptr, retaddr)
+ *        cpu_ld{sign}{size}_mmuidx_ra(env, ptr, mmu_idx, retaddr)
  *
- * store: cpu_st{sign}{size}_{mmusuffix}(env, ptr, val)
+ * store: cpu_st{size}_{mmusuffix}(env, ptr, val)
+ *        cpu_st{size}_{mmusuffix}_ra(env, ptr, val, retaddr)
+ *        cpu_st{size}_mmuidx_ra(env, ptr, val, mmu_idx, retaddr)
  *
  * sign is:
  * (empty): for 32 and 64 bit sizes
@@ -40,9 +44,14 @@
  *   l: 32 bits
  *   q: 64 bits
  *
- * mmusuffix is one of the generic suffixes "data" or "code", or
- * (for softmmu configs)  a target-specific MMU mode suffix as defined
- * in target cpu.h.
+ * mmusuffix is one of the generic suffixes "data" or "code", or "mmuidx".
+ * The "mmuidx" suffix carries an extra mmu_idx argument that specifies
+ * the index to use; the "data" and "code" suffixes take the index from
+ * cpu_mmu_index().
+ *
+ * Deprecated: for softmmu configs, mmusuffix may be a target-specific MMU
+ * mode suffix as defined in target cpu.h.  These should be replaced by
+ * one of the "mmuidx" functions.
  */
 #ifndef CPU_LDST_H
 #define CPU_LDST_H
@@ -145,6 +154,71 @@ static inline void clear_helper_retaddr(void)
 #undef MEMSUFFIX
 #undef CODE_ACCESS
 
+/*
+ * Provide the same *_mmuidx_ra interface as for softmmu.
+ * The mmu_idx argument is ignored.
+ */
+
+static inline uint32_t cpu_ldub_mmuidx_ra(CPUArchState *env, abi_ptr addr,
+                                          int mmu_idx, uintptr_t ra)
+{
+    return cpu_ldub_data_ra(env, addr, ra);
+}
+
+static inline uint32_t cpu_lduw_mmuidx_ra(CPUArchState *env, abi_ptr addr,
+                                          int mmu_idx, uintptr_t ra)
+{
+    return cpu_lduw_data_ra(env, addr, ra);
+}
+
+static inline uint32_t cpu_ldl_mmuidx_ra(CPUArchState *env, abi_ptr addr,
+                                         int mmu_idx, uintptr_t ra)
+{
+    return cpu_ldl_data_ra(env, addr, ra);
+}
+
+static inline uint64_t cpu_ldq_mmuidx_ra(CPUArchState *env, abi_ptr addr,
+                                         int mmu_idx, uintptr_t ra)
+{
+    return cpu_ldq_data_ra(env, addr, ra);
+}
+
+static inline int cpu_ldsb_mmuidx_ra(CPUArchState *env, abi_ptr addr,
+                                     int mmu_idx, uintptr_t ra)
+{
+    return cpu_ldsb_data_ra(env, addr, ra);
+}
+
+static inline int cpu_ldsw_mmuidx_ra(CPUArchState *env, abi_ptr addr,
+                                     int mmu_idx, uintptr_t ra)
+{
+    return cpu_ldsw_data_ra(env, addr, ra);
+}
+
+static inline void cpu_stb_mmuidx_ra(CPUArchState *env, abi_ptr addr,
+                                     uint32_t val, int mmu_idx, uintptr_t ra)
+{
+    cpu_stb_data_ra(env, addr, val, ra);
+}
+
+static inline void cpu_stw_mmuidx_ra(CPUArchState *env, abi_ptr addr,
+                                     uint32_t val, int mmu_idx, uintptr_t ra)
+{
+    cpu_stw_data_ra(env, addr, val, ra);
+}
+
+static inline void cpu_stl_mmuidx_ra(CPUArchState *env, abi_ptr addr,
+                                     uint32_t val, int mmu_idx, uintptr_t ra)
+{
+    cpu_stl_data_ra(env, addr, val, ra);
+}
+
+static inline void cpu_stq_mmuidx_ra(CPUArchState *env, abi_ptr addr,
+                                     uint64_t val, int mmu_idx, uintptr_t ra)
+{
+    cpu_stq_data_ra(env, addr, val, ra);
+}
+
 #else
 
 /* Needed for TCG_OVERSIZED_GUEST */
-- 
2.20.1


