Return-Path: <SRS0=2Sdx=UN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89D50C31E44
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 10:54:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55F6B2082C
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 10:54:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YwuECIDa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55F6B2082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50120 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbjqW-00029X-FU
	for qemu-devel@archiver.kernel.org; Fri, 14 Jun 2019 06:54:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57637)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hbjhe-0007wZ-V5
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 06:45:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hbjhd-00075v-Jv
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 06:45:02 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:40039)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hbjhd-000751-Dv
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 06:45:01 -0400
Received: by mail-wr1-x444.google.com with SMTP id p11so2005991wre.7
 for <qemu-devel@nongnu.org>; Fri, 14 Jun 2019 03:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=LB0bsaVvZA3zcHPIjDXxrbeOwWsnpZuqgC546jWarVg=;
 b=YwuECIDa7tIxSn4IleGBjVqDNCpwhKkSmQfRQZe3z6Ena/KgZTI/E00OBVPv5v9M+Z
 +LCwlQqGngExMbgO0YHSeyDtjaR0slsoJ7f0KNru9pnwvcQ58Md/xuYRgUy5WU2gCo8k
 /Tz+/hTzZzbrViPOD2QYaYmtOSdvqyfQIJRNDazSJffSlh76/SAsi5yJbYJseXL9zJtQ
 2fSAhZtso90rqbyCIgTqXe8vsqxOHkZtAiwpLjbWKGTJPk5vuM7EhtYQL7qTYe6f6q0y
 jtZ4V8ddOz1w1c7inxYfevB8CyXjoUt9FzDDeJmVKDrPD+Syh0pZIfpDh6xS7YFQdlgX
 VzkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=LB0bsaVvZA3zcHPIjDXxrbeOwWsnpZuqgC546jWarVg=;
 b=TrHMyY/r6TZQZmisqXNrAJ2C3huqiR00VAGo0xbopSCT7PPcvFsxD+y7qcJSZ481hY
 BMXSNweAsu93RqyoQ/u6gyQtAzZwha1PR1XENz978iGZskHstXIDokvjE4nFXBPFJACP
 OsgGSsrNtk6TQqXQp9ql9g7Yj9vFHq2zqklTV4VzDGTeqbH2ciBG0hpmfo7akAzDk3AQ
 KsB0jICLnYyymzgzd2zLFc4H6nMOEGYqaL3GITooHYNurymK5c9xZLTXCR7Dh6U76z28
 4p0/SvvqJsEoQ53FSjmUvD74/gZ2kzM/BvUFV06+N8K08z8zNSuQKqcsXwAdXEh0/wqo
 d9OQ==
X-Gm-Message-State: APjAAAVhwBUelIrMRipMNk5TgHy01kGeWnnbrqznY0Bhfe1VXB+FdjV5
 woOcNozGJ6W0vxGrNcc7/2G6pQ==
X-Google-Smtp-Source: APXvYqx8yaSVqYwIlqkNizA4J4VeZytxug/5G6UgO/0jB/Ik3hTGod16Pd+ZhM/7vCHJSI4HQdbi6w==
X-Received: by 2002:adf:e6c6:: with SMTP id y6mr1388772wrm.191.1560509100350; 
 Fri, 14 Jun 2019 03:45:00 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id y24sm2091238wmi.10.2019.06.14.03.44.59
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 14 Jun 2019 03:44:59 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Date: Fri, 14 Jun 2019 11:44:56 +0100
Message-Id: <20190614104457.24703-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190614104457.24703-1-peter.maydell@linaro.org>
References: <20190614104457.24703-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: [Qemu-devel] [PATCH 1/2] target/arm: Fix typos in trans function
 prototypes
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

