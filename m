Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87EECC3524D
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 09:12:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5407B2070A
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 09:12:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cFHxV070"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5407B2070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36594 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyXlw-0002xz-HU
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 04:12:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47631)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iyXjd-0006Rs-S0
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 04:09:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iyXjc-0000ic-FH
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 04:09:37 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:34608)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iyXjc-0000er-8j
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 04:09:36 -0500
Received: by mail-wr1-x441.google.com with SMTP id t2so16938975wrr.1
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2020 01:09:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=5Ix6KVpJPiwz6TJROnAmKF1sUq14DFJOadiZtwholtY=;
 b=cFHxV070oE/62TtvOMSssEG/z5QGrHEfMukLqxcjvxN7kOO4p0zxOXCRf/BlJQ37Ey
 NWjPgfkHBuTQ/SRH1stHjqLXvCIEAAt0+QQ2AhGpLbdFf5XpMvWiXxeh7y4pl7ulk7aF
 bj0lIp0VQHv/xYsPLGvme2fpZjO8sFlS3/g34tXD9bOWuL1n6A72zoRK9FhX9Q2yHiwo
 eQ9kt0f7t3X35jX9O0rcnuwrNEp0cG59Kd4AlvJ4b1bF8RW0Wapj9+uUavCXPzY2cyRs
 ONA9jKT8SJEw8hhEgz/8Zp8B6x2gsIZiMahTQY/tXi84vu9wvrMXvbKOYzTHBvv0saqS
 hnSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=5Ix6KVpJPiwz6TJROnAmKF1sUq14DFJOadiZtwholtY=;
 b=YiaLGiTspLe/GcFZ6OfiL6G6T9npWvGPbK1aSB1l6bNp3E20A1QVnUwwqOfZlqT5EK
 rnNVRhVlNgn9+YS8aOifqQwEMl0xgy5SfqJIBFWWi4RK3c50ZbSaikXZJwUtfenwxHE1
 0T2/leThIqjcAaiw+KZRBrffT04HgsCMiOOWEUpqP9GjBf8YpF4Vrxo/ciFolLIabFYE
 S1NC9NbSFbmRuJpv6tzOWo4SMoZ1N2UnrVtw1lxjxP+GjmAKm9V8huAIAv5SktEpPXN/
 YtZ15DpsehBRZRIdnlzrEeHP3XBXJa7EXt8BMKUuZN6Pk/vlS6qOKdCjsVoYG4zSdL4w
 GaQg==
X-Gm-Message-State: APjAAAWixQAdMsbiTV28nS9sii/g+ff/4GtHEjJ+VFmvUM2I2g3xHe4D
 te4MGBrB7/6zOBiWrKrFE317gQ==
X-Google-Smtp-Source: APXvYqyZ57p8mbojvVQdpHUNEzGUPXZTyAMN0PeWqGQnU1AXdP2EVSpb0inVjvsL7UkpRKzisVNH+A==
X-Received: by 2002:adf:fe4d:: with SMTP id m13mr14908180wrs.179.1580720975224; 
 Mon, 03 Feb 2020 01:09:35 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id x6sm22125328wmi.44.2020.02.03.01.09.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2020 01:09:33 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 6F4AF1FF8C;
 Mon,  3 Feb 2020 09:09:32 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 01/17] tests/docker: move most cross compilers to buster
 base
Date: Mon,  3 Feb 2020 09:09:16 +0000
Message-Id: <20200203090932.19147-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200203090932.19147-1-alex.bennee@linaro.org>
References: <20200203090932.19147-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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

This includes fixing up the dependencies (Which were already wrong for
one of the mips variants).

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 tests/docker/Makefile.include                    | 16 ++++++++--------
 tests/docker/dockerfiles/debian-amd64.docker     |  2 +-
 .../docker/dockerfiles/debian-armel-cross.docker |  2 +-
 .../docker/dockerfiles/debian-armhf-cross.docker |  2 +-
 .../dockerfiles/debian-mips64el-cross.docker     |  2 +-
 .../dockerfiles/debian-mipsel-cross.docker       |  2 +-
 .../dockerfiles/debian-ppc64el-cross.docker      |  2 +-
 .../docker/dockerfiles/debian-s390x-cross.docker |  2 +-
 8 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index 19dbe261699..43a86786882 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -91,19 +91,12 @@ endif
 # Enforce dependencies for composite images
 docker-image-debian9-mxe: docker-image-debian9
 ifeq ($(HOST_ARCH),x86_64)
-docker-image-debian-amd64: docker-image-debian9
+docker-image-debian-amd64: docker-image-debian10
 DOCKER_PARTIAL_IMAGES += debian-amd64-cross
 else
 docker-image-debian-amd64-cross: docker-image-debian10
 DOCKER_PARTIAL_IMAGES += debian-amd64
 endif
-docker-image-debian-armel-cross: docker-image-debian9
-docker-image-debian-armhf-cross: docker-image-debian9
-docker-image-debian-mips-cross: docker-image-debian9
-docker-image-debian-mipsel-cross: docker-image-debian9
-docker-image-debian-mips64el-cross: docker-image-debian9
-docker-image-debian-ppc64el-cross: docker-image-debian9
-docker-image-debian-s390x-cross: docker-image-debian9
 docker-image-debian-win32-cross: docker-image-debian9-mxe
 docker-image-debian-win64-cross: docker-image-debian9-mxe
 
@@ -118,12 +111,19 @@ endif
 
 docker-image-debian-alpha-cross: docker-image-debian10
 docker-image-debian-arm64-cross: docker-image-debian10
