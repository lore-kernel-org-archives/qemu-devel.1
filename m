Return-Path: <SRS0=r3/N=VJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6F3BC742B3
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 11:20:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8689920863
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 11:20:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AeqRCv5z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8689920863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48343 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hltbQ-0007X0-Pa
	for qemu-devel@archiver.kernel.org; Fri, 12 Jul 2019 07:20:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47197)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hltZq-0000Md-2F
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 07:18:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hltZo-0000MZ-5H
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 07:18:57 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:51715)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hltZn-0000Lo-UW
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 07:18:56 -0400
Received: by mail-wm1-x341.google.com with SMTP id 207so8575446wma.1
 for <qemu-devel@nongnu.org>; Fri, 12 Jul 2019 04:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=uxO/GL57CmfBOp81fuME+ZYWSe7cMxt6tIgwW6mb2xA=;
 b=AeqRCv5zYpzuCpTJpMg7tmsUzpH5yye7pkF5GYa61o1WxdaGWI7H0k4dPG8sRzYx+B
 cBA7ZapTxvUgmZi3O6IoBDrESXlinoRs65ZHTElSv1FGc7G7Xklptq7zeL/hAvzC4ptF
 SaQGDjPfLq4BAVGH5Zgzf+lLVXJnvJjC/f57h6veat7zYp2T5wdnfkxwz2/7+XdL4gFn
 AT4h4aW5P1PxVPiapv6s2LIKDYfacsgpWOWeM986yQmFM8jSIczVeJGo8H8ZbG0iTPM9
 a8A+s6LsQV4aolS0VWaAI1sHBKMWbMhk8oIL+M6aK7Z/k6u/uQ3MOlgto5QPM8ECPThb
 eB0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=uxO/GL57CmfBOp81fuME+ZYWSe7cMxt6tIgwW6mb2xA=;
 b=DQnTBx/L8XhnHE7e9mOG2D9Km23aKp1VQjHGnHrS+xVrULs5dzWulNM/i4uvQrXaZf
 QokOG5fP7QdoBEVdevMilt4pLMn0SNKYrnEm4RDBXNqqfp98g//1s6fprkzGplH+d93Q
 JERxcWCdE9M82L3/66oVASz8oR8I61DiZ/I7jYbnui6fmThsaaZu7835bob21XxzOPou
 oeg137mqMDm/6udoFadjSc0Lw9bO6q0SrqLRre0WM0B/jcjbulAPeSgpL4G2O/0D6iGA
 RGH86lQdhYrheBDV6ASfD5JJVxambrFZucaO8NJKYmnAY0rZZTdh9cXya2EzBHN/aMUd
 gGhQ==
X-Gm-Message-State: APjAAAUuaPdWN+r5EQk62ffXjoFbLQV7wYblmeabV1paMYcRhB14p1Hu
 gOT+e5MY+/j/jz1/ozdcCFePSw==
X-Google-Smtp-Source: APXvYqybWaXczfPjz5jKdUjkTpGgneEcURT4DGdkn4n+drO/4JwfeZ5YGQyTahr+GnwfhlrT6OqNvw==
X-Received: by 2002:a1c:d10c:: with SMTP id i12mr9453099wmg.152.1562930334719; 
 Fri, 12 Jul 2019 04:18:54 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id 32sm5552970wrh.76.2019.07.12.04.18.51
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 12 Jul 2019 04:18:51 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id D2C321FF93;
 Fri, 12 Jul 2019 12:18:50 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 12 Jul 2019 12:18:48 +0100
Message-Id: <20190712111849.9006-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190712111849.9006-1-alex.bennee@linaro.org>
References: <20190712111849.9006-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
Subject: [Qemu-devel] [PATCH v1 6/7] tests/dockerfiles: update the win cross
 builds to stretch
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
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-arm@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

While fixing up pkg.mxe.cc they move the URLs around a bit and dropped
Jessie support in favour of Stretch. We also need to update the keys
used to verify the packages.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/docker/Makefile.include                         |  6 +++---
 tests/docker/dockerfiles/debian-win32-cross.docker    |  4 ++--
 tests/docker/dockerfiles/debian-win64-cross.docker    |  4 ++--
 .../{debian8-mxe.docker => debian9-mxe.docker}        | 11 +++++++----
 4 files changed, 14 insertions(+), 11 deletions(-)
 rename tests/docker/dockerfiles/{debian8-mxe.docker => debian9-mxe.docker} (56%)

diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index aaf5396b85d..dbd58e548c1 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -85,7 +85,7 @@ endif
 
 # Enforce dependencies for composite images
 docker-image-debian: docker-image-debian9
-docker-image-debian8-mxe: docker-image-debian8
+docker-image-debian9-mxe: docker-image-debian9
 docker-image-debian-amd64: docker-image-debian9
 docker-image-debian-armel-cross: docker-image-debian9
 docker-image-debian-armhf-cross: docker-image-debian9
@@ -96,8 +96,8 @@ docker-image-debian-mipsel-cross: docker-image-debian9
 docker-image-debian-mips64el-cross: docker-image-debian9
 docker-image-debian-ppc64el-cross: docker-image-debian9
 docker-image-debian-s390x-cross: docker-image-debian9
-docker-image-debian-win32-cross: docker-image-debian8-mxe
-docker-image-debian-win64-cross: docker-image-debian8-mxe
+docker-image-debian-win32-cross: docker-image-debian9-mxe
+docker-image-debian-win64-cross: docker-image-debian9-mxe
 
 docker-image-debian-alpha-cross: docker-image-debian-sid
 docker-image-debian-hppa-cross: docker-image-debian-sid
diff --git a/tests/docker/dockerfiles/debian-win32-cross.docker b/tests/docker/dockerfiles/debian-win32-cross.docker
index 0a4970c0683..c787e432454 100644
--- a/tests/docker/dockerfiles/debian-win32-cross.docker
+++ b/tests/docker/dockerfiles/debian-win32-cross.docker
@@ -1,9 +1,9 @@
 #
 # Docker mingw32 cross-compiler target
 #
-# This docker target builds on the debian Jessie MXE base image.
+# This docker target builds on the debian Stretch MXE base image.
 #
-FROM qemu:debian8-mxe
+FROM qemu:debian9-mxe
 
 MAINTAINER Philippe Mathieu-Daudé <f4bug@amsat.org>
 
diff --git a/tests/docker/dockerfiles/debian-win64-cross.docker b/tests/docker/dockerfiles/debian-win64-cross.docker
index b27985b1b1f..a7068ed6ac6 100644
--- a/tests/docker/dockerfiles/debian-win64-cross.docker
+++ b/tests/docker/dockerfiles/debian-win64-cross.docker
@@ -1,9 +1,9 @@
 #
 # Docker mingw64 cross-compiler target
 #
-# This docker target builds on the debian Jessie MXE base image.
+# This docker target builds on the debian Stretch MXE base image.
 #
-FROM qemu:debian8-mxe
+FROM qemu:debian9-mxe
 
 MAINTAINER Philippe Mathieu-Daudé <f4bug@amsat.org>
 
diff --git a/tests/docker/dockerfiles/debian8-mxe.docker b/tests/docker/dockerfiles/debian9-mxe.docker
similarity index 56%
rename from tests/docker/dockerfiles/debian8-mxe.docker
rename to tests/docker/dockerfiles/debian9-mxe.docker
index 2df4cc8c5c9..5bc8a6d5c36 100644
--- a/tests/docker/dockerfiles/debian8-mxe.docker
+++ b/tests/docker/dockerfiles/debian9-mxe.docker
@@ -1,15 +1,18 @@
 #
 # Docker mingw cross-compiler target
 #
-# This docker target builds on the debian Jessie base image.
+# This docker target builds on the debian Stretch base image.
 #
-FROM qemu:debian8
+FROM qemu:debian9
 
 MAINTAINER Philippe Mathieu-Daudé <f4bug@amsat.org>
 
+RUN DEBIAN_FRONTEND=noninteractive eatmydata \
+    apt install -y --no-install-recommends gnupg dirmngr
+
 # Add the foreign architecture we want and install dependencies
-RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys D43A795B73B16ABE9643FE1AFD8FFF16DB45C6AB && \
-    echo "deb http://pkg.mxe.cc/repos/apt/debian jessie main" > /etc/apt/sources.list.d/mxeapt.list
+RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys C6BF758A33A3A276 && \
+    echo "deb http://pkg.mxe.cc/repos/apt stretch main" > /etc/apt/sources.list.d/mxeapt.list
 RUN apt-get update
 RUN DEBIAN_FRONTEND=noninteractive eatmydata \
     apt-get install -y --no-install-recommends \
-- 
2.20.1


