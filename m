Received: from eggs.gnu.org ([2001:4830:134:3::10]:47490)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fuEOC-0000zA-QV
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 06:04:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fuEOB-00058c-Rx
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 06:04:52 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57744 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fuEOB-00057m-N3
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 06:04:51 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 62FD04023827
	for <qemu-devel@nongnu.org>; Mon, 27 Aug 2018 10:04:51 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Mon, 27 Aug 2018 12:04:26 +0200
Message-Id: <20180827100431.7915-5-quintela@redhat.com>
In-Reply-To: <20180827100431.7915-1-quintela@redhat.com>
References: <20180827100431.7915-1-quintela@redhat.com>
Subject: [Qemu-devel] [PULL 4/9] x86_64-softmmu: Configuration is identical
 to i386-softmmu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com

If we ever changed that, just make the things that are different
explicit.

Signed-off-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 default-configs/x86_64-softmmu.mak | 67 +-----------------------------
 1 file changed, 1 insertion(+), 66 deletions(-)

diff --git a/default-configs/x86_64-softmmu.mak b/default-configs/x86_64-softmmu.mak
index 0390b4303c..64b2ee2960 100644
--- a/default-configs/x86_64-softmmu.mak
+++ b/default-configs/x86_64-softmmu.mak
@@ -1,68 +1,3 @@
 # Default configuration for x86_64-softmmu
 
-include pci.mak
-include sound.mak
-include usb.mak
-CONFIG_QXL=$(CONFIG_SPICE)
-CONFIG_VGA_ISA=y
-CONFIG_VGA_CIRRUS=y
-CONFIG_VMWARE_VGA=y
-CONFIG_VMXNET3_PCI=y
-CONFIG_VIRTIO_VGA=y
-CONFIG_VMMOUSE=y
-CONFIG_IPMI=y
-CONFIG_IPMI_LOCAL=y
-CONFIG_IPMI_EXTERN=y
-CONFIG_ISA_IPMI_KCS=y
-CONFIG_ISA_IPMI_BT=y
-CONFIG_SERIAL=y
-CONFIG_SERIAL_ISA=y
-CONFIG_PARALLEL=y
-CONFIG_I8254=y
-CONFIG_PCSPK=y
-CONFIG_PCKBD=y
-CONFIG_FDC=y
-CONFIG_ACPI=y
-CONFIG_ACPI_X86=y
-CONFIG_ACPI_X86_ICH=y
-CONFIG_ACPI_MEMORY_HOTPLUG=y
-CONFIG_ACPI_CPU_HOTPLUG=y
-CONFIG_APM=y
-CONFIG_I8257=y
-CONFIG_IDE_ISA=y
-CONFIG_IDE_PIIX=y
-CONFIG_NE2000_ISA=y
-CONFIG_HPET=y
-CONFIG_APPLESMC=y
-CONFIG_I8259=y
-CONFIG_PFLASH_CFI01=y
-CONFIG_TPM_TIS=$(CONFIG_TPM)
-CONFIG_TPM_CRB=$(CONFIG_TPM)
-CONFIG_MC146818RTC=y
-CONFIG_PCI_PIIX=y
-CONFIG_WDT_IB700=y
-CONFIG_ISA_DEBUG=y
-CONFIG_ISA_TESTDEV=y
-CONFIG_VMPORT=y
-CONFIG_SGA=y
-CONFIG_LPC_ICH9=y
-CONFIG_PCI_Q35=y
-CONFIG_APIC=y
-CONFIG_IOAPIC=y
-CONFIG_PVPANIC=y
-CONFIG_MEM_HOTPLUG=y
-CONFIG_NVDIMM=y
-CONFIG_ACPI_NVDIMM=y
-CONFIG_PCIE_PORT=y
-CONFIG_XIO3130=y
-CONFIG_IOH3420=y
-CONFIG_I82801B11=y
-CONFIG_SMBIOS=y
-CONFIG_HYPERV_TESTDEV=$(CONFIG_KVM)
-CONFIG_PXB=y
-CONFIG_ACPI_VMGENID=y
-CONFIG_FW_CFG_DMA=y
-CONFIG_I2C=y
-CONFIG_SEV=$(CONFIG_KVM)
-CONFIG_VTD=y
-CONFIG_AMD_IOMMU=y
+include i386-softmmu.mak
-- 
2.17.1
