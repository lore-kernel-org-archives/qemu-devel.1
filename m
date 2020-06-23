Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12499C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 11:40:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D23AB20768
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 11:40:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J/JPg4MO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D23AB20768
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58200 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnhI9-0004Fq-0Q
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 07:40:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43842)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jnhGl-0002LX-Jj
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 07:39:15 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d]:42331)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jnhGj-00038L-PC
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 07:39:15 -0400
Received: by mail-wr1-x42d.google.com with SMTP id o11so12447945wrv.9
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2020 04:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=gRw4h9UD+OhkmlKpVapEWtG7EMQyMl+l02GMd7Nx7gQ=;
 b=J/JPg4MOIZ9G/GdLzWL0gACIH/2SbKQ6yj8I+oLnsfCrA6f9zH3PMoGizb6bfTxF4R
 MfB66WMb8t1eGSsTs5thuNcRs76dg3zfEL5ljW8f8pJzKlLVf7kD2/kSdEi2hfVnmUMD
 0teMKNTVViJya/3KxKuiNxtrPTBkwsLl0UH12eEowyN9JTZVbxX9e30eUzfiEVYpTj1G
 aOO+a2hijGtgFBEWyc496UPVDSeJQAq877y2NhYow2RU0eFrfTetRyQnkCx+HmhsF7QY
 72KT8KiifMFxhTO1P+5x6huptbPmJsWssEs2nczl37geEC3fklCmg5rX7E0zURsd3LQ/
 +8uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=gRw4h9UD+OhkmlKpVapEWtG7EMQyMl+l02GMd7Nx7gQ=;
 b=kBlFB6uVe0uj0kseqpoCtX1oiaSvNpTSwqfFILhRTLUguRayL/jvtliV5rgtGh95pI
 mTE2UT1oF3Nu3bQk6+RkwXcF/kIqxFSrf9nX+JsxbiSBrvmMMI9ROHJONFynvRlDLKGw
 KNt8UfS3+pB9xHW8Dy99USHOzA1Kj7xEUpJxK3bfs4W3u0uhYP7K7oeetbGo7rqzmhC5
 dpikpT5oQ20QXl/EkscPyEq7j+fBIYSyRtq1ZwZvP+Zcdqw3SZpcyv2bK2cH9Y4InE42
 FOXJqUZvnvfCx2WTOTanhVTKWO37UsgeUnOpM2mYldmYpjzaW2njLnCrmAfpIdXRAY4L
 L+UA==
X-Gm-Message-State: AOAM531XCuDUtCWJ2kayNlXp5VksmIKfAmbyZ+L5aTyGH2+OFB2DYROI
 Bs6dDTh4oz4qqJaCfs749tthM4HhrMySpg==
X-Google-Smtp-Source: ABdhPJxAsHW3FlZd67u/vyi7kcTdYo1NLAtNA2oAxICMLlAAGHqIU+tlTUgPlCgrTPvAVYDgQtZlmQ==
X-Received: by 2002:adf:db4d:: with SMTP id f13mr20903981wrj.336.1592912351949; 
 Tue, 23 Jun 2020 04:39:11 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id m10sm4022177wru.4.2020.06.23.04.39.10
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2020 04:39:11 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 05/42] target/arm: Convert VZIP, VUZP to decodetree
Date: Tue, 23 Jun 2020 12:38:27 +0100
Message-Id: <20200623113904.28805-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200623113904.28805-1-peter.maydell@linaro.org>
References: <20200623113904.28805-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42d.google.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Convert the Neon VZIP and VUZP insns in the 2-reg-misc group to
decodetree.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200616170844.13318-4-peter.maydell@linaro.org
---
 target/arm/neon-dp.decode       |  3 ++
 target/arm/translate-neon.inc.c | 74 ++++++++++++++++++++++++++
 target/arm/translate.c          | 92 +--------------------------------
 3 files changed, 79 insertions(+), 90 deletions(-)

diff --git a/target/arm/neon-dp.decode b/target/arm/neon-dp.decode
index dd521baa07d..ad9e17fd737 100644
--- a/target/arm/neon-dp.decode
+++ b/target/arm/neon-dp.decode
@@ -447,6 +447,9 @@ Vimm_1r          1111 001 . 1 . 000 ... .... cmode:4 0 . op:1 1 .... @1reg_imm
 
     VPADAL_S     1111 001 11 . 11 .. 00 .... 0 1100 . . 0 .... @2misc
     VPADAL_U     1111 001 11 . 11 .. 00 .... 0 1101 . . 0 .... @2misc
+
+    VUZP         1111 001 11 . 11 .. 10 .... 0 0010 . . 0 .... @2misc
+    VZIP         1111 001 11 . 11 .. 10 .... 0 0011 . . 0 .... @2misc
   ]
 
   # Subgroup for size != 0b11
diff --git a/target/arm/translate-neon.inc.c b/target/arm/translate-neon.inc.c
index 2f7bd0d556f..f4799dd9770 100644
--- a/target/arm/translate-neon.inc.c
+++ b/target/arm/translate-neon.inc.c
@@ -3169,3 +3169,77 @@ static bool trans_VPADAL_U(DisasContext *s, arg_2misc *a)
     return do_2misc_pairwise(s, a, widenfn[a->size], opfn[a->size],
                              accfn[a->size]);
 }
