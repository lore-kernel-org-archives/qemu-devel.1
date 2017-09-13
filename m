Received: from eggs.gnu.org ([2001:4830:134:3::10]:37636)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ds3hM-000768-3V
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 05:11:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ds3hI-000442-3t
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 05:11:07 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Wed, 13 Sep 2017 11:10:38 +0200
Message-Id: <20170913091038.2900-4-cohuck@redhat.com>
In-Reply-To: <20170913091038.2900-1-cohuck@redhat.com>
References: <20170913091038.2900-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PATCH v2 3/3] iotests: use virtio aliases for 067
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: kwolf@redhat.com, mreitz@redhat.com
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, borntraeger@de.ibm.com, agraf@suse.de, thuth@redhat.com, david@redhat.com, haoqf@linux.vnet.ibm.com, Cornelia Huck <cohuck@redhat.com>

The default cpu model on s390x does not provide zPCI, which is
not yet wired up on tcg. Moreover, virtio-ccw is the standard
on s390x.

Using virtio-scsi will implicitly pick the right device, so just
switch to that for simplicity.

Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 tests/qemu-iotests/067     | 3 ++-
 tests/qemu-iotests/067.out | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/tests/qemu-iotests/067 b/tests/qemu-iotests/067
index 5d4ca4bc61..cbb3da286a 100755
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
@@ -150,6 +150,7 @@ run_qemu -device virtio-scsi-pci -device scsi-cd,id=cd0 <<EOF
 { "execute": "quit" }
 EOF
 
+
 # success, all done
 echo "*** done"
 rm -f $seq.full
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
