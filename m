Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97F59C11D30
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 13:41:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 658A520836
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 13:41:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uXA1/ncS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 658A520836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36576 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6Dzd-0004b5-I7
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 08:41:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42479)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bmeng.cn@gmail.com>) id 1j6DyU-0002oM-6j
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 08:40:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1j6DyR-0004Ua-67
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 08:40:42 -0500
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:33376)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1j6DyQ-0004Tn-Jp; Mon, 24 Feb 2020 08:40:39 -0500
Received: by mail-pg1-x542.google.com with SMTP id 6so5199802pgk.0;
 Mon, 24 Feb 2020 05:40:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=GiVymLUWzPF/XMnmP5bYNn3nnFnf51PRY5iUVcoEtz8=;
 b=uXA1/ncSFfx757YyInCFyM7ku9Z9Y2ELHjdl8TI/U7icxJS/+ig/17/DIsb8JbVQ7h
 7XY/oZg3D7/Efa4blWmKnFvxp8mGpeWalOEqnUrq94+bU2qiFLXj8T8GfOwREfD60NvW
 8sTH4c5GNDZAa8GjRyAT0zmrh++4v+Lr34/EwpOem3rJJKoSiWt3E1MZxFK8WlsnAyAg
 7ikclhgNyUj6D8EqmD1OBEmVEfMn9Lo5X+Kxl6ohZ576fF/66rdEyNpWpGq9XqdGACQ9
 9mM0hDnF+7SAwfGAObpW6UtAJQFIeJTNVWj2oQ5WHOtFxM8I86J4tQJ0I3lt3kRgE+Yo
 LfyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=GiVymLUWzPF/XMnmP5bYNn3nnFnf51PRY5iUVcoEtz8=;
 b=Wmd7bxJ8y7PhnbVJgg2OpBeMS6C/DYsf3cC2d5U2u6uqkV994jThfJLLu5rh2ADhj7
 BXlyTRlJXdccvi53mRggM8iOVPROPguftZpTeeM4P7aBdtwncbrdXzqIpDiEXX3i62B6
 K6NbX6TmybT8pYhehj3OWC/FHiK5e/EeOHL23hWqMk2opc0RFEXQqP4FUcjW96HVNvP7
 gOprQatK4ptIvxxF2P32/Sk9Olaogr8ZigSARz8HLh989WdtrgwcufY9HvnIyHzyqTRe
 m6OlTuDSZ6BsEKZOupDx6A8MuPsih6g6aKSbHeduMAiuh94bCbJZwyf3UrH1ZF0iwQhz
 8+gQ==
X-Gm-Message-State: APjAAAXuv6zIaiq6c7Y8jPu5uYkYAmo42O+YbJ5WWET1TOCMGqj/dqcC
 jUQY5dmp7B6WFwsfLYo6L+Q=
X-Google-Smtp-Source: APXvYqy3RRHWevRWQyi57j4SMAQzNUFyG3WnRNio5UqDeP8HiwB8oj1OL8Ou+KfJppIHR5vAkeqNNA==
X-Received: by 2002:aa7:85d9:: with SMTP id z25mr52932703pfn.223.1582551637476; 
 Mon, 24 Feb 2020 05:40:37 -0800 (PST)
