Return-Path: <SRS0=3Ld+=VU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9FE0C7618B
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 15:37:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 921722239F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 15:37:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BLshVy3G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 921722239F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45086 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpwrK-0003Bs-MN
	for qemu-devel@archiver.kernel.org; Tue, 23 Jul 2019 11:37:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49113)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hpwr9-0002js-Qw
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 11:37:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hpwr8-0007Ga-Da
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 11:37:35 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430]:45860)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hpwr8-0007Fl-4q
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 11:37:34 -0400
Received: by mail-wr1-x430.google.com with SMTP id f9so43646081wre.12
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2019 08:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ORqafQ7V1TWfSM9G+MIWMm2c3tUJzPaQi2WKEiywW4E=;
 b=BLshVy3GLwE91wsxmNH7XELGeLpRPMU5D6Br92VbNOhpAjKORsmV1RC+2cIgoiocVX
 JMYijEwTVynw4Bgq0LFjCcePgv+c/QFIydz3bkVwpQiDfaOSnF67ttt9Nt4rQHbAc9X7
 s6bfPOdzpfscikraF9U7unxJUjdHrU5rh9XGsZTM7LAREjwUPSolsZrb3EXVgOK0hgkD
 04xeP8kYRWTDfRK3XOs5Ute1hIu+uAxbFEriEJ1oqTGk3gt2VQnheepbLocvV3egE/c1
 ogodKLg2o7o/GbkxbTxgIWr6gGGaxdGNsQ+BUawGrQ2sfn7IEjw3zbLYq6kbgfg5ulzD
 YURg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ORqafQ7V1TWfSM9G+MIWMm2c3tUJzPaQi2WKEiywW4E=;
 b=Y7GUzdR4lvvQoUCNJmqiHgiLOu+p9jPvwaXQW8fgk+mJeNs3TCtlPOh+Y04McM6MS9
 Em5GIWAohSh/qU0uDgwTy3BtXNVVTsDjyxXdKT/Lpo7tVu5Uqq36ImZxJGx/iPpkJaOs
 4ronCqYnd2moc5vRKDTrsuDP9Nl/tPRi4qOYkYl7rcDGT+R8p7FN04VDbaWTJuBN5ZmK
 NOcDkL48Sz6nJztckC6qDsMPTEC5v4hUKd9CPQ81gs2vs6YgRSzm2kubLQ6MGCZNlKet
 sxeBX/0nqCP0krhsTOlI80hAbn5u6skNjBxTC74CtjC/gCbWsrlDeCdMrXyR3O42f3Gy
 6Ohg==
X-Gm-Message-State: APjAAAVEMMvEcy9bSscZRSb1fFP4w14HnYkWGixi0gC5j2BwRb/KEAlv
 A+TJ7sUnnxZoz1jSWvP5Ihf2Jw==
X-Google-Smtp-Source: APXvYqxCRk28o1YUgmZbVi7QAaQHHASEKURCJMZ+ng2OrC0Aj+jZkAFBm92tvn1AQBBHCCW809zm2A==
X-Received: by 2002:a5d:5647:: with SMTP id j7mr6251918wrw.191.1563896252280; 
 Tue, 23 Jul 2019 08:37:32 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id c11sm75437387wrq.45.2019.07.23.08.37.31
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 23 Jul 2019 08:37:31 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id E19C71FF87;
 Tue, 23 Jul 2019 16:37:30 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Date: Tue, 23 Jul 2019 16:37:30 +0100
Message-Id: <20190723153730.1808-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::430
Subject: [Qemu-devel] [PULL v3 for 4.1 00/23] testing updates
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

  https://github.com/stsquad/qemu.git tags/pull-testing-230719-3

for you to fetch changes up to e5ad6836dc0008ab6f902a63c8dc89468da8400f:

  tests/docker: Refresh APT cache before installing new packages on Debian (2019-07-23 16:07:30 +0100)

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


