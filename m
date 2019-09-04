Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EF20C3A5A9
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 21:03:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5834620674
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 21:03:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bYbwQdUS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5834620674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39786 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5cRX-00085Z-NX
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 17:03:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49672)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i5bv7-00087Q-G6
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 16:30:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i5bv3-0006WK-6B
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 16:30:25 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:36457)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i5bv1-0006Ug-8E
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 16:30:19 -0400
Received: by mail-wm1-x344.google.com with SMTP id p13so220057wmh.1
 for <qemu-devel@nongnu.org>; Wed, 04 Sep 2019 13:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=R/OdRV+hVfip7mTA91Yh+fBiJcl66+BykfGmRYjg0bE=;
 b=bYbwQdUSB0Hjffw02dO5cJv6Xtt4DXtrv21mIPISpGVKoLhcvuAy0pbosJhTskq6uP
 pg4kXhyDBMzUYfAyfOXlgkzPkLpUr79jLnV4Sz50AnHfleTVpRloaZZW5G/lUcQ+7tWU
 vOzJTCq9EeCvn7nduMm9lbNTJK6Ku1D1iBEOFQHlckqAIb/R0EcD/+9LOCKKWcYY11Em
 jMYCX41nbKNCE9PJWBNh4WJMDqLl1wXQlUtDO7E80TmovEXqiprTDQyErt+KNQlQMo0q
 ER2yFbelVvVFZiCIkBIW5abLAzn/7Yo5b8pRPIjlYk7wd7dOJmCyMDa86+aMK/gAIn1y
 ljcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=R/OdRV+hVfip7mTA91Yh+fBiJcl66+BykfGmRYjg0bE=;
 b=NutIJ3YK2YyC/LW9QjczPexZXPs1caBtvLxumAIOOZ6gCLXcfjEDOfftNunAZPOmbf
 irKxU77focUWvWXRiiX4GtRn9FzXVE5D3CgvhTerI15l8Sy5+XMtBdKNYRnMdhG5Tgch
 z4vsl+/ekAdDedpyuhnBB5dnZVXZrZV2Ge4tn3H350yaMzKu2VduQw4+J1mEK06WYsCU
 PauCcS/T2ZxOR9GuV9ZYOak8DL9PflGqij3hERx0e4yce1tTddt/dnRIS8IqulG/Dvhj
 6Y+6233WmZY1WzJL7/2BM7XbN2b1dm6jWxLEB5zpLjP00q6b3LFeuARy2eU7wFSvr2BZ
 UY+w==
X-Gm-Message-State: APjAAAVq8t00iWbnErRbVaFi/oTqstQ1yojUEdLL19WWiqIx25ZJptbu
 l08GafTDcahjGJ77acMERdvlRw==
X-Google-Smtp-Source: APXvYqzXQI6mD3R1ZIw8PKhVzAs0Ow6P4UNi7WicGkLrUgdpkI+WyxXOgpk/SCrJLGNF73Bz4JU0Tg==
X-Received: by 2002:a7b:cb81:: with SMTP id m1mr101926wmi.124.1567629016671;
 Wed, 04 Sep 2019 13:30:16 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id g24sm32321464wrb.35.2019.09.04.13.30.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Sep 2019 13:30:14 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 5A1711FF87;
 Wed,  4 Sep 2019 21:30:13 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed,  4 Sep 2019 21:29:31 +0100
Message-Id: <20190904203013.9028-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: [Qemu-devel] [PATCH  v1 00/42] current testing/next queue (podman,
 docker, ci)
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
 richard.henderson@linaro.org, f4bug@amsat.org, cota@braap.org,
 stefanha@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi All,

Here is the current status of my testing/next queue. It brings
together a number of different series as well as some CI fixes that
may be coming in view different trees. So in order we have:

Some fixes to for podman. This is a relatively new alternative to
docker and it works well but needs a little tweak to ensure we can
also use it from cross compiling check-tcg tests.

Paolo's tcg Makefile disentanglement which reduces some of the
Makefile hackage by having a tcg check specific configure step. I've
made a few minor tweaks to the configure script to fix up -static
handling and setting of make variables.

There is then a set of clean-ups to the dockerfiles whhich allow them
to default a target list in the dockerfile environment which can then
be overridden. I then update a bunch of the images to buster which
allows us to drop the rather hokey sid based approach we were using.

The next major chunk is Phillipe's caching changes which make a
considerable difference when constantly rebuild the same tree,
especially if all you are messing around with is ancillary scripts.

Finally there are a few more CI fixes including one slightly hacky
change to deal with variation in python3 implementations.

Please review ;-)

Alex Bennée (27):
  configure: clean-up container cross compile detect
  tests/docker: fix "cc" command to work with podman
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
  tests/docker: drop debian-sid image
  tests/docker: drop powerpc-user image for QEMU cross builds
  tests/docker: add debian-xtensa-cross to DEBIAN_PARTIAL_IMAGES
  tests/docker: add debian9-mxe to DEBIAN_PARTIAL_IMAGES
  tests/docker: avoid $SHELL invoke bash directly
  tests/docker: add debian-amd64-cross for non-x86 hosts
  tests/docker: use --arch-only for installing deps
  tests/docker: add more images to PARTIAL_IMAGES when not on x86_64
  configure: check if --no-pie is supported first
  tests/docker: --disable-libssh on ubuntu1804 builds
  tests/docker: don't always encoding for subprocess.check_output

