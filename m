Received: from eggs.gnu.org ([209.51.188.92]:53133)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h2gZU-00015N-7v
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 13:19:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h2gZS-0004Ed-87
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 13:19:42 -0500
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Sat,  9 Mar 2019 19:19:20 +0100
Message-Id: <20190309181920.30553-3-philmd@redhat.com>
In-Reply-To: <20190309181920.30553-1-philmd@redhat.com>
References: <20190309181920.30553-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 2/2] hw/nvram/fw_cfg: Use the ldst API
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-trivial@nongnu.org, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Laszlo Ersek <lersek@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Michael Tokarev <mjt@tls.msk.ru>, Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, qemu-arm@nongnu.org

The load/store API eases code review.

Reviewed-by: Laszlo Ersek <lersek@redhat.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/nvram/fw_cfg.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
index 7fdf04adc9..3d8859e333 100644
--- a/hw/nvram/fw_cfg.c
+++ b/hw/nvram/fw_cfg.c
@@ -85,7 +85,7 @@ static char *read_splashfile(char *filename, gsize *fil=
e_sizep,
     }
=20
     /* check magic ID */
-    filehead =3D ((content[0] & 0xff) + (content[1] << 8)) & 0xffff;
+    filehead =3D lduw_le_p(content);
     if (filehead =3D=3D 0xd8ff) {
         file_type =3D JPG_FILE;
     } else if (filehead =3D=3D 0x4d42) {
@@ -96,7 +96,7 @@ static char *read_splashfile(char *filename, gsize *fil=
e_sizep,
=20
     /* check BMP bpp */
     if (file_type =3D=3D BMP_FILE) {
-        bmp_bpp =3D (content[28] + (content[29] << 8)) & 0xffff;
+        bmp_bpp =3D lduw_le_p(&content[28]);
         if (bmp_bpp !=3D 24) {
             goto error;
         }
--=20
2.20.1
