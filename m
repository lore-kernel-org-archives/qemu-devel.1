Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C48BC43463
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 19:19:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17EEE21D7F
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 19:19:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H1kjFfGu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17EEE21D7F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45432 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJLuP-0000L9-59
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 15:19:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48322)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kJLHU-0000a5-Fg
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 14:38:48 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633]:40200)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kJLHO-0007AP-Ne
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 14:38:48 -0400
Received: by mail-pl1-x633.google.com with SMTP id bd2so3427354plb.7
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2020 11:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Ub2ynCDHLnvijoSLHJW2aWQL1n7R5p9vDIqMXp4ZHSk=;
 b=H1kjFfGuGUJLJrC45gAqwwG/PcE0N6UjVVW2N2+/vvCQxm0zAyoJ/YlV+albivg06L
 iP3W+NuQgagIcy6ZbztBaM4822HM6deWhiNN8PkEuiugj34z/Pc2PxfBBtJHUVwXlVOq
 0CS4W5E3aENok62PDVcEpJpRupoelM0nPlA/IX6Y4han93v4xCGvplhK+r+zVtYBUiNr
 I/ahWDx/bUEq8f5TpfovpdzPIC1aWPrK1zsezUWgoneWaCdwmbfB7/iQOhiDIXi0XN/O
 1dmB0EZK3mT3Ooo2SXKFJPt0XZhgUIPzz6iqKXlhkBWHCXsbnZqHcuTd5Yb6rkOjcdRV
 Y9Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Ub2ynCDHLnvijoSLHJW2aWQL1n7R5p9vDIqMXp4ZHSk=;
 b=eKy8wsVn+Ny6XOrufChCnp6GtRCxvZpiyBjKC9m2L5NoP88KCdHxq9oq6Hi/OeqQjN
 XsCW1+ntSVc4rYwzbHvTnjHWD+FCfXOYSJuewTo/MqFE1XeWO0c3rYlrGiit6l2kfXBX
 kx3nNb6M/Xnhx+5EKZteCR7D6ivj76CiRSGrvhWvYbhe9XiciFNOZeoowG/gkT3n5k4d
 8qk+N9stCK3DDwepp7eNMTyQkV1GHoAhan7Hg1+EgMhJ8uBryUUsXMMu0dMqOUVIDMho
 1duaXL3wnj3h2c6695ccZWBrCD330HTGjVN04XVL1sUy6GOUKK5WW4mm8Elw2FKpKv59
 450w==
X-Gm-Message-State: AOAM531NCBbN/5snx2yB6BOwsOePb4/DHyBWG7Cz9RTCdOLhCd7yiARI
 AecGCjQjA6XjPsWFPF1IPc3n1jhTPwSPtg==
X-Google-Smtp-Source: ABdhPJxo/bnRKZ8bRUsIZBPMSMacNidfGSf7kAM9DSd2X+Fx8taWyXqRpAT9ucVcENSGG87q05Nbcw==
X-Received: by 2002:a17:90b:20d1:: with SMTP id
 ju17mr13299274pjb.134.1600454320765; 
 Fri, 18 Sep 2020 11:38:40 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id f4sm3680723pfj.147.2020.09.18.11.38.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2020 11:38:39 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 36/81] target/arm: Implement SVE2 MATCH, NMATCH
Date: Fri, 18 Sep 2020 11:37:06 -0700
Message-Id: <20200918183751.2787647-37-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200918183751.2787647-1-richard.henderson@linaro.org>
References: <20200918183751.2787647-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org,
 Stephen Long <steplong@quicinc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Stephen Long <steplong@quicinc.com>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Stephen Long <steplong@quicinc.com>
Message-Id: <20200415145915.2859-1-steplong@quicinc.com>
[rth: Expanded comment for do_match2]
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
v2: Apply esz_mask to input pg to fix output flags.
---
 target/arm/helper-sve.h    | 10 ++++++
 target/arm/sve.decode      |  5 +++
 target/arm/sve_helper.c    | 64 ++++++++++++++++++++++++++++++++++++++
 target/arm/translate-sve.c | 22 +++++++++++++
 4 files changed, 101 insertions(+)

