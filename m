Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E20C5C43464
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 19:36:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53C4721741
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 19:36:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dSYr5dhO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53C4721741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36762 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJMBW-00047d-BZ
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 15:36:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48842)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kJLIA-000125-IE
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 14:39:30 -0400
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:52248)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kJLI2-0007GP-1O
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 14:39:30 -0400
Received: by mail-pj1-x1043.google.com with SMTP id bw23so786464pjb.2
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2020 11:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=h6MHIdnd/k4ep8IYhrC6CDpmus0bNBpHI413VcRuYZI=;
 b=dSYr5dhO5Q/k1KdyIe5UvLoj0996z6qZfq2FEv8c0UJI2t3NFar3V8o4aAZ4KbkS7/
 7n6S1YFsjqTMxgyygeU57hlpWaG9vCPtQ6UPrWQxdpecJr/6nQe4iQNPUupjKutnjakK
 B2bxWB9okM+TNjTY2fYNYYHlUUAg0VySTxoeZBakSVoPzKpdw7Ys9gwFrmd4ruwYvMeU
 mn3qffP0dLOWHdzA0JuPdytRwzpaoepeBwxZ59RE+C1hnqKnd0BAK0c2wPyGeHCASwaC
 2PJbJBSfO4/nRHURMqNGL6FFHM5lw5nmzhpN3tC1SGKD570hQpIuKrspPU3AN4X0BxVt
 WlmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=h6MHIdnd/k4ep8IYhrC6CDpmus0bNBpHI413VcRuYZI=;
 b=Sbrw+RMvfs2D71do4Mn2znkrprm431S8Fa6a5Sc685I92AvIriFVsJG4uJeQh40CRW
 Tbekhhg4OwU/TQX4y09SMjGtcqftYdaRl4xXMrCnAbYLYVzKiJ47Y9dY9PEYkJylY/Xp
 PwAfj7Xdd34/6u7lJVSsF4tqGnkA6dUd1iaqjb0Bi9zPimM4REhR5OkfMHcwOki76Duj
 Hmicq6ecGyYiUGNZZsb6P4zG9t+VSnSYO/78Vn8SXOoTaBvY8kOSvIReCsqodbB+plCV
 n92tNeHFLR6j32kKlz89GcHfRHGOWdrtttYiIdYmYdXdyUn8J3LEwBmMH18fLOJrxbf2
 Gk7Q==
X-Gm-Message-State: AOAM532Db/56efWW7rlOamYA85b1N6PyQf2yZUELWUsvRIEVTz82CPne
 DNPqbV9olCJo+oCM53ym6wDnMtvuWZq/iQ==
X-Google-Smtp-Source: ABdhPJzHBMsQsXJBlG1VnUFr+8PdaVTVIHEvMM5IkEZf9nn1ebkXdgelmaIRQQwMlwDOptfJYsrl1Q==
X-Received: by 2002:a17:90b:1b50:: with SMTP id
 nv16mr14322114pjb.153.1600454359943; 
 Fri, 18 Sep 2020 11:39:19 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id f4sm3680723pfj.147.2020.09.18.11.39.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2020 11:39:19 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 65/81] target/arm: Implement SVE mixed sign dot product
 (indexed)
Date: Fri, 18 Sep 2020 11:37:35 -0700
Message-Id: <20200918183751.2787647-66-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200918183751.2787647-1-richard.henderson@linaro.org>
References: <20200918183751.2787647-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1043;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1043.google.com
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
 target/arm/helper.h        |  4 +++
 target/arm/sve.decode      |  4 +++
 target/arm/translate-sve.c | 18 +++++++++++
 target/arm/vec_helper.c    | 66 ++++++++++++++++++++++++++++++++++++++
 5 files changed, 97 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index aaefbf0167..b394e15c0c 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3917,6 +3917,11 @@ static inline bool isar_feature_aa64_sve2_bitperm(const ARMISARegisters *id)
     return FIELD_EX64(id->id_aa64zfr0, ID_AA64ZFR0, BITPERM) != 0;
 }
 
