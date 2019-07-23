Return-Path: <SRS0=3Ld+=VU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5120C7618B
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 13:31:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82B4822543
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 13:31:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oSVQA41l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82B4822543
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42472 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hputP-0004FH-IR
	for qemu-devel@archiver.kernel.org; Tue, 23 Jul 2019 09:31:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59525)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hput3-0003gX-Gd
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 09:31:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hput2-00078e-1f
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 09:31:25 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e]:44597)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hpusz-00076j-En
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 09:31:23 -0400
Received: by mail-wr1-x42e.google.com with SMTP id p17so43167839wrf.11
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2019 06:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=8QtdQUtRYR/obCKdMlsSMMGnbGUhamNs987ASC+eYRc=;
 b=oSVQA41lgVvjB6kZv4QudGJvI6+rH1AIF8jLZXQfrYi4cNaL7/P4gCPS6UBfWfaQLC
 QCZk7BqD74pFUWD7odSf+qMhajuRyGoWWgLfjbz8z/iJTnptQx9+7zCcAm8o8UUSJZbS
 4/eU39fCHQ/3HSgnWCKILHmu/mSp3qpCbrWyipqprndsWTzhetCTr1eAyHtdQwF0bVcr
 gNknYNQTkA8tDU+OhVAaiuD+LiRMMs1HSukZcFvNSVlHhMVOTskU7+om4lyd1mtcoB2Y
 Ilz9euEhFQo8XZBYkU9fD1gKRi346G3fsVnxmyOH47dBTQvRx13DlVoflQIveagXnSR4
 JQeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=8QtdQUtRYR/obCKdMlsSMMGnbGUhamNs987ASC+eYRc=;
 b=dMIxqcdvX495dKaZEEcRmG+oWsquFELoLNof5ipx89tGGGiHYCaZjwQelzEw+2WmZB
 D2jm7NO1L9ih/UPS8BE5wch56qX4ezy5G99Z5AuZzyBDl+/pO6ICs1wHEHZlaVDSq7DK
 EkNfL4eBe3H9j0wIYhOoJ20ZoLwfBcqYPYSX3uMfdZldF35xnBU9OCMGI3FaHUtfPvDd
 8jzW2IEFBSFi59uHqwMkU3bpPzr7E0UKz2P+IcrOo3M4yMj6CIoajW2Bc4aYvmxJfBnV
 o1VTo+zGT/1V9FwNg0gwBPieGu6/tzzkTmxKlCK77hD+7tostVCnZmKx7m5nYQ0b1rcP
 uUeQ==
X-Gm-Message-State: APjAAAU9/fjEWZwuAxACkkoPvO1YpK6jyj8V1V3eJSZMRLOct4L/3dif
 ljElp5uCEn9mI7UErLxcjquZmg==
X-Google-Smtp-Source: APXvYqwJceOnzQ24KqNJaw0dvSbL2RzRJfcPFEgCdU4XOXLnyr88PfM33Dt1IakB8eAczH42Y9uGzg==
X-Received: by 2002:adf:a341:: with SMTP id d1mr33543893wrb.260.1563888679103; 
 Tue, 23 Jul 2019 06:31:19 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id a2sm42167349wmj.9.2019.07.23.06.31.18
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 23 Jul 2019 06:31:18 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 217941FF87;
 Tue, 23 Jul 2019 14:31:18 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Date: Tue, 23 Jul 2019 14:31:18 +0100
Message-Id: <20190723133118.27244-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42e
Subject: [Qemu-devel] [PULL v2 00/22 for 4.1] testing updates
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

  https://github.com/stsquad/qemu.git tags/pull-testing-230719-2

for you to fetch changes up to e2e767784eec076bc57a1516967661d11e76aee8:

  tests/qemu-iotests: Don't use 'seq' in the iotests (2019-07-23 14:22:02 +0100)

----------------------------------------------------------------
Final testing updates:

  - docker sphinx updates
  - windows build re-enabled in CI
  - travis_retry for make check
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
 tests/qemu-iotests/007                             |   2 +-
 tests/qemu-iotests/011                             |   2 +-
 tests/qemu-iotests/032                             |   2 +-
 tests/qemu-iotests/035                             |   2 +-
 tests/qemu-iotests/037                             |   2 +-
 tests/qemu-iotests/046                             |   2 +-
 tests/qemu-iotests/check                           |   4 +-
 tests/qemu-iotests/common.pattern                  |   4 +-
 tests/qemu-iotests/group                           | 120 +++++++++++----------
 28 files changed, 176 insertions(+), 109 deletions(-)
 rename tests/docker/dockerfiles/{debian8-mxe.docker => debian9-mxe.docker} (56%)
 create mode 100755 tests/docker/test-misc


-- 
2.20.1


