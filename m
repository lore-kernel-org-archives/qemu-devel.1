Received: from eggs.gnu.org ([2001:4830:134:3::10]:51148)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gJhvF-0000mk-6Z
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 11:40:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gJhv9-0008PS-PD
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 11:40:12 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon,  5 Nov 2018 17:37:39 +0100
Message-Id: <20181105163744.25139-32-kwolf@redhat.com>
In-Reply-To: <20181105163744.25139-1-kwolf@redhat.com>
References: <20181105163744.25139-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 31/36] chardev: Indent list of chardevs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

From: Max Reitz <mreitz@redhat.com>

Following the example of qemu_opts_print_help(), indent all entries in
the list of character devices.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 chardev/char.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/chardev/char.c b/chardev/char.c
index 79b05fb7b7..152dde5327 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -572,7 +572,7 @@ help_string_append(const char *name, void *opaque)
 {
     GString *str =3D opaque;
=20
-    g_string_append_printf(str, "\n%s", name);
+    g_string_append_printf(str, "\n  %s", name);
 }
=20
 static const char *chardev_alias_translate(const char *name)
--=20
2.19.1
