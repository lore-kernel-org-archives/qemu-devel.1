Received: from eggs.gnu.org ([2001:4830:134:3::10]:33886)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fsPqV-0007YK-VG
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 05:54:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fsPqV-0004oL-0I
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 05:54:35 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38576 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fsPqU-0004nx-QH
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 05:54:34 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5FB9940241DC
	for <qemu-devel@nongnu.org>; Wed, 22 Aug 2018 09:54:34 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 22 Aug 2018 11:54:14 +0200
Message-Id: <20180822095421.11765-4-quintela@redhat.com>
In-Reply-To: <20180822095421.11765-1-quintela@redhat.com>
References: <20180822095421.11765-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH v3 03/10] check: Only test isa-testdev when it
 is compiled in
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

Once there, untangle endianness-test and boot-serial-test.

Signed-off-by: Juan Quintela <quintela@redhat.com>

--

boot-serial-test don't depend on isa-testdev.  Thanks Thomas.

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 tests/Makefile.include | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index a705793381..15296be246 100644
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
@@ -321,15 +321,15 @@ check-qtest-m68k-y = tests/boot-serial-test$(EXESUF)
 
 check-qtest-microblaze-y = tests/boot-serial-test$(EXESUF)
 
-check-qtest-mips-y = tests/endianness-test$(EXESUF)
-
-check-qtest-mips64-y = tests/endianness-test$(EXESUF)
-
-check-qtest-mips64el-y = tests/endianness-test$(EXESUF)
-
 check-qtest-moxie-y = tests/boot-serial-test$(EXESUF)
 
-check-qtest-ppc-y = tests/endianness-test$(EXESUF)
+check-qtest-mips-$(CONFIG_ISA_TESTDEV) = tests/endianness-test$(EXESUF)
+
+check-qtest-mips64-$(CONFIG_ISA_TESTDEV) = tests/endianness-test$(EXESUF)
+
+check-qtest-mips64el-$(CONFIG_ISA_TESTDEV) = tests/endianness-test$(EXESUF)
+
+check-qtest-ppc-$(CONFIG_ISA_TESTDEV) = tests/endianness-test$(EXESUF)
 check-qtest-ppc-y += tests/boot-order-test$(EXESUF)
 check-qtest-ppc-y += tests/prom-env-test$(EXESUF)
 check-qtest-ppc-y += tests/drive_del-test$(EXESUF)
@@ -360,16 +360,16 @@ check-qtest-ppc64-y += tests/numa-test$(EXESUF)
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
