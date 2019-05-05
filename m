Received: from eggs.gnu.org ([209.51.188.92]:35972)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hNPQx-0004JX-4H
	for qemu-devel@nongnu.org; Sun, 05 May 2019 18:16:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hNPQt-0008JP-8Y
	for qemu-devel@nongnu.org; Sun, 05 May 2019 18:16:33 -0400
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Mon,  6 May 2019 00:15:34 +0200
Message-Id: <20190505221544.31568-4-philmd@redhat.com>
In-Reply-To: <20190505221544.31568-1-philmd@redhat.com>
References: <20190505221544.31568-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 03/13] tests/pflash-cfi02: Use IEC binary
 prefixes for size constants
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Stephen Checkoway <stephen.checkoway@oberlin.edu>
Cc: Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>, Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

Using IEC binary prefixes in order to make the code more readable.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 tests/pflash-cfi02-test.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tests/pflash-cfi02-test.c b/tests/pflash-cfi02-test.c
index ff775618c02..3c37465499a 100644
--- a/tests/pflash-cfi02-test.c
+++ b/tests/pflash-cfi02-test.c
@@ -8,6 +8,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "qemu/units.h"
 #include "libqtest.h"
=20
 /*
@@ -16,7 +17,7 @@
  * all. In particular, we're limited to a 16-bit wide flash device.
  */
=20
-#define MP_FLASH_SIZE_MAX (32 * 1024 * 1024)
+#define MP_FLASH_SIZE_MAX (32 * MiB)
 #define BASE_ADDR (0x100000000ULL - MP_FLASH_SIZE_MAX)
=20
 #define FLASH_WIDTH 2
@@ -205,7 +206,7 @@ int main(int argc, char **argv)
     char *image_path;
     int fd =3D g_file_open_tmp("pflash-cfi02-XXXXXX.raw", &image_path, &=
error);
     g_assert_no_error(error);
-    if (ftruncate(fd, 8 * 1024 * 1024) < 0) {
+    if (ftruncate(fd, 8 * MiB) < 0) {
         g_printerr("Failed to truncate file %s to 8 MB: %s\n", image_pat=
h,
                    strerror(errno));
         close(fd);
--=20
2.20.1
