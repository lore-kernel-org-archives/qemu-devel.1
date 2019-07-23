Return-Path: <SRS0=3Ld+=VU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B465C7618B
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 10:36:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD552223DD
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 10:36:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bVLREH8/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD552223DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40970 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hps9y-0006yf-CN
	for qemu-devel@archiver.kernel.org; Tue, 23 Jul 2019 06:36:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37730)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hps9Z-0005e3-0W
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 06:36:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hps9X-0007K0-JK
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 06:36:16 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430]:45061)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hps9X-0007JT-CJ
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 06:36:15 -0400
Received: by mail-wr1-x430.google.com with SMTP id f9so42565677wre.12
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2019 03:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=WOf4NNMRaucXo5koJQG7UnGOYc16QvW29DAa5MnuuL4=;
 b=bVLREH8/8Mv9xvRSGsoIEXgIIZ2OxOWDUOlxR8u0AEFZ2MkSHiixtgnXVC/6lU7pC6
 6X6C5cD1rgM+w5jEFXZ1KOq/p2bk//DlFr2PkJovjXAQDoteAM9chCoc8pEImMvSOzBo
 UK1CCEe40xZA1TKRBWg3CPJ6w1ogGWfjmGuSKtNdzI8QB1bVgZDN2fEsL4/0aQg8N4Cd
 ZCKQvJGqoeoaaa3HUaXyp8RU7/P3O2xB1ajr9RjfBcgpdFPZp8r8/l1PowCV6eKNWOVO
 lUQ/DvjnsKB1HJEGOG9nvvFUiVtucAjB0WJ2skTzc0cTWSoSaK5NmPlUbvfYXjPuRLXi
 LfMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=WOf4NNMRaucXo5koJQG7UnGOYc16QvW29DAa5MnuuL4=;
 b=rbXgulxt2DhtsLXvHdajkbz7Z3Tkl8ipz1a9Xfa7hBUp23rX7WleZBRykQBzdruZnZ
 YFTQ33k8ATmmw9+qHIYduE4vXqeNa/6mJBQX/SFTNBzkZKHHywTJCCp9zxExtJ1Z+9Pw
 8LiEj7aVUSdb7+Hx35QQzpYY/+wtnncNXwagzEvk5518m2RY/lnr4vt3hx27X2qC6D8B
 InpNrPHo0TvnYuOsPq3z9l7HUXPNFNDjBpwmKbqdMLJziQbZUXJGAWNv9Kcg9yLtB4ZC
 fQyAB7Vtlwl4Y89MPdh6cxGXC41vvV3HtPupk2SKCmFtxwdY+n69xRETp86o07//aMd9
 T1hA==
X-Gm-Message-State: APjAAAX76fG5KBpjs8904uzWeDeB26yJyMSnzPMKogP1fu/Xwson2f+o
 zsZ26+zs8p0y1JLEnEzgRxxqKn8CtUE=
X-Google-Smtp-Source: APXvYqzbznyroLuEGikmKJdOQDx1jbLt28CwMLdh9+NyWb08QJjnqqCgbdqCAzCiyk1BPZPHPoFuPw==
X-Received: by 2002:a5d:63c9:: with SMTP id c9mr44801517wrw.15.1563878174117; 
 Tue, 23 Jul 2019 03:36:14 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id f2sm35480111wrq.48.2019.07.23.03.36.12
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 23 Jul 2019 03:36:12 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 5EBD01FF87;
 Tue, 23 Jul 2019 11:36:12 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Date: Tue, 23 Jul 2019 11:35:49 +0100
Message-Id: <20190723103612.5600-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::430
Subject: [Qemu-devel] [PULL for 4.1-rc2 00/23] testing updates (green CI!)
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

The following changes since commit 23da9e297b4120ca9702cabec91599a44255fe96:

  Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20190722' into staging (2019-07-22 15:16:48 +0100)

are available in the Git repository at:

  https://github.com/stsquad/qemu.git tags/pull-testing-230719-1

for you to fetch changes up to 2e3b8743cd66f1d0fbc83051b0b6b072a97460cc:

  gitlab-ci: Remove qcow2 tests that are handled by "make check" already (2019-07-23 11:33:15 +0100)

----------------------------------------------------------------
Final testing updates:

  - docker sphinx updates
  - windows build re-enabled in CI
  - travis_retry for make check
  - quick iotests enabled for make check
  - build fixes

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

Philippe Mathieu-Daudé (11):
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

Thomas Huth (4):
      tests/qemu-iotests/check: Allow tests without groups
      tests/qemu-iotests/group: Remove some more tests from the "auto" group
      tests: Run the iotests during "make check" again
      gitlab-ci: Remove qcow2 tests that are handled by "make check" already

 .gitlab-ci.yml                                     |  13 +--
 .shippable.yml                                     |   9 +-
 .travis.yml                                        |   2 +-
 Makefile                                           |   3 +-
 hw/i386/Kconfig                                    |   4 +-
 qemu.nsi                                           |  11 ++
 scripts/archive-source.sh                          |  18 ++--
 tests/Makefile.include                             |  10 +-
 tests/check-block.sh                               |  44 ++++++--
 tests/docker/Makefile.include                      |   6 +-
 tests/docker/dockerfiles/debian-win32-cross.docker |  10 +-
 tests/docker/dockerfiles/debian-win64-cross.docker |  10 +-
 tests/docker/dockerfiles/debian10.docker           |   1 +
 .../{debian8-mxe.docker => debian9-mxe.docker}     |  11 +-
 tests/docker/dockerfiles/debian9.docker            |   1 +
 tests/docker/dockerfiles/fedora.docker             |   4 +
 tests/docker/dockerfiles/ubuntu.docker             |   3 +-
 tests/docker/dockerfiles/ubuntu1804.docker         |   3 +-
 tests/docker/run                                   |   4 +-
 tests/docker/test-mingw                            |   4 +-
 tests/docker/test-misc                             |  22 ++++
 tests/migration-test.c                             |  19 ++--
 tests/qemu-iotests-quick.sh                        |   8 --
 tests/qemu-iotests/check                           |   4 +-
 tests/qemu-iotests/group                           | 120 +++++++++++----------
 25 files changed, 212 insertions(+), 132 deletions(-)
 rename tests/docker/dockerfiles/{debian8-mxe.docker => debian9-mxe.docker} (56%)
 create mode 100755 tests/docker/test-misc
 delete mode 100755 tests/qemu-iotests-quick.sh

-- 
2.20.1


