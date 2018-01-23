Received: from eggs.gnu.org ([2001:4830:134:3::10]:58010)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1edzA4-0003mU-9H
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 09:02:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1edzA3-000682-9S
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 09:02:52 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 23 Jan 2018 15:01:52 +0100
Message-Id: <20180123140201.31163-21-kwolf@redhat.com>
In-Reply-To: <20180123140201.31163-1-kwolf@redhat.com>
References: <20180123140201.31163-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 20/29] iotests: Fix 051 for compat=0.10
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

051 has both compat=1.1 and compat=0.10 tests (once it uses
lazy_refcounts, once it tests that setting them does not work).
For the compat=0.10 tests, it already explicitly creates a suitable
image.  So let's just ignore the user-specified compat level for the
lazy_refcounts test and explicitly create a compat=1.1 image there, too.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Message-id: 20171123020832.8165-12-mreitz@redhat.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/051        | 2 ++
 tests/qemu-iotests/051.out    | 1 +
 tests/qemu-iotests/051.pc.out | 1 +
 3 files changed, 4 insertions(+)

diff --git a/tests/qemu-iotests/051 b/tests/qemu-iotests/051
index dba8816c9f..0c3be16489 100755
--- a/tests/qemu-iotests/051
+++ b/tests/qemu-iotests/051
@@ -131,6 +131,8 @@ echo
 echo === Enable and disable lazy refcounting on the command line, plus some invalid values ===
 echo
 
+_make_test_img -o compat=1.1 "$size"
+
 run_qemu -drive file="$TEST_IMG",format=qcow2,lazy-refcounts=on
 run_qemu -drive file="$TEST_IMG",format=qcow2,lazy-refcounts=off
 run_qemu -drive file="$TEST_IMG",format=qcow2,lazy-refcounts=
diff --git a/tests/qemu-iotests/051.out b/tests/qemu-iotests/051.out
index e3c6eaba57..dd9846d1ce 100644
--- a/tests/qemu-iotests/051.out
+++ b/tests/qemu-iotests/051.out
@@ -77,6 +77,7 @@ QEMU_PROG: -drive file=TEST_DIR/t.qcow2,file.backing.driver=qcow2,file.backing.f
 
 === Enable and disable lazy refcounting on the command line, plus some invalid values ===
 
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728
 Testing: -drive file=TEST_DIR/t.qcow2,format=qcow2,lazy-refcounts=on
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) quit
diff --git a/tests/qemu-iotests/051.pc.out b/tests/qemu-iotests/051.pc.out
index f2c5622cee..830c11880a 100644
--- a/tests/qemu-iotests/051.pc.out
+++ b/tests/qemu-iotests/051.pc.out
@@ -77,6 +77,7 @@ QEMU_PROG: -drive file=TEST_DIR/t.qcow2,file.backing.driver=qcow2,file.backing.f
 
 === Enable and disable lazy refcounting on the command line, plus some invalid values ===
 
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728
 Testing: -drive file=TEST_DIR/t.qcow2,format=qcow2,lazy-refcounts=on
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) quit
-- 
2.13.6
