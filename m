Received: from eggs.gnu.org ([209.51.188.92]:60498)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hJxXt-00043x-8O
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 05:53:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hJxMh-0000Eg-M6
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 05:41:56 -0400
From: Thomas Huth <thuth@redhat.com>
Message-ID: <dd85fab0-52df-9c2d-e402-28d7ce9867f1@redhat.com>
Date: Fri, 26 Apr 2019 11:41:47 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] Failing qemu-iotest 005 with raw
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Qemu-block <qemu-block@nongnu.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, hch@lst.de


When running iotest 005 with raw, the test currently fails for me:

005         - output mismatch (see 005.out.bad)
--- /home/thuth/devel/qemu/tests/qemu-iotests/005.out	2019-04-23
16:43:11.000000000 +0200
+++ /home/thuth/tmp/qemu-build/tests/qemu-iotests/005.out.bad	2019-04-26
11:34:11.000000000 +0200
@@ -1,13 +1,12 @@
 QA output created by 005

 creating large image
+qemu-img: TEST_DIR/t.IMGFMT: The image size is too large for file
format 'IMGFMT'
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=5368709120000

 small read
-read 4096/4096 bytes at offset 1024
-4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read failed: Input/output error

 small write
-wrote 4096/4096 bytes at offset 8192
-4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+write failed: Input/output error
 *** done


Could this be fixed somehow, or should the test rather be skipped for
IMGFMT=raw?

 Thomas
