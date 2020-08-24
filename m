Return-Path: <SRS0=JPH5=CC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A20FEC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 14:43:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6573320738
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 14:43:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pGp7iNYF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6573320738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42406 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kADgw-0007ua-LU
	for qemu-devel@archiver.kernel.org; Mon, 24 Aug 2020 10:43:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43568)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kADUC-0000RC-65
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 10:30:12 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:32775)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kADU8-0002kA-JW
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 10:30:11 -0400
Received: by mail-wr1-x444.google.com with SMTP id o4so4874233wrn.0
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2020 07:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=inJTXdydeioKk9+qU5p3iyt7UI/PdU5N/egNEICi6fM=;
 b=pGp7iNYF1mRXTiqxqfsmN2k7s9nzoT8n5AkG0/a4wYU3s5jVO99Vd/6dwvRXC0QCun
 ZClVhuFUlibjzlBOEHQxdsV6p8fGoAo5B3JvQFuemzuaV8xdFdNDXNoOd/+Xp1Z8++T5
 gpH35w43ror9qJBDbaHUJQ8a6MqKOvWpxlAKFJrioZHS0d+5ZNM/EmYhEU/Nz8lldAoi
 UEAtQrDbWUgbZzhlkg6fAwshdtdfw2esZPtSmhLlyWM2AqMMOEYdufBMJNZCFMbUPeOc
 3TfVkY8aFBr0rUL3gZMU24Eytq2wtKz+1iv6d/h9maVuxMyn9JB6xST91yMIJX37BrzG
 0vNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=inJTXdydeioKk9+qU5p3iyt7UI/PdU5N/egNEICi6fM=;
 b=RDrLV6K2z9yx2HD2vJYXNwk5Cp211AfXXjF5oKH72JZqIH0LEyVZv0DwCTxVAM838v
 ynMwpENqavgxl0P5Y4GNl5X0kl111Dx84fE4vBZs8l+lM7NB4bbQp7MTKI+cHNTTuZcq
 a1mQF+/QNnl05We0ykiUXiJBxOn4ymkj0NyJCFJx3oJ7jx6jzOdc6qNp5aUknRFpXpYa
 tCamFTa3kKE/HhOm7EFP4GO9x+V5CgN9RhgPpiuDtOs2MfnFQJVjMSybXMtBsKlesuIz
 tiRzAZ64iYVPL1wyeyMDnWIUwuo8eoWM0mkt3xG0Ajwa8FSt1gyW0EjXR2C8631EzU1G
 3lsA==
X-Gm-Message-State: AOAM532J9hYyzZvoKlAwHhG1FEWC3W4aUkhc9zolNV6HTjV+WD/EDgH1
 TarLkSIE9dgD3RlBUIPL7c7CcGLvDQgLfVLb
X-Google-Smtp-Source: ABdhPJzND5zJt4903rGotObbZ1wyShHXxexSP9fd+X/c7yd4lxF4L0BZBqHTCiOKKg9tdEwxVlGCXA==
X-Received: by 2002:adf:9e90:: with SMTP id a16mr6569855wrf.40.1598279394722; 
 Mon, 24 Aug 2020 07:29:54 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id b14sm24499091wrj.93.2020.08.24.07.29.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2020 07:29:54 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 17/22] target/arm: Implement VFP fp16 VSEL
Date: Mon, 24 Aug 2020 15:29:29 +0100
Message-Id: <20200824142934.20850-18-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200824142934.20850-1-peter.maydell@linaro.org>
References: <20200824142934.20850-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x444.google.com
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


