Received: from eggs.gnu.org ([209.51.188.92]:48450)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gmJnc-00089B-9C
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 09:46:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gmJnb-0000Be-BA
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 09:46:40 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Wed, 23 Jan 2019 15:46:03 +0100
Message-Id: <20190123144610.8842-3-mreitz@redhat.com>
In-Reply-To: <20190123144610.8842-1-mreitz@redhat.com>
References: <20190123144610.8842-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 2/9] iotests: Remove superfluous rm from 232
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>

This test creates no such file.

Signed-off-by: Max Reitz <mreitz@redhat.com>
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
