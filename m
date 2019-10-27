Return-Path: <SRS0=q9Vo=YU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46BC7CA9EAF
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Oct 2019 19:27:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 009FE2070B
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Oct 2019 19:27:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xsnUAI5j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 009FE2070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46814 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iOoCY-0006IT-4l
	for qemu-devel@archiver.kernel.org; Sun, 27 Oct 2019 15:27:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40000)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iOo7V-00053Z-Og
 for qemu-devel@nongnu.org; Sun, 27 Oct 2019 15:22:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iOo7T-00074m-Ih
 for qemu-devel@nongnu.org; Sun, 27 Oct 2019 15:22:33 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330]:52078)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iOo7S-00074O-5i
 for qemu-devel@nongnu.org; Sun, 27 Oct 2019 15:22:30 -0400
Received: by mail-wm1-x330.google.com with SMTP id q70so7248652wme.1
 for <qemu-devel@nongnu.org>; Sun, 27 Oct 2019 12:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=nR6x1L//qYywRjiO6A3GGrsBxnTEBFh4NxfRz9ZhsbY=;
 b=xsnUAI5jayjRslLfh9+SXh8AG6vmSrnU1atCi3RK0xzRgAxvihepiswA1cpysd7vUw
 bCnhxlyBQdT/j86dJlSRiskSCYON1AWww8DXC95dTc+S7BHJ9lOZUhxNTpmLE7/AS/69
 49eleRVAatfemyCjgEpGg3f5QZ83SvKhKDpA/0XCounmwLE95SRmThSbaOgNjlO1ibCF
 vHe20OFAnR0/LaDMDH6/5DkgPrujV6zmC98g7T5F9P8Be9d8R9Q9mg5+CKOBd1dGhQg/
 7FeooprYl2XlMbBNn4O/2Z1bKC2bTATpNBL0XYRLOfuMExrh/5X3O+xZmbvaolwLu09L
 G2nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=nR6x1L//qYywRjiO6A3GGrsBxnTEBFh4NxfRz9ZhsbY=;
 b=hDMme3vg1yC81csT2zyWUnuIXIrlaa7GAM9coPOFgyfoSEo3wX8H463qGyFeBEjcEy
 /8/ew1mLa3FyylmIKRV8y29L5unzO8/CPXAl3ALKyR5/uZyCPAAeJBuFvlUJ/BhDapTX
 gtaSLq9tdbQA+VCXiLzkjivbYmFzPFoAkS3Jh7GhVdN3DNJe0tnSjURMx+gRUY9S1THt
 CL0B9z9DM2sW2sgO0LbNIH5hwoT0mXr70Tw5VbEevNhm11WhvrVex+zk3HU/S4fOtTXP
 /TIe1xndN4rjSXV0M2nFQdSJSGi2R774K2EDdgQnYRDSBj/suGIvfKPYAOe+f846Avc4
 4TzQ==
X-Gm-Message-State: APjAAAUmTeM8lbGag7utaS6Wa2b1DxIVOffP9SvDXDMSi6qY3IcAHC2W
 9FgJ8l0qg9iyEc3vVP3MtqQE7Q==
X-Google-Smtp-Source: APXvYqzTZqmpmzyPzdqDcITi+UGltE6bTsSDcrGulweU/l05La0+SNoIwkGTKE6bC+TxnrxdDIPn8w==
X-Received: by 2002:a7b:c208:: with SMTP id x8mr11280967wmi.87.1572204147172; 
 Sun, 27 Oct 2019 12:22:27 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id q12sm3195880wrw.91.2019.10.27.12.22.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Oct 2019 12:22:24 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id C8AB51FF90;
 Sun, 27 Oct 2019 19:22:23 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 3/3] contrib/gitdm: add China Mobile to the domain map
Date: Sun, 27 Oct 2019 19:22:23 +0000
Message-Id: <20191027192223.10855-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191027192223.10855-1-alex.bennee@linaro.org>
References: <20191027192223.10855-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::330
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org, Mao Zhongyi <maozhongyi@cmss.chinamobile.com>,
 Zhang Shengju <zhangshengju@cmss.chinamobile.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We've had a number of contributions from this domain. Mao has
confirmed they are company contributions.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Acked-by: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
Cc: Zhang Shengju <zhangshengju@cmss.chinamobile.com>

diff --git a/contrib/gitdm/domain-map b/contrib/gitdm/domain-map
index 9efe066ec9c..dd79147c769 100644
--- a/contrib/gitdm/domain-map
+++ b/contrib/gitdm/domain-map
@@ -5,6 +5,7 @@
 #
 
 amd.com         AMD
+cmss.chinamobile.com China Mobile
 citrix.com      Citrix
 greensocs.com   GreenSocs
 fujitsu.com     Fujitsu
-- 
2.20.1