+static inline bool isar_feature_aa64_sve2_i8mm(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64zfr0, ID_AA64ZFR0, I8MM) != 0;
+}
+
 static inline bool isar_feature_aa64_sve2_f32mm(const ARMISARegisters *id)
 {
     return FIELD_EX64(id->id_aa64zfr0, ID_AA64ZFR0, F32MM) != 0;
diff --git a/target/arm/helper.h b/target/arm/helper.h
index 828fcc0fc9..0f17b59f45 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -608,6 +608,10 @@ DEF_HELPER_FLAGS_5(gvec_sdot_idx_h, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(gvec_udot_idx_h, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_sudot_idx_b, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_usdot_idx_b, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
 
 DEF_HELPER_FLAGS_5(gvec_fcaddh, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, i32)
diff --git a/target/arm/sve.decode b/target/arm/sve.decode
index e8011fe91b..51acbfa797 100644
--- a/target/arm/sve.decode
+++ b/target/arm/sve.decode
@@ -815,6 +815,10 @@ SQRDMLSH_zzxz_h 01000100 .. 1 ..... 000101 ..... .....          @rrxr_h
 SQRDMLSH_zzxz_s 01000100 .. 1 ..... 000101 ..... .....          @rrxr_s
 SQRDMLSH_zzxz_d 01000100 .. 1 ..... 000101 ..... .....          @rrxr_d
 
+# SVE mixed sign dot product (indexed)
+USDOT_zzxw_s    01000100 .. 1 ..... 000110 ..... .....          @rrxr_s
+SUDOT_zzxw_s    01000100 .. 1 ..... 000111 ..... .....          @rrxr_s
+
 # SVE2 saturating multiply-add (indexed)
 SQDMLALB_zzxw_s 01000100 .. 1 ..... 0010.0 ..... .....          @rrxw_s
 SQDMLALB_zzxw_d 01000100 .. 1 ..... 0010.0 ..... .....          @rrxw_d
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index 4628198b76..ae61659b1d 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -3842,6 +3842,24 @@ DO_RRXR(trans_SDOT_zzxw_d, gen_helper_gvec_sdot_idx_h)
 DO_RRXR(trans_UDOT_zzxw_s, gen_helper_gvec_udot_idx_b)
 DO_RRXR(trans_UDOT_zzxw_d, gen_helper_gvec_udot_idx_h)
 
+static bool trans_SUDOT_zzxw_s(DisasContext *s, arg_rrxr_esz *a)
+{
+    if (!dc_isar_feature(aa64_sve2_i8mm, s)) {
+        return false;
+    }
+    return do_zzxz_data(s, a->rd, a->rn, a->rm, a->ra,
+                        gen_helper_gvec_sudot_idx_b, a->index);
+}
+
+static bool trans_USDOT_zzxw_s(DisasContext *s, arg_rrxr_esz *a)
+{
+    if (!dc_isar_feature(aa64_sve2_i8mm, s)) {
+        return false;
+    }
+    return do_zzxz_data(s, a->rd, a->rn, a->rm, a->ra,
+                        gen_helper_gvec_usdot_idx_b, a->index);
+}
+
 #undef DO_RRXR
 
 static bool do_sve2_zzx_data(DisasContext *s, arg_rrx_esz *a,
diff --git a/target/arm/vec_helper.c b/target/arm/vec_helper.c
index 339e722383..8dccc6789d 100644
--- a/target/arm/vec_helper.c
+++ b/target/arm/vec_helper.c
@@ -677,6 +677,72 @@ void HELPER(gvec_udot_idx_b)(void *vd, void *vn, void *vm,
     clear_tail(d, opr_sz, simd_maxsz(desc));
 }
 
+void HELPER(gvec_sudot_idx_b)(void *vd, void *vn, void *vm,
+                              void *va, uint32_t desc)
+{
+    intptr_t i, segend, opr_sz = simd_oprsz(desc), opr_sz_4 = opr_sz / 4;
+    intptr_t index = simd_data(desc);
+    int32_t *d = vd, *a = va;
+    int8_t *n = vn;
+    uint8_t *m_indexed = (uint8_t *)vm + index * 4;
+
+    /* Notice the special case of opr_sz == 8, from aa64/aa32 advsimd.
+     * Otherwise opr_sz is a multiple of 16.
+     */
+    segend = MIN(4, opr_sz_4);
+    i = 0;
+    do {
+        uint8_t m0 = m_indexed[i * 4 + 0];
+        uint8_t m1 = m_indexed[i * 4 + 1];
+        uint8_t m2 = m_indexed[i * 4 + 2];
+        uint8_t m3 = m_indexed[i * 4 + 3];
+
+        do {
+            d[i] = (a[i] +
+                    n[i * 4 + 0] * m0 +
+                    n[i * 4 + 1] * m1 +
+                    n[i * 4 + 2] * m2 +
+                    n[i * 4 + 3] * m3);
+        } while (++i < segend);
+        segend = i + 4;
+    } while (i < opr_sz_4);
+
+    clear_tail(d, opr_sz, simd_maxsz(desc));
+}
+
+void HELPER(gvec_usdot_idx_b)(void *vd, void *vn, void *vm,
+                              void *va, uint32_t desc)
+{
+    intptr_t i, segend, opr_sz = simd_oprsz(desc), opr_sz_4 = opr_sz / 4;
+    intptr_t index = simd_data(desc);
+    uint32_t *d = vd, *a = va;
+    uint8_t *n = vn;
+    int8_t *m_indexed = (int8_t *)vm + index * 4;
+
+    /* Notice the special case of opr_sz == 8, from aa64/aa32 advsimd.
+     * Otherwise opr_sz is a multiple of 16.
+     */
+    segend = MIN(4, opr_sz_4);
+    i = 0;
+    do {
+        int8_t m0 = m_indexed[i * 4 + 0];
+        int8_t m1 = m_indexed[i * 4 + 1];
+        int8_t m2 = m_indexed[i * 4 + 2];
+        int8_t m3 = m_indexed[i * 4 + 3];
+
+        do {
+            d[i] = (a[i] +
+                    n[i * 4 + 0] * m0 +
+                    n[i * 4 + 1] * m1 +
+                    n[i * 4 + 2] * m2 +
+                    n[i * 4 + 3] * m3);
+        } while (++i < segend);
+        segend = i + 4;
+    } while (i < opr_sz_4);
+
+    clear_tail(d, opr_sz, simd_maxsz(desc));
+}
+
 void HELPER(gvec_sdot_idx_h)(void *vd, void *vn, void *vm,
                              void *va, uint32_t desc)
 {
-- 
2.25.1


