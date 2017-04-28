Received: from eggs.gnu.org ([2001:4830:134:3::10]:55477)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d4Cal-0001az-70
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 16:34:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d4Cak-0001By-Ak
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 16:34:15 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 28 Apr 2017 22:33:18 +0200
Message-Id: <1493411622-5343-11-git-send-email-kwolf@redhat.com>
In-Reply-To: <1493411622-5343-1-git-send-email-kwolf@redhat.com>
References: <1493411622-5343-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 10/34] iotests/051: Add test for empty filename
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

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Fam Zheng <famz@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/051        | 1 +
 tests/qemu-iotests/051.out    | 3 +++
 tests/qemu-iotests/051.pc.out | 3 +++
 3 files changed, 7 insertions(+)

diff --git a/tests/qemu-iotests/051 b/tests/qemu-iotests/051
index 7c78a02..26c29de 100755
--- a/tests/qemu-iotests/051
+++ b/tests/qemu-iotests/051
@@ -232,6 +232,7 @@ echo === Leaving out required options ===
 echo
 
 run_qemu -drive driver=file
+run_qemu -drive driver=file,filename=
 run_qemu -drive driver=nbd
 run_qemu -drive driver=raw
 run_qemu -drive file.driver=file
diff --git a/tests/qemu-iotests/051.out b/tests/qemu-iotests/051.out
index 3b7b040..4d3b1ff 100644
--- a/tests/qemu-iotests/051.out
+++ b/tests/qemu-iotests/051.out
@@ -221,6 +221,9 @@ QEMU X.Y.Z monitor - type 'help' for more information
 Testing: -drive driver=file
 QEMU_PROG: -drive driver=file: The 'file' block driver requires a file name
 
+Testing: -drive driver=file,filename=
+QEMU_PROG: -drive driver=file,filename=: The 'file' block driver requires a file name
+
 Testing: -drive driver=nbd
 QEMU_PROG: -drive driver=nbd: NBD server address missing
 
diff --git a/tests/qemu-iotests/051.pc.out b/tests/qemu-iotests/051.pc.out
index 7f9a121..76d7205 100644
--- a/tests/qemu-iotests/051.pc.out
+++ b/tests/qemu-iotests/051.pc.out
@@ -319,6 +319,9 @@ QEMU X.Y.Z monitor - type 'help' for more information
 Testing: -drive driver=file
 QEMU_PROG: -drive driver=file: The 'file' block driver requires a file name
 
+Testing: -drive driver=file,filename=
+QEMU_PROG: -drive driver=file,filename=: The 'file' block driver requires a file name
+
 Testing: -drive driver=nbd
 QEMU_PROG: -drive driver=nbd: NBD server address missing
 
-- 
1.8.3.1
