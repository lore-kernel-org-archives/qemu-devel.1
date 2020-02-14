Return-Path: <SRS0=hj7J=4C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 947C9C2BA83
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 18:27:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EA3C22314
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 18:27:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OpOZLTFy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EA3C22314
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43834 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2fgt-0000v6-Hl
	for qemu-devel@archiver.kernel.org; Fri, 14 Feb 2020 13:27:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60990)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j2fVd-0004m8-GJ
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 13:16:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j2fVc-0000N2-4s
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 13:16:13 -0500
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:33092)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j2fVb-0000MZ-Uy
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 13:16:12 -0500
Received: by mail-pg1-x543.google.com with SMTP id 6so5359259pgk.0
 for <qemu-devel@nongnu.org>; Fri, 14 Feb 2020 10:16:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=pMw3WexDwdJHFaht64LuoLlVbRzrqioLE5XZ9OBOKYc=;
 b=OpOZLTFyEqK6z0NFplV4tDRaB/hXh8fwpOHTwR2ICSTFmNcXFYQ1/wuLXfZsyCm+b5
 Z4fswPZ12UOB9MzsZ7brFasvCSl9VZMRYUWoM1eaV5PhqTWaKYYw8nkPCtZC1f2jGvtT
 ruQelYdHp5sstGVUnm46Dd+FG516ZEq6cfxFIH2UqwnRWE3LKG5HW18Q2w6q+QVMzBMc
 tOgRpxFvsk+y/YI0xjjezUTrgm0xcJDffLt236x4Vwi7E/++spbVeo0ad+WQokVu2NLZ
 fxzlW4JOK3lpn1EjCtsLikQ3OAE71XV7tKqHXxZpyUukL9XFQ4LNtnoL8VLpHDeczsCC
 3fKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=pMw3WexDwdJHFaht64LuoLlVbRzrqioLE5XZ9OBOKYc=;
 b=iiothwhOTDc+fSf+RUQ0fSgrZp75e4oWdicAxA5ZRLqolXt8Q+rh61VZTyxEtAmb57
 d3QpnbOLjGYtZY9Q4FcGbFkdWQCjo8ky/2mcuF8M3g/jjDSINfVHaF9eYk3qGCWN/irw
 luBorsvt/8e1N2ya7oNz5QXQahSXACCLMIgPw6KuYyTW2qpuFWnLWHkQxPYmckQf5w9T
 6LAJNUglJy+Y89VAPszv2Vvby1bjwrMdqFby3Cgo4Kdb7cuFhCAq7KEtrzZYcCMFEfQ4
 Li8Cbbt0OJOk5kxgrQYltnXXXL5dNQI/6ODy+pRtxpmJL0xTMdUlr/haNaxC8lxOwKwV
 KQXQ==
X-Gm-Message-State: APjAAAWpBJPV1Cs5YiFljjvbBCcWi++AiCFEDCXBWS4qwhB5uFE1QdpD
 BB9kr2hynenK/63B7bzkpVRKNQ5rUjo=
X-Google-Smtp-Source: APXvYqyrf2/+wOY4I0ry0Rp1dmhyQulHacIJKGSySeoykNJZJok0ImNjxIh8iGot5nyOB/te48S4eA==
X-Received: by 2002:a63:5c10:: with SMTP id q16mr4923809pgb.35.1581704170679; 
 Fri, 14 Feb 2020 10:16:10 -0800 (PST)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id i3sm7525123pfg.94.2020.02.14.10.16.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Feb 2020 10:16:09 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 19/19] target/arm: Split VMINMAXNM decode
Date: Fri, 14 Feb 2020 10:15:47 -0800
Message-Id: <20200214181547.21408-20-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214181547.21408-1-richard.henderson@linaro.org>
References: <20200214181547.21408-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::543
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

Passing the raw op field from the manual is less instructive
than it might be.  Do the full decode and use the existing
helpers to perform the expansion.

Since these are v8 insns, VECLEN+VECSTRIDE are already RES0.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/vfp-uncond.decode   |  12 ++--
 target/arm/translate-vfp.inc.c | 109 +++++++++++----------------------
 2 files changed, 44 insertions(+), 77 deletions(-)

diff --git a/target/arm/vfp-uncond.decode b/target/arm/vfp-uncond.decode
index 5af1f2ee66..34ca164266 100644
--- a/target/arm/vfp-uncond.decode
+++ b/target/arm/vfp-uncond.decode
@@ -41,15 +41,19 @@
 %vd_dp  22:1 12:4
 %vd_sp  12:4 22:1
 
+@vfp_dnm_s   ................................ vm=%vm_sp vn=%vn_sp vd=%vd_sp
+@vfp_dnm_d   ................................ vm=%vm_dp vn=%vn_dp vd=%vd_dp
+
 VSEL        1111 1110 0. cc:2 .... .... 1010 .0.0 .... \
             vm=%vm_sp vn=%vn_sp vd=%vd_sp dp=0
 VSEL        1111 1110 0. cc:2 .... .... 1011 .0.0 .... \
             vm=%vm_dp vn=%vn_dp vd=%vd_dp dp=1
 
