Return-Path: <SRS0=2W3W=T4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DE06C04E84
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 09:51:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FCE12075C
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 09:51:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XClN8fGp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FCE12075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59949 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVYlu-0007jd-Nn
	for qemu-devel@archiver.kernel.org; Tue, 28 May 2019 05:51:57 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40675)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hVYk2-0006D9-7t
	for qemu-devel@nongnu.org; Tue, 28 May 2019 05:49:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hVYk0-0008Qh-JD
	for qemu-devel@nongnu.org; Tue, 28 May 2019 05:49:58 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430]:36038)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hVYk0-0008Op-96
	for qemu-devel@nongnu.org; Tue, 28 May 2019 05:49:56 -0400
Received: by mail-wr1-x430.google.com with SMTP id s17so19479393wru.3
	for <qemu-devel@nongnu.org>; Tue, 28 May 2019 02:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=6fAdZpJbVNjsCcJXmRS3EI/2mWYfuXJdR44UgTTMphQ=;
	b=XClN8fGpVmzhE7P5/nL3NICJ1DQ3bLiGdRPK/6BAyQIDw3UZ83iHxUJud2vVLwk6Ii
	NwefyCbi3qVdyKF6nIFb2CC9fTGZGz2fHn1NAo4sTd1QLMLIHosvaGnM9PV0M2SB1nuj
	r1vOhQIobZsQoi6dm6OPa7uuLeGsLipZekG/NOsb1s5tnGF52k4MXN+WPy4qq91n56ym
	F17jnNdGq8K7Y12Ng2jUl8o6Ui3TZKuh8V3ItR0Af2eEUKRFQRQ1ehUyZ8S6HRpkfdot
	sncajFNu0VfSDgxRfZghkGrfbxWOfKJuN8beY0HfVDALNfE9lNDfiNJlLgR92/xiJn+H
	omvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=6fAdZpJbVNjsCcJXmRS3EI/2mWYfuXJdR44UgTTMphQ=;
	b=Nr++CvltVn41aZH/XjSE0JMXJyBASAyi6/Tw0VlYmouYpOjFIdNHoFsQsIMhZyfq6t
	GMEZZAy/mg0M4CA3Rdi1nCNHk4thR7PO4VRFeyNDTZin6C7LM/cilwh+72ivkf0mN9Sa
	knjNgXpq8OGe8Q25AwQ1+kgyMP915UOSSkbsS84VwwmWlMLUQGMitic27LIMZPDBRRUw
	CHxNdTtMtoOQsQEha/NKYMN+t+IaYilTE6WYfzYVSlFwevq9MoAIZL3u8o4i81Q7tkyT
	4bL7SlHaDpmXKjLGSUA/2eewNVsYywcW/PLZRzKl3S+MVj14n4EckNmygyVamMDi3v40
	gwtQ==
X-Gm-Message-State: APjAAAVxVmHnBu/jhMHj+Rs5IQbg+qTgV3SjpybhFPVNVYLqCqni86oV
	3ZyAuKOon39wGH6dUSd8AVcB6A==
X-Google-Smtp-Source: APXvYqwV6uTGazI3mMdFevfaHcyZi/mnIy6ZpBRF9HYlP30lLlJTF+WS9ippqcfcdQFNAH+eyqh+gw==
X-Received: by 2002:a5d:68cd:: with SMTP id p13mr12309572wrw.0.1559036994257; 
	Tue, 28 May 2019 02:49:54 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id
	z21sm2129540wmf.25.2019.05.28.02.49.53
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Tue, 28 May 2019 02:49:53 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id 433D61FF87;
	Tue, 28 May 2019 10:49:53 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Date: Tue, 28 May 2019 10:49:25 +0100
Message-Id: <20190528094953.14898-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::430
Subject: [Qemu-devel] [PULL 00/28] testing/next (system tests, docker,
 iotests)
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit a7b21f6762a2d6ec08106d8a7ccb11829914523f:

  Merge remote-tracking branch 'remotes/vivier2/tags/linux-user-for-4.1-pull-request' into staging (2019-05-24 12:47:49 +0100)

are available in the Git repository at:

  https://github.com/stsquad/qemu.git tags/pull-testing-next-280519-1

for you to fetch changes up to 4a344d91083e351c1c5ac877c0ab215335a1e23d:

  tests: Run the iotests during "make check" again (2019-05-28 10:28:51 +0100)

----------------------------------------------------------------
Various testing updates

  - semihosting re-factor (used in system tests)
  - aarch64 and alpha system tests
  - editorconfig tweak for .S
  - some docker image updates
  - iotests clean-up and make check inclusion

----------------------------------------------------------------
Alex Bennée (23):
      semihosting: move semihosting configuration into its own directory
      semihosting: introduce CONFIG_SEMIHOSTING
      semihosting: implement a semihosting console
      semihosting: enable chardev backed output for console
      target/arm: fixup some of the commentary for arm-semi
      target/arm: use the common interface for WRITE0/WRITEC in arm-semi
      target/arm: add LOG_UNIMP messages to arm-semi
      target/arm: correct return values for WRITE/READ in arm-semi
      target/mips: only build mips-semi for softmmu
      target/mips: convert UHI_plog to use common semihosting code
      MAINTAINERS: update for semihostings new home
      tests/tcg/multiarch: add support for multiarch system tests
      tests/tcg/multiarch: add hello world system test
      editorconfig: add settings for .s/.S files
      tests/tcg/aarch64: add system boot.S
      tests/tcg/multiarch: move the system memory test
      tests/tcg/minilib: support %c format char
      tests/tcg/multiarch: expand system memory test to cover more
      .travis.yml: enable aarch64-softmmu and alpha-softmmu tcg tests
      Makefile: fix coverage-report reference to BUILD_DIR
      Makefile: include per-target build directories in coverage report
      Makefile.target: support per-target coverage reports
      tests/qemu-iotests: re-format output to for make check-block

