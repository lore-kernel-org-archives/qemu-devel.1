Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44E93C433E6
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 18:55:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 152D52075B
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 18:55:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fA6sCUiA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 152D52075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58210 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBjX5-0002JW-Sl
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 14:55:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59210)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kBjCs-0002w8-MY
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 14:34:34 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:43866)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kBjCq-000632-3Y
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 14:34:34 -0400
Received: by mail-wr1-x443.google.com with SMTP id k15so38336wrn.10
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 11:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=ddfbpJ21TZ9Q17LNM2UsZZUB857tEs2rgQ+ipEgpwVQ=;
 b=fA6sCUiARSVq3wAaPcMu1SxXXm6Bz5UPqHap7nUVBKo6iCrQq3GzqJGt7oB466ak94
 3GkGpXVnA9LOfL8WKpN0vKPU1aGyX0xlx8mRYnnYsZZFUrJkAPgSS7R9JEgmwa8Loz4+
 UTyVMVCvexuzb4qfGpLFO0fak6v1jDWOe9hIiZqbx3hJHxqfyez/d2wzqTqKHnQHMPTM
 0iNpXV1FNb0ptm+iPuJIW1rWjhdE6gXNSUh+zVKK7RmVy+ufOGipsSbuMg+tSIL4bgLs
 AcjlZ1pfE+vjXQFzv4nc/Q6DzoJhH3MGse4HlQacFOjDf3OBmzorESP3yhYI6svexMUN
 xXVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ddfbpJ21TZ9Q17LNM2UsZZUB857tEs2rgQ+ipEgpwVQ=;
 b=Ea8MuefF6iRS0pIpeXga28TmtKdPtLbiwpSdCIs1bUb3/MAJSv8qGaMYqdzlXY0bjq
 40odB0mVTaeJfbIvDcMvRIeya6VS6Uy+12ix2ZFjYSI6FMXA8556J/2J8GHi0Im8Wgfe
 Zuwu68txCwtu9gcUgxVpaLcsjtwNq+UNuvddq31IVJ+oMHHyUhPaYjoAqj7LEoA9+1Zi
 cO4QO6mxlcK5UHT8Hv8KVinckKdwdO3sR2fgF/OurY0aYEvaZ2VVdbW94viFU0wZqwrs
 zm887TjliRI4eRfIao3FAYFEtUcj1VTh8N2RUiiC2lyejfHw8GF3AltSDSORzI+JUZPf
 8Mzg==
X-Gm-Message-State: AOAM533DzThEaEyI6hUMLrPCuT4uGyyKiFED3ZCnk06pZn+sTukS7SK/
 cNpl0xBBnLYTBPokxxdG9m41yoMkpIXYELb5
X-Google-Smtp-Source: ABdhPJxZ7VBhDGIluF6rdgHPIh7rzoVlpaLtXKsrrf8RafuA175gqWZn0Gzo3yzP+e8bQjNhQnG3UQ==
X-Received: by 2002:a05:6000:1003:: with SMTP id
 a3mr275229wrx.258.1598639670781; 
 Fri, 28 Aug 2020 11:34:30 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id s20sm356251wmh.21.2020.08.28.11.34.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2020 11:34:30 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 28/45] target/arm: Implement fp16 for Neon VMAX, VMIN
Date: Fri, 28 Aug 2020 19:33:37 +0100
Message-Id: <20200828183354.27913-29-peter.maydell@linaro.org>
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

Convert the Neon float-point VMAX and VMIN insns over to using
a gvec helper, and use this to implement the fp16 case.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.h             | 6 ++++++
 target/arm/vec_helper.c         | 6 ++++++
 target/arm/translate-neon.c.inc | 5 ++---
 3 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index b2d24050e27..e252f380a89 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -647,6 +647,12 @@ DEF_HELPER_FLAGS_5(gvec_facge_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(gvec_facgt_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(gvec_facgt_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 
+DEF_HELPER_FLAGS_5(gvec_fmax_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_fmax_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_5(gvec_fmin_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_fmin_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+
 DEF_HELPER_FLAGS_5(gvec_ftsmul_h, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(gvec_ftsmul_s, TCG_CALL_NO_RWG,
diff --git a/target/arm/vec_helper.c b/target/arm/vec_helper.c
index 4ac16ed102c..9d05e1a568b 100644
--- a/target/arm/vec_helper.c
+++ b/target/arm/vec_helper.c
@@ -817,6 +817,12 @@ DO_3OP(gvec_facge_s, float32_acge, float32)
 DO_3OP(gvec_facgt_h, float16_acgt, float16)
 DO_3OP(gvec_facgt_s, float32_acgt, float32)
 
+DO_3OP(gvec_fmax_h, float16_max, float16)
+DO_3OP(gvec_fmax_s, float32_max, float32)
+
+DO_3OP(gvec_fmin_h, float16_min, float16)
+DO_3OP(gvec_fmin_s, float32_min, float32)
+
 #ifdef TARGET_AARCH64
 
 DO_3OP(gvec_recps_h, helper_recpsf_f16, float16)
diff --git a/target/arm/translate-neon.c.inc b/target/arm/translate-neon.c.inc
index 645a099518d..621d6524df1 100644
--- a/target/arm/translate-neon.c.inc
+++ b/target/arm/translate-neon.c.inc
@@ -1117,6 +1117,8 @@ DO_3S_FP_GVEC(VCGE, gen_helper_gvec_fcge_s, gen_helper_gvec_fcge_h)
 DO_3S_FP_GVEC(VCGT, gen_helper_gvec_fcgt_s, gen_helper_gvec_fcgt_h)
 DO_3S_FP_GVEC(VACGE, gen_helper_gvec_facge_s, gen_helper_gvec_facge_h)
 DO_3S_FP_GVEC(VACGT, gen_helper_gvec_facgt_s, gen_helper_gvec_facgt_h)
+DO_3S_FP_GVEC(VMAX, gen_helper_gvec_fmax_s, gen_helper_gvec_fmax_h)
+DO_3S_FP_GVEC(VMIN, gen_helper_gvec_fmin_s, gen_helper_gvec_fmin_h)
 
 /*
  * For all the functions using this macro, size == 1 means fp16,
@@ -1132,9 +1134,6 @@ DO_3S_FP_GVEC(VACGT, gen_helper_gvec_facgt_s, gen_helper_gvec_facgt_h)
         return do_3same_fp(s, a, FUNC, READS_VD);                   \
     }
 
-DO_3S_FP(VMAX, gen_helper_vfp_maxs, false)
-DO_3S_FP(VMIN, gen_helper_vfp_mins, false)
-
 static void gen_VMLA_fp_3s(TCGv_i32 vd, TCGv_i32 vn, TCGv_i32 vm,
                             TCGv_ptr fpstatus)
 {
-- 
2.20.1