-VMINMAXNM   1111 1110 1.00 .... .... 1010 . op:1 .0 .... \
-            vm=%vm_sp vn=%vn_sp vd=%vd_sp dp=0
-VMINMAXNM   1111 1110 1.00 .... .... 1011 . op:1 .0 .... \
-            vm=%vm_dp vn=%vn_dp vd=%vd_dp dp=1
+VMAXNM_sp   1111 1110 1.00 .... .... 1010 .0.0 ....         @vfp_dnm_s
+VMINNM_sp   1111 1110 1.00 .... .... 1010 .1.0 ....         @vfp_dnm_s
+
+VMAXNM_dp   1111 1110 1.00 .... .... 1011 .0.0 ....         @vfp_dnm_d
+VMINNM_dp   1111 1110 1.00 .... .... 1011 .1.0 ....         @vfp_dnm_d
 
 VRINT       1111 1110 1.11 10 rm:2 .... 1010 01.0 .... \
             vm=%vm_sp vd=%vd_sp dp=0
diff --git a/target/arm/translate-vfp.inc.c b/target/arm/translate-vfp.inc.c
index b5f3feaf8d..2cf85e73cf 100644
--- a/target/arm/translate-vfp.inc.c
+++ b/target/arm/translate-vfp.inc.c
@@ -322,79 +322,6 @@ static bool trans_VSEL(DisasContext *s, arg_VSEL *a)
     return true;
 }
 
-static bool trans_VMINMAXNM(DisasContext *s, arg_VMINMAXNM *a)
-{
-    uint32_t rd, rn, rm;
-    bool dp = a->dp;
-    bool vmin = a->op;
-    TCGv_ptr fpst;
-
-    if (!dc_isar_feature(aa32_vminmaxnm, s)) {
-        return false;
-    }
-
-    if (dp && !dc_isar_feature(aa32_fpdp_v2, s)) {
-        return false;
-    }
-
-    /* UNDEF accesses to D16-D31 if they don't exist */
-    if (dp && !dc_isar_feature(aa32_simd_r32, s) &&
-        ((a->vm | a->vn | a->vd) & 0x10)) {
-        return false;
-    }
-
-    rd = a->vd;
-    rn = a->vn;
-    rm = a->vm;
-
-    if (!vfp_access_check(s)) {
-        return true;
-    }
-
-    fpst = get_fpstatus_ptr(0);
-
-    if (dp) {
-        TCGv_i64 frn, frm, dest;
-
-        frn = tcg_temp_new_i64();
-        frm = tcg_temp_new_i64();
-        dest = tcg_temp_new_i64();
-
-        neon_load_reg64(frn, rn);
-        neon_load_reg64(frm, rm);
-        if (vmin) {
-            gen_helper_vfp_minnumd(dest, frn, frm, fpst);
-        } else {
-            gen_helper_vfp_maxnumd(dest, frn, frm, fpst);
-        }
-        neon_store_reg64(dest, rd);
-        tcg_temp_free_i64(frn);
-        tcg_temp_free_i64(frm);
-        tcg_temp_free_i64(dest);
-    } else {
-        TCGv_i32 frn, frm, dest;
-
-        frn = tcg_temp_new_i32();
-        frm = tcg_temp_new_i32();
-        dest = tcg_temp_new_i32();
-
-        neon_load_reg32(frn, rn);
-        neon_load_reg32(frm, rm);
-        if (vmin) {
-            gen_helper_vfp_minnums(dest, frn, frm, fpst);
-        } else {
-            gen_helper_vfp_maxnums(dest, frn, frm, fpst);
-        }
-        neon_store_reg32(dest, rd);
-        tcg_temp_free_i32(frn);
-        tcg_temp_free_i32(frm);
-        tcg_temp_free_i32(dest);
-    }
-
-    tcg_temp_free_ptr(fpst);
-    return true;
-}
-
 /*
  * Table for converting the most common AArch32 encoding of
  * rounding mode to arm_fprounding order (which matches the
@@ -1784,6 +1711,42 @@ static bool trans_VDIV_dp(DisasContext *s, arg_VDIV_dp *a)
     return do_vfp_3op_dp(s, gen_helper_vfp_divd, a->vd, a->vn, a->vm, false);
 }
 
+static bool trans_VMINNM_sp(DisasContext *s, arg_VMINNM_sp *a)
+{
+    if (!dc_isar_feature(aa32_vminmaxnm, s)) {
+        return false;
+    }
+    return do_vfp_3op_sp(s, gen_helper_vfp_minnums,
+                         a->vd, a->vn, a->vm, false);
+}
+
+static bool trans_VMAXNM_sp(DisasContext *s, arg_VMAXNM_sp *a)
+{
+    if (!dc_isar_feature(aa32_vminmaxnm, s)) {
+        return false;
+    }
+    return do_vfp_3op_sp(s, gen_helper_vfp_maxnums,
+                         a->vd, a->vn, a->vm, false);
+}
+
+static bool trans_VMINNM_dp(DisasContext *s, arg_VMINNM_dp *a)
+{
+    if (!dc_isar_feature(aa32_vminmaxnm, s)) {
+        return false;
+    }
+    return do_vfp_3op_dp(s, gen_helper_vfp_minnumd,
+                         a->vd, a->vn, a->vm, false);
+}
+
+static bool trans_VMAXNM_dp(DisasContext *s, arg_VMAXNM_dp *a)
+{
+    if (!dc_isar_feature(aa32_vminmaxnm, s)) {
+        return false;
+    }
+    return do_vfp_3op_dp(s, gen_helper_vfp_maxnumd,
+                         a->vd, a->vn, a->vm, false);
+}
+
 static bool do_vfm_sp(DisasContext *s, arg_VFMA_sp *a, bool neg_n, bool neg_d)
 {
     /*
-- 
2.20.1


