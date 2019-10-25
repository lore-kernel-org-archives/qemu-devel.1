Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38BCBCA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 06:48:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0684620867
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 06:48:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YNdn/MR0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0684620867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56032 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNtOu-0001u2-Ay
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 02:48:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35472)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iNtDw-00038H-Px
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 02:37:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iNtDv-0008Op-MQ
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 02:37:24 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329]:39704)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iNtDv-0008OM-GH
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 02:37:23 -0400
Received: by mail-wm1-x329.google.com with SMTP id r141so754162wme.4
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 23:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=KBMNgmBi7/k8LJ63MGoqOawSxFhttAR/bJdyMWQnEAU=;
 b=YNdn/MR01lP6bgUrABEkCfoZTLgqwbuUnTNet4W8WkH0MSiblfSWPVtxxxRmtt6RF7
 PSfcEYAB0/kim6MspgMaUbhXAJv22VYLJtc+6faZgvxg+xZ3xZBzf46Pt0QwPPnMi4mK
 niu3ZYM8cuD1mH4vnSarQWs5FVnjy0f6qqTPRvtX9rP/+cqzGkT4XJOdpNRkjFwRqFQF
 zKkf7rHI7rc2DH7DksuUmlaIiGAPRowtH8zvFgSguIBpOEp88zcWju2OIW1ehvt4tJ7L
 XbQ9+itpWNsQl0vODdHHu+wdIymJXMGQvk4Tg5pPrfPmVp8jxSzyHKvea1R2Jsgguu7F
 6MNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=KBMNgmBi7/k8LJ63MGoqOawSxFhttAR/bJdyMWQnEAU=;
 b=XjxPlbDLaTfyB0Ng6EFVq2Afwe+NjJ5+mA71nIEYY3qThajd8dxPZ7OWK2neNDtC3w
 4wxC6NmoJLQPu5TNKprMiItI2DZfaspKDOdS7KYGI84QffdEcPglL3JopbEF9aRVaRlj
 vDZWldp5V7YE8k21JulUN9Rq0x4kvJJ+OINCS0JiTSkjspeAu0W73G+k1KBSPlSSMyC6
 Soo5bF454p4UBtOgbnjlDkOFY6iiG+4MTUDpkfFcbVAk4AHtFZOVIyR10UxuVCpKNl3A
 RQIrRdcLIyOj3MKxhwHB914lvXguI0LANyPV7KGJWSOehMlX0dqIMV2DMWrkYZDt6ScQ
 nUSg==
X-Gm-Message-State: APjAAAX/9sxc7hdt6Vl2WtmR+FCbKJCga+b7NrWa44zbfMJlvP4INual
 r3CVEyiBpF6wJM/ONwHQYe3f0w==
X-Google-Smtp-Source: APXvYqzdvcfKisazfDotOfP7lceLzA3nniIP6G51X1WnKp1Qbf+Ae5uxU5TuxH/teU08VDsUXKF/ig==
X-Received: by 2002:a05:600c:2293:: with SMTP id
 19mr1829021wmf.9.1571985442376; 
 Thu, 24 Oct 2019 23:37:22 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id p18sm1173048wmi.42.2019.10.24.23.37.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Oct 2019 23:37:22 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id D93CF1FF9D;
 Fri, 25 Oct 2019 07:37:14 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL v2 13/73] gitlab-ci.yml: Use libvdeplug-dev to compile-test the
 VDE network backend
Date: Fri, 25 Oct 2019 07:36:13 +0100
Message-Id: <20191025063713.23374-14-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191025063713.23374-1-alex.bennee@linaro.org>
References: <20191025063713.23374-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::329
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
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Thomas Huth <thuth@redhat.com>

The libvdeplug-dev package is required to compile-test net/vde.c.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20191016131002.29663-1-thuth@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index ed8067f5cf9..be57c6a454a 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -5,7 +5,7 @@ before_script:
 build-system1:
  script:
  - apt-get install -y -qq libgtk-3-dev libvte-dev nettle-dev libcacard-dev
-      libusb-dev libvde-dev libspice-protocol-dev libgl1-mesa-dev
+      libusb-dev libvde-dev libspice-protocol-dev libgl1-mesa-dev libvdeplug-dev
  - ./configure --enable-werror --target-list="aarch64-softmmu alpha-softmmu
       cris-softmmu hppa-softmmu lm32-softmmu moxie-softmmu microblazeel-softmmu
       mips64el-softmmu m68k-softmmu ppc-softmmu riscv64-softmmu sparc-softmmu"
-- 
2.20.1


