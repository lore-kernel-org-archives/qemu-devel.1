Received: from eggs.gnu.org ([209.51.188.92]:59449)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1glqId-0007UT-9D
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 02:16:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1glqIc-0002ZP-EL
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 02:16:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35742)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1glqIc-0002UH-8R
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 02:16:42 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Tue, 22 Jan 2019 08:08:34 +0100
Message-Id: <1548140916-6923-2-git-send-email-thuth@redhat.com>
In-Reply-To: <1548140916-6923-1-git-send-email-thuth@redhat.com>
References: <1548140916-6923-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PULL v4 01/26] tests/Makefile: Use some more CONFIG
 switches for x86 tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

To be able to build and test QEMU binaries where certain devices are
disabled, we have to use the right CONFIG_* switches to run certain
tests only if the corresponding device really has been compiled into
the binary.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/Makefile.include | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 5e6b2c7..64478b5 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -167,13 +167,13 @@ check-qtest-pci-$(CONFIG_NE2000_PCI) += tests/ne2000-test$(EXESUF)
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
@@ -185,9 +185,9 @@ check-qtest-i386-y += tests/bios-tables-test$(EXESUF)
 check-qtest-i386-$(CONFIG_SGA) += tests/boot-serial-test$(EXESUF)
 check-qtest-i386-$(CONFIG_SLIRP) += tests/pxe-test$(EXESUF)
 check-qtest-i386-y += tests/rtc-test$(EXESUF)
-check-qtest-i386-y += tests/ipmi-kcs-test$(EXESUF)
+check-qtest-i386-$(CONFIG_ISA_IPMI_KCS) += tests/ipmi-kcs-test$(EXESUF)
 # Disabled temporarily as it fails intermittently especially under NetBSD VM
-# check-qtest-i386-y += tests/ipmi-bt-test$(EXESUF)
+# check-qtest-i386-$(CONFIG_ISA_IPMI_BT) += tests/ipmi-bt-test$(EXESUF)
 check-qtest-i386-y += tests/i440fx-test$(EXESUF)
 check-qtest-i386-y += tests/fw_cfg-test$(EXESUF)
 check-qtest-i386-y += tests/drive_del-test$(EXESUF)
-- 
1.8.3.1
