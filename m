Return-Path: <SRS0=t3yw=6Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0CEFC3A5A9
	for <qemu-devel@archiver.kernel.org>; Sat,  2 May 2020 22:51:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87467206B8
	for <qemu-devel@archiver.kernel.org>; Sat,  2 May 2020 22:51:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Mn/6U0XZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87467206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53552 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jV0yk-0006cv-Ku
	for qemu-devel@archiver.kernel.org; Sat, 02 May 2020 18:51:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51624)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jV0sr-0003Fc-2f
 for qemu-devel@nongnu.org; Sat, 02 May 2020 18:45:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jV0sq-0004js-0D
 for qemu-devel@nongnu.org; Sat, 02 May 2020 18:45:20 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:38476)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jV0sp-0004jH-AH
 for qemu-devel@nongnu.org; Sat, 02 May 2020 18:45:19 -0400
Received: by mail-pf1-x444.google.com with SMTP id y25so3540961pfn.5
 for <qemu-devel@nongnu.org>; Sat, 02 May 2020 15:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ZBw+W06UBx//+69mT18KkEAMZiojtZ4qaweFEtT8bk0=;
 b=Mn/6U0XZZzZqcEGEn/rCmyTimrOSl/2+e2rUjftQENEpapE4Euqn7Y5lR6oQPXzIsQ
 yIDJcIA7LJveMhTzAsFOgidxj4eTRfqfXMpGN75NFzPoCfe2Myp/4PhO+OIn4jxsVYj4
 5V+oa/bXEkJYiiRHgXWlT1qRgJBZvT0gMKuvuXoXfhuAKzyL8bzDx2CPDgPqeoylj+M4
 K3ouVQ0HQux1lDSfft9MTBzx0u/36p0NM453A74UDhbgKrHDuyb7rJg3gfr4zM53bWOe
 qikfJZSoD73j+zcLvlFx2gAbMoHCLvPKv0kz5VpBHekerk/C2NvKOA2lkax1hWEu7KWh
 bvMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ZBw+W06UBx//+69mT18KkEAMZiojtZ4qaweFEtT8bk0=;
 b=Uk6x8eMBJo1CHCutO/MIkgElSny3WyaYwqGOlY4x4I3jUFp8Srw5/6Uojc73wtdz43
 H22R8Hg9s8yYY1xPuIgwvgA0Q85y7+7uTVaUQjtdsJ9zO9MqCZFhldpdUjiUHR3qQtwM
 G4DIy96EG6U8TOhKuU55DbPKICIgcMU8Ju0FeedugTZol8a+zOoiAL0hsg8g9EWkbF1U
 vz92kRp1TXRwDI+lDOOXgxOSRvnlrkZIBZYLkwZURNrI2oaS8hltYNEHrp9tl4doh0Cy
 N2f691N+PKqocKaQt1IIvleqZqEOdOFliqNOLm0jPANKWcbkxoYHZQ7Xoij9EASuf8Lc
 RK5Q==
X-Gm-Message-State: AGi0Pub8wQl1k71Z7HUvkQcP8mDiaDNnXgBzPvuTX1rcGjxjWdeJoLSH
 EIej09QG9IsQIoJLYunoVukhf2Df/8E=
X-Google-Smtp-Source: APiQypLqg+s16Rcv2kEYr6h0MiJ2tGagyjQ3dAzvpNAkQWGmsPQ0Ca1w09Fk1MkZxqk+ENPj0SLf3Q==
X-Received: by 2002:a05:6a00:2b4:: with SMTP id
 q20mr10609612pfs.104.1588459517133; 
 Sat, 02 May 2020 15:45:17 -0700 (PDT)
