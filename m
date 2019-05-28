Return-Path: <SRS0=2W3W=T4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D122DC04AB6
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 10:03:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A4BD208CB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 10:03:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="el0FdrJ7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A4BD208CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60130 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVYxA-0000iO-Nw
	for qemu-devel@archiver.kernel.org; Tue, 28 May 2019 06:03:32 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40907)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hVYkC-0006KB-68
	for qemu-devel@nongnu.org; Tue, 28 May 2019 05:50:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hVYkB-0000Ce-72
	for qemu-devel@nongnu.org; Tue, 28 May 2019 05:50:08 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333]:51337)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hVYkB-00007r-16
	for qemu-devel@nongnu.org; Tue, 28 May 2019 05:50:07 -0400
Received: by mail-wm1-x333.google.com with SMTP id f10so2142887wmb.1
	for <qemu-devel@nongnu.org>; Tue, 28 May 2019 02:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=AVe13N12Qyr3X7QnGmWrUiMxH2ipPSHqjdNskm5lzV0=;
	b=el0FdrJ7SxwziN4+YFvmUStwfKZRmqIsc2v00/G+LpRDf7ts1sCVkVRhiIjj4m4xzW
	mmjIpp1jtCQMt0NrC/drHOlpIh6V+h2QxMoJPrZsOkx4TAFWZAMACn8SlnyLciBbSKQr
	8lzB65VjT4/bia1WEnGKYiDYVk4lMwpYDzD5DAjqJd+6HNNZ9gfgKaJLS0OZNKXlvg2P
	9PGKc/buRM5WaD4kXxgunw7Mn1hbk14e6gZuYAEG69yonkbYT9ck5P4/nAlw9WJb1sSy
	NGIU9+uxEqG8i09gxO+EfZTnLgBIhzOUGILxR5BqYmXGifwtCzmJhQU6mLwP3y9Mdp1Z
	XyTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=AVe13N12Qyr3X7QnGmWrUiMxH2ipPSHqjdNskm5lzV0=;
	b=YQPpI3d+f8fXPNC5xpSHYR7guQ1pN1TkuujI+H8QDRAGWkztSBxKGNwY1eN0JVxhH7
	tmCryFZMcEAhszvkm7PNedZCM7I/y2aPEjOzKZ8SuBDPtOeL/COvsdZ7P81+CPhJXdFQ
	jQBfGOSRlFtw1VIJkSkWO6+QiEEODS89eEm4IXN/oDTryaqVz+N6a0MhDcsRgTFgMD1L
	nMkEpq8CcEi8AmVG1ntsnSHJYxq5YGB1MMQFrf0NP+oho+h1nm5aWst82GtVrh4rYSDZ
	Xt9P9X38QsWhZCMzCnqJergky4aXi8Vm1pIoUv1Beghn/3IuklXA+//PWwDKDGaedQIZ
	ajPA==
X-Gm-Message-State: APjAAAUvOsCwokN9TxJd0A0lxJzArc07LORrsCfISl21xqu4wOj2f3HH
	eiG24LwrBbQ3L/yaXpwmyq78kw==
X-Google-Smtp-Source: APXvYqxFL997nBg2vtq+l+n48ACr5sPhuPrypN+++eVoo5ER8dwsziAxuEH9oRu5k66eoC/X0SrsFw==
X-Received: by 2002:a1c:7915:: with SMTP id l21mr2476187wme.166.1559037002288; 
	Tue, 28 May 2019 02:50:02 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id
	d9sm12242564wro.26.2019.05.28.02.49.56
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Tue, 28 May 2019 02:49:56 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id 803961FF9B;
	Tue, 28 May 2019 10:49:54 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Date: Tue, 28 May 2019 10:49:37 +0100
Message-Id: <20190528094953.14898-13-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190528094953.14898-1-alex.bennee@linaro.org>
References: <20190528094953.14898-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::333
Subject: [Qemu-devel] [PULL 12/28] tests/docker: add ubuntu 18.04
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
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>
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


