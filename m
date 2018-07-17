Received: from eggs.gnu.org ([2001:4830:134:3::10]:45490)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1ffOFa-0007Hh-V0
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 07:34:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1ffOFY-0003ro-Jr
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 07:34:38 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36694 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1ffOFY-0003rS-Fo
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 07:34:36 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1F663401EF0B
	for <qemu-devel@nongnu.org>; Tue, 17 Jul 2018 11:34:36 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Tue, 17 Jul 2018 13:33:52 +0200
Message-Id: <20180717113402.5510-16-quintela@redhat.com>
In-Reply-To: <20180717113402.5510-1-quintela@redhat.com>
References: <20180717113402.5510-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 15/25] check: Only test i82801b11 when it is
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
index 3b555660bd..b0aa79909b 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -276,8 +276,8 @@ gcov-files-i386-y += hw/net/net_rx_pkt.c
 gcov-files-i386-y += hw/net/net_tx_pkt.c
 check-qtest-i386-y += tests/pvpanic-test$(EXESUF)
 gcov-files-i386-y += i386-softmmu/hw/misc/pvpanic.c
-check-qtest-i386-y += tests/i82801b11-test$(EXESUF)
-gcov-files-i386-y += hw/pci-bridge/i82801b11.c
+check-qtest-i386-$(CONFIG_I82801B11) += tests/i82801b11-test$(EXESUF)
+gcov-files-i386-$(CONFIG_I82801B11) += hw/pci-bridge/i82801b11.c
 check-qtest-i386-$(CONFIG_IOH3420) += tests/ioh3420-test$(EXESUF)
 gcov-files-i386-$(CONFIG_IOH3420) += hw/pci-bridge/ioh3420.c
 check-qtest-i386-y += tests/usb-hcd-ohci-test$(EXESUF)
-- 
2.17.1
