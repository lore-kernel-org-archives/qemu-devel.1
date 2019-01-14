Received: from eggs.gnu.org ([209.51.188.92]:35520)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gj3kJ-0006NI-9H
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 10:01:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gj3k9-0005JO-GH
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 10:01:47 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e]:45410)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gj3k9-0005FR-6N
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 10:01:37 -0500
Received: by mail-wr1-x42e.google.com with SMTP id t6so23161036wrr.12
	for <qemu-devel@nongnu.org>; Mon, 14 Jan 2019 07:01:32 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Mon, 14 Jan 2019 15:01:08 +0000
Message-Id: <20190114150129.1013-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 00/21] misc testing fixes for Travis and docker
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

The following changes since commit 7260438b7056469610ee166f7abe9ff8a26b8b16:

  Merge remote-tracking branch 'remotes/palmer/tags/riscv-for-master-3.2-part2' into staging (2019-01-14 11:41:43 +0000)

are available in the Git repository at:

  https://github.com/stsquad/qemu.git tags/pull-testing-next-140119-1

for you to fetch changes up to a36270a4d1589b1ed309065fc8b3fe0ac8d6869d:

  Revert "tests: Disable qht-bench parallel test when using gprof" (2019-01-14 14:55:32 +0000)

----------------------------------------------------------------
A bunch of fixes for testing:

  - Various Travis updates
  - "stable" SID snapshot for docker
  - avoid :latest docker tags
  - g_usleep fix for some tests

----------------------------------------------------------------
Alex Bennée (7):
      tests: use in-place sed magic for enabling deb-src in travis image
      travis: use homebrew addon for MacOSX
      travis: bump to Xenial baseline
      tests/docker: update our Travis image
      tests/docker: remove SID_AGE test hack
      tests: use g_usleep instead of rem = sleep(time)
      Revert "tests: Disable qht-bench parallel test when using gprof"

Daniel P. Berrangé (12):
      tests: run ldconfig after installing extra software
      tests: remove obsolete 'debian' dockerfile
      tests: update Fedora dockerfile to use Fedora 29
      tests: update Fedora i386 cross image to Fedora 29
      travis: add whitespace between each major section & matrix entry
      travis: define all the build matrix entries in one place
      travis: standardize the syntax used for env variables
      travis: don't clone git submodules upfront
      travis: stop redefining the script commands
      travis: stop using container based envs
      travis: run tests in verbose mode
      travis: remove matrix settings that duplicate global settings

Philippe Mathieu-Daudé (2):
      docker: Use stable git tag for virglrenderer
      docker: Use a stable snapshot for Debian Sid

 .travis.yml                                       | 172 +++++++++++++++-------
 configure                                         |   1 -
 tests/Makefile.include                            |   3 +-
 tests/atomic64-bench.c                            |   6 +-
 tests/atomic_add-bench.c                          |   6 +-
 tests/docker/Makefile.include                     |  13 --
 tests/docker/dockerfiles/debian-amd64.docker      |   5 +-
 tests/docker/dockerfiles/debian-sid.docker        |   7 +-
 tests/docker/dockerfiles/debian.docker            |  13 --
 tests/docker/dockerfiles/fedora-i386-cross.docker |   2 +-
 tests/docker/dockerfiles/fedora.docker            |   4 +-
 tests/docker/dockerfiles/travis.docker            |   4 +-
 tests/qht-bench.c                                 |   6 +-
 13 files changed, 138 insertions(+), 104 deletions(-)
 delete mode 100644 tests/docker/dockerfiles/debian.docker

--
2.17.1
