Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD4DAC3F68F
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 12:20:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71A6A2467F
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 12:20:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KZafxjOH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71A6A2467F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54286 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiHGI-0007rB-Eb
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 07:20:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54443)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iiH1y-000587-SF
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 07:05:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iiH1q-0008SZ-5X
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 07:05:15 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:52406)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iiH1o-0008Oj-O0
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 07:05:09 -0500
Received: by mail-wm1-x341.google.com with SMTP id p9so8694650wmc.2
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2019 04:05:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=YX/3QlJb96xuPlFrDu4WTqDveBFpdotwZIYVwV0XY7M=;
 b=KZafxjOH1S30qEh72GnMUHe2Au3BKIRFNGoG+fusNFoSXd61bMzh2txwNDqIhUrWQ8
 lsrFGNfq94RRztbZSLmBp1IZazWVx1xgFb4Nlu+kauZ+ZoCEoh6d2zZZOjzPf3q7sGH+
 fupYZcO6tS99qPBjwTnrreimuBWw6KkOc4ym3r07qndFNjQxi9h2UMruWlaTDBeWXBL7
 d5Wahcms/WP45ndLpzTUGYw9DXWohfk2QxMDaFzg2w7VMtCgvwHYZ7NkCNbFc/Sk5nvU
 LOMfb3qzVxp09VdCibz878qyKu36LPWOMQaBj9tr0luSw6I4m4xUGuo0h5KYP/enWVb/
 F3Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=YX/3QlJb96xuPlFrDu4WTqDveBFpdotwZIYVwV0XY7M=;
 b=AkBNO/DlnZBChzzVyYVoDLQOnVs2dHj+8/HzhXpfRNGxMoL9CFKBb8+9FcwliaNlYu
 HeqzF4O1zNIt+un/468R2GcJm8RQUhDoPEAsF+DT2Vafr/cejJmGnssOQwqOVoAjdheL
 ugnpSWjdiMhMSsxwubQK1e+J/7rECyatC5rStDIVTR2LsALu9GCCBiamZJvXwhRd4cbN
 lCK4OkpRh7Omkigb30i/wt4xaj15R3AVOIp9CmZSjToT+On5VE8CN1cw2c6bAgjqwXyx
 oxGdzfZSltKpZltWD66vT45gEkZYZUijnS0rR+RwFWTcodRtUnPeAm0wcps7Bc2zTz9u
 hu8g==
X-Gm-Message-State: APjAAAWM7rbgDVEg7W/GQ/4vwt5sDpo6mbmoxnKHccqok2dGiLDYIPIq
 fN/t4WloUK7CUVidAKuSEZtwVA==
X-Google-Smtp-Source: APXvYqzMteUC02PV+0/r2/S45UUYqfEQ/Cs/MC4qnm8xsmsJqbt8UeCUp4Q1YJDZu8bB2u+RzfAxMA==
X-Received: by 2002:a1c:7419:: with SMTP id p25mr15515137wmc.129.1576843507082; 
 Fri, 20 Dec 2019 04:05:07 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id x18sm9681364wrr.75.2019.12.20.04.04.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Dec 2019 04:04:51 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 2C4A81FF9B;
 Fri, 20 Dec 2019 12:04:40 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 11/21] target/arm: default SVE length to 64 bytes for
 linux-user
Date: Fri, 20 Dec 2019 12:04:28 +0000
Message-Id: <20191220120438.16114-12-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191220120438.16114-1-alex.bennee@linaro.org>
References: <20191220120438.16114-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
Cc: damien.hedde@greensocs.com, Peter Maydell <peter.maydell@linaro.org>,
 luis.machado@linaro.org, Richard Henderson <richard.henderson@linaro.org>,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>, alan.hayward@arm.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The Linux kernel chooses the default of 64 bytes for SVE registers on
the basis that it is the largest size on known hardware that won't
grow the signal frame. We still honour the sve-max-vq property and
userspace can expand the number of lanes by calling PR_SVE_SET_VL.

This should not make any difference to SVE enabled software as the SVE
is of course vector length agnostic.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

---
v2
  - tweak zcr_el[1] instead
---
 target/arm/cpu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index dd51adac059..2d2e786245b 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -199,9 +199,9 @@ static void arm_cpu_reset(CPUState *s)
         /* and to the SVE instructions */
         env->cp15.cpacr_el1 = deposit64(env->cp15.cpacr_el1, 16, 2, 3);
         env->cp15.cptr_el[3] |= CPTR_EZ;
-        /* with maximum vector length */
+        /* with reasonable vector length */
         env->vfp.zcr_el[1] = cpu_isar_feature(aa64_sve, cpu) ?
-                             cpu->sve_max_vq - 1 : 0;
+            MIN(cpu->sve_max_vq - 1, 3) : 0;
         env->vfp.zcr_el[2] = env->vfp.zcr_el[1];
         env->vfp.zcr_el[3] = env->vfp.zcr_el[1];
         /*
-- 
2.20.1


