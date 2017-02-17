Received: from eggs.gnu.org ([2001:4830:134:3::10]:36794)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1ceidT-0005LK-V7
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 08:31:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1ceidR-0007fQ-AD
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 08:31:43 -0500
From: Laurent Vivier <lvivier@redhat.com>
Date: Fri, 17 Feb 2017 14:31:33 +0100
Message-Id: <20170217133134.10735-2-lvivier@redhat.com>
In-Reply-To: <20170217133134.10735-1-lvivier@redhat.com>
References: <20170217133134.10735-1-lvivier@redhat.com>
Subject: [Qemu-devel] [PATCH v6 1/2] PCI: add missing classes in pci_ids.h
 to build device tree
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: David Gibson <david@gibson.dropbear.id.au>, Thomas Huth <thuth@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, qemu-ppc@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>, Laurent Vivier <lvivier@redhat.com>

To allow QEMU to add PCI entries in device tree,
we must have a more exhaustive list of PCI class IDs.

This patch synchronizes as much as possible with
pci_ids.h and add some missing IDs from SLOF.

Signed-off-by: Laurent Vivier <lvivier@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 include/hw/pci/pci_ids.h | 112 +++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 103 insertions(+), 9 deletions(-)

diff --git a/include/hw/pci/pci_ids.h b/include/hw/pci/pci_ids.h
index d77ca60..d22ad8d 100644
--- a/include/hw/pci/pci_ids.h
+++ b/include/hw/pci/pci_ids.h
@@ -13,41 +13,84 @@
 
 /* Device classes and subclasses */
 
-#define PCI_BASE_CLASS_STORAGE           0x01
-#define PCI_BASE_CLASS_NETWORK           0x02
+#define PCI_CLASS_NOT_DEFINED            0x0000
+#define PCI_CLASS_NOT_DEFINED_VGA        0x0001
 
+#define PCI_BASE_CLASS_STORAGE           0x01
 #define PCI_CLASS_STORAGE_SCSI           0x0100
 #define PCI_CLASS_STORAGE_IDE            0x0101
+#define PCI_CLASS_STORAGE_FLOPPY         0x0102
+#define PCI_CLASS_STORAGE_IPI            0x0103
 #define PCI_CLASS_STORAGE_RAID           0x0104
+#define PCI_CLASS_STORAGE_ATA            0x0105
 #define PCI_CLASS_STORAGE_SATA           0x0106
+#define PCI_CLASS_STORAGE_SAS            0x0107
 #define PCI_CLASS_STORAGE_EXPRESS        0x0108
 #define PCI_CLASS_STORAGE_OTHER          0x0180
 
+#define PCI_BASE_CLASS_NETWORK           0x02
 #define PCI_CLASS_NETWORK_ETHERNET       0x0200
+#define PCI_CLASS_NETWORK_TOKEN_RING     0x0201
+#define PCI_CLASS_NETWORK_FDDI           0x0202
+#define PCI_CLASS_NETWORK_ATM            0x0203
+#define PCI_CLASS_NETWORK_ISDN           0x0204
+#define PCI_CLASS_NETWORK_WORLDFIP       0x0205
+#define PCI_CLASS_NETWORK_PICMG214       0x0206
 #define PCI_CLASS_NETWORK_OTHER          0x0280
 
+#define PCI_BASE_CLASS_DISPLAY           0x03
 #define PCI_CLASS_DISPLAY_VGA            0x0300
+#define PCI_CLASS_DISPLAY_XGA            0x0301
+#define PCI_CLASS_DISPLAY_3D             0x0302
 #define PCI_CLASS_DISPLAY_OTHER          0x0380
 
+#define PCI_BASE_CLASS_MULTIMEDIA        0x04
+#define PCI_CLASS_MULTIMEDIA_VIDEO       0x0400
 #define PCI_CLASS_MULTIMEDIA_AUDIO       0x0401
+#define PCI_CLASS_MULTIMEDIA_PHONE       0x0402
+#define PCI_CLASS_MULTIMEDIA_OTHER       0x0480
 
+#define PCI_BASE_CLASS_MEMORY            0x05
 #define PCI_CLASS_MEMORY_RAM             0x0500
+#define PCI_CLASS_MEMORY_FLASH           0x0501
+#define PCI_CLASS_MEMORY_OTHER           0x0580
 
-#define PCI_CLASS_SYSTEM_SDHCI           0x0805
-#define PCI_CLASS_SYSTEM_OTHER           0x0880
-
-#define PCI_CLASS_SERIAL_USB             0x0c03
-#define PCI_CLASS_SERIAL_SMBUS           0x0c05
-
+#define PCI_BASE_CLASS_BRIDGE            0x06
 #define PCI_CLASS_BRIDGE_HOST            0x0600
 #define PCI_CLASS_BRIDGE_ISA             0x0601
+#define PCI_CLASS_BRIDGE_EISA            0x0602
+#define PCI_CLASS_BRIDGE_MC              0x0603
 #define PCI_CLASS_BRIDGE_PCI             0x0604
 #define PCI_CLASS_BRIDGE_PCI_INF_SUB     0x01
+#define PCI_CLASS_BRIDGE_PCMCIA          0x0605
+#define PCI_CLASS_BRIDGE_NUBUS           0x0606
+#define PCI_CLASS_BRIDGE_CARDBUS         0x0607
+#define PCI_CLASS_BRIDGE_RACEWAY         0x0608
+#define PCI_CLASS_BRIDGE_PCI_SEMITP      0x0609
+#define PCI_CLASS_BRIDGE_IB_PCI          0x060a
 #define PCI_CLASS_BRIDGE_OTHER           0x0680
 
