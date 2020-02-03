Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93E8CC3524D
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 09:14:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FCF82070A
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 09:14:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e3ANyyk6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FCF82070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36640 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyXnx-0006sJ-HS
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 04:14:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47771)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iyXjr-0006xC-AQ
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 04:09:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iyXjp-0001Dr-GF
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 04:09:51 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d]:42708)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iyXjp-0001Ad-8E
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 04:09:49 -0500
Received: by mail-wr1-x42d.google.com with SMTP id k11so16876542wrd.9
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2020 01:09:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=fTQ3LvFL13twHFzUdt/LymZKMHQDYPz4ZY8OCNkyk1M=;
 b=e3ANyyk6Y3t3OZ5Ru/+Wk7u64hZf73IneR2yJSlmdEaQMUCuTqVkKCmYhUyy3+cCU0
 ILpLNHSxVLNSfs7ogk/d7+pVhDbi9XMDYdj1BkrU1wyld244b+XGFdD5P2Svr9t2tMGR
 YKdDXF0aDyy+XIgiIk+/M9vZNhdcfzS10Z0AtnkM/vGaqOOvBbJ6KHOoZzvzJ5CVNjsm
 POMiqtE2/C6gCIZm3ujlLbNxqajxZRvf7hxE0poly0g2x7MHYJrIsy89tu953cH8M2Uh
 Pq+1K+yJ6XozdXKIpqmSn7HlHYWCZ8zwBSrrb97acLTzYtEtdCIH6OIKXsXO/0nevYWv
 I9fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=fTQ3LvFL13twHFzUdt/LymZKMHQDYPz4ZY8OCNkyk1M=;
 b=LQ1vte8gUTS2PVFYEt7INOAS8noJPQvlrq0SZWGWeZFfM8E980WNa5QI34I39i86UK
 Iki+IMRYNN8z3CiQyWzoXLR93drhZaPnk78cl+8qUhC3RHnyQh2Jz5Ht0H7AisWK+tvK
 6olvfM5ef4zmgLKoQDPWxFxjoeDcgwBA6LOqYqTv5BJDuQxoF/Ni8fSNFgiCmUwz6kHz
 o5Z5UBY1BLyaBBQnTBEaYOwNf+n2X2J0CdQ3beeTBiVKp/9uBXicxwcba5POajXOkdzt
 J05tWW1WhHgshMcPp+nKyEUJC90M+LIcUQXFxEiFy49xn4T8DsY1wLdjR5h1HepK1UKp
 poyA==
X-Gm-Message-State: APjAAAXMX1cHBwYpGkXvZvJu00cej3EVbNo84ezsMpC7Tgv6XzGW8rWb
 Jv1/YU0pR2bhj43afrzXUaT/GQ==
X-Google-Smtp-Source: APXvYqxxfJpH21Jhgy9ZLYA1MegrxhafNGsVglnZ4+Vi3qoI6whow8Kpl8ro5qwSrCX7TWvdoy5ltA==
X-Received: by 2002:a5d:4983:: with SMTP id r3mr13421098wrq.134.1580720988192; 
 Mon, 03 Feb 2020 01:09:48 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id t12sm16944666wrq.97.2020.02.03.01.09.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2020 01:09:39 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 115B01FF98;
 Mon,  3 Feb 2020 09:09:33 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v3 08/17] .travis.yml: Add description to each job
Date: Mon,  3 Feb 2020 09:09:23 +0000
Message-Id: <20200203090932.19147-9-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200203090932.19147-1-alex.bennee@linaro.org>
References: <20200203090932.19147-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42d
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
Cc: fam@euphon.net, berrange@redhat.com, stefanb@linux.vnet.ibm.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, f4bug@amsat.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, cota@braap.org,
 stefanha@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

The NAME variable can be used to describe nicely a job (see [*]).
As we currently have 32 jobs, use it. This helps for quickly
finding a particular job.

  before: https://travis-ci.org/qemu/qemu/builds/639887646
  after: https://travis-ci.org/philmd/qemu/builds/641795043

[*] https://docs.travis-ci.com/user/customizing-the-build/#naming-jobs-within-matrices

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <20200125183135.28317-1-f4bug@amsat.org>

---
[ajb]
  - drop [x86]
---
 .travis.yml | 101 ++++++++++++++++++++++++++++++++++------------------
 1 file changed, 67 insertions(+), 34 deletions(-)

diff --git a/.travis.yml b/.travis.yml
index 75269678476..3128eff7e01 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -96,24 +96,28 @@ after_script:
 
 matrix:
   include:
-    - env:
+    - name: "GCC static (user)"
+      env:
         - CONFIG="--disable-system --static"
         - CACHE_NAME="${TRAVIS_BRANCH}-linux-gcc-default"
 
 
     # we split the system builds as it takes a while to build them all
-    - env:
+    - name: "GCC (main-softmmu)"
+      env:
         - CONFIG="--disable-user --target-list=${MAIN_SOFTMMU_TARGETS}"
         - CACHE_NAME="${TRAVIS_BRANCH}-linux-gcc-default"
 
 
