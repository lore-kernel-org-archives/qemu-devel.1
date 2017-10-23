Received: from eggs.gnu.org ([2001:4830:134:3::10]:36007)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1e6fHg-0005zi-Ch
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 12:09:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1e6fHe-0000ea-Ly
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 12:09:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45148)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1e6fHe-0000dd-Fe
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 12:08:58 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 96750BBD8
	for <qemu-devel@nongnu.org>; Mon, 23 Oct 2017 16:08:57 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Mon, 23 Oct 2017 18:07:59 +0200
Message-Id: <20171023160800.20540-21-quintela@redhat.com>
In-Reply-To: <20171023160800.20540-1-quintela@redhat.com>
References: <20171023160800.20540-1-quintela@redhat.com>
Subject: [Qemu-devel] [PULL 20/21] qapi: Fix grammar in x-multifd-page-count
 descriptions
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

Reported-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 qapi/migration.json | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/qapi/migration.json b/qapi/migration.json
index 272f191551..6ae866e1aa 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -480,7 +480,7 @@
 #                     number of sockets used for migration.  The
 #                     default value is 2 (since 2.11)
 #
-# @x-multifd-page-count: Number of pages sent together to a thread
+# @x-multifd-page-count: Number of pages sent together to a thread.
 #                        The default value is 16 (since 2.11)
 #
 # Since: 2.4
@@ -551,7 +551,7 @@
 #                     number of sockets used for migration.  The
 #                     default value is 2 (since 2.11)
 #
-# @x-multifd-page-count: Number of pages sent together to a thread
+# @x-multifd-page-count: Number of pages sent together to a thread.
 #                        The default value is 16 (since 2.11)
 #
 # Since: 2.4
@@ -647,7 +647,7 @@
 #                     number of sockets used for migration.
 #                     The default value is 2 (since 2.11)
 #
-# @x-multifd-page-count: Number of pages sent together to a thread
+# @x-multifd-page-count: Number of pages sent together to a thread.
 #                        The default value is 16 (since 2.11)
 #
 # Since: 2.4
-- 
2.13.6
