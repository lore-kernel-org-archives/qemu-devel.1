Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 997E2C04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 17:17:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6691F217D7
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 17:17:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ouujw737"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6691F217D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58290 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOmfx-0006Ti-HR
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 13:17:45 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52121)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hOmU5-0003nE-GD
	for qemu-devel@nongnu.org; Thu, 09 May 2019 13:05:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hOmU4-0008Az-2u
	for qemu-devel@nongnu.org; Thu, 09 May 2019 13:05:29 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:34215)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hOmU3-00089V-Q3
	for qemu-devel@nongnu.org; Thu, 09 May 2019 13:05:27 -0400
Received: by mail-wr1-x444.google.com with SMTP id f7so4101365wrq.1
	for <qemu-devel@nongnu.org>; Thu, 09 May 2019 10:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=zGueEXNbToGx5hE14DEDnOdyHE8+wvuGNK1SwxHKnFs=;
	b=ouujw737NJgjmvM4H7Y4WHQ2MzmtLJ+RZ1+bjEU8aXhHcnLoC199oeT3Up2vgd30hJ
	8iBFm900G7jpe7hLYgTlwlFJ9HJtESdgUPaw25BsclYL4QPJQx7Dgy5q0VH3h+Cpz/On
	4p5Fzuf4wGUoInBF1iMDlhYz6CO5Z/QzfHL0GfNe8frKqat0GEIaCgKOSe4MOL2dAx6S
	m+dK+gZwqr4Y9B6cyVtEBObA5VrEsKoozd2HLUMAXKZ4s+a4cKoHxjYTSE9jByQ7LiYa
	aHP7lR7hdlKUwpUTDj011tx2CMxWGKNlNGkOgMdP085a6o+MjLl6OuxToASZdV5J1R/U
	r8FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=zGueEXNbToGx5hE14DEDnOdyHE8+wvuGNK1SwxHKnFs=;
	b=JowEJN3+sL2Z0hdcSJ8yJ5Yotd/NcOUJWKQVoBhIcbFWrPbmAL7WnAs0E1zj/ruwyG
	WuHC1a0o/Ux0De0a2yJB2t88+y7XVEkt9LlyJXU36LcuWRpfyurhCGBhzjHouNrdaj0K
	XcfuWs0gsCQZplyLtBHU7AGcS6teUtZ4kKz6jgF5ksJ7di4AkyrHo4kmRRwEMI5PMH6u
	l5U2BJqEzckBvot42ig4FipnoFt6XIOLmsAPf3htZdN0XcQx1SrdfKvJH41Y87Hce/9M
	8oUQk93l6qEKW+wo2GxozHSpPJC28oSeJBgFJsvfNZAotUiIIvEsj9M+Mn3YWzicAdXw
	uUnA==
X-Gm-Message-State: APjAAAUXqHbmGmIxX6Q7mjYA58BFdQdGbpl2PgKhZw9a80uWHFmVqfA2
	PTbmtHHRXmYDhVb+qNM6I08PfQ==
X-Google-Smtp-Source: APXvYqxtHuAG3AK9Z1+yzjEcHPR3QG6aVrE7sThjT76J3UouDUedtKC3+PzJoF9VX9W9kqgn4amitQ==
X-Received: by 2002:adf:e703:: with SMTP id c3mr3806988wrm.98.1557421525928;
	Thu, 09 May 2019 10:05:25 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id r3sm1790121wrn.5.2019.05.09.10.05.22
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 09 May 2019 10:05:23 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id A53D81FFA6;
	Thu,  9 May 2019 17:59:13 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu,  9 May 2019 17:59:07 +0100
Message-Id: <20190509165912.10512-20-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190509165912.10512-1-alex.bennee@linaro.org>
References: <20190509165912.10512-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: [Qemu-devel] [PATCH v1 19/23] cirrus / travis: Add gnu-sed and bash
 for macOS and FreeBSD
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
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
	Ed Maste <emaste@freebsd.org>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Christian Borntraeger <borntraeger@de.ibm.com>, qemu-arm@nongnu.org,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
	Li-Wen Hsu <lwhsu@freebsd.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Thomas Huth <thuth@redhat.com>

We are going to enable the qemu-iotests during "make check" again,
and for running the iotests, we need bash and gnu-sed.

Reviewed-by: Li-Wen Hsu <lwhsu@freebsd.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20190502084506.8009-5-thuth@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .cirrus.yml | 4 ++--
 .travis.yml | 1 +
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/.cirrus.yml b/.cirrus.yml
index 47ef5bc6040..8326a3a4b16 100644
--- a/.cirrus.yml
+++ b/.cirrus.yml
@@ -7,7 +7,7 @@ freebsd_12_task:
     cpu: 8
     memory: 8G
   install_script: pkg install -y
-    bison curl cyrus-sasl git glib gmake gnutls
+    bash bison curl cyrus-sasl git glib gmake gnutls gsed
     nettle perl5 pixman pkgconf png usbredir
   script:
     - mkdir build
@@ -20,7 +20,7 @@ macos_task:
   osx_instance:
     image: mojave-base
   install_script:
-    - brew install pkg-config python glib pixman make sdl2
+    - brew install pkg-config python gnu-sed glib pixman make sdl2
   script:
     - ./configure --python=/usr/local/bin/python3 || { cat config.log; exit 1; }
     - gmake -j$(sysctl -n hw.ncpu)
diff --git a/.travis.yml b/.travis.yml
index 8ba571b88a8..b053a836a32 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -42,6 +42,7 @@ addons:
     packages:
       - glib
       - pixman
+      - gnu-sed
 
 
 # The channel name "irc.oftc.net#qemu" is encrypted against qemu/qemu
-- 
2.20.1