-    - env:
-        - CONFIG="--disable-user --target-list-exclude=${MAIN_SOFTMMU_TARGETS}"
+    - name: "GCC (other-softmmu)"
+      env:
+       - CONFIG="--disable-user --target-list-exclude=${MAIN_SOFTMMU_TARGETS}"
         - CACHE_NAME="${TRAVIS_BRANCH}-linux-gcc-default"
 
 
     # Just build tools and run minimal unit and softfloat checks
-    - env:
+    - name: "GCC check-softfloat (user)"
+      env:
         - BASE_CONFIG="--enable-tools"
         - CONFIG="--disable-user --disable-system"
         - TEST_CMD="make check-unit check-softfloat -j3"
@@ -121,41 +125,48 @@ matrix:
 
 
     # --enable-debug implies --enable-debug-tcg, also runs quite a bit slower
-    - env:
+    - name: "GCC debug (main-softmmu)"
+      env:
         - CONFIG="--enable-debug --target-list=${MAIN_SOFTMMU_TARGETS}"
         - CACHE_NAME="${TRAVIS_BRANCH}-linux-gcc-debug"
 
 
     # TCG debug can be run just on its own and is mostly agnostic to user/softmmu distinctions
-    - env:
+    - name: "GCC debug (user)"
+      env:
         - CONFIG="--enable-debug-tcg --disable-system"
         - CACHE_NAME="${TRAVIS_BRANCH}-linux-gcc-debug-tcg"
 
 
-    - env:
+    - name: "GCC some libs disabled (main-softmmu)"
+      env:
         - CONFIG="--disable-linux-aio --disable-cap-ng --disable-attr --disable-brlapi --disable-libusb --disable-replication --target-list=${MAIN_SOFTMMU_TARGETS}"
 
 
     # Module builds are mostly of interest to major distros
-    - env:
+    - name: "GCC modules (main-softmmu)"
+      env:
         - CONFIG="--enable-modules --target-list=${MAIN_SOFTMMU_TARGETS}"
         - CACHE_NAME="${TRAVIS_BRANCH}-linux-gcc-default"
 
 
     # Alternate coroutines implementations are only really of interest to KVM users
     # However we can't test against KVM on Travis so we can only run unit tests
-    - env:
+    - name: "check-unit coroutine=ucontext"
+      env:
         - CONFIG="--with-coroutine=ucontext --disable-tcg"
         - TEST_CMD="make check-unit -j3 V=1"
 
 
-    - env:
+    - name: "check-unit coroutine=sigaltstack"
+      env:
         - CONFIG="--with-coroutine=sigaltstack --disable-tcg"
         - TEST_CMD="make check-unit -j3 V=1"
 
 
     # Check we can build docs and tools (out of tree)
-    - env:
+    - name: "tools and docs"
+      env:
         - BUILD_DIR="out-of-tree/build/dir" SRC_DIR="../../.."
         - BASE_CONFIG="--enable-tools --enable-docs"
         - CONFIG="--target-list=x86_64-softmmu,aarch64-linux-user"
@@ -169,13 +180,15 @@ matrix:
 
 
     # Test with Clang for compile portability (Travis uses clang-5.0)
-    - env:
+    - name: "Clang (user)"
+      env:
         - CONFIG="--disable-system"
         - CACHE_NAME="${TRAVIS_BRANCH}-linux-clang-default"
       compiler: clang
 
 
-    - env:
+    - name: "Clang (main-softmmu)"
+      env:
         - CONFIG="--target-list=${MAIN_SOFTMMU_TARGETS} "
         - CACHE_NAME="${TRAVIS_BRANCH}-linux-clang-sanitize"
       compiler: clang
@@ -184,52 +197,60 @@ matrix:
         - ${SRC_DIR}/configure ${CONFIG} --extra-cflags="-fsanitize=undefined -Werror" || { cat config.log && exit 1; }
 
 
-    - env:
+    - name: "Clang (other-softmmu)"
+      env:
         - CONFIG="--disable-user --target-list-exclude=${MAIN_SOFTMMU_TARGETS}"
         - CACHE_NAME="${TRAVIS_BRANCH}-linux-clang-default"
       compiler: clang
 
 
     # gprof/gcov are GCC features
-    - env:
+    - name: "GCC gprof/gcov"
+      env:
         - CONFIG="--enable-gprof --enable-gcov --disable-pie --target-list=${MAIN_SOFTMMU_TARGETS}"
       after_success:
         - ${SRC_DIR}/scripts/travis/coverage-summary.sh
 
 
     # We manually include builds which we disable "make check" for
-    - env:
+    - name: "GCC without-default-devices (softmmu)"
+      env:
         - CONFIG="--without-default-devices --disable-user"
         - CACHE_NAME="${TRAVIS_BRANCH}-linux-gcc-default"
         - TEST_CMD=""
 
 
     # Check the TCG interpreter (TCI)
-    - env:
+    - name: "GCC TCI"
+      env:
         - CONFIG="--enable-debug-tcg --enable-tcg-interpreter --disable-kvm --disable-containers
             --target-list=alpha-softmmu,arm-softmmu,hppa-softmmu,m68k-softmmu,microblaze-softmmu,moxie-softmmu,ppc-softmmu,s390x-softmmu,x86_64-softmmu"
         - TEST_CMD="make check-qtest check-tcg V=1"
 
 
     # We don't need to exercise every backend with every front-end
