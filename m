Return-Path: <SRS0=Qw6D=63=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDD37C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 16:36:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12FD220671
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 16:36:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZK4yb9/3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12FD220671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60680 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYuMW-0006fA-GV
	for qemu-devel@archiver.kernel.org; Wed, 13 May 2020 12:36:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48014)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jYuJe-0003lG-6L
 for qemu-devel@nongnu.org; Wed, 13 May 2020 12:33:06 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:35600)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jYuJd-00023I-7Y
 for qemu-devel@nongnu.org; Wed, 13 May 2020 12:33:05 -0400
Received: by mail-pg1-x542.google.com with SMTP id t11so8012350pgg.2
 for <qemu-devel@nongnu.org>; Wed, 13 May 2020 09:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=WJvxSydD4AqaqoBlC1YovV+jM2AoB6yDoOP5tm4PS34=;
 b=ZK4yb9/3XDesj4y48AAkEGNckVi++SwSZOlwBKfHicR/LBfqsMtV/bWcvlWqBpOAcz
 o0Gy5AhGeEg/s6qngAgNaHwTtE94KoSCcljM3Npx0fVErYnktwPK/dRWDRaSG+uSbOgs
 2mg6N7MSn6v18dRbggWNA3b/9v5KYZpOv7pDxwE5NN7ZFBQfA/u8OUAZUBInp4ZTD4jx
 gkAcvPOWkXpgbzaMuB2uh+c5IVLsBk/K+VJIor5q3jdeo+Hs2yprVIfwiHRRl1y2x/R+
 bF1A5FZbtuekjZtiNk/X2Ey/e8Zpb0QtOsCtSG3hF8qEDdW7zdZZIDMd3MCCfaFF39+C
 Q+Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=WJvxSydD4AqaqoBlC1YovV+jM2AoB6yDoOP5tm4PS34=;
 b=PM25Ov6NDCEunVfS8ZgOfBtFKJYxI2xjde1mtUf84FQVgI1WlXVRbrmYpzP6IZ12iN
 4OPP3ywkI9wC5SQi4OvQXc9Fui4jFRc8ECbnGK0s4LpoM38C9pM1HiGFR0kXZ6Upj44l
 qOLlWnoDiYdb9GmUCSUDNyqtLSLWDDiCTUINSgE8W63pxvwNBsh6AP7+DEjPBoAoshn8
 dNUKHxWFAdHvAJmasC79LP9vt94+hJQmVLUIChRiQLFtNoCZs1R5hdjU7bHrVian5tRE
 dpgwfO+PGY/WOVs06FSDllEhv5Oosrtm/pb5P7+nlQWEhJk/pjl6YHjD5pldp/DRShFs
 uHeA==
X-Gm-Message-State: AOAM532vQ0I18Qs7rVoXql6pbTyYL0ZjO+fGfqYJ0b1dz9N/Of76wLZ+
 M2V2GDS2W+iJ1EegNQDh754W7RKaxUg=
X-Google-Smtp-Source: ABdhPJx1Co3O/WzgBcrqUmtCZEtkXyHKoEItNaV0crxD3+Ex+zKpimkiGJkxkRHbXq6jgylJtWXlzA==
X-Received: by 2002:aa7:9575:: with SMTP id x21mr148296pfq.324.1589387583236; 
 Wed, 13 May 2020 09:33:03 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id b11sm158025pgq.50.2020.05.13.09.33.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 May 2020 09:33:02 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 12/16] target/arm: Create gen_gvec_{qrdmla,qrdmls}
Date: Wed, 13 May 2020 09:32:41 -0700
Message-Id: <20200513163245.17915-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200513163245.17915-1-richard.henderson@linaro.org>
References: <20200513163245.17915-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::542;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x542.google.com
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Provide a functional interface for the vector expansion.
This fits better with the existing set of helpers that
we provide for other operations.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate.h     |  5 ++++
 target/arm/translate-a64.c | 34 ++----------------------
 target/arm/translate.c     | 54 +++++++++++++++++++-------------------
 3 files changed, 34 insertions(+), 59 deletions(-)

diff --git a/target/arm/translate.h b/target/arm/translate.h
index 4e1778c5e0..aea8a9759d 100644
--- a/target/arm/translate.h
+++ b/target/arm/translate.h
@@ -332,6 +332,11 @@ void gen_gvec_sri(unsigned vece, uint32_t rd_ofs, uint32_t rm_ofs,
 void gen_gvec_sli(unsigned vece, uint32_t rd_ofs, uint32_t rm_ofs,
                   int64_t shift, uint32_t opr_sz, uint32_t max_sz);
 
+void gen_gvec_sqrdmlah_qc(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
+                          uint32_t rm_ofs, uint32_t opr_sz, uint32_t max_sz);
+void gen_gvec_sqrdmlsh_qc(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
+                          uint32_t rm_ofs, uint32_t opr_sz, uint32_t max_sz);
+
 /*
  * Forward to the isar_feature_* tests given a DisasContext pointer.
  */
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 367fa403ae..4577df3cf4 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -587,18 +587,6 @@ static void gen_gvec_op3_ool(DisasContext *s, bool is_q, int rd,
                        is_q ? 16 : 8, vec_full_reg_size(s), data, fn);
 }
 