Received: from localhost.localdomain (174-21-149-226.tukw.qwest.net.
 [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id h5sm2956182pjv.4.2020.05.02.15.45.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 May 2020 15:45:16 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 09/15] target/arm: Wrap vector uqadd/sqadd/uqsub/sqsub
 GVecGen4 in GVecGen3Fn
Date: Sat,  2 May 2020 15:44:57 -0700
Message-Id: <20200502224503.2282-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200502224503.2282-1-richard.henderson@linaro.org>
References: <20200502224503.2282-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::444;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::444
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate.h     |  13 +-
 target/arm/translate-a64.c |  22 ++--
 target/arm/translate.c     | 248 +++++++++++++++++++++----------------
 3 files changed, 157 insertions(+), 126 deletions(-)

diff --git a/target/arm/translate.h b/target/arm/translate.h
index b3e47e7a7f..ada84d411d 100644
--- a/target/arm/translate.h
+++ b/target/arm/translate.h
@@ -298,16 +298,21 @@ void gen_gvec_sshl(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
 void gen_gvec_ushl(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
                    uint32_t rm_ofs, uint32_t opr_sz, uint32_t max_sz);
 
-extern const GVecGen4 uqadd_op[4];
-extern const GVecGen4 sqadd_op[4];
-extern const GVecGen4 uqsub_op[4];
-extern const GVecGen4 sqsub_op[4];
 void gen_cmtst_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b);
 void gen_ushl_i32(TCGv_i32 d, TCGv_i32 a, TCGv_i32 b);
 void gen_sshl_i32(TCGv_i32 d, TCGv_i32 a, TCGv_i32 b);
 void gen_ushl_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b);
 void gen_sshl_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b);
 
