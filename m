Received: from eggs.gnu.org ([209.51.188.92]:57010)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gyJ55-0003To-Jj
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 11:26:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gyJ54-0004Hc-Nl
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 11:26:15 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Mon, 25 Feb 2019 16:18:31 +0000
Message-Id: <20190225161831.20103-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3] iotests: use -M accel=qtest in 238
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Thomas Huth <thuth@redhat.com>

Test 238 does not require the kvm accelerator.  tcg and qtest work too.

Use qtest since it's always built in while kvm and tcg are not.

Suggested-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 tests/qemu-iotests/238 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/qemu-iotests/238 b/tests/qemu-iotests/238
index f81ee1112f..c7f8d9422b 100755
--- a/tests/qemu-iotests/238
+++ b/tests/qemu-iotests/238
@@ -33,7 +33,7 @@ else:
     virtio_scsi_device =3D 'virtio-scsi-pci'
=20
 vm =3D QEMUMachine(iotests.qemu_prog)
-vm.add_args('-machine', 'accel=3Dkvm')
+vm.add_args('-machine', 'accel=3Dqtest')
 vm.launch()
=20
 log(vm.qmp('blockdev-add', node_name=3D'hd0', driver=3D'null-co'))
--=20
2.20.1
