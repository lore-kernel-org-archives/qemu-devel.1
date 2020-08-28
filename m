Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39E85C433E6
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 18:41:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0568720737
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 18:41:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q20YB91o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0568720737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57730 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBjJT-0004ew-6E
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 14:41:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58744)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kBjCe-0002Ky-Ty
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 14:34:20 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a]:45213)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kBjCX-0005xQ-Fq
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 14:34:20 -0400
Received: by mail-wr1-x42a.google.com with SMTP id h15so27266wrt.12
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 11:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=Hwpf+qxDq5BB579qMqkOfGdKfdGk8X1OZAvqrTZqjos=;
 b=Q20YB91oovxxIMG454oycLTw3vdcEFRWdXk+lOCGc0CBYwrcHc25MRe7AIt3Si1BmS
 los3yOIZ+fqkXGgQDMDdkQ6dBRAlwnJ1FqtUhd4hO3hKvvYO3L+ZFri/p/IXUR4ytCpb
 JF1JEIZ4IbMlO5/Zn0KJDWI+9WsLnnMtsesSbeoX+w45YeAwkd7siTG6im4VpgmwL0tP
 FZ0CMM+3znK6h/JKHDQeyVcdpTzLI+SH56fmlOIAVo4ENJUcuK7kjkp33jl/sW0jvZ1y
 Xori5WzWwgJBEs975BUMVNo2lEZ3Bq7OuH81+Y7YXVj/E4CfDgP5g0Vm+CfQm/1zFngw
 ws1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Hwpf+qxDq5BB579qMqkOfGdKfdGk8X1OZAvqrTZqjos=;
 b=q0u2vyy3MYE+yiVKz5+y65/r3lar/PJbYdL58iLJA1IYMtvyfZ9VSNqKR/bV6S83D1
 XYP71hWgUBolCO8Ux13ZSS7gn6d9ya9YKpx7XwKsOfZ9LFkPzD/LDzJVjefHJjWofvW7
 Le7ASdtjgQ59bHLoI2tfuw3HHb/3qaLlzTw95R+MUTdG10KZeIltFV1bOMONHeFhbbU3
 1AVb73aXfpiKoIq6RT7afdrHx7mGjWCWN5368Xjl7yNb0e8uWKpmkOlmyivvCoCy6PZA
 QgaWde/A+nTWH1yl3rALtqRcnBmn6PVY01DD2zN8O4xLg0kuK5GFy7Ok8U+Qvga/5xWL
 lQQg==
X-Gm-Message-State: AOAM530ZTJcmgWv04Qy/Y6DqxtF4rfNIgu9OSNy0wibem4UGJ+wJwz4W
 UYgCxAm3kkJehKNtFpWSnIENso+W6APl5yOi
X-Google-Smtp-Source: ABdhPJwR12uddhL50CGKck+Bf+07GHSrZc9xoJIx8OGOnDzBjboXmJmifk5A06B3l1lGRxiM8HRCDA==
X-Received: by 2002:adf:f106:: with SMTP id r6mr294739wro.106.1598639651110;
 Fri, 28 Aug 2020 11:34:11 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id s20sm356251wmh.21.2020.08.28.11.34.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2020 11:34:10 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 12/45] target/arm: Implement VFP fp16 VCVT between float
 and integer
Date: Fri, 28 Aug 2020 19:33:21 +0100
Message-Id: <20200828183354.27913-13-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200828183354.27913-1-peter.maydell@linaro.org>
References: <20200828183354.27913-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42a.google.com
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


