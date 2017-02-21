Received: from eggs.gnu.org ([2001:4830:134:3::10]:56169)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cgBEi-0001Ww-Gf
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 09:16:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cgBEd-0004Ff-HL
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 09:16:12 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33736)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cgBEd-0004FG-Ao
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 09:16:07 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7882B8048C
	for <qemu-devel@nongnu.org>; Tue, 21 Feb 2017 14:16:07 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 21 Feb 2017 18:14:37 +0400
Message-Id: <20170221141451.28305-17-marcandre.lureau@redhat.com>
In-Reply-To: <20170221141451.28305-1-marcandre.lureau@redhat.com>
References: <20170221141451.28305-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 16/30] tests: fix eepro100-test leak
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
