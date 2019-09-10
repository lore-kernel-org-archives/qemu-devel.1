Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A830AC3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 09:06:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 749EE206A5
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 09:06:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LwlDqjpP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 749EE206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36132 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7c6g-0001p3-6S
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 05:06:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35967)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i7bks-0003Wd-Jr
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 04:44:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i7bkr-0006QF-DE
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 04:44:06 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436]:34256)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i7bkr-0006Pm-7O
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 04:44:05 -0400
Received: by mail-wr1-x436.google.com with SMTP id a11so8603084wrx.1
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2019 01:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=oT+YrOkp3Z24zW1uGAxyIpgJg7/bVGfM+TeagJEdgqI=;
 b=LwlDqjpPhOBn3EkV+fdG7/LaIKNB4HGNdRD/IrYtAibyKWmHmiwioJTEwPkenYhegF
 EGMek+rmGIlBzTg+/e/P5g0ZogBJgTi5vTzVwUMHmySJ3LARpKLYMM7szz7z+vbh1VN9
 HsOUR3BaItEzg9v3ByH7WhHLI+W2VGTzr5f2vSdnSJ9aGUusxddFS10BFWJhJS0wyixT
 S4jvJVgctUoF4T38b3bZ5fTY1g8FG1In5C9B7VtZogL3jrCuieO9678wX1spBWnAVZk5
 aampqKj6Xzmz+qx7313ICOzlqDsRuh/qKvyTLLbIMHojN/8REXCOFhBSIWJfGx4yHIgQ
 tjBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=oT+YrOkp3Z24zW1uGAxyIpgJg7/bVGfM+TeagJEdgqI=;
 b=lQX8ICRfSqRKRf1DuZYTrM4O0tQKPzwt5mMSgcuVsrstoHyyP68789BRrttAiOCY7j
 wH4mUbG9EDaSx3fvSbrspLcJ2enRfUsAI4R4lFDLCS16emmKqxZA5mG/YWr4vAWgaTv8
 7mEg7B633BXeysoHlUBFk3V8IYDoEWGxlUEALVcAA1e2x3pcmRxRAx5WzTYc68grLs1g
 flBdMsy4lBHW1UduWHRv+UHlFsDCrHFxGBqBHA+I8a5Mg/48bUX4POM+2lDTBoy7IVpd
 07fuNwg8ng7XilIxy8JAKWIUqH8+pFcv8v22PO0AlvK/zW8CV/14O8WKztRido5EmF/2
 /HJA==
X-Gm-Message-State: APjAAAXUGKC5le9gbIQKY34p1uSMNjln6MnonktKw21jGfZ25Tr4C+oM
 5c4Z/HlZPb/0h+jGsNWCR4WoSA==
X-Google-Smtp-Source: APXvYqwrW+XcGrfYftw3eR9ctWtCOifZCrTic4dTUWxaUscaknHLBKXIKr9UedflAynxzF3KK8nZ/w==
X-Received: by 2002:adf:e44c:: with SMTP id t12mr23101031wrm.251.1568105044144; 
 Tue, 10 Sep 2019 01:44:04 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id h5sm12832294wrr.10.2019.09.10.01.43.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2019 01:44:01 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 8457D1FF87;
 Tue, 10 Sep 2019 09:43:51 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Date: Tue, 10 Sep 2019 09:43:25 +0100
Message-Id: <20190910084349.28817-22-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190910084349.28817-1-alex.bennee@linaro.org>
References: <20190910084349.28817-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::436
Subject: [Qemu-devel] [PULL 21/45] tests/docker: move our mips64 cross
 compile to Buster
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
Cc: Fam Zheng <fam@euphon.net>, Aleksandar Rikalo <arikalo@wavecomp.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Now Buster is released we can stop relying on the movable feast that
is Sid for our cross-compiler for building tests.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index e946aae14fa..896c1c5a601 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -102,11 +102,11 @@ docker-image-debian-alpha-cross: docker-image-debian10
 docker-image-debian-arm64-cross: docker-image-debian10
 docker-image-debian-hppa-cross: docker-image-debian10
 docker-image-debian-m68k-cross: docker-image-debian10
+docker-image-debian-mips64-cross: docker-image-debian10
 docker-image-debian-powerpc-cross: docker-image-debian10
 docker-image-debian-sh4-cross: docker-image-debian10
 docker-image-debian-sparc64-cross: docker-image-debian10
 
-docker-image-debian-mips64-cross: docker-image-debian-sid
 docker-image-debian-riscv64-cross: docker-image-debian-sid
 docker-image-debian-ppc64-cross: docker-image-debian-sid
 docker-image-travis: NOUSER=1
diff --git a/tests/docker/dockerfiles/debian-mips64-cross.docker b/tests/docker/dockerfiles/debian-mips64-cross.docker
index bf0073a4662..1a79505d696 100644
--- a/tests/docker/dockerfiles/debian-mips64-cross.docker
+++ b/tests/docker/dockerfiles/debian-mips64-cross.docker
@@ -1,10 +1,9 @@
 #
 # Docker cross-compiler target
 #
-# This docker target builds on the debian sid base image which
-# contains cross compilers for Debian "ports" targets.
+# This docker target builds on the debian Buster base image.
 #
-FROM qemu:debian-sid
+FROM qemu:debian10
 
 RUN apt update && \
     DEBIAN_FRONTEND=noninteractive eatmydata \
-- 
2.20.1


