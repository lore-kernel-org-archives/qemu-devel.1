Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 821D8C33C9E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 11:45:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B3D7206D5
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 11:45:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VMk7JDbL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B3D7206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59318 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ix8GG-0002Rx-Cq
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 06:45:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36182)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1ix89x-0001PU-Rw
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 06:38:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1ix89w-0000EE-Ha
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 06:38:57 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:44155)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1ix89w-0000BA-Af
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 06:38:56 -0500
Received: by mail-wr1-x441.google.com with SMTP id m16so3579408wrx.11
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2020 03:38:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=7MZbUR+2nQJySXQg9TSwuBOn05DJnaAO24wUUShcXc4=;
 b=VMk7JDbLGq10mikpR1iz4oBQ7kysAu2xI/UwnsduMfMFTmXTQEZFlMLSV7QUsJaMEa
 sF2jd1qFLd2qwRtc0NKPM/aShKq8Q9HLatU/Y27AXdMUJIs8aUtHdcfObM3Jq9Lk7/JP
 EGfA5mfN31gnqgJtB6G2GB+uuUs6JVnFQgrAn0F3kgJRUL7wSu4y1XHV8R6dK3w1Qd/q
 WJAQnB+zRvWLYhGbQW3W2C5J8/75xjzH2KVXfwd3IhY3fN5jc83A/vwl8FKktLueF5/e
 Enh5694cmBx9oulHpKUR8jGDsSncjK6EiIcvp3JLc71pK4HNYG1dg+EvwCG+BUC/Vivg
 H14w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=7MZbUR+2nQJySXQg9TSwuBOn05DJnaAO24wUUShcXc4=;
 b=hwrp9LmVVi4YrlQtFYYT3vJ6b+sBdtbJ07Od82ypd7pBPvNwyJ2Uac8wcR9nHCY/sS
 UrEvYSiV04pebb0IXMaLK1etN9A0e6WX3pugfoDlCH5bPNm3bRGn3WIwWOKKWANE7zwm
 YHTcP3RdlP1Il4q9ZP4q0BdwEQxphqDESXSC+kUCdwdvW9G/Qa4B+sN1YrIxFytfYXro
 SIPa9VM4Yaryj+Bah+wpqd6i8on35V4gfFNHeTWmE4bZQbHRDVwerDCiN83ffaUwZWBT
 ln9r6HQVMGRwtFMJbl13Aq4PEZwiWQhqIYALC9QWT5TzSVKn4s3cJnndk32mL8seQny+
 wvMg==
X-Gm-Message-State: APjAAAWnIt0fFrnwzd0dzUGeMjTi5OHgrYInrifIhQ5Ub5W6fMToTh2N
 9rBoLG4YfnIAS+m51qhZxVMCBg==
X-Google-Smtp-Source: APXvYqzeBYD+TyCJeFyjYvAWb80OmFOzRPclMkOFRcwNc1Du7UJ4efzxspY4WrkrbkKpBwXzrfSXhw==
X-Received: by 2002:a5d:4602:: with SMTP id t2mr4872740wrq.37.1580384334862;
 Thu, 30 Jan 2020 03:38:54 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id o7sm5965562wmh.11.2020.01.30.03.38.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jan 2020 03:38:49 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 29A831FF9B;
 Thu, 30 Jan 2020 11:32:24 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 11/12] .travis.yml: probe for number of available processors
Date: Thu, 30 Jan 2020 11:32:22 +0000
Message-Id: <20200130113223.31046-12-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200130113223.31046-1-alex.bennee@linaro.org>
References: <20200130113223.31046-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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

The arm64 hardware was especially hit by only building on 3 of the 32
available cores. Introduce a JOBS environment variable which we use
for all parallel builds. We still run the main checks single threaded
though so to make it easier to spot hangs.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .travis.yml | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/.travis.yml b/.travis.yml
index 1b92f40eab..a600f508b0 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -85,6 +85,8 @@ git:
 # Common first phase for all steps
 before_install:
   - if command -v ccache ; then ccache --zero-stats ; fi
+  - export JOBS=$(($(getconf _NPROCESSORS_ONLN) + 1))
+  - echo "=== Using ${JOBS} simultaneous jobs ==="
 
 # Configure step - may be overridden
 before_script:
@@ -93,7 +95,7 @@ before_script:
 
 # Main build & test - rarely overridden - controlled by TEST_CMD
 script:
-  - BUILD_RC=0 && make -j3 || BUILD_RC=$?
+  - BUILD_RC=0 && make -j${JOBS} || BUILD_RC=$?
   - if [ "$BUILD_RC" -eq 0 ] ; then travis_retry ${TEST_CMD} ; else $(exit $BUILD_RC); fi
 after_script:
   - if command -v ccache ; then ccache --show-stats ; fi
@@ -125,7 +127,7 @@ matrix:
       env:
         - BASE_CONFIG="--enable-tools"
         - CONFIG="--disable-user --disable-system"
-        - TEST_CMD="make check-unit check-softfloat -j3"
+        - TEST_CMD="make check-unit check-softfloat -j${JOBS}"
         - CACHE_NAME="${TRAVIS_BRANCH}-linux-gcc-default"
 
 
@@ -160,13 +162,13 @@ matrix:
     - name: "check-unit coroutine=ucontext"
       env:
         - CONFIG="--with-coroutine=ucontext --disable-tcg"
-        - TEST_CMD="make check-unit -j3 V=1"
+        - TEST_CMD="make check-unit -j${JOBS} V=1"
 
 
     - name: "check-unit coroutine=sigaltstack"
       env:
         - CONFIG="--with-coroutine=sigaltstack --disable-tcg"
-        - TEST_CMD="make check-unit -j3 V=1"
+        - TEST_CMD="make check-unit -j${JOBS} V=1"
 
 
     # Check we can build docs and tools (out of tree)
@@ -366,7 +368,7 @@ matrix:
     - name: "GCC check-tcg (user)"
       env:
         - CONFIG="--disable-system --enable-debug-tcg"
-        - TEST_CMD="make -j3 check-tcg V=1"
+        - TEST_CMD="make -j${JOBS} check-tcg V=1"
         - CACHE_NAME="${TRAVIS_BRANCH}-linux-gcc-debug-tcg"
 
 
@@ -375,7 +377,7 @@ matrix:
     - name: "GCC plugins check-tcg (user)"
       env:
         - CONFIG="--disable-system --enable-plugins --enable-debug-tcg --target-list-exclude=sparc64-linux-user"
-        - TEST_CMD="make -j3 check-tcg V=1"
+        - TEST_CMD="make -j${JOBS} check-tcg V=1"
         - CACHE_NAME="${TRAVIS_BRANCH}-linux-gcc-debug-tcg"
 
 
@@ -383,7 +385,7 @@ matrix:
     - name: "GCC check-tcg (some-softmmu)"
       env:
         - CONFIG="--enable-debug-tcg --target-list=xtensa-softmmu,arm-softmmu,aarch64-softmmu,alpha-softmmu"
-        - TEST_CMD="make -j3 check-tcg V=1"
+        - TEST_CMD="make -j${JOBS} check-tcg V=1"
         - CACHE_NAME="${TRAVIS_BRANCH}-linux-gcc-debug-tcg"
 
 
@@ -391,7 +393,7 @@ matrix:
     - name: "GCC plugins check-tcg (some-softmmu)"
       env:
         - CONFIG="--enable-plugins --enable-debug-tcg --target-list=xtensa-softmmu,arm-softmmu,aarch64-softmmu,alpha-softmmu"
-        - TEST_CMD="make -j3 check-tcg V=1"
+        - TEST_CMD="make -j${JOBS} check-tcg V=1"
         - CACHE_NAME="${TRAVIS_BRANCH}-linux-gcc-debug-tcg"
 
     - name: "[aarch64] GCC check-tcg"
@@ -500,7 +502,7 @@ matrix:
         - BUILD_DIR="release/build/dir" SRC_DIR="../../.."
         - BASE_CONFIG="--prefix=$PWD/dist"
         - CONFIG="--target-list=x86_64-softmmu,aarch64-softmmu,armeb-linux-user,ppc-linux-user"
-        - TEST_CMD="make install -j3"
+        - TEST_CMD="make install -j${JOBS}"
         - QEMU_VERSION="${TRAVIS_TAG:1}"
         - CACHE_NAME="${TRAVIS_BRANCH}-linux-gcc-default"
       script:
-- 
2.20.1


