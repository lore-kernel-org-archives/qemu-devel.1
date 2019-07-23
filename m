Return-Path: <SRS0=3Ld+=VU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15E22C76186
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 16:24:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A93020838
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 16:24:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mSesdlSF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A93020838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45612 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpxaE-0006i9-Fo
	for qemu-devel@archiver.kernel.org; Tue, 23 Jul 2019 12:24:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60876)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hpxa4-0006Gp-3v
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 12:24:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hpxa2-000870-Pc
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 12:24:00 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335]:55430)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hpxa2-00086B-GN
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 12:23:58 -0400
Received: by mail-wm1-x335.google.com with SMTP id a15so39163111wmj.5
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2019 09:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Wc8oRcpDMbAGOEQ46mGRQtRqJRsqCNlu2mcpybhLias=;
 b=mSesdlSF94HmCZWqqLmUrDqQgdwQ+eaNctsMMms5e9yjvnmnU1lFq/nbajDrPsl4Mu
 OOzOVRe1nLeey/AtmaotNiPo/7BopGmfzKKzfsjT7oKu8s7uqynDid3hMbBnvtTvIDxC
 B3gD02Hram6jJ0QseyjPQKfo1elndkUiLT4dhHwsG06713DcOOQ38DJpe+PcUJBw5k80
 6y05YLzeBgvSANG5KOnMaCP9ZNxlSzGKweRqhp4iZePs6YTykH/8f5pmQ2U+7UEEYaCs
 IavGy6w7UQ7EElctsEiah4uwNLi243rQQfNh6onL5pDYff9kA9XEcbahyn86OhjfMF1I
 B7Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Wc8oRcpDMbAGOEQ46mGRQtRqJRsqCNlu2mcpybhLias=;
 b=sFIifXZ/BTcJFMdZeY42aqW9XYUN5dXOvar/bNKpGyN8oX8/202axucgnnkxrRTQGR
 Qk/p7PvAT1X115JhajvHF5rYxFl+0r6htz1fTjW2mKCPRujfoa7xdzcwi5ReUtBmoDH4
 SfRC9zAaRQxvSV78WxI90d4w8rAtDUSEHwY4nVmIezXxYcocrafEwYFWltgNk9Ta4UZ2
 VVMa4xGRVI6Thj9T2y5DUJ43zRkupnZrqosR9Y1yPyoNT3MNXAXycsrz/ujz+tSegK9w
 hRaa5iBJjSpQaA+oY7TBS25ByJYi0S4fYZIoTMbIC2p9EYL2FX5k8M2S2XEjq+xMzrCx
 LwgA==
X-Gm-Message-State: APjAAAUwdcUNJFOy0VgvFnKYnFyTJwQXc53bgLVhI0jwUx7fc3n5b9XY
 8ILxDtS+8tJWWurL5nQKTvcXYQ==
X-Google-Smtp-Source: APXvYqxro/tZPwQgL5xR0US06fQ7XRTOOjLQ84JSCsI7OBrHv9RfS8GmzkADJheNgyXia3cMEPseEg==
X-Received: by 2002:a7b:c202:: with SMTP id x2mr67315718wmi.49.1563899036990; 
 Tue, 23 Jul 2019 09:23:56 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id v4sm40677018wmg.22.2019.07.23.09.23.56
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 23 Jul 2019 09:23:56 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 16A661FF87;
 Tue, 23 Jul 2019 17:23:56 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Date: Tue, 23 Jul 2019 17:23:56 +0100
Message-Id: <20190723162356.3296-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::335
Subject: [Qemu-devel] [PULL v4 00/23 for 4.1-rc2] testing updates
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 4da6c0f9ebbdaaf4315c71ccd288d02b9087f8af:

  Merge remote-tracking branch 'remotes/amarkovic2/tags/mips-queue-jul-23-2019' into staging (2019-07-23 12:49:39 +0100)

are available in the Git repository at:

  https://github.com/stsquad/qemu.git tags/pull-testing-230719-4

for you to fetch changes up to 98808c3d0c162aba93fe7840a34b54c4814332d4:

  tests/docker: Refresh APT cache before installing new packages on Debian (2019-07-23 17:19:11 +0100)

----------------------------------------------------------------
Final testing updates:

  - docker sphinx updates
  - windows build re-enabled in CI
  - travis_retry for make check
  - build fixes
  - docker cache fixes

----------------------------------------------------------------
Alex Bennée (7):
      tests/docker: add test-misc for building tools & docs
      tests/migration-test: don't spam the logs when we fail
      tests/dockerfiles: update the win cross builds to stretch
      shippable: re-enable the windows cross builds
      hw/i386: also turn off VMMOUSE is VMPORT is disabled
      travis: enable travis_retry for check phase
      tests/docker: invoke the DEBUG shell with --noprofile/--norc

Marc-André Lureau (1):
      archive-source: also create a stash for submodules

