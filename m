Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65C8FC433E7
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 15:38:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2208A20E65
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 15:38:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Sv3ZBdhV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2208A20E65
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49280 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD8Mb-0003wu-7o
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 11:38:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47754)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kD83a-0007rF-0b
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 11:18:46 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b]:35504)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kD83Y-0006Bw-5K
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 11:18:45 -0400
Received: by mail-wm1-x32b.google.com with SMTP id o21so1568615wmc.0
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2020 08:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=LYksQpOrC4uDUd5NAXsivhjz1yQJ3P5MVc1zocuiPzY=;
 b=Sv3ZBdhV7snhiS4X/1NbvHdKleBdTf7pFVtm4TegSeHW9Ht5AgZPCEI5iumBRjO28T
 3SjydRDd/LQKAdE5UtCLmR/EZ8wyKcCdS0m5YQbJ4TQrfdtvxmCqF3jzGPfHCDa51AOa
 /ZvVdghHTh377SiAV6qW3M1E2vpwElEb0YqrnQiIKm4ET2MDL/+5pRCPE3snkRVCkuBn
 JF9bk5SAVxBD1oEthcPZe3cVO/Noi8xuMoDbAWNBwR8PJoO0u9Y/rzdSrKPcCN0ysJ0M
 bN6q4SYzd7JXVfXQG175/GGBoizXs1+7JU5hpo+tQL4agPu8DpdsPZpxN8JRM7z8hPH9
 FXmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=LYksQpOrC4uDUd5NAXsivhjz1yQJ3P5MVc1zocuiPzY=;
 b=gnfWCHUilnlG9u2gqeoiz1xhYk7mc2H1qiGjTw9JmiE2CnxKPR+JYgY61xlWsDE1k9
 gZAYbu5mul95J5qlBIoDNkFqmCNLBlCFwWolJPPaUIGj4EIBlCAzN7rVI4A9kPgE80a6
 4Injk/n4cvjxA5gLm5wrsE89lY63g+hwxbd1fZfFEOsBy/7me2uovAht7Lxr47/S1lFe
 N01SZC6YgeYxsUsQcEfhabFZAELDySrKR3HBqArsBG+zYKi15vfmbmD65J3O73CbiCFy
 i0fFQR9+2yrly5YBp0X60Hp5IzeNaYjnW418CCTAFXWeHQxllcZD0yXKwN6YVUcmDIh7
 5qjw==
X-Gm-Message-State: AOAM5305ZBD3bfCO+Lh8Q89pgS/6UQD+97Pm/El+lG4zpPWneVr3nftL
 Jmf2Hns83M9UZ9mD8O0YJ/fvDMBF4MtmM4t5
X-Google-Smtp-Source: ABdhPJzi6Y5TbsqwZOAmNr+bVpuCuJhl+Xi9n9f4ndoSpdqMzMxEgzMJsD0XjXw1Wa9mAvlVlDfgjw==
X-Received: by 2002:a7b:c056:: with SMTP id u22mr2300067wmc.188.1598973522280; 
 Tue, 01 Sep 2020 08:18:42 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id z9sm2242317wma.4.2020.09.01.08.18.41
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2020 08:18:41 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 12/47] target/arm: Implement VFP fp16 VCVT between float and
 integer
Date: Tue,  1 Sep 2020 16:17:48 +0100
Message-Id: <20200901151823.29785-13-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200901151823.29785-1-peter.maydell@linaro.org>
References: <20200901151823.29785-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Implement the fp16 versions of the VFP VCVT instruction forms which
convert between floating point and integer.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200828183354.27913-13-peter.maydell@linaro.org
---
 target/arm/vfp.decode          |  4 +++
 target/arm/translate-vfp.c.inc | 65 ++++++++++++++++++++++++++++++++++
 2 files changed, 69 insertions(+)

diff --git a/target/arm/vfp.decode b/target/arm/vfp.decode
index 37f96e2d261..642ec039e3c 100644
--- a/target/arm/vfp.decode
+++ b/target/arm/vfp.decode
@@ -210,6 +210,8 @@ VCVT_sp      ---- 1110 1.11 0111 .... 1010 11.0 ....        @vfp_dm_ds
 VCVT_dp      ---- 1110 1.11 0111 .... 1011 11.0 ....        @vfp_dm_sd
 
 # VCVT from integer to floating point: Vm always single; Vd depends on size
