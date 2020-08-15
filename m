Return-Path: <SRS0=PlQC=BZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AE1DC433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2020 16:12:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4417A23B18
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2020 16:12:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e1Bkj8Zi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4417A23B18
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59310 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6ymn-0004WM-Ji
	for qemu-devel@archiver.kernel.org; Sat, 15 Aug 2020 12:12:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57028)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k6yla-0003Qg-T0
 for qemu-devel@nongnu.org; Sat, 15 Aug 2020 12:10:47 -0400
Received: from mail-vs1-xe42.google.com ([2607:f8b0:4864:20::e42]:39723)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k6ylY-0002nd-K3
 for qemu-devel@nongnu.org; Sat, 15 Aug 2020 12:10:46 -0400
Received: by mail-vs1-xe42.google.com with SMTP id n25so6174399vsq.6
 for <qemu-devel@nongnu.org>; Sat, 15 Aug 2020 09:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=o2sKGEby6/++OxhF3tijZoQWTqB0BkWs415h6IKC4gs=;
 b=e1Bkj8ZiuJXDakOROrU4mKxdMB6iW14Bz+nFnPYTXJoxAlWbF5gim1khLYYJOAwgHa
 Rb4+UfKjb2KAP73kGsukvIdSxZV/rWMTH40ZwnLskNKNOG2r75Yz0RunFcuWij2o2xy/
 v56j5t9eyaaWv6kzxt1KO2/DenkjbzMFysfG8H1b/VLACx0NhxA+5st/w7CJwHxZL4Q2
 nVhCLl8GJ5erW18ccJPbxsCeOE6e39HE635DOad30zrF+uAhPnIMyIofkBiGvmn+s3NH
 DZFHQBoPsH6/N1NOzJc2J9yf6czHmhnrd0Vtpdb1XrKYOKlyvy2e+xUTZblj5mdtb6JO
 1obQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=o2sKGEby6/++OxhF3tijZoQWTqB0BkWs415h6IKC4gs=;
 b=V/vSgE8CmsRb7z41EYuogqKHn4zdYoqMn4Vh5NZP14tMMAKZJXUikzYWRCj9TY9KDw
 ERZbFEFcY59Vc/dyDm9+2ZebKvqJR/3+f6Kq3LF+B0wc7H1Y0rsajQ3Yl3Qo6gbnecvi
 x/g//j2K0mplQfHOxfC5txvTBR1+p8ZtZ9fUPR3Pq6iQeb1kQEiqSkzqLA0z0j6Mou3I
 yvhcY2x468IQK9vzCC8KCzoAterR/c9TMMwpnJjZjxDHj5gxdJ0GtslxOsjwDBIezpeo
 1tAZanfHpTEszQWoUwgO18HJVvz3jRHGPVs+NM4Xe+7Tsnuax+94Mx6FXKCDyt+3kfdV
 sO2g==
X-Gm-Message-State: AOAM531AuiwUK1IM6+rz0XbmMRgRc/OODO86hsmWI2OISRCgAeVTgGps
 WBHmyRNN0/KmWZgXM1puZfCAW8jdPAdgIg==
X-Google-Smtp-Source: ABdhPJxSnui93vCrOieaxTuGLOIjaMykCjLL0LWA8Nvm+JpzE5HXTtvWSnXUpftceClHpy7YzYqNpw==
X-Received: by 2002:a62:3641:: with SMTP id d62mr2843375pfa.82.1597455133107; 
 Fri, 14 Aug 2020 18:32:13 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id y196sm10625528pfc.202.2020.08.14.18.32.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2020 18:32:12 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 19/20] target/arm: Convert integer multiply-add (indexed) to
 gvec for aa64 advsimd
