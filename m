Received: from eggs.gnu.org ([209.51.188.92]:55003)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gvz0o-0004g1-2c
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 01:36:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gvz0n-0000s4-B1
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 01:36:14 -0500
From: Thomas Huth <thuth@redhat.com>
Message-ID: <cd28473f-b768-0c3e-82be-1e07e9c3e786@redhat.com>
Date: Tue, 19 Feb 2019 07:36:07 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] Failing qemu-iotest 233
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
Cc: Qemu-block <qemu-block@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>


 Hi Eric, hi Daniel,

QEMU iotest 233 is failing for me on RHEL7:

233                [07:29:30] [07:29:30] [failed, exit status 1] - output mismatch (see 233.out.bad)
--- /home/thuth/devel/qemu/tests/qemu-iotests/233.out	2019-02-19 07:14:45.000000000 +0100
+++ /home/thuth/tmp/qemu-build/tests/qemu-iotests/233.out.bad	2019-02-19 07:29:30.000000000 +0100
@@ -13,45 +13,7 @@
 1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 == check TLS client to plain server fails ==
-qemu-img: Could not open 'driver=nbd,host=127.0.0.1,port=PORT,tls-creds=tls0': Denied by server for option 5 (starttls)
-server reported: TLS not configured
-qemu-nbd: Denied by server for option 5 (starttls)
-server reported: TLS not configured
+qemu-nbd: Unable to import client certificate /tmp/qemu-iotests-quick-28354/tls/client1/client-cert.pem: Base64 unexpected header error.
 
 == check plain client to TLS server fails ==
-qemu-img: Could not open 'nbd://localhost:PORT': TLS negotiation required before option 8 (structured reply)
-server reported: Option 0x8 not permitted before TLS
-qemu-nbd: TLS negotiation required before option 8 (structured reply)
-server reported: Option 0x8 not permitted before TLS
-
-== check TLS works ==
-image: nbd://127.0.0.1:PORT
-file format: nbd
-virtual size: 64M (67108864 bytes)
-disk size: unavailable
-exports available: 1
- export: ''
-  size:  67108864
-  flags: 0x4ed ( flush fua trim zeroes df cache )
-  min block: 512
-  opt block: 4096
-  max block: 33554432
-  available meta contexts: 1
-   base:allocation
-
-== check TLS with different CA fails ==
-qemu-img: Could not open 'driver=nbd,host=127.0.0.1,port=PORT,tls-creds=tls0': The certificate hasn't got a known issuer
-qemu-nbd: The certificate hasn't got a known issuer
-
-== perform I/O over TLS ==
-read 1048576/1048576 bytes at offset 1048576
-1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-wrote 1048576/1048576 bytes at offset 1048576
-1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-read 1048576/1048576 bytes at offset 1048576
-1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-
-== final server log ==
-qemu-nbd: option negotiation failed: Verify failed: No certificate was found.
-qemu-nbd: option negotiation failed: Verify failed: No certificate was found.
-*** done
+qemu-nbd unexpectedly quit


Any ideas how to fix this?

 Thomas
