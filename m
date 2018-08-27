Received: from eggs.gnu.org ([2001:4830:134:3::10]:47461)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fuEOA-0000lb-8Z
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 06:04:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fuEO9-00055D-3i
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 06:04:50 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59750 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fuEO8-00054z-VE
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 06:04:49 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A0A1F804BAAD
	for <qemu-devel@nongnu.org>; Mon, 27 Aug 2018 10:04:48 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Mon, 27 Aug 2018 12:04:25 +0200
Message-Id: <20180827100431.7915-4-quintela@redhat.com>
In-Reply-To: <20180827100431.7915-1-quintela@redhat.com>
References: <20180827100431.7915-1-quintela@redhat.com>
Subject: [Qemu-devel] [PULL 3/9] check: Only test usb-xhci-nec when it is
 compiled in
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

Signed-off-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 tests/Makefile.include | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index dee2f16e65..b4c3043dcc 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -298,8 +298,9 @@ endif
 gcov-files-i386-$(CONFIG_USB_EHCI) += hw/usb/hcd-ehci.c
 gcov-files-i386-y += hw/usb/dev-hid.c
 gcov-files-i386-y += hw/usb/dev-storage.c
-check-qtest-i386-y += tests/usb-hcd-xhci-test$(EXESUF)
-gcov-files-i386-y += hw/usb/hcd-xhci.c
+check-qtest-i386-$(CONFIG_USB_XHCI_NEC) += tests/usb-hcd-xhci-test$(EXESUF)
+gcov-files-i386-$(CONFIG_USB_XHCI) += hw/usb/hcd-xhci.c
+gcov-files-i386-$(CONFIG_USB_XHCI) += hw/usb/hcd-xhci-nec.c
 check-qtest-i386-y += tests/cpu-plug-test$(EXESUF)
 check-qtest-i386-y += tests/q35-test$(EXESUF)
 check-qtest-i386-y += tests/vmgenid-test$(EXESUF)
@@ -359,8 +360,9 @@ check-qtest-ppc64-$(CONFIG_USB_OHCI) += tests/usb-hcd-ohci-test$(EXESUF)
 gcov-files-ppc64-$(CONFIG_USB_OHCI) += hw/usb/hcd-ohci.c
 check-qtest-ppc64-$(CONFIG_USB_UHCI) += tests/usb-hcd-uhci-test$(EXESUF)
 gcov-files-ppc64-$(CONFIG_USB_UHCI) += hw/usb/hcd-uhci.c
-check-qtest-ppc64-y += tests/usb-hcd-xhci-test$(EXESUF)
-gcov-files-ppc64-y += hw/usb/hcd-xhci.c
+check-qtest-ppc64-$(CONFIG_USB_XHCI_NEC) += tests/usb-hcd-xhci-test$(EXESUF)
+gcov-files-ppc64-$(CONFIG_USB_XHCI) += hw/usb/hcd-xhci.c
+gcov-files-ppc64-$(CONFIG_USB_XHCI) += hw/usb/hcd-xhci-nec.c
 check-qtest-ppc64-y += $(check-qtest-virtio-y)
 check-qtest-ppc64-$(CONFIG_SLIRP) += tests/test-netfilter$(EXESUF)
 check-qtest-ppc64-$(CONFIG_POSIX) += tests/test-filter-mirror$(EXESUF)
-- 
2.17.1
