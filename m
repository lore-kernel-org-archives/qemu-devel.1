Return-Path: <SRS0=3Ld+=VU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13BF4C7618E
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 10:37:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8AA522400
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 10:37:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="v5IqGYvb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8AA522400
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41010 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpsB4-0003RD-M5
	for qemu-devel@archiver.kernel.org; Tue, 23 Jul 2019 06:37:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37769)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hps9b-0005h1-5w
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 06:36:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hps9a-0007Mi-2W
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 06:36:19 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433]:33102)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hps9Z-0007Lr-RP
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 06:36:17 -0400
Received: by mail-wr1-x433.google.com with SMTP id n9so42682764wru.0
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2019 03:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=VwUrgi4jKAJRQEbP+c7m0Efau+IX+/w4l0nX2BCVIts=;
 b=v5IqGYvbNGfWLemlqlBmR66aY5OU5yYyrPniSCbJq04emT/eGUfkYVZCa1FlDg6G0y
 ybDOz6H8EkeYJFe6VXmPzRfvJ3e40H+W26oLFkhxwrwBK/hTelOJHYvYfZD2rwTTl2mL
 dNJ6PmIRaEBy3JXL29m18w4rS3/m+w/MZxzYDRiIehnGWidEbOSAouDvA1901ijZ4PnM
 SSqh++MgAxCtof6C6mmj8PazPlCjgX1gKPfp6IlOi3rX3uDhE3YvsATSWaYoHjPXR8XE
 8ILKFQCy90j+B/yfHTfoVC4uhTiPjwhQu7b1g6/Bvg28fRDnhK4dA/tY0FZ+1hU68zG0
 Lnkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=VwUrgi4jKAJRQEbP+c7m0Efau+IX+/w4l0nX2BCVIts=;
 b=nSeWSp/gspao5nAYqpcFej9NPcRjbvthFf2ShwgIJRgDZPJT0wJe82o2SxwJ10/YfC
 LuqDKPOULDYTOPgElx5xn/dmVTal6iQqjcfsek9QenQs5NTiKbVZleWXq//rqH5WEfn+
 bamT3gEGA8loiqvJ19NIPpkUvqY1Dxj7lVosoqQIZ+F77veLrtNtRiQ910ZplIZWQM17
 1JMnVP6wyOev4wVI4lpjA7DCH/Au4trvc4BxnEnNcfLbV8mYvwqK+css0OG56IV4Gr5V
 oupGi9BAHvfEtpnm74PE4KNA14VIebWg48Ez5VuMFX1sNtK3qgLFO2QT3J00FAFvc+sW
 qZGQ==
X-Gm-Message-State: APjAAAUAxLfiZmzH60owMMrFI6H8siEn4rSGNiAMBbxQ7jX4YkxN06Wx
 YOzB7qbIoSyRwaWfRCwyg9U1dg==
X-Google-Smtp-Source: APXvYqygi8aMINVCRwUB14xSCFrQE3xHEFtQXACLJ7buohaLT8Clj67uxilzHy25pucPSkJvdonezg==
X-Received: by 2002:adf:b1d1:: with SMTP id r17mr81247141wra.273.1563878176623; 
 Tue, 23 Jul 2019 03:36:16 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id c65sm39811216wma.44.2019.07.23.03.36.12
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 23 Jul 2019 03:36:14 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id B03E81FF91;
 Tue, 23 Jul 2019 11:36:12 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Date: Tue, 23 Jul 2019 11:35:53 +0100
Message-Id: <20190723103612.5600-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190723103612.5600-1-alex.bennee@linaro.org>
References: <20190723103612.5600-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::433
Subject: [Qemu-devel] [PULL 04/23] tests/docker: Install Sphinx in the
 Fedora image
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Since commit 5f71eac06e the Sphinx tool is required
to build the rST documentation.

This fixes:

 $ ./configure --enable-docs

 ERROR: User requested feature docs
        configure was not able to find it.
        Install texinfo, Perl/perl-podlators and python-sphinx

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20190711102710.2263-1-philmd@redhat.com>
[AJB: also add /usr/libexec/python3-sphinx/ to PATH]
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/docker/dockerfiles/fedora.docker b/tests/docker/dockerfiles/fedora.docker
index 619d1b5656d..2350d494d9a 100644
--- a/tests/docker/dockerfiles/fedora.docker
+++ b/tests/docker/dockerfiles/fedora.docker
@@ -76,6 +76,7 @@ ENV PACKAGES \
     perl-Test-Harness \
     pixman-devel \
     python3 \
+    python3-sphinx \
     PyYAML \
     rdma-core-devel \
     SDL2-devel \
@@ -95,4 +96,5 @@ ENV QEMU_CONFIGURE_OPTS --python=/usr/bin/python3
 
 RUN dnf install -y $PACKAGES
 RUN rpm -q $PACKAGES | sort > /packages.txt
+ENV PATH $PATH:/usr/libexec/python3-sphinx/
 ENV FEATURES mingw clang pyyaml asan
-- 
2.20.1


