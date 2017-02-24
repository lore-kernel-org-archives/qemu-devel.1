Received: from eggs.gnu.org ([2001:4830:134:3::10]:44259)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1ch9QL-0008E8-NY
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 01:32:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1ch9QI-0000EO-JE
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 01:32:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35668)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1ch9QI-0000EJ-Dk
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 01:32:10 -0500
From: Fam Zheng <famz@redhat.com>
Date: Fri, 24 Feb 2017 14:32:00 +0800
Message-Id: <20170224063205.2537-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/5] Docker testing and shippable patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Fam Zheng <famz@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

The following changes since commit 10f25e4844cb9b3f02fb032f88051dd5b65b42=
06:

  Merge remote-tracking branch 'remotes/yongbok/tags/mips-20170222' into =
staging (2017-02-23 09:59:40 +0000)

are available in the git repository at:

  git://github.com/famz/qemu.git tags/for-upstream

for you to fetch changes up to a8f159d45bcb78c00ea160bfc2b94512e4ed9910:

  docker: Install python2 explicitly in docker image (2017-02-24 14:18:11=
 +0800)

----------------------------------------------------------------

Hi Peter,

These are testing and build automation patches:

- Shippable.com powered CI config
- Docker cross build
- Fixes and MAINTAINERS tweaks.

----------------------------------------------------------------

Alex Benn=C3=A9e (4):
  tests/docker: add basic user mapping support
  new: debian docker targets for cross-compiling
  .shippable.yml: new CI provider
  MAINTAINERS: merge Build and test automation with Docker tests

Fam Zheng (1):
  docker: Install python2 explicitly in docker image

 .shippable.yml                                     | 19 ++++++++++++++++
 MAINTAINERS                                        | 13 ++++++-----
 tests/docker/Makefile.include                      |  6 ++++++
 tests/docker/common.rc                             |  2 +-
 tests/docker/docker.py                             | 16 ++++++++++++--
 tests/docker/dockerfiles/debian-arm64-cross.docker | 15 +++++++++++++
 tests/docker/dockerfiles/debian-armhf-cross.docker | 15 +++++++++++++
 tests/docker/dockerfiles/debian.docker             | 25 ++++++++++++++++=
++++++
 tests/docker/dockerfiles/fedora.docker             |  2 +-
 9 files changed, 102 insertions(+), 11 deletions(-)
 create mode 100644 .shippable.yml
 create mode 100644 tests/docker/dockerfiles/debian-arm64-cross.docker
 create mode 100644 tests/docker/dockerfiles/debian-armhf-cross.docker
 create mode 100644 tests/docker/dockerfiles/debian.docker

--=20
2.9.3
