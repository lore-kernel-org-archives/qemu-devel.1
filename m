Received: from eggs.gnu.org ([2001:4830:134:3::10]:38351)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eXZv6-0002H5-DO
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 16:52:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eXZv5-00034s-ID
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 16:52:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42444)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1eXZv5-00033W-9A
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 16:52:55 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5A95D3DFCD
	for <qemu-devel@nongnu.org>; Fri,  5 Jan 2018 21:52:54 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Fri,  5 Jan 2018 22:52:37 +0100
Message-Id: <20180105215246.908-3-quintela@redhat.com>
In-Reply-To: <20180105215246.908-1-quintela@redhat.com>
References: <20180105215246.908-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH v4 02/11] tests: Migration ppc test was missing
 arguments
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

Argument file is also needed there.

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 tests/migration-test.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tests/migration-test.c b/tests/migration-test.c
index 0448bc77dc..32f3bb86a8 100644
--- a/tests/migration-test.c
+++ b/tests/migration-test.c
@@ -464,8 +464,9 @@ static void test_migrate_start(QTestState **from, QTestState **to,
         cmd_dst = g_strdup_printf("-machine accel=%s -m 256M"
                                   " -name pcdest,debug-threads=on"
                                   " -serial file:%s/dest_serial"
+                                  " -drive file=%s,if=pflash,format=raw"
                                   " -incoming %s",
-                                  accel, tmpfs, uri);
+                                  accel, tmpfs, bootpath, uri);
     } else {
         g_assert_not_reached();
     }
-- 
2.14.3
