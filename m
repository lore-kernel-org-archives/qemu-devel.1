Received: from eggs.gnu.org ([2001:4830:134:3::10]:33958)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fsPqa-0007al-Jo
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 05:54:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fsPqZ-0004rm-OA
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 05:54:40 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39750 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fsPqZ-0004rT-Ih
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 05:54:39 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3EB3A8076894
	for <qemu-devel@nongnu.org>; Wed, 22 Aug 2018 09:54:39 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 22 Aug 2018 11:54:17 +0200
Message-Id: <20180822095421.11765-7-quintela@redhat.com>
In-Reply-To: <20180822095421.11765-1-quintela@redhat.com>
References: <20180822095421.11765-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH v3 06/10] check: Only test ivshm when it is
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
 tests/Makefile.include | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 9a918f7655..116e93cdb6 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -243,8 +243,8 @@ gcov-files-pci-y += hw/display/virtio-gpu-pci.c
 gcov-files-pci-$(CONFIG_VIRTIO_VGA) += hw/display/virtio-vga.c
 check-qtest-pci-$(CONFIG_HDA) += tests/intel-hda-test$(EXESUF)
 gcov-files-pci-$(CONFIG_HDA) += hw/audio/intel-hda.c hw/audio/hda-codec.c
-check-qtest-pci-$(CONFIG_IVSHMEM) += tests/ivshmem-test$(EXESUF)
-gcov-files-pci-y += hw/misc/ivshmem.c
+check-qtest-pci-$(CONFIG_IVSHMEM_DEVICE) += tests/ivshmem-test$(EXESUF)
+gcov-files-pci-$(CONFIG_IVSHMEM_DEVICE) += hw/misc/ivshmem.c
 check-qtest-pci-y += tests/megasas-test$(EXESUF)
 gcov-files-pci-y += hw/scsi/megasas.c
 
@@ -358,7 +358,7 @@ check-qtest-ppc64-$(CONFIG_POSIX) += tests/test-filter-mirror$(EXESUF)
 check-qtest-ppc64-$(CONFIG_RTL8139_PCI) += tests/test-filter-redirector$(EXESUF)
 check-qtest-ppc64-y += tests/display-vga-test$(EXESUF)
 check-qtest-ppc64-y += tests/numa-test$(EXESUF)
-check-qtest-ppc64-$(CONFIG_IVSHMEM) += tests/ivshmem-test$(EXESUF)
+check-qtest-ppc64-$(CONFIG_IVSHMEM_DEVICE) += tests/ivshmem-test$(EXESUF)
 check-qtest-ppc64-y += tests/cpu-plug-test$(EXESUF)
 
 check-qtest-sh4-$(CONFIG_ISA_TESTDEV) = tests/endianness-test$(EXESUF)
-- 
2.17.1
