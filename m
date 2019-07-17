Return-Path: <SRS0=PWhW=VO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 324AFC76186
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 13:44:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03DEB208C0
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 13:44:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y1x8dG4F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03DEB208C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57289 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnkEh-0000we-Lk
	for qemu-devel@archiver.kernel.org; Wed, 17 Jul 2019 09:44:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55292)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hnkDd-0004wI-CV
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 09:43:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hnkDc-0004UM-9H
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 09:43:41 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333]:35886)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hnkDc-0004TJ-34
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 09:43:40 -0400
Received: by mail-wm1-x333.google.com with SMTP id g67so18123181wme.1
 for <qemu-devel@nongnu.org>; Wed, 17 Jul 2019 06:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=NtTeI78xH8tUJdk+GboQTX8bIzoNGyDMueezw0Q9cwY=;
 b=Y1x8dG4Fv0KMiUJaOowH08wZEki84il4YzkGQO1LKdDVdXlAtMWO9RanUtftx02Fpm
 BotlKmQEsUZfj2HFxUST9R5TvQmZIfUKPrZhW2ayZysK8bJYzkB9QC78Mpr/Lvb1VDW1
 8116Bfxdg92hNLVmDjbzD2bLUv9+R8axVzRKFEQuSOYD7hFOdmbqbys+lLi1HNsbCD22
 TBo3+sNPqDlSOfDC+A15LGGThq4YBESgR5OaGzvtBz3z8Mzz2fLEKDFmGP2lPVi5DgtD
 SR+91qpi3iR2WnSSUheQnIqu/+E3muPW7hhnaiRC+vBc7VLCsI/RPpaI8OCGYcQBwmb+
 895g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=NtTeI78xH8tUJdk+GboQTX8bIzoNGyDMueezw0Q9cwY=;
 b=HB2JwMJgjCeFSSLUEFRg6i/0LqstgAdrC9uqVr6QT3evo97nB7nOr4D5SWSyuKHxqP
 woIb0wpyRGSzqhUpK7GycHa4OH9mp4y9G5/kNB0Ta+/ZP9mIReeMU5s9C4+4kkwCQNpS
 Xj0H6Can04UjvV9zrbFPeIv12mhbulumkpcN2bpR5aRb4VA0xbifCS0nD924ahUuQa67
 g7i1GWRgvaP03ZDSZEO8Q6OE6nyBlCKTwgZF/O1TvZCkGlvWdmOL08zs2Cx2FIApVVQ/
 nmVzJN8sAJ2jquL6YW50q7fPx/r+gBwOPPbKKsm2y2aWPzg0CLFRrS/ytz2HH9hpLW8R
 rupw==
X-Gm-Message-State: APjAAAWe1addN2M8xEhm1oGn7Gmu9ZRkkt/YeeZZ18lHG52oHdYnnKVd
 YCwvoQuuIkxM3Y0BwjcZNwDbZyGwBmM=
X-Google-Smtp-Source: APXvYqxHdaF/TJl8yGKLAYqVDZfHBIvNqtnwIOdFY2sm/urH9/qItTji/EbQbMhV8FX0HDFTF1g8PA==
X-Received: by 2002:a1c:6555:: with SMTP id z82mr37948391wmb.129.1563371018810; 
 Wed, 17 Jul 2019 06:43:38 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id c1sm46381749wrh.1.2019.07.17.06.43.36
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 17 Jul 2019 06:43:37 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 233191FF90;
 Wed, 17 Jul 2019 14:43:36 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 17 Jul 2019 14:43:15 +0100
Message-Id: <20190717134335.15351-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190717134335.15351-1-alex.bennee@linaro.org>
References: <20190717134335.15351-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::333
Subject: [Qemu-devel] [PATCH v2 03/23] tests/docker: Install Sphinx in the
 Ubuntu images
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
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Since commit 5f71eac06e the Sphinx tool is required
to build the rST documentation.

This fixes:

 $ ./configure --enable-docs

 ERROR: User requested feature docs
        configure was not able to find it.
        Install texinfo, Perl/perl-podlators and python-sphinx

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20190711120609.12773-1-philmd@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
---
 tests/docker/dockerfiles/ubuntu.docker     | 1 +
 tests/docker/dockerfiles/ubuntu1804.docker | 1 +
 2 files changed, 2 insertions(+)

diff --git a/tests/docker/dockerfiles/ubuntu.docker b/tests/docker/dockerfiles/ubuntu.docker
index d3b72209c85..2500ec84b6f 100644
--- a/tests/docker/dockerfiles/ubuntu.docker
+++ b/tests/docker/dockerfiles/ubuntu.docker
@@ -61,6 +61,7 @@ ENV PACKAGES flex bison \
     libxen-dev \
     make \
     python-yaml \
+    python3-sphinx \
     sparse \
     texinfo \
     xfslibs-dev
diff --git a/tests/docker/dockerfiles/ubuntu1804.docker b/tests/docker/dockerfiles/ubuntu1804.docker
index 9d80b115009..0bb8088658d 100644
--- a/tests/docker/dockerfiles/ubuntu1804.docker
+++ b/tests/docker/dockerfiles/ubuntu1804.docker
@@ -48,6 +48,7 @@ ENV PACKAGES flex bison \
     libxen-dev \
     make \
     python-yaml \
+    python3-sphinx \
     sparse \
     texinfo \
     xfslibs-dev
-- 
2.20.1


