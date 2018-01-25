Received: from eggs.gnu.org ([2001:4830:134:3::10]:59267)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eeaNJ-0006hc-Jc
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 00:47:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eeaNF-00071C-7j
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 00:47:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45580)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1eeaNE-0006vw-VZ
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 00:46:57 -0500
From: Fam Zheng <famz@redhat.com>
Date: Thu, 25 Jan 2018 13:46:34 +0800
Message-Id: <20180125054648.18747-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 00/14] Block and docker patches
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

The following changes since commit 834a336eb911db8a8ca00e760ee6a85faca194=
14:

  Merge remote-tracking branch 'remotes/mst/tags/for_upstream' into stagi=
ng (2018-01-24 19:24:26 +0000)

are available in the Git repository at:

  git://github.com/famz/qemu.git tags/staging-pull-request

for you to fetch changes up to 6b4c4a84a1c7386df30edb4cb3b846b7ded9c707:

  qapi: Add NVMe driver options to the schema (2018-01-25 13:26:54 +0800)

----------------------------------------------------------------

Hi Peter, this includes:

- Paolo's docker fix for fedora image.
- Paolo's coroutine lock API improvements.
- My userspace NVMe driver.

----------------------------------------------------------------

Fam Zheng (9):
  stubs: Add stubs for ram block API
  util: Introduce vfio helpers
  block: Add VFIO based NVMe driver
  block: Introduce buf register API
  block/nvme: Implement .bdrv_(un)register_buf
  qemu-img: Map bench buffer
  block: Move NVMe constants to a separate header
  docs: Add section for NVMe VFIO driver
  qapi: Add NVMe driver options to the schema

Paolo Bonzini (5):
  docker: change Fedora base image to fedora:27
  lockable: add QemuLockable
  coroutine-lock: convert CoQueue to use QemuLockable
  coroutine-lock: make qemu_co_enter_next thread-safe
  curl: convert to CoQueue

 MAINTAINERS                            |    6 +
 block/Makefile.objs                    |    1 +
 block/block-backend.c                  |   10 +
 block/curl.c                           |   20 +-
 block/io.c                             |   24 +
 block/nvme.c                           | 1199 ++++++++++++++++++++++++++=
++++++
 block/trace-events                     |   21 +
 docs/qemu-block-drivers.texi           |   37 +
 fsdev/qemu-fsdev-throttle.c            |    4 +-
 hw/block/nvme.h                        |  698 +------------------
 include/block/block.h                  |   11 +-
 include/block/block_int.h              |    9 +
 include/block/nvme.h                   |  700 +++++++++++++++++++
 include/qemu/compiler.h                |   40 ++
 include/qemu/coroutine.h               |   25 +-
 include/qemu/lockable.h                |   75 ++
 include/qemu/thread.h                  |    5 +-
 include/qemu/typedefs.h                |    4 +
 include/qemu/vfio-helpers.h            |   33 +
 include/sysemu/block-backend.h         |    3 +
 qapi/block-core.json                   |   17 +-
 qemu-img.c                             |    9 +-
 stubs/Makefile.objs                    |    1 +
 stubs/ram-block.c                      |   16 +
 tests/docker/dockerfiles/fedora.docker |    2 +-
 util/Makefile.objs                     |    1 +
 util/qemu-coroutine-lock.c             |   22 +-
 util/trace-events                      |   11 +
 util/vfio-helpers.c                    |  726 +++++++++++++++++++
 29 files changed, 2993 insertions(+), 737 deletions(-)
 create mode 100644 block/nvme.c
 create mode 100644 include/block/nvme.h
 create mode 100644 include/qemu/lockable.h
 create mode 100644 include/qemu/vfio-helpers.h
 create mode 100644 stubs/ram-block.c
 create mode 100644 util/vfio-helpers.c

--=20
2.14.3