+VCVT_int_hp  ---- 1110 1.11 1000 .... 1001 s:1 1.0 .... \
+             vd=%vd_sp vm=%vm_sp
 VCVT_int_sp  ---- 1110 1.11 1000 .... 1010 s:1 1.0 .... \
              vd=%vd_sp vm=%vm_sp
 VCVT_int_dp  ---- 1110 1.11 1000 .... 1011 s:1 1.0 .... \
@@ -229,6 +231,8 @@ VCVT_fix_dp  ---- 1110 1.11 1.1. .... 1011 .1.0 .... \
              vd=%vd_dp imm=%vm_sp opc=%vcvt_fix_op
 
 # VCVT float to integer (VCVT and VCVTR): Vd always single; Vd depends on size
+VCVT_hp_int  ---- 1110 1.11 110 s:1 .... 1001 rz:1 1.0 .... \
+             vd=%vd_sp vm=%vm_sp
 VCVT_sp_int  ---- 1110 1.11 110 s:1 .... 1010 rz:1 1.0 .... \
              vd=%vd_sp vm=%vm_sp
 VCVT_dp_int  ---- 1110 1.11 110 s:1 .... 1011 rz:1 1.0 .... \
diff --git a/target/arm/translate-vfp.c.inc b/target/arm/translate-vfp.c.inc
index 59ef4d4fbc3..0140822d183 100644
--- a/target/arm/translate-vfp.c.inc
+++ b/target/arm/translate-vfp.c.inc
@@ -2845,6 +2845,35 @@ static bool trans_VCVT_dp(DisasContext *s, arg_VCVT_dp *a)
     return true;
 }
 
+static bool trans_VCVT_int_hp(DisasContext *s, arg_VCVT_int_sp *a)
+{
+    TCGv_i32 vm;
+    TCGv_ptr fpst;
+
+    if (!dc_isar_feature(aa32_fp16_arith, s)) {
+        return false;
+    }
+
+    if (!vfp_access_check(s)) {
+        return true;
+    }
+
+    vm = tcg_temp_new_i32();
+    neon_load_reg32(vm, a->vm);
+    fpst = fpstatus_ptr(FPST_FPCR_F16);
+    if (a->s) {
+        /* i32 -> f16 */
+        gen_helper_vfp_sitoh(vm, vm, fpst);
+    } else {
+        /* u32 -> f16 */
+        gen_helper_vfp_uitoh(vm, vm, fpst);
+    }
+    neon_store_reg32(vm, a->vd);
+    tcg_temp_free_i32(vm);
+    tcg_temp_free_ptr(fpst);
+    return true;
+}
+
 static bool trans_VCVT_int_sp(DisasContext *s, arg_VCVT_int_sp *a)
 {
     TCGv_i32 vm;
@@ -3067,6 +3096,42 @@ static bool trans_VCVT_fix_dp(DisasContext *s, arg_VCVT_fix_dp *a)
     return true;
 }
 
+static bool trans_VCVT_hp_int(DisasContext *s, arg_VCVT_sp_int *a)
+{
+    TCGv_i32 vm;
+    TCGv_ptr fpst;
+
+    if (!dc_isar_feature(aa32_fp16_arith, s)) {
+        return false;
+    }
+
+    if (!vfp_access_check(s)) {
+        return true;
+    }
+
+    fpst = fpstatus_ptr(FPST_FPCR_F16);
+    vm = tcg_temp_new_i32();
+    neon_load_reg32(vm, a->vm);
+
+    if (a->s) {
+        if (a->rz) {
+            gen_helper_vfp_tosizh(vm, vm, fpst);
+        } else {
+            gen_helper_vfp_tosih(vm, vm, fpst);
+        }
+    } else {
+        if (a->rz) {
+            gen_helper_vfp_touizh(vm, vm, fpst);
+        } else {
+            gen_helper_vfp_touih(vm, vm, fpst);
+        }
+    }
+    neon_store_reg32(vm, a->vd);
+    tcg_temp_free_i32(vm);
+    tcg_temp_free_ptr(fpst);
+    return true;
+}
+
 static bool trans_VCVT_sp_int(DisasContext *s, arg_VCVT_sp_int *a)
 {
     TCGv_i32 vm;
-- 
2.20.1


