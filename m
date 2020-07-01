Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73782C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 14:29:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41228206C3
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 14:29:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WlXD7kXT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41228206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36852 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqdjV-0004yv-Fq
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 10:29:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35314)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jqdUS-0006ZI-Gz
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 10:13:32 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a]:51098)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jqdUQ-0000A3-Iz
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 10:13:32 -0400
Received: by mail-wm1-x32a.google.com with SMTP id l17so22608870wmj.0
 for <qemu-devel@nongnu.org>; Wed, 01 Jul 2020 07:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=PJhXUCcF3c2PKDCFsCiaqFOmEKen6xlVm+g2tj8AYP8=;
 b=WlXD7kXTRinT7Nh0YWHeQjdrlpdwKW9wzLMBsuVgwCFPxDtx1THdoOTNvTmAoW+c6m
 uYX2DworzFB9U7oVOrQ5bZu/kk0jTpqeRG7JBe7DE/knr06Xsrkv2A0L9ScJBO5MlI15
 lGSIC6xnmIbMnPU9xnPt75lKLKFq+ZGYKLd70I7hwLVAyrh+ayuuJApL9t1NHDahY86u
 WS8pRCPL2nweFC9Dudd7htNV63Rqg6Wzi6rBU/KLBJHWDRB4BVH98zbWvpxe2sRUNFq7
 iRPw9m9424drJk2mcxRc/Q05+vbJY5uVby4UWKglAzKnmElti4YcRCcLWi5bHCPXqRRj
 2mnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=PJhXUCcF3c2PKDCFsCiaqFOmEKen6xlVm+g2tj8AYP8=;
 b=Rczy8EKcJWQ3jfdihvPk5Gtwg3/A4CuOu6w7A0dgjH15LnTBOkhiciU2gxmffjh2dQ
 uodOmVSuRQ+x1whc0FroZykB2RsByh/FsOMERJISiOfqds5mG/Jf/Tjjo2xt8j9OL2Ka
 mjZ5zwsHdZUCKpgjXakkAN4eLwJbbOdK8R0jxMoncrlTYX5KiVsL5XROz5A1bEDtJL6w
 hvv+SSb/iQ83hUsqPj53JdOUVjb7rw3MBwdu7b58CbkDADREoqNo+Bs7TkIT2BN/Ustt
 06lLygxMNWLMwqxULHUfvaubE0DJMtDhY9+o4KYK5hjTe2x3WSOAC4IdxZdOGoyjfDXQ
 RrEA==
X-Gm-Message-State: AOAM533xafsfMpSs5cu5MysSi8rrItPf/QgDGExFRh+BsAO13vAFs1ag
 dVVLaKJwpjeQ79zRD1w9R+ynag==
X-Google-Smtp-Source: ABdhPJyFeqTgxTB7qpx/e9QfQREZkFwCuxVWJNm1e0sXeL3mMBqdGOtfwzVYJABhr67ua3awDjP+9A==
X-Received: by 2002:a1c:4408:: with SMTP id r8mr26979777wma.100.1593612808833; 
 Wed, 01 Jul 2020 07:13:28 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id w2sm7835430wrs.77.2020.07.01.07.13.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2020 07:13:27 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 27B561FF8F;
 Wed,  1 Jul 2020 14:56:56 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 32/40] tests/docker: add a linux-user testing focused image
Date: Wed,  1 Jul 2020 14:56:44 +0100
Message-Id: <20200701135652.1366-33-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200701135652.1366-1-alex.bennee@linaro.org>
References: <20200701135652.1366-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32a.google.com
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
Cc: fam@euphon.net, berrange@redhat.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, f4bug@amsat.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, cota@braap.org,
 aurelien@aurel32.net
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
---
 .gitlab-ci.d/containers.yml                   |  7 +++
 tests/docker/Makefile.include                 |  1 +
 .../dockerfiles/debian-all-test-cross.docker  | 53 +++++++++++++++++++
 3 files changed, 61 insertions(+)
 create mode 100644 tests/docker/dockerfiles/debian-all-test-cross.docker

diff --git a/.gitlab-ci.d/containers.yml b/.gitlab-ci.d/containers.yml
index f353359fd8b..a7621c4204c 100644
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
index 977d8ff6e40..8406d039858 100644
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
index 00000000000..dedcea58b46
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


