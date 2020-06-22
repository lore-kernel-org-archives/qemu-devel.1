Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0941C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 14:51:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97AEA20732
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 14:51:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rK0ik3pe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97AEA20732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55386 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnNnb-0003e6-TM
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 10:51:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41218)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jnNZk-00061J-7g
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 10:37:32 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333]:36332)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jnNZh-0006a8-RG
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 10:37:31 -0400
Received: by mail-wm1-x333.google.com with SMTP id 17so1410850wmo.1
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2020 07:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=kpO6jorqg4gFYmKvuQF8bVTYfoSxIW2vkh7ytMeEuyk=;
 b=rK0ik3peQ8vYDiJvOQixOTa6eSoI47JBg277LPIRPimM9dnIEzuHvdb97m9kkNK4+J
 BZqEGhD/2xQvsthTGuHxTYPmssYHb213SIHaF8gutSFE1RzHuLj8bX2LNdU2VtEBhcRS
 7tFWzTTQ1Wj79dydAE+7oXghK/jwqyNmQ9VBL53/xVHTB8+ZyYRcV4CSDwPmCDX83cvF
 MjHTl/XsDhhK5E3rgE48W1Z2rKfQK3w486vuZtkV43jddT4pLVEjGD5g0fa+RqhOnmNy
 vutLqoSYlrjAm8ZM9QZ4wvGSq9a+snSgdb4pkyMoHcTZu7oxnh8JasiEdocKtJmK4QXA
 sEFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=kpO6jorqg4gFYmKvuQF8bVTYfoSxIW2vkh7ytMeEuyk=;
 b=MA5JnXHtPeknz4jmTrPpYaeQ7u1ggpcNtNn6rnTOqhOZ6RLI4XkAsyCJZhg+gA8UyE
 uneMU+dU7R9WHwH7xY4Mc7yzUq937abC+zaJn3CVriqfOTGlRseUd1E8YJwjP5FWIeL8
 /K3I+fcpqXfp27yzd9QorlWSGGA5IgkEnP9eFaPL6OHzlCrqpxzZpCJCaofbLqctz1zv
 chaaEho8g7n1mSgcqE3UDhNgbciH9Pf0uHeaORWOEyWa9z28n/5tsYUhAcN3Dse0J28l
 q+5dYIsjS9gQ+1ITJckqvOsORWikCIseyu6JR275+FHwcN1HspBu641EKWyDDAKMh9lq
 kDYA==
X-Gm-Message-State: AOAM533M5duMzBi2uhrdyHhpxMd0sSGYVmid1y+kynYFZ+kPY2sBCwdy
 /Hs9hqBe9NFpfuhLb2lUmkx0zA==
X-Google-Smtp-Source: ABdhPJyYz9E6Vk3PxbiNHnGQaHsdAz75ABnNjB0a/SH3bbQ2MXRZlXZDVZgirsO/O7Xd0roCMi9SnQ==
X-Received: by 2002:a1c:f203:: with SMTP id s3mr16955752wmc.126.1592836648326; 
 Mon, 22 Jun 2020 07:37:28 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id 138sm17498376wma.23.2020.06.22.07.37.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2020 07:37:25 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 36FFC1FF9E;
 Mon, 22 Jun 2020 15:32:06 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 15/18] .gitlab: add acceptance testing to system builds
Date: Mon, 22 Jun 2020 15:32:01 +0100
Message-Id: <20200622143204.12921-16-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200622143204.12921-1-alex.bennee@linaro.org>
References: <20200622143204.12921-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x333.google.com
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

As part of migrating things from Travis to GitLab add the acceptance
tests. To do this:

  - split system1 into ubuntu-main and debian-alt
  - use artifacts to save build stage
  - rename system2 to fedora-misc
  - split into build/check/acceptance
  - remove -j from check stages
  - add packages needed for acceptance
  - add post acceptance template and use

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .gitlab-ci.yml | 122 ++++++++++++++++++++++++++++++++++++++++++++++---
 .travis.yml    |  23 ----------
 2 files changed, 115 insertions(+), 30 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 349c77aa580..fc3a561d9bc 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -1,3 +1,15 @@
+#
+# Currently we have two build stages:
+#  - build (for traditional build and test or first stage build)
+#  - test (for test stages, using build artefacts from a build stage)
+stages:
+  - build
+  - test
+
+variables:
+  BASE_CONFIG: "--disable-docs"
+  MAIN_SOFTMMU_TARGETS: "aarch64-softmmu,mips64-softmmu,ppc64-softmmu,riscv64-softmmu,s390x-softmmu,x86_64-softmmu"
+
 include:
   - local: '/.gitlab-ci.d/edk2.yml'
   - local: '/.gitlab-ci.d/opensbi.yml'
@@ -16,22 +28,93 @@ include:
         make python3 perl-podlators perl-Test-Harness pixman-devel zlib-devel
   - JOBS=$(expr $(nproc) + 1)
 
-build-system1:
+.post_acceptance_template: &post_acceptance
+  after_script:
+    - python3 -c 'import json; r = json.load(open("tests/results/latest/results.json")); [print(t["logfile"]) for t in r["tests"] if t["status"] not in ("PASS", "SKIP")]' | xargs cat
+      - du -chs $HOME/avocado/data/cache
+
+build:system-ubuntu-main:
  image: ubuntu:19.10
+ stage: build
  <<: *before_script_apt
  script:
  - apt-get install -y -qq libgtk-3-dev libvte-dev nettle-dev libcacard-dev
       libusb-dev libvde-dev libspice-protocol-dev libgl1-mesa-dev libvdeplug-dev
  - mkdir build
  - cd build
