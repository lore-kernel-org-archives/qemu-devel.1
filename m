Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E521EC28E83
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 15:34:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABA2A20E65
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 15:34:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UDyDMhXq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABA2A20E65
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34662 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD8JA-00066m-QB
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 11:34:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48052)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kD83s-0000Cs-10
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 11:19:04 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:44605)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kD83q-0006G0-6P
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 11:19:03 -0400
Received: by mail-wr1-x442.google.com with SMTP id c15so1964013wrs.11
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2020 08:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=VDUiBBiK6Vni6aZV1BmJNFhEVyBbPkFOpse05USNH1c=;
 b=UDyDMhXq/sdtynzbJ+mJpwueU0QUy0PUMUjn1VpfzaspeRv05TX49KqxA2VB2xtKKD
 YOWLl0A90JTAuioA86Ix0p2c/iX3gSnvEnzT5uB1bx8EnlEsWQPPs2nOJKLR4nhbhv8s
 +d/CZGSTa+8cS3vx7XHo7g1f7lFCS3+yEHBakvXBXSfnHTjolVjELlF3GH0D87b0Nurg
 qK3XGIfChovso5i13Zg+W/S6vM5OakjvydlZBX9g06lqtj2kzzW9l9ZGxEi8DrMfWEAE
 FXes6TYRphHfirCPtGl1CPnVSW7FraOoR++XnvuZmIKxOYdAqKBNoHZDeIorTF681J6+
 CmJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=VDUiBBiK6Vni6aZV1BmJNFhEVyBbPkFOpse05USNH1c=;
 b=V7MkWzjiez5ZTtEtPgc7Xi4VcwxNAGLZrV+0J1ATSeXtDRdi4ncW7lj0FA415mek8P
 iM6lxVZBOJAv4jLMWTJ1+ZVqS9ujRyR23eqZogrn2z5/7DEMKFqBSvKSjJbt57TP9EkB
 TUoFwMcYU9FlzfVJc/XkllvIyczXddqQdWXpz0G/ph2Fg/KZFliIe9JaUPjblClVIYwY
 AaUhHCyrZx3FPH2cyWA24stTW/lfzp3KPPhMLhc89tRsRyC4lbvSFCh9aqYzw4c1V8vW
 TUY7OaanfiTMLvm+u454NuDWTW1jbE4SzE1+lgsEf4lr9cKBPd4r23e6xMLqGYa44pjw
 JnBg==
X-Gm-Message-State: AOAM532LzEwu8v2ObUdrTHVAncH/rm85kD3Q0cIo6Ym05+ieTuw824H2
 ATdjJ/ivaQYUTon6dyzticpDYrv2N56N9AAJ
X-Google-Smtp-Source: ABdhPJxmNc/zBSTEGvzsOfZwteznsILcA76DbLgNjncSlOeIEaW67PI3sqSm5xR6D+2jGzd6/39How==
X-Received: by 2002:a5d:4710:: with SMTP id y16mr2497206wrq.203.1598973540490; 
 Tue, 01 Sep 2020 08:19:00 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id z9sm2242317wma.4.2020.09.01.08.18.59
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2020 08:18:59 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 27/47] target/arm: Implement fp16 for Neon VMAX, VMIN
Date: Tue,  1 Sep 2020 16:18:03 +0100
Message-Id: <20200901151823.29785-28-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200901151823.29785-1-peter.maydell@linaro.org>
References: <20200901151823.29785-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x442.google.com
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

Convert the Neon float-point VMAX and VMIN insns over to using
a gvec helper, and use this to implement the fp16 case.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200828183354.27913-29-peter.maydell@linaro.org
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
index f21b944e0d3..018bfde1098 100644
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


