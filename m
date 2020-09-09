Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5DE9C43461
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 00:17:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 651F52145D
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 00:17:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="APzT0ssM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 651F52145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57688 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFnoC-00013y-ED
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 20:17:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37174)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kFnnH-0007eh-Ch
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 20:16:59 -0400
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044]:36996)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kFnnC-00028Y-K2
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 20:16:59 -0400
Received: by mail-pj1-x1044.google.com with SMTP id kk9so432551pjb.2
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2020 17:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=qseC2YwIOefPH/0qbFQ7mgbdCBiS9lx6tHPE8i+cDZQ=;
 b=APzT0ssMUK+Zw5uCrba6nyrgaPnOrf614op5YMdLNMsDiLlepAFNFsuXc9zhpV5Dqi
 iaWbJoN+woPCDrHnOPfV9fngMgS4alfOgK4Aq0bU9tL9FzMKeQYe2rWImpFvwLLFsoSS
 33qbP3mHOPtumRLCZ1tTcLASdkN+uy21pPf1JITbgaP320ZAo3z2lYgZu/wmRqi32dgD
 Kid/epDWCYsITOxSSexebMLeA9qXuZeB9uBMyIWhdOX/6KNcL7Nf2dxk87lsQE50ohCc
 FRBfYs25HEOAaWdCsm7pdbSyddONniYa47JAVjygnd3TeQN5A+3JdpE+Fpeh1t31rTQv
 45yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=qseC2YwIOefPH/0qbFQ7mgbdCBiS9lx6tHPE8i+cDZQ=;
 b=AivSHO9VSaK35TpWn8Y+UZnvoYCcTNm3z9XlQ5cpgaBC5zsMgfozIh/vUIbOYekEqk
 97xhtX/eLL7fScOcw2kYccdhfV0SsTeAxDbc9PvSfaZPNm75ek5iIf8MEp8hCkZgF843
 s2TtNQC4zKaooe2pU15gmPqJmOlBCTWef/jZeJqRCGnNDxiu279MhgNPsI/skNJGCQTi
 zdv47EtCiwzF+LVw3+MNIaOxskMW1EvIwxLS3yEGu2oGjZHFf1gmc0AcEYB9Bln+A3yW
 atCvRvV4gwUsn0mw4uBQLG/yDlUXgCmSEJsVVMG1/SFRKVH6HF5RAxYBKwte+nrH3yW8
 PGVQ==
X-Gm-Message-State: AOAM5314VhMnQy/SWKEJa8cwttQfEsNN4Iy58hjz3ymM6R33cqOC0GbA
 SJvC4DFhtVSiL+ZoDcyV+zZ36EFh/MhhMA==
X-Google-Smtp-Source: ABdhPJw5ZznBS93NQE9gkCHegBcw/ww/h8ZTiBWbPDZEWByXdi2Cq1Yh+tvqiIijgt2hk5A+4ri6fg==
X-Received: by 2002:a17:90b:4acd:: with SMTP id
 mh13mr1220025pjb.147.1599610611113; 
 Tue, 08 Sep 2020 17:16:51 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id 137sm505437pfu.149.2020.09.08.17.16.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2020 17:16:50 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 01/43] tcg: Adjust simd_desc size encoding
Date: Tue,  8 Sep 2020 17:16:05 -0700
Message-Id: <20200909001647.532249-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200909001647.532249-1-richard.henderson@linaro.org>
References: <20200909001647.532249-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1044;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1044.google.com
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

With larger vector sizes, it turns out oprsz == maxsz, and we only
need to represent mismatch for oprsz <= 32.  We do, however, need
to represent larger oprsz and do so without reducing SIMD_DATA_BITS.

Reduce the size of the oprsz field and increase the maxsz field.
Steal the oprsz value of 24 to indicate equality with maxsz.

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-gvec-desc.h | 38 ++++++++++++++++++++++++-------------
 tcg/tcg-op-gvec.c           | 35 ++++++++++++++++++++++++++--------
 2 files changed, 52 insertions(+), 21 deletions(-)

diff --git a/include/tcg/tcg-gvec-desc.h b/include/tcg/tcg-gvec-desc.h
index 0224ac3e78..704bd86454 100644
--- a/include/tcg/tcg-gvec-desc.h
+++ b/include/tcg/tcg-gvec-desc.h
@@ -20,29 +20,41 @@
 #ifndef TCG_TCG_GVEC_DESC_H
 #define TCG_TCG_GVEC_DESC_H
 
-/* ??? These bit widths are set for ARM SVE, maxing out at 256 byte vectors. */
-#define SIMD_OPRSZ_SHIFT   0
-#define SIMD_OPRSZ_BITS    5
+/*
+ * This configuration allows MAXSZ to represent 2048 bytes, and
+ * OPRSZ to match MAXSZ, or represent the smaller values 8, 16, or 32.
+ *
+ * Encode this with:
+ *   0, 1, 3 -> 8, 16, 32
+ *   2       -> maxsz
+ *
+ * This steals the input that would otherwise map to 24 to match maxsz.
+ */
+#define SIMD_MAXSZ_SHIFT   0
+#define SIMD_MAXSZ_BITS    8
 
