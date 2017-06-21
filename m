Received: from eggs.gnu.org ([2001:4830:134:3::10]:37751)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dNguu-0006ic-Pp
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 10:47:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dNguq-0004zc-DP
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 10:47:36 -0400
Received: from mail-wr0-x22d.google.com ([2a00:1450:400c:c0c::22d]:33925)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dNguq-0004ys-7C
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 10:47:32 -0400
Received: by mail-wr0-x22d.google.com with SMTP id 77so138144846wrb.1
	for <qemu-devel@nongnu.org>; Wed, 21 Jun 2017 07:47:32 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Wed, 21 Jun 2017 15:47:53 +0100
Message-Id: <20170621144814.15324-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 00/21] Docker and shippable updates
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

The following changes since commit 8dfaf23ae1f2273a9730a9b309cc8471269bb524:

  tcg/tci: fix tcg-interpreter build (2017-06-20 18:39:15 +0100)

are available in the git repository at:

  https://github.com/stsquad/qemu.git tags/pull-ci-updates-210617-2

for you to fetch changes up to 32b9ca986855a5d56daf47fdb516743008788b71:

  MAINTAINERS: self-appoint me as reviewer in build/test automation (2017-06-21 15:03:06 +0100)

----------------------------------------------------------------
This is mostly Philippe's updates

We add the following cross-compile targets:
  - mipsel-softmmu,mipsel-linux-user,mips64el-linux-user
  - armeb-linux-user

While I was rolling I discovered we could also back out a bunch of the
emdebian hacks as the newly released stretch handles cross compilers
as first class citizens. Unfortunately this also meant I had to drop
the powerpc support as that is no longer in Debian stable.

----------------------------------------------------------------
Alex Bennée (1):
      docker: update qemu:debian base following stretch release

Philippe Mathieu-Daudé (20):
      docker: let _copy_with_mkdir() sub_path argument be optional
      docker: add --include-files argument to 'build' command
      docker: rebuild image if 'extra files' checksum does not match
      docker: install ca-certificates package in base image
      docker: use better regex to generate deb-src entries
      docker: use eatmydata, install common build packages in base image
      docker: use eatmydata in debian armhf image
      docker: use eatmydata in debian arm64 image
      docker: add extra libs to armhf target to extend codebase coverage
      docker: add extra libs to arm64 target to extend codebase coverage
      docker: add extra libs to s390x target to extend codebase coverage
      docker: add mipsel build target
      shippable: use C locale to simplify console output
      shippable: build using all available cpus
      shippable: do not initialize submodules automatically
      shippable: be verbose while building docker images
      shippable: add armeb-linux-user target
      shippable: add mipsel target
      MAINTAINERS: add Shippable automation platform URL
      MAINTAINERS: self-appoint me as reviewer in build/test automation

 .shippable.yml                                     | 21 ++++++++++++---
 MAINTAINERS                                        |  2 ++
 tests/docker/Makefile.include                      |  4 +++
 tests/docker/docker.py                             | 30 +++++++++++++++++-----
 tests/docker/dockerfiles/debian-arm64-cross.docker | 18 +++++++++++--
 tests/docker/dockerfiles/debian-armhf-cross.docker | 18 +++++++++++--
 .../docker/dockerfiles/debian-mipsel-cross.docker  | 29 +++++++++++++++++++++
 tests/docker/dockerfiles/debian-s390x-cross.docker | 10 ++++++++
 tests/docker/dockerfiles/debian.docker             | 15 ++++-------
 9 files changed, 123 insertions(+), 24 deletions(-)
 create mode 100644 tests/docker/dockerfiles/debian-mipsel-cross.docker
