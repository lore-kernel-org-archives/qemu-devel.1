Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A663C4363D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 15:55:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E336821741
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 15:55:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WDlysb+g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E336821741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49344 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLq44-0008E4-Q0
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 11:55:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36118)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kLpq2-0002uR-L7
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 11:40:47 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430]:35662)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kLppz-0007dL-Dr
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 11:40:46 -0400
Received: by mail-wr1-x430.google.com with SMTP id e16so4118022wrm.2
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2020 08:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=eh9l4eDfafTGoYLxQ+GPB5ox68P4ojNb8oAcdbH5jGQ=;
 b=WDlysb+gMfo6mFegX0NjYWcuQjoByML5H+/+QymSgKjCgidxBlW2M5iIrI7XajJ/MC
 wEEqfPBrjpNHjmRWHgzPUmNU7J5Zvt24hhGnh+5yoS2zTLPoXQOm6NohkdEeJrtGc7i9
 xWyEw1ftc8F7Dya72p0/2Yx1NDVmd7SuoNCnRCCM7JtzJXP5XmGSRhHCc3bZHmw7WXf4
 +Ny7ca07Pmcm61kxRHDVGLWejvuBszNWyI8vFkaRjOoWHKUnrLOj2LLDcDo71wlaHkan
 Ci4qBSLOKEzUJffm5HD2lLeZpyy1QcQkhWwPnBms1/5Ze0bcvwJ5hsPltLBfdmZUhZNu
 0LzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=eh9l4eDfafTGoYLxQ+GPB5ox68P4ojNb8oAcdbH5jGQ=;
 b=LaKPu84ETOXQF4zy+BzzFSv6C7GYwfiTbM389JqLv/GBg2IBGgySV93YELr9QYMUzG
 FM2w21JNgtue5e2snUa2Ajr+XW3l5C0rceQBiUNtIvmfRbBHmClnmC+nfnQIns+Bimta
 8Rph4+PIHbvRVGqVaqENr9j/RozT0o9GjvJS/25WJabStYjCxWMwLTvRcIMixd6WsP0x
 d3jpSCVuupjnkh2mvv9TUvL5/iwDMZ8EIMiOWt5F5m2x6huU+8KDHQGG8Y/OTFdfzVHd
 wakZHpD9Cicn7wN41S55Z3eC6WILty3m2Y5crEG9JFmVghrmLdI23ZHQ64GoBwq+hMVW
 paAg==
X-Gm-Message-State: AOAM532SSk8aNSwTDJeok2qR6ewUSFm/2maiEnL7wXfg/nKUOmTCCZVF
 UV7VjGrNd5lZq5fdFco0WkVLLw==
X-Google-Smtp-Source: ABdhPJxIIfCXiY8Dz+M0BV01+Jl8OpnnUrgCpzaqx9tiLONLK9MzKB9+QeJbkCM0hqAWrQWetynSUg==
X-Received: by 2002:a5d:4d51:: with SMTP id a17mr5143400wru.248.1601048440682; 
 Fri, 25 Sep 2020 08:40:40 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id l126sm3353271wmf.39.2020.09.25.08.40.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2020 08:40:37 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 965AF1FF98;
 Fri, 25 Sep 2020 16:40:29 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 09/15] tests/docker: Use Fedora containers for MinGW
 cross-builds in the gitlab-CI
Date: Fri, 25 Sep 2020 16:40:21 +0100
Message-Id: <20200925154027.12672-10-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200925154027.12672-1-alex.bennee@linaro.org>
References: <20200925154027.12672-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x430.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Thomas Huth <thuth@redhat.com>

According to our support policy, we do not support Debian 9 in QEMU
anymore, and we only support building the Windows binaries with a
very recent version of the MinGW toolchain. So we should not test
the MinGW cross-compilation with Debian 9 anymore, but switch to
something newer like Fedora. To do this, we need a separate Fedora
container for each build that provides the QEMU_CONFIGURE_OPTS
environment variable.
Unfortunately, the MinGW 64-bit compiler seems to be a little bit
slow, so we also have to disable some features like "capstone" in the
build here to make sure that the CI pipelines still finish within a
reasonable amount of time.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20200921174320.46062-2-thuth@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .gitlab-ci.d/containers.yml                   | 10 +++++
 .gitlab-ci.d/crossbuilds.yml                  |  4 +-
 .../dockerfiles/fedora-win32-cross.docker     | 42 +++++++++++++++++++
 .../dockerfiles/fedora-win64-cross.docker     | 38 +++++++++++++++++
 4 files changed, 92 insertions(+), 2 deletions(-)
 create mode 100644 tests/docker/dockerfiles/fedora-win32-cross.docker
 create mode 100644 tests/docker/dockerfiles/fedora-win64-cross.docker

