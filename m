Received: from eggs.gnu.org ([2001:4830:134:3::10]:46494)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1d2jWx-0001WV-40
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 15:20:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1d2jWv-0002fB-Jy
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 15:20:15 -0400
From: Jeff Cody <jcody@redhat.com>
Date: Mon, 24 Apr 2017 15:19:53 -0400
Message-Id: <20170424192002.18622-4-jcody@redhat.com>
In-Reply-To: <20170424192002.18622-1-jcody@redhat.com>
References: <20170424192002.18622-1-jcody@redhat.com>
Subject: [Qemu-devel] [PULL v2 03/12] qemu-iotests: exclude vxhs from image
 creation via protocol
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: peter.maydell@linaro.org, jcody@redhat.com, qemu-devel@nongnu.org

The protocol VXHS does not support image creation.  Some tests expect
to be able to create images through the protocol.  Exclude VXHS from
these tests.

Signed-off-by: Jeff Cody <jcody@redhat.com>
---
 tests/qemu-iotests/017 | 1 +
 tests/qemu-iotests/020 | 1 +
 tests/qemu-iotests/029 | 1 +
 tests/qemu-iotests/073 | 1 +
 tests/qemu-iotests/114 | 1 +
 tests/qemu-iotests/130 | 1 +
 tests/qemu-iotests/134 | 1 +
 tests/qemu-iotests/156 | 1 +
 tests/qemu-iotests/158 | 1 +
 9 files changed, 9 insertions(+)

diff --git a/tests/qemu-iotests/017 b/tests/qemu-iotests/017
index e3f9e75..4f9302d 100755
--- a/tests/qemu-iotests/017
+++ b/tests/qemu-iotests/017
@@ -41,6 +41,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 # Any format supporting backing files
 _supported_fmt qcow qcow2 vmdk qed
 _supported_proto generic
+_unsupported_proto vxhs
 _supported_os Linux
 _unsupported_imgopts "subformat=monolithicFlat" "subformat=twoGbMaxExtentFlat"
 
diff --git a/tests/qemu-iotests/020 b/tests/qemu-iotests/020
index 9c4a68c..7a11110 100755
--- a/tests/qemu-iotests/020
+++ b/tests/qemu-iotests/020
@@ -43,6 +43,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 # Any format supporting backing files
 _supported_fmt qcow qcow2 vmdk qed
 _supported_proto generic
+_unsupported_proto vxhs
 _supported_os Linux
 _unsupported_imgopts "subformat=monolithicFlat" \
                      "subformat=twoGbMaxExtentFlat" \
diff --git a/tests/qemu-iotests/029 b/tests/qemu-iotests/029
index e639ac0..30bab24 100755
--- a/tests/qemu-iotests/029
+++ b/tests/qemu-iotests/029
@@ -42,6 +42,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 # Any format supporting intenal snapshots
 _supported_fmt qcow2
 _supported_proto generic
+_unsupported_proto vxhs
 _supported_os Linux
 # Internal snapshots are (currently) impossible with refcount_bits=1
 _unsupported_imgopts 'refcount_bits=1[^0-9]'
diff --git a/tests/qemu-iotests/073 b/tests/qemu-iotests/073
index ad37a61..40f85b1 100755
--- a/tests/qemu-iotests/073
+++ b/tests/qemu-iotests/073
@@ -39,6 +39,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 _supported_fmt qcow2
 _supported_proto generic
+_unsupported_proto vxhs
 _supported_os Linux
 
 CLUSTER_SIZE=64k
diff --git a/tests/qemu-iotests/114 b/tests/qemu-iotests/114
index f110d4f..5b7dc54 100755
--- a/tests/qemu-iotests/114
+++ b/tests/qemu-iotests/114
@@ -39,6 +39,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 _supported_fmt qcow2
 _supported_proto generic
+_unsupported_proto vxhs
 _supported_os Linux
 
 
diff --git a/tests/qemu-iotests/130 b/tests/qemu-iotests/130
index ecc8a5b..f941fc9 100755
--- a/tests/qemu-iotests/130
+++ b/tests/qemu-iotests/130
@@ -42,6 +42,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 _supported_fmt qcow2
 _supported_proto generic
+_unsupported_proto vxhs
 _supported_os Linux
 
 qemu_comm_method="monitor"
diff --git a/tests/qemu-iotests/134 b/tests/qemu-iotests/134
index af618b8..acce946 100755
--- a/tests/qemu-iotests/134
+++ b/tests/qemu-iotests/134
@@ -39,6 +39,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 _supported_fmt qcow2
 _supported_proto generic
+_unsupported_proto vxhs
 _supported_os Linux
 
 
diff --git a/tests/qemu-iotests/156 b/tests/qemu-iotests/156
index cc95ff1..78deaff 100755
--- a/tests/qemu-iotests/156
+++ b/tests/qemu-iotests/156
@@ -48,6 +48,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 _supported_fmt qcow2 qed
 _supported_proto generic
+_unsupported_proto vxhs
 _supported_os Linux
 
 # Create source disk
diff --git a/tests/qemu-iotests/158 b/tests/qemu-iotests/158
index a6cdd6d..ef8d70f 100755
--- a/tests/qemu-iotests/158
+++ b/tests/qemu-iotests/158
@@ -39,6 +39,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 _supported_fmt qcow2
 _supported_proto generic
+_unsupported_proto vxhs
 _supported_os Linux
 
 
-- 
2.9.3
