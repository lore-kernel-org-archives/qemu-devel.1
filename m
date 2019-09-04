Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3976CC3A5A9
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 21:08:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0276F21726
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 21:08:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ltyBU1t7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0276F21726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39868 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5cVc-0004ut-LR
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 17:08:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51701)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i5c46-00016d-4K
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 16:39:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i5c43-0003c3-GN
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 16:39:42 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a]:39891)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i5c42-0003aL-07
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 16:39:38 -0400
Received: by mail-wr1-x42a.google.com with SMTP id t16so204166wra.6
 for <qemu-devel@nongnu.org>; Wed, 04 Sep 2019 13:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=g7I0s4Lie1qYSELayH6y2qb5FHFQ5/ovNGMk3oUpNFw=;
 b=ltyBU1t7HZ3qIO6jg9Jfphp5bLDFjArmZKITbVl8ayqv+TO+dfY7qKqTPGES3MDjw8
 fHQEPVhxh8eLkmoqTKFtRnJZiXrqckt7Kfj5fQP01LMXlWcPDX89/3IZ5HJekHN2r89m
 xkX32vJ3dJjgupiPe+P1w3loxBSNzZP68x+L+7mDHLwjI8Ie/FEQsNpvGHwJ1UNmvkKt
 H02+fouSdqpD2mO3I1PaRRcVcP9St3GKfq8K59AsX9ssiRC13IZl9TABSGUGuX3bZT7v
 KC0U6DOBFnNv3XD0apv1jeRaDNtgAGGJJX1GqtEgfHqgiLusC+i53Je6yUJiyJiJIDjN
 kNjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=g7I0s4Lie1qYSELayH6y2qb5FHFQ5/ovNGMk3oUpNFw=;
 b=iJId2TG0dAoMByQutBiwWSpOzLjR4+6YlKiHjKiXH1qH9FWbqrHfmNrD9yHxxxgyq+
 3sZmLYzx1MJcA2ET5IhI0AaF8TJmMerSYrJKRbHV+4uF2gOMDdmcEWikB9+uJTGpSaEm
 nGVahclOE4tb5zBIWOYMxHIAu9BWwft2EVsy3jOwypqG3fe4mG9Cwg1VLtafQjg/EMI2
 XMyeVDVk2yOZvmfqtRuegiHzeIFzl4Y9TfV8dXOlo1Xe1TVBLbLFvaza7G6u+yC6Wg7l
 aEyr939ZPbvtBhI3MqE6gMv5O+lKjkGwgLU2wk6hPxOzzsT5m/5nHE9gmQwf2RHhIFXM
 JPtw==
X-Gm-Message-State: APjAAAU2mCA+GfPLeaVCy96UN3lTT58Fc+e1kTxHRbhW7r3zsywhCl/u
 OiJWkk5GmEj6YNuTnG0UbK2F9A==
X-Google-Smtp-Source: APXvYqwibsyRqFjS1/J9rPAhQLkzdJSO0xaTiwOhI9gtdsLH5cO2xxx10DPhCh1Pu1zAN3GWszZAYA==
X-Received: by 2002:adf:fe0f:: with SMTP id n15mr29857667wrr.343.1567629576119; 
 Wed, 04 Sep 2019 13:39:36 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id y3sm5604231wmg.2.2019.09.04.13.39.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Sep 2019 13:39:31 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id E8B691FFB1;
 Wed,  4 Sep 2019 21:30:15 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed,  4 Sep 2019 21:29:58 +0100
Message-Id: <20190904203013.9028-28-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190904203013.9028-1-alex.bennee@linaro.org>
References: <20190904203013.9028-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42a
Subject: [Qemu-devel] [PATCH v1 27/42] tests/docker: use --arch-only for
 installing deps
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
Cc: fam@euphon.net, berrange@redhat.com, stefanb@linux.vnet.ibm.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, f4bug@amsat.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, cota@braap.org,
 stefanha@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The Debian QEMU packages require a bunch of cross compilers for