-#define SIMD_MAXSZ_SHIFT   (SIMD_OPRSZ_SHIFT + SIMD_OPRSZ_BITS)
-#define SIMD_MAXSZ_BITS    5
+#define SIMD_OPRSZ_SHIFT   (SIMD_MAXSZ_SHIFT + SIMD_MAXSZ_BITS)
+#define SIMD_OPRSZ_BITS    2
 
-#define SIMD_DATA_SHIFT    (SIMD_MAXSZ_SHIFT + SIMD_MAXSZ_BITS)
+#define SIMD_DATA_SHIFT    (SIMD_OPRSZ_SHIFT + SIMD_OPRSZ_BITS)
 #define SIMD_DATA_BITS     (32 - SIMD_DATA_SHIFT)
 
 /* Create a descriptor from components.  */
 uint32_t simd_desc(uint32_t oprsz, uint32_t maxsz, int32_t data);
 
-/* Extract the operation size from a descriptor.  */
-static inline intptr_t simd_oprsz(uint32_t desc)
-{
-    return (extract32(desc, SIMD_OPRSZ_SHIFT, SIMD_OPRSZ_BITS) + 1) * 8;
-}
-
 /* Extract the max vector size from a descriptor.  */
 static inline intptr_t simd_maxsz(uint32_t desc)
 {
-    return (extract32(desc, SIMD_MAXSZ_SHIFT, SIMD_MAXSZ_BITS) + 1) * 8;
+    return extract32(desc, SIMD_MAXSZ_SHIFT, SIMD_MAXSZ_BITS) * 8 + 8;
+}
+
+/* Extract the operation size from a descriptor.  */
+static inline intptr_t simd_oprsz(uint32_t desc)
+{
+    uint32_t f = extract32(desc, SIMD_OPRSZ_SHIFT, SIMD_OPRSZ_BITS);
+    intptr_t o = f * 8 + 8;
+    intptr_t m = simd_maxsz(desc);
+    return f == 2 ? m : o;
 }
 
 /* Extract the operation-specific data from a descriptor.  */
diff --git a/tcg/tcg-op-gvec.c b/tcg/tcg-op-gvec.c
index 7ebd9e8298..ddbe06b71a 100644
--- a/tcg/tcg-op-gvec.c
+++ b/tcg/tcg-op-gvec.c
@@ -37,11 +37,21 @@ static const TCGOpcode vecop_list_empty[1] = { 0 };
    of the operand offsets so that we can check them all at once.  */
 static void check_size_align(uint32_t oprsz, uint32_t maxsz, uint32_t ofs)
 {
-    uint32_t opr_align = oprsz >= 16 ? 15 : 7;
-    uint32_t max_align = maxsz >= 16 || oprsz >= 16 ? 15 : 7;
-    tcg_debug_assert(oprsz > 0);
-    tcg_debug_assert(oprsz <= maxsz);
-    tcg_debug_assert((oprsz & opr_align) == 0);
+    uint32_t max_align;
+
+    switch (oprsz) {
+    case 8:
+    case 16:
+    case 32:
+        tcg_debug_assert(oprsz <= maxsz);
+        break;
+    default:
+        tcg_debug_assert(oprsz == maxsz);
+        break;
+    }
+    tcg_debug_assert(maxsz <= (8 << SIMD_MAXSZ_BITS));
+
+    max_align = maxsz >= 16 ? 15 : 7;
     tcg_debug_assert((maxsz & max_align) == 0);
     tcg_debug_assert((ofs & max_align) == 0);
 }
@@ -77,12 +87,21 @@ uint32_t simd_desc(uint32_t oprsz, uint32_t maxsz, int32_t data)
 {
     uint32_t desc = 0;
 
-    assert(oprsz % 8 == 0 && oprsz <= (8 << SIMD_OPRSZ_BITS));
-    assert(maxsz % 8 == 0 && maxsz <= (8 << SIMD_MAXSZ_BITS));
-    assert(data == sextract32(data, 0, SIMD_DATA_BITS));
+    check_size_align(oprsz, maxsz, 0);
+    tcg_debug_assert(data == sextract32(data, 0, SIMD_DATA_BITS));
 
     oprsz = (oprsz / 8) - 1;
     maxsz = (maxsz / 8) - 1;
+
+    /*
+     * We have just asserted in check_size_align that either
+     * oprsz is {8,16,32} or matches maxsz.  Encode the final
+     * case with '2', as that would otherwise map to 24.
+     */
+    if (oprsz == maxsz) {
+        oprsz = 2;
+    }
+
     desc = deposit32(desc, SIMD_OPRSZ_SHIFT, SIMD_OPRSZ_BITS, oprsz);
     desc = deposit32(desc, SIMD_MAXSZ_SHIFT, SIMD_MAXSZ_BITS, maxsz);
     desc = deposit32(desc, SIMD_DATA_SHIFT, SIMD_DATA_BITS, data);
-- 
2.25.1


