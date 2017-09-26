Received: from eggs.gnu.org ([2001:4830:134:3::10]:32941)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dwqkY-0001Zd-Vt
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 10:22:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dwqkR-0005O3-A8
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 10:22:14 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 26 Sep 2017 16:21:16 +0200
Message-Id: <20170926142133.2498-8-kwolf@redhat.com>
In-Reply-To: <20170926142133.2498-1-kwolf@redhat.com>
References: <20170926142133.2498-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 07/24] iotests: use virtio aliases for 067
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

From: Cornelia Huck <cohuck@redhat.com>

The default cpu model on s390x does not provide zPCI, which is
not yet wired up on tcg. Moreover, virtio-ccw is the standard
on s390x.

Using virtio-scsi will implicitly pick the right device, so just
switch to that for simplicity.

Signed-off-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: QingFeng Hao <haoqf@linux.vnet.ibm.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/067     | 2 +-
 tests/qemu-iotests/067.out | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/qemu-iotests/067 b/tests/qemu-iotests/067
index 5d4ca4bc61..ee9595f0da 100755
--- a/tests/qemu-iotests/067
+++ b/tests/qemu-iotests/067
@@ -141,7 +141,7 @@ echo
 echo === Empty drive with -device and device_del ===
 echo
 
-run_qemu -device virtio-scsi-pci -device scsi-cd,id=cd0 <<EOF
+run_qemu -device virtio-scsi -device scsi-cd,id=cd0 <<EOF
 { "execute": "qmp_capabilities" }
 { "execute": "query-block" }
 { "execute": "device_del", "arguments": { "id": "cd0" } }
diff --git a/tests/qemu-iotests/067.out b/tests/qemu-iotests/067.out
index bd70557ddc..58e83c4505 100644
--- a/tests/qemu-iotests/067.out
+++ b/tests/qemu-iotests/067.out
@@ -419,7 +419,7 @@ Testing:
 
 === Empty drive with -device and device_del ===
 
-Testing: -device virtio-scsi-pci -device scsi-cd,id=cd0
+Testing: -device virtio-scsi -device scsi-cd,id=cd0
 {
     QMP_VERSION
 }
-- 
2.13.5