Cleber Rosa (1):
  Fedora images: use URLs from stable "archives.fedoraproject.org"

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

Thomas Huth (1):
  hw/misc: Mark most objects as "common" code to speed up compilation a
    litte bit

 .travis.yml                                   |  39 ++-
 Makefile                                      |   1 +
 Makefile.target                               |   3 -
 configure                                     | 168 ++-----------
 hw/misc/Makefile.objs                         |  90 +++----
 qemu-doc.texi                                 |   6 +-
 tests/Makefile.include                        |  25 +-
 tests/acceptance/boot_linux_console.py        |  25 +-
 tests/acceptance/linux_initrd.py              |   5 +-
 tests/docker/Makefile.include                 |  61 +++--
 tests/docker/common.rc                        |   4 +
 tests/docker/docker.py                        |  51 ++--
 .../dockerfiles/debian-alpha-cross.docker     |   7 +-
 .../dockerfiles/debian-amd64-cross.docker     |  22 ++
 .../dockerfiles/debian-arm64-cross.docker     |   7 +-
 .../dockerfiles/debian-armel-cross.docker     |   3 +-
 .../dockerfiles/debian-armhf-cross.docker     |   3 +-
 .../debian-buster-arm64-cross.docker          |  16 --
 .../dockerfiles/debian-hppa-cross.docker      |   5 +-
 .../dockerfiles/debian-m68k-cross.docker      |   5 +-
 .../dockerfiles/debian-mips-cross.docker      |   7 +-
 .../dockerfiles/debian-mips64-cross.docker    |   5 +-
 .../dockerfiles/debian-mips64el-cross.docker  |   3 +-
 .../dockerfiles/debian-mipsel-cross.docker    |   2 +-
 .../dockerfiles/debian-powerpc-cross.docker   |   8 +-
 .../debian-powerpc-user-cross.docker          |  15 --
 .../dockerfiles/debian-ppc64-cross.docker     |   7 +-
 .../dockerfiles/debian-ppc64el-cross.docker   |   3 +-
 .../dockerfiles/debian-riscv64-cross.docker   |   5 +-
 .../dockerfiles/debian-s390x-cross.docker     |   3 +-
 .../dockerfiles/debian-sh4-cross.docker       |   5 +-
 tests/docker/dockerfiles/debian-sid.docker    |  41 ---
 .../dockerfiles/debian-sparc64-cross.docker   |   5 +-
 tests/docker/dockerfiles/ubuntu1804.docker    |   3 +
 tests/docker/run                              |   4 +-
 tests/docker/test-build                       |   1 -
 tests/docker/test-mingw                       |   1 -
 tests/docker/test-quick                       |   1 -
 tests/tcg/.gitignore                          |   5 +
 tests/tcg/Makefile.include                    |  88 -------
 tests/tcg/Makefile.prereqs                    |  18 ++
 tests/tcg/Makefile.probe                      |  31 ---
 tests/tcg/Makefile.qemu                       |  95 +++++++
 tests/tcg/{Makefile => Makefile.target}       |  15 +-
 tests/tcg/aarch64/Makefile.include            |   8 -
 tests/tcg/aarch64/Makefile.softmmu-target     |   4 +-
 tests/tcg/aarch64/Makefile.target             |  12 +-
 tests/tcg/alpha/Makefile.include              |   2 -
 tests/tcg/alpha/Makefile.softmmu-target       |   4 +-
 tests/tcg/arm/Makefile.include                |   8 -
 tests/tcg/arm/Makefile.softmmu-target         |   6 +-
 tests/tcg/configure.sh                        | 234 ++++++++++++++++++
 tests/tcg/cris/Makefile.include               |   6 -
 tests/tcg/hppa/Makefile.include               |   2 -
 tests/tcg/i386/Makefile.include               |   9 -
 tests/tcg/i386/Makefile.softmmu-target        |  12 +-
 tests/tcg/i386/Makefile.target                |  13 +-
 tests/tcg/m68k/Makefile.include               |   2 -
 tests/tcg/minilib/Makefile.target             |   2 +-
 tests/tcg/mips/Makefile.include               |  20 --
 tests/tcg/ppc/Makefile.include                |  10 -
 tests/tcg/riscv/Makefile.include              |  10 -
 tests/tcg/s390x/Makefile.include              |   2 -
 tests/tcg/sh4/Makefile.include                |   4 -
 tests/tcg/sparc64/Makefile.include            |   2 -
 tests/tcg/x86_64/Makefile.softmmu-target      |  36 +++
 tests/tcg/x86_64/Makefile.target              |   7 +-
 tests/tcg/xtensa/Makefile.include             |  11 -
 tests/tcg/xtensa/Makefile.softmmu-target      |   4 +-
 tests/vm/fedora                               |   2 +-
 70 files changed, 693 insertions(+), 656 deletions(-)
 create mode 100644 tests/docker/dockerfiles/debian-amd64-cross.docker
 delete mode 100644 tests/docker/dockerfiles/debian-buster-arm64-cross.docker
 delete mode 100644 tests/docker/dockerfiles/debian-powerpc-user-cross.docker
 delete mode 100644 tests/docker/dockerfiles/debian-sid.docker
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


