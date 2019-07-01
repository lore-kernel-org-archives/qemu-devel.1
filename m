Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76D35C5B578
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 02:58:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41F84205C9
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 02:58:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fQG36Omn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41F84205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47234 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hi8TU-0002b2-Tr
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 22:24:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56447)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hi4PM-0006p1-0W
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 18:04:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hi4PI-00017j-1d
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 18:04:18 -0400
Received: from mail-wr1-f49.google.com ([209.85.221.49]:44121)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hi4PE-00014B-8I
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 18:04:14 -0400
Received: by mail-wr1-f49.google.com with SMTP id e3so5903288wrs.11
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2019 15:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=sPbsb4f0JFD9WjkRWgwBp1rhSrFIRCwYdPeLnHu8nlU=;
 b=fQG36OmneOJ9jlAXGyPQbqVNcTTRlBazSOwtcCEZUf5RMrbY84c0kYPdTYmDpduFsd
 TA+0NMURBn0RHKtIgTnRRVHbqQG+3edeYPSnQiOIZKR/DazbD5vpKJQQBuk86o2r186r
 mZc9Kx+PeS7m9B4DujbjeybhpvfF9QfO78Pj9t6CkHZchQ7jiwSIm+xf+OgH/95fCglu
 67OkMiKOEdLT+Vmqt+d9ANhemHbUg5A+YDWXvzY1BenenVSwu4dUoqjVCzd43HKhx6vw
 beNpuM+Z5eD/5k8OFxzef1PREkkj64BlprWbOihz8PYNYRzYCVnfzdmtXOmNdxIBLodd
 MAYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=sPbsb4f0JFD9WjkRWgwBp1rhSrFIRCwYdPeLnHu8nlU=;
 b=IUbtGFafgJyQ/gA9A/YqOJ82+MFxxavs8X6835FmBvjfM22rmzTqe1SYYm+ZiJUqI+
 FVFBHXnAd25LUt6r+FS5bwRsAwFRL77Ubk7POxfw1i8s09omRHvMosdB7kq6kmI3M9um
 28N3BTl4RKaGRaSQLwapYobKujN27+vcz5u6D+AyoL3JJHhsXgHSNGnA4efOpPd0xDKm
 JnFz5VrlrfeIhtWvyX8Yu0JSwHorLFOaayCpBdOAIbJaZVmSrrJLjT4pi9i1W2wUudHi
 Om91xN4lr93dR019edr2agthWWFruZyed7Sub2065RuJNX1rS4Is8pwBXDFez7fzOXtl
 gGag==
X-Gm-Message-State: APjAAAUcN7Jwov+WpPrKA/qRqkLqFvx1gip4io2t2L7naVz3sh5AraSl
 9fEOZLsj58OSnfbA+lXuTD6iT/C4+PTBXg==
X-Google-Smtp-Source: APXvYqzVYyDLS7q1BUpVlT1//XpSKpV1y5lIlzA7o0sV2Yh001mjPLCSCCyKIS0CPn/a7mBehSHPDg==
X-Received: by 2002:adf:de90:: with SMTP id w16mr19401268wrl.217.1561999232428; 
 Mon, 01 Jul 2019 09:40:32 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id o6sm26573508wra.27.2019.07.01.09.40.31
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 01 Jul 2019 09:40:31 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon,  1 Jul 2019 17:39:39 +0100
Message-Id: <20190701163943.22313-43-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190701163943.22313-1-peter.maydell@linaro.org>
References: <20190701163943.22313-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.49
Subject: [Qemu-devel] [PULL 42/46] target/arm/vfp_helper: Extract
 vfp_set_fpscr_from_host()
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

From: Philippe Mathieu-Daudé <philmd@redhat.com>

The vfp_set_fpscr() helper contains code specific to the host
floating point implementation (here the SoftFloat library).
Extract this code to vfp_set_fpscr_from_host().

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-id: 20190701132516.26392-17-philmd@redhat.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/vfp_helper.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/target/arm/vfp_helper.c b/target/arm/vfp_helper.c
index b19a395b67d..838f7d25fd1 100644
--- a/target/arm/vfp_helper.c
+++ b/target/arm/vfp_helper.c
@@ -81,6 +81,18 @@ static inline int vfp_exceptbits_to_host(int target_bits)
     return host_bits;
 }
 
+static uint32_t vfp_get_fpscr_from_host(CPUARMState *env)
+{
+    uint32_t i;
+
+    i = get_float_exception_flags(&env->vfp.fp_status);
+    i |= get_float_exception_flags(&env->vfp.standard_fp_status);
+    /* FZ16 does not generate an input denormal exception.  */
+    i |= (get_float_exception_flags(&env->vfp.fp_status_f16)
+          & ~float_flag_input_denormal);
+    return vfp_exceptbits_from_host(i);
+}
+
 static void vfp_set_fpscr_to_host(CPUARMState *env, uint32_t val)
 {
     int i;
@@ -141,12 +153,7 @@ uint32_t HELPER(vfp_get_fpscr)(CPUARMState *env)
             | (env->vfp.vec_len << 16)
             | (env->vfp.vec_stride << 20);
 
-    i = get_float_exception_flags(&env->vfp.fp_status);
-    i |= get_float_exception_flags(&env->vfp.standard_fp_status);
-    /* FZ16 does not generate an input denormal exception.  */
-    i |= (get_float_exception_flags(&env->vfp.fp_status_f16)
-          & ~float_flag_input_denormal);
-    fpscr |= vfp_exceptbits_from_host(i);
+    fpscr |= vfp_get_fpscr_from_host(env);
 
     i = env->vfp.qc[0] | env->vfp.qc[1] | env->vfp.qc[2] | env->vfp.qc[3];
     fpscr |= i ? FPCR_QC : 0;
-- 
2.20.1


