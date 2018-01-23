Received: from eggs.gnu.org ([2001:4830:134:3::10]:58183)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1edzAM-00049B-PV
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 09:03:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1edzAD-0006PD-60
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 09:03:10 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 23 Jan 2018 15:02:01 +0100
Message-Id: <20180123140201.31163-30-kwolf@redhat.com>
In-Reply-To: <20180123140201.31163-1-kwolf@redhat.com>
References: <20180123140201.31163-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 29/29] iotests: Disable some tests for
 compat=0.10
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

From: Max Reitz <mreitz@redhat.com>

Tests 080, 130, 137, and 176 simply do not work with compat=0.10 for the
reasons stated there.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Message-Id: <20171123020832.8165-10-mreitz@redhat.com>
[eblake: fix 177 in a separate commit]
Signed-off-by: Eric Blake <eblake@redhat.com>
Message-id: 20180117165420.15946-3-eblake@redhat.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/080 | 5 +++--
 tests/qemu-iotests/130 | 2 ++
 tests/qemu-iotests/137 | 2 ++
 tests/qemu-iotests/176 | 2 ++
 4 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/tests/qemu-iotests/080 b/tests/qemu-iotests/080
index 55044c700b..1c2bd85742 100755
--- a/tests/qemu-iotests/080
+++ b/tests/qemu-iotests/080
@@ -41,8 +41,9 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 _supported_fmt qcow2
 _supported_proto file
 _supported_os Linux
-# Internal snapshots are (currently) impossible with refcount_bits=1
-_unsupported_imgopts 'refcount_bits=1[^0-9]'
+# - Internal snapshots are (currently) impossible with refcount_bits=1
+# - This is generally a test for compat=1.1 images
+_unsupported_imgopts 'refcount_bits=1[^0-9]' 'compat=0.10'
 
 header_size=104
 
diff --git a/tests/qemu-iotests/130 b/tests/qemu-iotests/130
index e7e43de6d6..2c4b94da1b 100755
--- a/tests/qemu-iotests/130
+++ b/tests/qemu-iotests/130
@@ -45,6 +45,8 @@ _supported_fmt qcow2
 _supported_proto generic
 _unsupported_proto vxhs
 _supported_os Linux
+# We are going to use lazy-refcounts
+_unsupported_imgopts 'compat=0.10'
 
 qemu_comm_method="monitor"
 
diff --git a/tests/qemu-iotests/137 b/tests/qemu-iotests/137
index eb91e517d7..5a01250005 100755
--- a/tests/qemu-iotests/137
+++ b/tests/qemu-iotests/137
@@ -41,6 +41,8 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 _supported_fmt qcow2
 _supported_proto file
 _supported_os Linux
+# We are going to use lazy-refcounts
+_unsupported_imgopts 'compat=0.10'
 
 
 _make_test_img 64M
diff --git a/tests/qemu-iotests/176 b/tests/qemu-iotests/176
index b8dc17c592..d38b3aeb91 100755
--- a/tests/qemu-iotests/176
+++ b/tests/qemu-iotests/176
@@ -48,6 +48,8 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 _supported_fmt qcow2
 _supported_proto file
 _supported_os Linux
+# Persistent dirty bitmaps require compat=1.1
+_unsupported_imgopts 'compat=0.10'
 
 function run_qemu()
 {
-- 
2.13.6
