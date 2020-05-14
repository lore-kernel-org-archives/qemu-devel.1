Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D08FFC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 21:29:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BE932065D
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 21:29:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Nrm1EtpZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BE932065D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34324 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZLQ3-0005eF-Pc
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 17:29:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49150)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jZLPC-000439-Sv
 for qemu-devel@nongnu.org; Thu, 14 May 2020 17:28:38 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:35678)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jZLPB-0004bU-VR
 for qemu-devel@nongnu.org; Thu, 14 May 2020 17:28:38 -0400
Received: by mail-pf1-x441.google.com with SMTP id n18so1958023pfa.2
 for <qemu-devel@nongnu.org>; Thu, 14 May 2020 14:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=QtavOgtJbqCDtFoMyh2yfPlecYMuCnzasezS0T2jFho=;
 b=Nrm1EtpZVTExEUl3ZJBZibMZF9mY+G7rJeCITqTr1OD6vv+8KVGcgFHxmPQnSVWjbJ
 vBCCweGupVA5Oqy2OlgU+zDforbVZE4ElCoORNLbeLyUG146wSxo/vJfScRvdYUl3uCy
 b8zMS5fVXXh9wnFa97u+lZ+AZIvZZ9WNggv6SXCNnZeikEZ2dlT4qQrD9bvJjW81yzcm
 Vi5Dk19qefQBMRQM/LJY3Tp14wwU7xvxlx0+mtdlOX47JNiPSCEuOWp3rgtaBxM9b6wc
 RqVK6ne74Sz58zJhhuaAToZFFpd8oOvsCmCWDw5ArZp0AAxnJn638ctNQFyZ4hGJ+EwV
 PyNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=QtavOgtJbqCDtFoMyh2yfPlecYMuCnzasezS0T2jFho=;
 b=uEc8gsPHrSZkA/G5yZGXtq2LdDZ+jT16EKIeoMuqFA1LDCmUGwjCDMa+OX31G7XSPZ
 /VW4S1JcgwRH1LixgJlDpOKANOS7tuZYB4MveRI2L5oqxKBad0x3eMRxoG24KAtI5XoU
 wCru6L/H9Op252K9O/J/E0BXTsjJoS1hfqzbDMf5sGL2mssZQdE6C8CbHGeQ84VRCh0c
 LCbysQ26bwhtq1DfIbwyMeg3oy19C0t8ry4HuP2lSdmavLE/BwHaGxlgcE47SuyNvBAE
 hh4UylPCmQXlFER5ZiK+6auQd8psny6vBvbHYvVACQs0maoCX/MDZLPFBXtGz58Wp+/4
 hP+Q==
X-Gm-Message-State: AOAM531We2SSSkFLyLo8vjpMHDt3CUgo35EpYWuXIL0YJV65e5oaZxp5
 wuhyfWzyN6NTmGvmmDaP+JyXadF1bNQ=
X-Google-Smtp-Source: ABdhPJxidZQcqfERxf9H1XAUhqKmcs43rjnLzqqmTEMvPFc1QZ1JLed17g9gumignU1VSKkpNfhoIw==
X-Received: by 2002:aa7:9096:: with SMTP id i22mr555981pfa.250.1589491716065; 
 Thu, 14 May 2020 14:28:36 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id i7sm4986pjj.33.2020.05.14.14.28.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2020 14:28:35 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/6] target/arm: Convert rax1 to gvec helpers
Date: Thu, 14 May 2020 14:28:27 -0700
Message-Id: <20200514212831.31248-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200514212831.31248-1-richard.henderson@linaro.org>
References: <20200514212831.31248-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::441;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x441.google.com
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
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

