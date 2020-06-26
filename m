Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B8DBC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 18:30:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BCF220836
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 18:30:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="podm8Phc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BCF220836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45126 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jot6w-0007kP-JK
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 14:30:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58324)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jot0B-0003ds-E8
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 14:23:03 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f]:44796)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jot09-00055f-Af
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 14:23:03 -0400
Received: by mail-wr1-x42f.google.com with SMTP id b6so10356875wrs.11
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2020 11:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=xUZG6tLp/xI8r3bd4dXEs/uYPfQvAur5hQZG/hEKfXs=;
 b=podm8PhcCmL7vam9aI9CPY+fYS9MtndrEkcOmhw8MQk++72Yuc43FVzU3vk10+0muO
 OHYf0eclrX9mL3phNozKFbraMeBKc+HpCcAYuNwe7XbHUly4m+NafwlWvaA/PMTrncSo
 FFUxpSBiu7G24wYTfj63pvyPsUeadOtO+MhHEdy6/7uHLizhi7Ratw/hGI0ViZkfJ6/j
 2s7Z5MjeCdCgkGyHV49f36Pd3EfwpoU+Ig7YpiJOo3uJ/dbZzWUy7m6scWTROV3lbrOa
 UcCnwWrIihHhsfXBKEliydKSpMYSdBelC+ZwjOUCI7AXoLWG9a8kpNGTzC+fRz2nwCWv
 lXdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=xUZG6tLp/xI8r3bd4dXEs/uYPfQvAur5hQZG/hEKfXs=;
 b=OUvUFaCdyAzR9y6icFNjFZacfeKiDpDtFwKdeKF+srKDDf9Z0DjzGPtnJKTpD9a604
 SFO6tAngGYupviGtSJTlqGRcFBJ38SoOwjx07e2F88YuCSld4SHeKqXYm0RIqka9Lru9
 Asej6EorQO2Vh/xMtq+mM+BCmCSsQwHwD9S0h4FtugfoE9kZ0ITdhEMlibreDbKogb8b
 dmUKN7lQ0Rt1YEM/uKkdR7kCSJ6j2paVQjWr6KY8/v5M5DYIao4eOXWRMcjWLu2CWZ7g
 76kJoyuLE+VjJPEJR01u8lFULbaOKxlgjNXp6F3tWj5RLqOvGOxfMu8978dbuoYHsuj+
 wmLw==
X-Gm-Message-State: AOAM532ZJy7XJVca1KUxJn5wVjgvHPqKxwCon7LxW3EuXC98KplJ2HkH
 gjKVKlxpYyfIi6maKuooI5VHLw==
X-Google-Smtp-Source: ABdhPJxo6zKuyUdIwOJz4uDUryeGy82n33hJD+nGjaO7b6mOUmJNkZsGXxNRzGm+438WrmeJeajkew==
X-Received: by 2002:adf:f2cd:: with SMTP id d13mr4821906wrp.378.1593195779870; 
 Fri, 26 Jun 2020 11:22:59 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id z16sm27768267wrr.35.2020.06.26.11.22.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2020 11:22:56 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id F189A1FFA5;
 Fri, 26 Jun 2020 19:14:01 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v3 19/30] gitlab: build all container images during CI
Date: Fri, 26 Jun 2020 19:13:46 +0100
Message-Id: <20200626181357.26211-20-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200626181357.26211-1-alex.bennee@linaro.org>
References: <20200626181357.26211-1-alex.bennee@linaro.org>
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
Cc: fam@euphon.net, Thomas Huth <thuth@redhat.com>, berrange@redhat.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, f4bug@amsat.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, cota@braap.org,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Daniel P. Berrangé <berrange@redhat.com>

We have a number of container images in tests/docker/dockerfiles
that are intended to provide well defined environments for doing
test builds. We want our CI system to use these containers too.

This introduces builds of all of them as the first stage in the
CI, so that the built containers are available for later build
jobs. The containers are setup to use the GitLab container
registry as the cache, so we only pay the penalty of the full
build when the dockerfiles change. The main qemu-project/qemu
repo is used as a second cache, so that users forking QEMU will
see a fast turnaround time on their CI jobs.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Message-Id: <20200622153318.751107-3-berrange@redhat.com>
[AJB: tweak the tag format]
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Acked-by: Thomas Huth <thuth@redhat.com>
---
 .gitlab-ci.d/containers.yml | 248 ++++++++++++++++++++++++++++++++++++
 .gitlab-ci.yml              |   3 +
 2 files changed, 251 insertions(+)
 create mode 100644 .gitlab-ci.d/containers.yml