diff --git a/.gitlab-ci.d/containers.yml b/.gitlab-ci.d/containers.yml
index 8c89efeb6d4b..15e7b564f91f 100644
--- a/.gitlab-ci.d/containers.yml
+++ b/.gitlab-ci.d/containers.yml
@@ -248,6 +248,16 @@ i386-fedora-cross-container:
   variables:
     NAME: fedora-i386-cross
 
+win32-fedora-cross-container:
+  <<: *container_job_definition
+  variables:
+    NAME: fedora-win32-cross
+
+win64-fedora-cross-container:
+  <<: *container_job_definition
+  variables:
+    NAME: fedora-win64-cross
+
 amd64-ubuntu1804-container:
   <<: *container_job_definition
   variables:
diff --git a/.gitlab-ci.d/crossbuilds.yml b/.gitlab-ci.d/crossbuilds.yml
index 4ec7226b5c3c..510cfec03bb7 100644
--- a/.gitlab-ci.d/crossbuilds.yml
+++ b/.gitlab-ci.d/crossbuilds.yml
@@ -105,9 +105,9 @@ cross-s390x-user:
 cross-win32-system:
   <<: *cross_system_build_job_definition
   variables:
-    IMAGE: debian-win32-cross
+    IMAGE: fedora-win32-cross
 
 cross-win64-system:
   <<: *cross_system_build_job_definition
   variables:
-    IMAGE: debian-win64-cross
+    IMAGE: fedora-win64-cross
diff --git a/tests/docker/dockerfiles/fedora-win32-cross.docker b/tests/docker/dockerfiles/fedora-win32-cross.docker
new file mode 100644
index 000000000000..5903e1b0b44b
--- /dev/null
+++ b/tests/docker/dockerfiles/fedora-win32-cross.docker
@@ -0,0 +1,42 @@
+FROM fedora:32
+
+# Please keep this list sorted alphabetically
+ENV PACKAGES \
+    bc \
+    bzip2 \
+    diffutils \
+    findutils \
+    gcc \
+    gettext \
+    git \
+    hostname \
+    make \
+    meson \
+    mingw32-bzip2 \
+    mingw32-curl \
+    mingw32-glib2 \
+    mingw32-gmp \
+    mingw32-gnutls \
+    mingw32-gtk3 \
+    mingw32-libjpeg-turbo \
+    mingw32-libpng \
+    mingw32-libtasn1 \
+    mingw32-nettle \
+    mingw32-nsis \
+    mingw32-pixman \
+    mingw32-pkg-config \
+    mingw32-SDL2 \
+    perl \
+    perl-Test-Harness \
+    python3 \
+    python3-PyYAML \
+    python3-setuptools \
+    tar \
+    which
+
+RUN dnf install -y $PACKAGES
+RUN rpm -q $PACKAGES | sort > /packages.txt
+ENV FEATURES mingw
+
+# Specify the cross prefix for this image (see tests/docker/common.rc)
+ENV QEMU_CONFIGURE_OPTS --cross-prefix=i686-w64-mingw32-
diff --git a/tests/docker/dockerfiles/fedora-win64-cross.docker b/tests/docker/dockerfiles/fedora-win64-cross.docker
new file mode 100644
index 000000000000..7f03cd8ffca6
--- /dev/null
+++ b/tests/docker/dockerfiles/fedora-win64-cross.docker
@@ -0,0 +1,38 @@
+FROM fedora:32
+
+# Please keep this list sorted alphabetically
+ENV PACKAGES \
+    bc \
+    bzip2 \
+    diffutils \
+    findutils \
+    gcc \
+    gettext \
+    git \
+    hostname \
+    make \
+    meson \
+    mingw64-bzip2 \
+    mingw64-curl \
+    mingw64-glib2 \
+    mingw64-gmp \
+    mingw64-gtk3 \
+    mingw64-libjpeg-turbo \
+    mingw64-libpng \
+    mingw64-libtasn1 \
+    mingw64-pixman \
+    mingw64-pkg-config \
+    perl \
+    perl-Test-Harness \
+    python3 \
+    python3-PyYAML \
+    python3-setuptools \
+    tar \
+    which
+
+RUN dnf install -y $PACKAGES
+RUN rpm -q $PACKAGES | sort > /packages.txt
+ENV FEATURES mingw
+
+# Specify the cross prefix for this image (see tests/docker/common.rc)
+ENV QEMU_CONFIGURE_OPTS --cross-prefix=x86_64-w64-mingw32- --disable-capstone
-- 
2.20.1


