Return-Path: <SRS0=3xBk=XV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,TVD_SUBJ_WIPE_DEBT,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 016F5C4360C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 19:05:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C88D3217F4
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 19:05:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P6JG+FAV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C88D3217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43104 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDZ4l-0006cZ-Vg
	for qemu-devel@archiver.kernel.org; Thu, 26 Sep 2019 15:05:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45453)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iDYmA-0002J9-Ll
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 14:46:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iDYm8-00054J-NX
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 14:46:02 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f]:52262)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iDYm7-0004yg-F8
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 14:46:00 -0400
Received: by mail-wm1-x32f.google.com with SMTP id r19so3926440wmh.2
 for <qemu-devel@nongnu.org>; Thu, 26 Sep 2019 11:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=DIbRZNB2IeiasAwENXw7mP/WxZPMKvvc+tM2dt1EMvY=;
 b=P6JG+FAVt/gknZx/yNWNDa4b4+hlxzLOWmWf8SNV7GCOe0/j6Ny6rc1C6F0kJ2NJM+
 KYIkEGtv01T1uwOL7r0xJzB0fo4PfOu7/pXaasdAtoGJo7JalCg1MK+HYJEns5kv6CUv
 OAiTvbl58kpL8nULkXpebAofm7+wVWsI4urb4YPJn1Jy58E44n7mll3unc2nejT3WJ8C
 KKPymbu+VPrxQh8/THe/1/UvQzNSkM/ja6Z3OhNdMkPpkvYUx7FUJdTI+sJM7NlBrnm+
 mO/KKSMgVr8smLUdQPOFPN+gjHuh6rK7MKdbUtTgVE8kg4ufXKZBLBSLWj11nsXNuyat
 UQlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=DIbRZNB2IeiasAwENXw7mP/WxZPMKvvc+tM2dt1EMvY=;
 b=UxuJhegQQRPoBQ8G/pJfjOT2PEVpDwth3kFV7xFgckZWJMCrAd9o78jG+/TTbj29pZ
 8/L3Z5Yjn6wuf0jvUg45y3A0xr0qYdcMqc/ZXs1v60EPYmQW1Z12V3syM1ZUOY9NMn1q
 LoQCG+pylswKrQE2f9MXpjKaES/33dDln70rzE8iE942YCZ7eCuHL732gwdfRsesHRC1
 ENPY62Vu3BSOizrBpBd4Hj/xyvr8vcNnyBk51G0u85DylIkOAFpRnivclwuyKlWBPdPV
 UgEGHy7y2QVy+Eg2c40snns6UZY0C0nWX3nsTHIwzEANMrlTL9/xhXIz/50IWwEt/ldh
 CxDQ==
X-Gm-Message-State: APjAAAW+CPCsnlb69TNOWz9Q7IGopz0tyAOXK6qkBEwbvzJZ8FXKsANt
 87LrIjJpPZ5wb2jrzEaXJZ6o2Aewu/+iHw==
X-Google-Smtp-Source: APXvYqy1k046A/hTvtFjRnMkVV0nCC8oLRP9/Gu5MlxzflDfzrwN5G58C7M22mjEDRpxyOdtA7oFKg==
X-Received: by 2002:a7b:c451:: with SMTP id l17mr3769453wmi.61.1569523555678; 
 Thu, 26 Sep 2019 11:45:55 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id f3sm95538wrq.53.2019.09.26.11.45.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Sep 2019 11:45:52 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id CE4B61FFB3;
 Thu, 26 Sep 2019 19:35:55 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 28/28] tests/docker: remove debian-powerpc-user-cross
Date: Thu, 26 Sep 2019 19:35:53 +0100
Message-Id: <20190926183553.13895-29-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190926183553.13895-1-alex.bennee@linaro.org>
References: <20190926183553.13895-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32f
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
Cc: Fam Zheng <fam@euphon.net>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Despite our attempts in 4d26c7fef4 to keep this going it still gets in
the way of "make docker-test-build" completing because of course we
can't build a modern QEMU with the image. Let's put the thing out of
its misery and remove it.

People who really care about building on powerpc can still use the
binfmt_misc support to manually build an image (or just run the build
from pre this commit).

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index 02cd5eeabc..89c56a3a88 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -147,15 +147,6 @@ DOCKER_PARTIAL_IMAGES += fedora-i386-cross fedora-cris-cross
 # work around issues with poorly working multi-arch systems and broken
 # packages.
 
-# Jessie is the last supported release for powerpc, but multi-arch is
-# broken so we need a qemu-linux-user for this target
-docker-binfmt-image-debian-powerpc-user: DEB_ARCH = powerpc
-docker-binfmt-image-debian-powerpc-user: DEB_TYPE = jessie
-docker-binfmt-image-debian-powerpc-user: DEB_URL = http://snapshot.debian.org/archive/debian/20180615T211437Z
-docker-binfmt-image-debian-powerpc-user: EXECUTABLE = ${BUILD_DIR}/ppc-linux-user/qemu-ppc
-docker-image-debian-powerpc-user-cross: docker-binfmt-image-debian-powerpc-user
-DOCKER_USER_IMAGES += debian-powerpc-user
-
 # Expand all the pre-requistes for each docker image and test combination
 $(foreach i,$(filter-out $(DOCKER_PARTIAL_IMAGES),$(DOCKER_IMAGES)), \
 	$(foreach t,$(DOCKER_TESTS) $(DOCKER_TOOLS), \
diff --git a/tests/docker/dockerfiles/debian-powerpc-user-cross.docker b/tests/docker/dockerfiles/debian-powerpc-user-cross.docker
deleted file mode 100644
index 83749b0abb..0000000000
--- a/tests/docker/dockerfiles/debian-powerpc-user-cross.docker
+++ /dev/null
@@ -1,21 +0,0 @@
-#
-# Docker powerpc cross-compiler target for QEMU
-#
-# We can't use current Debian stable cross-compilers to build powerpc
-# as it has been dropped as a release architecture. Using Debian Sid
-# is just far too sketchy a build environment. This leaves us the
-# final option of using linux-user. This image is based of the
-# debootstrapped qemu:debian-powerpc-user but doesn't need any extra
-# magic once it is setup.
-#
-# It can be used to build old versions of QEMU, current versions need
-# newer dependencies than Jessie provides.
-#
-FROM qemu:debian-powerpc-user
-
-RUN echo man-db man-db/auto-update boolean false | debconf-set-selections
-RUN apt-get update && \
-        DEBIAN_FRONTEND=noninteractive apt-get build-dep -yy qemu
-
-ENV QEMU_CONFIGURE_OPTS --disable-werror
-ENV DEF_TARGET_LIST powerpc-softmmu,arm-linux-user,aarch64-linux-user
-- 
2.20.1


