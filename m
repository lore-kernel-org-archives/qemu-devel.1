Received: from eggs.gnu.org ([2001:4830:134:3::10]:50754)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gSJW1-0005ll-PO
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 05:25:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gSJVx-0001NJ-S5
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 05:25:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42946)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gSJVx-0001Ly-KI
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 05:25:45 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CC2B4308219D
	for <qemu-devel@nongnu.org>; Thu, 29 Nov 2018 10:25:43 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
Date: Thu, 29 Nov 2018 11:25:39 +0100
Message-Id: <1543487139-28462-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH for-4.0] tests/Makefile: Use some more CONFIG
 switches for x86 tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, mrezanin@redhat.com, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

To be able to build and test QEMU binaries where certain devices are
disabled, we have to use the right CONFIG_* switches to run certain
tests only if the corresponding device really has been compiled into
the binary.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/Makefile.include | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index fb0b449..d87b403 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -165,13 +165,13 @@ check-qtest-pci-$(CONFIG_NE2000_PCI) += tests/ne2000-test$(EXESUF)
 check-qtest-pci-$(CONFIG_NVME_PCI) += tests/nvme-test$(EXESUF)
 check-qtest-pci-$(CONFIG_AC97) += tests/ac97-test$(EXESUF)
 check-qtest-pci-$(CONFIG_ES1370) += tests/es1370-test$(EXESUF)
-check-qtest-pci-y += $(check-qtest-virtio-y)
+check-qtest-pci-$(CONFIG_VIRTIO) += $(check-qtest-virtio-y)
 check-qtest-pci-$(CONFIG_IPACK) += tests/tpci200-test$(EXESUF)
 check-qtest-pci-$(CONFIG_IPACK) += $(check-qtest-ipack-y)
-check-qtest-pci-y += tests/display-vga-test$(EXESUF)
+check-qtest-pci-$(CONFIG_VGA) += tests/display-vga-test$(EXESUF)
 check-qtest-pci-$(CONFIG_HDA) += tests/intel-hda-test$(EXESUF)
 check-qtest-pci-$(CONFIG_IVSHMEM_DEVICE) += tests/ivshmem-test$(EXESUF)
-check-qtest-pci-y += tests/megasas-test$(EXESUF)
+check-qtest-pci-$(CONFIG_MEGASAS_SCSI_PCI) += tests/megasas-test$(EXESUF)
 
 check-qtest-i386-$(CONFIG_ISA_TESTDEV) = tests/endianness-test$(EXESUF)
 check-qtest-i386-y += tests/fdc-test$(EXESUF)
@@ -183,8 +183,8 @@ check-qtest-i386-y += tests/bios-tables-test$(EXESUF)
 check-qtest-i386-$(CONFIG_SGA) += tests/boot-serial-test$(EXESUF)
 check-qtest-i386-$(CONFIG_SLIRP) += tests/pxe-test$(EXESUF)
 check-qtest-i386-y += tests/rtc-test$(EXESUF)
-check-qtest-i386-y += tests/ipmi-kcs-test$(EXESUF)
-check-qtest-i386-y += tests/ipmi-bt-test$(EXESUF)
+check-qtest-i386-$(CONFIG_ISA_IPMI_KCS) += tests/ipmi-kcs-test$(EXESUF)
+check-qtest-i386-$(CONFIG_ISA_IPMI_BT) += tests/ipmi-bt-test$(EXESUF)
 check-qtest-i386-y += tests/i440fx-test$(EXESUF)
 check-qtest-i386-y += tests/fw_cfg-test$(EXESUF)
 check-qtest-i386-y += tests/drive_del-test$(EXESUF)
-- 
1.8.3.1