- - ../configure --enable-werror --target-list="aarch64-softmmu alpha-softmmu
-      cris-softmmu hppa-softmmu lm32-softmmu moxie-softmmu microblazeel-softmmu
-      mips64el-softmmu m68k-softmmu ppc-softmmu riscv64-softmmu sparc-softmmu"
+ - ../configure ${BASE_CONFIG} --enable-werror --target-list="${MAIN_SOFTMMU_TARGETS}"
  - make -j"$JOBS"
- - make -j"$JOBS" check
+ artifacts:
+   paths:
+     - build
 
-build-system2:
+check:system-ubuntu-main:
+ image: ubuntu:19.10
+ stage: test
+ dependencies:
+ - build:system-ubuntu-main
+ <<: *before_script_apt
+ script:
+ - cd build
+ - make check
+
+acceptance:system-ubuntu-main:
+ image: ubuntu:19.10
+ stage: test
+ dependencies:
+ - build:system-ubuntu-main
+ <<: *before_script_apt
+ script:
+ - DEBIAN_FRONTEND=noninteractive apt-get install -y -qq
+    python3-pil python3-pip python3-numpy python3-opencv python3-venv
+    rpm2cpio tesseract-ocr tesseract-ocr-eng
+ - cd build
+ - make check-acceptance
+ <<: *post_acceptance
+
+build:system-debian-alt:
+ image: debian:buster-slim
+ stage: build
+ <<: *before_script_apt
+ script:
+ - apt-get install -y -qq libgtk-3-dev libvte-dev nettle-dev libcacard-dev
+      libusb-dev libvde-dev libspice-protocol-dev libgl1-mesa-dev libvdeplug-dev
+ - mkdir build
+ - cd build
+ - ../configure ${BASE_CONFIG} --enable-werror --disable-user
+     --target-list-exclude="${MAIN_SOFTMMU_TARGETS}"
+ - make -j"$JOBS"
+ artifacts:
+   paths:
+     - build
+
+check:system-debian-alt:
+ image: debian:buster-slim
+ stage: test
+ dependencies:
+ - build:system-debian-alt
+ <<: *before_script_apt
+ script:
+ - cd build
+ - make check
+
+acceptance:system-debian-alt:
+ image: debian:buster-slim
+ stage: test
+ dependencies:
+ - build:system-debian-alt
+ <<: *before_script_apt
+ script:
+ - DEBIAN_FRONTEND=noninteractive apt-get install -y -qq
+    python3-pil python3-pip python3-numpy python3-opencv python3-venv
+    rpm2cpio tesseract-ocr tesseract-ocr-eng
+ - cd build
+ - make check-acceptance
+ <<: *post_acceptance
+
+build:system-fedora-misc:
  image: fedora:latest
+ stage: build
  <<: *before_script_dnf
  script:
  - yum install -y SDL2-devel libgcrypt-devel brlapi-devel libaio-devel
@@ -43,7 +126,32 @@ build-system2:
       microblaze-softmmu mips-softmmu riscv32-softmmu s390x-softmmu sh4-softmmu
       sparc64-softmmu x86_64-softmmu xtensa-softmmu nios2-softmmu or1k-softmmu"
  - make -j"$JOBS"
- - make -j"$JOBS" check
+ artifacts:
+   paths:
+     - build
+
+check:system-fedora-misc:
+ image: fedora:latest
+ stage: test
+ dependencies:
+ - build:system-fedora-misc
+ <<: *before_script_dnf
+ script:
+ - cd build
+ - make check
+
+acceptance:system-fedora-misc:
+ image: fedora:latest
+ stage: test
+ dependencies:
+ - build:system-fedora-misc
+ <<: *before_script_dnf
+ script:
+ - yum install -y python3-pillow python3-pip python3-numpy python3-opencv
+       python3-virtualenv tesseract tesseract-langpack-eng
+ - cd build
+ - make check-acceptance
+ <<: *post_acceptance
 
 build-disabled:
  image: fedora:latest
diff --git a/.travis.yml b/.travis.yml
index 74158f741b1..c24dfbe377f 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -289,29 +289,6 @@ jobs:
       python: 3.6
 
 
-    # Acceptance (Functional) tests
-    - name: "GCC check-acceptance"
-      dist: bionic
-      env:
-        - CONFIG="--enable-tools --target-list=aarch64-softmmu,alpha-softmmu,arm-softmmu,m68k-softmmu,microblaze-softmmu,mips-softmmu,mips64el-softmmu,nios2-softmmu,or1k-softmmu,ppc-softmmu,ppc64-softmmu,s390x-softmmu,sh4-softmmu,sparc-softmmu,x86_64-softmmu,xtensa-softmmu"
-        - TEST_CMD="make check-acceptance"
-        - CACHE_NAME="${TRAVIS_BRANCH}-linux-gcc-acceptance"
-      after_script:
-        - python3 -c 'import json; r = json.load(open("tests/results/latest/results.json")); [print(t["logfile"]) for t in r["tests"] if t["status"] not in ("PASS", "SKIP")]' | xargs cat
-        - du -chs $HOME/avocado/data/cache
-      addons:
-        apt:
-          packages:
-            - python3-pil
-            - python3-pip
-            - python3-numpy
-            - python3-opencv
-            - python3-venv
-            - rpm2cpio
-            - tesseract-ocr
-            - tesseract-ocr-eng
-
-
     # Using newer GCC with sanitizers
     - name: "GCC9 with sanitizers (softmmu)"
       addons:
-- 
2.20.1


