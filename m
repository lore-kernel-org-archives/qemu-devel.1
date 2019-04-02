Received: from eggs.gnu.org ([209.51.188.92]:59640)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hBIr4-0002PP-Ja
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 08:49:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hBIr3-0003Xd-Mr
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 08:49:30 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue,  2 Apr 2019 14:49:07 +0200
Message-Id: <20190402124907.24421-10-kwolf@redhat.com>
In-Reply-To: <20190402124907.24421-1-kwolf@redhat.com>
References: <20190402124907.24421-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 9/9] tests/qemu-iotests/235: Allow fallback to
 tcg
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

From: Thomas Huth <thuth@redhat.com>

iotest 235 currently only works with KVM - this is bad for systems where
it is not available, e.g. CI pipelines. The test also works when using
"tcg" as accelerator, so we can simply add that to the list of accelerato=
rs,
too.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/235 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/qemu-iotests/235 b/tests/qemu-iotests/235
index 75c203b30c..2b6a8c13be 100755
--- a/tests/qemu-iotests/235
+++ b/tests/qemu-iotests/235
@@ -49,7 +49,7 @@ qemu_img_create('-f', iotests.imgfmt, '-o', 'preallocat=
ion=3Dmetadata', disk,
                 str(size))
=20
 vm =3D QEMUMachine(iotests.qemu_prog)
-vm.add_args('-machine', 'accel=3Dkvm')
+vm.add_args('-machine', 'accel=3Dkvm:tcg')
 if iotests.qemu_default_machine =3D=3D 's390-ccw-virtio':
         vm.add_args('-no-shutdown')
 vm.add_args('-drive', 'id=3Dsrc,file=3D' + disk)
--=20
2.20.1
