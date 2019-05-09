Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57D2DC04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 17:01:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21636216C4
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 17:01:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RkifXN5H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21636216C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57997 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOmQ6-0008LX-CY
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 13:01:22 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49477)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hOmO4-0006w0-KO
	for qemu-devel@nongnu.org; Thu, 09 May 2019 12:59:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hOmO3-0004pm-K0
	for qemu-devel@nongnu.org; Thu, 09 May 2019 12:59:16 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c]:51419)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hOmO3-0004pI-CT
	for qemu-devel@nongnu.org; Thu, 09 May 2019 12:59:15 -0400
Received: by mail-wm1-x32c.google.com with SMTP id o189so4179425wmb.1
	for <qemu-devel@nongnu.org>; Thu, 09 May 2019 09:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=GPWkl0UZnL+LwntGtFPT1SPNtCHAc7QYKT2apLIn060=;
	b=RkifXN5H2o81L7Q9CxT0Xoqgl3MzoHci0nTItRsIciLS7azOnmr3X20Xt/KuPKBrUQ
	cxSspFNBCB6rEfrvEiKYPhbNkHO3bFnRcz9TaS987NbrKb38ar5vxV1akgUsuCgRgWGN
	Syq9EuqYWTrA5A/xeYQKEfN1t3qWxCxxHmaECqX5Dwy8Wow6AYKXVcp99SZw+7+dG6r4
	qqq6qnb4EROqOhfK7P4cRydnJMj7VPk/vnHHsbLjY+0M4KTPp7YDg4AOoasU4Y9aiQ2z
	QgDVe8fvNGor7Hj9iiD2pFCefOBoUULtYCQxVbCx35z8lPLEZ0zp5rcsEt6V+JmoSgBS
	ofRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=GPWkl0UZnL+LwntGtFPT1SPNtCHAc7QYKT2apLIn060=;
	b=jgbL6gw2zrLaisz7qGklbVtI3TlTEsP+vyVE5LT2/Tcv8HVBBgQ2cc/CBbLGC3SCPJ
	qhmgyIT7VgpOwfdF3dYlS93GC0Ce1gP/Um5HRV2pII/NB7wqrCeYHvpfcsY6WpO2ZvBV
	Sr3inScGP5aT3ri+c8mlVV0lXfsXJdLtEa92KHmKKznklsbouMLpjb7/9afibpPftYU8
	ijChHTZKs5GeWDCjM0DTpbrKg6LnE8sasL+3QRm6oJTE8ZE5BDexZHznf4ztBsCiEySy
	dGsB5zTPA9u4r1tFHkjDRmMbJUhE78voJdBNIfoVL2MitMQEbCcqhKjLtiNXa0HWw0Z5
	0ZQg==
X-Gm-Message-State: APjAAAUzGREPRubEzAIpan7GyN3NMb9ARmsQbsMB04w0tv9Tbd7V3wxe
	WQh2uoYy5fTGoNaqQmMyr2q2Uw==
X-Google-Smtp-Source: APXvYqxO4mrI+IZ8G6oo79UFvT+XfLjPHMDH6jzJuMPF67uoLomgBv+RNp5fRpIFDhvOsJkZVejksw==
X-Received: by 2002:a7b:c3da:: with SMTP id t26mr3875216wmj.40.1557421154104; 
	Thu, 09 May 2019 09:59:14 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id
	e16sm3494812wrw.24.2019.05.09.09.59.12
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 09 May 2019 09:59:12 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id 1F4D41FF8C;
	Thu,  9 May 2019 17:59:12 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu,  9 May 2019 17:58:49 +0100
Message-Id: <20190509165912.10512-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190509165912.10512-1-alex.bennee@linaro.org>
References: <20190509165912.10512-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::32c
Subject: [Qemu-devel] [PATCH  v1 01/23] tests/docker: add ubuntu 18.04
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
Cc: Fam Zheng <fam@euphon.net>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
	qemu-arm@nongnu.org,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Gerd Hoffmann <kraxel@redhat.com>

Based on the ubuntu.docker file.
Used to reproduce the build failure Peter was seeing.
Others might find this useful too ;)

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Message-Id: <20190503070241.24786-1-kraxel@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/docker/dockerfiles/ubuntu1804.docker | 57 ++++++++++++++++++++++
 1 file changed, 57 insertions(+)
 create mode 100644 tests/docker/dockerfiles/ubuntu1804.docker

diff --git a/tests/docker/dockerfiles/ubuntu1804.docker b/tests/docker/dockerfiles/ubuntu1804.docker
new file mode 100644
index 00000000000..2e2900150b0
--- /dev/null
+++ b/tests/docker/dockerfiles/ubuntu1804.docker
@@ -0,0 +1,57 @@
+FROM ubuntu:18.04
+ENV PACKAGES flex bison \
+    ccache \
+    clang \
+    gcc \
+    gettext \
+    git \
+    glusterfs-common \
+    libaio-dev \
+    libattr1-dev \
+    libbluetooth-dev \
+    libbrlapi-dev \
+    libbz2-dev \
+    libcacard-dev \
+    libcap-dev \
+    libcap-ng-dev \
+    libcurl4-gnutls-dev \
+    libdrm-dev \
+    libepoxy-dev \
+    libfdt-dev \
+    libgbm-dev \
+    libgtk-3-dev \
+    libibverbs-dev \
+    libiscsi-dev \
+    libjemalloc-dev \
+    libjpeg-turbo8-dev \
+    liblzo2-dev \
+    libncurses5-dev \
+    libncursesw5-dev \
+    libnfs-dev \
+    libnss3-dev \
+    libnuma-dev \
+    libpixman-1-dev \
+    librados-dev \
+    librbd-dev \
+    librdmacm-dev \
+    libsasl2-dev \
+    libsdl2-dev \
+    libseccomp-dev \
+    libsnappy-dev \
+    libspice-protocol-dev \
+    libspice-server-dev \
+    libssh2-1-dev \
+    libusb-1.0-0-dev \
+    libusbredirhost-dev \
+    libvdeplug-dev \
+    libvte-2.91-dev \
+    libxen-dev \
+    make \
+    python-yaml \
+    sparse \
+    texinfo \
+    xfslibs-dev
+RUN apt-get update && \
+    apt-get -y install $PACKAGES
+RUN dpkg -l $PACKAGES | sort > /packages.txt
+ENV FEATURES clang pyyaml sdl2
-- 
2.20.1


