Received: from eggs.gnu.org ([2001:4830:134:3::10]:49979)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fadkP-0001ae-R1
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 05:06:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fadkL-0007L8-NM
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 05:06:49 -0400
Received: from mail-wm0-x236.google.com ([2a00:1450:400c:c09::236]:54359)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fadkL-0007Ky-G3
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 05:06:45 -0400
Received: by mail-wm0-x236.google.com with SMTP id i139-v6so4964329wmf.4
	for <qemu-devel@nongnu.org>; Wed, 04 Jul 2018 02:06:45 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Wed,  4 Jul 2018 10:06:42 +0100
Message-Id: <20180704090642.3469-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL v2 00/20] Travis,
 Code Coverage and Cross Build updates
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

The following changes since commit 2a018f6e98782a4931b936a3087404ed81685bac:

  Merge remote-tracking branch 'remotes/berrange/tags/qcrypto-next-pull-request' into staging (2018-07-03 23:06:18 +0100)

are available in the Git repository at:

  https://github.com/stsquad/qemu.git tags/pull-code-coverage-and-build-tweaks-040718-2

for you to fetch changes up to a785003b11220afebae929b5c52f3b69bbfc4a40:

  docker: add linux-user powered cross builder for QEMU (2018-07-04 09:30:33 +0100)

----------------------------------------------------------------
Code coverage and other build tweaks

  - revert 208ecb3e (and drop filter for mingw)
  - some travis speed-ups
  - modernise code coverage support
  - docker image cleanups
  - clean-up binfmt_misc docker infrastructure
  - add debian-powerpc-user-cross image for ppc32 build

----------------------------------------------------------------
Alex Bennée (14):
      Revert "Makefile: Rename TARGET_DIRS to TARGET_LIST"
      build-system: remove per-test GCOV reporting
      .gitignore: add .gcov files
      docker: add gcovr to travis image
      travis: add gcovr summary for GCOV build
      build-system: add clean-coverage target
      build-system: add coverage-report target
      linux-user: introduce preexit_cleanup
      linux-user: add gcov support to preexit_cleanup
      docker: drop QEMU build-dep from bootstrap
      docker: debian-bootstrap.pre allow customising of variant/url
      docker: add special handling for FROM:debian-%-user targets
      docker: add special rule for deboostrapped images
      docker: add linux-user powered cross builder for QEMU

Philippe Mathieu-Daudé (6):
      travis: do not waste time cloning unused submodules
      travis: test out-of-tree builds
      docker: ubuntu: Update the package list before installing new ones
      docker: ubuntu: Use SDL2
      docker: Clean the MXE base image
      docker: Do not run tests in 'intermediate' images

 .gitignore                                         |  1 +
 .travis.yml                                        | 14 +++--
 MAINTAINERS                                        |  1 +
 Makefile                                           | 44 ++++++++++++----
 configure                                          |  2 +-
 docs/devel/testing.rst                             | 21 +++++---
 linux-user/Makefile.objs                           |  2 +-
 linux-user/exit.c                                  | 35 +++++++++++++
 linux-user/qemu.h                                  |  8 +++
 linux-user/syscall.c                               | 10 +---
 scripts/create_config                              |  2 +-
 scripts/travis/coverage-summary.sh                 | 27 ++++++++++
 tests/Makefile.include                             | 12 +----
 tests/docker/Makefile.include                      | 59 ++++++++++++++++++++--
 tests/docker/docker.py                             |  4 ++
 tests/docker/dockerfiles/debian-bootstrap.docker   |  2 -
 tests/docker/dockerfiles/debian-bootstrap.pre      | 11 +++-
 .../dockerfiles/debian-powerpc-user-cross.docker   | 15 ++++++
 tests/docker/dockerfiles/debian8-mxe.docker        |  2 +-
 tests/docker/dockerfiles/travis.docker             |  2 +-
 tests/docker/dockerfiles/ubuntu.docker             |  8 +--
 21 files changed, 228 insertions(+), 54 deletions(-)
 create mode 100644 linux-user/exit.c
 create mode 100755 scripts/travis/coverage-summary.sh
 create mode 100644 tests/docker/dockerfiles/debian-powerpc-user-cross.docker

--
2.17.1
