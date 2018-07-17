Received: from eggs.gnu.org ([2001:4830:134:3::10]:45489)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1ffOFa-0007Hg-Ux
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 07:34:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1ffOFZ-0003sY-VU
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 07:34:38 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46386 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1ffOFZ-0003sG-Ri
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 07:34:37 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6F5E9400E9A3
	for <qemu-devel@nongnu.org>; Tue, 17 Jul 2018 11:34:37 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Tue, 17 Jul 2018 13:33:53 +0200
Message-Id: <20180717113402.5510-17-quintela@redhat.com>
In-Reply-To: <20180717113402.5510-1-quintela@redhat.com>
References: <20180717113402.5510-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 16/25] check: Only test sdhci when it is
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
index b0aa79909b..868a41986b 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -307,7 +307,7 @@ check-qtest-i386-y += tests/migration-test$(EXESUF)
 check-qtest-i386-y += tests/test-x86-cpuid-compat$(EXESUF)
 check-qtest-i386-y += tests/numa-test$(EXESUF)
 check-qtest-x86_64-y += $(check-qtest-i386-y)
-check-qtest-x86_64-y += tests/sdhci-test$(EXESUF)
+check-qtest-x86_64-$(CONFIG_SDHCI) += tests/sdhci-test$(EXESUF)
 gcov-files-i386-y += i386-softmmu/hw/timer/mc146818rtc.c
 gcov-files-x86_64-y = $(subst i386-softmmu/,x86_64-softmmu/,$(gcov-files-i386-y))
 
@@ -381,10 +381,10 @@ gcov-files-arm-y += arm-softmmu/hw/block/virtio-blk.c
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
