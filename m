Received: from eggs.gnu.org ([2001:4830:134:3::10]:35820)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fsOBh-00035r-77
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 04:08:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fsOBf-0007py-UA
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 04:08:20 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39634 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fsOBb-0007kJ-1H
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 04:08:17 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2B32A5938
	for <qemu-devel@nongnu.org>; Wed, 22 Aug 2018 08:08:13 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 22 Aug 2018 10:07:41 +0200
Message-Id: <20180822080751.11307-10-quintela@redhat.com>
In-Reply-To: <20180822080751.11307-1-quintela@redhat.com>
References: <20180822080751.11307-1-quintela@redhat.com>
Subject: [Qemu-devel] [PULL 09/19] check: Only test ipack when it is
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
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 tests/Makefile.include | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index ff8534056a..7d13966055 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -232,10 +232,10 @@ check-qtest-pci-$(CONFIG_ES1370) += tests/es1370-test$(EXESUF)
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
