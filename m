Received: from eggs.gnu.org ([209.51.188.92]:48803)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gmJoA-0000Aa-TL
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 09:47:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gmJo9-0000bD-7o
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 09:47:14 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Wed, 23 Jan 2019 15:46:09 +0100
Message-Id: <20190123144610.8842-9-mreitz@redhat.com>
In-Reply-To: <20190123144610.8842-1-mreitz@redhat.com>
References: <20190123144610.8842-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 8/9] iotests: Filter SSH paths
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

8908b253c4ad5f8874c8d13abec169c696a5cd32 has implemented filtering of
remote paths for NFS, but forgot SSH.  This patch takes care of that.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/common.rc | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/qemu-iotests/common.rc b/tests/qemu-iotests/common.rc
index e15e7a7c8e..09a27f02d0 100644
--- a/tests/qemu-iotests/common.rc
+++ b/tests/qemu-iotests/common.rc
@@ -145,6 +145,7 @@ else
         TEST_IMG=3D"nbd:127.0.0.1:10810"
     elif [ "$IMGPROTO" =3D "ssh" ]; then
         TEST_IMG_FILE=3D$TEST_DIR/t.$IMGFMT
+        REMOTE_TEST_DIR=3D"ssh://127.0.0.1$TEST_DIR"
         TEST_IMG=3D"ssh://127.0.0.1$TEST_IMG_FILE"
     elif [ "$IMGPROTO" =3D "nfs" ]; then
         TEST_IMG_FILE=3D$TEST_DIR/t.$IMGFMT
--=20
2.20.1
