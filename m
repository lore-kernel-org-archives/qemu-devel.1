Return-Path: <SRS0=9X/F=UF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FD94C04AB5
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 18:04:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9B8520868
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 18:04:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AeivwsWv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9B8520868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36159 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYwkR-0004QT-5Q
	for qemu-devel@archiver.kernel.org; Thu, 06 Jun 2019 14:04:23 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45021)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hYwUB-0004a7-8G
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 13:47:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hYwU7-0004Ca-GD
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 13:47:35 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:51559)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hYwU7-00038g-7L
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 13:47:31 -0400
Received: by mail-wm1-x343.google.com with SMTP id f10so812923wmb.1
	for <qemu-devel@nongnu.org>; Thu, 06 Jun 2019 10:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=nNQjd9/+a2DdLghORqFl+Muzj1ZfiiJpWnJhjxjLPOE=;
	b=AeivwsWv6H3IMBY0RADPYPO1lUXNcmCV50EZlViQj9rpGM/zN5493L4aRJAyIaNeOQ
	Yk2k7qHXCL3EBHhm+2MP/CTSx7N04cQHVYJCjw2vdVFdrm0cV8X27GlCoR4O/enGbfW6
	dceQC6n7721RoOitNI4VdXQsDYDs6kRXhinqLrGbGet3rek38chCJDlvg5GYjX8lUIhy
	zTRwZdi0U/vFTEdxajMNQ4xN9YfNnEGwTbWt0hJ0sP0cXhfiu4rhlbXam1ZjOW3yjLcB
	xO9N6UZdylICDPYeRQaUyT8sLJZCIlyF0BmRanSelP3XkXEk/8eI6NyQlxrsSagEdeH/
	u0UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=nNQjd9/+a2DdLghORqFl+Muzj1ZfiiJpWnJhjxjLPOE=;
	b=BVIgIu2q2bBC3tMY8BXbQMCZ4pxppaxeQ/wL+cS0R3qPHkrAAkLoy55yfxvweVfX3/
	5SZl56v1NQWDUp3kYo/icBW6p9U9Sw2v9G1+QnJcs6kI4pnnQ0teHzOWp4YoVFk1eg9S
	qNmQ3wRbInSLytH8zb6Nypg12PHgDBZ4MFEUASrguCJdArWbe0piCycv3y5qZhJTm2OO
	aZx8/b6xuPXe+OhhKzwfPnTW0GRqhmqvAHgC9fPcCz8ZWMCT7OckfYgx70LUDfdU+V8S
	kuLxzvSSimCepuZZrje45yIGWeQwtk5zFV87B2LojT4T8eritN0FIjgnklYNhFDHpn1y
	uoMA==
X-Gm-Message-State: APjAAAVygJSq2JkPPwTiU8293GDnGv6EHsQ+BOpl4+XFlK7E5zSyKEdi
	GPCfox83CgkNRrZ/hM17UScTHg==
X-Google-Smtp-Source: APXvYqwpeQ8mciG9lO53pZDwVTwx/zorKDR6VJFwTyaeMhrANtqz7/G13SAurpGczM2SGLhUJBpAwA==
X-Received: by 2002:a1c:305:: with SMTP id 5mr824561wmd.101.1559843198881;
	Thu, 06 Jun 2019 10:46:38 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	z135sm2596784wmc.45.2019.06.06.10.46.38
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 06 Jun 2019 10:46:38 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Date: Thu,  6 Jun 2019 18:45:52 +0100
Message-Id: <20190606174609.20487-26-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190606174609.20487-1-peter.maydell@linaro.org>
References: <20190606174609.20487-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::343
Subject: [Qemu-devel] [PATCH 25/42] target/arm: Convert VSUB to decodetree
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Convert the VSUB instruction to decodetree.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate-vfp.inc.c | 10 ++++++++++
 target/arm/translate.c         |  6 +-----
 target/arm/vfp.decode          |  5 +++++
 3 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/target/arm/translate-vfp.inc.c b/target/arm/translate-vfp.inc.c
index 14aeb25f597..12da3b8acb8 100644
--- a/target/arm/translate-vfp.inc.c
+++ b/target/arm/translate-vfp.inc.c
@@ -1461,3 +1461,13 @@ static bool trans_VADD_dp(DisasContext *s, arg_VADD_sp *a)
 {
     return do_vfp_3op_dp(s, gen_helper_vfp_addd, a->vd, a->vn, a->vm, false);
 }
+
+static bool trans_VSUB_sp(DisasContext *s, arg_VSUB_sp *a)
+{
+    return do_vfp_3op_sp(s, gen_helper_vfp_subs, a->vd, a->vn, a->vm, false);
+}
+
+static bool trans_VSUB_dp(DisasContext *s, arg_VSUB_sp *a)
+{
+    return do_vfp_3op_dp(s, gen_helper_vfp_subd, a->vd, a->vn, a->vm, false);
+}
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 7fa255f6598..433f1cbf2c7 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -1386,7 +1386,6 @@ static inline void gen_vfp_##name(int dp)                             \
     tcg_temp_free_ptr(fpst);                                          \
 }
 
-VFP_OP2(sub)
 VFP_OP2(div)
 
 #undef VFP_OP2
@@ -3110,7 +3109,7 @@ static int disas_vfp_insn(DisasContext *s, uint32_t insn)
             rn = VFP_SREG_N(insn);
 
             switch (op) {
-            case 0 ... 6:
+            case 0 ... 7:
                 /* Already handled by decodetree */
                 return 1;
             default:
@@ -3296,9 +3295,6 @@ static int disas_vfp_insn(DisasContext *s, uint32_t insn)
             for (;;) {
                 /* Perform the calculation.  */
                 switch (op) {
-                case 7: /* sub: fn - fm */
-                    gen_vfp_sub(dp);
-                    break;
                 case 8: /* div: fn / fm */
                     gen_vfp_div(dp);
                     break;
diff --git a/target/arm/vfp.decode b/target/arm/vfp.decode
index d911f12dfd0..de56f44efc9 100644
--- a/target/arm/vfp.decode
+++ b/target/arm/vfp.decode
@@ -132,3 +132,8 @@ VADD_sp      ---- 1110 0.11 .... .... 1010 .0.0 .... \
              vm=%vm_sp vn=%vn_sp vd=%vd_sp
 VADD_dp      ---- 1110 0.11 .... .... 1011 .0.0 .... \
              vm=%vm_dp vn=%vn_dp vd=%vd_dp
+
+VSUB_sp      ---- 1110 0.11 .... .... 1010 .1.0 .... \
+             vm=%vm_sp vn=%vn_sp vd=%vd_sp
+VSUB_dp      ---- 1110 0.11 .... .... 1011 .1.0 .... \
+             vm=%vm_dp vn=%vn_dp vd=%vd_dp
-- 
2.20.1


