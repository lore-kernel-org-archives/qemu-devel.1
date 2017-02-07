Received: from eggs.gnu.org ([2001:4830:134:3::10]:60910)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cb6Cl-0008Aj-6M
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 08:53:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cb6Ck-0008FD-6i
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 08:53:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33764)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cb6Ck-0008Ep-12
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 08:53:10 -0500
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 14F0D3D959
	for <qemu-devel@nongnu.org>; Tue,  7 Feb 2017 13:53:10 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue,  7 Feb 2017 17:51:58 +0400
Message-Id: <20170207135211.15870-16-marcandre.lureau@redhat.com>
In-Reply-To: <20170207135211.15870-1-marcandre.lureau@redhat.com>
References: <20170207135211.15870-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 15/28] tests: fix eepro100-test leak
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
 tests/eepro100-test.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/eepro100-test.c b/tests/eepro100-test.c
index ed23258b0f..bdc8a67d57 100644
--- a/tests/eepro100-test.c
+++ b/tests/eepro100-test.c
@@ -54,6 +54,7 @@ int main(int argc, char **argv)
=20
         path =3D g_strdup_printf("eepro100/%s", models[i]);
         qtest_add_data_func(path, models[i], test_device);
+        g_free(path);
     }
=20
     return g_test_run();
--=20
2.11.0.295.gd7dffce1c.dirty