diff --git a/target/arm/helper-sve.h b/target/arm/helper-sve.h
index 923911ca21..7f53287f0d 100644
--- a/target/arm/helper-sve.h
+++ b/target/arm/helper-sve.h
@@ -2509,6 +2509,16 @@ DEF_HELPER_FLAGS_3(sve2_uqrshrnt_h, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
 DEF_HELPER_FLAGS_3(sve2_uqrshrnt_s, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
 DEF_HELPER_FLAGS_3(sve2_uqrshrnt_d, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
 
+DEF_HELPER_FLAGS_5(sve2_match_ppzz_b, TCG_CALL_NO_RWG,
+                   i32, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve2_match_ppzz_h, TCG_CALL_NO_RWG,
+                   i32, ptr, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_5(sve2_nmatch_ppzz_b, TCG_CALL_NO_RWG,
+                   i32, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve2_nmatch_ppzz_h, TCG_CALL_NO_RWG,
+                   i32, ptr, ptr, ptr, ptr, i32)
+
 DEF_HELPER_FLAGS_6(sve2_faddp_zpzz_h, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_6(sve2_faddp_zpzz_s, TCG_CALL_NO_RWG,
diff --git a/target/arm/sve.decode b/target/arm/sve.decode
index a50afd40c2..2207693d28 100644
--- a/target/arm/sve.decode
+++ b/target/arm/sve.decode
@@ -1320,6 +1320,11 @@ UQSHRNT         01000101 .. 1 ..... 00 1101 ..... .....  @rd_rn_tszimm_shr
 UQRSHRNB        01000101 .. 1 ..... 00 1110 ..... .....  @rd_rn_tszimm_shr
 UQRSHRNT        01000101 .. 1 ..... 00 1111 ..... .....  @rd_rn_tszimm_shr
 
+### SVE2 Character Match
+
+MATCH           01000101 .. 1 ..... 100 ... ..... 0 .... @pd_pg_rn_rm
+NMATCH          01000101 .. 1 ..... 100 ... ..... 1 .... @pd_pg_rn_rm
+
 ## SVE2 floating-point pairwise operations
 
 FADDP           01100100 .. 010 00 0 100 ... ..... ..... @rdn_pg_rm
diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
index aa7ff94812..139dea423f 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -6875,3 +6875,67 @@ void HELPER(sve2_nbsl)(void *vd, void *vn, void *vm, void *vk, uint32_t desc)
         d[i] = ~((n[i] & k[i]) | (m[i] & ~k[i]));
     }
 }
+
+/*
+ * Returns true if m0 or m1 contains the low uint8_t/uint16_t in n.
+ * See hasless(v,1) from
+ *   https://graphics.stanford.edu/~seander/bithacks.html#ZeroInWord
+ */
+static inline bool do_match2(uint64_t n, uint64_t m0, uint64_t m1, int esz)
+{
+    int bits = 8 << esz;
+    uint64_t ones = dup_const(esz, 1);
+    uint64_t signs = ones << (bits - 1);
+    uint64_t cmp0, cmp1;
+
+    cmp1 = dup_const(esz, n);
+    cmp0 = cmp1 ^ m0;
+    cmp1 = cmp1 ^ m1;
+    cmp0 = (cmp0 - ones) & ~cmp0;
+    cmp1 = (cmp1 - ones) & ~cmp1;
+    return (cmp0 | cmp1) & signs;
+}
+
+static inline uint32_t do_match(void *vd, void *vn, void *vm, void *vg,
+                                uint32_t desc, int esz, bool nmatch)
+{
+    uint16_t esz_mask = pred_esz_masks[esz];
+    intptr_t opr_sz = simd_oprsz(desc);
+    uint32_t flags = PREDTEST_INIT;
+    intptr_t i, j, k;
+
+    for (i = 0; i < opr_sz; i += 16) {
+        uint64_t m0 = *(uint64_t *)(vm + i);
+        uint64_t m1 = *(uint64_t *)(vm + i + 8);
+        uint16_t pg = *(uint16_t *)(vg + H1_2(i >> 3)) & esz_mask;
+        uint16_t out = 0;
+
+        for (j = 0; j < 16; j += 8) {
+            uint64_t n = *(uint64_t *)(vn + i + j);
+
+            for (k = 0; k < 8; k += 1 << esz) {
+                if (pg & (1 << (j + k))) {
+                    bool o = do_match2(n >> (k * 8), m0, m1, esz);
+                    out |= (o ^ nmatch) << (j + k);
+                }
+            }
+        }
+        *(uint16_t *)(vd + H1_2(i >> 3)) = out;
+        flags = iter_predtest_fwd(out, pg, flags);
+    }
+    return flags;
+}
+
+#define DO_PPZZ_MATCH(NAME, ESZ, INV)                                         \
+uint32_t HELPER(NAME)(void *vd, void *vn, void *vm, void *vg, uint32_t desc)  \
+{                                                                             \
+    return do_match(vd, vn, vm, vg, desc, ESZ, INV);                          \
+}
+
+DO_PPZZ_MATCH(sve2_match_ppzz_b, MO_8, false)
+DO_PPZZ_MATCH(sve2_match_ppzz_h, MO_16, false)
+
+DO_PPZZ_MATCH(sve2_nmatch_ppzz_b, MO_8, true)
+DO_PPZZ_MATCH(sve2_nmatch_ppzz_h, MO_16, true)
+
+#undef DO_PPZZ_MATCH
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index 540e926c18..ffb7f5c8a0 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -7467,6 +7467,28 @@ static bool trans_UQRSHRNT(DisasContext *s, arg_rri_esz *a)
     return do_sve2_shr_narrow(s, a, ops);
 }
 
+static bool do_sve2_ppzz_flags(DisasContext *s, arg_rprr_esz *a,
+                               gen_helper_gvec_flags_4 *fn)
+{
+    if (!dc_isar_feature(aa64_sve2, s)) {
+        return false;
+    }
+    return do_ppzz_flags(s, a, fn);
+}
+
+#define DO_SVE2_PPZZ_MATCH(NAME, name)                                      \
+static bool trans_##NAME(DisasContext *s, arg_rprr_esz *a)                  \
+{                                                                           \
+    static gen_helper_gvec_flags_4 * const fns[4] = {                       \
+        gen_helper_sve2_##name##_ppzz_b, gen_helper_sve2_##name##_ppzz_h,   \
+        NULL,                            NULL                               \
+    };                                                                      \
+    return do_sve2_ppzz_flags(s, a, fns[a->esz]);                           \
+}
+
+DO_SVE2_PPZZ_MATCH(MATCH, match)
+DO_SVE2_PPZZ_MATCH(NMATCH, nmatch)
+
 static bool do_sve2_zpzz_fp(DisasContext *s, arg_rprr_esz *a,
                             gen_helper_gvec_4_ptr *fn)
 {
-- 
2.25.1


