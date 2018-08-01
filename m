Received: from eggs.gnu.org ([2001:4830:134:3::10]:32798)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fkp12-0008Vr-IN
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 07:10:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fkp0z-0006YZ-TK
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 07:10:04 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49094 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fkp0z-0006YV-Oh
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 07:10:01 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 50C8640201BE
	for <qemu-devel@nongnu.org>; Wed,  1 Aug 2018 11:10:01 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed,  1 Aug 2018 13:09:36 +0200
Message-Id: <20180801110952.5590-3-quintela@redhat.com>
In-Reply-To: <20180801110952.5590-1-quintela@redhat.com>
References: <20180801110952.5590-1-quintela@redhat.com>
Subject: [Qemu-devel] [[PATH for 3.1] v2 02/18] check: Only test ne2000 when
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
 tests/Makefile.include | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 11c1463b99..258963810b 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -222,8 +222,8 @@ gcov-files-pci-y += hw/net/pcnet.c
 gcov-files-pci-y += hw/net/pcnet-pci.c
 check-qtest-pci-y += tests/eepro100-test$(EXESUF)
 gcov-files-pci-y += hw/net/eepro100.c
-check-qtest-pci-y += tests/ne2000-test$(EXESUF)
-gcov-files-pci-y += hw/net/ne2000.c
+check-qtest-pci-$(CONFIG_NE2000_PCI) += tests/ne2000-test$(EXESUF)
+gcov-files-pci-$(CONFIG_NE2000_PCI) += hw/net/ne2000.c
 check-qtest-pci-y += tests/nvme-test$(EXESUF)
 gcov-files-pci-y += hw/block/nvme.c
 check-qtest-pci-y += tests/ac97-test$(EXESUF)
-- 
2.17.1
