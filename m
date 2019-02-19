Received: from eggs.gnu.org ([209.51.188.92]:39514)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gw43y-0006Bs-Iw
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 06:59:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gw43u-0003xE-C5
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 06:59:48 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Tue, 19 Feb 2019 11:59:37 +0000
Message-Id: <20190219115937.21587-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] iotests: drop unnecessary accel=kvm
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Thomas Huth <thuth@redhat.com>

Tests 235 and 238 do not require the kvm accelerator.  TCG works fine.

Use the default accelerator instead of requiring kvm.

Suggested-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 tests/qemu-iotests/235 | 1 -
 tests/qemu-iotests/238 | 1 -
 2 files changed, 2 deletions(-)

diff --git a/tests/qemu-iotests/235 b/tests/qemu-iotests/235
index d6edd97ab4..329da8f0c2 100755
--- a/tests/qemu-iotests/235
+++ b/tests/qemu-iotests/235
@@ -49,7 +49,6 @@ qemu_img_create('-f', iotests.imgfmt, '-o', 'preallocat=
ion=3Dmetadata', disk,
                 str(size))
=20
 vm =3D QEMUMachine(iotests.qemu_prog)
-vm.add_args('-machine', 'accel=3Dkvm')
 if iotests.qemu_default_machine =3D=3D 's390-ccw-virtio':
         vm.add_args('-no-shutdown')
 vm.add_args('-drive', 'id=3Dsrc,file=3D' + disk)
diff --git a/tests/qemu-iotests/238 b/tests/qemu-iotests/238
index f81ee1112f..e490bb4298 100755
--- a/tests/qemu-iotests/238
+++ b/tests/qemu-iotests/238
@@ -33,7 +33,6 @@ else:
     virtio_scsi_device =3D 'virtio-scsi-pci'
=20
 vm =3D QEMUMachine(iotests.qemu_prog)
-vm.add_args('-machine', 'accel=3Dkvm')
 vm.launch()
=20
 log(vm.qmp('blockdev-add', node_name=3D'hd0', driver=3D'null-co'))
--=20
2.20.1
