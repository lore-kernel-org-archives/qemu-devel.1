Received: from eggs.gnu.org ([209.51.188.92]:41334)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hJicK-0000Er-Cv
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 13:57:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hJicJ-0004sX-Ay
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 13:57:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:28926)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hJicJ-0004rT-2d
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 13:57:03 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Thu, 25 Apr 2019 14:56:48 -0300
Message-Id: <20190425175659.24876-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 00/11] Machine queue, 2019-04-25
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>

The following changes since commit 3284aa128153750f14a61e8a96fd085e6f2999b6:

  Merge remote-tracking branch 'remotes/lersek/tags/edk2-pull-2019-04-22' into staging (2019-04-24 13:19:41 +0100)

are available in the Git repository at:

  git://github.com/ehabkost/qemu.git tags/machine-next-pull-request

for you to fetch changes up to 119906afa5ca610adb87c55ab0d8e53c9104bfc3:

  util/mmap-alloc: support MAP_SYNC in qemu_ram_mmap() (2019-04-25 14:17:36 -0300)

----------------------------------------------------------------
Machine queue, 2019-04-25

* 4.1 machine-types (Cornelia Huck)
* Support MAP_SYNC on pmem memory backends (Zhang Yi)
* -cpu parsing fixes and cleanups (Eduardo Habkost)
* machine initialization cleanups (Wei Yang, Markus Armbruster)

----------------------------------------------------------------

Queue for Machine Core patches


Cornelia Huck (1):
  hw: add compat machines for 4.1

Eduardo Habkost (2):
  cpu: Rename parse_cpu_model() to parse_cpu_option()
  cpu: Fix crash with empty -cpu option

Markus Armbruster (2):
  vl: Clean up after previous commit
  vl: Simplify machine_parse()

Wei Yang (2):
  vl.c: make find_default_machine() local
  vl.c: allocate TYPE_MACHINE list once during bootup

Zhang Yi (4):
  util/mmap-alloc: Add a 'is_pmem' parameter to qemu_ram_mmap
  scripts/update-linux-headers: add linux/mman.h
  linux-headers: add linux/mman.h.
  util/mmap-alloc: support MAP_SYNC in qemu_ram_mmap()

 docs/nvdimm.txt                            |  22 ++++-
 include/hw/boards.h                        |   4 +-
 include/hw/i386/pc.h                       |   3 +
 include/qemu/mmap-alloc.h                  |  21 +++-
 include/qom/cpu.h                          |   6 +-
 linux-headers/asm-arm/mman.h               |   4 +
 linux-headers/asm-arm64/mman.h             |   1 +
 linux-headers/asm-generic/hugetlb_encode.h |  36 +++++++
 linux-headers/asm-generic/mman-common.h    |  77 +++++++++++++++
 linux-headers/asm-generic/mman.h           |  24 +++++
 linux-headers/asm-mips/mman.h              | 108 +++++++++++++++++++++
 linux-headers/asm-powerpc/mman.h           |  39 ++++++++
 linux-headers/asm-s390/mman.h              |   1 +
 linux-headers/asm-x86/mman.h               |  31 ++++++
 linux-headers/linux/mman.h                 |  38 ++++++++
 bsd-user/main.c                            |   2 +-
 exec.c                                     |  10 +-
 hw/arm/virt.c                              |   9 +-
 hw/core/machine.c                          |   3 +
 hw/i386/pc.c                               |   3 +
 hw/i386/pc_piix.c                          |  14 ++-
 hw/i386/pc_q35.c                           |  13 ++-
 hw/ppc/spapr.c                             |  15 ++-
 hw/s390x/s390-virtio-ccw.c                 |  14 ++-
 linux-user/main.c                          |   2 +-
 util/mmap-alloc.c                          |  47 ++++++++-
 util/oslib-posix.c                         |   2 +-
 vl.c                                       |  87 +++++++----------
 qemu-options.hx                            |   5 +
 scripts/update-linux-headers.sh            |   6 +-
 tests/acceptance/empty_cpu_model.py        |  19 ++++
 31 files changed, 591 insertions(+), 75 deletions(-)
 create mode 100644 linux-headers/asm-arm/mman.h
 create mode 100644 linux-headers/asm-arm64/mman.h
 create mode 100644 linux-headers/asm-generic/hugetlb_encode.h
 create mode 100644 linux-headers/asm-generic/mman-common.h
 create mode 100644 linux-headers/asm-generic/mman.h
 create mode 100644 linux-headers/asm-mips/mman.h
 create mode 100644 linux-headers/asm-powerpc/mman.h
 create mode 100644 linux-headers/asm-s390/mman.h
 create mode 100644 linux-headers/asm-x86/mman.h
 create mode 100644 linux-headers/linux/mman.h
 create mode 100644 tests/acceptance/empty_cpu_model.py

-- 
2.18.0.rc1.1.g3f1ff2140
