Received: from eggs.gnu.org ([2001:4830:134:3::10]:40446)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eZFnO-0006Fc-HE
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 07:47:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eZFnN-0004j4-9O
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 07:47:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33538)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1eZFnN-0004iH-3U
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 07:47:53 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3FBC35FD76
	for <qemu-devel@nongnu.org>; Wed, 10 Jan 2018 12:47:52 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 10 Jan 2018 13:47:20 +0100
Message-Id: <20180110124723.11879-12-quintela@redhat.com>
In-Reply-To: <20180110124723.11879-1-quintela@redhat.com>
References: <20180110124723.11879-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH v10 11/14] LOCAL: use trace events for
 migration-test
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
 tests/migration-test.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/migration-test.c b/tests/migration-test.c
index 488ae89f34..d0b0c1b64b 100644
--- a/tests/migration-test.c
+++ b/tests/migration-test.c
@@ -457,11 +457,13 @@ static void test_migrate_start(QTestState **from, QTestState **to,
     if (strcmp(arch, "i386") == 0 || strcmp(arch, "x86_64") == 0) {
         init_bootfile_x86(bootpath);
         cmd_src = g_strdup_printf("-machine accel=%s -m 256M"
+                                  " -trace events=/home/quintela/tmp/events"
                                   " -name source,debug-threads=on"
                                   " -serial file:%s/src_serial"
                                   " -drive file=%s,format=raw",
                                   accel, tmpfs, bootpath);
         cmd_dst = g_strdup_printf("-machine accel=%s -m 256M"
+                                  " -trace events=/home/quintela/tmp/events"
                                   " -name target,debug-threads=on"
                                   " -serial file:%s/dest_serial"
                                   " -drive file=%s,format=raw"
-- 
2.14.3
