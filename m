Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A856C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 07:31:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6999F206B6
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 07:31:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o7o5dpiV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6999F206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48182 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsi4v-0004z9-N6
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 03:31:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45954)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jshxv-0001dz-KW
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 03:24:31 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f]:43980)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jshxt-0006hF-Th
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 03:24:31 -0400
Received: by mail-wr1-x42f.google.com with SMTP id j4so41598336wrp.10
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2020 00:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=m1Cz8IQnUh6NpcECGMGmsDtXwGSngF0Lzci6sx+px08=;
 b=o7o5dpiVbw/Gbqhr50c4Q6ywWPBUR+7yUm8mlIGpn+2HDhUah51XdnA1F8YaNpAi0l
 vnJh19F1ms18ONVAE/CtRdz6yU02bFJF9amH5CHmW2RbvmOl0UmjPcCp0REaLQNWbcfH
 +09Rw6ozJ+n74A4/pwMVNpc1tEaIOFOI9VDhQSRb++vnKd3U7L0ev7lXoOgJbDrPQ5ql
 lr+mY1Nt6T4TP+m3hDBNXT9z79JeiFZ/tX74VUUvOGW9r3jjTIwxEc4DqY9UetFKIC5i
 MGwDdtjLwS+Ob9wt3XT9MNyuYmuuV6kNk5qjkcEWTKsNjCrh5yk62KESnJ3/oEULciFf
 sGxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=m1Cz8IQnUh6NpcECGMGmsDtXwGSngF0Lzci6sx+px08=;
 b=WVAaKR/xCznw0H9DA77kxqOcy5jSXQHhIsWAkNwT+ILSWmFYX+vsygstrGHNpcV2lQ
 kS1F1q1e+rKxqNkD41ZLtmARZkx5A3sJLGk3708ZfH4I5Vaop39QUBz70MnpOVSpRyBP
 fbi8pCSqNssRokyq5qViTIiw23U0u0aC+irE3WkULJIttXtQ6DP2L+OhqW3w9bHF975I
 KxJuCHi01kuLaQ2YRnOFkdsisT4fVFKoznbThRneO5JMqy3HDMSYnRFCrmb7QvkfH6v8
 zlHfnGeW94fsWkoxfnZfeKzCeQ7tHTt32RqNphTNFegNC1NsQgkIKIA1teFiPFhHwf90
 1nbQ==
X-Gm-Message-State: AOAM532nHttFndodF8spab91GfW3/dIW5fj7x1ewc6sfJuSpDeHIkQx+
 qXw3rqBVIbREujH8KCCDyIYUcw==
X-Google-Smtp-Source: ABdhPJysWXeMIZJAbgWh5yjMXwiUiKgtXJC2TlibNKCWkjGHU6yYieNXWnVIcZ1tCvBaNzaMh8uIQQ==
X-Received: by 2002:adf:8524:: with SMTP id 33mr52091346wrh.366.1594106668552; 
 Tue, 07 Jul 2020 00:24:28 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id x185sm2385198wmg.41.2020.07.07.00.24.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2020 00:24:27 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 883CD1FFB7;
 Tue,  7 Jul 2020 08:09:01 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 30/41] tests/docker: add a linux-user testing focused image
Date: Tue,  7 Jul 2020 08:08:47 +0100
Message-Id: <20200707070858.6622-31-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200707070858.6622-1-alex.bennee@linaro.org>
References: <20200707070858.6622-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42f.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We happily use all the cross images for both cross-building QEMU as
well as building the linux-user tests. However calling docker from
within docker seems not to work. As we can build in Debian anyway why
not include an image that has all the compilers available for
non-docker invocation.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200701135652.1366-33-alex.bennee@linaro.org>

diff --git a/.gitlab-ci.d/containers.yml b/.gitlab-ci.d/containers.yml
index f353359fd8ba..a7621c4204c7 100644
--- a/.gitlab-ci.d/containers.yml
+++ b/.gitlab-ci.d/containers.yml
@@ -64,6 +64,13 @@ amd64-debian-cross-container:
   variables:
     NAME: debian-amd64-cross
 
