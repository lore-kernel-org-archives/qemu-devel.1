Received: from eggs.gnu.org ([2001:4830:134:3::10]:41571)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cj0Ct-0003Hd-7R
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 04:06:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cj0Cs-0001dO-1z
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 04:05:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50228)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cj0Cr-0001cz-Ph
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 04:05:57 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F265B3B71F
	for <qemu-devel@nongnu.org>; Wed,  1 Mar 2017 09:05:57 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed,  1 Mar 2017 13:04:41 +0400
Message-Id: <20170301090453.11075-17-marcandre.lureau@redhat.com>
In-Reply-To: <20170301090453.11075-1-marcandre.lureau@redhat.com>
References: <20170301090453.11075-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 16/28] tests: fix eepro100-test leak
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
Reviewed-by: Stefan Weil <sw@weilnetz.de>
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
2.12.0.rc2.3.gc93709801
