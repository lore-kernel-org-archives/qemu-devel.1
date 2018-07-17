Received: from eggs.gnu.org ([2001:4830:134:3::10]:45441)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1ffOFT-0007C5-St
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 07:34:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1ffOFT-0003n1-8F
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 07:34:31 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37112 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1ffOFT-0003mE-4j
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 07:34:31 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BAE6B81A4EBC
	for <qemu-devel@nongnu.org>; Tue, 17 Jul 2018 11:34:30 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Tue, 17 Jul 2018 13:33:49 +0200
Message-Id: <20180717113402.5510-13-quintela@redhat.com>
In-Reply-To: <20180717113402.5510-1-quintela@redhat.com>
References: <20180717113402.5510-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 12/25] check: Only test ipack when it is
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
index 691f853ab6..5a3943c81c 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -230,10 +230,10 @@ check-qtest-pci-$(CONFIG_ES1370) += tests/es1370-test$(EXESUF)
 gcov-files-pci-$(CONFIG_ES1370) += hw/audio/es1370.c
 check-qtest-pci-y += $(check-qtest-virtio-y)
 gcov-files-pci-y += $(gcov-files-virtio-y) hw/virtio/virtio-pci.c
-check-qtest-pci-y += tests/tpci200-test$(EXESUF)
-gcov-files-pci-y += hw/ipack/tpci200.c
-check-qtest-pci-y += $(check-qtest-ipack-y)
-gcov-files-pci-y += $(gcov-files-ipack-y)
+check-qtest-pci-$(CONFIG_IPACK) += tests/tpci200-test$(EXESUF)
+gcov-files-pci-$(CONFIG_IPACK) += hw/ipack/tpci200.c
+check-qtest-pci-$(CONFIG_IPACK) += $(check-qtest-ipack-y)
+gcov-files-pci-$(CONFIG_IPACK) += $(gcov-files-ipack-y)
 check-qtest-pci-y += tests/display-vga-test$(EXESUF)
 gcov-files-pci-y += hw/display/vga.c
 gcov-files-pci-y += hw/display/cirrus_vga.c
-- 
2.17.1
