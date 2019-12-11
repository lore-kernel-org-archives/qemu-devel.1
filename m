Return-Path: <SRS0=Q6KP=2B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8345EC00454
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 14:39:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 518BA20836
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 14:39:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ihsMmgzj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 518BA20836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43382 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1if399-0004b3-BH
	for qemu-devel@archiver.kernel.org; Wed, 11 Dec 2019 09:39:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49970)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1if30B-0003zf-3o
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 09:30:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1if308-0003Vs-Ht
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 09:30:06 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:38408)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1if308-0003U9-AS
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 09:30:04 -0500
Received: by mail-wr1-x442.google.com with SMTP id y17so24280430wrh.5
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2019 06:30:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=sOXmfdkp6uqWjdrg0TuZzWd3wRDxzC7eIg66A07rdZg=;
 b=ihsMmgzjNZTCnAFxkE140PQmT+pRGNZBqKmRiZfufovQp5NvSpl+xvCeN1nSpd7nix
 JSn07LDiKEZcMnB2oyPO9Z/3Lt/cZYUzsgVAHpeFhamoU6l4EmgEJAx6v+5jHygSXOMm
 UNeLz/624koOTE3XMZXL+PfLZMiU1SflffUYDAzjYCZe8Vqzjnel4BhgYgZYXSIDsQOq
 i6xWkkN+JWeOX805N7xoBccjX+mxzkF/crtmEy612n/y4k99rJp7thPub+pzf5vR58ds
 VQiIRjoTeYVp5efYUHRdRgjkPAf8GgAEnV436vTd36OSRjGi751wext30EUT22cRJ79O
 hi+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=sOXmfdkp6uqWjdrg0TuZzWd3wRDxzC7eIg66A07rdZg=;
 b=FdT/QcGHM+zN0yKAp7WRLzjHDu05K7Q6dIARMLYUe4nkSfC5DAAgKC9IzvbJ7TWUmS
 zI+KGgabByoFRlvoZNdu+jt+HvFv5B1VFhPAF1ktrjdOLVwWvByCq0kQQ94wF3VqageF
 0qaK035YzxFkrftW8jIVSYcn3sr9WX9OnUaDII2GRmwlqZ0sbwoNkazz2jZNyk465bcl
 BZEX1AYGE72EUFXhHJuHyDFBm+z1X9jKGw6Ez81tSZNWg98WDN1e9jCCmwa9Ljs2sJyh
 bwXb8IIevT18KAkSH6vC/lGcvwsje47NSRAWgxIoemIdTLn2Lh7NkZcQwtszA0d8EmKY
 P19w==
X-Gm-Message-State: APjAAAUxsEsJwjY92S3D06iSLEwNfZq4R3QxEYen4q/vrbwUROTMjPsz
 oirIYZv9D2Miqle7hj/7htWGMeV6
X-Google-Smtp-Source: APXvYqzRYEqkwk8E0UZzJySziPci5d2R/yvWBFeCvP44TqlxDyd+1Lm9sxYijvfdM7/lX1wNevlO3A==
X-Received: by 2002:adf:cf0a:: with SMTP id o10mr27891wrj.325.1576074602386;
 Wed, 11 Dec 2019 06:30:02 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id n8sm2475408wrx.42.2019.12.11.06.30.01
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 11 Dec 2019 06:30:01 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] ci: build out-of-tree
Date: Wed, 11 Dec 2019 15:30:00 +0100
Message-Id: <1576074600-54759-1-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Cc: alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Most developers are using out-of-tree builds and it was discussed in the past
to only allow those.  To prepare for the transition, use out-of-tree builds
in all continuous integration jobs.

Based on a patch by Marc-André Lureau.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 .cirrus.yml    |  8 ++++++--
 .gitlab-ci.yml | 28 +++++++++++++++++++++-------
 .shippable.yml |  4 +++-
 .travis.yml    |  7 +++++--
 configure      |  1 +
 5 files changed, 36 insertions(+), 12 deletions(-)