building firmware which aren't available on all host architectures.
Using --arch-only skips this particular requirement and allows us to
install just the dependencies we need.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/docker/dockerfiles/debian-arm64-cross.docker    | 2 +-
 tests/docker/dockerfiles/debian-armel-cross.docker    | 2 +-
 tests/docker/dockerfiles/debian-armhf-cross.docker    | 2 +-
 tests/docker/dockerfiles/debian-mips-cross.docker     | 6 +++---
 tests/docker/dockerfiles/debian-mips64el-cross.docker | 2 +-
 tests/docker/dockerfiles/debian-mipsel-cross.docker   | 2 +-
 tests/docker/dockerfiles/debian-ppc64el-cross.docker  | 2 +-
 tests/docker/dockerfiles/debian-s390x-cross.docker    | 2 +-
 8 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/tests/docker/dockerfiles/debian-arm64-cross.docker b/tests/docker/dockerfiles/debian-arm64-cross.docker
index 55045ff5d5a..09ca0a1ba79 100644
--- a/tests/docker/dockerfiles/debian-arm64-cross.docker
+++ b/tests/docker/dockerfiles/debian-arm64-cross.docker
@@ -13,7 +13,7 @@ RUN apt update && \
         crossbuild-essential-arm64
 RUN apt update && \
     DEBIAN_FRONTEND=noninteractive eatmydata \
-    apt build-dep -yy -a arm64 qemu
+    apt build-dep -yy -a arm64 --arch-only qemu
 
 # Specify the cross prefix for this image (see tests/docker/common.rc)
 ENV QEMU_CONFIGURE_OPTS --cross-prefix=aarch64-linux-gnu-
diff --git a/tests/docker/dockerfiles/debian-armel-cross.docker b/tests/docker/dockerfiles/debian-armel-cross.docker
index 363a162a253..15378f8ea2c 100644
--- a/tests/docker/dockerfiles/debian-armel-cross.docker
+++ b/tests/docker/dockerfiles/debian-armel-cross.docker
@@ -11,7 +11,7 @@ RUN dpkg --add-architecture armel && \
     apt update && \
     apt install -yy crossbuild-essential-armel && \
     DEBIAN_FRONTEND=noninteractive eatmydata \
-    apt build-dep -yy -a armel qemu
+    apt build-dep -yy -a armel --arch-only qemu
 
 # Specify the cross prefix for this image (see tests/docker/common.rc)
 ENV QEMU_CONFIGURE_OPTS --cross-prefix=arm-linux-gnueabi-
diff --git a/tests/docker/dockerfiles/debian-armhf-cross.docker b/tests/docker/dockerfiles/debian-armhf-cross.docker
index d5365881e79..4a20af6fe1a 100644
--- a/tests/docker/dockerfiles/debian-armhf-cross.docker
+++ b/tests/docker/dockerfiles/debian-armhf-cross.docker
@@ -13,7 +13,7 @@ RUN apt update && \
         crossbuild-essential-armhf
 RUN apt update && \
     DEBIAN_FRONTEND=noninteractive eatmydata \
-    apt build-dep -yy -a armhf qemu
+    apt build-dep -yy -a armhf --arch-only qemu
 
 # Specify the cross prefix for this image (see tests/docker/common.rc)
 ENV QEMU_CONFIGURE_OPTS --cross-prefix=arm-linux-gnueabihf-
diff --git a/tests/docker/dockerfiles/debian-mips-cross.docker b/tests/docker/dockerfiles/debian-mips-cross.docker
index a54efa7253a..08a8e1c29cc 100644
--- a/tests/docker/dockerfiles/debian-mips-cross.docker
+++ b/tests/docker/dockerfiles/debian-mips-cross.docker
@@ -1,9 +1,9 @@
 #
 # Docker mips cross-compiler target
 #
-# This docker target builds on the debian Stretch base image.
+# This docker target builds on the debian Buster base image.
 #
