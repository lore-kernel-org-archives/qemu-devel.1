Received: from eggs.gnu.org ([209.51.188.92]:39213)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1h1bbE-00069p-Rz
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 13:49:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1h1bbE-0004FJ-2W
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 13:49:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44528)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1h1bbD-0004Eo-Sd
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 13:49:04 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Wed,  6 Mar 2019 15:40:56 -0300
Message-Id: <20190306184101.9974-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 0/5] Machine queue, 2019-03-06
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org

The following changes since commit 9b748c5e061b1202fba59afd857e16a693743d90:

  Merge remote-tracking branch 'remotes/vivier2/tags/trivial-branch-pull-request' into staging (2019-03-06 11:58:10 +0000)

are available in the Git repository at:

  git://github.com/ehabkost/qemu.git tags/machine-next-pull-request

for you to fetch changes up to 14405c274e86e993e90198a49eecab3ca0ded8db:

  qdev: Provide qdev_get_bus_hotplug_handler() (2019-03-06 11:51:08 -0300)

----------------------------------------------------------------
Machine queue, 2019-03-06

* qdev: Hotplug handler chaining (David Hildenbrand)
* qdev: fix qbus_is_full() (Tony Krowiak)
* hostmem: fix crash when querying empty host-nodes property via
  QMP (Igor Mammedov)

----------------------------------------------------------------

Queue for Machine Core patches


David Hildenbrand (2):
  qdev: Let the hotplug_handler_unplug() caller delete the device
  qdev: Provide qdev_get_bus_hotplug_handler()

Igor Mammedov (2):
  hostmem: fix crash when querying empty host-nodes property via QMP
  qdev: Let machine hotplug handler to override bus hotplug handler

Tony Krowiak (1):
  qdev/core: fix qbus_is_full()

 include/hw/qdev-core.h   | 13 +++++++++++++
 backends/hostmem.c       |  3 ++-
 hw/acpi/cpu.c            |  1 +
 hw/acpi/memory_hotplug.c |  1 +
 hw/acpi/pcihp.c          |  3 ++-
 hw/core/qdev.c           | 22 +++++++++++++++-------
 hw/i386/pc.c             |  5 ++---
 hw/pci/pci.c             |  3 ++-
 hw/pci/pcie.c            |  3 ++-
 hw/pci/shpc.c            |  3 ++-
 hw/ppc/spapr.c           |  9 ++++++---
 hw/ppc/spapr_pci.c       |  3 ++-
 hw/s390x/css-bridge.c    |  2 +-
 hw/s390x/s390-pci-bus.c  | 13 ++++++++-----
 qdev-monitor.c           | 11 ++++++++---
 15 files changed, 67 insertions(+), 28 deletions(-)

-- 
2.18.0.rc1.1.g3f1ff2140
