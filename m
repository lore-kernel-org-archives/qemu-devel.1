Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04F41C3A5A6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 17:28:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C32A421928
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 17:28:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fO/EGBtg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C32A421928
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46960 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iB0EY-0007He-8I
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 13:28:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50079)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iB06m-0008Kv-Dg
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 13:20:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iB05p-0000Qp-Je
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 13:19:46 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b]:38307)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iB05p-0000QL-Dh
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 13:19:45 -0400
Received: by mail-wr1-x42b.google.com with SMTP id l11so3959499wrx.5
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2019 10:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ViSX4enI+dJcwOYnkvEKIVP5m0g4W0h9r7phsHaVvOg=;
 b=fO/EGBtg+Hgg5YwmmBS5OjMtmY/zofAdKarO8oZqAaMzN6VAtXZnHqRU7lgWW3oZ3c
 aE6rgrAyRSwlmSpgv336tEKQIwy1wZzwYblEPg/y9ucGLKr/TMf7BJTLaq6TmXMdytSt
 /8wM68ByqWkNNR7GXZEzUiU65XpIIu+SaSO6xAczar18JnsB/nu7sMsGKHSULrs0E8AO
 Zq8XeJBsc4dI33A3c68CRAaRT/57/+dhH3fXDQ0XoNqHmP/o9knjFZ2sKRh2BbJoH/uV
 IFPpP0KMO4lPPNYpfbn/oZKcGt9XnEl0TyDw/xeo+im16QX8ponworjvY2wJAWqv/rbJ
 SkRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ViSX4enI+dJcwOYnkvEKIVP5m0g4W0h9r7phsHaVvOg=;
 b=SIb2TEV0ZaexJFHTojvgIywHrt3icZ4z9vBNZUl9pifdsijYE+HfMXfOlUe4GOlGWa
 robo8E3hem2wOartLudqLZYtFTKJAYX69EmAR2hxtkQk8tKCU4PhWGCv0ScgNcbwhWo1
 u33D+pHpjPWBl/4jR8W+HEEUYN3BH3oUNDDRyH2kMNRD7HseLZkns3R4xkXrstAMMa4C
 6VIVT9Pl4O7PhH+a87HCkfxPOVw2rpbFDC0fboz82jz+1gd/rYSn3o7iZhzWgoePVbmb
 N1GdFK60queTPBf0G9FUAfWjDzjqUXFOVjQJ3ffhkSi06XA2szqShQH2zKsM4TYzk9Ng
 dBgg==
X-Gm-Message-State: APjAAAWkVZeY+joYMU4KrPLL4jsTR+D6mJqM2PmYmkvHHrPbpQUiy2KQ
 7iegmktDOLpw1xthetEarO4trQ==
X-Google-Smtp-Source: APXvYqxPP2dGkV4DQSqmEOfzk3v8eqeQ6mzlMX6jFVRe5kZ18pgqTHxSvwC2RYtCNCTrVDdu+wQwpg==
X-Received: by 2002:a5d:40c4:: with SMTP id b4mr8666185wrq.214.1568913584283; 
 Thu, 19 Sep 2019 10:19:44 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id v64sm8979316wmf.12.2019.09.19.10.19.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Sep 2019 10:19:40 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id E179F1FF9C;
 Thu, 19 Sep 2019 18:10:16 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v2 12/16] tests/docker: Add fedora-win10sdk-cross image
Date: Thu, 19 Sep 2019 18:10:11 +0100
Message-Id: <20190919171015.12681-13-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190919171015.12681-1-alex.bennee@linaro.org>
References: <20190919171015.12681-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42b
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
 peter.maydell@linaro.org, Fam Zheng <fam@euphon.net>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20190919105932.19412-2-philmd@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/docker/Makefile.include                 |  1 +
 .../dockerfiles/fedora-win10sdk-cross.docker  | 21 +++++++++++++++++++
 2 files changed, 22 insertions(+)
 create mode 100644 tests/docker/dockerfiles/fedora-win10sdk-cross.docker

diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index 3fc7a863e51..d796f71b63a 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -125,6 +125,7 @@ docker-image-debian-ppc64-cross: docker-image-debian10
 docker-image-debian-riscv64-cross: docker-image-debian10
 docker-image-debian-sh4-cross: docker-image-debian10
 docker-image-debian-sparc64-cross: docker-image-debian10
+docker-image-fedora-win10sdk-cross: docker-image-fedora
 
 docker-image-travis: NOUSER=1
 
diff --git a/tests/docker/dockerfiles/fedora-win10sdk-cross.docker b/tests/docker/dockerfiles/fedora-win10sdk-cross.docker
new file mode 100644
index 00000000000..1aafdad483c
--- /dev/null
+++ b/tests/docker/dockerfiles/fedora-win10sdk-cross.docker
@@ -0,0 +1,21 @@
+#
+# Docker MinGW64 cross-compiler target with WHPX header installed
+#
+# This docker target builds on the Fedora 30 base image.
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+FROM qemu:fedora
+
+# Install headers extracted by the Android folks from the win10sdk.iso:
+# https://developer.microsoft.com/en-us/windows/downloads/windows-10-sdk
+ENV WIN10SDK_INCDIR /usr/local/include/win10sdk
+RUN mkdir ${WIN10SDK_INCDIR} && \
+    for hdr in WinHvEmulation.h WinHvPlatformDefs.h WinHvPlatform.h; do \
+        curl -s "https://android.googlesource.com/platform/prebuilts/gcc/linux-x86/host/x86_64-w64-mingw32-4.8/+/1bde9c3b14f3a3b081ada6e32da9f2870671b46f/x86_64-w64-mingw32/include/${hdr}?format=TEXT" | base64 --decode > ${WIN10SDK_INCDIR}/${hdr}; \
+    done
+
+ENV QEMU_CONFIGURE_OPTS ${QEMU_CONFIGURE_OPTS} \
+    --cross-prefix=x86_64-w64-mingw32- \
+    --extra-cflags="-I ${WIN10SDK_INCDIR}" --disable-werror \
+    --enable-hax --enable-whpx
-- 
2.20.1


