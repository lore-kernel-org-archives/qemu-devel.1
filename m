Received: from eggs.gnu.org ([2001:4830:134:3::10]:54829)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fb6jK-0008NC-FB
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 12:03:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fb6jE-0007vT-4V
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 12:03:38 -0400
Received: from mail-wm0-x22b.google.com ([2a00:1450:400c:c09::22b]:55699)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fb6jD-0007v7-Tf
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 12:03:32 -0400
Received: by mail-wm0-x22b.google.com with SMTP id v16-v6so12128563wmv.5
	for <qemu-devel@nongnu.org>; Thu, 05 Jul 2018 09:03:31 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu,  5 Jul 2018 17:03:09 +0100
Message-Id: <20180705160329.30386-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL v3 00/20] Travis,
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
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

The following changes since commit 6cf495be0b445789eeb7e88a6015c8cf74d4c1cf:

  Merge remote-tracking branch 'remotes/jnsnow/tags/bitmaps-pull-request' into staging (2018-07-05 13:33:52 +0100)

are available in the Git repository at:

  https://github.com/stsquad/qemu.git tags/pull-code-coverage-and-build-tweaks-050718-3

for you to fetch changes up to 19c9a18f45fc8d8b8e96a6b8ea6074d08b6a8612:

  docker: add linux-user powered cross builder for QEMU (2018-07-05 16:57:39 +0100)

----------------------------------------------------------------
Code coverage and other build tweaks

  - revert 208ecb3e (and drop filter for mingw, tweak for check-tcg)
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
 .travis.yml                                        | 14 ++++--
 MAINTAINERS                                        |  1 +
 Makefile                                           | 44 +++++++++++++-----
 configure                                          |  2 +-
 docs/devel/testing.rst                             | 21 ++++++---
 linux-user/Makefile.objs                           |  2 +-
 linux-user/exit.c                                  | 35 +++++++++++++++
 linux-user/qemu.h                                  |  8 ++++
 linux-user/syscall.c                               | 10 +----
 scripts/create_config                              |  2 +-
 scripts/travis/coverage-summary.sh                 | 27 +++++++++++
 tests/Makefile.include                             | 16 ++-----
 tests/docker/Makefile.include                      | 52 ++++++++++++++++++++--
 tests/docker/docker.py                             |  4 ++
 tests/docker/dockerfiles/debian-bootstrap.docker   |  2 -
 tests/docker/dockerfiles/debian-bootstrap.pre      | 11 ++++-
 .../dockerfiles/debian-powerpc-user-cross.docker   | 15 +++++++
 tests/docker/dockerfiles/debian8-mxe.docker        |  2 +-
 tests/docker/dockerfiles/travis.docker             |  2 +-
 tests/docker/dockerfiles/ubuntu.docker             |  8 ++--
 21 files changed, 223 insertions(+), 56 deletions(-)
 create mode 100644 linux-user/exit.c
 create mode 100755 scripts/travis/coverage-summary.sh
 create mode 100644 tests/docker/dockerfiles/debian-powerpc-user-cross.docker

-- 
2.17.1
