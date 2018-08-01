Received: from eggs.gnu.org ([2001:4830:134:3::10]:32831)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fkp13-0008W7-Nw
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 07:10:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fkp12-0006Z2-Is
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 07:10:05 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51630 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fkp12-0006Ys-Dk
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 07:10:04 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 121AE7DAC7
	for <qemu-devel@nongnu.org>; Wed,  1 Aug 2018 11:10:04 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed,  1 Aug 2018 13:09:38 +0200
Message-Id: <20180801110952.5590-5-quintela@redhat.com>
In-Reply-To: <20180801110952.5590-1-quintela@redhat.com>
References: <20180801110952.5590-1-quintela@redhat.com>
Subject: [Qemu-devel] [[PATH for 3.1] v2 04/18] check: Only test pcnet when
 it is compiled in
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
 tests/Makefile.include | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 8cf2c15daf..f234a68345 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -217,9 +217,9 @@ check-qtest-pci-y += tests/e1000e-test$(EXESUF)
 gcov-files-pci-y += hw/net/e1000e.c hw/net/e1000e_core.c
 check-qtest-pci-y += tests/rtl8139-test$(EXESUF)
 gcov-files-pci-y += hw/net/rtl8139.c
-check-qtest-pci-y += tests/pcnet-test$(EXESUF)
-gcov-files-pci-y += hw/net/pcnet.c
-gcov-files-pci-y += hw/net/pcnet-pci.c
+check-qtest-pci-$(CONFIG_PCNET_PCI) += tests/pcnet-test$(EXESUF)
+gcov-files-pci-$(CONFIG_PCNET_PCI) += hw/net/pcnet.c
+gcov-files-pci-$(CONFIG_PCNET_PCI) += hw/net/pcnet-pci.c
 check-qtest-pci-$(CONFIG_EEPRO100_PCI) += tests/eepro100-test$(EXESUF)
 gcov-files-pci-$(CONFIG_EEPRO100_PCI) += hw/net/eepro100.c
 check-qtest-pci-$(CONFIG_NE2000_PCI) += tests/ne2000-test$(EXESUF)
-- 
2.17.1