With this conversion, we will be able to use the same helpers
with sve.  This also fixes a bug in which we failed to clear
the high bits of the SVE register after an AdvSIMD operation.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.h        |  2 ++
 target/arm/translate-a64.h |  3 ++
 target/arm/crypto_helper.c | 11 +++++++
 target/arm/translate-a64.c | 59 ++++++++++++++++++++------------------
 4 files changed, 47 insertions(+), 28 deletions(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index 42759f82aa..6c4eb9befb 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -534,6 +534,8 @@ DEF_HELPER_FLAGS_3(crypto_sm3partw2, TCG_CALL_NO_RWG, void, ptr, ptr, ptr)
 DEF_HELPER_FLAGS_4(crypto_sm4e, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(crypto_sm4ekey, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 
+DEF_HELPER_FLAGS_4(crypto_rax1, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
 DEF_HELPER_FLAGS_3(crc32, TCG_CALL_NO_RWG_SE, i32, i32, i32, i32)
 DEF_HELPER_FLAGS_3(crc32c, TCG_CALL_NO_RWG_SE, i32, i32, i32, i32)
 
diff --git a/target/arm/translate-a64.h b/target/arm/translate-a64.h
index f02fbb63a4..da0f59a2ce 100644
--- a/target/arm/translate-a64.h
+++ b/target/arm/translate-a64.h
@@ -115,4 +115,7 @@ static inline int vec_full_reg_size(DisasContext *s)
 
 bool disas_sve(DisasContext *, uint32_t);
 
+void gen_gvec_rax1(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
+                   uint32_t rm_ofs, uint32_t opr_sz, uint32_t max_sz);
+
 #endif /* TARGET_ARM_TRANSLATE_A64_H */
diff --git a/target/arm/crypto_helper.c b/target/arm/crypto_helper.c
index 6bd5a3d2d0..372d8350e4 100644
--- a/target/arm/crypto_helper.c
+++ b/target/arm/crypto_helper.c
@@ -725,3 +725,14 @@ void HELPER(crypto_sm4ekey)(void *vd, void *vn, void* vm, uint32_t desc)
     }
     clear_tail(vd, opr_sz, simd_maxsz(desc));
 }
+
+void HELPER(crypto_rax1)(void *vd, void *vn, void *vm, uint32_t desc)
+{
+    intptr_t i, opr_sz = simd_oprsz(desc);
+    uint64_t *d = vd, *n = vn, *m = vm;
+
+    for (i = 0; i < opr_sz / 8; ++i) {
+        d[i] = n[i] ^ rol64(m[i], 1);
+    }
+    clear_tail(vd, opr_sz, simd_maxsz(desc));
+}
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 1e511529b8..4d7a8fd2bb 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -13579,6 +13579,32 @@ static void disas_crypto_two_reg_sha(DisasContext *s, uint32_t insn)
     tcg_temp_free_ptr(tcg_rn_ptr);
 }
 
+static void gen_rax1_i64(TCGv_i64 d, TCGv_i64 n, TCGv_i64 m)
+{
+    tcg_gen_rotli_i64(d, m, 1);
+    tcg_gen_xor_i64(d, d, n);
+}
+
+static void gen_rax1_vec(unsigned vece, TCGv_vec d, TCGv_vec n, TCGv_vec m)
+{
+    tcg_gen_rotli_vec(vece, d, m, 1);
+    tcg_gen_xor_vec(vece, d, d, n);
+}
+
+void gen_gvec_rax1(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
+                   uint32_t rm_ofs, uint32_t opr_sz, uint32_t max_sz)
+{
+    static const TCGOpcode vecop_list[] = { INDEX_op_rotli_vec, 0 };
+    static const GVecGen3 op = {
+        .fni8 = gen_rax1_i64,
+        .fniv = gen_rax1_vec,
+        .opt_opc = vecop_list,
+        .fno = gen_helper_crypto_rax1,
+        .vece = MO_64,
+    };
+    tcg_gen_gvec_3(rd_ofs, rn_ofs, rm_ofs, opr_sz, max_sz, &op);
+}
+
 /* Crypto three-reg SHA512
  *  31                   21 20  16 15  14  13 12  11  10  9    5 4    0
  * +-----------------------+------+---+---+-----+--------+------+------+
@@ -13595,6 +13621,7 @@ static void disas_crypto_three_reg_sha512(DisasContext *s, uint32_t insn)
     bool feature;
     CryptoThreeOpFn *genfn = NULL;
     gen_helper_gvec_3 *oolfn = NULL;
+    GVecGen3Fn *gvecfn = NULL;
 
     if (o == 0) {
         switch (opcode) {
@@ -13612,7 +13639,7 @@ static void disas_crypto_three_reg_sha512(DisasContext *s, uint32_t insn)
             break;
         case 3: /* RAX1 */
             feature = dc_isar_feature(aa64_sha3, s);
-            genfn = NULL;
+            gvecfn = gen_gvec_rax1;
             break;
         default:
             g_assert_not_reached();
@@ -13648,10 +13675,9 @@ static void disas_crypto_three_reg_sha512(DisasContext *s, uint32_t insn)
 
     if (oolfn) {
         gen_gvec_op3_ool(s, true, rd, rn, rm, 0, oolfn);
-        return;
-    }
-
-    if (genfn) {
+    } else if (gvecfn) {
+        gen_gvec_fn3(s, true, rd, rn, rm, gvecfn, MO_64);
+    } else {
         TCGv_ptr tcg_rd_ptr, tcg_rn_ptr, tcg_rm_ptr;
 
         tcg_rd_ptr = vec_full_reg_ptr(s, rd);
@@ -13663,29 +13689,6 @@ static void disas_crypto_three_reg_sha512(DisasContext *s, uint32_t insn)
         tcg_temp_free_ptr(tcg_rd_ptr);
         tcg_temp_free_ptr(tcg_rn_ptr);
         tcg_temp_free_ptr(tcg_rm_ptr);
-    } else {
-        TCGv_i64 tcg_op1, tcg_op2, tcg_res[2];
-        int pass;
-
-        tcg_op1 = tcg_temp_new_i64();
-        tcg_op2 = tcg_temp_new_i64();
-        tcg_res[0] = tcg_temp_new_i64();
-        tcg_res[1] = tcg_temp_new_i64();
-
-        for (pass = 0; pass < 2; pass++) {
-            read_vec_element(s, tcg_op1, rn, pass, MO_64);
-            read_vec_element(s, tcg_op2, rm, pass, MO_64);
-
-            tcg_gen_rotli_i64(tcg_res[pass], tcg_op2, 1);
-            tcg_gen_xor_i64(tcg_res[pass], tcg_res[pass], tcg_op1);
-        }
-        write_vec_element(s, tcg_res[0], rd, 0, MO_64);
-        write_vec_element(s, tcg_res[1], rd, 1, MO_64);
-
-        tcg_temp_free_i64(tcg_op1);
-        tcg_temp_free_i64(tcg_op2);
-        tcg_temp_free_i64(tcg_res[0]);
-        tcg_temp_free_i64(tcg_res[1]);
     }
 }
 
-- 
2.20.1


