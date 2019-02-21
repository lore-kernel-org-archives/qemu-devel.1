Received: from eggs.gnu.org ([209.51.188.92]:51231)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gwlLV-0007aH-8c
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 05:12:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gwlLU-0007eN-Gs
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 05:12:49 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Thu, 21 Feb 2019 10:11:39 +0000
Message-Id: <20190221101139.2224-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2] iotests: drop unnecessary accel=kvm in 238
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Stefan Hajnoczi <stefanha@redhat.com>, Thomas Huth <thuth@redhat.com>

Test 238 does not require the kvm accelerator.  TCG works fine.

Use the default accelerator instead of requiring kvm.

Suggested-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
Vladimir, I have dropped the 235 change because I don't have time to
figure out the kvm/tcg vs qtest differences or add a skip function.
Sorry!

 tests/qemu-iotests/238 | 1 -
 1 file changed, 1 deletion(-)

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
