Received: from eggs.gnu.org ([209.51.188.92]:43239)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hLpUV-00079X-Bt
	for qemu-devel@nongnu.org; Wed, 01 May 2019 09:41:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hLpUS-0006Ns-A6
	for qemu-devel@nongnu.org; Wed, 01 May 2019 09:41:43 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Wed,  1 May 2019 15:41:27 +0200
Message-Id: <20190501134127.21104-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] tests/qemu-iotests: Fix more reference output
 files due to recent qemu-io change
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Cc: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

The output of qemu-io changed recently - most tests have been fixed in
commit 36b9986b08787019ef42 ("tests/qemu-iotests: Fix output of qemu-io
related tests") already, but the qcow1 and the vmdk test was still missin=
g.

Fixes: 99e98d7c9fc1a1639fad ("qemu-io: Use error_[gs]et_progname()")
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/qemu-iotests/059.out |  8 ++++----
 tests/qemu-iotests/092.out | 24 ++++++++++++------------
 2 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/tests/qemu-iotests/059.out b/tests/qemu-iotests/059.out
index 700ad1f290..f51394ae8e 100644
--- a/tests/qemu-iotests/059.out
+++ b/tests/qemu-iotests/059.out
@@ -2,15 +2,15 @@ QA output created by 059
=20
 =3D=3D=3D Testing invalid granularity =3D=3D=3D
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864
-can't open device TEST_DIR/t.vmdk: Invalid granularity, image may be cor=
rupt
+qemu-io: can't open device TEST_DIR/t.vmdk: Invalid granularity, image m=
ay be corrupt
=20
 =3D=3D=3D Testing too big L2 table size =3D=3D=3D
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864
-can't open device TEST_DIR/t.vmdk: L2 table size too big
+qemu-io: can't open device TEST_DIR/t.vmdk: L2 table size too big
=20
 =3D=3D=3D Testing too big L1 table size =3D=3D=3D
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864
-can't open device TEST_DIR/t.vmdk: L1 size too big
+qemu-io: can't open device TEST_DIR/t.vmdk: L1 size too big
=20
 =3D=3D=3D Testing monolithicFlat creation and opening =3D=3D=3D
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D2147483648 subformat=
=3DmonolithicFlat
@@ -2050,7 +2050,7 @@ wrote 512/512 bytes at offset 10240
=20
 =3D=3D=3D Testing monolithicFlat with internally generated JSON file nam=
e =3D=3D=3D
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864 subformat=3D=
monolithicFlat
-can't open: Cannot use relative extent paths with VMDK descriptor file '=
json:{"image": {"driver": "file", "filename": "TEST_DIR/t.IMGFMT"}, "driv=
er": "blkdebug", "inject-error.0.event": "read_aio"}'
+qemu-io: can't open: Cannot use relative extent paths with VMDK descript=
or file 'json:{"image": {"driver": "file", "filename": "TEST_DIR/t.IMGFMT=
"}, "driver": "blkdebug", "inject-error.0.event": "read_aio"}'
=20
 =3D=3D=3D Testing version 3 =3D=3D=3D
 image: TEST_DIR/iotest-version3.IMGFMT
diff --git a/tests/qemu-iotests/092.out b/tests/qemu-iotests/092.out
index 6eda321fc6..3e79914873 100644
--- a/tests/qemu-iotests/092.out
+++ b/tests/qemu-iotests/092.out
@@ -2,25 +2,25 @@ QA output created by 092
=20
 =3D=3D Invalid cluster size =3D=3D
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864
-can't open device TEST_DIR/t.qcow: Cluster size must be between 512 and =
64k
-can't open device TEST_DIR/t.qcow: Cluster size must be between 512 and =
64k
-can't open device TEST_DIR/t.qcow: Cluster size must be between 512 and =
64k
-can't open device TEST_DIR/t.qcow: Cluster size must be between 512 and =
64k
+qemu-io: can't open device TEST_DIR/t.qcow: Cluster size must be between=
 512 and 64k
+qemu-io: can't open device TEST_DIR/t.qcow: Cluster size must be between=
 512 and 64k
+qemu-io: can't open device TEST_DIR/t.qcow: Cluster size must be between=
 512 and 64k
+qemu-io: can't open device TEST_DIR/t.qcow: Cluster size must be between=
 512 and 64k
=20
 =3D=3D Invalid L2 table size =3D=3D
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864
-can't open device TEST_DIR/t.qcow: L2 table size must be between 512 and=
 64k
-can't open device TEST_DIR/t.qcow: L2 table size must be between 512 and=
 64k
-can't open device TEST_DIR/t.qcow: L2 table size must be between 512 and=
 64k
-can't open device TEST_DIR/t.qcow: L2 table size must be between 512 and=
 64k
+qemu-io: can't open device TEST_DIR/t.qcow: L2 table size must be betwee=
n 512 and 64k
+qemu-io: can't open device TEST_DIR/t.qcow: L2 table size must be betwee=
n 512 and 64k
+qemu-io: can't open device TEST_DIR/t.qcow: L2 table size must be betwee=
n 512 and 64k
+qemu-io: can't open device TEST_DIR/t.qcow: L2 table size must be betwee=
n 512 and 64k
=20
 =3D=3D Invalid size =3D=3D
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864
-can't open device TEST_DIR/t.qcow: Image too large
-can't open device TEST_DIR/t.qcow: Image too large
+qemu-io: can't open device TEST_DIR/t.qcow: Image too large
+qemu-io: can't open device TEST_DIR/t.qcow: Image too large
=20
 =3D=3D Invalid backing file length =3D=3D
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864
-can't open device TEST_DIR/t.qcow: Backing file name too long
-can't open device TEST_DIR/t.qcow: Backing file name too long
+qemu-io: can't open device TEST_DIR/t.qcow: Backing file name too long
+qemu-io: can't open device TEST_DIR/t.qcow: Backing file name too long
 *** done
--=20
2.21.0
