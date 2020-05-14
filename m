Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6D63C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 14:35:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 776C0205CB
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 14:35:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tQ8r66Ir"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 776C0205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39670 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZExl-0004R4-Hw
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 10:35:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39498)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jZEkK-0003HY-He
 for qemu-devel@nongnu.org; Thu, 14 May 2020 10:22:00 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c]:45453)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jZEkJ-0005WJ-Eu
 for qemu-devel@nongnu.org; Thu, 14 May 2020 10:22:00 -0400
Received: by mail-wr1-x42c.google.com with SMTP id v12so4314862wrp.12
 for <qemu-devel@nongnu.org>; Thu, 14 May 2020 07:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=3AUEgJUYy+FfWjpXl8LxNyi8rCML/2BcqVHdiNxn4WE=;
 b=tQ8r66IrrCX9G6TTSbQWcru0zT2/nyTHLRQT3UsAH1rTxdavfnijPGYNse6UDPXwGv
 AVs7obnI5sLyL0f/QBjhv1VPoaaHfQAbOBPnbvSWnY9ogd13YNNA3iqCX5IePC3u4Gjc
 0jnTmAF1vCFgABLZnmu9coOiivMKAoexIJbvMjxA3dal2/FXVwXYuxfQH1WGaa4Jwmyz
 sv5i2OpNKACgZ+2nyQ+mGQDIKdk1Zv4vOwB+znhRyGtViQyllGYo0la1XKREPLApoXkJ
 VRtUG0EK3V6KdpR2I4WS3SSGzykPn3rbkIgzNUhI01hvayhKqhGlHQLt4rPVgm+nOj8S
 VliQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=3AUEgJUYy+FfWjpXl8LxNyi8rCML/2BcqVHdiNxn4WE=;
 b=O294LJ6B4pB1Gv6hcGqY2ugTT8jFk7+E4HuI4hJJAjEDviFS7jHfOZCMv+zD0UnEWn
 qs0j31QoRJktxDZjnyRPbT2R/4Y1rtmvzt+sqIjWNAoTWCalHE3eT7OHOJ4O3kddlWBB
 mcXLEM8uHVMcAc3il6xzYbktB2m+Al+uSG1ylq/FxImu6LyHqCL/uQloDvrgpVZNtR8B
 9TJXbakhXlo0JgRtLlJtqafo9jJC5PPRuv08ESwyQaVMb41pDCYUJLqC6GTC+A6CilBv
 rRSjutSEH3SePkIwTg5OpSKBm/ee9qXkAHGODih8eOXc4XycPMa/P7QAxOJre8R0RUIY
 T2Aw==
X-Gm-Message-State: AOAM532EqTX6L2k511Lnw8HkKGPwWA2+d4SBfiIZLAB8Az1BTaOyGoHN
 F04J2+1NfY2eoySnAtsQEM4W4RMraZEeQA==
X-Google-Smtp-Source: ABdhPJxG2s9/l2iCrdJkmobLHiBageu/8phe/SUdFOelgirZN5+zNi4yFm2Vo4I6divf85cy7p/yog==
X-Received: by 2002:adf:b30f:: with SMTP id j15mr6176833wrd.394.1589466117776; 
 Thu, 14 May 2020 07:21:57 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id 88sm4077443wrq.77.2020.05.14.07.21.56
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2020 07:21:57 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 13/45] target/arm: Create gen_gvec_{qrdmla,qrdmls}
Date: Thu, 14 May 2020 15:21:06 +0100
Message-Id: <20200514142138.20875-14-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200514142138.20875-1-peter.maydell@linaro.org>
References: <20200514142138.20875-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42c.google.com
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

Provide a functional interface for the vector expansion.
This fits better with the existing set of helpers that
we provide for other operations.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200513163245.17915-13-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate.h     |  5 ++++
 target/arm/translate-a64.c | 34 ++----------------------
 target/arm/translate.c     | 54 +++++++++++++++++++-------------------
 3 files changed, 34 insertions(+), 59 deletions(-)

diff --git a/target/arm/translate.h b/target/arm/translate.h
index 4e1778c5e09..aea8a9759d2 100644
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
index 367fa403ae2..4577df3cf43 100644
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
index 391a09b4398..39626e0df91 100644
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


