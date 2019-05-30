Return-Path: <SRS0=r6E1=T6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29B88C28CC0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 10:21:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBCD925715
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 10:21:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bU4MhMOM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBCD925715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50611 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWIBl-0006FE-6L
	for qemu-devel@archiver.kernel.org; Thu, 30 May 2019 06:21:37 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54321)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hWI6W-0002a4-TO
	for qemu-devel@nongnu.org; Thu, 30 May 2019 06:16:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hWI6V-0006Uy-Mz
	for qemu-devel@nongnu.org; Thu, 30 May 2019 06:16:12 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:41883)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hWI6V-0006UF-EU
	for qemu-devel@nongnu.org; Thu, 30 May 2019 06:16:11 -0400
Received: by mail-wr1-x441.google.com with SMTP id c2so3807178wrm.8
	for <qemu-devel@nongnu.org>; Thu, 30 May 2019 03:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=tdfRNkcy3tXrd40GFlSuojfYwNRpqR4LehskXAKdxiE=;
	b=bU4MhMOMtOQF9SzIY9sKIx1ml5gCo6WA0CTGCSf//xBaBJx9aWmvonLe6FA3rgO0vM
	r1mqz9QtEKR0dJuKzlIvz9o0Ce6vfW3bVHKXYcShjgmMb7EQ3qBX+6k8VOcdfzTxwORo
	XObCcf/AWo1cTO/z/x0pw3nTH/8fIO5WyY/PM+GfGNEwjzF8jHamLew9U73WNDbW1RYz
	IhsdO5Uij9oSHSn1bEAeogEzX0auB+meUQnxhhlB0YKXxuAhSICyW9nBN0DqndfRmA64
	wpkZQPGyjyRfrGtpV9nsRPomf/QDlBQQ/uDzlZ75tRSDOTHYXpgxbl0K0cJpi4hpQrjR
	eCcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=tdfRNkcy3tXrd40GFlSuojfYwNRpqR4LehskXAKdxiE=;
	b=EgfTCFqii4MzZYjyOKfGm3mzrmIlmO3/8IqXkAjZjA0qB1LTf2ipRVspxPR8oSsh12
	TUb+KSMlpTfJSQ8Tg/qAVI3qYyR7l4x4y/Amu4VinUTchCW3e+A8nbyUNbTsap1TXiST
	VItqlbKo2dHpk4G/WHgLEbWPTMGEj/p6qS4WSOt+Iosu4TMK2mEA6Hpn2toQ/CNphpI/
	kdMSMdg/XW5BRmjTb4KUON9n6koiJiYEJ306n9/GWx+GLODbbHZ/6BBTwDFcOJYXcS1c
	3K47/yOwj4UGgL+a6QwXaJPe5ZJhDmw6FNoohNPBWmp2r2Ozu8Ec24zRuQXMCRNlRdeg
	4nyQ==
X-Gm-Message-State: APjAAAVKwTd1mnZBUPB1hXA+58n+3wkbLhv+zB4Ec2iRd+QsdBuWVmyW
	fxjM2GF+fqNLY3BK51P8sS7B+Q==
X-Google-Smtp-Source: APXvYqxWYHGYkBKlrK1Uu8vk/WJl+lcvUPnDXl+s1V+Pb9eXsuWSAnk6hotSNrANAlHm97daVv6edg==
X-Received: by 2002:a5d:568c:: with SMTP id f12mr2040279wrv.77.1559211370441; 
	Thu, 30 May 2019 03:16:10 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id
	u10sm1736567wml.42.2019.05.30.03.16.06
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Thu, 30 May 2019 03:16:08 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id 884C31FF93;
	Thu, 30 May 2019 11:16:04 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu, 30 May 2019 11:15:43 +0100
Message-Id: <20190530101603.22254-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190530101603.22254-1-alex.bennee@linaro.org>
References: <20190530101603.22254-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: [Qemu-devel] [PATCH v1 06/26] tests/docker: Update the Ubuntu image
 to 19.04
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
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This has aged a little and we have a separate LTS image for testing on
the older distros. Update it to a more recent release like its Fedora
cousin.

Besides it is useful to have something with gcc-9 on it for squashing
those stringop truncation errors.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/docker/dockerfiles/ubuntu.docker | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/tests/docker/dockerfiles/ubuntu.docker b/tests/docker/dockerfiles/ubuntu.docker
index 36e2b17de59..8d256961f06 100644
--- a/tests/docker/dockerfiles/ubuntu.docker
+++ b/tests/docker/dockerfiles/ubuntu.docker
@@ -1,6 +1,15 @@
-FROM ubuntu:16.04
-RUN echo "deb http://archive.ubuntu.com/ubuntu/ trusty universe multiverse" >> \
-    /etc/apt/sources.list
+#
+# Latest Ubuntu Release
+#
+# Useful for testing against relatively bleeding edge libraries and
+# compilers. We also have seperate recipe for the most recent LTS
+# release.
+#
+# When updating use the full tag not :latest otherwise the build
+# system won't pick up that it has changed.
+#
+
+FROM ubuntu:19.04
 ENV PACKAGES flex bison \
     ccache \
     clang \
@@ -21,7 +30,7 @@ ENV PACKAGES flex bison \
     libepoxy-dev \
     libfdt-dev \
     libgbm-dev \
-    libgnutls-dev \
+    libgnutls28-dev \
     libgtk-3-dev \
     libibverbs-dev \
     libiscsi-dev \
@@ -34,7 +43,7 @@ ENV PACKAGES flex bison \
     libnss3-dev \
     libnuma-dev \
     libpixman-1-dev \
-    libpng12-dev \
+    libpng-dev \
     librados-dev \
     librbd-dev \
     librdmacm-dev \
-- 
2.20.1


