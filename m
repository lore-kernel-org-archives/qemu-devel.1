Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 191BFC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 04:57:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCD4C2186A
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 04:57:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V499mi/1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCD4C2186A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51924 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlmc3-0004sg-0p
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 00:57:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33286)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jlmCt-0003HK-3r
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 00:31:19 -0400
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:37907)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jlmCq-0003Ji-9G
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 00:31:18 -0400
Received: by mail-pj1-x1042.google.com with SMTP id d6so2079971pjs.3
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 21:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=UsPujwpgcFjHgZDhsoUQnsI57TEaho6cSXl3HkPTCSY=;
 b=V499mi/1qlXrydLZDcGedWT1CdxXot6TnPwjG7QEbZ9AL+SBsJrdsUaDK2tN96/43L
 YRDcKEFp4mnsPvQ82pz0aGTautsWCP9694Y1Gk8xi3mB/awVxdmSwUxYnhIib62gQASK
 K/oGCZaAsV6vtxCRlduvgBGdQhW+VtgOMz+aSG8sB2Kd7jlh0oCPQPXtcdOYiWUH5P6B
 gYsugdxs+KkmYs7/JrvdIEXkdECox3atUdzRJ4OdiwLfr/Domi/oPFh6/6ScTjRLumDC
 j4FFWQ5RH501IeGufecVe6pus+M5LdgUV1VCj3BzF+1I4l+TlI5Uece55mV8dz47qwTJ
 ho8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=UsPujwpgcFjHgZDhsoUQnsI57TEaho6cSXl3HkPTCSY=;
 b=MjhxE8TIDFgwzNaXdHhpf7se6Ii/gdhgikGpYPspvtM+ia+lFwHwPWT8Y7ZPRdpKvv
 QwtsNN7Qh4yJsgaRTu4e35KamA6BEfO5V1caBXNoCHiOtqr4N3P1KWKNGzjPOHjt93sP
 8HFFj8sO7ucgKRoE+CUbza8abKQMGp1hMdFQGcvoRSz/FpxVF4X/wZh/BkCg/LnFv9Ts
 rYoeGEh5H34cW5i1XueaY7U8XHRuoB90sB55ZyLWs/p+g6DkQVacX3UJkCIha2LhzZ9f
 V11sV/VGoNhE93aCXWBlc6HqWlsIW5ShU8C0W6ZE39AN9qZS8CPVeBMpeAVR6fLSB+Jh
 d2Gg==
X-Gm-Message-State: AOAM530we6bGOKAXcdkZ2QzYe0rmE+9GhKUl46RZFkuLWBegiLYO8uz8
 bV3+jNgMZoMC4bpPm1IfdmkH/O3sUMc=
X-Google-Smtp-Source: ABdhPJxnPMYBkdfrY1pTOjV4sfHzIavmWvt80Wiwz02IY+VBcTMqDq6t82XrJrrSKknpc6zTWDMiwQ==
X-Received: by 2002:a17:902:c697:: with SMTP id
 r23mr2160599plx.312.1592454674404; 
 Wed, 17 Jun 2020 21:31:14 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id o1sm974337pjf.17.2020.06.17.21.31.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2020 21:31:13 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 062/100] target/arm: Implement SVE2 FMMLA
Date: Wed, 17 Jun 2020 21:26:06 -0700
Message-Id: <20200618042644.1685561-63-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618042644.1685561-1-richard.henderson@linaro.org>
References: <20200618042644.1685561-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1042;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1042.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: qemu-arm@nongnu.org, steplong@quicinc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Stephen Long <steplong@quicinc.com>

Signed-off-by: Stephen Long <steplong@quicinc.com>

