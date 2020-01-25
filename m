Return-Path: <SRS0=4gpF=3O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47786C2D0DB
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jan 2020 18:32:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F284F2071A
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jan 2020 18:32:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nVL1NFH0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F284F2071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56412 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ivQEP-0005Ea-4m
	for qemu-devel@archiver.kernel.org; Sat, 25 Jan 2020 13:32:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55172)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ivQDh-0004bv-9V
 for qemu-devel@nongnu.org; Sat, 25 Jan 2020 13:31:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ivQDf-0006AJ-Ad
 for qemu-devel@nongnu.org; Sat, 25 Jan 2020 13:31:45 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:34244)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ivQDd-00066L-Pv
 for qemu-devel@nongnu.org; Sat, 25 Jan 2020 13:31:43 -0500
Received: by mail-wr1-x442.google.com with SMTP id t2so5986671wrr.1
 for <qemu-devel@nongnu.org>; Sat, 25 Jan 2020 10:31:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=zDafEbVpcwhtJJ3rI5Ital1XdIiNBL8k/kxtcciPuus=;
 b=nVL1NFH0WxcAsxkFLjNYBFoI1SoAccOsMbmsTaF86cYlEHySOcB2iLMs3Wogtqi5Pp
 g2YPbJm3djhxm+XQayhQpCPnUFmD2dQ84ZBlRkbWZxXuqHiiZvZ59Zr6R2wMnHWWtHgo
 xnDjMlp6KCUeDtioQcdKDJW3SU9v+QFRZN6tw5pLJJqYJ1ZmB4RPuKzHlEBUWuO40Lhe
 W64VoM4NN0xtlIGxuCBnjiIKsU0UNDbNwwPfPr7pwOTgZGeq+X9GomboMLpcM4gF0kPJ
 D5eQF1MfVHZxS0Nl+6jUGhbfSbLVraDxgI1tTk2BVuvIf2M/DzW+KdCixjlJDayZoVzw
 QdjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=zDafEbVpcwhtJJ3rI5Ital1XdIiNBL8k/kxtcciPuus=;
 b=tXWpaOmh1mypb/E85yLYNjMmKHSrrz178Lo5ZMn49K5v6h1RQBNW6C+4VhI1xbHWrD
 kb+UtzYDgcz9RKYA52BoLgACb380ESfEFE7CT5NeqdQM7hZjtfSxyBPGRUVSVE0oX7lp
 bOzDnKf5pOzqbvQ2qYNyuvAIJdMSY1pjrKu1V3M2YW8ETOQp2lLwjmuDv8o+us5/0kfY
 00r5QeL+R0p0BWjs4QhkOUVvkNg3k/gVQSdvL5DxnkRstDuxW27sWhLLLYDGKHyzmOAV
 BH23IFnpCgT6qTbgmqxGwbQatQuwwjsd68aoIeP2BI/XgGM50YJzifqjkAemBGDNX+G3
 TC3Q==
X-Gm-Message-State: APjAAAV3zPZ4Iy+TPbyBP1AKUT4iU9oREiFR6PsAubvel1O9POB7Vl8a
 Lxn7Wl2U8F622Uk/P2OALQDU4tMC
X-Google-Smtp-Source: APXvYqxzXFSZYPxOJyh9rJuIhJvVO6ZfZ74Q+rf1p1e47dAeZbzs/xFJDsaZzH2xicbu2ydvzVLlCg==
X-Received: by 2002:a5d:51cc:: with SMTP id n12mr11496614wrv.177.1579977099635; 
 Sat, 25 Jan 2020 10:31:39 -0800 (PST)