-/* Expand a 3-operand + env pointer operation using
- * an out-of-line helper.
- */
-static void gen_gvec_op3_env(DisasContext *s, bool is_q, int rd,
-                             int rn, int rm, gen_helper_gvec_3_ptr *fn)
-{
-    tcg_gen_gvec_3_ptr(vec_full_reg_offset(s, rd),
-                       vec_full_reg_offset(s, rn),
-                       vec_full_reg_offset(s, rm), cpu_env,
-                       is_q ? 16 : 8, vec_full_reg_size(s), 0, fn);
-}
-
 /* Expand a 3-operand + fpstatus pointer + simd data value operation using
  * an out-of-line helper.
  */
@@ -11693,29 +11681,11 @@ static void disas_simd_three_reg_same_extra(DisasContext *s, uint32_t insn)
 
     switch (opcode) {
     case 0x0: /* SQRDMLAH (vector) */
-        switch (size) {
-        case 1:
-            gen_gvec_op3_env(s, is_q, rd, rn, rm, gen_helper_gvec_qrdmlah_s16);
-            break;
-        case 2:
-            gen_gvec_op3_env(s, is_q, rd, rn, rm, gen_helper_gvec_qrdmlah_s32);
-            break;
-        default:
-            g_assert_not_reached();
-        }
+        gen_gvec_fn3(s, is_q, rd, rn, rm, gen_gvec_sqrdmlah_qc, size);
         return;
 
     case 0x1: /* SQRDMLSH (vector) */
-        switch (size) {
-        case 1:
-            gen_gvec_op3_env(s, is_q, rd, rn, rm, gen_helper_gvec_qrdmlsh_s16);
-            break;
-        case 2:
-            gen_gvec_op3_env(s, is_q, rd, rn, rm, gen_helper_gvec_qrdmlsh_s32);
-            break;
-        default:
-            g_assert_not_reached();
-        }
+        gen_gvec_fn3(s, is_q, rd, rn, rm, gen_gvec_sqrdmlsh_qc, size);
         return;
 
     case 0x2: /* SDOT / UDOT */
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 391a09b439..39626e0df9 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -3629,20 +3629,26 @@ static const uint8_t neon_2rm_sizes[] = {
     [NEON_2RM_VCVT_UF] = 0x4,
 };
 
-
-/* Expand v8.1 simd helper.  */
-static int do_v81_helper(DisasContext *s, gen_helper_gvec_3_ptr *fn,
-                         int q, int rd, int rn, int rm)
+void gen_gvec_sqrdmlah_qc(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
+                          uint32_t rm_ofs, uint32_t opr_sz, uint32_t max_sz)
 {
-    if (dc_isar_feature(aa32_rdm, s)) {
-        int opr_sz = (1 + q) * 8;
-        tcg_gen_gvec_3_ptr(vfp_reg_offset(1, rd),
-                           vfp_reg_offset(1, rn),
-                           vfp_reg_offset(1, rm), cpu_env,
-                           opr_sz, opr_sz, 0, fn);
-        return 0;
-    }
-    return 1;
+    static gen_helper_gvec_3_ptr * const fns[2] = {
+        gen_helper_gvec_qrdmlah_s16, gen_helper_gvec_qrdmlah_s32
+    };
+    tcg_debug_assert(vece >= 1 && vece <= 2);
+    tcg_gen_gvec_3_ptr(rd_ofs, rn_ofs, rm_ofs, cpu_env,
+                       opr_sz, max_sz, 0, fns[vece - 1]);
+}
+
+void gen_gvec_sqrdmlsh_qc(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
+                          uint32_t rm_ofs, uint32_t opr_sz, uint32_t max_sz)
+{
+    static gen_helper_gvec_3_ptr * const fns[2] = {
+        gen_helper_gvec_qrdmlsh_s16, gen_helper_gvec_qrdmlsh_s32
+    };
+    tcg_debug_assert(vece >= 1 && vece <= 2);
+    tcg_gen_gvec_3_ptr(rd_ofs, rn_ofs, rm_ofs, cpu_env,
+                       opr_sz, max_sz, 0, fns[vece - 1]);
 }
 
 #define GEN_CMP0(NAME, COND)                                            \
@@ -5197,13 +5203,10 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                 break;  /* VPADD */
             }
             /* VQRDMLAH */
-            switch (size) {
-            case 1:
-                return do_v81_helper(s, gen_helper_gvec_qrdmlah_s16,
-                                     q, rd, rn, rm);
-            case 2:
-                return do_v81_helper(s, gen_helper_gvec_qrdmlah_s32,
-                                     q, rd, rn, rm);
+            if (dc_isar_feature(aa32_rdm, s) && (size == 1 || size == 2)) {
+                gen_gvec_sqrdmlah_qc(size, rd_ofs, rn_ofs, rm_ofs,
+                                     vec_size, vec_size);
+                return 0;
             }
             return 1;
 
@@ -5216,13 +5219,10 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                 break;
             }
             /* VQRDMLSH */
-            switch (size) {
-            case 1:
-                return do_v81_helper(s, gen_helper_gvec_qrdmlsh_s16,
-                                     q, rd, rn, rm);
-            case 2:
-                return do_v81_helper(s, gen_helper_gvec_qrdmlsh_s32,
-                                     q, rd, rn, rm);
+            if (dc_isar_feature(aa32_rdm, s) && (size == 1 || size == 2)) {
+                gen_gvec_sqrdmlsh_qc(size, rd_ofs, rn_ofs, rm_ofs,
+                                     vec_size, vec_size);
+                return 0;
             }
             return 1;
 
-- 
2.20.1


