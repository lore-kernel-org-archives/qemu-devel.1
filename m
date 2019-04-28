Received: from eggs.gnu.org ([209.51.188.92]:37944)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hKlcg-0007ic-Hv
	for qemu-devel@nongnu.org; Sun, 28 Apr 2019 11:21:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hKlce-0000V9-Ku
	for qemu-devel@nongnu.org; Sun, 28 Apr 2019 11:21:46 -0400
From: Thomas Huth <thuth@redhat.com>
Message-ID: <e3e75fd5-661e-95ab-d7d6-f9a7bf6548d4@redhat.com>
Date: Sun, 28 Apr 2019 17:21:34 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] Failing QEMU iotest 221
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Qemu-block <qemu-block@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>

QEMU iotest 221 is failing for me, too, when I run it with -raw:

tests/qemu-iotests$ ./check -raw 221
QEMU          -- "/home/thuth/tmp/qemu-build/tests/qemu-iotests/../../x86_64-softmmu/qemu-system-x86_64" -nodefaults -machine accel=qtest
QEMU_IMG      -- "/home/thuth/tmp/qemu-build/tests/qemu-iotests/../../qemu-img" 
QEMU_IO       -- "/home/thuth/tmp/qemu-build/tests/qemu-iotests/../../qemu-io"  --cache writeback -f raw
QEMU_NBD      -- "/home/thuth/tmp/qemu-build/tests/qemu-iotests/../../qemu-nbd" 
IMGFMT        -- raw
IMGPROTO      -- file
PLATFORM      -- Linux/x86_64 thuth 3.10.0-957.10.1.el7.x86_64
TEST_DIR      -- /home/thuth/tmp/qemu-build/tests/qemu-iotests/scratch
SOCKET_SCM_HELPER -- /home/thuth/tmp/qemu-build/tests/qemu-iotests/socket_scm_helper

221         - output mismatch (see 221.out.bad)
--- /home/thuth/devel/qemu/tests/qemu-iotests/221.out	2019-04-23 16:43:12.000000000 +0200
+++ /home/thuth/tmp/qemu-build/tests/qemu-iotests/221.out.bad	2019-04-28 17:18:52.000000000 +0200
@@ -7,10 +7,10 @@
 [{ "start": 0, "length": 43520, "depth": 0, "zero": true, "data": false, "offset": OFFSET}]
 wrote 1/1 bytes at offset 43008
 1 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-[{ "start": 0, "length": 40960, "depth": 0, "zero": true, "data": false, "offset": OFFSET},
-{ "start": 40960, "length": 2049, "depth": 0, "zero": false, "data": true, "offset": OFFSET},
+[{ "start": 0, "length": 43008, "depth": 0, "zero": true, "data": false, "offset": OFFSET},
+{ "start": 43008, "length": 1, "depth": 0, "zero": false, "data": true, "offset": OFFSET},
 { "start": 43009, "length": 511, "depth": 0, "zero": true, "data": false, "offset": OFFSET}]
-[{ "start": 0, "length": 40960, "depth": 0, "zero": true, "data": false, "offset": OFFSET},
-{ "start": 40960, "length": 2049, "depth": 0, "zero": false, "data": true, "offset": OFFSET},
+[{ "start": 0, "length": 43008, "depth": 0, "zero": true, "data": false, "offset": OFFSET},
+{ "start": 43008, "length": 1, "depth": 0, "zero": false, "data": true, "offset": OFFSET},
 { "start": 43009, "length": 511, "depth": 0, "zero": true, "data": false, "offset": OFFSET}]
 *** done
Failures: 221
Failed 1 of 1 tests

Any ideas how to fix this?

 Thomas
