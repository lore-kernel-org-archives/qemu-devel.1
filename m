Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BFEDC3F68F
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 18:45:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03414217F4
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 18:45:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eLqf5VbW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03414217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36186 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iz3C5-0002mI-4B
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 13:45:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49771)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iz37w-0002Yp-0f
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 13:40:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iz37u-0003Wl-MQ
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 13:40:47 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d]:38579)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iz37u-0003SR-Ek
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 13:40:46 -0500
Received: by mail-wr1-x42d.google.com with SMTP id y17so24424550wrh.5
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2020 10:40:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=0aVFKZb4dTY13AjtnctAI9fn5KF4XqDrO8C2sbD1mzs=;
 b=eLqf5VbWkA1vRchZe1PWt9FbID6f0n3cqK/h2QQA9P22kLnDfP7sLOpsPhf0aNUsHy
 dmZPf9kOjlOjBoYTDKBy64fs8f+xofmZ+r4vvl6bZ8VKqq0M8K9iJLb7P+YQ/EPZ1nys
 mmHcZigyoo/Hy5pfttN8Rs7bBw3fOPfmd5wcWEuZWtoIt29nUzRGXS1vjh+C6GI76O47
 H7wT7leOucnOfl4X1rV3xa4+aQTkYhJn3iuopMIQoRv3vtkdNpk6DKQfry61GB6yMqYM
 G+ggfrngzo2SNzzbpjdGQehp04UU4Lu4PpH57CyLMJ2TwIe/3U0TJazlRF+Jg8sTVP0K
 HIjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=0aVFKZb4dTY13AjtnctAI9fn5KF4XqDrO8C2sbD1mzs=;
 b=cwvxclfkE07bPuYunpuojRicueJhBfaRoAnb+mwqZEt2ZYPLNdZ/pRK68oXfi94sZV
 J8foB09CCVSesUwV+m7o0iBUnLOK8S7r6zJ6NC4R5Q0s7Sq/Bk3rfB7fu9pytsUqywYt
 1k1slrOrhTWFWSO+e8aljv+DqB6F8hsjhxv9BBhWw3AaX0Vx5LRjYf4Poj6UJpwb4A1r
 j8fLCVJmqJIfWOdJhCAtdMZ8KaVsw87QjrZVb9E1CFAnoqLYiSvMWxujasfNBX0mMxZ1
 gGb528EUOjMcu14qxJdiQcoPlidj7uSLVbCQrwNuCchW689pZzIYg6ygRg7lxE7B1K7Y
 9TmA==
X-Gm-Message-State: APjAAAVZERj/h/HaW6m/KEzezKnXHyX4La8FsI8+jhER5wdxJRHB7jlt
 b+suL/I036IIv2HQhKE/Qwiu0w==
X-Google-Smtp-Source: APXvYqz33Ez1IH+/xwKiGltJasBmxBIGidss+0yJV21cBunuAM8WXjgW/tBs7UV8FJ/bcOobQkNnEw==
X-Received: by 2002:a05:6000:1187:: with SMTP id
 g7mr23674290wrx.109.1580841645456; 
 Tue, 04 Feb 2020 10:40:45 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id x7sm31198259wrq.41.2020.02.04.10.40.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Feb 2020 10:40:37 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 34C611FF99;
 Tue,  4 Feb 2020 18:40:29 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 09/16] .travis.yml: probe for number of available processors
Date: Tue,  4 Feb 2020 18:40:21 +0000
Message-Id: <20200204184028.13708-10-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200204184028.13708-1-alex.bennee@linaro.org>
References: <20200204184028.13708-1-alex.bennee@linaro.org>
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
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The arm64 hardware was especially hit by only building on 3 of the 32
available cores. Introduce a JOBS environment variable which we use
for all parallel builds. We still run the main checks single threaded
though so to make it easier to spot hangs.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200203090932.19147-12-alex.bennee@linaro.org>

diff --git a/.travis.yml b/.travis.yml
index 1b92f40eab2..a600f508b0a 100644
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