Received: from localhost.localdomain (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id p4sm12912258pgh.14.2020.02.24.05.40.36
 (version=TLS1 cipher=AES128-SHA bits=128/128);
 Mon, 24 Feb 2020 05:40:37 -0800 (PST)
From: Bin Meng <bmeng.cn@gmail.com>
To: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmerdabbelt@google.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Subject: [PATCH v2 4/4] gitlab-ci.yml: Add jobs to build OpenSBI firmware
 binaries
Date: Mon, 24 Feb 2020 05:39:44 -0800
Message-Id: <1582551584-20093-5-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1582551584-20093-1-git-send-email-bmeng.cn@gmail.com>
References: <1582551584-20093-1-git-send-email-bmeng.cn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::542
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add two GitLab jobs to build the OpenSBI firmware binaries.

The first job builds a Docker image with the packages requisite
to build OpenSBI, and stores this image in the GitLab registry.
The second job pulls the image from the registry and builds the
OpenSBI firmware binaries.

The docker image is only rebuilt if the GitLab YAML or the
Dockerfile is updated. The second job is only built when the
roms/opensbi/ submodule is updated, when a git-ref starts with
'opensbi' or when the last commit contains 'OpenSBI'. The files
generated are archived in the artifacts.zip file.

With OpenSBI v0.6, it took 2 minutes 56 seconds to build
the docker image, and 1 minute 24 seconds to generate the
artifacts.zip with the firmware binaries (filesize: 111KiB).

See: https://gitlab.com/lbmeng/qemu/pipelines/120520138

Suggested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Bin Meng <bmeng.cn@gmail.com>

---

Changes in v2:
- new patch: Add GitLab jobs to build OpenSBI firmware binaries

 .gitlab-ci-opensbi.yml          | 63 +++++++++++++++++++++++++++++++++++++++++
 .gitlab-ci.d/opensbi/Dockerfile | 33 +++++++++++++++++++++
 .gitlab-ci.yml                  |  1 +
 3 files changed, 97 insertions(+)
 create mode 100644 .gitlab-ci-opensbi.yml
 create mode 100644 .gitlab-ci.d/opensbi/Dockerfile

diff --git a/.gitlab-ci-opensbi.yml b/.gitlab-ci-opensbi.yml
new file mode 100644
index 0000000..dd051c0
--- /dev/null
+++ b/.gitlab-ci-opensbi.yml
@@ -0,0 +1,63 @@
+docker-opensbi:
+ stage: build
+ rules: # Only run this job when the Dockerfile is modified
+ - changes:
+   - .gitlab-ci-opensbi.yml
+   - .gitlab-ci.d/opensbi/Dockerfile
+   when: always
+ image: docker:19.03.1
+ services:
+ - docker:19.03.1-dind
+ variables:
+  GIT_DEPTH: 3
+  IMAGE_TAG: $CI_REGISTRY_IMAGE:opensbi-cross-build
+  # We don't use TLS
+  DOCKER_HOST: tcp://docker:2375
+  DOCKER_TLS_CERTDIR: ""
+ before_script:
+ - docker login -u $CI_REGISTRY_USER -p $CI_REGISTRY_PASSWORD $CI_REGISTRY
+ script:
+ - docker pull $IMAGE_TAG || true
+ - docker build --cache-from $IMAGE_TAG --tag $CI_REGISTRY_IMAGE:$CI_COMMIT_SHA
+                                        --tag $IMAGE_TAG .gitlab-ci.d/opensbi
+ - docker push $CI_REGISTRY_IMAGE:$CI_COMMIT_SHA
+ - docker push $IMAGE_TAG
+
+build-opensbi:
+ rules: # Only run this job when ...
+ - changes: # ... roms/opensbi/ is modified (submodule updated)
+   - roms/opensbi/*
+   when: always
+ - if: '$CI_COMMIT_REF_NAME =~ /^opensbi/' # or the branch/tag starts with 'opensbi'
+   when: always
+ - if: '$CI_COMMIT_MESSAGE =~ /opensbi/i' # or last commit description contains 'OpenSBI'
+   when: always
+ artifacts:
+   paths: # 'artifacts.zip' will contains the following files:
+   - pc-bios/opensbi-riscv32-sifive_u-fw_jump.bin
+   - pc-bios/opensbi-riscv32-virt-fw_jump.bin
+   - pc-bios/opensbi-riscv64-sifive_u-fw_jump.bin
+   - pc-bios/opensbi-riscv64-virt-fw_jump.bin
+   - opensbi32-virt-stdout.log
+   - opensbi32-virt-stderr.log
+   - opensbi64-virt-stdout.log
+   - opensbi64-virt-stderr.log
+   - opensbi32-sifive_u-stdout.log
+   - opensbi32-sifive_u-stderr.log
+   - opensbi64-sifive_u-stdout.log
+   - opensbi64-sifive_u-stderr.log
+ image: $CI_REGISTRY_IMAGE:opensbi-cross-build
+ variables:
+   GIT_DEPTH: 3
+ script: # Clone the required submodules and build OpenSBI
+ - git submodule update --init roms/opensbi
+ - export JOBS=$(($(getconf _NPROCESSORS_ONLN) + 1))
+ - echo "=== Using ${JOBS} simultaneous jobs ==="
+ - make -j${JOBS} -C roms/opensbi clean
+ - make -j${JOBS} -C roms opensbi32-virt 2>&1 1>opensbi32-virt-stdout.log | tee -a opensbi32-virt-stderr.log >&2
+ - make -j${JOBS} -C roms/opensbi clean
+ - make -j${JOBS} -C roms opensbi64-virt 2>&1 1>opensbi64-virt-stdout.log | tee -a opensbi64-virt-stderr.log >&2
+ - make -j${JOBS} -C roms/opensbi clean
+ - make -j${JOBS} -C roms opensbi32-sifive_u 2>&1 1>opensbi32-sifive_u-stdout.log | tee -a opensbi32-sifive_u-stderr.log >&2
+ - make -j${JOBS} -C roms/opensbi clean
+ - make -j${JOBS} -C roms opensbi64-sifive_u 2>&1 1>opensbi64-sifive_u-stdout.log | tee -a opensbi64-sifive_u-stderr.log >&2
diff --git a/.gitlab-ci.d/opensbi/Dockerfile b/.gitlab-ci.d/opensbi/Dockerfile
new file mode 100644
index 0000000..4ba8a4d
--- /dev/null
+++ b/.gitlab-ci.d/opensbi/Dockerfile
@@ -0,0 +1,33 @@
+#
+# Docker image to cross-compile OpenSBI firmware binaries
+#
+FROM ubuntu:18.04
+
+MAINTAINER Bin Meng <bmeng.cn@gmail.com>
+
+# Install packages required to build OpenSBI
+RUN apt update \
+    && \
+    \
+    DEBIAN_FRONTEND=noninteractive \
+    apt install --assume-yes --no-install-recommends \
+        build-essential \
+        ca-certificates \
+        git \
+        make \
+        wget \
+    && \
+    \
+    rm -rf /var/lib/apt/lists/*
+
+# Manually install the kernel.org "Crosstool" based toolchains for gcc-8.3
+RUN wget -O - \
+    https://mirrors.edge.kernel.org/pub/tools/crosstool/files/bin/x86_64/8.3.0/x86_64-gcc-8.3.0-nolibc-riscv32-linux.tar.xz \
+    | tar -C /opt -xJ
+RUN wget -O - \
+    https://mirrors.edge.kernel.org/pub/tools/crosstool/files/bin/x86_64/8.3.0/x86_64-gcc-8.3.0-nolibc-riscv64-linux.tar.xz \
+    | tar -C /opt -xJ
+
+# Export the toolchains to the system path
+ENV PATH="/opt/gcc-8.3.0-nolibc/riscv32-linux/bin:${PATH}"
+ENV PATH="/opt/gcc-8.3.0-nolibc/riscv64-linux/bin:${PATH}"
diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index c15e394..4c3a72b 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -1,5 +1,6 @@
 include:
   - local: '/.gitlab-ci-edk2.yml'
+  - local: '/.gitlab-ci-opensbi.yml'
 
 before_script:
  - apt-get update -qq
-- 
2.7.4


