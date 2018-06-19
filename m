Received: from eggs.gnu.org ([2001:4830:134:3::10]:35021)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fVIoD-0006Us-Uy
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 11:44:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fVIoA-0006JA-Md
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 11:44:41 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:52688)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fVIoA-0006It-BV
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 11:44:38 -0400
Received: by mail-wm0-x241.google.com with SMTP id p126-v6so1184106wmb.2
	for <qemu-devel@nongnu.org>; Tue, 19 Jun 2018 08:44:37 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue, 19 Jun 2018 16:43:39 +0100
Message-Id: <20180619154435.18898-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 00/56] add check-tcg and associated machinery
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, cota@braap.org, famz@redhat.com, berrange@redhat.com, f4bug@amsat.org, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

The following changes since commit 2ef2f16781af9dee6ba6517755e9073ba5799fa2:

  Merge remote-tracking branch 'remotes/dgilbert/tags/pull-migration-20180615a' into staging (2018-06-15 18:13:35 +0100)

are available in the Git repository at:

  https://github.com/stsquad/qemu.git tags/pull-tcg-testing-revivial-190618-1

for you to fetch changes up to 03c79cb5825f2e930a39839e8375dc0feef6d57d:

  .travis.yml: add check-tcg test (2018-06-19 16:38:54 +0100)

----------------------------------------------------------------
Add check-tcg machinary

This restores the ability to run TCG smoke tests by using our docker
infrastructure to support cross building simple tests. It represents
the first step to making better cross-architecture testing available
straight from the source tree ;-)

----------------------------------------------------------------
Alex Bennée (54):
      configure: add support for --cross-cc-FOO
      configure: move i386_cc to cross_cc_i386
      configure: allow user to specify --cross-cc-cflags-foo=
      configure: set cross_cc_FOO for host compiler
      docker: Add "cc" subcommand
      docker: extend "cc" command to accept compiler
      docker: allow "cc" command to run in user context
      docker: Makefile.include introduce DOCKER_SCRIPT
      tests/tcg: move architecture independent tests into subdir
      tests/tcg/multiarch: enable additional linux-test tests
      tests/tcg/multiarch: don't hard code paths/ports for linux-test
      tests/tcg/multiarch: move most output to stdout
      tests/tcg: move i386 specific tests into subdir
      tests/tcg: enable building for i386
      tests/tcg/i386: fix test-i386
      tests/tcg/i386: add runner for test-i386-fprem
      tests/tcg/x86_64: add Makefile.target
      tests/tcg/i386/test-i386: use modern vector_size attributes
      tests/tcg/i386/test-i386: fix printf format
      tests/tcg: move ARM specific tests into subdir
      tests/tcg: enable building for ARM
      tests/tcg/arm: fix up test-arm-iwmmxt test
      tests/tcg: enable building for AArch64
      tests/tcg/arm: add fcvt test cases for AArch32/64
      tests/tcg: move MIPS specific tests into subdir
      tests/tcg: enable building for MIPS
      tests/docker/Makefile.include: fix mipsel-cross dependancy
      tests/tcg/mips: include common mips hello-mips
      tests/tcg: enable building for s390x
      tests/tcg: enable building for ppc64
      tests/tcg: enable building for Alpha
      tests/tcg/alpha: add Alpha specific tests
      tests/tcg: enable building for HPPA
      tests/tcg: enable building for m68k
      tests/tcg: enable building for sh4
      tests/tcg: enable building for sparc64
      tests/tcg: enable building for mips64
      tests/tcg: enable building for RISCV64
      docker: move debian-powerpc-cross to sid based build
      tests/tcg: enable building for PowerPC
      tests/tcg/Makefile: update to be called from Makefile.target
      Makefile.target: add (clean-/build-)guest-tests targets
      tests/Makefile.include: add [build|clean|check]-tcg targets
      tests/tcg: add run, diff, and skip helper macros
      tests/tcg: override runners for broken tests
      tests/tcg/i386: extend timeout for runcom test
      tests: add top-level make dependency for docker builds
      docker: docker.py use "version" to probe usage
      docker: docker.py don't conflate checksums for extra_files
      docker: docker.py add check sub-command
      tests/Makefile: call sub-makes with SKIP_DOCKER_BUILD=1
      docker: docker.py adding age check command
      tests/docker/Makefile.include: only force SID to NOCACHE if old
      .travis.yml: add check-tcg test

