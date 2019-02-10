Received: from eggs.gnu.org ([209.51.188.92]:54208)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gsqYS-0002zI-15
	for qemu-devel@nongnu.org; Sun, 10 Feb 2019 09:58:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gsqYR-0005sF-Dz
	for qemu-devel@nongnu.org; Sun, 10 Feb 2019 09:57:59 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Sun, 10 Feb 2019 15:57:29 +0100
Message-Id: <20190210145736.1486-4-mreitz@redhat.com>
In-Reply-To: <20190210145736.1486-1-mreitz@redhat.com>
References: <20190210145736.1486-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 03/10] iotests: Remove superfluous rm from
 232
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

This test creates no such file.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
---
 tests/qemu-iotests/232 | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tests/qemu-iotests/232 b/tests/qemu-iotests/232
index 0708b8b155..93e5d641a3 100755
--- a/tests/qemu-iotests/232
+++ b/tests/qemu-iotests/232
@@ -29,7 +29,6 @@ status=3D1	# failure is the default!
 _cleanup()
 {
     _cleanup_test_img
-    rm -f $TEST_IMG.snap
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
=20
--=20
2.20.1
