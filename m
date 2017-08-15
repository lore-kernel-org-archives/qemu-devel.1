Received: from eggs.gnu.org ([2001:4830:134:3::10]:36973)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dhZXM-0007qk-Fe
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 06:57:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dhZXJ-0002Jl-Dx
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 06:57:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36760)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dhZXJ-0002JH-7T
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 06:57:25 -0400
From: Fam Zheng <famz@redhat.com>
Date: Tue, 15 Aug 2017 18:57:16 +0800
Message-Id: <20170815105721.31893-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/5] Build and test patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

The following changes since commit 83c3a1f61673ef554facf4d6d29ed56c5a219f=
9d:

  xlnx-qspi: add a property for mmio-execution (2017-08-14 14:17:18 +0100=
)

are available in the git repository at:

  git://github.com/famz/qemu.git tags/build-and-test-pull-request

for you to fetch changes up to a8132a2f288c260fb43243eb3c092b5186d84968:

  docker: add centos7 image (2017-08-15 15:16:45 +0800)

----------------------------------------------------------------

One fix and a few docker test enhancements. Not 2.10 blocker, but it's
good to have them.

----------------------------------------------------------------

Fam Zheng (1):
  Makefile: Let "make check-help" work without running ./configure

Philippe Mathieu-Daud=C3=A9 (4):
  docker: use one package per line in CentOS config
  docker: add Xen libs to centos6 image
  docker: install more packages on CentOS to extend code coverage
  docker: add centos7 image

 Makefile                                |  2 --
 tests/Makefile.include                  | 46 ++++++++++++++++++---------=
------
 tests/docker/dockerfiles/centos6.docker | 31 ++++++++++++++++++----
 tests/docker/dockerfiles/centos7.docker | 31 ++++++++++++++++++++++
 4 files changed, 82 insertions(+), 28 deletions(-)
 create mode 100644 tests/docker/dockerfiles/centos7.docker

--=20
2.13.4
