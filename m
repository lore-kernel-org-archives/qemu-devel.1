Received: from eggs.gnu.org ([2001:4830:134:3::10]:45396)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1ffOFR-00079Z-Bf
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 07:34:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1ffOFQ-0003kV-KH
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 07:34:29 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46382 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1ffOFQ-0003kI-Fq
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 07:34:28 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 18DCD400E9A3
	for <qemu-devel@nongnu.org>; Tue, 17 Jul 2018 11:34:28 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Tue, 17 Jul 2018 13:33:47 +0200
Message-Id: <20180717113402.5510-11-quintela@redhat.com>
In-Reply-To: <20180717113402.5510-1-quintela@redhat.com>
References: <20180717113402.5510-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 10/25] check: Only test ac97 when it is
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
index 3d146310f0..af395b5f22 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -224,8 +224,8 @@ check-qtest-pci-$(CONFIG_NE2000_PCI) += tests/ne2000-test$(EXESUF)
 gcov-files-pci-$(CONFIG_NE2000_PCI) += hw/net/ne2000.c
 check-qtest-pci-y += tests/nvme-test$(EXESUF)
 gcov-files-pci-y += hw/block/nvme.c
-check-qtest-pci-y += tests/ac97-test$(EXESUF)
-gcov-files-pci-y += hw/audio/ac97.c
+check-qtest-pci-$(CONFIG_AC97) += tests/ac97-test$(EXESUF)
+gcov-files-pci-$(CONFIG_AC97) += hw/audio/ac97.c
 check-qtest-pci-$(CONFIG_ES1370) += tests/es1370-test$(EXESUF)
 gcov-files-pci-$(CONFIG_ES1370) += hw/audio/es1370.c
 check-qtest-pci-y += $(check-qtest-virtio-y)
-- 
2.17.1
