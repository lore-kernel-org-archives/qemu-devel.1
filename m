Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B0B7C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 08:51:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6754120863
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 08:51:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ybtewwPN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6754120863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35810 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7brq-0000wV-88
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 04:51:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35744)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i7bki-0003K7-2A
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 04:43:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i7bkg-0006Gy-1E
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 04:43:55 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a]:35582)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i7bkf-0006GL-6F
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 04:43:53 -0400
Received: by mail-wr1-x42a.google.com with SMTP id g7so18420577wrx.2
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2019 01:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=AdWgq4tRQb7WRwYVIuU3m8Ztq0cv+cQYX0f+UsriHMs=;
 b=ybtewwPNaXzWXowa9eP1IShs5k2+CXNcTDM1zSKr63OXOMOu0C6GjkblGtsZSgU23S
 4oSY7oD/H4V/2Qd6rBToT8JejZo/cvzwepVIcQu5QlKuX4AHCoEA1CuEtu6oOz3zBzam
 crApEPo+a8Zfj134ZZkyC1aJTSqZmHWBox3XAJOUeaaYehpdAyLD4E9pQQHB/0+IaVCw
 4Ol55+bD/65t9NjNopZMdFGBVjmZkCbi+ZcS/hOGK9i8MDUfmv2NBt20FlIr0LkFEFTJ
 p3DgX8QCHk7U+PxWRKie2WifthYQZnE6HqU8WiriXs+dFb9PgVUu1Qfm/IKqoo9Wyaj1
 dIvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=AdWgq4tRQb7WRwYVIuU3m8Ztq0cv+cQYX0f+UsriHMs=;
 b=MGKkuf7McNf2D5SIATasnN7j5ucqxBA5ROSxjCaEEMOqNkRXmdl5ZGN5if0YWJWd8a
 w3vFctYpZwIlndhkjKB89gPpwcB9vpMO4co17iLuQfaAA2bLI1W3yGADhjzLW3r8rv9/
 qIIzK/wQCt90c0myNe63NzizRTthghjDqfdQe5kLSeUqhzi/nbS9OCQjwoi4PGm2bBRP
 yXZpeOwJl2velEa4XXSLpitXLR208VGr8G8hBZnh2jotDaw8BrPLYqVmxQad/+3y/1Jo
 s9BVcV9iUMCuT8rjkOT/V8HnMpnoLLwg+gv8qnI0lCNRm7Jy/3/JirUGMUNgYNMyUcsN
 Y5gQ==
X-Gm-Message-State: APjAAAUWoSImcuQiarkDFQPphoXSALaOvfR3lymKC/7Mbf4sOt/yKVml
 moASP/5M+ozjN7LMEmiTT2Fc2SbNTGI=
X-Google-Smtp-Source: APXvYqwJFohWi8hcusK+g86TtGl9JP3BzQr2SiK/fP0r/4EWhuaDDiDatpxUrIdt4GzoVxcT6nQmyg==
X-Received: by 2002:adf:d84f:: with SMTP id k15mr22949623wrl.70.1568105031500; 
 Tue, 10 Sep 2019 01:43:51 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id z189sm3131482wmc.25.2019.09.10.01.43.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2019 01:43:50 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 71A131FF87;
 Tue, 10 Sep 2019 09:43:49 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Date: Tue, 10 Sep 2019 09:43:04 +0100
Message-Id: <20190910084349.28817-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42a
Subject: [Qemu-devel] [PULL 00/45] testing updates (fixes, upgrades, caching)
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

The following changes since commit 89ea03a7dc83ca36b670ba7f787802791fcb04b1:

  Merge remote-tracking branch 'remotes/huth-gitlab/tags/m68k-pull-2019-09-07' into staging (2019-09-09 09:48:34 +0100)

are available in the Git repository at:

  https://github.com/stsquad/qemu.git tags/pull-testing-next-100919-1

for you to fetch changes up to 4cf22bac5b22a36adf23dc9ec4628c66bbc6f209:

  travis.yml: Install libcap-dev for testing virito-9p (2019-09-10 09:39:09 +0100)

----------------------------------------------------------------
Testing fixes:

  - podman cleanups
  - docker.py python3 fixes (encode)
  - DEF_TARGET_LIST applied to cross build images
  - move a bunch to Buster based images
  - enable Travis caching
  - more common objs for faster builds
  - stable URLs for acceptance tests
  - additional travis dependencies

