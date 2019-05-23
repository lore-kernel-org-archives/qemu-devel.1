Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B151C282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 10:56:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BEDE20868
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 10:56:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BYBFYJlx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BEDE20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33602 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTlOn-0006Ym-Dm
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 06:56:37 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52137)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hTl2r-0004U5-FU
	for qemu-devel@nongnu.org; Thu, 23 May 2019 06:33:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hTl2q-0006hG-FI
	for qemu-devel@nongnu.org; Thu, 23 May 2019 06:33:57 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:37054)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hTl2o-0006dJ-FE
	for qemu-devel@nongnu.org; Thu, 23 May 2019 06:33:55 -0400
Received: by mail-wm1-x341.google.com with SMTP id 7so5224145wmo.2
	for <qemu-devel@nongnu.org>; Thu, 23 May 2019 03:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=xuuMnNMpb8Xfi2k7UTaye3/+aCNPdHNH8EZgGhe/xVw=;
	b=BYBFYJlxprKmCCsen8TmgK142cSTMkLUIQb5qqFJq0t6kSdYZ85XDCSueq4uBAhLSL
	piGlLpifau8XKmqwxKXPl2fm+yDhRj77OKas4CKR1YEeAFD+EomgUDACuPJ/dghCCplq
	/dzqPJlpFPdVc8PDuC3PFk6R7O6ZS0TCj6bensWWTN/zMvFpB6ScXwTkkAQx+JJIDhLF
	A3x7aiCIuiwCw4Ozk46wAl/S+pduc+BEEw6UFNu8+/yBL4+3u2mMzJprkBd/cLA8Wo4n
	2Yd6h8FALkqNF+BO23vYyIJYeRJqxAojJptwwpOkGPdG++3YtprRfwJXsgqA+Uf0owwU
	/VtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=xuuMnNMpb8Xfi2k7UTaye3/+aCNPdHNH8EZgGhe/xVw=;
	b=crAoodWXvFdhdTBYkI+uAtWjvtE1HtoMk4xP+ysfVBugxxLM6oElj+w204smcKt4Ty
	/+LjVU7IV+KEW8EPn0F3WeCejsF0Pk/1NHR+PcxDkksShTWk/ude1tDJNgJxlne0nFwG
	WiWleU4sRpI8qO7NVrcMh1WjjWflRW+NcvpQFWDbcGOt+Sy3iZ3aN6VkoUA5ImV71xx4
	XqjxH/rgMzAedeK40PuM5i+4JJY6dQ5HL9rXhLQBQgQf/2cIw7xR/SxxhA1o/sG6GAYn
	5323aopY9FcSuAfREIT9xjK8o7iYobcEb2LkJSTO4Ck4HhsVIfXoyZohr4nccYWy9zW6
	pQrQ==
X-Gm-Message-State: APjAAAX4qX3MJaZvci7E5A4s1jXnvqK7WohE5D92iAl3FxFRs9sWsOYk
	wWiUJusd/xa5M0AmFT+qcQ9AFQ==
X-Google-Smtp-Source: APXvYqyJWBnU3PZ06gqlap+TH01YZOeSjxihYgza3Hri1PSHV8oD9ZyeIdFmm4HQivQVdoLvr4ETtQ==
X-Received: by 2002:a7b:cd12:: with SMTP id f18mr5791043wmj.103.1558607630142; 
	Thu, 23 May 2019 03:33:50 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id 74sm10695056wma.7.2019.05.23.03.33.44
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 23 May 2019 03:33:47 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id 86F721FF9B;
	Thu, 23 May 2019 11:25:33 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu, 23 May 2019 11:25:16 +0100
Message-Id: <20190523102532.10486-13-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190523102532.10486-1-alex.bennee@linaro.org>
References: <20190523102532.10486-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::341
Subject: [Qemu-devel] [PATCH  v2 12/28] tests/docker: add ubuntu 18.04
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
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
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


