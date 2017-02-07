Received: from eggs.gnu.org ([2001:4830:134:3::10]:60850)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cb6Cc-000834-K4
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 08:53:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cb6CZ-00089a-KG
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 08:53:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38772)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cb6CZ-00088i-FE
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 08:52:59 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 893B480474
	for <qemu-devel@nongnu.org>; Tue,  7 Feb 2017 13:52:59 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue,  7 Feb 2017 17:51:55 +0400
Message-Id: <20170207135211.15870-13-marcandre.lureau@redhat.com>
In-Reply-To: <20170207135211.15870-1-marcandre.lureau@redhat.com>
References: <20170207135211.15870-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 12/28] tests: fix ipmi-kcs-test leak
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
 tests/ipmi-kcs-test.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/ipmi-kcs-test.c b/tests/ipmi-kcs-test.c
index 9cf0b34a33..178ffc1797 100644
--- a/tests/ipmi-kcs-test.c
+++ b/tests/ipmi-kcs-test.c
@@ -279,6 +279,7 @@ int main(int argc, char **argv)
     cmdline =3D g_strdup_printf("-device ipmi-bmc-sim,id=3Dbmc0"
                               " -device isa-ipmi-kcs,bmc=3Dbmc0");
     qtest_start(cmdline);
+    g_free(cmdline);
     qtest_irq_intercept_in(global_qtest, "ioapic");
     qtest_add_func("/ipmi/local/kcs_base", test_kcs_base);
     qtest_add_func("/ipmi/local/kcs_abort", test_kcs_abort);
--=20
2.11.0.295.gd7dffce1c.dirty
