Received: from eggs.gnu.org ([2001:4830:134:3::10]:37667)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cTsiH-0002me-36
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 11:03:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cTsiD-0007Pw-Bd
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 11:03:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49280)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cTsiD-0007PV-6B
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 11:03:49 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 572FB2F9FDF
	for <qemu-devel@nongnu.org>; Wed, 18 Jan 2017 16:03:49 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 18 Jan 2017 20:03:09 +0400
Message-Id: <20170118160332.13390-3-marcandre.lureau@redhat.com>
In-Reply-To: <20170118160332.13390-1-marcandre.lureau@redhat.com>
References: <20170118160332.13390-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 02/25] tests: change /0.15/* tests to /qmp/*
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, berrange@redhat.com, kraxel@redhat.com, armbru@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Presumably 0.15 was the version it was first introduced, but
qmp keeps evolving. There is no point in having that version
as test prefix, 'qmp' makes more sense here.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 tests/test-qmp-commands.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tests/test-qmp-commands.c b/tests/test-qmp-commands.c
index ff944811e8..e46981eb1e 100644
--- a/tests/test-qmp-commands.c
+++ b/tests/test-qmp-commands.c
@@ -267,11 +267,11 @@ int main(int argc, char **argv)
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
     module_call_init(MODULE_INIT_QAPI);
     g_test_run();
--=20
2.11.0.295.gd7dffce1c
