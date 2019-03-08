Received: from eggs.gnu.org ([209.51.188.92]:59223)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1h2F5I-00080f-Tx
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 07:58:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1h2F5G-0004le-U4
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 07:58:44 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri,  8 Mar 2019 13:57:51 +0100
Message-Id: <20190308125823.32535-2-kwolf@redhat.com>
In-Reply-To: <20190308125823.32535-1-kwolf@redhat.com>
References: <20190308125823.32535-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 01/33] iotests: use iotests.VM in 238
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

From: Stefan Hajnoczi <stefanha@redhat.com>

Test 238 does not require the kvm accelerator.  Using the qtest
accelerator allows the test to run in both non-kvm and non-tcg
environments.

iotests.VM implicitly uses the qtest accelerator and is really the class
that this test should be using.  Switch to that instead of
qemu.QEMUMachine.

Suggested-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/238 | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/tests/qemu-iotests/238 b/tests/qemu-iotests/238
index 688abc9acb..1c0a46fa90 100755
--- a/tests/qemu-iotests/238
+++ b/tests/qemu-iotests/238
@@ -23,17 +23,12 @@ import os
 import iotests
 from iotests import log
=20
-sys.path.append(os.path.join(os.path.dirname(__file__), '..', '..', 'pyt=
hon'))
-
-from qemu import QEMUMachine
-
 if iotests.qemu_default_machine =3D=3D 's390-ccw-virtio':
     virtio_scsi_device =3D 'virtio-scsi-ccw'
 else:
     virtio_scsi_device =3D 'virtio-scsi-pci'
=20
-vm =3D QEMUMachine(iotests.qemu_prog)
-vm.add_args('-machine', 'accel=3Dkvm')
+vm =3D iotests.VM()
 vm.launch()
=20
 log(vm.qmp('blockdev-add', node_name=3D'hd0', driver=3D'null-co'))
--=20
2.20.1