In several places cut and paste errors meant we were using the wrong
type for the 'arg' struct in trans_ functions called by the
decodetree decoder, because we were using the _sp version of the
struct in the _dp function.  These were harmless, because the two
structs were identical and so decodetree made them typedefs of the
same underlying structure (and we'd have had a compile error if they
were not harmless), but we should clean them up anyway.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate-vfp.inc.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/target/arm/translate-vfp.inc.c b/target/arm/translate-vfp.inc.c
index 709fc65374d..85187bcc9dc 100644
--- a/target/arm/translate-vfp.inc.c
+++ b/target/arm/translate-vfp.inc.c
@@ -835,7 +835,7 @@ static bool trans_VMOV_64_sp(DisasContext *s, arg_VMOV_64_sp *a)
     return true;
 }
 
-static bool trans_VMOV_64_dp(DisasContext *s, arg_VMOV_64_sp *a)
+static bool trans_VMOV_64_dp(DisasContext *s, arg_VMOV_64_dp *a)
 {
     TCGv_i32 tmp;
 
@@ -910,7 +910,7 @@ static bool trans_VLDR_VSTR_sp(DisasContext *s, arg_VLDR_VSTR_sp *a)
     return true;
 }
 
-static bool trans_VLDR_VSTR_dp(DisasContext *s, arg_VLDR_VSTR_sp *a)
+static bool trans_VLDR_VSTR_dp(DisasContext *s, arg_VLDR_VSTR_dp *a)
 {
     uint32_t offset;
     TCGv_i32 addr;
@@ -1500,7 +1500,7 @@ static void gen_VMLA_dp(TCGv_i64 vd, TCGv_i64 vn, TCGv_i64 vm, TCGv_ptr fpst)
     tcg_temp_free_i64(tmp);
 }
 
-static bool trans_VMLA_dp(DisasContext *s, arg_VMLA_sp *a)
+static bool trans_VMLA_dp(DisasContext *s, arg_VMLA_dp *a)
 {
     return do_vfp_3op_dp(s, gen_VMLA_dp, a->vd, a->vn, a->vm, true);
 }
@@ -1538,7 +1538,7 @@ static void gen_VMLS_dp(TCGv_i64 vd, TCGv_i64 vn, TCGv_i64 vm, TCGv_ptr fpst)
     tcg_temp_free_i64(tmp);
 }
 
-static bool trans_VMLS_dp(DisasContext *s, arg_VMLS_sp *a)
+static bool trans_VMLS_dp(DisasContext *s, arg_VMLS_dp *a)
 {
     return do_vfp_3op_dp(s, gen_VMLS_dp, a->vd, a->vn, a->vm, true);
 }
@@ -1580,7 +1580,7 @@ static void gen_VNMLS_dp(TCGv_i64 vd, TCGv_i64 vn, TCGv_i64 vm, TCGv_ptr fpst)
     tcg_temp_free_i64(tmp);
 }
 
-static bool trans_VNMLS_dp(DisasContext *s, arg_VNMLS_sp *a)
+static bool trans_VNMLS_dp(DisasContext *s, arg_VNMLS_dp *a)
 {
     return do_vfp_3op_dp(s, gen_VNMLS_dp, a->vd, a->vn, a->vm, true);
 }
@@ -1614,7 +1614,7 @@ static void gen_VNMLA_dp(TCGv_i64 vd, TCGv_i64 vn, TCGv_i64 vm, TCGv_ptr fpst)
     tcg_temp_free_i64(tmp);
 }
 
-static bool trans_VNMLA_dp(DisasContext *s, arg_VNMLA_sp *a)
+static bool trans_VNMLA_dp(DisasContext *s, arg_VNMLA_dp *a)
 {
     return do_vfp_3op_dp(s, gen_VNMLA_dp, a->vd, a->vn, a->vm, true);
 }
@@ -1624,7 +1624,7 @@ static bool trans_VMUL_sp(DisasContext *s, arg_VMUL_sp *a)
     return do_vfp_3op_sp(s, gen_helper_vfp_muls, a->vd, a->vn, a->vm, false);
 }
 
