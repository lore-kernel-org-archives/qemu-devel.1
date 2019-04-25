Received: from eggs.gnu.org ([209.51.188.92]:50855)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hJbcm-0006Uf-1R
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 06:29:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hJbcj-0000rv-AG
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 06:29:02 -0400
References: <20190131164614.19209-1-cfergeau@redhat.com>
	<20190131164614.19209-2-cfergeau@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <42cbc07b-6525-ef95-69be-14786554b76b@redhat.com>
Date: Thu, 25 Apr 2019 12:28:39 +0200
MIME-Version: 1.0
In-Reply-To: <20190131164614.19209-2-cfergeau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v7 1/2] qemu-io: Use error_[gs]et_progname()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christophe Fergeau <cfergeau@redhat.com>, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Qemu-block <qemu-block@nongnu.org>

On 31/01/2019 17.46, Christophe Fergeau wrote:
> qemu-io reimplements itself what
> error_get_progname()/error_set_progname() already does.
> This commit switches it to use this API from qemu-error.h
> 
> Signed-off-by: Christophe Fergeau <cfergeau@redhat.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

This patch causes some qemu-iotests to fail now, e.g.:

cd tests/qemu-iotests
./check -qcow2 114
[...]
114 0s ... - output mismatch (see 114.out.bad)
--- /home/thuth/devel/qemu/tests/qemu-iotests/114.out	2019-04-23
16:43:12.000000000 +0200
+++ /home/thuth/tmp/qemu-build/tests/qemu-iotests/114.out.bad	2019-04-25
12:27:47.000000000 +0200
@@ -7,7 +7,7 @@
 cluster_size: 65536
 backing file: TEST_DIR/t.IMGFMT.base
 backing file format: foo
-can't open device TEST_DIR/t.qcow2: Could not open backing file:
Unknown driver 'foo'
+qemu-io: can't open device TEST_DIR/t.qcow2: Could not open backing
file: Unknown driver 'foo'
 no file open, try 'help open'
 read 4096/4096 bytes at offset 0
 4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)

Could you please have a look?

 Thomas
