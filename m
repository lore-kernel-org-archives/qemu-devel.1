Received: from eggs.gnu.org ([2001:4830:134:3::10]:47503)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fuEOE-00015L-3F
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 06:04:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fuEOD-0005CM-8m
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 06:04:54 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38436 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fuEOD-0005Bk-3t
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 06:04:53 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C024C83221
	for <qemu-devel@nongnu.org>; Mon, 27 Aug 2018 10:04:52 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Mon, 27 Aug 2018 12:04:27 +0200
Message-Id: <20180827100431.7915-6-quintela@redhat.com>
In-Reply-To: <20180827100431.7915-1-quintela@redhat.com>
References: <20180827100431.7915-1-quintela@redhat.com>
Subject: [Qemu-devel] [PULL 5/9] check: Only test ivshm when it is compiled
 in
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
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 tests/Makefile.include | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index b4c3043dcc..9edfdbe56f 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -251,8 +251,8 @@ gcov-files-pci-y += hw/display/virtio-gpu-pci.c
 gcov-files-pci-$(CONFIG_VIRTIO_VGA) += hw/display/virtio-vga.c
 check-qtest-pci-$(CONFIG_HDA) += tests/intel-hda-test$(EXESUF)
 gcov-files-pci-$(CONFIG_HDA) += hw/audio/intel-hda.c hw/audio/hda-codec.c
-check-qtest-pci-$(CONFIG_IVSHMEM) += tests/ivshmem-test$(EXESUF)
-gcov-files-pci-y += hw/misc/ivshmem.c
+check-qtest-pci-$(CONFIG_IVSHMEM_DEVICE) += tests/ivshmem-test$(EXESUF)
+gcov-files-pci-$(CONFIG_IVSHMEM_DEVICE) += hw/misc/ivshmem.c
 check-qtest-pci-y += tests/megasas-test$(EXESUF)
 gcov-files-pci-y += hw/scsi/megasas.c
 
@@ -369,7 +369,8 @@ check-qtest-ppc64-$(CONFIG_POSIX) += tests/test-filter-mirror$(EXESUF)
 check-qtest-ppc64-$(CONFIG_RTL8139_PCI) += tests/test-filter-redirector$(EXESUF)
 check-qtest-ppc64-y += tests/display-vga-test$(EXESUF)
 check-qtest-ppc64-y += tests/numa-test$(EXESUF)
-check-qtest-ppc64-$(CONFIG_IVSHMEM) += tests/ivshmem-test$(EXESUF)
+check-qtest-ppc64-$(CONFIG_IVSHMEM_DEVICE) += tests/ivshmem-test$(EXESUF)
+gcov-files-ppc64-$(CONFIG_IVSHMEM_DEVICE) += hw/misc/ivshmem.c
 check-qtest-ppc64-y += tests/cpu-plug-test$(EXESUF)
 
 check-qtest-sh4-$(CONFIG_ISA_TESTDEV) = tests/endianness-test$(EXESUF)
-- 
2.17.1
