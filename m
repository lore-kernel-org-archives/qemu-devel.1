Received: from eggs.gnu.org ([2001:4830:134:3::10]:33703)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cyhGi-0006Kh-AW
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 12:06:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cyhGh-0004BR-5l
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 12:06:48 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Thu, 13 Apr 2017 18:06:25 +0200
Message-Id: <20170413160625.27719-3-mreitz@redhat.com>
In-Reply-To: <20170413160625.27719-1-mreitz@redhat.com>
References: <20170413160625.27719-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.10 2/2] iotests/051: Add test for empty
 filename
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/051        | 1 +
 tests/qemu-iotests/051.out    | 3 +++
 tests/qemu-iotests/051.pc.out | 3 +++
 3 files changed, 7 insertions(+)

diff --git a/tests/qemu-iotests/051 b/tests/qemu-iotests/051
index 630cb7a114..4fe676019b 100755
--- a/tests/qemu-iotests/051
+++ b/tests/qemu-iotests/051
@@ -231,6 +231,7 @@ echo === Leaving out required options ===
 echo
 
 run_qemu -drive driver=file
+run_qemu -drive driver=file,filename=
 run_qemu -drive driver=nbd
 run_qemu -drive driver=raw
 run_qemu -drive file.driver=file
diff --git a/tests/qemu-iotests/051.out b/tests/qemu-iotests/051.out
index 7524c62025..57bee086f0 100644
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
index c6f4eef215..19426e5eda 100644
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
2.12.2