-static bool trans_VMUL_dp(DisasContext *s, arg_VMUL_sp *a)
+static bool trans_VMUL_dp(DisasContext *s, arg_VMUL_dp *a)
 {
     return do_vfp_3op_dp(s, gen_helper_vfp_muld, a->vd, a->vn, a->vm, false);
 }
@@ -1648,7 +1648,7 @@ static void gen_VNMUL_dp(TCGv_i64 vd, TCGv_i64 vn, TCGv_i64 vm, TCGv_ptr fpst)
     gen_helper_vfp_negd(vd, vd);
 }
 
-static bool trans_VNMUL_dp(DisasContext *s, arg_VNMUL_sp *a)
+static bool trans_VNMUL_dp(DisasContext *s, arg_VNMUL_dp *a)
 {
     return do_vfp_3op_dp(s, gen_VNMUL_dp, a->vd, a->vn, a->vm, false);
 }
@@ -1658,7 +1658,7 @@ static bool trans_VADD_sp(DisasContext *s, arg_VADD_sp *a)
     return do_vfp_3op_sp(s, gen_helper_vfp_adds, a->vd, a->vn, a->vm, false);
 }
 
-static bool trans_VADD_dp(DisasContext *s, arg_VADD_sp *a)
+static bool trans_VADD_dp(DisasContext *s, arg_VADD_dp *a)
 {
     return do_vfp_3op_dp(s, gen_helper_vfp_addd, a->vd, a->vn, a->vm, false);
 }
@@ -1668,7 +1668,7 @@ static bool trans_VSUB_sp(DisasContext *s, arg_VSUB_sp *a)
     return do_vfp_3op_sp(s, gen_helper_vfp_subs, a->vd, a->vn, a->vm, false);
 }
 
-static bool trans_VSUB_dp(DisasContext *s, arg_VSUB_sp *a)
+static bool trans_VSUB_dp(DisasContext *s, arg_VSUB_dp *a)
 {
     return do_vfp_3op_dp(s, gen_helper_vfp_subd, a->vd, a->vn, a->vm, false);
 }
@@ -1678,7 +1678,7 @@ static bool trans_VDIV_sp(DisasContext *s, arg_VDIV_sp *a)
     return do_vfp_3op_sp(s, gen_helper_vfp_divs, a->vd, a->vn, a->vm, false);
 }
 
-static bool trans_VDIV_dp(DisasContext *s, arg_VDIV_sp *a)
+static bool trans_VDIV_dp(DisasContext *s, arg_VDIV_dp *a)
 {
     return do_vfp_3op_dp(s, gen_helper_vfp_divd, a->vd, a->vn, a->vm, false);
 }
@@ -1741,7 +1741,7 @@ static bool trans_VFM_sp(DisasContext *s, arg_VFM_sp *a)
     return true;
 }
 
-static bool trans_VFM_dp(DisasContext *s, arg_VFM_sp *a)
+static bool trans_VFM_dp(DisasContext *s, arg_VFM_dp *a)
 {
     /*
      * VFNMA : fd = muladd(-fd,  fn, fm)
@@ -2201,7 +2201,7 @@ static bool trans_VRINTR_sp(DisasContext *s, arg_VRINTR_sp *a)
     return true;
 }
 
-static bool trans_VRINTR_dp(DisasContext *s, arg_VRINTR_sp *a)
+static bool trans_VRINTR_dp(DisasContext *s, arg_VRINTR_dp *a)
 {
     TCGv_ptr fpst;
     TCGv_i64 tmp;
@@ -2257,7 +2257,7 @@ static bool trans_VRINTZ_sp(DisasContext *s, arg_VRINTZ_sp *a)
     return true;
 }
 
-static bool trans_VRINTZ_dp(DisasContext *s, arg_VRINTZ_sp *a)
+static bool trans_VRINTZ_dp(DisasContext *s, arg_VRINTZ_dp *a)
 {
     TCGv_ptr fpst;
     TCGv_i64 tmp;
-- 
2.20.1


