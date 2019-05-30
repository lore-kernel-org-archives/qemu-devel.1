Return-Path: <SRS0=r6E1=T6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51D0FC28CC0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 10:24:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F72F25725
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 10:24:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lR9r11t9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F72F25725
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50642 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWIEr-0000Wl-A9
	for qemu-devel@archiver.kernel.org; Thu, 30 May 2019 06:24:49 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54303)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hWI6W-0002Zl-8g
	for qemu-devel@nongnu.org; Thu, 30 May 2019 06:16:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hWI6V-0006UZ-5g
	for qemu-devel@nongnu.org; Thu, 30 May 2019 06:16:12 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:40269)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hWI6U-0006Tc-V2
	for qemu-devel@nongnu.org; Thu, 30 May 2019 06:16:11 -0400
Received: by mail-wm1-x343.google.com with SMTP id 15so3457028wmg.5
	for <qemu-devel@nongnu.org>; Thu, 30 May 2019 03:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=XEDDkoJKFf+IpBra7HDHG0A6Y/FKSBEEsukwDPufo7k=;
	b=lR9r11t9rA8f0H5+5wxcChwS0IOKmncWsaLejMOBY+nUB0urOlE7EKrxfhvESLScSG
	pXan9EJoYz0xV7N5AybHN82/O3BVi9mfgKntuTbOxiJRu7nry7vDSHeuRa8yVo9Um9db
	BENdaI2y6SBKLtHYSZg+x0PEN9KE4SgFhR0qXwtua6PdfUrWrtObqmlLWLIL/HNl8dcp
	Ay7leC+khmFPgngHrFoo4Z5b0z5CRDASpydVgtdvNYloHluIkqXDauyJQ1q11L5E57X4
	A941B+lyxVXNFUSLu0GNNSJ8QhMNjzB4ncSWcVmeK1z+YnPQAT6y6sMjqUcFoU2rSSpI
	oiaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=XEDDkoJKFf+IpBra7HDHG0A6Y/FKSBEEsukwDPufo7k=;
	b=Jk6v7E4sltyu+24qfXhhyljGnWJADX6qtU7Qus1pxsZgUOvoyxefXzRE824mAY6gjY
	xavd23PM+gvVDvCaJEDP7U4b7rnIGqG0Pcq1GkxU2uxnpShQB5Z2cBMYxN0kMsWoSe1x
	O1WOiH/lfTNcXuSOS691JEsPeT5lhHR0ZvBOIFNhxsnMKl3Zz5IAGYIz53LPlg/f2yWm
	wBvRde1f/MRH1lpzDgP/6kKxxdBzbI4BzZnoVOUQj9tLi+xnISuHbDzIppNMG4djROa5
	F1pmohSg53dcLA540pSH/IeSuVbVsxwTNj3a0xnONUyyd8UuLmzBOJR9vW8twgzObSLP
	xuEw==
X-Gm-Message-State: APjAAAVc0HmxPe+nbXBAhZtVYe2zUDYj026SfyXg/7akWwPA0oI8k/u+
	gvI7W9b2h3VgAj50YbUY4MClUQ==
X-Google-Smtp-Source: APXvYqw7BIb3mLB2wgPSPaxW4Px2y4VKwvbgE6I93S9SyVxjEJcj+yQyhVOfhqI6sGbuThU19F5wqg==
X-Received: by 2002:a1c:385:: with SMTP id 127mr1694799wmd.109.1559211369935; 
	Thu, 30 May 2019 03:16:09 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id
	w185sm1689633wma.39.2019.05.30.03.16.05
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Thu, 30 May 2019 03:16:08 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id 7422B1FF92;
	Thu, 30 May 2019 11:16:04 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu, 30 May 2019 11:15:42 +0100
Message-Id: <20190530101603.22254-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190530101603.22254-1-alex.bennee@linaro.org>
References: <20190530101603.22254-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::343
Subject: [Qemu-devel] [PATCH v1 05/26] tests/docker: Update the Fedora cross
 compile images to 30
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

While at it remove the bogus :latest tag for cris cross compiler. It
tends to break caching and cause confusion.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/docker/dockerfiles/fedora-cris-cross.docker | 2 +-
 tests/docker/dockerfiles/fedora-i386-cross.docker | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/docker/dockerfiles/fedora-cris-cross.docker b/tests/docker/dockerfiles/fedora-cris-cross.docker
index b168ada615a..09e7e449f9b 100644
--- a/tests/docker/dockerfiles/fedora-cris-cross.docker
+++ b/tests/docker/dockerfiles/fedora-cris-cross.docker
@@ -2,7 +2,7 @@
 # Cross compiler for cris system tests
 #
 
-FROM fedora:latest
+FROM fedora:30
 ENV PACKAGES gcc-cris-linux-gnu
 RUN dnf install -y $PACKAGES
 RUN rpm -q $PACKAGES | sort > /packages.txt
diff --git a/tests/docker/dockerfiles/fedora-i386-cross.docker b/tests/docker/dockerfiles/fedora-i386-cross.docker
index eb8108d1185..9106cf9ebed 100644
--- a/tests/docker/dockerfiles/fedora-i386-cross.docker
+++ b/tests/docker/dockerfiles/fedora-i386-cross.docker
@@ -1,4 +1,4 @@
-FROM fedora:29
+FROM fedora:30
 ENV PACKAGES \
     gcc \
     glib2-devel.i686 \
-- 
2.20.1


