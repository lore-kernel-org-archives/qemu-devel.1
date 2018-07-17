Received: from eggs.gnu.org ([2001:4830:134:3::10]:45560)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1ffOFg-0007NM-7j
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 07:34:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1ffOFf-0003z6-HN
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 07:34:44 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36708 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1ffOFf-0003y3-74
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 07:34:43 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C6607401EF15
	for <qemu-devel@nongnu.org>; Tue, 17 Jul 2018 11:34:42 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Tue, 17 Jul 2018 13:33:57 +0200
Message-Id: <20180717113402.5510-21-quintela@redhat.com>
In-Reply-To: <20180717113402.5510-1-quintela@redhat.com>
References: <20180717113402.5510-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 20/25] check: Only test usb-xhci-nec when it is
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
---
 tests/Makefile.include | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index b3e707e8c3..ccf71bddcc 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -288,8 +288,8 @@ check-qtest-i386-y += tests/usb-hcd-ehci-test$(EXESUF)
 gcov-files-i386-y += hw/usb/hcd-ehci.c
 gcov-files-i386-y += hw/usb/dev-hid.c
 gcov-files-i386-y += hw/usb/dev-storage.c
-check-qtest-i386-y += tests/usb-hcd-xhci-test$(EXESUF)
-gcov-files-i386-y += hw/usb/hcd-xhci.c
+check-qtest-i386-$(CONFIG_USB_XHCI_NEC) += tests/usb-hcd-xhci-test$(EXESUF)
+gcov-files-i386-$(CONFIG_USB_XHCI) += hw/usb/hcd-xhci.c
 check-qtest-i386-y += tests/cpu-plug-test$(EXESUF)
 check-qtest-i386-y += tests/q35-test$(EXESUF)
 check-qtest-i386-y += tests/vmgenid-test$(EXESUF)
@@ -347,8 +347,8 @@ check-qtest-ppc64-y += tests/usb-hcd-ohci-test$(EXESUF)
 gcov-files-ppc64-y += hw/usb/hcd-ohci.c
 check-qtest-ppc64-y += tests/usb-hcd-uhci-test$(EXESUF)
 gcov-files-ppc64-y += hw/usb/hcd-uhci.c
-check-qtest-ppc64-y += tests/usb-hcd-xhci-test$(EXESUF)
-gcov-files-ppc64-y += hw/usb/hcd-xhci.c
+check-qtest-ppc64-$(CONFIG_USB_XHCI_NEC) += tests/usb-hcd-xhci-test$(EXESUF)
+gcov-files-ppc64-$(CONFIG_USB_XHCI) += hw/usb/hcd-xhci.c
 check-qtest-ppc64-y += $(check-qtest-virtio-y)
 check-qtest-ppc64-$(CONFIG_SLIRP) += tests/test-netfilter$(EXESUF)
 check-qtest-ppc64-$(CONFIG_POSIX) += tests/test-filter-mirror$(EXESUF)
-- 
2.17.1
