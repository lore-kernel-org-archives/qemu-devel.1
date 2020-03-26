Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F7D9C43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 23:18:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7B8A20714
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 23:18:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uZP/lhXQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7B8A20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34724 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHblF-0008Ci-1E
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 19:18:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59043)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jHbcc-0002p0-NG
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 19:09:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jHbcb-0001o9-Ff
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 19:09:10 -0400
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044]:39645)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jHbcb-0001nC-9n
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 19:09:09 -0400
Received: by mail-pj1-x1044.google.com with SMTP id z3so2516243pjr.4
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2020 16:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=shWQ4UzPuX9NwbrJUFloHvE+a/223KVCdbky39wDCzw=;
 b=uZP/lhXQ9+6tllKEfEN0KkQUWibVsIqtbsoZx4jNPeMpoCPd23g11WKmPnIa24KHvk
 Z8auWRPUzDsWDFnhCnEDBhqnR4kbtFkKd9AHAO2D3CAjoPijiF54ECmCyfg1C9PfRIh8
 upojrFhm9RyZD2WkX2yWbtqOBS2SDeOBjI9RxSd6zitwCvctGM4alAv4Cjf+6wZn5bnS
 3r+cvru6wsrE8ht/2U/gR6IsiTRnmCRT7Oh0SyQG2tQaES7HFfV2fFkUmKK2ZOIu+O40
 jwI0prwSLnx2LeKppVkYjRRWYj5B9mtLbdm6pBkOpr1fh+eyewl7MFbXpphdoKXBB+lU
 7hOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=shWQ4UzPuX9NwbrJUFloHvE+a/223KVCdbky39wDCzw=;
 b=XLXfp7MOZgIRLnTH45yw3lI5M1L/YUHL4Hnm1H7gXfQLZfrP5iwW+86wFr2XWeKKiO
 Rv9xlE/hv0dJ5oRFwgFhY5LVBVKsIYy5VXb+q/U+Sq3LXQZiJ2FQYmDrR7TXyOrQIo5g
 5hm+D7hVlFfWv8KieKNLgt/lqZ+Np1Idhn7cq2ahqQ/E4FoQhf1Vu1PQZmLbQttOawZe
 4ANdH6AFwMeTIVPP6BKEdpT64NvjdzG3/1ZYtsNSioOJId2AXHAlvuIMmbxFrxCYolpf
 Lv088/llDo//NOVERnUB39hULMeuMLPOJBQ+Ca4FMGvYgjAZq+XKjnGq5vu5POJugxD1
 4d2A==
X-Gm-Message-State: ANhLgQ3VTeK96CmeeTOC9l6kxVbNkIRuu11Q71uOA32uuEJMSVuGPq61
 xepr2J9fGTLCLJu1qy/+Pv5qFzIu2Vs=
X-Google-Smtp-Source: ADFU+vvPoE0JokHDMqWCBQi1uly8mCuS57fbi/6wXSF5yB1P3rnU44iiQAiMm15VeaFMe4Rlu6fLjQ==
X-Received: by 2002:a17:90a:9501:: with SMTP id
 t1mr2659209pjo.108.1585264147996; 
 Thu, 26 Mar 2020 16:09:07 -0700 (PDT)
Received: from localhost.localdomain (174-21-138-234.tukw.qwest.net.
 [174.21.138.234])
 by smtp.gmail.com with ESMTPSA id i187sm2530037pfg.33.2020.03.26.16.09.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2020 16:09:07 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 22/31] target/arm: Implement SVE2 integer add/subtract long
 with carry
Date: Thu, 26 Mar 2020 16:08:29 -0700
Message-Id: <20200326230838.31112-23-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200326230838.31112-1-richard.henderson@linaro.org>
References: <20200326230838.31112-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1044
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
Cc: rajav@quicinc.com, qemu-arm@nongnu.org, apazos@quicinc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper-sve.h    |  3 +++
 target/arm/sve.decode      |  6 ++++++
 target/arm/sve_helper.c    | 33 +++++++++++++++++++++++++++++++++
 target/arm/translate-sve.c | 23 +++++++++++++++++++++++
 4 files changed, 65 insertions(+)

