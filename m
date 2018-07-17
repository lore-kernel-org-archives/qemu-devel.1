Received: from eggs.gnu.org ([2001:4830:134:3::10]:54882)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1ffOiP-0005Vl-Pk
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 08:04:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1ffOiO-0007BF-Va
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 08:04:25 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33912 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1ffOiO-0007Al-RP
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 08:04:24 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6A7F77C6CA
	for <qemu-devel@nongnu.org>; Tue, 17 Jul 2018 12:04:24 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Tue, 17 Jul 2018 14:04:04 +0200
Message-Id: <20180717120414.5852-5-quintela@redhat.com>
In-Reply-To: <20180717120414.5852-1-quintela@redhat.com>
References: <20180717120414.5852-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 04/14] check: Only test esp when it is compiled
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
index bab2ecc306..0d7dff6da5 100644
--- a/tests/cdrom-test.c
+++ b/tests/cdrom-test.c
@@ -134,12 +134,14 @@ static void add_x86_tests(void)
                         "-blockdev file,node-name=cdr,filename=", test_cdboot);
     qtest_add_data_func("cdrom/boot/isapc", "-M isapc "
                         "-drive if=ide,media=cdrom,file=", test_cdboot);
+#ifdef CONFIG_ESP_PCI
     qtest_add_data_func("cdrom/boot/am53c974",
                         "-device am53c974 -device scsi-cd,drive=cd1 "
                         "-drive if=none,id=cd1,format=raw,file=", test_cdboot);
     qtest_add_data_func("cdrom/boot/dc390",
                         "-device dc390 -device scsi-cd,drive=cd1 "
                         "-blockdev file,node-name=cd1,filename=", test_cdboot);
+#endif
 #ifdef CONFIG_LSI_SCSI_PCI
     qtest_add_data_func("cdrom/boot/lsi53c895a",
                         "-device lsi53c895a -device scsi-cd,drive=cd1 "
-- 
2.17.1
