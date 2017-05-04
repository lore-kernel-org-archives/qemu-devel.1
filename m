Received: from eggs.gnu.org ([2001:4830:134:3::10]:46593)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1d6FBW-0004Nv-VZ
	for qemu-devel@nongnu.org; Thu, 04 May 2017 07:44:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1d6FBS-0004sK-1i
	for qemu-devel@nongnu.org; Thu, 04 May 2017 07:44:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39588)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1d6FBR-0004rn-SJ
	for qemu-devel@nongnu.org; Thu, 04 May 2017 07:44:33 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu,  4 May 2017 15:42:27 +0400
Message-Id: <20170504114232.20318-17-marcandre.lureau@redhat.com>
In-Reply-To: <20170504114232.20318-1-marcandre.lureau@redhat.com>
References: <20170504114232.20318-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 16/21] tests: add alias check in /char/ringbuf
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: stefanha@gmail.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 tests/test-char.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tests/test-char.c b/tests/test-char.c
index 71de4b35ee..2811644bcd 100644
--- a/tests/test-char.c
+++ b/tests/test-char.c
@@ -104,6 +104,16 @@ static void char_ringbuf_test(void)
=20
     qemu_chr_fe_deinit(&be);
     object_unparent(OBJECT(chr));
+
+    /* check alias */
+    opts =3D qemu_opts_create(qemu_find_opts("chardev"), "memory-label",
+                            1, &error_abort);
+    qemu_opt_set(opts, "backend", "memory", &error_abort);
+    qemu_opt_set(opts, "size", "2", &error_abort);
+    chr =3D qemu_chr_new_from_opts(opts, NULL);
+    g_assert_nonnull(chr);
+    object_unparent(OBJECT(chr));
+    qemu_opts_del(opts);
 }
=20
 static void char_mux_test(void)
--=20
2.12.0.191.gc5d8de91d
