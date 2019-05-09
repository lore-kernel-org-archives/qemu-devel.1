Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E232EC04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 17:04:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AC90205C9
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 17:04:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZDfoYvFj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AC90205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58035 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOmTK-0002pI-Aa
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 13:04:42 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49506)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hOmO5-0006wO-9i
	for qemu-devel@nongnu.org; Thu, 09 May 2019 12:59:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hOmO4-0004qE-6F
	for qemu-devel@nongnu.org; Thu, 09 May 2019 12:59:17 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a]:44896)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hOmO3-0004pU-Vj
	for qemu-devel@nongnu.org; Thu, 09 May 2019 12:59:16 -0400
Received: by mail-wr1-x42a.google.com with SMTP id c5so4014876wrs.11
	for <qemu-devel@nongnu.org>; Thu, 09 May 2019 09:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=bMInk10U9DPIdxrDVbgVpcIvGvM3TC9tcdyqpqFFzTY=;
	b=ZDfoYvFjwFGI+53DIh0UGgKquZ04X5GPXQ/2iQBEx/TaxptET+iCyTZ0kSD4LGNQix
	jgbWJxrhltyNHlppjJMAtUguXsVLA4hPWFaWWREDBI4Rkaea97gZP4uspnOdHI7OcB6Z
	6n+GPtvjUXFpPmoIuGrjISk/NyE/fRWmPKkFDZAfHLJ+BmTLeu1jde8PZdfmlTorxml2
	wuPboAekmv3YIAUF31EfabfqqqwTs04yx2+tUyh5V6rjYAJzRKCW3PfTTOAtENwlHucC
	UezInEfGzvncMj6k1vCBem4ahPbpO3DkpO0HFlHgAd01aQL4p3KfL3BeTYIn5eghhbbY
	z8WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=bMInk10U9DPIdxrDVbgVpcIvGvM3TC9tcdyqpqFFzTY=;
	b=mjGJDVVpA1MQWgpQ5FG0ZoXxVKiMnG0chC9lUHYlc90CHbtMHgAOUXoxzVc60MXYv8
	tl3BKHJGBIl0AWO2yLw1si/iiNTj9S0Py8RCTY9exMtNJAeLKRdmdfOgBU3hA3pFJB/8
	7T0XsB8F0A/s5qY8xmGu0RYf5nz44HBPjn9cbc6r9quzSJ7OzZm4rqZXTNtKT+5Grxc1
	CGGQYfDrfiTrTWcLG9jJzPcf6C9v845WcjPkDOIEuwsuJhwPb9WKZHs5GR8cLUiNZNej
	Mx3TwYdB8cKBqgqGGUKKjm/E/BiCEXkpcKhiNTyi45+q5LMRVXje/Yd/LdBKDRI3mS4J
	JEFQ==
X-Gm-Message-State: APjAAAU7obqHf3LtcP6bTxCQRh85qGVasP8/MuMGGIhGfE+/ATYg+JN5
	Yu1SH8yPIKE88M8KgGvamXmmqA==
X-Google-Smtp-Source: APXvYqwjPY0jChYLruJRkImEkTPFzM5D5E8J9V0Hs2Si3HeJ0qEAmb9nU2bIsxgYksM3bvBudKMNbg==
X-Received: by 2002:a5d:4704:: with SMTP id y4mr3849907wrq.86.1557421154902;
	Thu, 09 May 2019 09:59:14 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id
	i127sm7871188wmg.21.2019.05.09.09.59.12
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 09 May 2019 09:59:14 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id 3335B1FF8F;
	Thu,  9 May 2019 17:59:12 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu,  9 May 2019 17:58:50 +0100
Message-Id: <20190509165912.10512-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190509165912.10512-1-alex.bennee@linaro.org>
References: <20190509165912.10512-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::42a
Subject: [Qemu-devel] [PATCH v1 02/23] tests/docker: Test more components on
 the Fedora default image
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
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	qemu-arm@nongnu.org,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Install optional dependencies of QEMU to get better coverage.

The following components are now enabled:

  $ ./configure
  ...
  Multipath support yes
  VNC SASL support  yes
  RDMA support      yes
  PVRDMA support    yes
  libiscsi support  yes
  seccomp support   yes
  libpmem support   yes
  libudev           yes

Note: The udev-devel package is provided by systemd-devel.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20190504055440.20406-1-philmd@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/docker/dockerfiles/fedora.docker | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tests/docker/dockerfiles/fedora.docker b/tests/docker/dockerfiles/fedora.docker
index 69d4a7f5d75..afbba29adaa 100644
--- a/tests/docker/dockerfiles/fedora.docker
+++ b/tests/docker/dockerfiles/fedora.docker
@@ -8,6 +8,7 @@ ENV PACKAGES \
     bzip2-devel \
     ccache \
     clang \
+    cyrus-sasl-devel \
     device-mapper-multipath-devel \
     findutils \
     flex \
@@ -23,13 +24,17 @@ ENV PACKAGES \
     libaio-devel \
     libasan \
     libattr-devel \
+    libblockdev-mpath-devel \
     libcap-devel \
     libcap-ng-devel \
     libcurl-devel \
     libfdt-devel \
+    libiscsi-devel \
     libjpeg-devel \
+    libpmem-devel \
     libpng-devel \
     librbd-devel \
+    libseccomp-devel \
     libssh2-devel \
     libubsan \
     libusbx-devel \
@@ -74,10 +79,12 @@ ENV PACKAGES \
     pixman-devel \
     python3 \
     PyYAML \
+    rdma-core-devel \
     SDL2-devel \
     snappy-devel \
     sparse \
     spice-server-devel \
+    systemd-devel \
     systemtap-sdt-devel \
     tar \
     usbredir-devel \
-- 
2.20.1


