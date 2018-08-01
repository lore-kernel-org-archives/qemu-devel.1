Received: from eggs.gnu.org ([2001:4830:134:3::10]:33005)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fkp1J-0000OL-Ml
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 07:10:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fkp1I-0006lV-On
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 07:10:21 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51640 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fkp1I-0006lJ-Jw
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 07:10:20 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 43DFA7DAC7
	for <qemu-devel@nongnu.org>; Wed,  1 Aug 2018 11:10:20 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed,  1 Aug 2018 13:09:50 +0200
Message-Id: <20180801110952.5590-17-quintela@redhat.com>
In-Reply-To: <20180801110952.5590-1-quintela@redhat.com>
References: <20180801110952.5590-1-quintela@redhat.com>
Subject: [Qemu-devel] [[PATH for 3.1] v2 16/18] check: Only test usb-ohci
 when it is compiled in
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
---
 tests/Makefile.include | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 2642500659..353f068f3b 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -282,8 +282,8 @@ check-qtest-i386-$(CONFIG_I82801B11) += tests/i82801b11-test$(EXESUF)
 gcov-files-i386-$(CONFIG_I82801B11) += hw/pci-bridge/i82801b11.c
 check-qtest-i386-$(CONFIG_IOH3420) += tests/ioh3420-test$(EXESUF)
 gcov-files-i386-$(CONFIG_IOH3420) += hw/pci-bridge/ioh3420.c
-check-qtest-i386-y += tests/usb-hcd-ohci-test$(EXESUF)
-gcov-files-i386-y += hw/usb/hcd-ohci.c
+check-qtest-i386-$(CONFIG_USB_OHCI) += tests/usb-hcd-ohci-test$(EXESUF)
+gcov-files-i386-$(CONFIG_USB_OHCI) += hw/usb/hcd-ohci.c
 check-qtest-i386-y += tests/usb-hcd-uhci-test$(EXESUF)
 gcov-files-i386-y += hw/usb/hcd-uhci.c
 check-qtest-i386-y += tests/usb-hcd-ehci-test$(EXESUF)
@@ -347,8 +347,8 @@ check-qtest-ppc64-y += tests/pnv-xscom-test$(EXESUF)
 check-qtest-ppc64-y += tests/migration-test$(EXESUF)
 check-qtest-ppc64-y += tests/rtas-test$(EXESUF)
 check-qtest-ppc64-$(CONFIG_SLIRP) += tests/pxe-test$(EXESUF)
-check-qtest-ppc64-y += tests/usb-hcd-ohci-test$(EXESUF)
-gcov-files-ppc64-y += hw/usb/hcd-ohci.c
+check-qtest-ppc64-$(CONFIG_USB_OHCI) += tests/usb-hcd-ohci-test$(EXESUF)
+gcov-files-ppc64-$(CONFIG_USB_OHCI) += hw/usb/hcd-ohci.c
 check-qtest-ppc64-y += tests/usb-hcd-uhci-test$(EXESUF)
 gcov-files-ppc64-y += hw/usb/hcd-uhci.c
 check-qtest-ppc64-y += tests/usb-hcd-xhci-test$(EXESUF)
-- 
2.17.1
