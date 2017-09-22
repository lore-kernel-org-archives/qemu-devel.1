Received: from eggs.gnu.org ([2001:4830:134:3::10]:37500)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dvIg0-0007oI-Du
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 03:47:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dvIfx-0000oO-9x
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 03:47:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57666)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dvIfx-0000o1-1N
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 03:47:05 -0400
From: Fam Zheng <famz@redhat.com>
Date: Fri, 22 Sep 2017 15:46:23 +0800
Message-Id: <20170922074659.30097-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v5 00/36] Build and test automation patches
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

The following changes since commit 0a8066f0c068f1e318a1aacd7864fc00e455a3=
7b:

  Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-201=
70921' into staging (2017-09-21 17:42:27 +0100)

are available in the git repository at:

  git://github.com/famz/qemu.git tags/build-and-test-automation-pull-requ=
est

for you to fetch changes up to 4f6afe41f2ee3d8170eef7a9122d256588b707b2:

  docker: Drop 'set -e' from run script (2017-09-22 14:51:43 +0800)

----------------------------------------------------------------

Since v4:

- Drop three iffy -cflags patches from me (for gtk/vnc/curses).
- Revised VM test scripts after addressing comments.
- Add Eduardo's small tweak on MAINTAINERS.

----------------------------------------------------------------

Alex Benn=C3=A9e (4):
  docker: ensure NOUSER for travis images
  docker: docker.py make --no-cache skip checksum test
  docker: don't install device-tree-compiler build-deps in travis.docker
  docker: reduce noise when building travis.docker

Eduardo Habkost (1):
  MAINTAINERS: Fix subsystem name for "Build and test automation"

Fam Zheng (31):
  docker: Update ubuntu image
  docker: Enable features explicitly in test-full
  tests/docker: Clean up paths
  docker: Fix return code of build_qemu()
  docker: Add test_fail and prep_fail
  docker: Use unconfined security profile
  docker: Add nettle-devel to fedora image
  docker: Add test-block
  vl: Don't include vde header
  buildsys: Move vde libs to per object
  buildsys: Move sdl cflags/libs to per object
  buildsys: Move audio libs to per object
  buildsys: Move libcacard cflags/libs to per object
  buildsys: Move libusb cflags/libs to per object
  buildsys: Move usb redir cflags/libs to per object
  buildsys: Move brlapi libs to per object
  buildsys: Move rdma libs to per object
  gitignore: Ignore vm test images
  qemu.py: Add "wait()" method
  scripts: Add archive-source.sh
  tests: Add a test key pair
  tests: Add vm test lib
  tests: Add ubuntu.i386 image
  tests: Add FreeBSD image
  tests: Add NetBSD image
  tests: Add OpenBSD image
  Makefile: Add rules to run vm tests
  MAINTAINERS: Add tests/vm entry
  tests: Add README for vm tests
  docker: Use archive-source.py
  docker: Drop 'set -e' from run script

 .gitignore                             |   1 +
 MAINTAINERS                            |   2 +
 Makefile                               |   2 +
 audio/Makefile.objs                    |   6 +
 chardev/Makefile.objs                  |   1 +
 configure                              |  38 ++---
 hw/usb/Makefile.objs                   |  13 +-
 migration/Makefile.objs                |   1 +
 net/Makefile.objs                      |   2 +
 scripts/archive-source.sh              |  51 +++++++
 scripts/qemu.py                        |   7 +
 tests/.gitignore                       |   1 +
 tests/docker/Makefile.include          |  16 +-
 tests/docker/common.rc                 |  20 ++-
 tests/docker/docker.py                 |   3 +-
 tests/docker/dockerfiles/fedora.docker |   1 +
 tests/docker/dockerfiles/travis.docker |   6 +-
 tests/docker/dockerfiles/ubuntu.docker |  11 +-
 tests/docker/run                       |  18 +--
 tests/docker/test-block                |  21 +++
 tests/docker/test-full                 |  82 ++++++++++-
 tests/keys/README                      |   6 +
 tests/keys/id_rsa                      |  27 ++++
 tests/keys/id_rsa.pub                  |   1 +
 tests/vm/Makefile.include              |  42 ++++++
 tests/vm/README                        |  89 +++++++++++
 tests/vm/basevm.py                     | 262 +++++++++++++++++++++++++++=
++++++
 tests/vm/freebsd                       |  42 ++++++
 tests/vm/netbsd                        |  42 ++++++
 tests/vm/openbsd                       |  43 ++++++
 tests/vm/ubuntu.i386                   |  89 +++++++++++
 ui/Makefile.objs                       |   1 +
 vl.c                                   |   4 -
 33 files changed, 886 insertions(+), 65 deletions(-)
 create mode 100755 scripts/archive-source.sh
 create mode 100755 tests/docker/test-block
 create mode 100644 tests/keys/README
 create mode 100644 tests/keys/id_rsa
 create mode 100644 tests/keys/id_rsa.pub
 create mode 100644 tests/vm/Makefile.include
 create mode 100644 tests/vm/README
 create mode 100755 tests/vm/basevm.py
 create mode 100755 tests/vm/freebsd
 create mode 100755 tests/vm/netbsd
 create mode 100755 tests/vm/openbsd
 create mode 100755 tests/vm/ubuntu.i386

--=20
2.13.5