Philippe Mathieu-Daudé (12):
      tests/docker: Install Sphinx in the Ubuntu images
      tests/docker: Install Sphinx in the Fedora image
      tests/docker: Install Ubuntu images noninteractively
      tests/docker: Install Sphinx in the Debian images
      tests/docker: Install the NSIS tools in the MinGW capable images
      tests/docker: Set the correct cross-PKG_CONFIG_PATH in the MXE images
      tests/docker: Install texinfo in the Fedora image
      buildsys: The NSIS Windows build requires the documentation installed
      buildsys: The NSIS Windows build requires qemu-nsis.bmp installed
      tests/docker: Let the test-mingw test generate a NSIS installer
      NSIS: Add missing firmware blobs
      tests/docker: Refresh APT cache before installing new packages on Debian

Thomas Huth (3):
      tests/qemu-iotests/check: Allow tests without groups
      tests/qemu-iotests/group: Remove some more tests from the "auto" group
      tests/qemu-iotests: Don't use 'seq' in the iotests

 .shippable.yml                                     |   9 +-
 .travis.yml                                        |   2 +-
 Makefile                                           |   3 +-
 hw/i386/Kconfig                                    |   4 +-
 qemu.nsi                                           |  11 ++
 scripts/archive-source.sh                          |  18 ++--
 tests/docker/Makefile.include                      |   6 +-
 tests/docker/dockerfiles/debian-alpha-cross.docker |   5 +-
 tests/docker/dockerfiles/debian-amd64.docker       |  20 ++--
 tests/docker/dockerfiles/debian-arm64-cross.docker |  16 +--
 tests/docker/dockerfiles/debian-armel-cross.docker |  13 +--
 tests/docker/dockerfiles/debian-armhf-cross.docker |  16 +--
 .../dockerfiles/debian-buster-arm64-cross.docker   |   5 +-
 tests/docker/dockerfiles/debian-hppa-cross.docker  |   5 +-
 tests/docker/dockerfiles/debian-m68k-cross.docker  |   5 +-
 tests/docker/dockerfiles/debian-mips-cross.docker  |  16 +--
 .../docker/dockerfiles/debian-mips64-cross.docker  |   5 +-
 .../dockerfiles/debian-mips64el-cross.docker       |  16 +--
 .../docker/dockerfiles/debian-mipsel-cross.docker  |  16 +--
 tests/docker/dockerfiles/debian-ports.docker       |   4 +-
 .../docker/dockerfiles/debian-powerpc-cross.docker |   5 +-
 tests/docker/dockerfiles/debian-ppc64-cross.docker |   5 +-
 .../docker/dockerfiles/debian-ppc64el-cross.docker |  14 +--
 .../docker/dockerfiles/debian-riscv64-cross.docker |   5 +-
 tests/docker/dockerfiles/debian-s390x-cross.docker |  15 +--
 tests/docker/dockerfiles/debian-sh4-cross.docker   |   5 +-
 tests/docker/dockerfiles/debian-sid.docker         |   6 +-
 .../docker/dockerfiles/debian-sparc64-cross.docker |   5 +-
 tests/docker/dockerfiles/debian-win32-cross.docker |  13 ++-
 tests/docker/dockerfiles/debian-win64-cross.docker |  13 ++-
 .../docker/dockerfiles/debian-xtensa-cross.docker  |   4 +-
 tests/docker/dockerfiles/debian10.docker           |   7 +-
 tests/docker/dockerfiles/debian8.docker            |   6 +-
 .../{debian8-mxe.docker => debian9-mxe.docker}     |  15 +--
 tests/docker/dockerfiles/debian9.docker            |   7 +-
 tests/docker/dockerfiles/fedora.docker             |   4 +
 tests/docker/dockerfiles/ubuntu.docker             |   3 +-
 tests/docker/dockerfiles/ubuntu1804.docker         |   3 +-
 tests/docker/run                                   |   4 +-
 tests/docker/test-mingw                            |   4 +-
 tests/docker/test-misc                             |  22 ++++
 tests/migration-test.c                             |  19 ++--
 tests/qemu-iotests/007                             |   2 +-
 tests/qemu-iotests/011                             |   2 +-
 tests/qemu-iotests/032                             |   2 +-
 tests/qemu-iotests/035                             |   2 +-
 tests/qemu-iotests/037                             |   2 +-
 tests/qemu-iotests/046                             |   2 +-
 tests/qemu-iotests/check                           |   4 +-
 tests/qemu-iotests/common.pattern                  |   4 +-
 tests/qemu-iotests/group                           | 120 +++++++++++----------
 51 files changed, 309 insertions(+), 210 deletions(-)
 rename tests/docker/dockerfiles/{debian8-mxe.docker => debian9-mxe.docker} (54%)
 create mode 100755 tests/docker/test-misc


-- 
2.20.1


