Received: from eggs.gnu.org ([2001:4830:134:3::10]:45774)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ebzeg-0000CM-2R
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 21:10:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ebzeb-0004HC-Es
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 21:10:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52114)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1ebzeb-0004Gh-6L
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 21:10:09 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Thu, 18 Jan 2018 00:09:41 -0200
Message-Id: <20180118021000.27203-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 00/19] machine queue, 2018-01-18
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

The following changes since commit 8e5dc9ba49743b46d955ec7dacb04e42ae7ada=
7c:

  Merge remote-tracking branch 'remotes/rth/tags/pull-tcg-20180116' into =
staging (2018-01-16 17:36:39 +0000)

are available in the Git repository at:

  git://github.com/ehabkost/qemu.git tags/machine-next-pull-request

for you to fetch changes up to 901cc8d31f36ac82824ab68f656ab7050404100c:

  fw_cfg: fix memory corruption when all fw_cfg slots are used (2018-01-1=
7 23:04:37 -0200)

----------------------------------------------------------------
machine queue, 2018-01-18

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
