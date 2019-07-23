Return-Path: <SRS0=3Ld+=VU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F6ABC7618B
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 10:38:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C85D21655
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 10:38:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hYyChAPV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C85D21655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41022 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpsBO-0004qA-3V
	for qemu-devel@archiver.kernel.org; Tue, 23 Jul 2019 06:38:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37825)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hps9e-0005ur-1B
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 06:36:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hps9c-0007P4-IZ
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 06:36:21 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334]:37894)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hps9c-0007OG-BU
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 06:36:20 -0400
Received: by mail-wm1-x334.google.com with SMTP id s15so16670197wmj.3
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2019 03:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=eyW47wPZQjsYoqu7XDv4Zff5+db4gOrr6waWGJroE1g=;
 b=hYyChAPVosqUzvnU0FuhghhtkweI/DOLQNcgqrLSCgH1U0T/orzZQX6cafxQToANS4
 5RHu3htbPa3o3hlzRs45mhMNWc0rhXGsjSO0Do8QzsSCPDNscwAHrf0e5hlZjHVelEi4
 I08oMEsaJH+Iik3zwG1iNfvZtltBrxCidSmaK97KQTPGQ0yf50ihzYIs71wFNIyS3QhG
 gO72tpJfRkbkLk8Lv4H/UMGPD0C9uQEaknHasPWfx43UdhbpVxSTRggw6b5XclqO03t+
 OpQANtuNVJ0C3k1jP56/omtk77BqqUSQqij1fnRWL9LO4gIeHCz0pYuscxMwZABwMGvS
 as+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=eyW47wPZQjsYoqu7XDv4Zff5+db4gOrr6waWGJroE1g=;
 b=R1LqD145S26qnYTKhoLdDidwZRYNI0N8u9XTiFDhIz5GBNgM0dgdQvHmcGQd+lrsP8
 zG/+Az2Z8/56jJNd6ZzhD/UfNVJQvdN6cydF6g3J5Nkr0srVTJPis9/BF/Vd8TZCnv8z
 F/I/jq59FtcHHyIvhcTNuzAU5x9AGjtFG0yrLR82sBB1I4Hc0OQ6ABf6m6gtaNuzih3l
 /EUENktlK3npQ8DvBENVSzVLJHGWjpBg2Tig4y35pmONQHBGI4aDjMpMIKofafPuVVny
 SiPYhFFrpeFAxf5mNLGBB8K9IZAKm1aHaH2uPgzuEFD3FjDlHhJH+Th40OXydYHqw6w4
 lI0g==
X-Gm-Message-State: APjAAAUL1UR/lp8wmTdKqDdMf3PG7CLxQtyi1eUgbJjxMBP0+5YDQV5Y
 TW8igmGmwAmf3kJjr+aKlr/p5g==
X-Google-Smtp-Source: APXvYqwKH+5T0YVesMD7NVZxGoPLVMedBz2l0G84G48YlghC5NYZtGMU446U4dnuToSboofZZGA+ow==
X-Received: by 2002:a1c:968c:: with SMTP id y134mr67331440wmd.75.1563878179139; 
 Tue, 23 Jul 2019 03:36:19 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id a84sm50325743wmf.29.2019.07.23.03.36.14
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 23 Jul 2019 03:36:14 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 0310E1FF96;
 Tue, 23 Jul 2019 11:36:13 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Date: Tue, 23 Jul 2019 11:35:56 +0100
Message-Id: <20190723103612.5600-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190723103612.5600-1-alex.bennee@linaro.org>
References: <20190723103612.5600-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::334
Subject: [Qemu-devel] [PULL 07/23] tests/dockerfiles: update the win cross
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
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

While fixing up pkg.mxe.cc they move the URLs around a bit and dropped
Jessie support in favour of Stretch. We also need to update the keys
used to verify the packages.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

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


