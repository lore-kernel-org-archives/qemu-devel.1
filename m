Received: from eggs.gnu.org ([2001:4830:134:3::10]:39846)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cZIkx-0005O9-Qo
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 09:53:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cZIkx-0004W8-3k
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 09:53:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35516)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cZIkw-0004Vl-Tb
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 09:53:03 -0500
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E28FDC7043
	for <qemu-devel@nongnu.org>; Thu,  2 Feb 2017 14:53:02 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu,  2 Feb 2017 18:51:36 +0400
Message-Id: <20170202145141.17138-18-marcandre.lureau@redhat.com>
In-Reply-To: <20170202145141.17138-1-marcandre.lureau@redhat.com>
References: <20170202145141.17138-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 17/22] tests: add alias check in /char/ringbuf
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, eblake@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 tests/test-char.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tests/test-char.c b/tests/test-char.c
index da69f110e4..aa9b18a61b 100644
--- a/tests/test-char.c
+++ b/tests/test-char.c
@@ -104,6 +104,16 @@ static void char_ringbuf_test(void)
=20
     qemu_chr_fe_deinit(&be);
     qemu_chr_delete(chr);
+
+    /* check alias */
+    opts =3D qemu_opts_create(qemu_find_opts("chardev"), "memory-label",
+                            1, &error_abort);
+    qemu_opt_set(opts, "backend", "memory", &error_abort);
+    qemu_opt_set(opts, "size", "2", &error_abort);
+    chr =3D qemu_chr_new_from_opts(opts, NULL);
+    g_assert_nonnull(chr);
+    qemu_chr_delete(chr);
+    qemu_opts_del(opts);
 }
=20
 static void char_mux_test(void)
--=20
2.11.0.295.gd7dffce1c.dirty
