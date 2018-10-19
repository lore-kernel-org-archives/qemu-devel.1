Received: from eggs.gnu.org ([2001:4830:134:3::10]:44768)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gDXyN-0003Cn-33
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 12:50:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gDXyM-00057m-3d
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 12:50:02 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Fri, 19 Oct 2018 18:49:29 +0200
Message-Id: <20181019164929.18404-6-mreitz@redhat.com>
In-Reply-To: <20181019164929.18404-1-mreitz@redhat.com>
References: <20181019164929.18404-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 5/5] fw_cfg: Drop newline in @file
 description
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>

There is no good reason why there should be a newline in this
description, so remove it.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 vl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/vl.c b/vl.c
index ecddbb6b8e..6604648570 100644
--- a/vl.c
+++ b/vl.c
@@ -529,7 +529,7 @@ static QemuOptsList qemu_fw_cfg_opts =3D {
         }, {
             .name =3D "file",
             .type =3D QEMU_OPT_STRING,
-            .help =3D "Sets the name of the file from which\n"
+            .help =3D "Sets the name of the file from which "
                     "the fw_cfg blob will be loaded",
         }, {
             .name =3D "string",
--=20
2.17.1