Received: from localhost.localdomain
 (113.red-83-57-172.dynamicip.rima-tde.net. [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id g21sm11586084wmh.17.2020.01.25.10.31.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 25 Jan 2020 10:31:38 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] .travis.yml: Add description to each job
Date: Sat, 25 Jan 2020 19:31:35 +0100
Message-Id: <20200125183135.28317-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The NAME variable can be used to describe nicely a job (see [*]).
As we currently have 32 jobs, use it. This helps for quickly
finding a particular job.

  before: https://travis-ci.org/qemu/qemu/builds/639887646
  after: https://travis-ci.org/philmd/qemu/builds/641795043

[*] https://docs.travis-ci.com/user/customizing-the-build/#naming-jobs-within-matrices

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 .travis.yml | 101 ++++++++++++++++++++++++++++++++++------------------
 1 file changed, 67 insertions(+), 34 deletions(-)

diff --git a/.travis.yml b/.travis.yml
index 6c1038a0f1..d68e35a2c5 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -94,24 +94,28 @@ after_script:
 
 matrix:
   include:
-    - env:
+    - name: "[x86] GCC static (user)"
+      env:
         - CONFIG="--disable-system --static"
         - CACHE_NAME="${TRAVIS_BRANCH}-linux-gcc-default"
 
 
     # we split the system builds as it takes a while to build them all
-    - env:
+    - name: "[x86] GCC (main-softmmu)"
+      env:
         - CONFIG="--disable-user --target-list=${MAIN_SOFTMMU_TARGETS}"
         - CACHE_NAME="${TRAVIS_BRANCH}-linux-gcc-default"
 
 
-    - env:
-        - CONFIG="--disable-user --target-list-exclude=${MAIN_SOFTMMU_TARGETS}"
+    - name: "[x86] GCC (other-softmmu)"
+      env:
+       - CONFIG="--disable-user --target-list-exclude=${MAIN_SOFTMMU_TARGETS}"
         - CACHE_NAME="${TRAVIS_BRANCH}-linux-gcc-default"
 
 
     # Just build tools and run minimal unit and softfloat checks
-    - env:
+    - name: "[x86] GCC check-softfloat (user)"
+      env:
         - BASE_CONFIG="--enable-tools"
         - CONFIG="--disable-user --disable-system"
         - TEST_CMD="make check-unit check-softfloat -j3"
@@ -119,41 +123,48 @@ matrix:
 
 
     # --enable-debug implies --enable-debug-tcg, also runs quite a bit slower
-    - env:
+    - name: "[x86] GCC debug (main-softmmu)"
+      env:
         - CONFIG="--enable-debug --target-list=${MAIN_SOFTMMU_TARGETS}"
         - CACHE_NAME="${TRAVIS_BRANCH}-linux-gcc-debug"
 
 
     # TCG debug can be run just on its own and is mostly agnostic to user/softmmu distinctions
-    - env:
+    - name: "[x86] GCC debug (user)"
+      env:
         - CONFIG="--enable-debug-tcg --disable-system"
         - CACHE_NAME="${TRAVIS_BRANCH}-linux-gcc-debug-tcg"
 
 
-    - env:
+    - name: "[x86] GCC some libs disabled (main-softmmu)"
+      env:
         - CONFIG="--disable-linux-aio --disable-cap-ng --disable-attr --disable-brlapi --disable-libusb --disable-replication --target-list=${MAIN_SOFTMMU_TARGETS}"
 
 
     # Module builds are mostly of interest to major distros
-    - env:
+    - name: "[x86] GCC modules (main-softmmu)"
+      env:
         - CONFIG="--enable-modules --target-list=${MAIN_SOFTMMU_TARGETS}"
         - CACHE_NAME="${TRAVIS_BRANCH}-linux-gcc-default"
 
 
     # Alternate coroutines implementations are only really of interest to KVM users
     # However we can't test against KVM on Travis so we can only run unit tests
-    - env:
+    - name: "[x86] check-unit coroutine=ucontext"
+      env:
         - CONFIG="--with-coroutine=ucontext --disable-tcg"
         - TEST_CMD="make check-unit -j3 V=1"
 
 
-    - env:
+    - name: "[x86] check-unit coroutine=sigaltstack"
+      env:
         - CONFIG="--with-coroutine=sigaltstack --disable-tcg"
         - TEST_CMD="make check-unit -j3 V=1"
 
 
     # Check we can build docs and tools (out of tree)
-    - env:
+    - name: "[x86] tools and docs"
+      env:
         - BUILD_DIR="out-of-tree/build/dir" SRC_DIR="../../.."
         - BASE_CONFIG="--enable-tools --enable-docs"
         - CONFIG="--target-list=x86_64-softmmu,aarch64-linux-user"
@@ -167,13 +178,15 @@ matrix:
 
 
     # Test with Clang for compile portability (Travis uses clang-5.0)
-    - env:
+    - name: "[x86] Clang (user)"
+      env:
         - CONFIG="--disable-system"
         - CACHE_NAME="${TRAVIS_BRANCH}-linux-clang-default"
       compiler: clang
 
 
-    - env:
+    - name: "[x86] Clang (main-softmmu)"
+      env:
         - CONFIG="--target-list=${MAIN_SOFTMMU_TARGETS} "
         - CACHE_NAME="${TRAVIS_BRANCH}-linux-clang-sanitize"
       compiler: clang
@@ -182,52 +195,60 @@ matrix:
         - ${SRC_DIR}/configure ${CONFIG} --extra-cflags="-fsanitize=undefined -Werror" || { cat config.log && exit 1; }
 
 
-    - env:
+    - name: "[x86] Clang (other-softmmu)"
+      env:
         - CONFIG="--disable-user --target-list-exclude=${MAIN_SOFTMMU_TARGETS}"
         - CACHE_NAME="${TRAVIS_BRANCH}-linux-clang-default"
       compiler: clang
 
 
     # gprof/gcov are GCC features
-    - env:
+    - name: "[x86] GCC gprof/gcov"
+      env:
         - CONFIG="--enable-gprof --enable-gcov --disable-pie --target-list=${MAIN_SOFTMMU_TARGETS}"
       after_success:
         - ${SRC_DIR}/scripts/travis/coverage-summary.sh
 
 
     # We manually include builds which we disable "make check" for
-    - env:
+    - name: "[x86] GCC without-default-devices (softmmu)"
+      env:
         - CONFIG="--without-default-devices --disable-user"
         - CACHE_NAME="${TRAVIS_BRANCH}-linux-gcc-default"
         - TEST_CMD=""
 
 
     # Check the TCG interpreter (TCI)
-    - env:
+    - name: "[x86] GCC TCI"
+      env:
         - CONFIG="--enable-debug-tcg --enable-tcg-interpreter --disable-kvm --disable-containers
             --target-list=alpha-softmmu,arm-softmmu,hppa-softmmu,m68k-softmmu,microblaze-softmmu,moxie-softmmu,ppc-softmmu,s390x-softmmu,x86_64-softmmu"
         - TEST_CMD="make check-qtest check-tcg V=1"
 
 
     # We don't need to exercise every backend with every front-end
-    - env:
+    - name: "[x86] GCC trace log,simple,syslog (user)"
+      env:
         - CONFIG="--enable-trace-backends=log,simple,syslog --disable-system"
         - TEST_CMD=""
 
 
-    - env:
+    - name: "[x86] GCC trace ftrace (x86_64-softmmu)"
+      env:
         - CONFIG="--enable-trace-backends=ftrace --target-list=x86_64-softmmu"
         - TEST_CMD=""
 
 
-    - env:
+    - name: "[x86] GCC trace ust (x86_64-softmmu)"
+      env:
         - CONFIG="--enable-trace-backends=ust --target-list=x86_64-softmmu"
         - TEST_CMD=""
 
 
     # MacOSX builds - cirrus.yml also tests some MacOS builds including latest Xcode
 
-    - env:
+    - name: "[x86] OSX Xcode 10.3"
+      env:
         - CONFIG="--target-list=i386-softmmu,ppc-softmmu,ppc64-softmmu,m68k-softmmu,x86_64-softmmu"
       os: osx
       osx_image: xcode10.3
@@ -250,7 +271,8 @@ matrix:
 
 
     # Python builds
-    - env:
+    - name: "[x86] GCC Python 3.5 (x86_64-softmmu)"
+      env:
         - CONFIG="--target-list=x86_64-softmmu"
         - CACHE_NAME="${TRAVIS_BRANCH}-linux-gcc-default"
       language: python
@@ -258,7 +280,8 @@ matrix:
         - "3.5"
 
 
-    - env:
+    - name: "[x86] GCC Python 3.6 (x86_64-softmmu)"
+      env:
         - CONFIG="--target-list=x86_64-softmmu"
         - CACHE_NAME="${TRAVIS_BRANCH}-linux-gcc-default"
       language: python
@@ -267,7 +290,8 @@ matrix:
 
 
     # Acceptance (Functional) tests
-    - env:
+    - name: "[x86] GCC check-acceptance"
+      env:
         - CONFIG="--python=/usr/bin/python3 --target-list=x86_64-softmmu,mips-softmmu,mips64el-softmmu,aarch64-softmmu,arm-softmmu,s390x-softmmu,alpha-softmmu,ppc-softmmu,ppc64-softmmu,m68k-softmmu,sparc-softmmu"
         - TEST_CMD="make check-acceptance"
       after_script:
@@ -283,7 +307,8 @@ matrix:
 
 
     # Using newer GCC with sanitizers
-    - addons:
+    - name: "[x86] GCC9 with sanitizers (softmmu)"
+      addons:
         apt:
           update: true
           sources:
@@ -331,7 +356,8 @@ matrix:
 
 
     # Run check-tcg against linux-user
-    - env:
+    - name: "[x86] GCC check-tcg (user)"
+      env:
         - CONFIG="--disable-system --enable-debug-tcg"
         - TEST_CMD="make -j3 check-tcg V=1"
         - CACHE_NAME="${TRAVIS_BRANCH}-linux-gcc-debug-tcg"
@@ -339,26 +365,30 @@ matrix:
 
     # Run check-tcg against linux-user (with plugins)
     # we skip sparc64-linux-user until it has been fixed somewhat
-    - env:
+    - name: "[x86] GCC plugins check-tcg (user)"
+      env:
         - CONFIG="--disable-system --enable-plugins --enable-debug-tcg --target-list-exclude=sparc64-linux-user"
         - TEST_CMD="make -j3 check-tcg V=1"
         - CACHE_NAME="${TRAVIS_BRANCH}-linux-gcc-debug-tcg"
 
 
     # Run check-tcg against softmmu targets
-    - env:
+    - name: "[x86] GCC check-tcg (some-softmmu)"
+      env:
         - CONFIG="--enable-debug-tcg --target-list=xtensa-softmmu,arm-softmmu,aarch64-softmmu,alpha-softmmu"
         - TEST_CMD="make -j3 check-tcg V=1"
         - CACHE_NAME="${TRAVIS_BRANCH}-linux-gcc-debug-tcg"
 
 
     # Run check-tcg against softmmu targets (with plugins)
-    - env:
+    - name: "[x86] GCC plugins check-tcg (some-softmmu)"
+      env:
         - CONFIG="--enable-plugins --enable-debug-tcg --target-list=xtensa-softmmu,arm-softmmu,aarch64-softmmu,alpha-softmmu"
         - TEST_CMD="make -j3 check-tcg V=1"
         - CACHE_NAME="${TRAVIS_BRANCH}-linux-gcc-debug-tcg"
 
-    - arch: arm64
+    - name: "[aarch64] GCC check-tcg"
+      arch: arm64
       dist: xenial
       addons:
         apt_packages:
@@ -387,7 +417,8 @@ matrix:
         - TEST_CMD="make check check-tcg V=1"
         - CONFIG="--disable-containers --target-list=${MAIN_SOFTMMU_TARGETS}"
 
-    - arch: ppc64le
+    - name: "[ppc64] GCC check-tcg"
+      arch: ppc64le
       dist: xenial
       addons:
         apt_packages:
@@ -416,7 +447,8 @@ matrix:
         - TEST_CMD="make check check-tcg V=1"
         - CONFIG="--disable-containers --target-list=${MAIN_SOFTMMU_TARGETS},ppc64le-linux-user"
 
-    - arch: s390x
+    - name: "[s390x] GCC check-tcg"
+      arch: s390x
       dist: bionic
       addons:
         apt_packages:
@@ -448,7 +480,8 @@ matrix:
     # Release builds
     # The make-release script expect a QEMU version, so our tag must start with a 'v'.
     # This is the case when release candidate tags are created.
-    - if: tag IS present AND tag =~ /^v\d+\.\d+(\.\d+)?(-\S*)?$/
+    - name: "Release tarball"
+      if: tag IS present AND tag =~ /^v\d+\.\d+(\.\d+)?(-\S*)?$/
       env:
         # We want to build from the release tarball
         - BUILD_DIR="release/build/dir" SRC_DIR="../../.."
-- 
2.21.1


