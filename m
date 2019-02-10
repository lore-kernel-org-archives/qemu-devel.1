Received: from eggs.gnu.org ([209.51.188.92]:54255)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gsqYW-00033v-NT
	for qemu-devel@nongnu.org; Sun, 10 Feb 2019 09:58:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gsqYW-0005w9-41
	for qemu-devel@nongnu.org; Sun, 10 Feb 2019 09:58:04 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Sun, 10 Feb 2019 15:57:30 +0100
Message-Id: <20190210145736.1486-5-mreitz@redhat.com>
In-Reply-To: <20190210145736.1486-1-mreitz@redhat.com>
References: <20190210145736.1486-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 04/10] iotests: Fix 232 for LUKS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>, Kevin Wolf <kwolf@redhat.com>

With IMGOPTSSYNTAX, $TEST_IMG is useless for this test (it only tests
the file-posix protocol driver).  Therefore, if $TEST_IMG_FILE is set,
use that instead.

Because this test requires the file protocol, $TEST_IMG_FILE will always
be set if $IMGOPTSSYNTAX is true.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
---
 tests/qemu-iotests/232 | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tests/qemu-iotests/232 b/tests/qemu-iotests/232
index 93e5d641a3..e48bc8f5db 100755
--- a/tests/qemu-iotests/232
+++ b/tests/qemu-iotests/232
@@ -69,6 +69,10 @@ size=3D128M
=20
 _make_test_img $size
=20
+if [ -n "$TEST_IMG_FILE" ]; then
+    TEST_IMG=3D$TEST_IMG_FILE
+fi
+
 echo
 echo "=3D=3D=3D -drive with read-write image: read-only/auto-read-only c=
ombinations =3D=3D=3D"
 echo
--=20
2.20.1
