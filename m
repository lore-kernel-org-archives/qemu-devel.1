Received: from eggs.gnu.org ([2001:4830:134:3::10]:54988)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dzhCQ-0004oN-5M
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 06:46:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dzhCO-0002nF-Qk
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 06:46:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48328)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dzhCO-0002mp-K3
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 06:46:44 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9C13F882FF
	for <qemu-devel@nongnu.org>; Wed,  4 Oct 2017 10:46:43 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed,  4 Oct 2017 12:46:25 +0200
Message-Id: <20171004104636.7963-2-quintela@redhat.com>
In-Reply-To: <20171004104636.7963-1-quintela@redhat.com>
References: <20171004104636.7963-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH v9 01/12] qapi: Fix grammar in
 x-multifd-page-count descriptions
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
index f8b365e3f5..d94d6c0e46 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -471,7 +471,7 @@
 #                     number of sockets used for migration.  The
 #                     default value is 2 (since 2.11)
 #
-# @x-multifd-page-count: Number of pages sent together to a thread
+# @x-multifd-page-count: Number of pages sent together to a thread.
 #                        The default value is 16 (since 2.11)
 #
 # Since: 2.4
@@ -542,7 +542,7 @@
 #                     number of sockets used for migration.  The
 #                     default value is 2 (since 2.11)
 #
-# @x-multifd-page-count: Number of pages sent together to a thread
+# @x-multifd-page-count: Number of pages sent together to a thread.
 #                        The default value is 16 (since 2.11)
 #
 # Since: 2.4
@@ -638,7 +638,7 @@
 #                     number of sockets used for migration.
 #                     The default value is 2 (since 2.11)
 #
-# @x-multifd-page-count: Number of pages sent together to a thread
+# @x-multifd-page-count: Number of pages sent together to a thread.
 #                        The default value is 16 (since 2.11)
 #
 # Since: 2.4
-- 
2.13.5
