Received: from eggs.gnu.org ([2001:4830:134:3::10]:41442)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dqG0L-0007de-6A
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 05:55:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dqG0G-0004C9-7Y
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 05:55:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55896)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dqG0F-0004B0-VA
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 05:55:12 -0400
From: Fam Zheng <famz@redhat.com>
Date: Fri,  8 Sep 2017 17:54:28 +0800
Message-Id: <20170908095506.13594-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 00/38] Test and build system patches
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

Hi Peter,

The following changes since commit cda4a338c4243fa3bff4498b935340ac7121cc=
76:

  tcg/tci: Add TCG_TARGET_DEFAULT_MO (2017-09-07 18:57:34 +0100)

are available in the git repository at:

  git://github.com/famz/qemu.git tags/staging-pull-request

for you to fetch changes up to d0fba2165aa69ee5cb6a368ad611f3d54950fe4e:

  buildsys: Move rdma libs to per object (2017-09-08 17:47:11 +0800)

----------------------------------------------------------------

This includes:

- Alex's improvements of docker tests
- VM test
- test-block for docker tests
- test-full improvements
- cflags / libs cleanup

----------------------------------------------------------------

Alex Benn=C3=A9e (4):
  docker: ensure NOUSER for travis images
  docker: docker.py make --no-cache skip checksum test
  docker: don't install device-tree-compiler build-deps in travis.docker
  docker: reduce noise when building travis.docker

Fam Zheng (34):
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
  buildsys: Move opengl cflags to per object
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
 configure                              |  63 ++++----
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
 tests/docker/test-block                |  22 +++
 tests/docker/test-full                 |  82 +++++++++-
 tests/vm/Makefile.include              |  42 +++++
 tests/vm/README                        |  63 ++++++++
 tests/vm/basevm.py                     | 276 +++++++++++++++++++++++++++=
++++++
 tests/vm/freebsd                       |  42 +++++
 tests/vm/netbsd                        |  42 +++++
 tests/vm/openbsd                       |  43 +++++
 tests/vm/ubuntu.i386                   |  88 +++++++++++
 ui/Makefile.objs                       |  37 +++--
 vl.c                                   |   4 -
 30 files changed, 856 insertions(+), 90 deletions(-)
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
