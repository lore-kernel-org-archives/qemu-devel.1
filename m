Received: from eggs.gnu.org ([2001:4830:134:3::10]:38306)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fFjXl-0006Eu-Ic
	for qemu-devel@nongnu.org; Mon, 07 May 2018 13:03:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fFjXi-0007H1-FP
	for qemu-devel@nongnu.org; Mon, 07 May 2018 13:03:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:18222)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fFjXi-0007GC-9s
	for qemu-devel@nongnu.org; Mon, 07 May 2018 13:03:18 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon,  7 May 2018 14:03:03 -0300
Message-Id: <20180507170315.11497-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 00/12] Machine queue, 2018-05-07
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org

The following changes since commit c8b7e627b4269a3bc3ae41d9f420547a47e6d9b9:

  Merge remote-tracking branch 'remotes/ericb/tags/pull-nbd-2018-05-04' into staging (2018-05-04 14:42:46 +0100)

are available in the Git repository at:

  git://github.com/ehabkost/qemu.git tags/machine-next-pull-request

for you to fetch changes up to b40dffdec60c2dbe54806576faa5cb85227586d1:

  scripts/device-crash-test: Removed fixed CAN entries (2018-05-07 10:00:02 -0300)

----------------------------------------------------------------
Machine queue, 2018-05-07

* pc-dimm: factor out MemoryDevice
  (virtio-pmem and virtio-mem will make use of the new abstraction later)
* scripts/device-crash-test: Removed fixed CAN entries

----------------------------------------------------------------

Queue for Machine Core patches


David Hildenbrand (11):
  pc-dimm: factor out MemoryDevice interface
  machine: make MemoryHotplugState accessible via the machine
  pc-dimm: no need to pass the memory region
  pc-dimm: pass in the machine and to the MemoryHotplugState
  pc-dimm: factor out address search into MemoryDevice code
  pc-dimm: factor out capacity and slot checks into MemoryDevice
  pc-dimm: move actual plug/unplug of a memory region to MemoryDevice
  machine: rename MemoryHotplugState to DeviceMemoryState
  pc: rename "hotplug memory" terminology to "device memory"
  spapr: rename "hotplug memory" terminology to "device memory"
  vl: allow 'maxmem' without 'slot'

Thomas Huth (1):
  scripts/device-crash-test: Removed fixed CAN entries

 include/hw/boards.h                          |  12 ++
 include/hw/i386/pc.h                         |   3 +-
 include/hw/mem/memory-device.h               |  51 +++++
 include/hw/mem/pc-dimm.h                     |  27 +--
 include/hw/ppc/spapr.h                       |   5 +-
 hw/i386/acpi-build.c                         |   7 +-
 hw/i386/pc.c                                 |  65 +++---
 hw/mem/memory-device.c                       | 275 ++++++++++++++++++++++++
 hw/mem/pc-dimm.c                             | 304 +++++++--------------------
 hw/ppc/spapr.c                               |  71 ++++---
 hw/ppc/spapr_hcall.c                         |   7 +-
 hw/ppc/spapr_rtas_ddw.c                      |   5 +-
 numa.c                                       |   3 +-
 qmp.c                                        |   4 +-
 stubs/{qmp_pc_dimm.c => qmp_memory_device.c} |   4 +-
 vl.c                                         |  19 +-
 hw/mem/Makefile.objs                         |   1 +
 scripts/device-crash-test                    |   3 -
 stubs/Makefile.objs                          |   2 +-
 19 files changed, 510 insertions(+), 358 deletions(-)
 create mode 100644 include/hw/mem/memory-device.h
 create mode 100644 hw/mem/memory-device.c
 rename stubs/{qmp_pc_dimm.c => qmp_memory_device.c} (61%)

-- 
2.14.3
