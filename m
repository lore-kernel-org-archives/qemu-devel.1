Received: from eggs.gnu.org ([2001:4830:134:3::10]:41567)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1ejbor-00060w-7u
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 21:20:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1ejbon-0004Ib-22
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 21:20:13 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49628 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1ejbom-0004Hc-T8
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 21:20:08 -0500
From: Fam Zheng <famz@redhat.com>
Date: Thu,  8 Feb 2018 10:19:37 +0800
Message-Id: <20180208021953.7354-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 00/16] Docker and block patches
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

The following changes since commit 7b213bb4755dc99e447c19c532768ef5105b97=
71:

  Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into s=
taging (2018-02-07 20:40:36 +0000)

are available in the Git repository at:

  git://github.com/famz/qemu.git tags/staging-pull-request

for you to fetch changes up to 4eb995603479f0f7aff14b518f8ada16fe694ca7:

  docs: Add docs/devel/testing.rst (2018-02-08 09:23:07 +0800)

----------------------------------------------------------------

 - The docker, coroutine and block patches from the earlier version
 - The testing documentation

----------------------------------------------------------------

Fam Zheng (10):
  stubs: Add stubs for ram block API
  util: Introduce vfio helpers
  block: Add VFIO based NVMe driver
  block: Introduce buf register API
  block/nvme: Implement .bdrv_(un)register_buf
  qemu-img: Map bench buffer
  block: Move NVMe constants to a separate header
  docs: Add section for NVMe VFIO driver
  qapi: Add NVMe driver options to the schema
  docs: Add docs/devel/testing.rst

Paolo Bonzini (6):
  docker: change Fedora base image to fedora:27
  test-coroutine: add simple CoMutex test
  lockable: add QemuLockable
  coroutine-lock: convert CoQueue to use QemuLockable
  coroutine-lock: make qemu_co_enter_next thread-safe
  curl: convert to CoQueue

 MAINTAINERS                            |    6 +
 block/Makefile.objs                    |    1 +
 block/block-backend.c                  |   10 +
 block/curl.c                           |   20 +-
 block/io.c                             |   24 +
 block/nvme.c                           | 1201 ++++++++++++++++++++++++++=
++++++
 block/trace-events                     |   21 +
 docs/devel/testing.rst                 |  486 +++++++++++++
 docs/qemu-block-drivers.texi           |   37 +
 fsdev/qemu-fsdev-throttle.c            |    4 +-
 hw/block/nvme.h                        |  698 +------------------
 include/block/block.h                  |   11 +-
 include/block/block_int.h              |    9 +
 include/block/nvme.h                   |  700 +++++++++++++++++++
 include/qemu/compiler.h                |   39 ++
 include/qemu/coroutine.h               |   29 +-
 include/qemu/lockable.h                |   96 +++
 include/qemu/thread.h                  |    5 +-
 include/qemu/typedefs.h                |    4 +
 include/qemu/vfio-helpers.h            |   33 +
 include/sysemu/block-backend.h         |    3 +
 qapi/block-core.json                   |   17 +-
 qemu-doc.texi                          |    1 +
 qemu-img.c                             |    9 +-
 stubs/Makefile.objs                    |    1 +
 stubs/ram-block.c                      |   16 +
 tests/docker/dockerfiles/fedora.docker |    2 +-
 tests/test-coroutine.c                 |   75 +-
 tests/vm/README                        |   90 +--
 util/Makefile.objs                     |    1 +
 util/qemu-coroutine-lock.c             |   22 +-
 util/trace-events                      |   11 +
 util/vfio-helpers.c                    |  727 +++++++++++++++++++
 33 files changed, 3580 insertions(+), 829 deletions(-)
 create mode 100644 block/nvme.c
 create mode 100644 docs/devel/testing.rst
 create mode 100644 include/block/nvme.h
 create mode 100644 include/qemu/lockable.h
 create mode 100644 include/qemu/vfio-helpers.h
 create mode 100644 stubs/ram-block.c
 create mode 100644 util/vfio-helpers.c

--=20
2.14.3