----------------------------------------------------------------
Alex Bennée (28):
      configure: clean-up container cross compile detect
      tests/docker: fix "cc" command to work with podman
      tests/docker: handle missing encoding keyword for subprocess.check_output
      tests/docker: fix final missing .encode when parsing solibs
      tests/tcg: add .gitignore for in source builds
      tests/docker: move DEF_TARGET_LIST setting to common.rc
      tests/docker: set DEF_TARGET_LIST for some containers
      tests/docker: add Buster to DOCKER_PARTIAL_IMAGES
      tests/docker: move our arm64 cross compile to Buster
      tests/docker: move our powerpc cross compile to Buster
      tests/docker: move our Alpha cross compile to Buster
      tests/docker: move our HPPA cross compile to Buster
      tests/docker: move our m68k cross compile to Buster
      tests/docker: move our sparc64 cross compile to Buster
      tests/docker: move our sh4 cross compile to Buster
      tests/docker: move our mips64 cross compile to Buster
      tests/docker: move our riscv64 cross compile to Buster
      tests/docker: move our ppc64 cross compile to Buster
      tests/docker: update Debian Sid image
      tests/docker: pin powerpc-user-cross to a snapshot
      tests/docker: add debian-xtensa-cross to DEBIAN_PARTIAL_IMAGES
      tests/docker: add debian9-mxe to DEBIAN_PARTIAL_IMAGES
      tests/docker: avoid $SHELL invoke bash directly
      tests/docker: add debian-amd64-cross for non-x86 hosts
      tests/docker: use --arch-only for installing deps
      tests/docker: add more images to PARTIAL_IMAGES when not on x86_64
      tests/docker: --disable-libssh on ubuntu1804 builds
      configure: check if --no-pie is supported first

Cleber Rosa (1):
      Fedora images: use URLs from stable "archives.fedoraproject.org"

John Snow (1):
      tests/docker: Use --userns=keep-id for podman

Paolo Bonzini (3):
      tests/tcg: use EXTRA_CFLAGS everywhere
      tests/tcg: cleanup Makefile inclusions
      tests/tcg: move configuration to a sub-shell script

Philippe Mathieu-Daudé (10):
      .travis.yml: Enable multiple caching features
      .travis.yml: Increase cache timeout from 3min to 20min
      .travis.yml: Cache Python PIP packages
      .travis.yml: Cache Avocado cache
      .travis.yml: Improve ccache use
      .travis.yml: Enable ccache on OSX
      .travis.yml: Document how the build matrix use caches
      .travis.yml: Cache Linux/GCC 'debug profile' jobs together
      .travis.yml: Cache Linux/GCC 'non-debug profile' jobs together
      .travis.yml: Cache Linux/Clang jobs together