diff --git a/target/arm/helper-sve.h b/target/arm/helper-sve.h
index b48a88135f..cfc1357613 100644
--- a/target/arm/helper-sve.h
+++ b/target/arm/helper-sve.h
@@ -2424,3 +2424,6 @@ DEF_HELPER_FLAGS_5(sve2_uabal_s, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(sve2_uabal_d, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_5(sve2_adcl_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve2_adcl_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
diff --git a/target/arm/sve.decode b/target/arm/sve.decode
index f66a6c242f..5d46e3ab45 100644
--- a/target/arm/sve.decode
+++ b/target/arm/sve.decode
@@ -1247,3 +1247,9 @@ SABALB          01000101 .. 0 ..... 1100 00 ..... .....  @rda_rn_rm
 SABALT          01000101 .. 0 ..... 1100 01 ..... .....  @rda_rn_rm
 UABALB          01000101 .. 0 ..... 1100 10 ..... .....  @rda_rn_rm
 UABALT          01000101 .. 0 ..... 1100 11 ..... .....  @rda_rn_rm
+
+## SVE2 integer add/subtract long with carry
+
+# ADC and SBC decoded via size in helper dispatch.
+ADCLB           01000101 .. 0 ..... 11010 0 ..... .....  @rda_rn_rm
+ADCLT           01000101 .. 0 ..... 11010 1 ..... .....  @rda_rn_rm
diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
index a0995d95c7..aa330f75c3 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -1240,6 +1240,39 @@ DO_ABAL(sve2_uabal_d, uint64_t, uint32_t)
 
 #undef DO_ABAL
 
+void HELPER(sve2_adcl_s)(void *vd, void *va, void *vn, void *vm, uint32_t desc)
+{
+    intptr_t i, opr_sz = simd_oprsz(desc);
+    int sel = extract32(desc, SIMD_DATA_SHIFT, 1) * 32;
+    uint32_t inv = -extract32(desc, SIMD_DATA_SHIFT + 1, 1);
+    uint64_t *d = vd, *a = va, *n = vn, *m = vm;
+
+    for (i = 0; i < opr_sz / 8; ++i) {
+        uint32_t e1 = (uint32_t)a[i];
+        uint32_t e2 = (uint32_t)(n[i] >> sel) ^ inv;
+        uint64_t c = extract64(m[i], 32, 1);
+        /* Compute and store the entire 33-bit result at once. */
+        d[i] = c + e1 + e2;
+    }
+}
+
+void HELPER(sve2_adcl_d)(void *vd, void *va, void *vn, void *vm, uint32_t desc)
+{
+    intptr_t i, opr_sz = simd_oprsz(desc);
+    int sel = extract32(desc, SIMD_DATA_SHIFT, 1) * 32;
+    uint64_t inv = -(uint64_t)extract32(desc, SIMD_DATA_SHIFT + 1, 1);
+    uint64_t *d = vd, *a = va, *n = vn, *m = vm;
+
+    for (i = 0; i < opr_sz / 8; i += 2) {
+        Int128 e1 = int128_make64(a[i]);
+        Int128 e2 = int128_make64(n[i + sel] ^ inv);
+        Int128 c = int128_make64(m[i + 1] & 1);
+        Int128 r = int128_add(int128_add(e1, e2), c);
+        d[i + 0] = int128_getlo(r);
+        d[i + 1] = int128_gethi(r);
+    }
+}
+
 #define DO_BITPERM(NAME, TYPE, OP) \
 void HELPER(NAME)(void *vd, void *vn, void *vm, uint32_t desc) \
 {                                                              \
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index c6161d2ce2..a80765a978 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -6294,3 +6294,26 @@ static bool trans_UABALT(DisasContext *s, arg_rrrr_esz *a)
 {
     return do_abal(s, a, true, true);
 }
+
+static bool do_adcl(DisasContext *s, arg_rrrr_esz *a, bool sel)
+{
+    static gen_helper_gvec_4 * const fns[2] = {
+        gen_helper_sve2_adcl_s,
+        gen_helper_sve2_adcl_d,
+    };
+    /*
+     * Note that in this case the ESZ field encodes both size and sign.
+     * Split out 'subtract' into bit 1 of the data field for the helper.
+     */
+    return do_sve2_zzzz_ool(s, a, fns[a->esz & 1], (a->esz & 2) | sel);
+}
+
+static bool trans_ADCLB(DisasContext *s, arg_rrrr_esz *a)
+{
+    return do_adcl(s, a, false);
+}
+
+static bool trans_ADCLT(DisasContext *s, arg_rrrr_esz *a)
+{
+    return do_adcl(s, a, true);
+}
-- 
2.20.1


