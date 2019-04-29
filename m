Return-Path: <SRS0=sEuR=S7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61259C04AA6
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 17:19:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29DFC2147A
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 17:19:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HG/W47iA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29DFC2147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60841 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hL9vn-0002VK-9B
	for qemu-devel@archiver.kernel.org; Mon, 29 Apr 2019 13:19:07 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34374)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL9er-0004re-HB
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:01:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL9eo-0006kj-HI
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:01:36 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333]:39766)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hL9eo-0006A7-2D
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:01:34 -0400
Received: by mail-wm1-x333.google.com with SMTP id n25so161295wmk.4
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 10:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=S6YGUPrZb+xu8faTD0l3bzQsRZcNjA+xFgUKebYVi8Q=;
	b=HG/W47iAG3JKUM2CErCJc6Hv+xR0WIi3N3YEQt8NKcWchnDBriQs45eRcs8hx09LIX
	agfqckyOCqK4oqzwwQKwcMWlLz/SC+VCPIVSO3dygOm9jJjfJdNL0YStntekuD/pqoKU
	M70cE2HJ4UCfbrtsQkq6BXUu2FDWN5mMge7/WwNo/Me7U93cybLzoY8cxnkfKNU3yfot
	bR84OZJB+vutz7dWK1oDP3fScqI2txhCCNE/G2evJkTEfNj5rv95NmznVNOeTbVHpN7G
	4LfVF4JNCeWt2RNGZGLvF8+MCV85VGHgeIHOrRl376Ic1zzmkOrudQMsAcnbIOYxbfzW
	iYow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=S6YGUPrZb+xu8faTD0l3bzQsRZcNjA+xFgUKebYVi8Q=;
	b=a63k9rw1ObT2k/aYSNxDErlZs0IWJH3ojTGZErdVP0NfDz/HYTYHNFTa/GtPVDInDC
	w/6jN4vbsKS0nZylWWywbGdXrgIbd2HMtswYMz6phxLMJb6JV4w/I2LhMIh5Dl6I2DSi
	BldTAVoD5qUzdyuL2R+O1UodWsahk8vxKlZrbDjJLWiCklNBKdFABvhvRH7ZHEjA1Ike
	dcqQJdc7VaFdwAwIrisAcFergzqMD+9Q8hcGqFUNx5pT5dazI9zqhYDhUT2OOvIy1OvR
	tFQoKBtpO2le8TIjTygPXxrqMd2l5ylii20Y2ivNR6DVmHu4rqIeVOq0+quDsgVhiqqM
	qilA==
X-Gm-Message-State: APjAAAWpY6t9/QfEPwqRJRTOGwZElAQbXq7qX8jHrn2xo5jxHs1aJIkl
	on7hrAUGBMRgUptbDNhGUMyjdbV1DvM=
X-Google-Smtp-Source: APXvYqwcmd80JjmsS49QpgvVjv3x4wZ7iMXzlzgPPLGaIRrp0B5cs4zkN4noZwZckAvoFZqgJ+WfOA==
X-Received: by 2002:a1c:be0e:: with SMTP id o14mr35391wmf.11.1556557238029;
	Mon, 29 Apr 2019 10:00:38 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id a13sm36896wmj.39.2019.04.29.10.00.36
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 29 Apr 2019 10:00:37 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon, 29 Apr 2019 17:59:52 +0100
Message-Id: <20190429170030.11323-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190429170030.11323-1-peter.maydell@linaro.org>
References: <20190429170030.11323-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::333
Subject: [Qemu-devel] [PULL 04/42] target/arm: Make sure M-profile FPSCR
 RES0 bits are not settable
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190429165952.ag5A3KQDhC6CMrTtgS_GbNngDf37QZmYGCwN_1dYrtQ@z>

Enforce that for M-profile various FPSCR bits which are RES0 there
but have defined meanings on A-profile are never settable. This
ensures that M-profile code can't enable the A-profile behaviour
(notably vector length/stride handling) by accident.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20190416125744.27770-2-peter.maydell@linaro.org
---
 target/arm/vfp_helper.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/target/arm/vfp_helper.c b/target/arm/vfp_helper.c
index 2468fc16294..7a46d991486 100644
--- a/target/arm/vfp_helper.c
+++ b/target/arm/vfp_helper.c
@@ -105,6 +105,14 @@ void HELPER(vfp_set_fpscr)(CPUARMState *env, uint32_t val)
         val &= ~FPCR_FZ16;
     }
 
+    if (arm_feature(env, ARM_FEATURE_M)) {
+        /*
+         * M profile FPSCR is RES0 for the QC, STRIDE, FZ16, LEN bits
+         * and also for the trapped-exception-handling bits IxE.
+         */
+        val &= 0xf7c0009f;
+    }
+
     /*
      * We don't implement trapped exception handling, so the
      * trap enable bits, IDE|IXE|UFE|OFE|DZE|IOE are all RAZ/WI (not RES0!)
-- 
2.20.1