-    - env:
+    - name: "GCC trace log,simple,syslog (user)"
+      env:
         - CONFIG="--enable-trace-backends=log,simple,syslog --disable-system"
         - TEST_CMD=""
 
 
-    - env:
+    - name: "GCC trace ftrace (x86_64-softmmu)"
+      env:
         - CONFIG="--enable-trace-backends=ftrace --target-list=x86_64-softmmu"
         - TEST_CMD=""
 
 
-    - env:
+    - name: "GCC trace ust (x86_64-softmmu)"
+      env:
         - CONFIG="--enable-trace-backends=ust --target-list=x86_64-softmmu"
         - TEST_CMD=""
 
 
     # MacOSX builds - cirrus.yml also tests some MacOS builds including latest Xcode
 
-    - env:
+    - name: "OSX Xcode 10.3"
+      env:
         - CONFIG="--target-list=i386-softmmu,ppc-softmmu,ppc64-softmmu,m68k-softmmu,x86_64-softmmu"
       os: osx
       osx_image: xcode10.3
@@ -252,7 +273,8 @@ matrix:
 
 
     # Python builds
-    - env:
+    - name: "GCC Python 3.5 (x86_64-softmmu)"
+      env:
         - CONFIG="--target-list=x86_64-softmmu"
         - CACHE_NAME="${TRAVIS_BRANCH}-linux-gcc-default"
       language: python
@@ -260,7 +282,8 @@ matrix:
         - "3.5"
 
 
-    - env:
+    - name: "GCC Python 3.6 (x86_64-softmmu)"
+      env:
         - CONFIG="--target-list=x86_64-softmmu"
         - CACHE_NAME="${TRAVIS_BRANCH}-linux-gcc-default"
       language: python
@@ -269,7 +292,8 @@ matrix:
 
 
     # Acceptance (Functional) tests
-    - env:
+    - name: "GCC check-acceptance"
+      env:
         - CONFIG="--target-list=x86_64-softmmu,mips-softmmu,mips64el-softmmu,aarch64-softmmu,arm-softmmu,s390x-softmmu,alpha-softmmu,ppc-softmmu,ppc64-softmmu,m68k-softmmu,sparc-softmmu"
         - TEST_CMD="make check-acceptance"
       after_script:
@@ -285,7 +309,8 @@ matrix:
 
 
     # Using newer GCC with sanitizers
-    - addons:
+    - name: "GCC9 with sanitizers (softmmu)"
+      addons:
         apt:
           update: true
           sources:
@@ -333,7 +358,8 @@ matrix:
 
 
     # Run check-tcg against linux-user
-    - env:
+    - name: "GCC check-tcg (user)"
+      env:
         - CONFIG="--disable-system --enable-debug-tcg"
         - TEST_CMD="make -j3 check-tcg V=1"
         - CACHE_NAME="${TRAVIS_BRANCH}-linux-gcc-debug-tcg"
@@ -341,26 +367,30 @@ matrix:
 
     # Run check-tcg against linux-user (with plugins)
     # we skip sparc64-linux-user until it has been fixed somewhat
-    - env:
+    - name: "GCC plugins check-tcg (user)"
+      env:
         - CONFIG="--disable-system --enable-plugins --enable-debug-tcg --target-list-exclude=sparc64-linux-user"
         - TEST_CMD="make -j3 check-tcg V=1"
         - CACHE_NAME="${TRAVIS_BRANCH}-linux-gcc-debug-tcg"
 
 
     # Run check-tcg against softmmu targets
-    - env:
+    - name: "GCC check-tcg (some-softmmu)"
+      env:
         - CONFIG="--enable-debug-tcg --target-list=xtensa-softmmu,arm-softmmu,aarch64-softmmu,alpha-softmmu"
         - TEST_CMD="make -j3 check-tcg V=1"
         - CACHE_NAME="${TRAVIS_BRANCH}-linux-gcc-debug-tcg"
 
 
     # Run check-tcg against softmmu targets (with plugins)
-    - env:
+    - name: "GCC plugins check-tcg (some-softmmu)"
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
@@ -391,7 +421,8 @@ matrix:
         - TEST_CMD="make check check-tcg V=1"
         - CONFIG="--disable-containers --target-list=${MAIN_SOFTMMU_TARGETS}"
 
-    - arch: ppc64le
+    - name: "[ppc64] GCC check-tcg"
+      arch: ppc64le
       dist: xenial
       addons:
         apt_packages:
@@ -422,7 +453,8 @@ matrix:
         - TEST_CMD="make check check-tcg V=1"
         - CONFIG="--disable-containers --target-list=${MAIN_SOFTMMU_TARGETS},ppc64le-linux-user"
 
-    - arch: s390x
+    - name: "[s390x] GCC check-tcg"
+      arch: s390x
       dist: bionic
       addons:
         apt_packages:
@@ -456,7 +488,8 @@ matrix:
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
2.20.1


