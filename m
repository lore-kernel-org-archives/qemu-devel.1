Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EC4BC433E2
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 13:34:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06B9B2072A
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 13:34:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d5CTtmeB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06B9B2072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46404 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDpO2-0003UR-1G
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 09:34:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44090)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kDpLe-0007Ic-3Q
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 09:32:18 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:55745)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kDpLb-0007v8-JP
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 09:32:17 -0400
Received: by mail-wm1-x344.google.com with SMTP id a65so2892368wme.5
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2020 06:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=4YiQdBJ1hxjT11XkjIFT4NIt+VV3HO6udxhsJSHRVWc=;
 b=d5CTtmeBhsM8Eb973i6HmTNgAWS6GnlU5KMxXj5CURQoQExfQ46o7C+fGa4Bue8OQI
 Y10y3Dl9fNJyIcouNOFVNBhc4l8+esPAPanQnhREHPtgO+exuvNyIhBkujZtpHRV3/jq
 7kMr6Wf2kBlQL5kL+HtbXhS3MkdAKDTUDvu9uzRxwr85x42kP7pTbjD/JwiwVXjQ8q9B
 IhNw4sTZ6RfFZgp3gciwpnCgNuhTaRThOl1FkTPjSI0tA7OCuCRdfUr4oewmgaKz+o1U
 dF4a5XZENpoG2yFowUUKaR1/bRC4gfQZFjCGTmeNc2zM92/xCQfJ4ESXlEMbZX9DBQ2V
 9kww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=4YiQdBJ1hxjT11XkjIFT4NIt+VV3HO6udxhsJSHRVWc=;
 b=G/wYS/Do3ZQMcxlHUTvx9NZbMRzzgX8TtqnyGoLGIwoI2P1/faX1/MuRA4ErWZuOMC
 pYS3wXWzeVsdTpbEgc164oNcxmtL+g52Je+60tS+9NfzY42bfFifg8v2J4Go0i9A9osC
 XtJKcHNKaUeaIB6eqiwVuW19Tuo9P5haGGCdcTz/ZZKu1BdRbY27G9uke6DX+X57lR3j
 MH41ZbhEr3gfL5MTfH3mVGcVyEir8Yw8mvY2nHU7xgh5JlGKEzWD5j/7cdevP9rz+InU
 62Z4weitovvh2V2QtK1iYqLu7tRTyHg/1KgsxI5HtI1R0BtT5eSY6X9emJMv6xD7IEPh
 D0cQ==
X-Gm-Message-State: AOAM5312MRIlO7jvnjfhmGJon9zuLPimUags0CnqPYNHWlpUwQGi9HXR
 NUAyYVieNYgwPdj1JhSEZe8rlA==
X-Google-Smtp-Source: ABdhPJxi6ETqkvY/8PcZ5+/345ZzzKFKxkznORzuyEX88savOoeSRnsvh9Co+4rxvoCzIlO295ucKw==
X-Received: by 2002:a7b:c401:: with SMTP id k1mr2517484wmi.18.1599139934297;
 Thu, 03 Sep 2020 06:32:14 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id k24sm4301988wmj.19.2020.09.03.06.32.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2020 06:32:13 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 2/3] target/arm: Convert Neon VCVT fp size field to MO_* in
 decode
Date: Thu,  3 Sep 2020 14:32:08 +0100
Message-Id: <20200903133209.5141-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200903133209.5141-1-peter.maydell@linaro.org>
References: <20200903133209.5141-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x344.google.com
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
Cc: Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Convert the insns using the 2reg_vcvt and 2reg_vcvt_f16 formats
to pass the size through to the trans function as a MO_* value
rather than the '0==f32, 1==f16' used in the fp 3-same encodings.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/neon-dp.decode       | 3 +--
 target/arm/translate-neon.c.inc | 4 ++--
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/target/arm/neon-dp.decode b/target/arm/neon-dp.decode
index f453833396f..d7da2e7db3c 100644
--- a/target/arm/neon-dp.decode
+++ b/target/arm/neon-dp.decode
@@ -256,9 +256,8 @@ VMINNM_fp_3s     1111 001 1 0 . 1 . .... .... 1111 ... 1 .... @3same_fp
 @2reg_shll_b     .... ... . . . 001 shift:3  .... .... 0 . . . .... \
                  &2reg_shift vm=%vm_dp vd=%vd_dp size=0 q=0
 
-# We use size=0 for fp32 and size=1 for fp16 to match the 3-same encodings.
 @2reg_vcvt       .... ... . . . 1 ..... .... .... . q:1 . . .... \
-                 &2reg_shift vm=%vm_dp vd=%vd_dp size=0 shift=%neon_rshift_i5
+                 &2reg_shift vm=%vm_dp vd=%vd_dp size=2 shift=%neon_rshift_i5
 @2reg_vcvt_f16   .... ... . . . 11 .... .... .... . q:1 . . .... \
                  &2reg_shift vm=%vm_dp vd=%vd_dp size=1 shift=%neon_rshift_i4
 
diff --git a/target/arm/translate-neon.c.inc b/target/arm/translate-neon.c.inc
index 255c1cf8a2a..213c1c2174a 100644
--- a/target/arm/translate-neon.c.inc
+++ b/target/arm/translate-neon.c.inc
@@ -1626,7 +1626,7 @@ static bool do_fp_2sh(DisasContext *s, arg_2reg_shift *a,
         return false;
     }
 
-    if (a->size != 0) {
+    if (a->size == MO_16) {
         if (!dc_isar_feature(aa32_fp16_arith, s)) {
             return false;
         }
@@ -1646,7 +1646,7 @@ static bool do_fp_2sh(DisasContext *s, arg_2reg_shift *a,
         return true;
     }
 
-    fpst = fpstatus_ptr(a->size ? FPST_STD_F16 : FPST_STD);
+    fpst = fpstatus_ptr(a->size == MO_16 ? FPST_STD_F16 : FPST_STD);
     tcg_gen_gvec_2_ptr(rd_ofs, rm_ofs, fpst, vec_size, vec_size, a->shift, fn);
     tcg_temp_free_ptr(fpst);
     return true;
-- 
2.20.1


