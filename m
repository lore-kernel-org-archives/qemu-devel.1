Received: from eggs.gnu.org ([2001:4830:134:3::10]:32930)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fkp1E-0000JD-Bl
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 07:10:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fkp1D-0006hE-Bw
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 07:10:16 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49104 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fkp1D-0006h7-7b
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 07:10:15 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D6373402243B
	for <qemu-devel@nongnu.org>; Wed,  1 Aug 2018 11:10:14 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed,  1 Aug 2018 13:09:46 +0200
Message-Id: <20180801110952.5590-13-quintela@redhat.com>
In-Reply-To: <20180801110952.5590-1-quintela@redhat.com>
References: <20180801110952.5590-1-quintela@redhat.com>
Subject: [Qemu-devel] [[PATH for 3.1] v2 12/18] check: Only test sdhci when
 it is compiled in
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
 tests/Makefile.include | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index c9768086be..42f09dbfdf 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -311,7 +311,7 @@ check-qtest-i386-y += tests/migration-test$(EXESUF)
 check-qtest-i386-y += tests/test-x86-cpuid-compat$(EXESUF)
 check-qtest-i386-y += tests/numa-test$(EXESUF)
 check-qtest-x86_64-y += $(check-qtest-i386-y)
-check-qtest-x86_64-y += tests/sdhci-test$(EXESUF)
+check-qtest-x86_64-$(CONFIG_SDHCI) += tests/sdhci-test$(EXESUF)
 gcov-files-i386-y += i386-softmmu/hw/timer/mc146818rtc.c
 gcov-files-x86_64-y = $(subst i386-softmmu/,x86_64-softmmu/,$(gcov-files-i386-y))
 
@@ -385,10 +385,10 @@ gcov-files-arm-y += arm-softmmu/hw/block/virtio-blk.c
 check-qtest-arm-y += tests/test-arm-mptimer$(EXESUF)
 gcov-files-arm-y += hw/timer/arm_mptimer.c
 check-qtest-arm-y += tests/boot-serial-test$(EXESUF)
-check-qtest-arm-y += tests/sdhci-test$(EXESUF)
+check-qtest-arm-$(CONFIG_SDHCI) += tests/sdhci-test$(EXESUF)
 
 check-qtest-aarch64-y = tests/numa-test$(EXESUF)
-check-qtest-aarch64-y += tests/sdhci-test$(EXESUF)
+check-qtest-aarch64-$(CONFIG_SDHCI) += tests/sdhci-test$(EXESUF)
 check-qtest-aarch64-y += tests/boot-serial-test$(EXESUF)
 
 check-qtest-microblazeel-y = $(check-qtest-microblaze-y)
-- 
2.17.1