+#define PCI_BASE_CLASS_COMMUNICATION     0x07
 #define PCI_CLASS_COMMUNICATION_SERIAL   0x0700
+#define PCI_CLASS_COMMUNICATION_PARALLEL 0x0701
+#define PCI_CLASS_COMMUNICATION_MULTISERIAL 0x0702
+#define PCI_CLASS_COMMUNICATION_MODEM    0x0703
+#define PCI_CLASS_COMMUNICATION_GPIB     0x0704
+#define PCI_CLASS_COMMUNICATION_SC       0x0705
 #define PCI_CLASS_COMMUNICATION_OTHER    0x0780
 
+#define PCI_BASE_CLASS_SYSTEM            0x08
+#define PCI_CLASS_SYSTEM_PIC             0x0800
+#define PCI_CLASS_SYSTEM_PIC_IOAPIC      0x080010
+#define PCI_CLASS_SYSTEM_PIC_IOXAPIC     0x080020
+#define PCI_CLASS_SYSTEM_DMA             0x0801
+#define PCI_CLASS_SYSTEM_TIMER           0x0802
+#define PCI_CLASS_SYSTEM_RTC             0x0803
+#define PCI_CLASS_SYSTEM_PCI_HOTPLUG     0x0804
+#define PCI_CLASS_SYSTEM_SDHCI           0x0805
+#define PCI_CLASS_SYSTEM_OTHER           0x0880
+
+#define PCI_BASE_CLASS_INPUT             0x09
 #define PCI_CLASS_INPUT_KEYBOARD         0x0900
 #define PCI_CLASS_INPUT_PEN              0x0901
 #define PCI_CLASS_INPUT_MOUSE            0x0902
@@ -55,8 +98,59 @@
 #define PCI_CLASS_INPUT_GAMEPORT         0x0904
 #define PCI_CLASS_INPUT_OTHER            0x0980
 
-#define PCI_CLASS_PROCESSOR_CO           0x0b40
+#define PCI_BASE_CLASS_DOCKING           0x0a
+#define PCI_CLASS_DOCKING_GENERIC        0x0a00
+#define PCI_CLASS_DOCKING_OTHER          0x0a80
+
+#define PCI_BASE_CLASS_PROCESSOR         0x0b
+#define PCI_CLASS_PROCESSOR_PENTIUM      0x0b02
 #define PCI_CLASS_PROCESSOR_POWERPC      0x0b20
+#define PCI_CLASS_PROCESSOR_MIPS         0x0b30
+#define PCI_CLASS_PROCESSOR_CO           0x0b40
+
+#define PCI_BASE_CLASS_SERIAL            0x0c
+#define PCI_CLASS_SERIAL_FIREWIRE        0x0c00
+#define PCI_CLASS_SERIAL_ACCESS          0x0c01
+#define PCI_CLASS_SERIAL_SSA             0x0c02
+#define PCI_CLASS_SERIAL_USB             0x0c03
+#define PCI_CLASS_SERIAL_USB_UHCI        0x0c0300
+#define PCI_CLASS_SERIAL_USB_OHCI        0x0c0310
+#define PCI_CLASS_SERIAL_USB_EHCI        0x0c0320
+#define PCI_CLASS_SERIAL_USB_XHCI        0x0c0330
+#define PCI_CLASS_SERIAL_USB_UNKNOWN     0x0c0380
+#define PCI_CLASS_SERIAL_USB_DEVICE      0x0c03fe
+#define PCI_CLASS_SERIAL_FIBER           0x0c04
+#define PCI_CLASS_SERIAL_SMBUS           0x0c05
+#define PCI_CLASS_SERIAL_IB              0x0c06
+#define PCI_CLASS_SERIAL_IPMI            0x0c07
+#define PCI_CLASS_SERIAL_SERCOS          0x0c08
+#define PCI_CLASS_SERIAL_CANBUS          0x0c09
+
+#define PCI_BASE_CLASS_WIRELESS          0x0d
+#define PCI_CLASS_WIRELESS_IRDA          0x0d00
+#define PCI_CLASS_WIRELESS_CIR           0x0d01
+#define PCI_CLASS_WIRELESS_RF_CONTROLLER 0x0d10
+#define PCI_CLASS_WIRELESS_BLUETOOTH     0x0d11
+#define PCI_CLASS_WIRELESS_BROADBAND     0x0d12
+#define PCI_CLASS_WIRELESS_OTHER         0x0d80
+
+#define PCI_BASE_CLASS_SATELLITE         0x0f
+#define PCI_CLASS_SATELLITE_TV           0x0f00
+#define PCI_CLASS_SATELLITE_AUDIO        0x0f01
+#define PCI_CLASS_SATELLITE_VOICE        0x0f03
+#define PCI_CLASS_SATELLITE_DATA         0x0f04
+
+#define PCI_BASE_CLASS_CRYPT             0x10
+#define PCI_CLASS_CRYPT_NETWORK          0x1000
+#define PCI_CLASS_CRYPT_ENTERTAINMENT    0x1001
+#define PCI_CLASS_CRYPT_OTHER            0x1080
+
+#define PCI_BASE_CLASS_SIGNAL_PROCESSING 0x11
+#define PCI_CLASS_SP_DPIO                0x1100
+#define PCI_CLASS_SP_PERF                0x1101
+#define PCI_CLASS_SP_SYNCH               0x1110
+#define PCI_CLASS_SP_MANAGEMENT          0x1120
+#define PCI_CLASS_SP_OTHER               0x1180
 
 #define PCI_CLASS_OTHERS                 0xff
 
-- 
2.9.3