+amd64-debian-user-cross-container:
+  <<: *container_job_definition
+  stage: containers-layer2
+  needs: ['amd64-debian10-container']
+  variables:
+    NAME: debian-all-test-cross
+
 amd64-debian-container:
   <<: *container_job_definition
   stage: containers-layer2
diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index a26177abc258..a104e9df2817 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -134,6 +134,7 @@ docker-image-travis: NOUSER=1
 
 # Specialist build images, sometimes very limited tools
 docker-image-debian-tricore-cross: docker-image-debian9
+docker-image-debian-all-test-cross: docker-image-debian10
 docker-image-debian-arm64-test-cross: docker-image-debian11
 
 # These images may be good enough for building tests but not for test builds
diff --git a/tests/docker/dockerfiles/debian-all-test-cross.docker b/tests/docker/dockerfiles/debian-all-test-cross.docker
new file mode 100644
index 000000000000..dedcea58b467
--- /dev/null
+++ b/tests/docker/dockerfiles/debian-all-test-cross.docker
@@ -0,0 +1,53 @@
+#
+# Docker all cross-compiler target (tests only)
+#
+# While the normal cross builds take care to setup proper multiarch
+# build environments which can cross build QEMU this just installs the
+# basic compilers for as many targets as possible. We shall use this
+# to build and run linux-user tests on GitLab
+#
+FROM qemu/debian10
+
+# What we need to build QEMU itself
+RUN apt update && \
+    DEBIAN_FRONTEND=noninteractive eatmydata \
+    apt build-dep -yy qemu
+
+# Add the foreign architecture we want and install dependencies
+RUN DEBIAN_FRONTEND=noninteractive eatmydata \
+        apt install -y --no-install-recommends \
+        gcc-aarch64-linux-gnu \
+        libc6-dev-arm64-cross \
+        gcc-alpha-linux-gnu \
+        libc6.1-dev-alpha-cross \
+        gcc-arm-linux-gnueabihf \
+        libc6-dev-armhf-cross \
+        gcc-hppa-linux-gnu \
+        libc6-dev-hppa-cross \
+        gcc-m68k-linux-gnu \
+        libc6-dev-m68k-cross \
+        gcc-mips-linux-gnu \
+        libc6-dev-mips-cross \
+        gcc-mips64-linux-gnuabi64 \
+        libc6-dev-mips64-cross \
+        gcc-mips64el-linux-gnuabi64 \
+        libc6-dev-mips64el-cross \
+        gcc-mipsel-linux-gnu \
+        libc6-dev-mipsel-cross \
+        gcc-powerpc-linux-gnu \
+        libc6-dev-powerpc-cross \
+        gcc-powerpc64-linux-gnu \
+        libc6-dev-ppc64-cross \
+        gcc-powerpc64le-linux-gnu \
+        libc6-dev-ppc64el-cross \
+        gcc-riscv64-linux-gnu \
+        libc6-dev-riscv64-cross \
+        gcc-s390x-linux-gnu \
+        libc6-dev-s390x-cross \
+        gcc-sh4-linux-gnu \
+        libc6-dev-sh4-cross \
+        gcc-sparc64-linux-gnu \
+        libc6-dev-sparc64-cross
+
+ENV QEMU_CONFIGURE_OPTS --disable-system --disable-docs --disable-tools
+ENV DEF_TARGET_LIST aarch64-linux-user,alpha-linux-user,arm-linux-user,hppa-linux-user,i386-linux-user,m68k-linux-user,mips-linux-user,mips64-linux-user,mips64el-linux-user,mipsel-linux-user,ppc-linux-user,ppc64-linux-user,ppc64le-linux-user,riscv64-linux-user,s390x-linux-user,sh4-linux-user,sparc64-linux-user
-- 
2.20.1


