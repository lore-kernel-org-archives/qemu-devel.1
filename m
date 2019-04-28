Received: from eggs.gnu.org ([209.51.188.92]:46568)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hKlxu-0004Qn-PM
	for qemu-devel@nongnu.org; Sun, 28 Apr 2019 11:43:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hKlxt-0005PX-Q5
	for qemu-devel@nongnu.org; Sun, 28 Apr 2019 11:43:42 -0400
From: Thomas Huth <thuth@redhat.com>
Message-ID: <d9016c33-ef8f-7e79-d15f-4220c67efb10@redhat.com>
Date: Sun, 28 Apr 2019 17:43:35 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] Failing qemu-iotest 211 with -vdi
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>

QEMU iotest 211 is failing for me, too, when I run it with -vdi:

tests/qemu-iotests$ ./check -vdi 211
QEMU          -- "/home/thuth/tmp/qemu-build/tests/qemu-iotests/../../x86_64-softmmu/qemu-system-x86_64" -nodefaults -machine accel=qtest
QEMU_IMG      -- "/home/thuth/tmp/qemu-build/tests/qemu-iotests/../../qemu-img" 
QEMU_IO       -- "/home/thuth/tmp/qemu-build/tests/qemu-iotests/../../qemu-io"  --cache writeback -f vdi
QEMU_NBD      -- "/home/thuth/tmp/qemu-build/tests/qemu-iotests/../../qemu-nbd" 
IMGFMT        -- vdi
IMGPROTO      -- file
PLATFORM      -- Linux/x86_64 thuth 3.10.0-957.10.1.el7.x86_64
TEST_DIR      -- /home/thuth/tmp/qemu-build/tests/qemu-iotests/scratch
SOCKET_SCM_HELPER -- /home/thuth/tmp/qemu-build/tests/qemu-iotests/socket_scm_helper

211         - output mismatch (see 211.out.bad)
--- /home/thuth/devel/qemu/tests/qemu-iotests/211.out	2019-04-23 16:43:12.000000000 +0200
+++ /home/thuth/tmp/qemu-build/tests/qemu-iotests/211.out.bad	2019-04-28 17:41:19.000000000 +0200
@@ -55,8 +55,7 @@
 virtual size: 32M (33554432 bytes)
 cluster_size: 1048576
 
-[{ "start": 0, "length": 3072, "depth": 0, "zero": false, "data": true, "offset": 1024},
-{ "start": 3072, "length": 33551360, "depth": 0, "zero": true, "data": true, "offset": 4096}]
+[{ "start": 0, "length": 33554432, "depth": 0, "zero": true, "data": true, "offset": 1024}]
 
 === Invalid BlockdevRef ===
 
Failures: 211
Failed 1 of 1 tests

Any ideas how to fix this?

 Thomas
