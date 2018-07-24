Received: from eggs.gnu.org ([2001:4830:134:3::10]:59983)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fhuuT-0000rk-3K
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 06:51:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fhuuP-0006P3-3m
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 06:51:17 -0400
Received: from mail-wm0-x235.google.com ([2a00:1450:400c:c09::235]:50393)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fhuuO-0006OU-RY
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 06:51:13 -0400
Received: by mail-wm0-x235.google.com with SMTP id v25-v6so2076066wmc.0
	for <qemu-devel@nongnu.org>; Tue, 24 Jul 2018 03:51:12 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue, 24 Jul 2018 11:50:52 +0100
Message-Id: <20180724105109.8392-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL for 3.0 00/17] docker fixes and tcg test tweak
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

The following changes since commit 768cef2974fb1fa30dd188b043ea737e13fea477:

  Merge remote-tracking branch 'remotes/ehabkost/tags/x86-next-pull-request' into staging (2018-07-24 10:37:52 +0100)

are available in the Git repository at:

  https://github.com/stsquad/qemu.git tags/pull-docker-fixes-for-3.0-240718-1

for you to fetch changes up to 1a3bdc6111482fbb41eacacf850002e4589a81ef:

  tests/tcg: remove runcom test (2018-07-24 11:45:25 +0100)

----------------------------------------------------------------
docker fixes & tcg test tweak

  - graceful handling of testing under cross-compile
  - fixes for debootstrap handling
  - more helpful errors (binfmt_misc/EXECUTABLE missing)
  - drop runcom TCG test

----------------------------------------------------------------
Alex Bennée (16):
      tests/.gitignore: don't ignore docker tests
      docker: base debian-tricore on qemu:debian9
      docker: par down QEMU_CONFIGURE_OPTS in debian-tricore-cross
      docker: fail more gracefully on docker.py check
      docker: split configure_qemu from build_qemu
      docker: move make check into check_qemu helper
      docker: gracefully skip check_qemu
      docker: Makefile.include don't include partial images
      docker: add test-unit runner
      docker: add expansion for docker-test-FOO to Makefile.include
      docker: drop QEMU_TARGET check, fallback in EXECUTABLE not set
      docker: report hint when docker.py check fails
      docker: add commentary to debian-bootstrap.docker
      docker: ignore distro versioning of debootstrap
      docker: perform basic binfmt_misc validation in docker.py
      tests/tcg: remove runcom test

Philippe Mathieu-Daudé (1):
      docker: Update debootstrap script after Debian migration from Alioth to Salsa

 tests/.gitignore                                   |   1 +
 tests/docker/Makefile.include                      |  23 ++-
 tests/docker/common.rc                             |  24 ++-
 tests/docker/docker.py                             |  37 +++-
 tests/docker/dockerfiles/debian-bootstrap.docker   |   1 +
 tests/docker/dockerfiles/debian-bootstrap.pre      |  13 +-
 .../docker/dockerfiles/debian-tricore-cross.docker |   6 +-
 tests/docker/test-clang                            |   2 +-
 tests/docker/test-debug                            |   2 +-
 tests/docker/test-full                             |   2 +-
 tests/docker/test-quick                            |   2 +-
 tests/docker/test-unit                             |  21 +++
 tests/tcg/i386/Makefile.target                     |   5 -
 tests/tcg/i386/README                              |   3 -
 tests/tcg/i386/pi_10.com                           | Bin 54 -> 0 bytes
 tests/tcg/i386/runcom.c                            | 192 ---------------------
 16 files changed, 111 insertions(+), 223 deletions(-)
 create mode 100755 tests/docker/test-unit
 delete mode 100644 tests/tcg/i386/pi_10.com
 delete mode 100644 tests/tcg/i386/runcom.c

-- 
2.17.1
