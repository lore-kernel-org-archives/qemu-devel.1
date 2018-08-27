Received: from eggs.gnu.org ([2001:4830:134:3::10]:47537)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fuEOK-0001Xs-Uz
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 06:05:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fuEOH-0005HC-8R
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 06:05:00 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57746 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fuEOH-0005GU-3v
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 06:04:57 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C7F9C40201BE
	for <qemu-devel@nongnu.org>; Mon, 27 Aug 2018 10:04:56 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Mon, 27 Aug 2018 12:04:29 +0200
Message-Id: <20180827100431.7915-8-quintela@redhat.com>
In-Reply-To: <20180827100431.7915-1-quintela@redhat.com>
References: <20180827100431.7915-1-quintela@redhat.com>
Subject: [Qemu-devel] [PULL 7/9] check: Move VMXNET3 test to common
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

We protect it with CONFIG_VMXNET3_PCI now, so no need to also put it
on i386.

Signed-off-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 tests/Makefile.include | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index d0c0a92e67..e5eb5140d8 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -255,6 +255,8 @@ check-qtest-pci-$(CONFIG_IVSHMEM_DEVICE) += tests/ivshmem-test$(EXESUF)
 gcov-files-pci-$(CONFIG_IVSHMEM_DEVICE) += hw/misc/ivshmem.c
 check-qtest-pci-y += tests/megasas-test$(EXESUF)
 gcov-files-pci-y += hw/scsi/megasas.c
+check-qtest-$(CONFIG_VMXNET3_PCI) += tests/vmxnet3-test$(EXESUF)
+gcov-files-$(CONFIG_VMXNET3_PCI) += hw/net/vmxnet3.c
 
 check-qtest-i386-$(CONFIG_ISA_TESTDEV) = tests/endianness-test$(EXESUF)
 check-qtest-i386-y += tests/fdc-test$(EXESUF)
@@ -278,8 +280,6 @@ gcov-files-i386-$(CONFIG_WDT_IB700) += hw/watchdog/watchdog.c hw/watchdog/wdt_ib
 check-qtest-i386-y += tests/tco-test$(EXESUF)
 check-qtest-i386-y += $(check-qtest-pci-y)
 gcov-files-i386-y += $(gcov-files-pci-y)
-check-qtest-i386-$(CONFIG_VMXNET3_PCI) += tests/vmxnet3-test$(EXESUF)
-gcov-files-i386-$(CONFIG_VMXNET3_PCI) += hw/net/vmxnet3.c
 gcov-files-i386-y += hw/net/net_rx_pkt.c
 gcov-files-i386-y += hw/net/net_tx_pkt.c
 check-qtest-i386-$(CONFIG_PVPANIC) += tests/pvpanic-test$(EXESUF)
-- 
2.17.1