Fam Zheng (2):
      tests/tcg/multiarch: Build fix for linux-test
      tests/tcg/i386: Build fix for hello-i386

 .travis.yml                                        |    8 +
 MAINTAINERS                                        |   15 +
 Makefile.target                                    |    5 +
 configure                                          |  134 +-
 tests/Makefile.include                             |   41 +-
 tests/docker/Makefile.include                      |   47 +-
 tests/docker/docker.py                             |  107 +-
 tests/docker/dockerfiles/debian-alpha-cross.docker |   12 +
 tests/docker/dockerfiles/debian-apt-fake.sh        |   46 -
 tests/docker/dockerfiles/debian-hppa-cross.docker  |   12 +
 tests/docker/dockerfiles/debian-m68k-cross.docker  |   12 +
 .../docker/dockerfiles/debian-mips64-cross.docker  |   12 +
 .../docker/dockerfiles/debian-powerpc-cross.docker |   39 +-
 .../docker/dockerfiles/debian-riscv64-cross.docker |   12 +
 tests/docker/dockerfiles/debian-sh4-cross.docker   |   12 +
 tests/docker/dockerfiles/debian-sid.docker         |   32 +
 .../docker/dockerfiles/debian-sparc64-cross.docker |   12 +
 tests/docker/dockerfiles/debian8.docker            |    3 -
 tests/tcg/Makefile                                 |  219 +-
 tests/tcg/Makefile.include                         |   88 +
 tests/tcg/Makefile.probe                           |   31 +
 tests/tcg/README                                   |   69 +-
 tests/tcg/aarch64/Makefile.include                 |    8 +
 tests/tcg/aarch64/Makefile.target                  |   17 +
 tests/tcg/aarch64/fcvt.ref                         | 3268 ++++++++++++++++++++
 tests/tcg/alpha/Makefile                           |   35 -
 tests/tcg/alpha/Makefile.include                   |    2 +
 tests/tcg/alpha/Makefile.target                    |   18 +
 tests/tcg/alpha/crt.s                              |   26 -
 tests/tcg/alpha/hello-alpha.c                      |    2 +
 tests/tcg/alpha/test-cond.c                        |    1 +
 tests/tcg/alpha/test-ovf.c                         |    2 +
 tests/tcg/arm/Makefile.include                     |    8 +
 tests/tcg/arm/Makefile.target                      |   32 +
 tests/tcg/arm/README                               |   11 +
 tests/tcg/arm/fcvt.c                               |  458 +++
 tests/tcg/arm/fcvt.ref                             | 3268 ++++++++++++++++++++
 tests/tcg/{ => arm}/hello-arm.c                    |    0
 .../{test-arm-iwmmxt.s => arm/test-arm-iwmmxt.S}   |    0
 tests/tcg/hppa/Makefile.include                    |    2 +
 tests/tcg/hppa/Makefile.target                     |    6 +
 tests/tcg/i386/Makefile.include                    |    9 +
 tests/tcg/i386/Makefile.target                     |   52 +
 tests/tcg/i386/README                              |   38 +
 tests/tcg/{ => i386}/hello-i386.c                  |    1 +
 tests/tcg/{ => i386}/pi_10.com                     |  Bin
 tests/tcg/{ => i386}/runcom.c                      |    0
 tests/tcg/{ => i386}/test-i386-code16.S            |    0
 tests/tcg/{ => i386}/test-i386-fprem.c             |   12 +-
 tests/tcg/{ => i386}/test-i386-muldiv.h            |    0
 tests/tcg/{ => i386}/test-i386-shift.h             |    0
 tests/tcg/{ => i386}/test-i386-ssse3.c             |    0
 tests/tcg/{ => i386}/test-i386-vm86.S              |    0
 tests/tcg/{ => i386}/test-i386.c                   |    7 +-
 tests/tcg/{ => i386}/test-i386.h                   |    0
 tests/tcg/m68k/Makefile.include                    |    2 +
 tests/tcg/m68k/Makefile.target                     |    7 +
 tests/tcg/mips/Makefile.include                    |   20 +
 tests/tcg/mips/Makefile.target                     |   22 +
 tests/tcg/mips/README                              |    7 +
 tests/tcg/{ => mips}/hello-mips.c                  |    0
 tests/tcg/multiarch/Makefile.target                |   36 +
 tests/tcg/multiarch/README                         |    1 +
 tests/tcg/{ => multiarch}/linux-test.c             |  150 +-
 tests/tcg/{ => multiarch}/sha1.c                   |    0
 tests/tcg/{ => multiarch}/test-mmap.c              |   40 +-
 tests/tcg/{ => multiarch}/testthread.c             |    0
 tests/tcg/ppc/Makefile.include                     |    7 +
 tests/tcg/ppc/Makefile.target                      |   12 +
 tests/tcg/riscv/Makefile.include                   |   10 +
 tests/tcg/s390x/Makefile.include                   |    2 +
 tests/tcg/sh4/Makefile.include                     |    4 +
 tests/tcg/sh4/Makefile.target                      |    7 +
 tests/tcg/sparc64/Makefile.include                 |    2 +
 tests/tcg/sparc64/Makefile.target                  |   11 +
 tests/tcg/test_path.c                              |  157 -
 tests/tcg/x86_64/Makefile.target                   |   15 +
 77 files changed, 8136 insertions(+), 627 deletions(-)
 create mode 100644 tests/docker/dockerfiles/debian-alpha-cross.docker
 delete mode 100755 tests/docker/dockerfiles/debian-apt-fake.sh
 create mode 100644 tests/docker/dockerfiles/debian-hppa-cross.docker
 create mode 100644 tests/docker/dockerfiles/debian-m68k-cross.docker
 create mode 100644 tests/docker/dockerfiles/debian-mips64-cross.docker
 create mode 100644 tests/docker/dockerfiles/debian-riscv64-cross.docker
 create mode 100644 tests/docker/dockerfiles/debian-sh4-cross.docker
 create mode 100644 tests/docker/dockerfiles/debian-sid.docker
 create mode 100644 tests/docker/dockerfiles/debian-sparc64-cross.docker
 create mode 100644 tests/tcg/Makefile.include
 create mode 100644 tests/tcg/Makefile.probe
 create mode 100644 tests/tcg/aarch64/Makefile.include
 create mode 100644 tests/tcg/aarch64/Makefile.target
 create mode 100644 tests/tcg/aarch64/fcvt.ref
 delete mode 100644 tests/tcg/alpha/Makefile
 create mode 100644 tests/tcg/alpha/Makefile.include
 create mode 100644 tests/tcg/alpha/Makefile.target
 delete mode 100644 tests/tcg/alpha/crt.s
 create mode 100644 tests/tcg/arm/Makefile.include
 create mode 100644 tests/tcg/arm/Makefile.target
 create mode 100644 tests/tcg/arm/README
 create mode 100644 tests/tcg/arm/fcvt.c
 create mode 100644 tests/tcg/arm/fcvt.ref
 rename tests/tcg/{ => arm}/hello-arm.c (100%)
 rename tests/tcg/{test-arm-iwmmxt.s => arm/test-arm-iwmmxt.S} (100%)
 create mode 100644 tests/tcg/hppa/Makefile.include
 create mode 100644 tests/tcg/hppa/Makefile.target
 create mode 100644 tests/tcg/i386/Makefile.include
 create mode 100644 tests/tcg/i386/Makefile.target
 create mode 100644 tests/tcg/i386/README
 rename tests/tcg/{ => i386}/hello-i386.c (96%)
 rename tests/tcg/{ => i386}/pi_10.com (100%)
 rename tests/tcg/{ => i386}/runcom.c (100%)
 rename tests/tcg/{ => i386}/test-i386-code16.S (100%)
 rename tests/tcg/{ => i386}/test-i386-fprem.c (97%)
 rename tests/tcg/{ => i386}/test-i386-muldiv.h (100%)
 rename tests/tcg/{ => i386}/test-i386-shift.h (100%)
 rename tests/tcg/{ => i386}/test-i386-ssse3.c (100%)
 rename tests/tcg/{ => i386}/test-i386-vm86.S (100%)
 rename tests/tcg/{ => i386}/test-i386.c (99%)
 rename tests/tcg/{ => i386}/test-i386.h (100%)
 create mode 100644 tests/tcg/m68k/Makefile.include
 create mode 100644 tests/tcg/m68k/Makefile.target
 create mode 100644 tests/tcg/mips/Makefile.include
 create mode 100644 tests/tcg/mips/Makefile.target
 create mode 100644 tests/tcg/mips/README
 rename tests/tcg/{ => mips}/hello-mips.c (100%)
 create mode 100644 tests/tcg/multiarch/Makefile.target
 create mode 100644 tests/tcg/multiarch/README
 rename tests/tcg/{ => multiarch}/linux-test.c (81%)
 rename tests/tcg/{ => multiarch}/sha1.c (100%)
 rename tests/tcg/{ => multiarch}/test-mmap.c (93%)
 rename tests/tcg/{ => multiarch}/testthread.c (100%)
 create mode 100644 tests/tcg/ppc/Makefile.include
 create mode 100644 tests/tcg/ppc/Makefile.target
 create mode 100644 tests/tcg/riscv/Makefile.include
 create mode 100644 tests/tcg/s390x/Makefile.include
 create mode 100644 tests/tcg/sh4/Makefile.include
 create mode 100644 tests/tcg/sh4/Makefile.target
 create mode 100644 tests/tcg/sparc64/Makefile.include
 create mode 100644 tests/tcg/sparc64/Makefile.target
 delete mode 100644 tests/tcg/test_path.c
 create mode 100644 tests/tcg/x86_64/Makefile.target

--
2.17.1
