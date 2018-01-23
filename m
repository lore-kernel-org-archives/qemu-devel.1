Received: from eggs.gnu.org ([2001:4830:134:3::10]:58145)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1edzAF-00041W-Oh
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 09:03:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1edzA6-0006FD-4n
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 09:03:03 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 23 Jan 2018 15:01:55 +0100
Message-Id: <20180123140201.31163-24-kwolf@redhat.com>
In-Reply-To: <20180123140201.31163-1-kwolf@redhat.com>
References: <20180123140201.31163-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 23/29] iotests: Make 089 compatible with
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

The only thing that is missing is a _filter_img_info after the
"$QEMU_IO -c info" invocations.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Message-id: 20171123020832.8165-15-mreitz@redhat.com
Reviewed-by: John Snow <jsnow@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/089     |  4 ++--
 tests/qemu-iotests/089.out | 10 ----------
 2 files changed, 2 insertions(+), 12 deletions(-)

diff --git a/tests/qemu-iotests/089 b/tests/qemu-iotests/089
index 9bfe2307b3..0b059aba90 100755
--- a/tests/qemu-iotests/089
+++ b/tests/qemu-iotests/089
@@ -119,11 +119,11 @@ echo
 
 # Both options given directly and those given in the filename should be used
 $QEMU_IO -c "open -o driver=qcow2 json:{\"file.filename\":\"$TEST_IMG\"}" \
-         -c "info" 2>&1 | _filter_testdir | _filter_imgfmt
+         -c "info" 2>&1 | _filter_img_info
 
 # Options given directly should be prioritized over those given in the filename
 $QEMU_IO -c "open -o driver=qcow2 json:{\"driver\":\"raw\",\"file.filename\":\"$TEST_IMG\"}" \
-         -c "info" 2>&1 | _filter_testdir | _filter_imgfmt
+         -c "info" 2>&1 | _filter_img_info
 
 
 # success, all done
diff --git a/tests/qemu-iotests/089.out b/tests/qemu-iotests/089.out
index 18f5fdda7a..0bf5a13ec1 100644
--- a/tests/qemu-iotests/089.out
+++ b/tests/qemu-iotests/089.out
@@ -38,17 +38,7 @@ cluster_size: 65536
 format name: IMGFMT
 cluster size: 64 KiB
 vm state offset: 512 MiB
-Format specific information:
-    compat: 1.1
-    lazy refcounts: false
-    refcount bits: 16
-    corrupt: false
 format name: IMGFMT
 cluster size: 64 KiB
 vm state offset: 512 MiB
-Format specific information:
-    compat: 1.1
-    lazy refcounts: false
-    refcount bits: 16
-    corrupt: false
 *** done
-- 
2.13.6
