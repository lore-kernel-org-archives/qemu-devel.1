Received: from eggs.gnu.org ([2001:4830:134:3::10]:33466)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dqYaz-0005kW-Cl
	for qemu-devel@nongnu.org; Sat, 09 Sep 2017 01:46:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dqYaw-00069c-BW
	for qemu-devel@nongnu.org; Sat, 09 Sep 2017 01:46:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33168)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dqYaw-00069H-2o
	for qemu-devel@nongnu.org; Sat, 09 Sep 2017 01:46:18 -0400
From: Fam Zheng <famz@redhat.com>
Date: Sat,  9 Sep 2017 13:45:36 +0800
Message-Id: <20170909054613.19148-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v2 00/37] Staging patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>

The following changes since commit fcea73709b966a7ded9efa7b106ea50c7fe902=
5c:

  Merge remote-tracking branch 'remotes/mst/tags/for_upstream' into stagi=
ng (2017-09-08 16:04:42 +0100)

are available in the git repository at:

  git://github.com/famz/qemu.git tags/staging-pull-request

for you to fetch changes up to 734e2410b1c14a4cf17b1500bda1dcc7e7e57cfc:

  buildsys: Move rdma libs to per object (2017-09-09 11:55:51 +0800)

----------------------------------------------------------------

v2: Drop opengl flags patch.
    Change the new scripts' licenses to GPLv2+.

----------------------------------------------------------------

Alex Benn=C3=A9e (4):
  docker: ensure NOUSER for travis images
  docker: docker.py make --no-cache skip checksum test
  docker: don't install device-tree-compiler build-deps in travis.docker
  docker: reduce noise when building travis.docker

Fam Zheng (33):
  docker: Update ubuntu image
  docker: Enable features explicitly in test-full
  tests/docker: Clean up paths
  gitignore: Ignore vm test images
  qemu.py: Add "wait()" method
  scripts: Add archive-source.sh
  tests: Add vm test lib
  tests: Add ubuntu.i386 image
  tests: Add FreeBSD image
  tests: Add NetBSD image
  tests: Add OpenBSD image
  Makefile: Add rules to run vm tests
  MAINTAINERS: Add tests/vm entry
  tests: Add README for vm tests
  docker: Use archive-source.py
  docker: Fix return code of build_qemu()
  docker: Add test_fail and prep_fail
  docker: Use unconfined security profile
  docker: Add nettle-devel to fedora image
  docker: Add test-block
  docker: Drop 'set -e' from run script
  vl: Don't include vde header
  buildsys: Move vde libs to per object
  buildsys: Move gtk/vte cflags/libs to per object
  buildsys: Move sdl cflags/libs to per object
  buildsys: Move vnc cflags/libs to per object
  buildsys: Move audio libs to per object
  buildsys: Move curese cflags/libs to per object
  buildsys: Move libcacard cflags/libs to per object
  buildsys: Move libusb cflags/libs to per object
  buildsys: Move usb redir cflags/libs to per object
  buildsys: Move brlapi libs to per object
  buildsys: Move rdma libs to per object

 .gitignore                             |   1 +
 MAINTAINERS                            |   1 +
 Makefile                               |   2 +
 audio/Makefile.objs                    |   6 +
 chardev/Makefile.objs                  |   1 +
 configure                              |  61 ++++----
 hw/usb/Makefile.objs                   |  13 +-
 migration/Makefile.objs                |   1 +
 net/Makefile.objs                      |   2 +
 scripts/archive-source.sh              |  31 ++++
 scripts/qemu.py                        |   7 +
 tests/.gitignore                       |   1 +
 tests/docker/Makefile.include          |  17 +-
 tests/docker/common.rc                 |  20 ++-
 tests/docker/docker.py                 |   3 +-
 tests/docker/dockerfiles/fedora.docker |   1 +
 tests/docker/dockerfiles/travis.docker |   6 +-
 tests/docker/dockerfiles/ubuntu.docker |  11 +-
 tests/docker/run                       |  18 +--
 tests/docker/test-block                |  21 +++
 tests/docker/test-full                 |  82 +++++++++-
 tests/vm/Makefile.include              |  42 +++++
 tests/vm/README                        |  63 ++++++++
 tests/vm/basevm.py                     | 276 +++++++++++++++++++++++++++=
++++++
 tests/vm/freebsd                       |  42 +++++
 tests/vm/netbsd                        |  42 +++++
 tests/vm/openbsd                       |  43 +++++
 tests/vm/ubuntu.i386                   |  88 +++++++++++
 ui/Makefile.objs                       |  29 ++--
 vl.c                                   |   4 -
 30 files changed, 850 insertions(+), 85 deletions(-)
 create mode 100755 scripts/archive-source.sh
 create mode 100755 tests/docker/test-block
 create mode 100644 tests/vm/Makefile.include
 create mode 100644 tests/vm/README
 create mode 100755 tests/vm/basevm.py
 create mode 100755 tests/vm/freebsd
 create mode 100755 tests/vm/netbsd
 create mode 100755 tests/vm/openbsd
 create mode 100755 tests/vm/ubuntu.i386

--=20
2.13.5
