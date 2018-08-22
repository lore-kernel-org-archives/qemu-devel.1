Received: from eggs.gnu.org ([2001:4830:134:3::10]:34009)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fsPqg-0007qv-Ne
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 05:54:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fsPqf-0004wU-SF
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 05:54:46 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38582 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fsPqf-0004vH-Jj
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 05:54:45 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4755640241DC
	for <qemu-devel@nongnu.org>; Wed, 22 Aug 2018 09:54:45 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 22 Aug 2018 11:54:20 +0200
Message-Id: <20180822095421.11765-10-quintela@redhat.com>
In-Reply-To: <20180822095421.11765-1-quintela@redhat.com>
References: <20180822095421.11765-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH v3 09/10] check: Move endianess test to common
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

It is already protected by CONFIG_ISA_TESTDEV in all architectures.

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 tests/Makefile.include | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 91ffde3103..f646cd0524 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -249,8 +249,8 @@ check-qtest-pci-y += tests/megasas-test$(EXESUF)
 gcov-files-pci-y += hw/scsi/megasas.c
 check-qtest-$(CONFIG_VMXNET3_PCI) += tests/vmxnet3-test$(EXESUF)
 gcov-files-$(CONFIG_VMXNET3_PCI) += hw/net/vmxnet3.c
+check-qtest-$(CONFIG_ISA_TESTDEV) = tests/endianness-test$(EXESUF)
 
-check-qtest-i386-$(CONFIG_ISA_TESTDEV) = tests/endianness-test$(EXESUF)
 check-qtest-i386-y += tests/fdc-test$(EXESUF)
 gcov-files-i386-y = hw/block/fdc.c
 check-qtest-i386-y += tests/ide-test$(EXESUF)
@@ -324,13 +324,6 @@ check-qtest-microblaze-y = tests/boot-serial-test$(EXESUF)
 
 check-qtest-moxie-y = tests/boot-serial-test$(EXESUF)
 
-check-qtest-mips-$(CONFIG_ISA_TESTDEV) = tests/endianness-test$(EXESUF)
-
-check-qtest-mips64-$(CONFIG_ISA_TESTDEV) = tests/endianness-test$(EXESUF)
-
-check-qtest-mips64el-$(CONFIG_ISA_TESTDEV) = tests/endianness-test$(EXESUF)
-
-check-qtest-ppc-$(CONFIG_ISA_TESTDEV) = tests/endianness-test$(EXESUF)
 check-qtest-ppc-y += tests/boot-order-test$(EXESUF)
 check-qtest-ppc-y += tests/prom-env-test$(EXESUF)
 check-qtest-ppc-y += tests/drive_del-test$(EXESUF)
@@ -361,16 +354,11 @@ check-qtest-ppc64-y += tests/numa-test$(EXESUF)
 check-qtest-ppc64-$(CONFIG_IVSHMEM_DEVICE) += tests/ivshmem-test$(EXESUF)
 check-qtest-ppc64-y += tests/cpu-plug-test$(EXESUF)
 
-check-qtest-sh4-$(CONFIG_ISA_TESTDEV) = tests/endianness-test$(EXESUF)
-
-check-qtest-sh4eb-$(CONFIG_ISA_TESTDEV) = tests/endianness-test$(EXESUF)
-
 check-qtest-sparc-y = tests/prom-env-test$(EXESUF)
 check-qtest-sparc-y += tests/m48t59-test$(EXESUF)
 gcov-files-sparc-y = hw/timer/m48t59.c
 check-qtest-sparc-y += tests/boot-serial-test$(EXESUF)
 
-check-qtest-sparc64-$(CONFIG_ISA_TESTDEV) = tests/endianness-test$(EXESUF)
 check-qtest-sparc64-y += tests/prom-env-test$(EXESUF)
 check-qtest-sparc64-y += tests/boot-serial-test$(EXESUF)
 
-- 
2.17.1
