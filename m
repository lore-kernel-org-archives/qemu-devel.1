Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D05BCA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 20:23:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9C2121D81
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 20:23:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eu9aN0PX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9C2121D81
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35876 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iO678-0003FT-4s
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 16:23:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57766)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iO5Of-000870-9c
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 15:37:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iO5Oe-00036b-43
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 15:37:17 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433]:44526)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iO5Od-000360-U4
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 15:37:16 -0400
Received: by mail-wr1-x433.google.com with SMTP id z11so3594000wro.11
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2019 12:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=9U6VJzyn/CEOB4/CyQIKZOWv5ZeIvdrRbrpNWyazKps=;
 b=eu9aN0PXTTLnLaw3sCfLWL3V9fvQWOXb4b+Z+thPF4BrsECB8Uia0bMGjutZHcFw/I
 vUG9thzCj+aeFwvjQnNLSpztlkTx3OXftxS4ELwzu0SSfcp2uF8DzuaNF30cK+HBJQTv
 OXWfZfAEKuK+1KTVIE9vwdktYRztDdOlsa3Qe9yomplRWNGWmwSN+yhdt51C0fPEQFwO
 E+4/niUYsTmA76SmxB5IEZ9h1C0EFDoE7zCbeuQgixnCKvJrua4FPuPXHfi/5+CM66Ec
 TkZOkrMyeYmkB8BOcJ1Po/bomHRFHs9PxdziOlKxHYDoBX7YG6CP/qIFtD7QKKIyMM9f
 oXRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=9U6VJzyn/CEOB4/CyQIKZOWv5ZeIvdrRbrpNWyazKps=;
 b=TWQEATTU8FDUVbDmWum6HveL2yf1yJx1GNNEaouIajP7vGEYWgDvDaB40o4O/stSFO
 nCEDEQbzXdBmM8HHxUjiA8UQvTqphlQN4tIcVH1HFiaSGZrZzcDZHWo8fKYaPzxTdNiV
 6u0w+T5fdeTn9Y0dieFQkPEpsF9FTexCsqUPie5h5gJdjhOFJx1giGdmGKwQy88rt1rT
 uN+VrQ6+fRp0cMfxMMU1astpplrMxkv87aHWFpWvseo571YGS0XWrE1Q+Wub6bJO3HKx
 Gem3bEvfUzNqGFvHHA6N9YgSOl86Ls+00J/j1LpCQ9VOvX1AvtV7eNankiJZ8P9UAgu8
 mg3Q==
X-Gm-Message-State: APjAAAWhG4JfI86LKW14NRnVI9QDMfRxE9VKyIbV9/rhZmNjWs7olWD6
 RCoAZQhQ03kDCICs9nEDiR+Tng==
X-Google-Smtp-Source: APXvYqymQFkYg9PGZQ/f58PyMhMr+NSWihnwoLdBx0qeGEL6OF3K2w36hPf4LY4iDr3YBGy2Szbjhg==
X-Received: by 2002:adf:e8d0:: with SMTP id k16mr3603214wrn.213.1572032234733; 
 Fri, 25 Oct 2019 12:37:14 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id 5sm3726651wrk.86.2019.10.25.12.37.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Oct 2019 12:37:13 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 01FD21FF93;
 Fri, 25 Oct 2019 20:37:10 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL v3 06/15] travis.yml: Test the release tarball
Date: Fri, 25 Oct 2019 20:37:00 +0100
Message-Id: <20191025193709.28783-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191025193709.28783-1-alex.bennee@linaro.org>
References: <20191025193709.28783-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::433
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
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Add a job to generate the release tarball and build/install few
QEMU targets from it.

Ideally we should build the 'efi' target from the 'roms' directory,
but it is too time consuming.

This job is only triggered when a tag starting with 'v' is pushed,
which is the case with release candidate tags.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20191007160450.3619-1-philmd@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/.travis.yml b/.travis.yml
index 7e0d4ad2b31..f2b679fe701 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -343,3 +343,26 @@ matrix:
         - CONFIG="--target-list=xtensa-softmmu,arm-softmmu,aarch64-softmmu,alpha-softmmu"
         - TEST_CMD="make -j3 check-tcg V=1"
         - CACHE_NAME="${TRAVIS_BRANCH}-linux-gcc-default"
+
+
+    # Release builds
+    # The make-release script expect a QEMU version, so our tag must start with a 'v'.
+    # This is the case when release candidate tags are created.
+    - if: tag IS present AND tag =~ /^v\d+\.\d+(\.\d+)?(-\S*)?$/
+      env:
+        # We want to build from the release tarball
+        - BUILD_DIR="release/build/dir" SRC_DIR="../../.."
+        - BASE_CONFIG="--prefix=$PWD/dist"
+        - CONFIG="--target-list=x86_64-softmmu,aarch64-softmmu,armeb-linux-user,ppc-linux-user"
+        - TEST_CMD="make install -j3"
+        - QEMU_VERSION="${TRAVIS_TAG:1}"
+        - CACHE_NAME="${TRAVIS_BRANCH}-linux-gcc-default"
+      before_script:
+        - command -v ccache && ccache --zero-stats
+        - mkdir -p ${BUILD_DIR} && cd ${BUILD_DIR}
+      script:
+        - make -C ${SRC_DIR} qemu-${QEMU_VERSION}.tar.bz2
+        - ls -l ${SRC_DIR}/qemu-${QEMU_VERSION}.tar.bz2
+        - tar -xf ${SRC_DIR}/qemu-${QEMU_VERSION}.tar.bz2 && cd qemu-${QEMU_VERSION}
+        - ./configure ${BASE_CONFIG} ${CONFIG} || { cat config.log && exit 1; }
+        - make install
-- 
2.20.1