diff --git a/.cirrus.yml b/.cirrus.yml
index 27efc48..90645fe 100644
--- a/.cirrus.yml
+++ b/.cirrus.yml
@@ -22,7 +22,9 @@ macos_task:
   install_script:
     - brew install pkg-config python gnu-sed glib pixman make sdl2
   script:
-    - ./configure --python=/usr/local/bin/python3 || { cat config.log; exit 1; }
+    - mkdir build
+    - cd build
+    - ../configure --python=/usr/local/bin/python3 || { cat config.log; exit 1; }
     - gmake -j$(sysctl -n hw.ncpu)
     - gmake check -j$(sysctl -n hw.ncpu)
 
@@ -33,6 +35,8 @@ macos_xcode_task:
   install_script:
     - brew install pkg-config gnu-sed glib pixman make sdl2
   script:
-    - ./configure --cc=clang || { cat config.log; exit 1; }
+    - mkdir build
+    - cd build
+    - ../configure --cc=clang || { cat config.log; exit 1; }
     - gmake -j$(sysctl -n hw.ncpu)
     - gmake check -j$(sysctl -n hw.ncpu)
diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index be57c6a..f771b40 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -6,7 +6,9 @@ build-system1:
  script:
  - apt-get install -y -qq libgtk-3-dev libvte-dev nettle-dev libcacard-dev
       libusb-dev libvde-dev libspice-protocol-dev libgl1-mesa-dev libvdeplug-dev
- - ./configure --enable-werror --target-list="aarch64-softmmu alpha-softmmu
+ - mkdir build
+ - cd build
+ - ../configure --enable-werror --target-list="aarch64-softmmu alpha-softmmu
       cris-softmmu hppa-softmmu lm32-softmmu moxie-softmmu microblazeel-softmmu
       mips64el-softmmu m68k-softmmu ppc-softmmu riscv64-softmmu sparc-softmmu"
  - make -j2
@@ -16,7 +18,9 @@ build-system2:
  script:
  - apt-get install -y -qq libsdl2-dev libgcrypt-dev libbrlapi-dev libaio-dev
       libfdt-dev liblzo2-dev librdmacm-dev libibverbs-dev libibumad-dev
- - ./configure --enable-werror --target-list="tricore-softmmu unicore32-softmmu
+ - mkdir build
+ - cd build
+ - ../configure --enable-werror --target-list="tricore-softmmu unicore32-softmmu
       microblaze-softmmu mips-softmmu riscv32-softmmu s390x-softmmu sh4-softmmu
       sparc64-softmmu x86_64-softmmu xtensa-softmmu nios2-softmmu or1k-softmmu"
  - make -j2
@@ -24,7 +28,9 @@ build-system2:
 
 build-disabled:
  script:
- - ./configure --enable-werror --disable-rdma --disable-slirp --disable-curl
+ - mkdir build
+ - cd build
+ - ../configure --enable-werror --disable-rdma --disable-slirp --disable-curl
       --disable-capstone --disable-live-block-migration --disable-glusterfs
       --disable-replication --disable-coroutine-pool --disable-smartcard
       --disable-guest-agent --disable-curses --disable-libxml2 --disable-tpm
@@ -37,7 +43,9 @@ build-disabled:
 build-tcg-disabled:
  script:
  - apt-get install -y -qq clang libgtk-3-dev libbluetooth-dev libusb-dev
- - ./configure --cc=clang --enable-werror --disable-tcg --audio-drv-list=""
+ - mkdir build
+ - cd build
+ - ../configure --cc=clang --enable-werror --disable-tcg --audio-drv-list=""
  - make -j2
  - make check-unit
  - make check-qapi-schema
@@ -52,7 +60,9 @@ build-tcg-disabled:
 
 build-user:
  script:
- - ./configure --enable-werror --disable-system --disable-guest-agent
+ - mkdir build
+ - cd build
+ - ../configure --enable-werror --disable-system --disable-guest-agent
                --disable-capstone --disable-slirp --disable-fdt
  - make -j2
  - make run-tcg-tests-i386-linux-user run-tcg-tests-x86_64-linux-user
