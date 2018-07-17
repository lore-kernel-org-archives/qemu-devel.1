Received: from eggs.gnu.org ([2001:4830:134:3::10]:45487)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1ffOFa-0007He-Us
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 07:34:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1ffOFV-0003q8-WB
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 07:34:38 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36688 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1ffOFV-0003pv-RV
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 07:34:33 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6F92A401EF05
	for <qemu-devel@nongnu.org>; Tue, 17 Jul 2018 11:34:33 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Tue, 17 Jul 2018 13:33:50 +0200
Message-Id: <20180717113402.5510-14-quintela@redhat.com>
In-Reply-To: <20180717113402.5510-1-quintela@redhat.com>
References: <20180717113402.5510-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 13/25] check: Only test isa-testdev when it is
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
 tests/Makefile.include | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 5a3943c81c..a56d423303 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -248,7 +248,7 @@ gcov-files-pci-y += hw/misc/ivshmem.c
 check-qtest-pci-y += tests/megasas-test$(EXESUF)
 gcov-files-pci-y += hw/scsi/megasas.c
 
-check-qtest-i386-y = tests/endianness-test$(EXESUF)
+check-qtest-i386-$(CONFIG_ISA_TESTDEV) = tests/endianness-test$(EXESUF)
 check-qtest-i386-y += tests/fdc-test$(EXESUF)
 gcov-files-i386-y = hw/block/fdc.c
 check-qtest-i386-y += tests/ide-test$(EXESUF)
@@ -319,15 +319,15 @@ check-qtest-m68k-y = tests/boot-serial-test$(EXESUF)
 
 check-qtest-microblaze-y = tests/boot-serial-test$(EXESUF)
 
-check-qtest-mips-y = tests/endianness-test$(EXESUF)
+check-qtest-mips-$(CONFIG_ISA_TESTDEV) = tests/endianness-test$(EXESUF)
 
-check-qtest-mips64-y = tests/endianness-test$(EXESUF)
+check-qtest-mips64-$(CONFIG_ISA_TESTDEV) = tests/endianness-test$(EXESUF)
 
-check-qtest-mips64el-y = tests/endianness-test$(EXESUF)
+check-qtest-mips64el-$(CONFIG_ISA_TESTDEV) = tests/endianness-test$(EXESUF)
 
-check-qtest-moxie-y = tests/boot-serial-test$(EXESUF)
+check-qtest-moxie-$(CONFIG_ISA_TESTDEV) = tests/boot-serial-test$(EXESUF)
 
-check-qtest-ppc-y = tests/endianness-test$(EXESUF)
+check-qtest-ppc-$(CONFIG_ISA_TESTDEV) = tests/endianness-test$(EXESUF)
 check-qtest-ppc-y += tests/boot-order-test$(EXESUF)
 check-qtest-ppc-y += tests/prom-env-test$(EXESUF)
 check-qtest-ppc-y += tests/drive_del-test$(EXESUF)
@@ -358,16 +358,16 @@ check-qtest-ppc64-y += tests/numa-test$(EXESUF)
 check-qtest-ppc64-$(CONFIG_IVSHMEM) += tests/ivshmem-test$(EXESUF)
 check-qtest-ppc64-y += tests/cpu-plug-test$(EXESUF)
 
-check-qtest-sh4-y = tests/endianness-test$(EXESUF)
+check-qtest-sh4-$(CONFIG_ISA_TESTDEV) = tests/endianness-test$(EXESUF)
 
-check-qtest-sh4eb-y = tests/endianness-test$(EXESUF)
+check-qtest-sh4eb-$(CONFIG_ISA_TESTDEV) = tests/endianness-test$(EXESUF)
 
 check-qtest-sparc-y = tests/prom-env-test$(EXESUF)
 check-qtest-sparc-y += tests/m48t59-test$(EXESUF)
 gcov-files-sparc-y = hw/timer/m48t59.c
 check-qtest-sparc-y += tests/boot-serial-test$(EXESUF)
 
-check-qtest-sparc64-y = tests/endianness-test$(EXESUF)
+check-qtest-sparc64-$(CONFIG_ISA_TESTDEV) = tests/endianness-test$(EXESUF)
 check-qtest-sparc64-y += tests/prom-env-test$(EXESUF)
 check-qtest-sparc64-y += tests/boot-serial-test$(EXESUF)
 
-- 
2.17.1
