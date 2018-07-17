Received: from eggs.gnu.org ([2001:4830:134:3::10]:45310)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1ffOFK-00072m-B9
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 07:34:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1ffOFJ-0003Xn-Is
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 07:34:22 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:32794 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1ffOFJ-0003Wi-Er
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 07:34:21 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 182FD7D84D
	for <qemu-devel@nongnu.org>; Tue, 17 Jul 2018 11:34:21 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Tue, 17 Jul 2018 13:33:43 +0200
Message-Id: <20180717113402.5510-7-quintela@redhat.com>
In-Reply-To: <20180717113402.5510-1-quintela@redhat.com>
References: <20180717113402.5510-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 06/25] check: Only test eepro100 when it is
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
 tests/Makefile.include | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index ae77d26932..560f486416 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -218,8 +218,8 @@ gcov-files-pci-y += hw/net/rtl8139.c
 check-qtest-pci-y += tests/pcnet-test$(EXESUF)
 gcov-files-pci-y += hw/net/pcnet.c
 gcov-files-pci-y += hw/net/pcnet-pci.c
-check-qtest-pci-y += tests/eepro100-test$(EXESUF)
-gcov-files-pci-y += hw/net/eepro100.c
+check-qtest-pci-$(CONFIG_EEPRO100_PCI) += tests/eepro100-test$(EXESUF)
+gcov-files-pci-$(CONFIG_EEPRO100_PCI) += hw/net/eepro100.c
 check-qtest-pci-$(CONFIG_NE2000_PCI) += tests/ne2000-test$(EXESUF)
 gcov-files-pci-$(CONFIG_NE2000_PCI) += hw/net/ne2000.c
 check-qtest-pci-y += tests/nvme-test$(EXESUF)
-- 
2.17.1
