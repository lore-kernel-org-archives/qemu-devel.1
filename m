Received: from eggs.gnu.org ([2001:4830:134:3::10]:32993)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fkp1I-0000Mq-BD
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 07:10:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fkp1H-0006ks-Eu
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 07:10:20 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39390 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fkp1H-0006kd-9s
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 07:10:19 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DF4528182D38
	for <qemu-devel@nongnu.org>; Wed,  1 Aug 2018 11:10:18 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed,  1 Aug 2018 13:09:49 +0200
Message-Id: <20180801110952.5590-16-quintela@redhat.com>
In-Reply-To: <20180801110952.5590-1-quintela@redhat.com>
References: <20180801110952.5590-1-quintela@redhat.com>
Subject: [Qemu-devel] [[PATH for 3.1] v2 15/18] check: Only test nvme when
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
index b9fb80b461..2642500659 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -224,8 +224,8 @@ check-qtest-pci-$(CONFIG_EEPRO100_PCI) += tests/eepro100-test$(EXESUF)
 gcov-files-pci-$(CONFIG_EEPRO100_PCI) += hw/net/eepro100.c
 check-qtest-pci-$(CONFIG_NE2000_PCI) += tests/ne2000-test$(EXESUF)
 gcov-files-pci-$(CONFIG_NE2000_PCI) += hw/net/ne2000.c
-check-qtest-pci-y += tests/nvme-test$(EXESUF)
-gcov-files-pci-y += hw/block/nvme.c
+check-qtest-pci-$(CONFIG_NVME_PCI) += tests/nvme-test$(EXESUF)
+gcov-files-pci-$(CONFIG_NVME_PCI) += hw/block/nvme.c
 check-qtest-pci-$(CONFIG_AC97) += tests/ac97-test$(EXESUF)
 gcov-files-pci-$(CONFIG_AC97) += hw/audio/ac97.c
 check-qtest-pci-$(CONFIG_ES1370) += tests/es1370-test$(EXESUF)
-- 
2.17.1
