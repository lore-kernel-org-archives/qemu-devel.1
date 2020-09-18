Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68348C43463
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 19:14:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4E3C21707
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 19:14:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hmHehQn8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4E3C21707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35642 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJLqH-0004aB-Ql
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 15:14:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48020)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kJLH6-0008I4-2N
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 14:38:24 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e]:38748)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kJLH4-00076d-3K
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 14:38:23 -0400
Received: by mail-pj1-x102e.google.com with SMTP id u3so3458959pjr.3
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2020 11:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ZbLRc+IuD/nbM0BZc/f1DlwGe0rxW4uXRdQXUe4P2FY=;
 b=hmHehQn8U0+FG94/i9fACPsgggM4cJ3wHQTD0cAdvEM4axP8r3b0A521UtteVOvvuP
 FJZ2Q16C1zZxWb86fxbyC9136zBU/YvGSbJ6h9IF5EH20s8p8jl7wAcu2c29wEhNqBsh
 8hYMJ82d6NJCXaOJmItS7iKfXTFBJRV1yxk9HT/yT3GDekAQ7/lAJxefbtQX3JXdro4u
 sJBys+wH/69pVY7SCToHohh+kwF69PJHMhhb09XDoHvkxa+90BAJ9QdiAqwCTvxQ2MqT
 omCdIKEs1Fuq4yvZCVMUi+LX7v2Pf4T0tT4Wd/7VKhiny1cVPudvtpiRy9WQSzGH8oF2
 H5XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ZbLRc+IuD/nbM0BZc/f1DlwGe0rxW4uXRdQXUe4P2FY=;
 b=rhyY+H7jdr+cOZWz5fsUcZ2SyJjAIMqZqpPxu0kptAywG1xdUN3Mb0StVPzJaHkovE
 zHs/lq5TrBSOj3Y0MZC9UJimLepuvYmYSl44uG1yTuhujDv8YT/Ik3X9xcscQP8TvIB5
 jeu+HmM0xSZj+PY386TGMQN63xT4eWtvMV4GspQ0MdpkbxVQuj2AbUgp7mYqxxyoLXlU
 coQhH+OFgJvOxqZ57NEQY4+55B255mY5gtfuitVGiNYRAGQ8wAWbBOKUvERPNHr5c9Xr
 /16EZSEx1+CzsCsRGkXf9Htt8TFEIY6W7ySQ4iqAN/KQbIPaQiFVyCkIjp2R73UM9aRO
 tcSA==
X-Gm-Message-State: AOAM532kvRtizer4YtP9csDI72iWFiTuOvU5ZiO2Zg/iBHL8VqQWWnZ/
 ZXjG+DMm4OWtdH8LAOGMbBOj5wijy7W5JQ==
X-Google-Smtp-Source: ABdhPJzOlWRuUA/Bc1BM5RSMgminb/vRknoJ+mDa/Quqh+7uQBtcb2t+jqIjYEyOnPwX3sABVdqgnw==
X-Received: by 2002:a17:902:6b05:b029:d2:8b5:14 with SMTP id
 o5-20020a1709026b05b02900d208b50014mr3790154plk.80.1600454300344; 
 Fri, 18 Sep 2020 11:38:20 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id f4sm3680723pfj.147.2020.09.18.11.38.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2020 11:38:19 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 20/81] target/arm: Implement SVE2 bitwise permute
Date: Fri, 18 Sep 2020 11:36:50 -0700
Message-Id: <20200918183751.2787647-21-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200918183751.2787647-1-richard.henderson@linaro.org>
References: <20200918183751.2787647-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102e.google.com
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
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h           |  5 +++
 target/arm/helper-sve.h    | 15 ++++++++
 target/arm/sve.decode      |  6 ++++
 target/arm/sve_helper.c    | 73 ++++++++++++++++++++++++++++++++++++++
 target/arm/translate-sve.c | 36 +++++++++++++++++++
 5 files changed, 135 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 59415184db..5ed2f2c65b 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3912,6 +3912,11 @@ static inline bool isar_feature_aa64_sve2_pmull128(const ARMISARegisters *id)
     return FIELD_EX64(id->id_aa64zfr0, ID_AA64ZFR0, AES) >= 2;
 }
 
+static inline bool isar_feature_aa64_sve2_bitperm(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64zfr0, ID_AA64ZFR0, BITPERM) != 0;
+}
+
 /*
  * Feature tests for "does this exist in either 32-bit or 64-bit?"
  */
