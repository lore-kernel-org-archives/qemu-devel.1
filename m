Received: from eggs.gnu.org ([209.51.188.92]:37128)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hKlZg-0006Jt-1W
	for qemu-devel@nongnu.org; Sun, 28 Apr 2019 11:18:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hKlZf-0007Xb-09
	for qemu-devel@nongnu.org; Sun, 28 Apr 2019 11:18:40 -0400
From: Thomas Huth <thuth@redhat.com>
Message-ID: <68cc5bbc-ed6f-e001-e376-ccd986683b88@redhat.com>
Date: Sun, 28 Apr 2019 17:18:28 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] Failing QEMU iotest 175
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Qemu-block <qemu-block@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>, Nir Soffer <nirsof@gmail.com>

QEMU iotest 175 is failing for me when I run it with -raw:

$ ./check -raw 175
QEMU          --
"/home/thuth/tmp/qemu-build/tests/qemu-iotests/../../x86_64-softmmu/qemu-system-x86_64"
-nodefaults -machine accel=qtest
QEMU_IMG      --
"/home/thuth/tmp/qemu-build/tests/qemu-iotests/../../qemu-img"
QEMU_IO       --
"/home/thuth/tmp/qemu-build/tests/qemu-iotests/../../qemu-io"  --cache
writeback -f raw
QEMU_NBD      --
"/home/thuth/tmp/qemu-build/tests/qemu-iotests/../../qemu-nbd"
IMGFMT        -- raw
IMGPROTO      -- file
PLATFORM      -- Linux/x86_64 thuth 3.10.0-957.10.1.el7.x86_64
TEST_DIR      -- /home/thuth/tmp/qemu-build/tests/qemu-iotests/scratch
SOCKET_SCM_HELPER --
/home/thuth/tmp/qemu-build/tests/qemu-iotests/socket_scm_helper

175         - output mismatch (see 175.out.bad)
--- /home/thuth/devel/qemu/tests/qemu-iotests/175.out	2019-04-23
16:43:12.000000000 +0200
+++ /home/thuth/tmp/qemu-build/tests/qemu-iotests/175.out.bad	2019-04-28
17:17:32.000000000 +0200
@@ -2,17 +2,17 @@

 == creating image with default preallocation ==
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576
-size=1048576, blocks=0
+size=1048576, blocks=2

 == creating image with preallocation off ==
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576 preallocation=off
-size=1048576, blocks=0
+size=1048576, blocks=2

 == creating image with preallocation full ==
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576 preallocation=full
-size=1048576, blocks=2048
+size=1048576, blocks=2050

 == creating image with preallocation falloc ==
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576
preallocation=falloc
-size=1048576, blocks=2048
+size=1048576, blocks=2050
  *** done
Failures: 175
Failed 1 of 1 tests

Any ideas how to fix this?

 Thomas
