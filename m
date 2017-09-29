Received: from eggs.gnu.org ([2001:4830:134:3::10]:33603)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dxlp1-0007d5-IU
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 23:18:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dxlox-0002VL-J4
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 23:18:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60720)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dxlox-0002Uj-CQ
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 23:18:35 -0400
From: Fam Zheng <famz@redhat.com>
Date: Fri, 29 Sep 2017 11:18:26 +0800
Message-Id: <20170929031831.10179-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/5] Docker testing patches
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
List-ID: <qemu-devel.nongnu.org>

The following changes since commit ab161529261928ae7f3556e3220829c34b2686=
ec:

  Merge remote-tracking branch 'remotes/dgilbert/tags/pull-migration-2017=
0927a' into staging (2017-09-27 22:44:51 +0100)

are available in the git repository at:

  git://github.com/famz/qemu.git tags/docker-testing-pull-request

for you to fetch changes up to 36ac78e65a0695f0e397865cceaf4ab5c4e52c64:

  docker: Don't mount ccache db if NOUSER=3D1 (2017-09-29 11:14:15 +0800)

----------------------------------------------------------------

----------------------------------------------------------------

Alex Benn=C3=A9e (1):
  tests/docker/run: don't source /etc/profile

Fam Zheng (3):
  docker: Fix test-mingw
  docker: test-block: Don't continue if build fails
  docker: Don't mount ccache db if NOUSER=3D1

Paolo Bonzini (1):
  docker: add installation to build tests

 tests/docker/Makefile.include                | 6 ++++--
 tests/docker/common.rc                       | 8 ++++++++
 tests/docker/dockerfiles/centos6.docker      | 1 +
 tests/docker/dockerfiles/centos7.docker      | 1 +
 tests/docker/dockerfiles/debian-ports.docker | 1 +
 tests/docker/dockerfiles/debian8.docker      | 1 +
 tests/docker/dockerfiles/debian9.docker      | 1 +
 tests/docker/dockerfiles/fedora.docker       | 2 +-
 tests/docker/dockerfiles/min-glib.docker     | 2 +-
 tests/docker/dockerfiles/ubuntu.docker       | 2 +-
 tests/docker/run                             | 4 +++-
 tests/docker/test-block                      | 2 +-
 tests/docker/test-build                      | 1 +
 tests/docker/test-clang                      | 1 +
 tests/docker/test-full                       | 2 +-
 tests/docker/test-mingw                      | 1 +
 tests/docker/test-quick                      | 1 +
 17 files changed, 29 insertions(+), 8 deletions(-)

--=20
2.13.5
