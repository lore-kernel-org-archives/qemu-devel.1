Received: from eggs.gnu.org ([2001:4830:134:3::10]:52071)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e3Wyy-0006TF-ND
	for qemu-devel@nongnu.org; Sat, 14 Oct 2017 20:40:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e3Wyx-0003jE-RY
	for qemu-devel@nongnu.org; Sat, 14 Oct 2017 20:40:44 -0400
From: Eric Blake <eblake@redhat.com>
Date: Sat, 14 Oct 2017 19:40:25 -0500
Message-Id: <20171015004033.3248-2-eblake@redhat.com>
In-Reply-To: <20171015004033.3248-1-eblake@redhat.com>
References: <20171015004033.3248-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 1/9] NBD: use g_new() family of functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "open list:Network Block Dev..." <qemu-block@nongnu.org>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Message-Id: <20171006235023.11952-22-f4bug@amsat.org>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 nbd/server.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/nbd/server.c b/nbd/server.c
index 993ade30bb..b74cc6ab7e 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -1047,7 +1047,7 @@ NBDExport *nbd_export_new(BlockDriverState *bs, off=
_t dev_offset, off_t size,
 {
     AioContext *ctx;
     BlockBackend *blk;
-    NBDExport *exp =3D g_malloc0(sizeof(NBDExport));
+    NBDExport *exp =3D g_new0(NBDExport, 1);
     uint64_t perm;
     int ret;

@@ -1539,7 +1539,7 @@ void nbd_client_new(NBDExport *exp,
     NBDClient *client;
     Coroutine *co;

-    client =3D g_malloc0(sizeof(NBDClient));
+    client =3D g_new0(NBDClient, 1);
     client->refcount =3D 1;
     client->exp =3D exp;
     client->tlscreds =3D tlscreds;
--=20
2.13.6
