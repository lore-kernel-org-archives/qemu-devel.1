Received: from eggs.gnu.org ([2001:4830:134:3::10]:34610)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eWfVa-0006zw-Js
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 04:38:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eWfVZ-00071d-U2
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 04:38:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60270)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1eWfVZ-00070o-OH
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 04:38:49 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E042B356FF
	for <qemu-devel@nongnu.org>; Wed,  3 Jan 2018 09:38:48 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed,  3 Jan 2018 10:38:25 +0100
Message-Id: <20180103093834.20879-6-quintela@redhat.com>
In-Reply-To: <20180103093834.20879-1-quintela@redhat.com>
References: <20180103093834.20879-1-quintela@redhat.com>
Subject: [Qemu-devel] [PULL 05/14] migration: free result string
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
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reported-by: Peter Xu <peterx@redhat.com>
---
 tests/migration-test.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tests/migration-test.c b/tests/migration-test.c
index be598d3257..799e24ebc6 100644
--- a/tests/migration-test.c
+++ b/tests/migration-test.c
@@ -358,13 +358,14 @@ static void migrate_check_parameter(QTestState *who, const char *parameter,
                                     const char *value)
 {
     QDict *rsp, *rsp_return;
-    const char *result;
+    char *result;
 
     rsp = wait_command(who, "{ 'execute': 'query-migrate-parameters' }");
     rsp_return = qdict_get_qdict(rsp, "return");
     result = g_strdup_printf("%" PRId64,
                              qdict_get_try_int(rsp_return,  parameter, -1));
     g_assert_cmpstr(result, ==, value);
+    g_free(result);
     QDECREF(rsp);
 }
 
-- 
2.14.3
