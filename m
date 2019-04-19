Received: from eggs.gnu.org ([209.51.188.92]:35712)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hHHc9-0007cN-FL
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 20:42:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hHHRC-0005oF-Dq
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 20:31:31 -0400
From: Wei Yang <richardw.yang@linux.intel.com>
Date: Fri, 19 Apr 2019 08:30:47 +0800
Message-Id: <20190419003053.8260-1-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v4 0/6] Extract build_mcfg
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: mst@redhat.com, imammedo@redhat.com, shannon.zhaosl@gmail.com, peter.maydell@linaro.org, marcel.apfelbaum@gmail.com, yang.zhong@intel.com, philmd@redhat.com, Wei Yang <richardw.yang@linux.intel.com>

This patch set tries to generalize MCFG table build process. And it is
based on one un-merged patch from Igor, which is included in this serials.

v3->v4:
    * adjust comment to give more information about MCFG table

v2->v3:
    * Includes the un-merged patch from Igor
    * use build_append_foo() API to construct MCFG

Igor Mammedov (1):
  q35: acpi: do not create dummy MCFG table

Wei Yang (5):
  hw/arm/virt-acpi-build: remove unnecessary variable mcfg_start
  i386, acpi: remove mcfg_ prefix in AcpiMcfgInfo members
  hw/arm/virt-acpi-build: pass AcpiMcfgInfo to build_mcfg()
  hw/acpi: Consolidate build_mcfg to pci.c
  acpi: pci: use build_append_foo() API to construct MCFG

 default-configs/arm-softmmu.mak  |  1 +
 default-configs/i386-softmmu.mak |  1 +
 hw/acpi/Kconfig                  |  4 +++
 hw/acpi/Makefile.objs            |  1 +
 hw/acpi/pci.c                    | 55 ++++++++++++++++++++++++++++++++
 hw/arm/virt-acpi-build.c         | 31 +++++-------------
 hw/i386/acpi-build.c             | 44 ++++---------------------
 include/hw/acpi/acpi-defs.h      | 18 -----------
 include/hw/acpi/pci.h            | 34 ++++++++++++++++++++
 9 files changed, 111 insertions(+), 78 deletions(-)
 create mode 100644 hw/acpi/pci.c
 create mode 100644 include/hw/acpi/pci.h

-- 
2.19.1