Fixed the errors Richard pointed out.
Message-Id: <20200422165503.13511-1-steplong@quicinc.com>
[rth: Fix indexing in helpers, expand macro to straight functions.]
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h           | 10 ++++++
 target/arm/helper-sve.h    |  3 ++
 target/arm/sve.decode      |  4 +++
 target/arm/sve_helper.c    | 74 ++++++++++++++++++++++++++++++++++++++
 target/arm/translate-sve.c | 33 +++++++++++++++++
 5 files changed, 124 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 25ca3aed67..331c5cdd4b 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3877,6 +3877,16 @@ static inline bool isar_feature_aa64_sve2_bitperm(const ARMISARegisters *id)
     return FIELD_EX64(id->id_aa64zfr0, ID_AA64ZFR0, BITPERM) != 0;
 }
 
+static inline bool isar_feature_aa64_sve2_f32mm(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64zfr0, ID_AA64ZFR0, F32MM) != 0;
+}
+
+static inline bool isar_feature_aa64_sve2_f64mm(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64zfr0, ID_AA64ZFR0, F64MM) != 0;
+}
+
 /*
  * Feature tests for "does this exist in either 32-bit or 64-bit?"
  */
diff --git a/target/arm/helper-sve.h b/target/arm/helper-sve.h
index 9f6095c884..2929ad48a7 100644
--- a/target/arm/helper-sve.h
+++ b/target/arm/helper-sve.h
@@ -2174,3 +2174,6 @@ DEF_HELPER_FLAGS_5(sve2_sqrdcmlah_zzzz_s, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(sve2_sqrdcmlah_zzzz_d, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_6(fmmla_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_6(fmmla_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, ptr, i32)
diff --git a/target/arm/sve.decode b/target/arm/sve.decode
index 1b5bd2d193..11e724d3a2 100644
--- a/target/arm/sve.decode
+++ b/target/arm/sve.decode
@@ -1389,6 +1389,10 @@ UMLSLT_zzzw     01000100 .. 0 ..... 010 111 ..... .....  @rda_rn_rm
 CMLA_zzzz       01000100 esz:2 0 rm:5 0010 rot:2 rn:5 rd:5  ra=%reg_movprfx
 SQRDCMLAH_zzzz  01000100 esz:2 0 rm:5 0011 rot:2 rn:5 rd:5  ra=%reg_movprfx
 
+### SVE2 floating point matrix multiply accumulate
+
+FMMLA           01100100 .. 1 ..... 111001 ..... .....  @rda_rn_rm
+
 ### SVE2 Memory Gather Load Group
 
 # SVE2 64-bit gather non-temporal load
diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
index a6c5ff8f79..b1bb2300f8 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -6823,3 +6823,77 @@ void HELPER(sve2_xar_s)(void *vd, void *vn, void *vm, uint32_t desc)
         d[i] = ror32(n[i] ^ m[i], shr);
     }
 }
+
+void HELPER(fmmla_s)(void *vd, void *vn, void *vm, void *va,
+                     void *status, uint32_t desc)
+{
+    intptr_t s, opr_sz = simd_oprsz(desc) / (sizeof(float32) * 4);
+
+    for (s = 0; s < opr_sz; ++s) {
+        float32 *n = vn + s * sizeof(float32) * 4;
+        float32 *m = vm + s * sizeof(float32) * 4;
+        float32 *a = va + s * sizeof(float32) * 4;
+        float32 *d = vd + s * sizeof(float32) * 4;
+        float32 n00 = n[H4(0)], n01 = n[H4(1)];
+        float32 n10 = n[H4(2)], n11 = n[H4(3)];
+        float32 m00 = m[H4(0)], m01 = m[H4(1)];
+        float32 m10 = m[H4(2)], m11 = m[H4(3)];
+        float32 p0, p1;
+
+        /* i = 0, j = 0 */
+        p0 = float32_mul(n00, m00, status);
+        p1 = float32_mul(n01, m01, status);
+        d[H4(0)] = float32_add(a[H4(0)], float32_add(p0, p1, status), status);
+
+        /* i = 0, j = 1 */
+        p0 = float32_mul(n00, m10, status);
+        p1 = float32_mul(n01, m11, status);
+        d[H4(1)] = float32_add(a[H4(1)], float32_add(p0, p1, status), status);
+
+        /* i = 1, j = 0 */
+        p0 = float32_mul(n10, m00, status);
+        p1 = float32_mul(n11, m01, status);
+        d[H4(2)] = float32_add(a[H4(2)], float32_add(p0, p1, status), status);
+
+        /* i = 1, j = 1 */
+        p0 = float32_mul(n10, m10, status);
+        p1 = float32_mul(n11, m11, status);
+        d[H4(3)] = float32_add(a[H4(3)], float32_add(p0, p1, status), status);
+    }
+}
+
+void HELPER(fmmla_d)(void *vd, void *vn, void *vm, void *va,
+                     void *status, uint32_t desc)
+{
+    intptr_t s, opr_sz = simd_oprsz(desc) / (sizeof(float64) * 4);
+
+    for (s = 0; s < opr_sz; ++s) {
+        float64 *n = vn + s * sizeof(float64) * 4;
+        float64 *m = vm + s * sizeof(float64) * 4;
+        float64 *a = va + s * sizeof(float64) * 4;
+        float64 *d = vd + s * sizeof(float64) * 4;
+        float64 n00 = n[0], n01 = n[1], n10 = n[2], n11 = n[3];
+        float64 m00 = m[0], m01 = m[1], m10 = m[2], m11 = m[3];
+        float64 p0, p1;
+
+        /* i = 0, j = 0 */
+        p0 = float64_mul(n00, m00, status);
+        p1 = float64_mul(n01, m01, status);
+        d[0] = float64_add(a[0], float64_add(p0, p1, status), status);
+
+        /* i = 0, j = 1 */
+        p0 = float64_mul(n00, m10, status);
+        p1 = float64_mul(n01, m11, status);
+        d[1] = float64_add(a[1], float64_add(p0, p1, status), status);
+
+        /* i = 1, j = 0 */
+        p0 = float64_mul(n10, m00, status);
+        p1 = float64_mul(n11, m01, status);
+        d[2] = float64_add(a[2], float64_add(p0, p1, status), status);
+
+        /* i = 1, j = 1 */
+        p0 = float64_mul(n10, m10, status);
+        p1 = float64_mul(n11, m11, status);
+        d[3] = float64_add(a[3], float64_add(p0, p1, status), status);
+    }
+}
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index 77003ee43e..0fa04afcaf 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -7233,6 +7233,39 @@ DO_SVE2_ZPZZ_FP(FMINP, fminp)
  * SVE Integer Multiply-Add (unpredicated)
  */
 
+static bool trans_FMMLA(DisasContext *s, arg_rrrr_esz *a)
+{
+    gen_helper_gvec_4_ptr *fn;
+
+    switch (a->esz) {
+    case MO_32:
+        if (!dc_isar_feature(aa64_sve2_f32mm, s)) {
+            return false;
+        }
+        fn = gen_helper_fmmla_s;
+        break;
+    case MO_64:
+        if (!dc_isar_feature(aa64_sve2_f64mm, s)) {
+            return false;
+        }
+        fn = gen_helper_fmmla_d;
+        break;
+    default:
+        return false;
+    }
+
+    if (sve_access_check(s)) {
+        unsigned vsz = vec_full_reg_size(s);
+        TCGv_ptr status = get_fpstatus_ptr(a->esz == MO_16);
+        tcg_gen_gvec_4_ptr(vec_full_reg_offset(s, a->rd),
+                           vec_full_reg_offset(s, a->rn),
+                           vec_full_reg_offset(s, a->rm),
+                           vec_full_reg_offset(s, a->ra),
+                           status, vsz, vsz, 0, fn);
+    }
+    return true;
+}
+
 static bool do_sqdmlal_zzzw(DisasContext *s, arg_rrrr_esz *a,
                             bool sel1, bool sel2)
 {
-- 
2.25.1


