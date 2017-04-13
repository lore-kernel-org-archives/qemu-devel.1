Received: from eggs.gnu.org ([2001:4830:134:3::10]:53694)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cyiTZ-0007mr-7x
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 13:24:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cyiTT-0005D8-2R
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 13:24:09 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Thu, 13 Apr 2017 19:23:33 +0200
Message-Id: <1492104214-29994-3-git-send-email-kwolf@redhat.com>
In-Reply-To: <1492104214-29994-1-git-send-email-kwolf@redhat.com>
References: <1492104214-29994-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH 2/3] qemu-iotests: Filter HMP readline escape
 characters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, eblake@redhat.com, quintela@redhat.com, dgilbert@redhat.com, stefanha@redhat.com, lvivier@redhat.com, qemu-devel@nongnu.org

The only thing the escape characters achieve is making the reference
output unreadable and lines that are potentially so long that git
doesn't want to put them into an email any more. Let's filter them out.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/028.out       | 2 +-
 tests/qemu-iotests/130.out       | 4 ++--
 tests/qemu-iotests/common.filter | 7 +++++++
 tests/qemu-iotests/common.qemu   | 4 ++--
 4 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/tests/qemu-iotests/028.out b/tests/qemu-iotests/028.out
index acd2870..7d54aeb 100644
--- a/tests/qemu-iotests/028.out
+++ b/tests/qemu-iotests/028.out
@@ -469,7 +469,7 @@ No errors were found on the image.
 block-backup
 
 Formatting 'TEST_DIR/t.IMGFMT.copy', fmt=IMGFMT size=4294968832 backing_file=TEST_DIR/t.IMGFMT.base backing_fmt=IMGFMT
-(qemu) i[K[Din[K[D[Dinf[K[D[D[Dinfo[K[D[D[D[Dinfo [K[D[D[D[D[Dinfo b[K[D[D[D[D[D[Dinfo bl[K[D[D[D[D[D[D[Dinfo blo[K[D[D[D[D[D[D[D[Dinfo bloc[K[D[D[D[D[D[D[D[D[Dinfo block[K[D[D[D[D[D[D[D[D[D[Dinfo block-[K[D[D[D[D[D[D[D[D[D[D[Dinfo block-j[K[D[D[D[D[D[D[D[D[D[D[D[Dinfo block-jo[K[D[D[D[D[D[D[D[D[D[D[D[D[Dinfo block-job[K[D[D[D[D[D[D[D[D[D[D[D[D[D[Dinfo block-jobs[K
+(qemu) info block-jobs
 No active jobs
 === IO: pattern 195
 read 512/512 bytes at offset 3221194240
diff --git a/tests/qemu-iotests/130.out b/tests/qemu-iotests/130.out
index ae95b50..93020c3 100644
--- a/tests/qemu-iotests/130.out
+++ b/tests/qemu-iotests/130.out
@@ -9,14 +9,14 @@ virtual size: 64M (67108864 bytes)
 === HMP commit ===
 
 QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) c[K[Dco[K[D[Dcom[K[D[D[Dcomm[K[D[D[D[Dcommi[K[D[D[D[D[Dcommit[K[D[D[D[D[D[Dcommit [K[D[D[D[D[D[D[Dcommit t[K[D[D[D[D[D[D[D[Dcommit te[K[D[D[D[D[D[D[D[D[Dcommit tes[K[D[D[D[D[D[D[D[D[D[Dcommit test[K[D[D[D[D[D[D[D[D[D[D[Dcommit testd[K[D[D[D[D[D[D[D[D[D[D[D[Dcommit testdi[K[D[D[D[D[D[D[D[D[D[D[D[D[Dcommit testdis[K[D[D[D[D[D[D[D[D[D[D[D[D[D[Dcommit testdisk[K
+(qemu) commit testdisk
 (qemu) 
 image: TEST_DIR/t.IMGFMT
 file format: IMGFMT
 virtual size: 64M (67108864 bytes)
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864 backing_file=TEST_DIR/t.IMGFMT.orig backing_fmt=raw
 QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) c[K[Dco[K[D[Dcom[K[D[D[Dcomm[K[D[D[D[Dcommi[K[D[D[D[D[Dcommit[K[D[D[D[D[D[Dcommit [K[D[D[D[D[D[D[Dcommit t[K[D[D[D[D[D[D[D[Dcommit te[K[D[D[D[D[D[D[D[D[Dcommit tes[K[D[D[D[D[D[D[D[D[D[Dcommit test[K[D[D[D[D[D[D[D[D[D[D[Dcommit testd[K[D[D[D[D[D[D[D[D[D[D[D[Dcommit testdi[K[D[D[D[D[D[D[D[D[D[D[D[D[Dcommit testdis[K[D[D[D[D[D[D[D[D[D[D[D[D[D[Dcommit testdisk[K
+(qemu) commit testdisk
 (qemu) 
 image: TEST_DIR/t.IMGFMT
 file format: IMGFMT
diff --git a/tests/qemu-iotests/common.filter b/tests/qemu-iotests/common.filter
index 1040013..78b7bfa 100644
--- a/tests/qemu-iotests/common.filter
+++ b/tests/qemu-iotests/common.filter
@@ -86,6 +86,13 @@ _filter_qmp()
         -e '    QMP_VERSION'
 }
 
+# readline makes HMP command strings so long that git complains
+_filter_hmp()
+{
+    sed -e 's/(qemu).*\o33\[D/(qemu) /g' \
+        -e 's/\o33\[K//g'
+}
+
 # replace block job offset
 _filter_block_job_offset()
 {
diff --git a/tests/qemu-iotests/common.qemu b/tests/qemu-iotests/common.qemu
index 4278789..7a78a00 100644
--- a/tests/qemu-iotests/common.qemu
+++ b/tests/qemu-iotests/common.qemu
@@ -59,7 +59,7 @@ function _timed_wait_for()
     do
         if [ -z "${silent}" ]; then
             echo "${resp}" | _filter_testdir | _filter_qemu \
-                           | _filter_qemu_io | _filter_qmp
+                           | _filter_qemu_io | _filter_qmp | _filter_hmp
         fi
         grep -q "${*}" < <(echo ${resp})
         if [ $? -eq 0 ]; then
@@ -217,7 +217,7 @@ function _cleanup_qemu()
 
         if [ -n "${wait}" ]; then
             cat <&${QEMU_OUT[$i]} | _filter_testdir | _filter_qemu \
-                                  | _filter_qemu_io | _filter_qmp
+                                  | _filter_qemu_io | _filter_qmp | _filter_hmp
         fi
         rm -f "${QEMU_FIFO_IN}_${i}" "${QEMU_FIFO_OUT}_${i}"
         eval "exec ${QEMU_IN[$i]}<&-"   # close file descriptors
-- 
1.8.3.1