diff --git a/target/arm/helper-sve.h b/target/arm/helper-sve.h
index cdd3cab607..492079578d 100644
--- a/target/arm/helper-sve.h
+++ b/target/arm/helper-sve.h
@@ -2377,3 +2377,18 @@ DEF_HELPER_FLAGS_4(sve2_eoril_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(sve2_eoril_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(sve2_eoril_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(sve2_eoril_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_4(sve2_bext_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2_bext_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2_bext_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2_bext_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_4(sve2_bdep_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2_bdep_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2_bdep_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2_bdep_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_4(sve2_bgrp_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2_bgrp_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2_bgrp_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2_bgrp_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
diff --git a/target/arm/sve.decode b/target/arm/sve.decode
index 79d915cf5b..b316610bbb 100644
--- a/target/arm/sve.decode
+++ b/target/arm/sve.decode
@@ -1220,3 +1220,9 @@ USHLLT          01000101 .. 0 ..... 1010 11 ..... .....  @rd_rn_tszimm_shl
 
 EORBT           01000101 .. 0 ..... 10010 0 ..... .....  @rd_rn_rm
 EORTB           01000101 .. 0 ..... 10010 1 ..... .....  @rd_rn_rm
+
+## SVE2 bitwise permute
+
+BEXT            01000101 .. 0 ..... 1011 00 ..... .....  @rd_rn_rm
+BDEP            01000101 .. 0 ..... 1011 01 ..... .....  @rd_rn_rm
+BGRP            01000101 .. 0 ..... 1011 10 ..... .....  @rd_rn_rm
diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
index 9133d0a58d..fffd3ca4a5 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -1241,6 +1241,79 @@ DO_ZZZ_NTB(sve2_eoril_d, uint64_t,     , DO_EOR)
 
 #undef DO_ZZZ_NTB
 
+#define DO_BITPERM(NAME, TYPE, OP) \
+void HELPER(NAME)(void *vd, void *vn, void *vm, uint32_t desc) \
+{                                                              \
+    intptr_t i, opr_sz = simd_oprsz(desc);                     \
+    for (i = 0; i < opr_sz; i += sizeof(TYPE)) {               \
+        TYPE nn = *(TYPE *)(vn + i);                           \
+        TYPE mm = *(TYPE *)(vm + i);                           \
+        *(TYPE *)(vd + i) = OP(nn, mm, sizeof(TYPE) * 8);      \
+    }                                                          \
+}
+
+static uint64_t bitextract(uint64_t data, uint64_t mask, int n)
+{
+    uint64_t res = 0;
+    int db, rb = 0;
+
+    for (db = 0; db < n; ++db) {
+        if ((mask >> db) & 1) {
+            res |= ((data >> db) & 1) << rb;
+            ++rb;
+        }
+    }
+    return res;
+}
+
+DO_BITPERM(sve2_bext_b, uint8_t, bitextract)
+DO_BITPERM(sve2_bext_h, uint16_t, bitextract)
+DO_BITPERM(sve2_bext_s, uint32_t, bitextract)
+DO_BITPERM(sve2_bext_d, uint64_t, bitextract)
+
+static uint64_t bitdeposit(uint64_t data, uint64_t mask, int n)
+{
+    uint64_t res = 0;
+    int rb, db = 0;
+
+    for (rb = 0; rb < n; ++rb) {
+        if ((mask >> rb) & 1) {
+            res |= ((data >> db) & 1) << rb;
+            ++db;
+        }
+    }
+    return res;
+}
+
+DO_BITPERM(sve2_bdep_b, uint8_t, bitdeposit)
+DO_BITPERM(sve2_bdep_h, uint16_t, bitdeposit)
+DO_BITPERM(sve2_bdep_s, uint32_t, bitdeposit)
+DO_BITPERM(sve2_bdep_d, uint64_t, bitdeposit)
+
+static uint64_t bitgroup(uint64_t data, uint64_t mask, int n)
+{
+    uint64_t resm = 0, resu = 0;
+    int db, rbm = 0, rbu = 0;
+
+    for (db = 0; db < n; ++db) {
+        uint64_t val = (data >> db) & 1;
+        if ((mask >> db) & 1) {
+            resm |= val << rbm++;
+        } else {
+            resu |= val << rbu++;
+        }
+    }
+
+    return resm | (resu << rbm);
+}
+
+DO_BITPERM(sve2_bgrp_b, uint8_t, bitgroup)
+DO_BITPERM(sve2_bgrp_h, uint16_t, bitgroup)
+DO_BITPERM(sve2_bgrp_s, uint32_t, bitgroup)
+DO_BITPERM(sve2_bgrp_d, uint64_t, bitgroup)
+
+#undef DO_BITPERM
+
 #define DO_ZZI_SHLL(NAME, TYPEW, TYPEN, HW, HN) \
 void HELPER(NAME)(void *vd, void *vn, uint32_t desc)           \
 {                                                              \
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index 0a194a0e8c..c2be092370 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -6259,3 +6259,39 @@ static bool trans_USHLLT(DisasContext *s, arg_rri_esz *a)
 {
     return do_sve2_shll_tb(s, a, true, true);
 }
+
+static bool trans_BEXT(DisasContext *s, arg_rrr_esz *a)
+{
+    static gen_helper_gvec_3 * const fns[4] = {
+        gen_helper_sve2_bext_b, gen_helper_sve2_bext_h,
+        gen_helper_sve2_bext_s, gen_helper_sve2_bext_d,
+    };
+    if (!dc_isar_feature(aa64_sve2_bitperm, s)) {
+        return false;
+    }
+    return do_sve2_zzw_ool(s, a, fns[a->esz], 0);
+}
+
+static bool trans_BDEP(DisasContext *s, arg_rrr_esz *a)
+{
+    static gen_helper_gvec_3 * const fns[4] = {
+        gen_helper_sve2_bdep_b, gen_helper_sve2_bdep_h,
+        gen_helper_sve2_bdep_s, gen_helper_sve2_bdep_d,
+    };
+    if (!dc_isar_feature(aa64_sve2_bitperm, s)) {
+        return false;
+    }
+    return do_sve2_zzw_ool(s, a, fns[a->esz], 0);
+}
+
+static bool trans_BGRP(DisasContext *s, arg_rrr_esz *a)
+{
+    static gen_helper_gvec_3 * const fns[4] = {
+        gen_helper_sve2_bgrp_b, gen_helper_sve2_bgrp_h,
+        gen_helper_sve2_bgrp_s, gen_helper_sve2_bgrp_d,
+    };
+    if (!dc_isar_feature(aa64_sve2_bitperm, s)) {
+        return false;
+    }
+    return do_sve2_zzw_ool(s, a, fns[a->esz], 0);
+}
-- 
2.25.1


