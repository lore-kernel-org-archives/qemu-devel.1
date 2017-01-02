Received: from eggs.gnu.org ([2001:4830:134:3::10]:33106)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1cO8o1-0001YJ-6L
	for qemu-devel@nongnu.org; Mon, 02 Jan 2017 15:02:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1cO8o0-0003nn-5x
	for qemu-devel@nongnu.org; Mon, 02 Jan 2017 15:02:05 -0500
From: Andrew Jones <drjones@redhat.com>
Date: Mon,  2 Jan 2017 21:01:37 +0100
Message-Id: <20170102200153.28864-1-drjones@redhat.com>
Subject: [Qemu-devel] [PATCH v2 00/16] Remove VirtGuestInfo
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: imammedo@redhat.com, peter.maydell@linaro.org, zhaoshenglong@huawei.com, shannon.zhao@linaro.org, mst@redhat.com, ehabkost@redhat.com

v2:
 - all Igor's suggestions
 - added four mach-virt acpi cleanup patches
 - added the remaining two acpi patches needed to bring equivalence
   to Peter's DT changes

This series is based on Peter's qemu-arm gicv3-virt branch. It's
main goal (patches 07-13), which was suggested by Eduardo, is to
remove an unnecessary structure, VirtGuestInfo, which is a
maintenance burden, as it requires duplicating Virt machine state.
Additionally patches 05-06 do some mach-virt cleanups and patches
14-16 add the ACPI equivalents of the DT patches in Peter's
gicv3-virt branch. The first four patches are cleanups to mach-virt's
acpi code.

Patches available here
https://github.com/rhdrjones/qemu/commits/virt/remove-guest-info-v2

Andrew Jones (16):
  hw/arm/virt-acpi-build: add all missing cpu_to_le's
  hw/arm/virt-acpi-build: name GIC CPU Interface Structure appropriately
  hw/arm/virt-acpi-build: gtdt: improve flag naming
  hw/arm/virt-acpi-build: fadt: improve flag naming
  hw/arm/virt: parameter passing cleanups
  hw/arm/virt: use VirtMachineState.gic_version
  hw/arm/virt: eliminate struct VirtGuestInfoState
  hw/arm/virt: remove include/hw/arm/virt-acpi-build.h
  hw/arm/virt: move VirtMachineState/Class to virt.h
  hw/arm/virt: pass VirtMachineState instead of VirtGuestInfo
  hw/arm/virt-acpi-build: remove redundant members from VirtGuestInfo
  hw/arm/virt-acpi-build: don't save VirtGuestInfo on AcpiBuildState
  hw/arm/virt: remove VirtGuestInfo
  hw/arm/virt-acpi-build: Don't incorrectly claim architectural timer to
    be edge-triggered
  hw/arm/virt-acpi-build: use SMC if booting in EL2
  hw/arm/virt-acpi-build: madt: add vgic maint irq

 MAINTAINERS                      |   2 -
 hw/arm/virt-acpi-build.c         | 145 +++++++++++++++++++++------------------
 hw/arm/virt.c                    | 141 +++++++++++++------------------------
 include/hw/acpi/acpi-defs.h      |  33 +++------
 include/hw/arm/virt-acpi-build.h |  47 -------------
 include/hw/arm/virt.h            |  43 +++++++++++-
 6 files changed, 178 insertions(+), 233 deletions(-)
 delete mode 100644 include/hw/arm/virt-acpi-build.h

-- 
2.9.3
