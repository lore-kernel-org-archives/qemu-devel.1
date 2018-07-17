Received: from eggs.gnu.org ([2001:4830:134:3::10]:54860)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1ffOiO-0005V6-Mr
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 08:04:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1ffOiN-00078s-TA
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 08:04:24 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38084 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1ffOiN-00077h-O3
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 08:04:23 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1807281A4EAF
	for <qemu-devel@nongnu.org>; Tue, 17 Jul 2018 12:04:23 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Tue, 17 Jul 2018 14:04:03 +0200
Message-Id: <20180717120414.5852-4-quintela@redhat.com>
In-Reply-To: <20180717120414.5852-1-quintela@redhat.com>
References: <20180717120414.5852-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 03/14] check: Only test lsi when it is compiled
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
---
 tests/cdrom-test.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/cdrom-test.c b/tests/cdrom-test.c
index 42c29524b8..bab2ecc306 100644
--- a/tests/cdrom-test.c
+++ b/tests/cdrom-test.c
@@ -140,9 +140,11 @@ static void add_x86_tests(void)
     qtest_add_data_func("cdrom/boot/dc390",
                         "-device dc390 -device scsi-cd,drive=cd1 "
                         "-blockdev file,node-name=cd1,filename=", test_cdboot);
+#ifdef CONFIG_LSI_SCSI_PCI
     qtest_add_data_func("cdrom/boot/lsi53c895a",
                         "-device lsi53c895a -device scsi-cd,drive=cd1 "
                         "-blockdev file,node-name=cd1,filename=", test_cdboot);
+#endif
 #ifdef CONFIG_MEGASAS_SCSI_PCI
     qtest_add_data_func("cdrom/boot/megasas", "-M q35 "
                         "-device megasas -device scsi-cd,drive=cd1 "
-- 
2.17.1