@@ -61,7 +71,9 @@ build-clang:
  script:
  - apt-get install -y -qq clang libsdl2-dev libattr1-dev libcap-dev
       xfslibs-dev libiscsi-dev libnfs-dev libseccomp-dev gnutls-dev librbd-dev
- - ./configure --cc=clang --cxx=clang++ --enable-werror
+ - mkdir build
+ - cd build
+ - ../configure --cc=clang --cxx=clang++ --enable-werror
       --target-list="alpha-softmmu arm-softmmu m68k-softmmu mips64-softmmu
                      ppc-softmmu s390x-softmmu x86_64-softmmu arm-linux-user"
  - make -j2
@@ -70,7 +82,9 @@ build-clang:
 build-tci:
  script:
  - TARGETS="aarch64 alpha arm hppa m68k microblaze moxie ppc64 s390x x86_64"
- - ./configure --enable-tcg-interpreter
+ - mkdir build
+ - cd build
+ - ../configure --enable-tcg-interpreter
       --target-list="$(for tg in $TARGETS; do echo -n ${tg}'-softmmu '; done)"
  - make -j2
  - make tests/boot-serial-test tests/cdrom-test tests/pxe-test
diff --git a/.shippable.yml b/.shippable.yml
index f74a3de..83aae08 100644
--- a/.shippable.yml
+++ b/.shippable.yml
@@ -35,5 +35,7 @@ build:
     options: "-e HOME=/root"
   ci:
     - unset CC
-    - ./configure ${QEMU_CONFIGURE_OPTS} --target-list=${TARGET_LIST}
+    - mkdir build
+    - cd build
+    - ../configure ${QEMU_CONFIGURE_OPTS} --target-list=${TARGET_LIST}
     - make -j$(($(getconf _NPROCESSORS_ONLN) + 1))
diff --git a/.travis.yml b/.travis.yml
index 445b064..d259b51 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -74,8 +74,8 @@ notifications:
 
 env:
   global:
-    - SRC_DIR="."
-    - BUILD_DIR="."
+    - SRC_DIR=".."
+    - BUILD_DIR="build"
     - BASE_CONFIG="--disable-docs --disable-tools"
     - TEST_CMD="make check V=1"
     # This is broadly a list of "mainline" softmmu targets which have support across the major distros
@@ -192,7 +192,9 @@ matrix:
         - CACHE_NAME="${TRAVIS_BRANCH}-linux-clang-sanitize"
       compiler: clang
       before_script:
+        - mkdir -p ${BUILD_DIR} && cd ${BUILD_DIR}
         - ./configure ${CONFIG} --extra-cflags="-fsanitize=undefined -Werror" || { cat config.log && exit 1; }
+        - ${SRC_DIR}/configure ${CONFIG} --extra-cflags="-fsanitize=undefined -Werror" --extra-ldflags="-fsanitize=undefined" || { cat config.log && exit 1; }
 
 
     - env:
@@ -323,6 +325,7 @@ matrix:
         - CONFIG="--cc=gcc-9 --cxx=g++-9 --disable-pie --disable-linux-user"
         - TEST_CMD=""
       before_script:
+        - mkdir -p ${BUILD_DIR} && cd ${BUILD_DIR}
         - ./configure ${CONFIG} --extra-cflags="-g3 -O0 -Wno-error=stringop-truncation -fsanitize=thread -fuse-ld=gold" || { cat config.log && exit 1; }
 
 
diff --git a/configure b/configure
index 7a1bc47..19b209a 100755
--- a/configure
+++ b/configure
@@ -6441,6 +6441,7 @@ else
 echo "local state directory   queried at runtime"
 echo "Windows SDK       $win_sdk"
 fi
+echo "Build directory   $(pwd)"
 echo "Source path       $source_path"
 echo "GIT binary        $git"
 echo "GIT submodules    $git_submodules"
-- 
1.8.3.1