-FROM qemu:debian9
+FROM qemu:debian10
 
 MAINTAINER Philippe Mathieu-Daudé <f4bug@amsat.org>
 
@@ -16,7 +16,7 @@ RUN apt update && \
 
 RUN apt update && \
     DEBIAN_FRONTEND=noninteractive eatmydata \
-    apt build-dep -yy -a mips qemu
+    apt build-dep -yy -a mips --arch-only qemu
 
 # Specify the cross prefix for this image (see tests/docker/common.rc)
 ENV QEMU_CONFIGURE_OPTS --cross-prefix=mips-linux-gnu-
diff --git a/tests/docker/dockerfiles/debian-mips64el-cross.docker b/tests/docker/dockerfiles/debian-mips64el-cross.docker
index a1481e16e2c..2fca1124053 100644
--- a/tests/docker/dockerfiles/debian-mips64el-cross.docker
+++ b/tests/docker/dockerfiles/debian-mips64el-cross.docker
@@ -17,7 +17,7 @@ RUN dpkg --add-architecture mips64el && \
 
 RUN apt update && \
     DEBIAN_FRONTEND=noninteractive eatmydata \
-    apt build-dep -yy -a mips64el qemu
+    apt build-dep -yy -a mips64el --arch-only qemu
 
 # Specify the cross prefix for this image (see tests/docker/common.rc)
 ENV QEMU_CONFIGURE_OPTS --cross-prefix=mips64el-linux-gnuabi64-
diff --git a/tests/docker/dockerfiles/debian-mipsel-cross.docker b/tests/docker/dockerfiles/debian-mipsel-cross.docker
index 88accad2692..4abf7832ac6 100644
--- a/tests/docker/dockerfiles/debian-mipsel-cross.docker
+++ b/tests/docker/dockerfiles/debian-mipsel-cross.docker
@@ -16,7 +16,7 @@ RUN apt update && \
 
 RUN apt update && \
     DEBIAN_FRONTEND=noninteractive eatmydata \
-    apt build-dep -yy -a mipsel qemu
+    apt build-dep -yy -a mipsel --arch-only qemu
 
 # Specify the cross prefix for this image (see tests/docker/common.rc)
 ENV QEMU_CONFIGURE_OPTS --cross-prefix=mipsel-linux-gnu-
diff --git a/tests/docker/dockerfiles/debian-ppc64el-cross.docker b/tests/docker/dockerfiles/debian-ppc64el-cross.docker
index f10883c8188..9973df9ff74 100644
--- a/tests/docker/dockerfiles/debian-ppc64el-cross.docker
+++ b/tests/docker/dockerfiles/debian-ppc64el-cross.docker
@@ -12,7 +12,7 @@ RUN dpkg --add-architecture ppc64el && \
 
 RUN apt update && \
     DEBIAN_FRONTEND=noninteractive eatmydata \
-    apt build-dep -yy -a ppc64el qemu
+    apt build-dep -yy -a ppc64el --arch-only qemu
 
 # Specify the cross prefix for this image (see tests/docker/common.rc)
 ENV QEMU_CONFIGURE_OPTS --cross-prefix=powerpc64le-linux-gnu-
diff --git a/tests/docker/dockerfiles/debian-s390x-cross.docker b/tests/docker/dockerfiles/debian-s390x-cross.docker
index efa346007d6..eb73c988559 100644
--- a/tests/docker/dockerfiles/debian-s390x-cross.docker
+++ b/tests/docker/dockerfiles/debian-s390x-cross.docker
@@ -17,7 +17,7 @@ RUN apt update && \
 
 RUN apt update && \
     DEBIAN_FRONTEND=noninteractive eatmydata \
-    apt build-dep -yy -a s390x qemu
+    apt build-dep -yy -a s390x --arch-only qemu
 
 # Specify the cross prefix for this image (see tests/docker/common.rc)
 ENV QEMU_CONFIGURE_OPTS --cross-prefix=s390x-linux-gnu-
-- 
2.20.1


