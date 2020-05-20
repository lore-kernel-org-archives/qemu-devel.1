Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B4C8C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 14:08:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46392207D4
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 14:08:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X5HHixyO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46392207D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37950 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbPOm-0004Ym-Fu
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 10:08:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55238)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jbPM6-0000C0-71
 for qemu-devel@nongnu.org; Wed, 20 May 2020 10:05:58 -0400
Received: from mail-ej1-x644.google.com ([2a00:1450:4864:20::644]:32869)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jbPM5-0001za-7E
 for qemu-devel@nongnu.org; Wed, 20 May 2020 10:05:57 -0400
Received: by mail-ej1-x644.google.com with SMTP id n24so3987990ejd.0
 for <qemu-devel@nongnu.org>; Wed, 20 May 2020 07:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=dnix+tfq2fdfws6TsVzkTHLlR4M0EwyavqIhHiXG7vU=;
 b=X5HHixyOI99g+WiUaQD8pYhavhfEXVgxEeZlenYNgBDtrxHOoAkneZTL2JLiStsqV8
 /MiErkGxdpVR9/uOl7lZzeugFLuhkdppf8Jwgd5J7Xn0ts+m9ufm2Nzq2XP18PpejV7D
 uPLeZOWCX5b0ISiaiI1pmKtwYdbPwypNC2e9HkhYO/3v14WjyEcMfig2X/46Ad5JD7Tk
 i5ljhwGtM+UenXpnox5vExj+gaeHlYCeB3xR9oWodpvsXtpPXZ3dWCmECO8fZDZVdDoJ
 iWQHHOI9NbtIVxhVXkAvtJuDu5zdkCNQf6X0Alk+ytco7n4R/628WTyUyhp2z4/1UxcH
 yQeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=dnix+tfq2fdfws6TsVzkTHLlR4M0EwyavqIhHiXG7vU=;
 b=MPtBW+nwapC2aRNG/K2XujXV9XdBL733LVwpM0SiCV+bMFxVdYpmZL9srOUyEpr1Q1
 09JWhafmwZ4RU4DK2AA/TZmE4DCMWeSO8X7nKVlf40VI7J3QMv4TpIZpGX3NgilpuiEc
 E2RtdH+ALa2G8XiVz3TgzFfhdbuDUkjifOpH67u8E+NAZ3Cb/JUeDXRNQj4N9twQp0IN
 /vqL3rBhislpCc3P977KGaM6/7PSgw9YN64wkGrzQ8dhOp9WUsidVqmnovSI9fUiR+7y
 nmpHaKm2DjwSpH0m22t94jGqCpY5SDlkPuONc7P95eI54P054s//VGRA92l++OGsNnog
 gbKg==
X-Gm-Message-State: AOAM532bl723x3/w13qc8C6WMflNps9HwOr4tHzzvmLkCosQXinO+O4/
 jLIUwZErRk8hoSYz/Q4a3bozcg==
X-Google-Smtp-Source: ABdhPJziS0vsQ9V6nSw+MJ8upl6US/GKPHLklkathteVBc9JHY16G8x70fdVXqClqOU5e+vrIDnkAQ==
X-Received: by 2002:a17:906:a417:: with SMTP id
 l23mr3753999ejz.213.1589983555832; 
 Wed, 20 May 2020 07:05:55 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id b23sm1985096ejz.121.2020.05.20.07.05.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2020 07:05:49 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 19D701FF99;
 Wed, 20 May 2020 15:05:42 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 10/15] tests/docker: use a gcc-10 based image for arm64
 tests
Date: Wed, 20 May 2020 15:05:36 +0100
Message-Id: <20200520140541.30256-11-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200520140541.30256-1-alex.bennee@linaro.org>
References: <20200520140541.30256-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::644;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x644.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

As we enable newer features that we want to test on arm64 targets we
need newer compilers. Split off a new debian-arm64-test-cross image
which we can use to build these new tests.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/docker/Makefile.include                       |  2 ++
 .../dockerfiles/debian-arm64-test-cross.docker      | 13 +++++++++++++
 tests/tcg/configure.sh                              |  4 ++--
 3 files changed, 17 insertions(+), 2 deletions(-)
 create mode 100644 tests/docker/dockerfiles/debian-arm64-test-cross.docker

diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index 3596b589307..ed46bd98eb5 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -131,9 +131,11 @@ docker-image-travis: NOUSER=1
 
 # Specialist build images, sometimes very limited tools
 docker-image-tricore-cross: docker-image-debian9
+docker-image-debian-arm64-test-cross: docker-image-debian11
 
 # These images may be good enough for building tests but not for test builds
 DOCKER_PARTIAL_IMAGES += debian-alpha-cross
+DOCKER_PARTIAL_IMAGES += debian-arm64-test-cross
 DOCKER_PARTIAL_IMAGES += debian-hppa-cross
 DOCKER_PARTIAL_IMAGES += debian-m68k-cross debian-mips64-cross
 DOCKER_PARTIAL_IMAGES += debian-powerpc-cross debian-ppc64-cross
diff --git a/tests/docker/dockerfiles/debian-arm64-test-cross.docker b/tests/docker/dockerfiles/debian-arm64-test-cross.docker
new file mode 100644
index 00000000000..a44e76d9421
--- /dev/null
+++ b/tests/docker/dockerfiles/debian-arm64-test-cross.docker
@@ -0,0 +1,13 @@
+#
+# Docker arm64 cross-compiler target (tests only)
+#
+# This docker target builds on the debian Bullseye base image.
+#
+FROM qemu:debian11
+
+# Add the foreign architecture we want and install dependencies
+RUN dpkg --add-architecture arm64
+RUN apt update && \
+    DEBIAN_FRONTEND=noninteractive eatmydata \
+        apt install -y --no-install-recommends \
+        crossbuild-essential-arm64 gcc-10-aarch64-linux-gnu
diff --git a/tests/tcg/configure.sh b/tests/tcg/configure.sh
index eaaaff6233a..2326f978562 100755
--- a/tests/tcg/configure.sh
+++ b/tests/tcg/configure.sh
@@ -97,8 +97,8 @@ for target in $target_list; do
   case $target in
     aarch64-*)
       # We don't have any bigendian build tools so we only use this for AArch64
-      container_image=debian-arm64-cross
-      container_cross_cc=aarch64-linux-gnu-gcc
+      container_image=debian-arm64-test-cross
+      container_cross_cc=aarch64-linux-gnu-gcc-10
       ;;
     alpha-*)
       container_image=debian-alpha-cross
-- 
2.20.1


