Received: from eggs.gnu.org ([2001:4830:134:3::10]:35532)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fbPil-00033K-6q
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 08:20:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fbPih-00083u-Vu
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 08:20:19 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41306 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1fbPih-00082t-JM
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 08:20:15 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3B63881A4EA8
	for <qemu-devel@nongnu.org>; Fri,  6 Jul 2018 12:13:57 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Fri,  6 Jul 2018 14:13:43 +0200
Message-Id: <20180706121354.2021-2-marcandre.lureau@redhat.com>
In-Reply-To: <20180706121354.2021-1-marcandre.lureau@redhat.com>
References: <20180706121354.2021-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 01/12] tests: change /0.15/* tests to /qmp/*
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, armbru@redhat.com, peterx@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Presumably 0.15 was the version it was first introduced, but
qmp keeps evolving. There is no point in having that version
as test prefix, 'qmp' makes more sense here.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-Id: <20180326150916.9602-12-marcandre.lureau@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 tests/test-qmp-cmds.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tests/test-qmp-cmds.c b/tests/test-qmp-cmds.c
index ba41a6161e..ab414fa0c9 100644
--- a/tests/test-qmp-cmds.c
+++ b/tests/test-qmp-cmds.c
@@ -286,11 +286,11 @@ int main(int argc, char **argv)
 {
     g_test_init(&argc, &argv, NULL);
=20
-    g_test_add_func("/0.15/dispatch_cmd", test_dispatch_cmd);
-    g_test_add_func("/0.15/dispatch_cmd_failure", test_dispatch_cmd_fail=
ure);
-    g_test_add_func("/0.15/dispatch_cmd_io", test_dispatch_cmd_io);
-    g_test_add_func("/0.15/dealloc_types", test_dealloc_types);
-    g_test_add_func("/0.15/dealloc_partial", test_dealloc_partial);
+    g_test_add_func("/qmp/dispatch_cmd", test_dispatch_cmd);
+    g_test_add_func("/qmp/dispatch_cmd_failure", test_dispatch_cmd_failu=
re);
+    g_test_add_func("/qmp/dispatch_cmd_io", test_dispatch_cmd_io);
+    g_test_add_func("/qmp/dealloc_types", test_dealloc_types);
+    g_test_add_func("/qmp/dealloc_partial", test_dealloc_partial);
=20
     test_qmp_init_marshal(&qmp_commands);
     g_test_run();
--=20
2.18.0.rc1