diff --git a/.gitlab-ci.d/containers.yml b/.gitlab-ci.d/containers.yml
new file mode 100644
index 00000000000..580439647ef
--- /dev/null
+++ b/.gitlab-ci.d/containers.yml
@@ -0,0 +1,248 @@
+
+
+.container_job_template: &container_job_definition
+  image: docker:stable
+  stage: containers
+  services:
+    - docker:dind
+  before_script:
+    - export TAG="$CI_REGISTRY_IMAGE/qemu/$NAME:latest"
+    - export COMMON_TAG="$CI_REGISTRY/qemu-project/qemu/$NAME:latest"
+    - docker info
+    - docker login registry.gitlab.com -u "$CI_REGISTRY_USER" -p "$CI_REGISTRY_PASSWORD"
+  script:
+    - docker pull "$TAG" || docker pull "$COMMON_TAG" || true
+    - sed -i -e "s,FROM qemu/,FROM $CI_REGISTRY_IMAGE/qemu/," tests/docker/dockerfiles/$NAME.docker
+    - docker build --cache-from "$TAG" --cache-from "$COMMON_TAG" --tag "$TAG" -f "tests/docker/dockerfiles/$NAME.docker" tests/docker/dockerfiles
+    - docker push "$TAG"
+  after_script:
+    - docker logout
+
+amd64-centos7-container:
+  <<: *container_job_definition
+  variables:
+    NAME: centos7
+
+amd64-centos8-container:
+  <<: *container_job_definition
+  variables:
+    NAME: centos8
+
+amd64-debian10-container:
+  <<: *container_job_definition
+  variables:
+    NAME: debian10
+
+amd64-debian11-container:
+  <<: *container_job_definition
+  variables:
+    NAME: debian11
+
+amd64-debian9-container:
+  <<: *container_job_definition
+  variables:
+    NAME: debian9
+
+amd64-debian9-mxe-container:
+  <<: *container_job_definition
+  stage: containers-layer2
+  needs: ['amd64-debian9-container']
+  variables:
+    NAME: debian9-mxe
+
+alpha-debian-cross-container:
+  <<: *container_job_definition
+  stage: containers-layer2
+  needs: ['amd64-debian10-container']
+  variables:
+    NAME: debian-alpha-cross
+
+amd64-debian-cross-container:
+  <<: *container_job_definition
+  stage: containers-layer2
+  needs: ['amd64-debian10-container']
+  variables:
+    NAME: debian-amd64-cross
+
+amd64-debian-container:
+  <<: *container_job_definition
+  stage: containers-layer2
+  needs: ['amd64-debian10-container']
+  variables:
+    NAME: debian-amd64
+
+arm64-debian-cross-container:
+  <<: *container_job_definition
+  stage: containers-layer2
+  needs: ['amd64-debian10-container']
+  variables:
+    NAME: debian-arm64-cross
+
+arm64-test-debian-cross-container:
+  <<: *container_job_definition
+  stage: containers-layer2
+  needs: ['amd64-debian11-container']
+  variables:
+    NAME: debian-arm64-test-cross
+
+armel-debian-cross-container:
+  <<: *container_job_definition
+  stage: containers-layer2
+  needs: ['amd64-debian10-container']
+  variables:
+    NAME: debian-armel-cross
+
+armhf-debian-cross-container:
+  <<: *container_job_definition
+  stage: containers-layer2
+  needs: ['amd64-debian10-container']
+  variables:
+    NAME: debian-armhf-cross
+
+hppa-debian-cross-container:
+  <<: *container_job_definition
+  stage: containers-layer2
+  needs: ['amd64-debian10-container']
+  variables:
+    NAME: debian-hppa-cross
+
+m68k-debian-cross-container:
+  <<: *container_job_definition
+  stage: containers-layer2
+  needs: ['amd64-debian10-container']
+  variables:
+    NAME: debian-m68k-cross
+
+mips64-debian-cross-container:
+  <<: *container_job_definition
+  stage: containers-layer2
+  needs: ['amd64-debian10-container']
+  variables:
+    NAME: debian-mips64-cross
+
+mips64el-debian-cross-container:
+  <<: *container_job_definition
+  stage: containers-layer2
+  needs: ['amd64-debian10-container']
+  variables:
+    NAME: debian-mips64el-cross
+
+mips-debian-cross-container:
+  <<: *container_job_definition
+  stage: containers-layer2
+  needs: ['amd64-debian10-container']
+  variables:
+    NAME: debian-mips-cross
+
+mipsel-debian-cross-container:
+  <<: *container_job_definition
+  stage: containers-layer2
+  needs: ['amd64-debian10-container']
+  variables:
+    NAME: debian-mipsel-cross
+
+powerpc-debian-cross-container:
+  <<: *container_job_definition
+  stage: containers-layer2
+  needs: ['amd64-debian10-container']
+  variables:
+    NAME: debian-powerpc-cross
+
+ppc64-debian-cross-container:
+  <<: *container_job_definition
+  stage: containers-layer2
+  needs: ['amd64-debian10-container']
+  variables:
+    NAME: debian-ppc64-cross
+
+ppc64el-debian-cross-container:
+  <<: *container_job_definition
+  stage: containers-layer2
+  needs: ['amd64-debian10-container']
+  variables:
+    NAME: debian-ppc64el-cross
+
+riscv64-debian-cross-container:
+  <<: *container_job_definition
+  stage: containers-layer2
+  needs: ['amd64-debian10-container']
+  variables:
+    NAME: debian-riscv64-cross
+
+s390x-debian-cross-container:
+  <<: *container_job_definition
+  stage: containers-layer2
+  needs: ['amd64-debian10-container']
+  variables:
+    NAME: debian-s390x-cross
+
+sh4-debian-cross-container:
+  <<: *container_job_definition
+  stage: containers-layer2
+  needs: ['amd64-debian10-container']
+  variables:
+    NAME: debian-sh4-cross
+
+sparc64-debian-cross-container:
+  <<: *container_job_definition
+  stage: containers-layer2
+  needs: ['amd64-debian10-container']
+  variables:
+    NAME: debian-sparc64-cross
+
+tricore-debian-cross-container:
+  <<: *container_job_definition
+  stage: containers-layer2
+  needs: ['amd64-debian9-container']
+  variables:
+    NAME: debian-tricore-cross
+
+win32-debian-cross-container:
+  <<: *container_job_definition
+  stage: containers-layer3
+  needs: ['amd64-debian9-mxe-container']
+  variables:
+    NAME: debian-win32-cross
+
+win64-debian-cross-container:
+  <<: *container_job_definition
+  stage: containers-layer3
+  needs: ['amd64-debian9-mxe-container']
+  variables:
+    NAME: debian-win64-cross
+
+xtensa-debian-cross-container:
+  <<: *container_job_definition
+  variables:
+    NAME: debian-xtensa-cross
+
+cris-fedora-cross-container:
+  <<: *container_job_definition
+  variables:
+    NAME: fedora-cris-cross
+
+amd64-fedora-container:
+  <<: *container_job_definition
+  variables:
+    NAME: fedora
+
+i386-fedora-cross-container:
+  <<: *container_job_definition
+  variables:
+    NAME: fedora-i386-cross
+
+amd64-ubuntu1804-container:
+  <<: *container_job_definition
+  variables:
+    NAME: ubuntu1804
+
+amd64-ubuntu2004-container:
+  <<: *container_job_definition
+  variables:
+    NAME: ubuntu2004
+
+amd64-ubuntu-container:
+  <<: *container_job_definition
+  variables:
+    NAME: ubuntu
+
diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 9fdc752ea63..72d688875fd 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -1,10 +1,13 @@
 stages:
   - containers
+  - containers-layer2
+  - containers-layer3
   - build
 
 include:
   - local: '/.gitlab-ci.d/edk2.yml'
   - local: '/.gitlab-ci.d/opensbi.yml'
+  - local: '/.gitlab-ci.d/containers.yml'
 
 .update_apt_template: &before_script_apt
  before_script:
-- 
2.20.1