Thomas Huth (2):
      hw/misc: Mark most objects as "common" code to speed up compilation a litte bit
      travis.yml: Install libcap-dev for testing virito-9p

 .shippable.yml                                     |   2 +
 .travis.yml                                        |  40 +++-
 Makefile                                           |   1 +
 Makefile.target                                    |   3 -
 configure                                          | 168 ++-------------
 hw/misc/Makefile.objs                              |  90 ++++----
 qemu-doc.texi                                      |   6 +-
 tests/Makefile.include                             |  25 ++-
 tests/acceptance/boot_linux_console.py             |  25 ++-
 tests/acceptance/linux_initrd.py                   |   5 +-
 tests/docker/Makefile.include                      |  58 +++--
 tests/docker/common.rc                             |   4 +
 tests/docker/docker.py                             |  51 +++--
 tests/docker/dockerfiles/debian-alpha-cross.docker |   7 +-
 tests/docker/dockerfiles/debian-amd64-cross.docker |  22 ++
 tests/docker/dockerfiles/debian-arm64-cross.docker |   7 +-
 tests/docker/dockerfiles/debian-armel-cross.docker |   3 +-
 tests/docker/dockerfiles/debian-armhf-cross.docker |   3 +-
 .../dockerfiles/debian-buster-arm64-cross.docker   |  16 --
 tests/docker/dockerfiles/debian-hppa-cross.docker  |   5 +-
 tests/docker/dockerfiles/debian-m68k-cross.docker  |   5 +-
 tests/docker/dockerfiles/debian-mips-cross.docker  |   7 +-
 .../docker/dockerfiles/debian-mips64-cross.docker  |   5 +-
 .../dockerfiles/debian-mips64el-cross.docker       |   3 +-
 .../docker/dockerfiles/debian-mipsel-cross.docker  |   2 +-
 .../docker/dockerfiles/debian-powerpc-cross.docker |   8 +-
 .../dockerfiles/debian-powerpc-user-cross.docker   |   8 +-
 tests/docker/dockerfiles/debian-ppc64-cross.docker |   7 +-
 .../docker/dockerfiles/debian-ppc64el-cross.docker |   3 +-
 .../docker/dockerfiles/debian-riscv64-cross.docker |   5 +-
 tests/docker/dockerfiles/debian-s390x-cross.docker |   3 +-
 tests/docker/dockerfiles/debian-sh4-cross.docker   |   5 +-
 tests/docker/dockerfiles/debian-sid.docker         |  24 +--
 .../docker/dockerfiles/debian-sparc64-cross.docker |   5 +-
 tests/docker/dockerfiles/ubuntu1804.docker         |   3 +
 tests/docker/run                                   |   4 +-
 tests/docker/test-build                            |   1 -
 tests/docker/test-mingw                            |   1 -
 tests/docker/test-quick                            |   1 -
 tests/tcg/.gitignore                               |   5 +
 tests/tcg/Makefile.include                         |  88 --------
 tests/tcg/Makefile.prereqs                         |  18 ++
 tests/tcg/Makefile.probe                           |  31 ---
 tests/tcg/Makefile.qemu                            |  95 +++++++++
 tests/tcg/{Makefile => Makefile.target}            |  15 +-
 tests/tcg/aarch64/Makefile.include                 |   8 -
 tests/tcg/aarch64/Makefile.softmmu-target          |   4 +-
 tests/tcg/aarch64/Makefile.target                  |  12 +-
 tests/tcg/alpha/Makefile.include                   |   2 -
 tests/tcg/alpha/Makefile.softmmu-target            |   4 +-
 tests/tcg/arm/Makefile.include                     |   8 -
 tests/tcg/arm/Makefile.softmmu-target              |   6 +-
 tests/tcg/configure.sh                             | 234 +++++++++++++++++++++
 tests/tcg/cris/Makefile.include                    |   6 -
 tests/tcg/hppa/Makefile.include                    |   2 -
 tests/tcg/i386/Makefile.include                    |   9 -
 tests/tcg/i386/Makefile.softmmu-target             |  12 +-
 tests/tcg/i386/Makefile.target                     |  13 +-
 tests/tcg/m68k/Makefile.include                    |   2 -
 tests/tcg/minilib/Makefile.target                  |   2 +-
 tests/tcg/mips/Makefile.include                    |  20 --
 tests/tcg/ppc/Makefile.include                     |  10 -
 tests/tcg/riscv/Makefile.include                   |  10 -
 tests/tcg/s390x/Makefile.include                   |   2 -
 tests/tcg/sh4/Makefile.include                     |   4 -
 tests/tcg/sparc64/Makefile.include                 |   2 -
 tests/tcg/x86_64/Makefile.softmmu-target           |  36 ++++
 tests/tcg/x86_64/Makefile.target                   |   7 +-
 tests/tcg/xtensa/Makefile.include                  |  11 -
 tests/tcg/xtensa/Makefile.softmmu-target           |   4 +-
 tests/vm/fedora                                    |   2 +-
 71 files changed, 715 insertions(+), 610 deletions(-)
 create mode 100644 tests/docker/dockerfiles/debian-amd64-cross.docker
 delete mode 100644 tests/docker/dockerfiles/debian-buster-arm64-cross.docker
 create mode 100644 tests/tcg/.gitignore
 delete mode 100644 tests/tcg/Makefile.include
 create mode 100644 tests/tcg/Makefile.prereqs
 delete mode 100644 tests/tcg/Makefile.probe
 create mode 100644 tests/tcg/Makefile.qemu
 rename tests/tcg/{Makefile => Makefile.target} (90%)
 delete mode 100644 tests/tcg/aarch64/Makefile.include
 delete mode 100644 tests/tcg/alpha/Makefile.include
 delete mode 100644 tests/tcg/arm/Makefile.include
 create mode 100755 tests/tcg/configure.sh
 delete mode 100644 tests/tcg/cris/Makefile.include
 delete mode 100644 tests/tcg/hppa/Makefile.include
 delete mode 100644 tests/tcg/i386/Makefile.include
 delete mode 100644 tests/tcg/m68k/Makefile.include
 delete mode 100644 tests/tcg/mips/Makefile.include
 delete mode 100644 tests/tcg/ppc/Makefile.include
 delete mode 100644 tests/tcg/riscv/Makefile.include
 delete mode 100644 tests/tcg/s390x/Makefile.include
 delete mode 100644 tests/tcg/sh4/Makefile.include
 delete mode 100644 tests/tcg/sparc64/Makefile.include
 create mode 100644 tests/tcg/x86_64/Makefile.softmmu-target
 delete mode 100644 tests/tcg/xtensa/Makefile.include

--
2.20.1