Gerd Hoffmann (1):
      tests/docker: add ubuntu 18.04

Philippe Mathieu-Daudé (1):
      tests/docker: Test more components on the Fedora default image

Richard Henderson (1):
      tests/tcg/alpha: add system boot.S

Thomas Huth (2):
      tests/qemu-iotests/group: Re-use the "auto" group for tests that can always run
      tests: Run the iotests during "make check" again

 .editorconfig                                      |   5 +
 .travis.yml                                        |   2 +-
 MAINTAINERS                                        |   8 +
 Makefile                                           |   4 +-
 Makefile.target                                    |  16 +
 default-configs/arm-softmmu.mak                    |   1 +
 default-configs/lm32-softmmu.mak                   |   2 +
 default-configs/m68k-softmmu.mak                   |   2 +
 default-configs/mips-softmmu-common.mak            |   1 +
 default-configs/nios2-softmmu.mak                  |   2 +
 default-configs/xtensa-softmmu.mak                 |   2 +
 gdbstub.c                                          |   2 +-
 hw/Kconfig                                         |   1 +
 hw/Makefile.objs                                   |   1 +
 hw/mips/mips_malta.c                               |   2 +-
 hw/semihosting/Kconfig                             |   3 +
 hw/semihosting/Makefile.objs                       |   2 +
 hw/semihosting/config.c                            | 186 ++++++++
 hw/semihosting/console.c                           |  84 ++++
 include/hw/semihosting/console.h                   |  38 ++
 include/{exec => hw/semihosting}/semihost.h        |  17 +-
 include/sysemu/sysemu.h                            |   1 +
 linux-user/Makefile.objs                           |   2 +
 linux-user/arm/semihost.c                          |  24 +
 qemu-options.hx                                    |   6 +-
 stubs/Makefile.objs                                |   1 +
 stubs/semihost.c                                   |  70 +++
 target/arm/arm-semi.c                              |  96 ++--
 target/arm/helper.c                                |   2 +-
 target/arm/translate-a64.c                         |   2 +-
 target/arm/translate.c                             |   2 +-
 target/lm32/helper.c                               |   2 +-
 target/m68k/op_helper.c                            |   2 +-
 target/mips/Makefile.objs                          |   3 +-
 target/mips/helper.h                               |   2 +
 target/mips/mips-semi.c                            |  14 +-
 target/mips/translate.c                            |  10 +-
 target/nios2/helper.c                              |   2 +-
 target/xtensa/translate.c                          |   2 +-
 target/xtensa/xtensa-semi.c                        |   2 +-
 tests/Makefile.include                             |   8 +-
 tests/check-block.sh                               |  44 +-
 tests/docker/dockerfiles/fedora.docker             |   7 +
 tests/docker/dockerfiles/ubuntu1804.docker         |  57 +++
 tests/qemu-iotests-quick.sh                        |   8 -
 tests/qemu-iotests/check                           | 177 ++++---
 tests/qemu-iotests/group                           | 177 +++----
 tests/tcg/Makefile                                 |   1 +
 tests/tcg/aarch64/Makefile.softmmu-target          |  34 ++
 tests/tcg/aarch64/system/boot.S                    | 239 ++++++++++
 tests/tcg/aarch64/system/kernel.ld                 |  24 +
 tests/tcg/alpha/Makefile.softmmu-target            |  34 ++
 tests/tcg/alpha/system/boot.S                      | 511 +++++++++++++++++++++
 tests/tcg/alpha/system/kernel.ld                   |  30 ++
 tests/tcg/i386/Makefile.softmmu-target             |   4 +-
 tests/tcg/i386/system/memory.c                     | 243 ----------
 tests/tcg/minilib/printf.c                         |   3 +
 tests/tcg/multiarch/system/Makefile.softmmu-target |  14 +
 tests/tcg/{i386 => multiarch}/system/hello.c       |   0
 tests/tcg/multiarch/system/memory.c                | 449 ++++++++++++++++++
 vl.c                                               | 128 +-----
 61 files changed, 2216 insertions(+), 602 deletions(-)
 create mode 100644 hw/semihosting/Kconfig
 create mode 100644 hw/semihosting/Makefile.objs
 create mode 100644 hw/semihosting/config.c
 create mode 100644 hw/semihosting/console.c
 create mode 100644 include/hw/semihosting/console.h
 rename include/{exec => hw/semihosting}/semihost.h (78%)
 create mode 100644 linux-user/arm/semihost.c
 create mode 100644 stubs/semihost.c
 create mode 100644 tests/docker/dockerfiles/ubuntu1804.docker
 delete mode 100755 tests/qemu-iotests-quick.sh
 create mode 100644 tests/tcg/aarch64/Makefile.softmmu-target
 create mode 100644 tests/tcg/aarch64/system/boot.S
 create mode 100644 tests/tcg/aarch64/system/kernel.ld
 create mode 100644 tests/tcg/alpha/Makefile.softmmu-target
 create mode 100644 tests/tcg/alpha/system/boot.S
 create mode 100644 tests/tcg/alpha/system/kernel.ld
 delete mode 100644 tests/tcg/i386/system/memory.c
 create mode 100644 tests/tcg/multiarch/system/Makefile.softmmu-target
 rename tests/tcg/{i386 => multiarch}/system/hello.c (100%)
 create mode 100644 tests/tcg/multiarch/system/memory.c

-- 
2.20.1


