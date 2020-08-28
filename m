Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81363C433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 18:39:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3ACC12065F
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 18:39:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="asKZH8a2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3ACC12065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49220 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBjHH-000163-C3
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 14:39:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58738)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kBjCe-0002KH-I1
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 14:34:20 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:40387)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kBjCW-0005xH-CX
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 14:34:20 -0400
Received: by mail-wr1-x441.google.com with SMTP id b18so50180wrs.7
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 11:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=+jA5lQWk27z4fN9b66lo0L+e7azK7DThocQahuWYwHI=;
 b=asKZH8a2xkEPAOtK//+nFwbK8CLHytrF/xkl5ldFXEYzBxGP+JF2GIc1aJzt5mQrYG
 z2WYghV04vewxJFg1JIhjnGgCLkuCUOBtdXA+GiBW7Q+86GVb2b3cqjGG2eALUZWAwi6
 KZl7rmZNCnYdv7rug6UDgDBXSHXWE0hXvfHBg0v6lH+gqEbzzLJePHXkI9Qwe1/qXoOT
 +FLJYQNY5Gx/wEguhTeLM4f+pP2jFdkKQjkWzcGR+xR/v3TwmiRk+vpcuj1GJ6sLKd1c
 IYeBycZSQsinun2/5h3E6BS19RQUVvmgRR7EyDJiusZ2wHOWzLTeFSjsScfYTo2Dj8Es
 5vMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=+jA5lQWk27z4fN9b66lo0L+e7azK7DThocQahuWYwHI=;
 b=BkO9k4BsSGHdFmXq5QLlPwpUXdCTRa9pHGwepYB6R++UIDI/2HGBkESEjY1Plsc5FT
 IyUuNo+82h6oSaygRF75f0ucn2M6RssbSvrz+jxn4bzLWL7iwe3stXr8HgSiPE2lidP4
 fnI8yZF4SdYESsoXKRAUXL2xP+cF7EHl3dy8dr4oFl5WbQE478Ymej1KhFRrV6OLl8lq
 5u49dp6tBrYv6B/zyBLwzoEMpM8jdfy68oOqmGMIYVeRrZ9CCX5Mfjt0jIO0+xOLfeAM
 /gtp1/JzgVqvZX6q3eGkWpcq0LwER4/gWXv/B4dWJX+U4lVPOl0Tw2ODZC83lEttVc+G
 Iheg==
X-Gm-Message-State: AOAM533JoObVktK2ioEAJ/6UOSY+uCBoyuMYLp9yHpxu8FErb+KiBysR
 OVr3MtZ7rWLupiqeGRPdY92XsQ==
X-Google-Smtp-Source: ABdhPJwGr/5z0JVasQnq8L5lp3l0uUP4k36Jkf74Z+g+phtlrNCN7Waw8MF7rIVh7dILPcunP75b2A==
X-Received: by 2002:adf:f7c3:: with SMTP id a3mr281191wrq.162.1598639650004;
 Fri, 28 Aug 2020 11:34:10 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id s20sm356251wmh.21.2020.08.28.11.34.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2020 11:34:09 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 11/45] target/arm: Implement VFP fp16 VLDR and VSTR
Date: Fri, 28 Aug 2020 19:33:20 +0100
Message-Id: <20200828183354.27913-12-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200828183354.27913-1-peter.maydell@linaro.org>
References: <20200828183354.27913-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x441.google.com
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

Implement the fp16 versions of the VFP VLDR/VSTR (immediate).

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/vfp.decode          |  3 +--
 target/arm/translate-vfp.c.inc | 35 ++++++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/target/arm/vfp.decode b/target/arm/vfp.decode
index b213da4b55d..37f96e2d261 100644
--- a/target/arm/vfp.decode
+++ b/target/arm/vfp.decode
@@ -79,8 +79,7 @@ VMOV_single  ---- 1110 000 l:1 .... rt:4 1010 . 001 0000    vn=%vn_sp
 VMOV_64_sp   ---- 1100 010 op:1 rt2:4 rt:4 1010 00.1 ....   vm=%vm_sp
 VMOV_64_dp   ---- 1100 010 op:1 rt2:4 rt:4 1011 00.1 ....   vm=%vm_dp
 
-# Note that the half-precision variants of VLDR and VSTR are
-# not part of this decodetree at all because they have bits [9:8] == 0b01
+VLDR_VSTR_hp ---- 1101 u:1 .0 l:1 rn:4 .... 1001 imm:8      vd=%vd_sp
 VLDR_VSTR_sp ---- 1101 u:1 .0 l:1 rn:4 .... 1010 imm:8      vd=%vd_sp
 VLDR_VSTR_dp ---- 1101 u:1 .0 l:1 rn:4 .... 1011 imm:8      vd=%vd_dp
 
diff --git a/target/arm/translate-vfp.c.inc b/target/arm/translate-vfp.c.inc
index 00a6363e1e1..59ef4d4fbc3 100644
--- a/target/arm/translate-vfp.c.inc
+++ b/target/arm/translate-vfp.c.inc
@@ -886,6 +886,41 @@ static bool trans_VMOV_64_dp(DisasContext *s, arg_VMOV_64_dp *a)
     return true;
 }
 
+static bool trans_VLDR_VSTR_hp(DisasContext *s, arg_VLDR_VSTR_sp *a)
+{
+    uint32_t offset;
+    TCGv_i32 addr, tmp;
+
+    if (!dc_isar_feature(aa32_fp16_arith, s)) {
+        return false;
+    }
+
+    if (!vfp_access_check(s)) {
+        return true;
+    }
+
+    /* imm8 field is offset/2 for fp16, unlike fp32 and fp64 */
+    offset = a->imm << 1;
+    if (!a->u) {
+        offset = -offset;
+    }
+
+    /* For thumb, use of PC is UNPREDICTABLE.  */
+    addr = add_reg_for_lit(s, a->rn, offset);
+    tmp = tcg_temp_new_i32();
+    if (a->l) {
+        gen_aa32_ld16u(s, tmp, addr, get_mem_index(s));
+        neon_store_reg32(tmp, a->vd);
+    } else {
+        neon_load_reg32(tmp, a->vd);
+        gen_aa32_st16(s, tmp, addr, get_mem_index(s));
+    }
+    tcg_temp_free_i32(tmp);
+    tcg_temp_free_i32(addr);
+
+    return true;
+}
+
 static bool trans_VLDR_VSTR_sp(DisasContext *s, arg_VLDR_VSTR_sp *a)
 {
     uint32_t offset;
-- 
2.20.1


