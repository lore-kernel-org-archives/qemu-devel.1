Received: from eggs.gnu.org ([2001:4830:134:3::10]:55498)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zuban32s@gmail.com>) id 1dPB4Q-0008OT-Ku
	for qemu-devel@nongnu.org; Sun, 25 Jun 2017 13:11:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zuban32s@gmail.com>) id 1dPB4N-0007pc-G4
	for qemu-devel@nongnu.org; Sun, 25 Jun 2017 13:11:34 -0400
Received: from mail-lf0-x243.google.com ([2a00:1450:4010:c07::243]:34649)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <zuban32s@gmail.com>) id 1dPB4N-0007oa-8X
	for qemu-devel@nongnu.org; Sun, 25 Jun 2017 13:11:31 -0400
Received: by mail-lf0-x243.google.com with SMTP id g21so5697250lfk.1
	for <qemu-devel@nongnu.org>; Sun, 25 Jun 2017 10:11:29 -0700 (PDT)
From: Aleksandr Bezzubikov <zuban32s@gmail.com>
Date: Sun, 25 Jun 2017 20:10:59 +0300
Message-Id: <1498410660-15762-1-git-send-email-zuban32s@gmail.com>
Subject: [Qemu-devel] [PATCH RFC] Generic PCIE-to-PCI Bridge
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, marcel@redhat.com, imammedo@redhat.com, Aleksandr Bezzubikov <zuban32s@gmail.com>

This patch introduces a new device - generic PCI Express to PCI bridge.

Now only x86-specific DMI-to-PCI bridge can be used to enable 
usage of legacy PCI devices on Q35 machine. But this bridge isn't cross-platform 
and doesn't support hotplugging.
That's why we need a new generic cross-platform bridge device, which supports hotplugging.

This patch creates device only for static CLI usage, 
the next goal is to add ACPI hotplug support.  It will utilize 
in some way past Marcel's RFC series for Q35 ACPI PCI hotplug support 
https://lists.gnu.org/archive/html/qemu-devel/2016-05/msg05681.html, 
but will require dynamic ACPI code emission in case when the bridge was hotplugged itself.

Aleksandr Bezzubikov (1):
  hw/pci-bridge: implement pcie-pci-bridge device

 hw/pci-bridge/Makefile.objs     |   2 +-
 hw/pci-bridge/pcie_pci_bridge.c | 152 ++++++++++++++++++++++++++++++++++++++++
 include/hw/pci/pci.h            |   1 +
 3 files changed, 154 insertions(+), 1 deletion(-)
 create mode 100644 hw/pci-bridge/pcie_pci_bridge.c

-- 
2.7.4
