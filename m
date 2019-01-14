Received: from eggs.gnu.org ([209.51.188.92]:44761)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1giz4t-0005b2-OG
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 05:02:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1giz4n-0007Rz-5L
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 05:02:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47478)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1giz4m-0007QU-Vx
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 05:02:37 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Mon, 14 Jan 2019 11:02:01 +0100
Message-Id: <1547460140-1473-7-git-send-email-thuth@redhat.com>
In-Reply-To: <1547460140-1473-1-git-send-email-thuth@redhat.com>
References: <1547460140-1473-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PULL 06/25] tests/Makefile: Use some more CONFIG
 switches for ppc tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Li Qiang <liq3ea@163.com>

To be able to build and test QEMU binaries where certain devices or machines
are disabled, we have to use the right CONFIG_* switches to run certain tests
only if the corresponding device or machine really has been compiled into
the binary.

Reviewed-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/Makefile.include | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 462b5e0..476b943 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -242,22 +242,22 @@ check-qtest-ppc-y += tests/boot-order-test$(EXESUF)
 check-qtest-ppc-y += tests/prom-env-test$(EXESUF)
 check-qtest-ppc-y += tests/drive_del-test$(EXESUF)
 check-qtest-ppc-y += tests/boot-serial-test$(EXESUF)
-check-qtest-ppc-y += tests/m48t59-test$(EXESUF)
+check-qtest-ppc-$(CONFIG_M48T59) += tests/m48t59-test$(EXESUF)
 
 check-qtest-ppc64-y += $(check-qtest-ppc-y)
-check-qtest-ppc64-y += tests/spapr-phb-test$(EXESUF)
-check-qtest-ppc64-y += tests/pnv-xscom-test$(EXESUF)
+check-qtest-ppc64-$(CONFIG_PSERIES) += tests/spapr-phb-test$(EXESUF)
+check-qtest-ppc64-$(CONFIG_POWERNV) += tests/pnv-xscom-test$(EXESUF)
 check-qtest-ppc64-y += tests/migration-test$(EXESUF)
-check-qtest-ppc64-y += tests/rtas-test$(EXESUF)
+check-qtest-ppc64-$(CONFIG_PSERIES) += tests/rtas-test$(EXESUF)
 check-qtest-ppc64-$(CONFIG_SLIRP) += tests/pxe-test$(EXESUF)
 check-qtest-ppc64-$(CONFIG_USB_OHCI) += tests/usb-hcd-ohci-test$(EXESUF)
 check-qtest-ppc64-$(CONFIG_USB_UHCI) += tests/usb-hcd-uhci-test$(EXESUF)
 check-qtest-ppc64-$(CONFIG_USB_XHCI_NEC) += tests/usb-hcd-xhci-test$(EXESUF)
-check-qtest-ppc64-y += $(check-qtest-virtio-y)
+check-qtest-ppc64-$(CONFIG_VIRTIO) += $(check-qtest-virtio-y)
 check-qtest-ppc64-$(CONFIG_SLIRP) += tests/test-netfilter$(EXESUF)
 check-qtest-ppc64-$(CONFIG_POSIX) += tests/test-filter-mirror$(EXESUF)
 check-qtest-ppc64-$(CONFIG_RTL8139_PCI) += tests/test-filter-redirector$(EXESUF)
-check-qtest-ppc64-y += tests/display-vga-test$(EXESUF)
+check-qtest-ppc64-$(CONFIG_VGA) += tests/display-vga-test$(EXESUF)
 check-qtest-ppc64-y += tests/numa-test$(EXESUF)
 check-qtest-ppc64-$(CONFIG_IVSHMEM_DEVICE) += tests/ivshmem-test$(EXESUF)
 check-qtest-ppc64-y += tests/cpu-plug-test$(EXESUF)
-- 
1.8.3.1
