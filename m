Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78BC3C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 13:26:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34F742067B
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 13:26:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YntOMk+n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34F742067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39828 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7g9n-0005an-9f
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 09:26:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39591)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i7g8k-0004ot-I1
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 09:25:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i7g8i-0001NA-Ls
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 09:25:02 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c]:37050)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i7g8i-0001MV-De
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 09:25:00 -0400
Received: by mail-wr1-x42c.google.com with SMTP id i1so19641833wro.4
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2019 06:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=BZ2rS/k3ba9v52aMpOLGscrWBPgLIF2nr2uDDFMJe4M=;
 b=YntOMk+n/5KkZTJkjBo3U5CitgyIzfYXt5qHrovc923SmHALGt9MHAnkQa+kEtKbA+
 +zjYQVYhR6sYZVsKw7egu/6+LBMoUTohuEMKdWnb/te2Z00+2i31otaPUgpOxKGVap7/
 kUUMZESUHENOS6JW2HbG0zG7oyMpPtvQzPcOYAX+c1OCWJMtDyiY6Ad5TPcX560rcqE2
 rXBDyELdOFcDRLlRzu+cWBJin5XgSolieZi7obBrP3n7MNS5YPryj8FiPgaCcvgd4x8x
 L/HKdR5U7v4UyMsTnI6sMfGeZIULPovi3PUBKuBCq4G/6VQuYFZCLpOz4E9d7IRVtRD+
 Sxrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=BZ2rS/k3ba9v52aMpOLGscrWBPgLIF2nr2uDDFMJe4M=;
 b=cQNNup5KbVV3vwgpbqEogvOY0TlDB8YRDCp6cfKT6ww5ygwKO7NMV65/DHdO3gCAVa
 WhAZP8tOlXMaIduo1HFmn82zSQdgASay7QyHK0IzAhDxBufSn1Rqp+TJ00/Gl2/z/D/2
 ELwkRIx6eeJrT77pzF9uOusPSy3MrrjtZuKsioHoXQtcfCoFPrkWzVd1LqLbCKPt+yyQ
 gd3j09ghnop5uzx0M/T1tgub5FxVPOn0mmg+3a+272OQwC8exLd6D62qEPFx5VJBMPRO
 +j+uM3l72ePFZWkVHMHHv7QIb84BSc0dvb7ZVg7482kOinaI3FXX9doZtc6QXoVEEEnZ
 WQGQ==
X-Gm-Message-State: APjAAAUU+tr3qYHtzIF06SYUJLghGMj956E8GBldEeHbMmlDEvOKCYx9
 koV6QsW7Q+nCKuyegkRfDQ29eQ==
X-Google-Smtp-Source: APXvYqxDzP1yqHEGm0WoEAlZH2gJlsG7U1W488ti9Hnf8qzhT05fj3WzjhCAsTXpi6DzD/hXZ226nw==
X-Received: by 2002:a5d:5642:: with SMTP id j2mr17434776wrw.345.1568121897703; 
 Tue, 10 Sep 2019 06:24:57 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id f143sm3452261wme.40.2019.09.10.06.24.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2019 06:24:56 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 27E6C1FF87;
 Tue, 10 Sep 2019 14:24:56 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Date: Tue, 10 Sep 2019 14:24:56 +0100
Message-Id: <20190910132456.26023-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42c
Subject: [Qemu-devel] [PULL v2 00/46] testing updates (fixes, upgrades,
 caching)
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

  https://github.com/stsquad/qemu.git tags/pull-testing-next-100919-2

for you to fetch changes up to dda60da384ddbe4fc75182dd23db7e9aa4a88f46:

  tests/tcg: fix typo when calling clean-tcg (2019-09-10 14:14:32 +0100)

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
  - work around ppc64abi32 linux-test breakage [v2]

----------------------------------------------------------------
Alex Bennée (29):
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
      tests/tcg: fix typo when calling clean-tcg

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
 tests/tcg/multiarch/Makefile.target                |   7 +-
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
 72 files changed, 721 insertions(+), 611 deletions(-)
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


