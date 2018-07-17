Received: from eggs.gnu.org ([2001:4830:134:3::10]:45380)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1ffOFQ-00078w-OG
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 07:34:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1ffOFN-0003gi-Ks
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 07:34:28 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38090 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1ffOFN-0003gV-Gw
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 07:34:25 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 195E283221
	for <qemu-devel@nongnu.org>; Tue, 17 Jul 2018 11:34:25 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Tue, 17 Jul 2018 13:33:46 +0200
Message-Id: <20180717113402.5510-10-quintela@redhat.com>
In-Reply-To: <20180717113402.5510-1-quintela@redhat.com>
References: <20180717113402.5510-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 09/25] check: Only test es1370 when it is
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
index c6156fe105..3d146310f0 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -226,8 +226,8 @@ check-qtest-pci-y += tests/nvme-test$(EXESUF)
 gcov-files-pci-y += hw/block/nvme.c
 check-qtest-pci-y += tests/ac97-test$(EXESUF)
 gcov-files-pci-y += hw/audio/ac97.c
-check-qtest-pci-y += tests/es1370-test$(EXESUF)
-gcov-files-pci-y += hw/audio/es1370.c
+check-qtest-pci-$(CONFIG_ES1370) += tests/es1370-test$(EXESUF)
+gcov-files-pci-$(CONFIG_ES1370) += hw/audio/es1370.c
 check-qtest-pci-y += $(check-qtest-virtio-y)
 gcov-files-pci-y += $(gcov-files-virtio-y) hw/virtio/virtio-pci.c
 check-qtest-pci-y += tests/tpci200-test$(EXESUF)
-- 
2.17.1