+
+typedef void ZipFn(TCGv_ptr, TCGv_ptr);
+
+static bool do_zip_uzp(DisasContext *s, arg_2misc *a,
+                       ZipFn *fn)
+{
+    TCGv_ptr pd, pm;
+
+    if (!arm_dc_feature(s, ARM_FEATURE_NEON)) {
+        return false;
+    }
+
+    /* UNDEF accesses to D16-D31 if they don't exist. */
+    if (!dc_isar_feature(aa32_simd_r32, s) &&
+        ((a->vd | a->vm) & 0x10)) {
+        return false;
+    }
+
+    if ((a->vd | a->vm) & a->q) {
+        return false;
+    }
+
+    if (!fn) {
+        /* Bad size or size/q combination */
+        return false;
+    }
+
+    if (!vfp_access_check(s)) {
+        return true;
+    }
+
+    pd = vfp_reg_ptr(true, a->vd);
+    pm = vfp_reg_ptr(true, a->vm);
+    fn(pd, pm);
+    tcg_temp_free_ptr(pd);
+    tcg_temp_free_ptr(pm);
+    return true;
+}
+
+static bool trans_VUZP(DisasContext *s, arg_2misc *a)
+{
+    static ZipFn * const fn[2][4] = {
+        {
+            gen_helper_neon_unzip8,
+            gen_helper_neon_unzip16,
+            NULL,
+            NULL,
+        }, {
+            gen_helper_neon_qunzip8,
+            gen_helper_neon_qunzip16,
+            gen_helper_neon_qunzip32,
+            NULL,
+        }
+    };
+    return do_zip_uzp(s, a, fn[a->q][a->size]);
+}
+
+static bool trans_VZIP(DisasContext *s, arg_2misc *a)
+{
+    static ZipFn * const fn[2][4] = {
+        {
+            gen_helper_neon_zip8,
+            gen_helper_neon_zip16,
+            NULL,
+            NULL,
+        }, {
+            gen_helper_neon_qzip8,
+            gen_helper_neon_qzip16,
+            gen_helper_neon_qzip32,
+            NULL,
+        }
+    };
+    return do_zip_uzp(s, a, fn[a->q][a->size]);
+}
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 4405b034f77..442f287d861 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -2934,86 +2934,6 @@ static void gen_exception_return(DisasContext *s, TCGv_i32 pc)
     gen_rfe(s, pc, load_cpu_field(spsr));
 }
 
-static int gen_neon_unzip(int rd, int rm, int size, int q)
-{
-    TCGv_ptr pd, pm;
-    
-    if (!q && size == 2) {
-        return 1;
-    }
-    pd = vfp_reg_ptr(true, rd);
-    pm = vfp_reg_ptr(true, rm);
-    if (q) {
-        switch (size) {
-        case 0:
-            gen_helper_neon_qunzip8(pd, pm);
-            break;
-        case 1:
-            gen_helper_neon_qunzip16(pd, pm);
-            break;
-        case 2:
-            gen_helper_neon_qunzip32(pd, pm);
-            break;
-        default:
-            abort();
-        }
-    } else {
-        switch (size) {
-        case 0:
-            gen_helper_neon_unzip8(pd, pm);
-            break;
-        case 1:
-            gen_helper_neon_unzip16(pd, pm);
-            break;
-        default:
-            abort();
-        }
-    }
-    tcg_temp_free_ptr(pd);
-    tcg_temp_free_ptr(pm);
-    return 0;
-}
-
-static int gen_neon_zip(int rd, int rm, int size, int q)
-{
-    TCGv_ptr pd, pm;
-
-    if (!q && size == 2) {
-        return 1;
-    }
-    pd = vfp_reg_ptr(true, rd);
-    pm = vfp_reg_ptr(true, rm);
-    if (q) {
-        switch (size) {
-        case 0:
-            gen_helper_neon_qzip8(pd, pm);
-            break;
-        case 1:
-            gen_helper_neon_qzip16(pd, pm);
-            break;
-        case 2:
-            gen_helper_neon_qzip32(pd, pm);
-            break;
-        default:
-            abort();
-        }
-    } else {
-        switch (size) {
-        case 0:
-            gen_helper_neon_zip8(pd, pm);
-            break;
-        case 1:
-            gen_helper_neon_zip16(pd, pm);
-            break;
-        default:
-            abort();
-        }
-    }
-    tcg_temp_free_ptr(pd);
-    tcg_temp_free_ptr(pm);
-    return 0;
-}
-
 static void gen_neon_trn_u8(TCGv_i32 t0, TCGv_i32 t1)
 {
     TCGv_i32 rd, tmp;
@@ -5082,6 +5002,8 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                 case NEON_2RM_VREV64:
                 case NEON_2RM_VPADDL: case NEON_2RM_VPADDL_U:
                 case NEON_2RM_VPADAL: case NEON_2RM_VPADAL_U:
+                case NEON_2RM_VUZP:
+                case NEON_2RM_VZIP:
                     /* handled by decodetree */
                     return 1;
                 case NEON_2RM_VTRN:
@@ -5097,16 +5019,6 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                         goto elementwise;
                     }
                     break;
-                case NEON_2RM_VUZP:
-                    if (gen_neon_unzip(rd, rm, size, q)) {
-                        return 1;
-                    }
-                    break;
-                case NEON_2RM_VZIP:
-                    if (gen_neon_zip(rd, rm, size, q)) {
-                        return 1;
-                    }
-                    break;
                 case NEON_2RM_VMOVN: case NEON_2RM_VQMOVN:
                     /* also VQMOVUN; op field and mnemonics don't line up */
                     if (rm & 1) {
-- 
2.20.1


