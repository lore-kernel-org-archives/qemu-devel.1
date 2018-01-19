Received: from eggs.gnu.org ([2001:4830:134:3::10]:45176)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ecZc5-0005AR-Gs
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 11:33:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ecZc1-0006Mn-HQ
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 11:33:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:5321)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1ecZc1-0006MQ-9F
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 11:33:53 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Fri, 19 Jan 2018 14:33:26 -0200
Message-Id: <20180119163345.10649-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v2 00/19] machine queue, 2018-01-19
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel@redhat.com>

Changes from v1 (2018-01-18):
* Fix build failure on 32-bit

The following changes since commit 3e5bdc6573edf0585e4085e6a4e349b135abf3=
b4:

  Merge remote-tracking branch 'remotes/mst/tags/for_upstream' into stagi=
ng (2018-01-19 10:17:20 +0000)

are available in the Git repository at:

  git://github.com/ehabkost/qemu.git tags/machine-next-pull-request

for you to fetch changes up to d6b6abc51dda79a97f2c7bd6652c1940c068f1ec:

  fw_cfg: fix memory corruption when all fw_cfg slots are used (2018-01-1=
9 11:18:51 -0200)

----------------------------------------------------------------
machine queue, 2018-01-19

----------------------------------------------------------------

Eduardo Habkost (6):
  machine: Replace has_dynamic_sysbus with list of allowed devices
  hw/arm/virt: Allow only supported dynamic sysbus devices
  ppc: e500: Allow only supported dynamic sysbus devices
  spapr: Allow only supported dynamic sysbus devices
  xen: Add only xen-sysdev to dynamic sysbus device list
  q35: Allow only supported dynamic sysbus devices

Haozhong Zhang (3):
  hostmem-file: add "align" option
  nvdimm: add a macro for property "label-size"
  nvdimm: add 'unarmed' option

Igor Mammedov (2):
  numa: fix missing '-numa cpu' in '-help' output
  possible_cpus: add CPUArchId::type field

Marc-Andr=C3=A9 Lureau (2):
  memfd: split qemu_memfd_alloc()
  memfd: remove needless include

Marcel Apfelbaum (1):
  fw_cfg: fix memory corruption when all fw_cfg slots are used

Stefan Hajnoczi (2):
  qemu-options: document missing memory-backend-file options
  qemu-options: document memory-backend-ram

Thomas Huth (3):
  qdev_monitor: Simplify error handling in qdev_device_add()
  qdev: Check for the availability of a hotplug controller before adding
    a device
  scripts: Remove fixed entries from the device-crash-test

 docs/nvdimm.txt            | 31 ++++++++++++++++++++++
 include/exec/memory.h      |  3 +++
 include/hw/boards.h        |  7 ++++-
 include/hw/mem/nvdimm.h    | 12 +++++++++
 include/hw/qdev-core.h     |  1 +
 include/qemu/memfd.h       |  1 +
 backends/hostmem-file.c    | 41 +++++++++++++++++++++++++++-
 exec.c                     |  8 +++++-
 hw/acpi/nvdimm.c           |  7 +++++
 hw/arm/virt.c              |  8 ++++--
 hw/core/machine.c          | 55 ++++++++++++++++++++++++--------------
 hw/core/qdev.c             | 28 ++++++++++++++------
 hw/i386/pc.c               |  4 ++-
 hw/i386/pc_q35.c           |  5 +++-
 hw/mem/nvdimm.c            | 28 +++++++++++++++++++-
 hw/nvram/fw_cfg.c          |  6 +++--
 hw/ppc/e500plat.c          |  4 ++-
 hw/ppc/spapr.c             | 15 ++++++-----
 hw/s390x/s390-virtio-ccw.c |  1 +
 hw/xen/xen_backend.c       |  2 +-
 memory.c                   |  2 ++
 numa.c                     |  2 +-
 qdev-monitor.c             | 21 +++++++++------
 util/memfd.c               | 63 ++++++++++++++++++++++++----------------=
---
 vl.c                       |  3 +--
 qemu-options.hx            | 66 ++++++++++++++++++++++++++++++++++++++++=
------
 scripts/device-crash-test  |  8 ------
 27 files changed, 332 insertions(+), 100 deletions(-)

--=20
2.14.3
