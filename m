Received: from eggs.gnu.org ([209.51.188.92]:50499)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gtBH9-00074O-Bs
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 08:05:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gtBGq-0003kj-QX
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 08:05:21 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a]:43778)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gtBGo-0003iM-Iz
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 08:05:11 -0500
Received: by mail-wr1-x42a.google.com with SMTP id r2so4577632wrv.10
	for <qemu-devel@nongnu.org>; Mon, 11 Feb 2019 05:05:10 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Mon, 11 Feb 2019 13:04:49 +0000
Message-Id: <20190211130507.8710-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 00/18] testing updates:
 travis/cirrus/vm-test/binfmt
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

The following changes since commit e47f81b617684c4546af286d307b69014a83538a:

  Merge remote-tracking branch 'remotes/thibault/tags/samuel-thibault' into staging (2019-02-07 18:53:25 +0000)

are available in the Git repository at:

  https://github.com/stsquad/qemu.git tags/pull-testing-next-110219-1

for you to fetch changes up to 920fff9093db26f3e74858e3d4182b74a6da7496:

  tests/vm: Be verbose while extracting compressed images (2019-02-11 12:47:08 +0000)

----------------------------------------------------------------
Testing updates:

  - .travis.yml tweaks and optimisations
  - .cirrus.yml enabled for FreeBSD CI
  - docker.py clean-ups for binfmt_misc
  - more control of vm-test builds

----------------------------------------------------------------
Alex Bennée (11):
      .travis.yml: separate tools and docs into another entry
      .travis.yml: fold --disable-tcg into alternate coroutine builds
      docker: add debian-buster-arm64-cross
      tests: make docker.py update use configured binfmt path
      tests: make docker.py check for persistent configs
      tests: docker.py be even smarter with persistent binfmt_misc
      tests: PEP8 cleanup of docker.py, mostly white space
      tests/vm: call make check directly for netbsd/freebsd/ubuntu.i386
      tests/vm: add --build-target option
      tests/vm: expose BUILD_TARGET, TARGET_LIST and EXTRA_CONFIGURE_OPTS
      scripts/qemu.py: allow arches use KVM for their 32bit cousins

Daniel P. Berrangé (1):
      .travis.yml: stop requesting libffi & gettext from homebrew

Ed Maste (1):
      .cirrus.yml: basic compile and test for FreeBSD

Gerd Hoffmann (1):
      tests/vm: move images to $HOME/.cache/qemu-vm/images

Murilo Opsfelder Araujo (1):
      docs/devel/testing: Add -a option to usermod command on docker setup

Philippe Mathieu-Daudé (3):
      MAINTAINERS: Add an entry for scripts/archive-source.sh
      archive-source.sh: Clone the submodules locally
      tests/vm: Be verbose while extracting compressed images

 .cirrus.yml                                        |  16 +++
 .travis.yml                                        |  31 +++---
 MAINTAINERS                                        |   9 ++
 docs/devel/testing.rst                             |   2 +-
 scripts/archive-source.sh                          |   7 ++
 scripts/qemu.py                                    |  12 ++-
 tests/docker/Makefile.include                      |   1 +
 tests/docker/docker.py                             | 110 +++++++++++++++------
 .../dockerfiles/debian-buster-arm64-cross.docker   |  15 +++
 tests/docker/dockerfiles/debian10.docker           |  31 ++++++
 tests/tcg/aarch64/Makefile.include                 |   2 +-
 tests/vm/Makefile.include                          |  22 +++--
 tests/vm/basevm.py                                 |   3 +
 tests/vm/centos                                    |   3 +-
 tests/vm/freebsd                                   |   6 +-
 tests/vm/netbsd                                    |   6 +-
 tests/vm/openbsd                                   |   3 +-
 tests/vm/ubuntu.i386                               |   3 +-
 18 files changed, 222 insertions(+), 60 deletions(-)
 create mode 100644 .cirrus.yml
 create mode 100644 tests/docker/dockerfiles/debian-buster-arm64-cross.docker
 create mode 100644 tests/docker/dockerfiles/debian10.docker

--
2.20.1
