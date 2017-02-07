Received: from eggs.gnu.org ([2001:4830:134:3::10]:60572)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cb6CD-0007ek-MV
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 08:52:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cb6CD-0007u1-49
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 08:52:37 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38520)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cb6CC-0007tj-UW
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 08:52:37 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0D32780F7B
	for <qemu-devel@nongnu.org>; Tue,  7 Feb 2017 13:52:37 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue,  7 Feb 2017 17:51:49 +0400
Message-Id: <20170207135211.15870-7-marcandre.lureau@redhat.com>
In-Reply-To: <20170207135211.15870-1-marcandre.lureau@redhat.com>
References: <20170207135211.15870-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 06/28] tests: fix endianness-test leaks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Spotted by ASAN.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 tests/endianness-test.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tests/endianness-test.c b/tests/endianness-test.c
index cf8d41b7b4..ed0bf52019 100644
--- a/tests/endianness-test.c
+++ b/tests/endianness-test.c
@@ -295,14 +295,17 @@ int main(int argc, char **argv)
         path =3D g_strdup_printf("endianness/%s",
                                test_cases[i].machine);
         qtest_add_data_func(path, &test_cases[i], test_endianness);
+        g_free(path);
=20
         path =3D g_strdup_printf("endianness/split/%s",
                                test_cases[i].machine);
         qtest_add_data_func(path, &test_cases[i], test_endianness_split)=
;
+        g_free(path);
=20
         path =3D g_strdup_printf("endianness/combine/%s",
                                test_cases[i].machine);
         qtest_add_data_func(path, &test_cases[i], test_endianness_combin=
e);
+        g_free(path);
     }
=20
     return g_test_run();
--=20
2.11.0.295.gd7dffce1c.dirty
