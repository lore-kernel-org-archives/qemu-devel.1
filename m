Received: from eggs.gnu.org ([209.51.188.92]:44474)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1h1CeI-0007nj-5b
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 11:10:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1h1CeG-00011y-7w
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 11:10:34 -0500
From: Alberto Garcia <berto@igalia.com>
Date: Tue, 05 Mar 2019 17:10:26 +0100
Message-ID: <w51y35tb8ul.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] iotest 223 is flaky
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>

I can make it fail by running it a few times:

223 1s ... - output mismatch (see 223.out.bad)
--- tests/qemu-iotests/223.out       2019-02-08 17:25:15.584387100 +0200
+++ tests/qemu-iotests/223.out.bad     2019-03-05 18:05:16.855223976 +0200
@@ -92,9 +92,10 @@
 
 === Use qemu-nbd as server ===
 
-[{ "start": 0, "length": 65536, "depth": 0, "zero": false, "data": false},
-{ "start": 65536, "length": 2031616, "depth": 0, "zero": false, "data": true},
-{ "start": 2097152, "length": 2097152, "depth": 0, "zero": false, "data": false}]
+qemu-nbd: Failed to blk_new_open 'tests/qemu-iotests/scratch/t.qcow2': Failed to get shared "write" lock
+Is another process using the image [tests/qemu-iotests/scratch/t.qcow2]?
+qemu-img: Could not open 'driver=nbd,server.type=unix,server.path=tests/qemu-iotests/scratch/qemu-nbd.sock,x-dirty-bitmap=qemu:dirty-bitmap:b': Failed to connect socket tests/qemu-iotests/scratch/qemu-nbd.sock: Connection refused
+./common.nbd: line 33: kill: (11122) - No such process
 [{ "start": 0, "length": 512, "depth": 0, "zero": false, "data": true},
 { "start": 512, "length": 512, "depth": 0, "zero": false, "data": false},
 { "start": 1024, "length": 2096128, "depth": 0, "zero": false, "data": true},

Berto
