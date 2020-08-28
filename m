Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1A6BC433E6
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 18:41:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A96C120737
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 18:41:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VP5Z8Eqd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A96C120737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58946 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBjJq-00058H-RF
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 14:41:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58900)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kBjCj-0002X1-A0
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 14:34:25 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:42996)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kBjCc-0005yo-PL
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 14:34:24 -0400
Received: by mail-wr1-x443.google.com with SMTP id c18so42299wrm.9
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 11:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=SpjNLpXsFoj6kxewsPo7gjZ4twjnVkm0kk0XSYVH8rY=;
 b=VP5Z8EqdS5lhxOl+Y28w5eD3/KldhPftK7i4fgR1jItfcLRUyzVZiSJDPNFXHCgB/o
 GrAOjIGhD5XZEPmajc7w2Lv0dymRShJeNVLCorrLhwaxfXKPm+abq/0yMJ8GPSrzcVEl
 CXa1FZPDmqUP9q9SHQkxSBO6HPqe1gZqeso9RGCXZKD6OYKvQxu4zC21HJOARggOsOIJ
 dTKNr1cVkiW8+/Cti0RH2qkhygDO2giUJp3MAjip54FuI4pp/iVYKwHeCxc4ZRi0+/fg
 ABQNts6sklmXQqmOUYaQDf4W8Sbo6dYLngX/x1dyMFqheKUDvR7gVyLKobCPTuyP1Lie
 RLlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=SpjNLpXsFoj6kxewsPo7gjZ4twjnVkm0kk0XSYVH8rY=;
 b=SRdqVZHLSZHYCTJqMoU3N/ofnGNMWtJa15Ve/rL/qDw+QXMKjlvdRjT3hw583o6od+
 Q6pB3fOpGcYsBqQbynCX5CygKPKXV8eF0RnblX6zM/oIU2RClcNaluAPlJWo4+MSRx7H
 2T26HyXEZjd7DvFrJvcJj8xlMVl/luk66E+GF6XaZIJz/oKQvcXVpPdc58ZYStvEeYdt
 QV4LVoIN8oVPf/lqPWFRQ0QLv0+6+QK+7jeed76ZwubH+fyRkApaLCrrDr4D1u9RhLMg
 YY9BKItH9CrIt8xwlxzjhZbvxbZzs4TnnAPshL5GdbYqXGNPP9OWqZ8H+8Z3o9cV/4ti
 GpxA==
X-Gm-Message-State: AOAM530dnu7j5/wMkdrilbZJ0xC5r/0BjJjy46EDkzGyS0XzZGxplJQ6
 BK5oDuxoOvqcE65jUC3/5zvLJw==
X-Google-Smtp-Source: ABdhPJxjWSbwvs/HwYIADF7zL+On0S0KbABaVf7YbJpz2OZIcWdXW1O1cPEgZKa9qNsgXC1k5EhX5A==
X-Received: by 2002:a5d:4ccb:: with SMTP id c11mr250573wrt.159.1598639657426; 
 Fri, 28 Aug 2020 11:34:17 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id s20sm356251wmh.21.2020.08.28.11.34.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2020 11:34:16 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 17/45] target/arm: Implement VFP fp16 VSEL
Date: Fri, 28 Aug 2020 19:33:26 +0100
Message-Id: <20200828183354.27913-18-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200828183354.27913-1-peter.maydell@linaro.org>
References: <20200828183354.27913-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Implement the fp16 versions of the VFP VSEL instruction.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/vfp-uncond.decode   |  6 ++++--
 target/arm/translate-vfp.c.inc | 16 ++++++++++++----
 2 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/target/arm/vfp-uncond.decode b/target/arm/vfp-uncond.decode
index b7cd9d11ed5..8ba7b1703e0 100644
--- a/target/arm/vfp-uncond.decode
+++ b/target/arm/vfp-uncond.decode
@@ -44,10 +44,12 @@
 @vfp_dnm_s   ................................ vm=%vm_sp vn=%vn_sp vd=%vd_sp
 @vfp_dnm_d   ................................ vm=%vm_dp vn=%vn_dp vd=%vd_dp
 
+VSEL        1111 1110 0. cc:2 .... .... 1001 .0.0 .... \
+            vm=%vm_sp vn=%vn_sp vd=%vd_sp sz=1
 VSEL        1111 1110 0. cc:2 .... .... 1010 .0.0 .... \
-            vm=%vm_sp vn=%vn_sp vd=%vd_sp dp=0
+            vm=%vm_sp vn=%vn_sp vd=%vd_sp sz=2
 VSEL        1111 1110 0. cc:2 .... .... 1011 .0.0 .... \
-            vm=%vm_dp vn=%vn_dp vd=%vd_dp dp=1
+            vm=%vm_dp vn=%vn_dp vd=%vd_dp sz=3
 
 VMAXNM_hp   1111 1110 1.00 .... .... 1001 .0.0 ....         @vfp_dnm_s
 VMINNM_hp   1111 1110 1.00 .... .... 1001 .1.0 ....         @vfp_dnm_s
diff --git a/target/arm/translate-vfp.c.inc b/target/arm/translate-vfp.c.inc
index 583e7ccdb20..869b67b2b93 100644
--- a/target/arm/translate-vfp.c.inc
+++ b/target/arm/translate-vfp.c.inc
@@ -190,18 +190,22 @@ static bool vfp_access_check(DisasContext *s)
 static bool trans_VSEL(DisasContext *s, arg_VSEL *a)
 {
     uint32_t rd, rn, rm;
-    bool dp = a->dp;
+    int sz = a->sz;
 
     if (!dc_isar_feature(aa32_vsel, s)) {
         return false;
     }
 
-    if (dp && !dc_isar_feature(aa32_fpdp_v2, s)) {
+    if (sz == 3 && !dc_isar_feature(aa32_fpdp_v2, s)) {
+        return false;
+    }
+
+    if (sz == 1 && !dc_isar_feature(aa32_fp16_arith, s)) {
         return false;
     }
 
     /* UNDEF accesses to D16-D31 if they don't exist */
-    if (dp && !dc_isar_feature(aa32_simd_r32, s) &&
+    if (sz == 3 && !dc_isar_feature(aa32_simd_r32, s) &&
         ((a->vm | a->vn | a->vd) & 0x10)) {
         return false;
     }
@@ -214,7 +218,7 @@ static bool trans_VSEL(DisasContext *s, arg_VSEL *a)
         return true;
     }
 
-    if (dp) {
+    if (sz == 3) {
         TCGv_i64 frn, frm, dest;
         TCGv_i64 tmp, zero, zf, nf, vf;
 
@@ -307,6 +311,10 @@ static bool trans_VSEL(DisasContext *s, arg_VSEL *a)
             tcg_temp_free_i32(tmp);
             break;
         }
+        /* For fp16 the top half is always zeroes */
+        if (sz == 1) {
+            tcg_gen_andi_i32(dest, dest, 0xffff);
+        }
         neon_store_reg32(dest, rd);
         tcg_temp_free_i32(frn);
         tcg_temp_free_i32(frm);
-- 
2.20.1