Date: Fri, 14 Aug 2020 18:31:44 -0700
Message-Id: <20200815013145.539409-20-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200815013145.539409-1-richard.henderson@linaro.org>
References: <20200815013145.539409-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::e42;
 envelope-from=richard.henderson@linaro.org; helo=mail-vs1-xe42.google.com
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.h        | 14 ++++++++++++++
 target/arm/translate-a64.c | 34 ++++++++++++++++++++++++++++++++++
 target/arm/vec_helper.c    | 25 +++++++++++++++++++++++++
 3 files changed, 73 insertions(+)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index d0573a53c8..378bb1898b 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -762,6 +762,20 @@ DEF_HELPER_FLAGS_4(gvec_mul_idx_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(gvec_mul_idx_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(gvec_mul_idx_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 
+DEF_HELPER_FLAGS_5(gvec_mla_idx_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_mla_idx_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_mla_idx_d, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_5(gvec_mls_idx_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_mls_idx_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_mls_idx_d, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+
 #ifdef TARGET_AARCH64
 #include "helper-a64.h"
 #include "helper-sve.h"
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index d08960a1c8..c74c6e854c 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -13523,6 +13523,40 @@ static void disas_simd_indexed(DisasContext *s, uint32_t insn)
             return;
         }
         break;
+
+    case 0x10: /* MLA */
+        if (!is_long && !is_scalar) {
+            static gen_helper_gvec_4 * const fns[3] = {
+                gen_helper_gvec_mla_idx_h,
+                gen_helper_gvec_mla_idx_s,
+                gen_helper_gvec_mla_idx_d,
+            };
+            tcg_gen_gvec_4_ool(vec_full_reg_offset(s, rd),
+                               vec_full_reg_offset(s, rn),
+                               vec_full_reg_offset(s, rm),
+                               vec_full_reg_offset(s, rd),
+                               is_q ? 16 : 8, vec_full_reg_size(s),
+                               index, fns[size - 1]);
+            return;
+        }
+        break;
+
+    case 0x14: /* MLS */
+        if (!is_long && !is_scalar) {
+            static gen_helper_gvec_4 * const fns[3] = {
+                gen_helper_gvec_mls_idx_h,
+                gen_helper_gvec_mls_idx_s,
+                gen_helper_gvec_mls_idx_d,
+            };
+            tcg_gen_gvec_4_ool(vec_full_reg_offset(s, rd),
+                               vec_full_reg_offset(s, rn),
+                               vec_full_reg_offset(s, rm),
+                               vec_full_reg_offset(s, rd),
+                               is_q ? 16 : 8, vec_full_reg_size(s),
+                               index, fns[size - 1]);
+            return;
+        }
+        break;
     }
 
     if (size == 3) {
diff --git a/target/arm/vec_helper.c b/target/arm/vec_helper.c
index aa1de36921..fb53684ce3 100644
--- a/target/arm/vec_helper.c
+++ b/target/arm/vec_helper.c
@@ -731,6 +731,31 @@ DO_MUL_IDX(gvec_mul_idx_d, uint64_t, )
 
 #undef DO_MUL_IDX
 
+#define DO_MLA_IDX(NAME, TYPE, OP, H) \
+void HELPER(NAME)(void *vd, void *vn, void *vm, void *va, uint32_t desc)   \
+{                                                                          \
+    intptr_t i, j, oprsz = simd_oprsz(desc), segment = 16 / sizeof(TYPE);  \
+    intptr_t idx = simd_data(desc);                                        \
+    TYPE *d = vd, *n = vn, *m = vm, *a = va;                               \
+    for (i = 0; i < oprsz / sizeof(TYPE); i += segment) {                  \
+        TYPE mm = m[H(i + idx)];                                           \
+        for (j = 0; j < segment; j++) {                                    \
+            d[i + j] = a[i + j] OP n[i + j] * mm;                          \
+        }                                                                  \
+    }                                                                      \
+    clear_tail(d, oprsz, simd_maxsz(desc));                                \
+}
+
+DO_MLA_IDX(gvec_mla_idx_h, uint16_t, +, H2)
+DO_MLA_IDX(gvec_mla_idx_s, uint32_t, +, H4)
+DO_MLA_IDX(gvec_mla_idx_d, uint64_t, +,   )
+
+DO_MLA_IDX(gvec_mls_idx_h, uint16_t, -, H2)
+DO_MLA_IDX(gvec_mls_idx_s, uint32_t, -, H4)
+DO_MLA_IDX(gvec_mls_idx_d, uint64_t, -,   )
+
+#undef DO_MLA_IDX
+
 #define DO_FMUL_IDX(NAME, TYPE, H) \
 void HELPER(NAME)(void *vd, void *vn, void *vm, void *stat, uint32_t desc) \
 {                                                                          \
-- 
2.25.1