+void gen_gvec_uqadd_qc(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
+                       uint32_t rm_ofs, uint32_t opr_sz, uint32_t max_sz);
+void gen_gvec_sqadd_qc(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
+                       uint32_t rm_ofs, uint32_t opr_sz, uint32_t max_sz);
+void gen_gvec_uqsub_qc(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
+                       uint32_t rm_ofs, uint32_t opr_sz, uint32_t max_sz);
+void gen_gvec_sqsub_qc(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
+                       uint32_t rm_ofs, uint32_t opr_sz, uint32_t max_sz);
+
 void gen_gvec_ssra(unsigned vece, uint32_t rd_ofs, uint32_t rm_ofs,
                    int64_t shift, uint32_t opr_sz, uint32_t max_sz);
 void gen_gvec_usra(unsigned vece, uint32_t rd_ofs, uint32_t rm_ofs,
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 2be6ab541e..eeaa92b9f1 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -11185,20 +11185,18 @@ static void disas_simd_3same_int(DisasContext *s, uint32_t insn)
 
     switch (opcode) {
     case 0x01: /* SQADD, UQADD */
-        tcg_gen_gvec_4(vec_full_reg_offset(s, rd),
-                       offsetof(CPUARMState, vfp.qc),
-                       vec_full_reg_offset(s, rn),
-                       vec_full_reg_offset(s, rm),
-                       is_q ? 16 : 8, vec_full_reg_size(s),
-                       (u ? uqadd_op : sqadd_op) + size);
+        if (u) {
+            gen_gvec_fn3(s, is_q, rd, rn, rm, gen_gvec_uqadd_qc, size);
+        } else {
+            gen_gvec_fn3(s, is_q, rd, rn, rm, gen_gvec_sqadd_qc, size);
+        }
         return;
     case 0x05: /* SQSUB, UQSUB */
-        tcg_gen_gvec_4(vec_full_reg_offset(s, rd),
-                       offsetof(CPUARMState, vfp.qc),
-                       vec_full_reg_offset(s, rn),
-                       vec_full_reg_offset(s, rm),
-                       is_q ? 16 : 8, vec_full_reg_size(s),
-                       (u ? uqsub_op : sqsub_op) + size);
+        if (u) {
+            gen_gvec_fn3(s, is_q, rd, rn, rm, gen_gvec_uqsub_qc, size);
+        } else {
+            gen_gvec_fn3(s, is_q, rd, rn, rm, gen_gvec_sqsub_qc, size);
+        }
         return;
     case 0x08: /* SSHL, USHL */
         if (u) {
diff --git a/target/arm/translate.c b/target/arm/translate.c
index e5aa78c88a..8e6c6f7b00 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -5197,32 +5197,37 @@ static void gen_uqadd_vec(unsigned vece, TCGv_vec t, TCGv_vec sat,
     tcg_temp_free_vec(x);
 }
 
-static const TCGOpcode vecop_list_uqadd[] = {
-    INDEX_op_usadd_vec, INDEX_op_cmp_vec, INDEX_op_add_vec, 0
-};
-
-const GVecGen4 uqadd_op[4] = {
-    { .fniv = gen_uqadd_vec,
-      .fno = gen_helper_gvec_uqadd_b,
-      .write_aofs = true,
-      .opt_opc = vecop_list_uqadd,
-      .vece = MO_8 },
-    { .fniv = gen_uqadd_vec,
-      .fno = gen_helper_gvec_uqadd_h,
-      .write_aofs = true,
-      .opt_opc = vecop_list_uqadd,
-      .vece = MO_16 },
-    { .fniv = gen_uqadd_vec,
-      .fno = gen_helper_gvec_uqadd_s,
-      .write_aofs = true,
-      .opt_opc = vecop_list_uqadd,
-      .vece = MO_32 },
-    { .fniv = gen_uqadd_vec,
-      .fno = gen_helper_gvec_uqadd_d,
-      .write_aofs = true,
-      .opt_opc = vecop_list_uqadd,
-      .vece = MO_64 },
-};
+void gen_gvec_uqadd_qc(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
+                       uint32_t rm_ofs, uint32_t opr_sz, uint32_t max_sz)
+{
+    static const TCGOpcode vecop_list[] = {
+        INDEX_op_usadd_vec, INDEX_op_cmp_vec, INDEX_op_add_vec, 0
+    };
+    static const GVecGen4 ops[4] = {
+        { .fniv = gen_uqadd_vec,
+          .fno = gen_helper_gvec_uqadd_b,
+          .write_aofs = true,
+          .opt_opc = vecop_list,
+          .vece = MO_8 },
+        { .fniv = gen_uqadd_vec,
+          .fno = gen_helper_gvec_uqadd_h,
+          .write_aofs = true,
+          .opt_opc = vecop_list,
+          .vece = MO_16 },
+        { .fniv = gen_uqadd_vec,
+          .fno = gen_helper_gvec_uqadd_s,
+          .write_aofs = true,
+          .opt_opc = vecop_list,
+          .vece = MO_32 },
+        { .fniv = gen_uqadd_vec,
+          .fno = gen_helper_gvec_uqadd_d,
+          .write_aofs = true,
+          .opt_opc = vecop_list,
+          .vece = MO_64 },
+    };
+    tcg_gen_gvec_4(rd_ofs, offsetof(CPUARMState, vfp.qc),
+                   rn_ofs, rm_ofs, opr_sz, max_sz, &ops[vece]);
+}
 
 static void gen_sqadd_vec(unsigned vece, TCGv_vec t, TCGv_vec sat,
                           TCGv_vec a, TCGv_vec b)
@@ -5235,32 +5240,37 @@ static void gen_sqadd_vec(unsigned vece, TCGv_vec t, TCGv_vec sat,
     tcg_temp_free_vec(x);
 }
 
-static const TCGOpcode vecop_list_sqadd[] = {
-    INDEX_op_ssadd_vec, INDEX_op_cmp_vec, INDEX_op_add_vec, 0
-};
-
-const GVecGen4 sqadd_op[4] = {
-    { .fniv = gen_sqadd_vec,
-      .fno = gen_helper_gvec_sqadd_b,
-      .opt_opc = vecop_list_sqadd,
-      .write_aofs = true,
-      .vece = MO_8 },
-    { .fniv = gen_sqadd_vec,
-      .fno = gen_helper_gvec_sqadd_h,
-      .opt_opc = vecop_list_sqadd,
-      .write_aofs = true,
-      .vece = MO_16 },
-    { .fniv = gen_sqadd_vec,
-      .fno = gen_helper_gvec_sqadd_s,
-      .opt_opc = vecop_list_sqadd,
-      .write_aofs = true,
-      .vece = MO_32 },
-    { .fniv = gen_sqadd_vec,
-      .fno = gen_helper_gvec_sqadd_d,
-      .opt_opc = vecop_list_sqadd,
-      .write_aofs = true,
-      .vece = MO_64 },
-};
+void gen_gvec_sqadd_qc(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
+                       uint32_t rm_ofs, uint32_t opr_sz, uint32_t max_sz)
+{
+    static const TCGOpcode vecop_list[] = {
+        INDEX_op_ssadd_vec, INDEX_op_cmp_vec, INDEX_op_add_vec, 0
+    };
+    static const GVecGen4 ops[4] = {
+        { .fniv = gen_sqadd_vec,
+          .fno = gen_helper_gvec_sqadd_b,
+          .opt_opc = vecop_list,
+          .write_aofs = true,
+          .vece = MO_8 },
+        { .fniv = gen_sqadd_vec,
+          .fno = gen_helper_gvec_sqadd_h,
+          .opt_opc = vecop_list,
+          .write_aofs = true,
+          .vece = MO_16 },
+        { .fniv = gen_sqadd_vec,
+          .fno = gen_helper_gvec_sqadd_s,
+          .opt_opc = vecop_list,
+          .write_aofs = true,
+          .vece = MO_32 },
+        { .fniv = gen_sqadd_vec,
+          .fno = gen_helper_gvec_sqadd_d,
+          .opt_opc = vecop_list,
+          .write_aofs = true,
+          .vece = MO_64 },
+    };
+    tcg_gen_gvec_4(rd_ofs, offsetof(CPUARMState, vfp.qc),
+                   rn_ofs, rm_ofs, opr_sz, max_sz, &ops[vece]);
+}
 
 static void gen_uqsub_vec(unsigned vece, TCGv_vec t, TCGv_vec sat,
                           TCGv_vec a, TCGv_vec b)
@@ -5273,32 +5283,37 @@ static void gen_uqsub_vec(unsigned vece, TCGv_vec t, TCGv_vec sat,
     tcg_temp_free_vec(x);
 }
 
-static const TCGOpcode vecop_list_uqsub[] = {
-    INDEX_op_ussub_vec, INDEX_op_cmp_vec, INDEX_op_sub_vec, 0
-};
-
-const GVecGen4 uqsub_op[4] = {
-    { .fniv = gen_uqsub_vec,
-      .fno = gen_helper_gvec_uqsub_b,
-      .opt_opc = vecop_list_uqsub,
-      .write_aofs = true,
-      .vece = MO_8 },
-    { .fniv = gen_uqsub_vec,
-      .fno = gen_helper_gvec_uqsub_h,
-      .opt_opc = vecop_list_uqsub,
-      .write_aofs = true,
-      .vece = MO_16 },
-    { .fniv = gen_uqsub_vec,
-      .fno = gen_helper_gvec_uqsub_s,
-      .opt_opc = vecop_list_uqsub,
-      .write_aofs = true,
-      .vece = MO_32 },
-    { .fniv = gen_uqsub_vec,
-      .fno = gen_helper_gvec_uqsub_d,
-      .opt_opc = vecop_list_uqsub,
-      .write_aofs = true,
-      .vece = MO_64 },
-};
+void gen_gvec_uqsub_qc(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
+                       uint32_t rm_ofs, uint32_t opr_sz, uint32_t max_sz)
+{
+    static const TCGOpcode vecop_list[] = {
+        INDEX_op_ussub_vec, INDEX_op_cmp_vec, INDEX_op_sub_vec, 0
+    };
+    static const GVecGen4 ops[4] = {
+        { .fniv = gen_uqsub_vec,
+          .fno = gen_helper_gvec_uqsub_b,
+          .opt_opc = vecop_list,
+          .write_aofs = true,
+          .vece = MO_8 },
+        { .fniv = gen_uqsub_vec,
+          .fno = gen_helper_gvec_uqsub_h,
+          .opt_opc = vecop_list,
+          .write_aofs = true,
+          .vece = MO_16 },
+        { .fniv = gen_uqsub_vec,
+          .fno = gen_helper_gvec_uqsub_s,
+          .opt_opc = vecop_list,
+          .write_aofs = true,
+          .vece = MO_32 },
+        { .fniv = gen_uqsub_vec,
+          .fno = gen_helper_gvec_uqsub_d,
+          .opt_opc = vecop_list,
+          .write_aofs = true,
+          .vece = MO_64 },
+    };
+    tcg_gen_gvec_4(rd_ofs, offsetof(CPUARMState, vfp.qc),
+                   rn_ofs, rm_ofs, opr_sz, max_sz, &ops[vece]);
+}
 
 static void gen_sqsub_vec(unsigned vece, TCGv_vec t, TCGv_vec sat,
                           TCGv_vec a, TCGv_vec b)
@@ -5311,32 +5326,37 @@ static void gen_sqsub_vec(unsigned vece, TCGv_vec t, TCGv_vec sat,
     tcg_temp_free_vec(x);
 }
 
-static const TCGOpcode vecop_list_sqsub[] = {
-    INDEX_op_sssub_vec, INDEX_op_cmp_vec, INDEX_op_sub_vec, 0
-};
-
-const GVecGen4 sqsub_op[4] = {
-    { .fniv = gen_sqsub_vec,
-      .fno = gen_helper_gvec_sqsub_b,
-      .opt_opc = vecop_list_sqsub,
-      .write_aofs = true,
-      .vece = MO_8 },
-    { .fniv = gen_sqsub_vec,
-      .fno = gen_helper_gvec_sqsub_h,
-      .opt_opc = vecop_list_sqsub,
-      .write_aofs = true,
-      .vece = MO_16 },
-    { .fniv = gen_sqsub_vec,
-      .fno = gen_helper_gvec_sqsub_s,
-      .opt_opc = vecop_list_sqsub,
-      .write_aofs = true,
-      .vece = MO_32 },
-    { .fniv = gen_sqsub_vec,
-      .fno = gen_helper_gvec_sqsub_d,
-      .opt_opc = vecop_list_sqsub,
-      .write_aofs = true,
-      .vece = MO_64 },
-};
+void gen_gvec_sqsub_qc(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
+                       uint32_t rm_ofs, uint32_t opr_sz, uint32_t max_sz)
+{
+    static const TCGOpcode vecop_list[] = {
+        INDEX_op_sssub_vec, INDEX_op_cmp_vec, INDEX_op_sub_vec, 0
+    };
+    static const GVecGen4 ops[4] = {
+        { .fniv = gen_sqsub_vec,
+          .fno = gen_helper_gvec_sqsub_b,
+          .opt_opc = vecop_list,
+          .write_aofs = true,
+          .vece = MO_8 },
+        { .fniv = gen_sqsub_vec,
+          .fno = gen_helper_gvec_sqsub_h,
+          .opt_opc = vecop_list,
+          .write_aofs = true,
+          .vece = MO_16 },
+        { .fniv = gen_sqsub_vec,
+          .fno = gen_helper_gvec_sqsub_s,
+          .opt_opc = vecop_list,
+          .write_aofs = true,
+          .vece = MO_32 },
+        { .fniv = gen_sqsub_vec,
+          .fno = gen_helper_gvec_sqsub_d,
+          .opt_opc = vecop_list,
+          .write_aofs = true,
+          .vece = MO_64 },
+    };
+    tcg_gen_gvec_4(rd_ofs, offsetof(CPUARMState, vfp.qc),
+                   rn_ofs, rm_ofs, opr_sz, max_sz, &ops[vece]);
+}
 
 /* Translate a NEON data processing instruction.  Return nonzero if the
    instruction is invalid.
@@ -5522,15 +5542,23 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
             return 0;
 
         case NEON_3R_VQADD:
-            tcg_gen_gvec_4(rd_ofs, offsetof(CPUARMState, vfp.qc),
-                           rn_ofs, rm_ofs, vec_size, vec_size,
-                           (u ? uqadd_op : sqadd_op) + size);
+            if (u) {
+                gen_gvec_uqadd_qc(size, rd_ofs, rn_ofs, rm_ofs,
+                                  vec_size, vec_size);
+            } else {
+                gen_gvec_sqadd_qc(size, rd_ofs, rn_ofs, rm_ofs,
+                                  vec_size, vec_size);
+            }
             return 0;
 
         case NEON_3R_VQSUB:
-            tcg_gen_gvec_4(rd_ofs, offsetof(CPUARMState, vfp.qc),
-                           rn_ofs, rm_ofs, vec_size, vec_size,
-                           (u ? uqsub_op : sqsub_op) + size);
+            if (u) {
+                gen_gvec_uqsub_qc(size, rd_ofs, rn_ofs, rm_ofs,
+                                  vec_size, vec_size);
+            } else {
+                gen_gvec_sqsub_qc(size, rd_ofs, rn_ofs, rm_ofs,
+                                  vec_size, vec_size);
+            }
             return 0;
 
         case NEON_3R_VMUL: /* VMUL */
-- 
2.20.1


