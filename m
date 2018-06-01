Received: from eggs.gnu.org ([2001:4830:134:3::10]:37007)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fOmnb-0005qV-OI
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 12:21:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fOmnY-0003mN-KC
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 12:21:07 -0400
Received: from mail-wr0-x233.google.com ([2a00:1450:400c:c0c::233]:34198)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fOmnY-0003le-BM
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 12:21:04 -0400
Received: by mail-wr0-x233.google.com with SMTP id a12-v6so1918962wro.1
	for <qemu-devel@nongnu.org>; Fri, 01 Jun 2018 09:21:04 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri,  1 Jun 2018 17:20:54 +0100
Message-Id: <20180601162101.895-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 0/7] Travis updates
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, berrange@redhat.com, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

The following changes since commit c25e8bba1f546ea72744ccfab77f8a9e8a323be8:

  Merge remote-tracking branch 'remotes/otubo/tags/pull-seccomp-20180601' into staging (2018-06-01 13:11:30 +0100)

are available in the Git repository at:

  https://github.com/stsquad/qemu.git tags/pull-travis-updates-010618-1

for you to fetch changes up to ac07ffc65472ec3b1255f427051481fc9050a2f8:

  .travis.yml: update GCC sanitizer build to GCC 7 (2018-06-01 15:00:54 +0100)

----------------------------------------------------------------
Some Travis & Docker updates

 - simplification of the build matrix
 - usability tweaks for docker
 - update Travis docker image

----------------------------------------------------------------
Alex Bennée (5):
      .travis.yml: disable linux-user build for gcov
      docker: update Travis docker image
      .travis.yml: rationalise clang testing
      .travis.yml: make current setup explicit
      .travis.yml: update GCC sanitizer build to GCC 7

Philippe Mathieu-Daudé (2):
      docker: sort images list displayed by 'make docker'
      docker: do not display deprecated images in 'make docker' help

 .travis.yml                            | 84 +++++++---------------------------
 tests/docker/Makefile.include          |  5 +-
 tests/docker/dockerfiles/travis.docker |  9 +++-
 3 files changed, 27 insertions(+), 71 deletions(-)

--
2.17.0
