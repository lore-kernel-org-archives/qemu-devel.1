Received: from eggs.gnu.org ([2001:4830:134:3::10]:53689)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1cGutA-0002ML-Nr
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 16:45:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1cGut9-0007TG-6X
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 16:45:32 -0500
From: Andrew Jones <drjones@redhat.com>
Date: Tue, 13 Dec 2016 22:45:11 +0100
Message-Id: <20161213214522.25548-1-drjones@redhat.com>
Subject: [Qemu-devel] [PATCH 00/11] Remove VirtGuestInfo
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: peter.maydell@linaro.org, zhaoshenglong@huawei.com, mst@redhat.com, imammedo@redhat.com, ehabkost@redhat.com

This series is based on Peter's qemu-arm gicv3-virt branch. It's
main goal (patches 04-10), which was suggested by Eduardo, is to
remove an unnecessary structure, VirtGuestInfo, which is a
maintenance burden, as it requires duplicating Virt machine state.
Additionally patches 01-03 do some mach-virt cleanups and patch 11
adds the ACPI equivalent to one of the DT patches in Peter's
gicv3-virt branch.

The last patch isn't really tested as the guest kernel versions I
used seem to ignore the GTDT irqflags and either just choose edge,
4.5-based kernel, or level, 4.9-based kernel.

Patches available here
https://github.com/rhdrjones/qemu/commits/virt/remove-guest-info


Andrew Jones (11):
  hw/arm/virt: parameter passing cleanups
  hw/arm/virt: use VirtMachineState.gic_version
  hw/arm/virt: use VirtMachineState.smp_cpus
  hw/arm/virt: eliminate struct VirtGuestInfoState
  hw/arm/virt: remove include/hw/arm/virt-acpi-build.h
  hw/arm/virt: move VirtMachineState/Class to virt.h
  hw/arm/virt: pass VirtMachineState instead of VirtGuestInfo
  hw/arm/virt-acpi-build: remove redundant members from VirtGuestInfo
  hw/arm/virt-acpi-build: don't save VirtGuestInfo on AcpiBuildState
  hw/arm/virt: remove VirtGuestInfo
  hw/arm/virt-acpi-build: Don't incorrectly claim architectural timer to
    be edge-triggered

 MAINTAINERS                      |   2 -
 hw/arm/virt-acpi-build.c         | 103 +++++++++++++-------------
 hw/arm/virt.c                    | 152 ++++++++++++++-------------------------
 include/hw/arm/virt-acpi-build.h |  47 ------------
 include/hw/arm/virt.h            |  45 +++++++++++-
 5 files changed, 151 insertions(+), 198 deletions(-)
 delete mode 100644 include/hw/arm/virt-acpi-build.h

-- 
2.9.3
