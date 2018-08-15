Received: from eggs.gnu.org ([2001:4830:134:3::10]:60570)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fpw0v-0002vE-51
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 09:39:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fpw0p-0003Zq-5T
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 09:39:04 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52282 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fpw0o-0003Z3-1h
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 09:38:58 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 161CC818F035
	for <qemu-devel@nongnu.org>; Wed, 15 Aug 2018 13:38:55 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Wed, 15 Aug 2018 21:37:45 +0800
Message-Id: <20180815133747.25032-12-peterx@redhat.com>
In-Reply-To: <20180815133747.25032-1-peterx@redhat.com>
References: <20180815133747.25032-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v6 11/13] tests: remove "0.15" prefix for
 test-qmp-cmds
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com

The "0.15" prefix seems useless.  Remove them.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tests/test-qmp-cmds.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tests/test-qmp-cmds.c b/tests/test-qmp-cmds.c
index ba41a6161e..989819b26d 100644
--- a/tests/test-qmp-cmds.c
+++ b/tests/test-qmp-cmds.c
@@ -286,11 +286,11 @@ int main(int argc, char **argv)
 {
     g_test_init(&argc, &argv, NULL);
 
-    g_test_add_func("/0.15/dispatch_cmd", test_dispatch_cmd);
-    g_test_add_func("/0.15/dispatch_cmd_failure", test_dispatch_cmd_failure);
-    g_test_add_func("/0.15/dispatch_cmd_io", test_dispatch_cmd_io);
-    g_test_add_func("/0.15/dealloc_types", test_dealloc_types);
-    g_test_add_func("/0.15/dealloc_partial", test_dealloc_partial);
+    g_test_add_func("/dispatch_cmd", test_dispatch_cmd);
+    g_test_add_func("/dispatch_cmd_failure", test_dispatch_cmd_failure);
+    g_test_add_func("/dispatch_cmd_io", test_dispatch_cmd_io);
+    g_test_add_func("/dealloc_types", test_dealloc_types);
+    g_test_add_func("/dealloc_partial", test_dealloc_partial);
 
     test_qmp_init_marshal(&qmp_commands);
     g_test_run();
-- 
2.17.1