+docker-image-debian-armel-cross: docker-image-debian10
+docker-image-debian-armhf-cross: docker-image-debian10
 docker-image-debian-hppa-cross: docker-image-debian10
 docker-image-debian-m68k-cross: docker-image-debian10
+docker-image-debian-mips-cross: docker-image-debian10
 docker-image-debian-mips64-cross: docker-image-debian10
+docker-image-debian-mips64el-cross: docker-image-debian10
+docker-image-debian-mipsel-cross: docker-image-debian10
 docker-image-debian-powerpc-cross: docker-image-debian10
 docker-image-debian-ppc64-cross: docker-image-debian10
+docker-image-debian-ppc64el-cross: docker-image-debian10
 docker-image-debian-riscv64-cross: docker-image-debian10
+docker-image-debian-s390x-cross: docker-image-debian10
 docker-image-debian-sh4-cross: docker-image-debian10
 docker-image-debian-sparc64-cross: docker-image-debian10
 
diff --git a/tests/docker/dockerfiles/debian-amd64.docker b/tests/docker/dockerfiles/debian-amd64.docker
index 431e947ebd5..3b860af1068 100644
--- a/tests/docker/dockerfiles/debian-amd64.docker
+++ b/tests/docker/dockerfiles/debian-amd64.docker
@@ -4,7 +4,7 @@
 # This docker target builds on the debian Stretch base image. Further
 # libraries which are not widely available are installed by hand.
 #
-FROM qemu:debian9
+FROM qemu:debian10
 MAINTAINER Philippe Mathieu-Daudé <f4bug@amsat.org>
 
 RUN apt update && \
diff --git a/tests/docker/dockerfiles/debian-armel-cross.docker b/tests/docker/dockerfiles/debian-armel-cross.docker
index 15378f8ea2c..e3794a61c95 100644
--- a/tests/docker/dockerfiles/debian-armel-cross.docker
+++ b/tests/docker/dockerfiles/debian-armel-cross.docker
@@ -3,7 +3,7 @@
 #
 # This docker target builds on the debian Stretch base image.
 #
-FROM qemu:debian9
+FROM qemu:debian10
 MAINTAINER Philippe Mathieu-Daudé <f4bug@amsat.org>
 
 # Add the foreign architecture we want and install dependencies
diff --git a/tests/docker/dockerfiles/debian-armhf-cross.docker b/tests/docker/dockerfiles/debian-armhf-cross.docker
index 4a20af6fe1a..e163b8b9569 100644
--- a/tests/docker/dockerfiles/debian-armhf-cross.docker
+++ b/tests/docker/dockerfiles/debian-armhf-cross.docker
@@ -3,7 +3,7 @@
 #
 # This docker target builds on the debian Stretch base image.
 #
-FROM qemu:debian9
+FROM qemu:debian10
 
 # Add the foreign architecture we want and install dependencies
 RUN dpkg --add-architecture armhf
diff --git a/tests/docker/dockerfiles/debian-mips64el-cross.docker b/tests/docker/dockerfiles/debian-mips64el-cross.docker
index 2fca1124053..453b53ef72c 100644
--- a/tests/docker/dockerfiles/debian-mips64el-cross.docker
+++ b/tests/docker/dockerfiles/debian-mips64el-cross.docker
@@ -4,7 +4,7 @@
 # This docker target builds on the debian Stretch base image.
 #
 
-FROM qemu:debian9
+FROM qemu:debian10
 
 MAINTAINER Philippe Mathieu-Daudé <f4bug@amsat.org>
 
diff --git a/tests/docker/dockerfiles/debian-mipsel-cross.docker b/tests/docker/dockerfiles/debian-mipsel-cross.docker
index 4abf7832ac6..3b6e975c686 100644
--- a/tests/docker/dockerfiles/debian-mipsel-cross.docker
+++ b/tests/docker/dockerfiles/debian-mipsel-cross.docker
@@ -3,7 +3,7 @@
 #
 # This docker target builds on the debian Stretch base image.
 #
-FROM qemu:debian9
+FROM qemu:debian10
 
 MAINTAINER Philippe Mathieu-Daudé <f4bug@amsat.org>
 
diff --git a/tests/docker/dockerfiles/debian-ppc64el-cross.docker b/tests/docker/dockerfiles/debian-ppc64el-cross.docker
index 9973df9ff74..cd386f01d93 100644
--- a/tests/docker/dockerfiles/debian-ppc64el-cross.docker
+++ b/tests/docker/dockerfiles/debian-ppc64el-cross.docker
@@ -3,7 +3,7 @@
 #
 # This docker target builds on the debian Stretch base image.
 #
-FROM qemu:debian9
+FROM qemu:debian10
 
 # Add the foreign architecture we want and install dependencies
 RUN dpkg --add-architecture ppc64el && \
diff --git a/tests/docker/dockerfiles/debian-s390x-cross.docker b/tests/docker/dockerfiles/debian-s390x-cross.docker
index eb73c988559..43fe59836f2 100644
--- a/tests/docker/dockerfiles/debian-s390x-cross.docker
+++ b/tests/docker/dockerfiles/debian-s390x-cross.docker
@@ -3,7 +3,7 @@
 #
 # This docker target builds on the debian Stretch base image.
 #
-FROM qemu:debian9
+FROM qemu:debian10
 
 # Add the s390x architecture
 RUN dpkg --add-architecture s390x
-- 
2.20.1


