Received: from eggs.gnu.org ([209.51.188.92]:57960)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hFLup-0007IG-FI
	for qemu-devel@nongnu.org; Sat, 13 Apr 2019 12:54:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hFLuo-0002rY-IM
	for qemu-devel@nongnu.org; Sat, 13 Apr 2019 12:54:07 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Sat, 13 Apr 2019 18:53:43 +0200
Message-Id: <20190413165343.9018-8-mreitz@redhat.com>
In-Reply-To: <20190413165343.9018-1-mreitz@redhat.com>
References: <20190413165343.9018-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 7/7] iotests: Test qemu-img convert -C
 --salvage
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>, "Denis V . Lunev" <den@openvz.org>

We do not support this combination (yet), so this should yield an error
message.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/082     | 1 +
 tests/qemu-iotests/082.out | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/tests/qemu-iotests/082 b/tests/qemu-iotests/082
index d0afa46e9a..c58b37127f 100755
--- a/tests/qemu-iotests/082
+++ b/tests/qemu-iotests/082
@@ -163,6 +163,7 @@ echo =3D=3D=3D convert: -C and other options =3D=3D=3D
 run_qemu_img convert -C -S 4k -O $IMGFMT "$TEST_IMG" "$TEST_IMG".target
 run_qemu_img convert -C -S 8k -O $IMGFMT "$TEST_IMG" "$TEST_IMG".target
 run_qemu_img convert -C -c -O $IMGFMT "$TEST_IMG" "$TEST_IMG".target
+run_qemu_img convert -C --salvage -O $IMGFMT "$TEST_IMG" "$TEST_IMG".tar=
get
=20
 echo
 echo =3D=3D=3D amend: Options specified more than once =3D=3D=3D
diff --git a/tests/qemu-iotests/082.out b/tests/qemu-iotests/082.out
index d36938da9b..9d4f7574c9 100644
--- a/tests/qemu-iotests/082.out
+++ b/tests/qemu-iotests/082.out
@@ -555,6 +555,9 @@ qemu-img: Cannot enable copy offloading when -S is us=
ed
 Testing: convert -C -c -O qcow2 TEST_DIR/t.qcow2 TEST_DIR/t.qcow2.target
 qemu-img: Cannot enable copy offloading when -c is used
=20
+Testing: convert -C --salvage -O qcow2 TEST_DIR/t.qcow2 TEST_DIR/t.qcow2=
.target
+qemu-img: Cannot use copy offloading in salvaging mode
+
 =3D=3D=3D amend: Options specified more than once =3D=3D=3D
=20
 Testing: amend -f foo -f qcow2 -o lazy_refcounts=3Don TEST_DIR/t.qcow2
--=20
2.20.1
