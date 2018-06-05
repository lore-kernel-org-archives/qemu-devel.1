Received: from eggs.gnu.org ([2001:4830:134:3::10]:53080)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fQEVB-0000v0-67
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 12:08:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fQESu-0004JP-CC
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 12:08:05 -0400
Received: from mail-wm0-x22a.google.com ([2a00:1450:400c:c09::22a]:39834)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fQESt-0004Ij-QV
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 12:05:44 -0400
Received: by mail-wm0-x22a.google.com with SMTP id p11-v6so6149755wmc.4
	for <qemu-devel@nongnu.org>; Tue, 05 Jun 2018 09:05:43 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue,  5 Jun 2018 17:05:35 +0100
Message-Id: <20180605160541.10664-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 0/6] Some docker updates
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

The following changes since commit 1d889f2a8baaa265939b339d2f52ec57f5b8a09c:

  Merge remote-tracking branch 'remotes/cody/tags/block-pull-request' into staging (2018-06-05 15:22:07 +0100)

are available in the Git repository at:

  https://github.com/stsquad/qemu.git tags/pull-docker-updates-050618-1

for you to fetch changes up to 36dc5fedab0339afdeb3c40ff820c7e5ce334751:

  docker: add debian/tricore image (2018-06-05 16:25:43 +0100)

----------------------------------------------------------------
Docker related updates

  - configure/probe for docker
  - TARGET_DIRS -> TARGET_LIST cleanup
  - new fedora-i386-cross and debian/tricore images
  - test-mingw use SDL2/GTK3

----------------------------------------------------------------
Alex Bennée (2):
      docker: add "probe" command for configure
      configure: add test for docker availability

Fam Zheng (2):
      Makefile: Rename TARGET_DIRS to TARGET_LIST
      docker: Add fedora-i386-cross image

Paolo Bonzini (1):
      docker: test-mingw: use SDL2 and GTK+3

Philippe Mathieu-Daudé (1):
      docker: add debian/tricore image

 Makefile                                           | 20 +++++++++----------
 configure                                          | 19 +++++++++++++++++-
 scripts/create_config                              |  2 +-
 tests/Makefile.include                             |  2 +-
 tests/docker/Makefile.include                      |  3 +++
 tests/docker/docker.py                             | 18 +++++++++++++++++
 .../docker/dockerfiles/debian-tricore-cross.docker | 23 ++++++++++++++++++++++
 tests/docker/dockerfiles/fedora-i386-cross.docker  | 14 +++++++++++++
 tests/docker/dockerfiles/fedora.docker             |  8 ++++----
 tests/docker/test-mingw                            |  4 ++--
 10 files changed, 94 insertions(+), 19 deletions(-)
 create mode 100644 tests/docker/dockerfiles/debian-tricore-cross.docker
 create mode 100644 tests/docker/dockerfiles/fedora-i386-cross.docker


-- 
2.17.0
