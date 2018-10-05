Received: from eggs.gnu.org ([2001:4830:134:3::10]:59013)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1g8PFc-00018K-2f
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 08:30:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1g8PFY-0006Wt-RL
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 08:30:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55876)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1g8PFX-0006Vo-0z
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 08:30:31 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Fri,  5 Oct 2018 16:29:05 +0400
Message-Id: <20181005122910.11745-8-marcandre.lureau@redhat.com>
In-Reply-To: <20181005122910.11745-1-marcandre.lureau@redhat.com>
References: <20181005122910.11745-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v2 07/12] tests/qom-proplist: check duplicate
 "bv" property registration failed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

"bv" is already a class property.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/check-qom-proplist.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tests/check-qom-proplist.c b/tests/check-qom-proplist.c
index 92898e1520..0f6d9c1ce3 100644
--- a/tests/check-qom-proplist.c
+++ b/tests/check-qom-proplist.c
@@ -125,10 +125,13 @@ static char *dummy_get_sv(Object *obj,
=20
 static void dummy_init(Object *obj)
 {
+    Error *err =3D NULL;
+
     object_property_add_bool(obj, "bv",
                              dummy_get_bv,
                              dummy_set_bv,
-                             NULL);
+                             &err);
+    error_free_or_abort(&err);
 }
=20
=20
--=20
2.19.0.271.gfe8321ec05
