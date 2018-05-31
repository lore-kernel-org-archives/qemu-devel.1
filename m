Received: from eggs.gnu.org ([2001:4830:134:3::10]:41985)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fOFxU-0000B1-2F
	for qemu-devel@nongnu.org; Thu, 31 May 2018 01:17:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fOFxP-0006GO-2f
	for qemu-devel@nongnu.org; Thu, 31 May 2018 01:17:08 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39866 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fOFxO-0006GE-RW
	for qemu-devel@nongnu.org; Thu, 31 May 2018 01:17:02 -0400
From: Peter Xu <peterx@redhat.com>
Date: Thu, 31 May 2018 13:16:39 +0800
Message-Id: <20180531051641.8473-3-peterx@redhat.com>
In-Reply-To: <20180531051641.8473-1-peterx@redhat.com>
References: <20180531051641.8473-1-peterx@redhat.com>
Subject: [Qemu-devel] [RFC v2 2/4] tests: iotests: don't compare SHUTDOWN
 event
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, peterx@redhat.com, Eric Auger <eric.auger@redhat.com>, Eric Blake <eblake@redhat.com>, John Snow <jsnow@redhat.com>, Markus Armbruster <armbru@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

This event is not really necessary.  After OOB series it might affect
the timing of the script so this event may or may not be there comparing
to the old *.out results.  Let's just filter it out.

Since some of the scripts are using qmp-pretty, we need some trick in
the filtering script to make sure sed works for multiple lines to
explicitly mask out this event.

CC: John Snow <jsnow@redhat.com>
CC: Max Reitz <mreitz@redhat.com>
CC: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tests/qemu-iotests/060.out       |  1 -
 tests/qemu-iotests/067.out       |  5 ++++
 tests/qemu-iotests/071.out       |  2 --
 tests/qemu-iotests/081.out       |  1 -
 tests/qemu-iotests/087.out       |  6 -----
 tests/qemu-iotests/094.out       |  1 -
 tests/qemu-iotests/109.out       | 22 ------------------
 tests/qemu-iotests/117.out       |  1 -
 tests/qemu-iotests/119.out       |  1 -
 tests/qemu-iotests/120.out       |  1 -
 tests/qemu-iotests/127.out       |  1 -
 tests/qemu-iotests/140.out       |  1 -
 tests/qemu-iotests/143.out       |  1 -
 tests/qemu-iotests/156.out       |  1 -
 tests/qemu-iotests/176.out       |  8 -------
 tests/qemu-iotests/183.out       |  2 --
 tests/qemu-iotests/184.out       | 40 --------------------------------
 tests/qemu-iotests/185.out       |  5 ----
 tests/qemu-iotests/191.out       | 20 ----------------
 tests/qemu-iotests/195.out       | 20 ----------------
 tests/qemu-iotests/206.out       | 11 ---------
 tests/qemu-iotests/207.out       |  6 -----
 tests/qemu-iotests/210.out       |  6 -----
 tests/qemu-iotests/211.out       |  7 ------
 tests/qemu-iotests/212.out       |  8 -------
 tests/qemu-iotests/213.out       |  9 -------
 tests/qemu-iotests/common.filter |  5 +++-
 27 files changed, 9 insertions(+), 183 deletions(-)

diff --git a/tests/qemu-iotests/060.out b/tests/qemu-iotests/060.out
index 25d5c3938b..6f06eee1f0 100644
--- a/tests/qemu-iotests/060.out
+++ b/tests/qemu-iotests/060.out
@@ -419,5 +419,4 @@ QMP_VERSION
 write failed: Input/output error
 {"return": ""}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
 *** done
diff --git a/tests/qemu-iotests/067.out b/tests/qemu-iotests/067.out
index 2e71cff3ce..babf8343c6 100644
--- a/tests/qemu-iotests/067.out
+++ b/tests/qemu-iotests/067.out
@@ -70,6 +70,7 @@ Testing: -drive file=TEST_DIR/t.IMGFMT,format=IMGFMT,if=none,id=disk -device vir
     }
 }
 
+
 === -drive/device_add and device_del ===
 
 Testing: -drive file=TEST_DIR/t.IMGFMT,format=IMGFMT,if=none,id=disk
@@ -141,6 +142,7 @@ Testing: -drive file=TEST_DIR/t.IMGFMT,format=IMGFMT,if=none,id=disk
     }
 }
 
+
 === drive_add/device_add and device_del ===
 
 Testing:
@@ -215,6 +217,7 @@ Testing:
     }
 }
 
+
 === blockdev_add/device_add and device_del ===
 
 Testing:
@@ -372,6 +375,7 @@ Testing:
     }
 }
 
+
 === Empty drive with -device and device_del ===
 
 Testing: -device virtio-scsi -device scsi-cd,id=cd0
@@ -410,4 +414,5 @@ Testing: -device virtio-scsi -device scsi-cd,id=cd0
     "return": {
     }
 }
+
 *** done
diff --git a/tests/qemu-iotests/071.out b/tests/qemu-iotests/071.out
index 1d5e28d730..64b64526ab 100644
--- a/tests/qemu-iotests/071.out
+++ b/tests/qemu-iotests/071.out
@@ -46,7 +46,6 @@ QMP_VERSION
 read failed: Input/output error
 {"return": ""}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
 
 
 === Testing blkverify on existing block device ===
@@ -85,7 +84,6 @@ wrote 512/512 bytes at offset 0
 read failed: Input/output error
 {"return": ""}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
 QEMU_PROG: Failed to flush the L2 table cache: Input/output error
 QEMU_PROG: Failed to flush the refcount block cache: Input/output error
 
diff --git a/tests/qemu-iotests/081.out b/tests/qemu-iotests/081.out
index 2533c31c78..737b7d6f9b 100644
--- a/tests/qemu-iotests/081.out
+++ b/tests/qemu-iotests/081.out
@@ -36,7 +36,6 @@ read 10485760/10485760 bytes at offset 0
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 {"return": ""}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
 
 
 == using quorum rewrite corrupted mode ==
diff --git a/tests/qemu-iotests/087.out b/tests/qemu-iotests/087.out
index b1318c6ed6..936ea81b3c 100644
--- a/tests/qemu-iotests/087.out
+++ b/tests/qemu-iotests/087.out
@@ -8,7 +8,6 @@ QMP_VERSION
 {"return": {}}
 {"error": {"class": "GenericError", "desc": "'node-name' must be specified for the root node"}}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
 
 
 === Duplicate ID ===
@@ -19,7 +18,6 @@ QMP_VERSION
 {"error": {"class": "GenericError", "desc": "node-name=disk is conflicting with a device id"}}
 {"error": {"class": "GenericError", "desc": "Duplicate node name"}}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
 
 
 === aio=native without O_DIRECT ===
@@ -29,7 +27,6 @@ QMP_VERSION
 {"return": {}}
 {"error": {"class": "GenericError", "desc": "aio=native was specified, but it requires cache.direct=on, which was not specified."}}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
 
 
 === Encrypted image QCow ===
@@ -41,7 +38,6 @@ QMP_VERSION
 {"return": {}}
 {"error": {"class": "GenericError", "desc": "Use of AES-CBC encrypted IMGFMT images is no longer supported in system emulators"}}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
 
 
 === Encrypted image LUKS ===
@@ -53,7 +49,6 @@ QMP_VERSION
 {"return": {}}
 {"return": {}}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
 
 
 === Missing driver ===
@@ -64,6 +59,5 @@ QMP_VERSION
 {"return": {}}
 {"error": {"class": "GenericError", "desc": "Parameter 'driver' is missing"}}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
 
 *** done
diff --git a/tests/qemu-iotests/094.out b/tests/qemu-iotests/094.out
index 665b630b08..19775ae1d0 100644
--- a/tests/qemu-iotests/094.out
+++ b/tests/qemu-iotests/094.out
@@ -14,5 +14,4 @@ Formatting 'TEST_DIR/source.IMGFMT', fmt=IMGFMT size=67108864
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "concluded", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "src"}}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
 *** done
diff --git a/tests/qemu-iotests/109.out b/tests/qemu-iotests/109.out
index ad0ee6fb48..dc5cfde259 100644
--- a/tests/qemu-iotests/109.out
+++ b/tests/qemu-iotests/109.out
@@ -18,7 +18,6 @@ WARNING: Image format was not specified for 'TEST_DIR/t.raw' and probing guessed
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "src"}}
 {"return": []}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
 read 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 {"return": {}}
@@ -29,7 +28,6 @@ read 65536/65536 bytes at offset 0
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_READY", "data": {"device": "src", "len": 1024, "offset": 1024, "speed": 0, "type": "mirror"}}
 {"return": [{"auto-finalize": true, "io-status": "ok", "device": "src", "auto-dismiss": true, "busy": false, "len": 1024, "offset": 1024, "status": "ready", "paused": false, "speed": 0, "ready": true, "type": "mirror"}]}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "waiting", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "pending", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_COMPLETED", "data": {"device": "src", "len": 1024, "offset": 1024, "speed": 0, "type": "mirror"}}
@@ -56,7 +54,6 @@ WARNING: Image format was not specified for 'TEST_DIR/t.raw' and probing guessed
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "src"}}
 {"return": []}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
 read 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 {"return": {}}
@@ -67,7 +64,6 @@ read 65536/65536 bytes at offset 0
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_READY", "data": {"device": "src", "len": 197120, "offset": 197120, "speed": 0, "type": "mirror"}}
 {"return": [{"auto-finalize": true, "io-status": "ok", "device": "src", "auto-dismiss": true, "busy": false, "len": 197120, "offset": 197120, "status": "ready", "paused": false, "speed": 0, "ready": true, "type": "mirror"}]}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "waiting", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "pending", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_COMPLETED", "data": {"device": "src", "len": 197120, "offset": 197120, "speed": 0, "type": "mirror"}}
@@ -94,7 +90,6 @@ WARNING: Image format was not specified for 'TEST_DIR/t.raw' and probing guessed
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "src"}}
 {"return": []}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
 read 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 {"return": {}}
@@ -105,7 +100,6 @@ read 65536/65536 bytes at offset 0
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_READY", "data": {"device": "src", "len": 327680, "offset": 327680, "speed": 0, "type": "mirror"}}
 {"return": [{"auto-finalize": true, "io-status": "ok", "device": "src", "auto-dismiss": true, "busy": false, "len": 327680, "offset": 327680, "status": "ready", "paused": false, "speed": 0, "ready": true, "type": "mirror"}]}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "waiting", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "pending", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_COMPLETED", "data": {"device": "src", "len": 327680, "offset": 327680, "speed": 0, "type": "mirror"}}
@@ -132,7 +126,6 @@ WARNING: Image format was not specified for 'TEST_DIR/t.raw' and probing guessed
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "src"}}
 {"return": []}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
 read 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 {"return": {}}
@@ -143,7 +136,6 @@ read 65536/65536 bytes at offset 0
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_READY", "data": {"device": "src", "len": 1024, "offset": 1024, "speed": 0, "type": "mirror"}}
 {"return": [{"auto-finalize": true, "io-status": "ok", "device": "src", "auto-dismiss": true, "busy": false, "len": 1024, "offset": 1024, "status": "ready", "paused": false, "speed": 0, "ready": true, "type": "mirror"}]}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "waiting", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "pending", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_COMPLETED", "data": {"device": "src", "len": 1024, "offset": 1024, "speed": 0, "type": "mirror"}}
@@ -170,7 +162,6 @@ WARNING: Image format was not specified for 'TEST_DIR/t.raw' and probing guessed
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "src"}}
 {"return": []}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
 read 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 {"return": {}}
@@ -181,7 +172,6 @@ read 65536/65536 bytes at offset 0
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_READY", "data": {"device": "src", "len": 65536, "offset": 65536, "speed": 0, "type": "mirror"}}
 {"return": [{"auto-finalize": true, "io-status": "ok", "device": "src", "auto-dismiss": true, "busy": false, "len": 65536, "offset": 65536, "status": "ready", "paused": false, "speed": 0, "ready": true, "type": "mirror"}]}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "waiting", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "pending", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_COMPLETED", "data": {"device": "src", "len": 65536, "offset": 65536, "speed": 0, "type": "mirror"}}
@@ -208,7 +198,6 @@ WARNING: Image format was not specified for 'TEST_DIR/t.raw' and probing guessed
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "src"}}
 {"return": []}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
 read 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 {"return": {}}
@@ -219,7 +208,6 @@ read 65536/65536 bytes at offset 0
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_READY", "data": {"device": "src", "len": 2560, "offset": 2560, "speed": 0, "type": "mirror"}}
 {"return": [{"auto-finalize": true, "io-status": "ok", "device": "src", "auto-dismiss": true, "busy": false, "len": 2560, "offset": 2560, "status": "ready", "paused": false, "speed": 0, "ready": true, "type": "mirror"}]}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "waiting", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "pending", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_COMPLETED", "data": {"device": "src", "len": 2560, "offset": 2560, "speed": 0, "type": "mirror"}}
@@ -245,7 +233,6 @@ WARNING: Image format was not specified for 'TEST_DIR/t.raw' and probing guessed
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "src"}}
 {"return": []}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
 read 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 {"return": {}}
@@ -256,7 +243,6 @@ read 65536/65536 bytes at offset 0
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_READY", "data": {"device": "src", "len": 2560, "offset": 2560, "speed": 0, "type": "mirror"}}
 {"return": [{"auto-finalize": true, "io-status": "ok", "device": "src", "auto-dismiss": true, "busy": false, "len": 2560, "offset": 2560, "status": "ready", "paused": false, "speed": 0, "ready": true, "type": "mirror"}]}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "waiting", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "pending", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_COMPLETED", "data": {"device": "src", "len": 2560, "offset": 2560, "speed": 0, "type": "mirror"}}
@@ -282,7 +268,6 @@ WARNING: Image format was not specified for 'TEST_DIR/t.raw' and probing guessed
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "src"}}
 {"return": []}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
 read 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 {"return": {}}
@@ -293,7 +278,6 @@ read 65536/65536 bytes at offset 0
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_READY", "data": {"device": "src", "len": 31457280, "offset": 31457280, "speed": 0, "type": "mirror"}}
 {"return": [{"auto-finalize": true, "io-status": "ok", "device": "src", "auto-dismiss": true, "busy": false, "len": 31457280, "offset": 31457280, "status": "ready", "paused": false, "speed": 0, "ready": true, "type": "mirror"}]}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "waiting", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "pending", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_COMPLETED", "data": {"device": "src", "len": 31457280, "offset": 31457280, "speed": 0, "type": "mirror"}}
@@ -319,7 +303,6 @@ WARNING: Image format was not specified for 'TEST_DIR/t.raw' and probing guessed
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "src"}}
 {"return": []}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
 read 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 {"return": {}}
@@ -330,7 +313,6 @@ read 65536/65536 bytes at offset 0
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_READY", "data": {"device": "src", "len": 327680, "offset": 327680, "speed": 0, "type": "mirror"}}
 {"return": [{"auto-finalize": true, "io-status": "ok", "device": "src", "auto-dismiss": true, "busy": false, "len": 327680, "offset": 327680, "status": "ready", "paused": false, "speed": 0, "ready": true, "type": "mirror"}]}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "waiting", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "pending", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_COMPLETED", "data": {"device": "src", "len": 327680, "offset": 327680, "speed": 0, "type": "mirror"}}
@@ -356,7 +338,6 @@ WARNING: Image format was not specified for 'TEST_DIR/t.raw' and probing guessed
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "src"}}
 {"return": []}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
 read 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 {"return": {}}
@@ -367,7 +348,6 @@ read 65536/65536 bytes at offset 0
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_READY", "data": {"device": "src", "len": 2048, "offset": 2048, "speed": 0, "type": "mirror"}}
 {"return": [{"auto-finalize": true, "io-status": "ok", "device": "src", "auto-dismiss": true, "busy": false, "len": 2048, "offset": 2048, "status": "ready", "paused": false, "speed": 0, "ready": true, "type": "mirror"}]}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "waiting", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "pending", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_COMPLETED", "data": {"device": "src", "len": 2048, "offset": 2048, "speed": 0, "type": "mirror"}}
@@ -390,7 +370,6 @@ WARNING: Image format was not specified for 'TEST_DIR/t.raw' and probing guessed
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_READY", "data": {"device": "src", "len": 512, "offset": 512, "speed": 0, "type": "mirror"}}
 {"return": [{"auto-finalize": true, "io-status": "ok", "device": "src", "auto-dismiss": true, "busy": false, "len": 512, "offset": 512, "status": "ready", "paused": false, "speed": 0, "ready": true, "type": "mirror"}]}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "waiting", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "pending", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_COMPLETED", "data": {"device": "src", "len": 512, "offset": 512, "speed": 0, "type": "mirror"}}
@@ -406,7 +385,6 @@ Images are identical.
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_READY", "data": {"device": "src", "len": 512, "offset": 512, "speed": 0, "type": "mirror"}}
 {"return": [{"auto-finalize": true, "io-status": "ok", "device": "src", "auto-dismiss": true, "busy": false, "len": 512, "offset": 512, "status": "ready", "paused": false, "speed": 0, "ready": true, "type": "mirror"}]}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "waiting", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "pending", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_COMPLETED", "data": {"device": "src", "len": 512, "offset": 512, "speed": 0, "type": "mirror"}}
diff --git a/tests/qemu-iotests/117.out b/tests/qemu-iotests/117.out
index 851e214144..324805c962 100644
--- a/tests/qemu-iotests/117.out
+++ b/tests/qemu-iotests/117.out
@@ -7,7 +7,6 @@ wrote 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 {"return": ""}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
 No errors were found on the image.
 read 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
diff --git a/tests/qemu-iotests/119.out b/tests/qemu-iotests/119.out
index a8743b810e..9969d04b3a 100644
--- a/tests/qemu-iotests/119.out
+++ b/tests/qemu-iotests/119.out
@@ -6,6 +6,5 @@ read 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 {"return": ""}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
 
 *** done
diff --git a/tests/qemu-iotests/120.out b/tests/qemu-iotests/120.out
index 1af1aeb38d..219928a811 100644
--- a/tests/qemu-iotests/120.out
+++ b/tests/qemu-iotests/120.out
@@ -6,7 +6,6 @@ wrote 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 {"return": ""}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
 read 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 read 65536/65536 bytes at offset 0
diff --git a/tests/qemu-iotests/127.out b/tests/qemu-iotests/127.out
index 83b522d4c2..b2d7c0cb99 100644
--- a/tests/qemu-iotests/127.out
+++ b/tests/qemu-iotests/127.out
@@ -17,5 +17,4 @@ wrote 42/42 bytes at offset 0
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "concluded", "id": "mirror"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "mirror"}}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
 *** done
diff --git a/tests/qemu-iotests/140.out b/tests/qemu-iotests/140.out
index 7295b3d975..ce2d65bc23 100644
--- a/tests/qemu-iotests/140.out
+++ b/tests/qemu-iotests/140.out
@@ -11,5 +11,4 @@ read 65536/65536 bytes at offset 0
 can't open device nbd+unix:///drv?socket=TEST_DIR/nbd: Requested export not available
 server reported: export 'drv' not present
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
 *** done
diff --git a/tests/qemu-iotests/143.out b/tests/qemu-iotests/143.out
index 1c7fb45543..ca78c86d0c 100644
--- a/tests/qemu-iotests/143.out
+++ b/tests/qemu-iotests/143.out
@@ -4,5 +4,4 @@ QA output created by 143
 can't open device nbd+unix:///no_such_export?socket=TEST_DIR/nbd: Requested export not available
 server reported: export 'no_such_export' not present
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
 *** done
diff --git a/tests/qemu-iotests/156.out b/tests/qemu-iotests/156.out
index 34c057b626..4f0e65840d 100644
--- a/tests/qemu-iotests/156.out
+++ b/tests/qemu-iotests/156.out
@@ -41,7 +41,6 @@ read 65536/65536 bytes at offset 196608
 {"return": ""}
 
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
 
 read 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
diff --git a/tests/qemu-iotests/176.out b/tests/qemu-iotests/176.out
index f03a2e776c..ab63d5bdb0 100644
--- a/tests/qemu-iotests/176.out
+++ b/tests/qemu-iotests/176.out
@@ -170,7 +170,6 @@ QMP_VERSION
 {"return": {}}
 {"return": {}}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
 wrote 196608/196608 bytes at offset 2147287040
 192 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 wrote 131072/131072 bytes at offset 2147352576
@@ -207,7 +206,6 @@ QMP_VERSION
 {"return": {}}
 {"return": {"sha256": HASH}}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
 
 === Test pass bitmap.1 ===
 
@@ -219,7 +217,6 @@ QMP_VERSION
 {"return": {}}
 {"return": {}}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
 wrote 196608/196608 bytes at offset 2147287040
 192 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 wrote 131072/131072 bytes at offset 2147352576
@@ -257,7 +254,6 @@ QMP_VERSION
 {"return": {}}
 {"return": {"sha256": HASH}}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
 
 === Test pass bitmap.2 ===
 
@@ -269,7 +265,6 @@ QMP_VERSION
 {"return": {}}
 {"return": {}}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
 wrote 196608/196608 bytes at offset 2147287040
 192 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 wrote 131072/131072 bytes at offset 2147352576
@@ -307,7 +302,6 @@ QMP_VERSION
 {"return": {}}
 {"return": {"sha256": HASH}}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
 
 === Test pass bitmap.3 ===
 
@@ -319,7 +313,6 @@ QMP_VERSION
 {"return": {}}
 {"return": {}}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
 wrote 196608/196608 bytes at offset 2147287040
 192 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 wrote 131072/131072 bytes at offset 2147352576
@@ -354,5 +347,4 @@ QMP_VERSION
 {"return": {}}
 {"return": {"sha256": HASH}}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
 *** done
diff --git a/tests/qemu-iotests/183.out b/tests/qemu-iotests/183.out
index 103fdc778b..73cace6e0f 100644
--- a/tests/qemu-iotests/183.out
+++ b/tests/qemu-iotests/183.out
@@ -36,8 +36,6 @@ wrote 65536/65536 bytes at offset 1048576
 
 {"return": {}}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
 No errors were found on the image.
 No errors were found on the image.
 wrote 65536/65536 bytes at offset 1048576
diff --git a/tests/qemu-iotests/184.out b/tests/qemu-iotests/184.out
index 672650cde8..0dc080de79 100644
--- a/tests/qemu-iotests/184.out
+++ b/tests/qemu-iotests/184.out
@@ -87,16 +87,6 @@ Testing:
     "return": {
     }
 }
-{
-    "timestamp": {
-        "seconds":  TIMESTAMP,
-        "microseconds":  TIMESTAMP
-    },
-    "event": "SHUTDOWN",
-    "data": {
-        "guest": false
-    }
-}
 
 
 == property changes in ThrottleGroup ==
@@ -166,16 +156,6 @@ Testing:
     "return": {
     }
 }
-{
-    "timestamp": {
-        "seconds":  TIMESTAMP,
-        "microseconds":  TIMESTAMP
-    },
-    "event": "SHUTDOWN",
-    "data": {
-        "guest": false
-    }
-}
 
 
 == object creation/set errors  ==
@@ -207,16 +187,6 @@ Testing:
     "return": {
     }
 }
-{
-    "timestamp": {
-        "seconds":  TIMESTAMP,
-        "microseconds":  TIMESTAMP
-    },
-    "event": "SHUTDOWN",
-    "data": {
-        "guest": false
-    }
-}
 
 
 == don't specify group ==
@@ -242,16 +212,6 @@ Testing:
     "return": {
     }
 }
-{
-    "timestamp": {
-        "seconds":  TIMESTAMP,
-        "microseconds":  TIMESTAMP
-    },
-    "event": "SHUTDOWN",
-    "data": {
-        "guest": false
-    }
-}
 
 
 *** done
diff --git a/tests/qemu-iotests/185.out b/tests/qemu-iotests/185.out
index 4e0ca0dffa..dc4d8cc385 100644
--- a/tests/qemu-iotests/185.out
+++ b/tests/qemu-iotests/185.out
@@ -21,7 +21,6 @@ Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 backing_file=TEST_DIR/t.q
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "disk"}}
 {"return": {}}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_CANCELLED", "data": {"device": "disk", "len": 67108864, "offset": 524288, "speed": 65536, "type": "commit"}}
 
 === Start active commit job and exit qemu ===
@@ -31,7 +30,6 @@ Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 backing_file=TEST_DIR/t.q
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "disk"}}
 {"return": {}}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_CANCELLED", "data": {"device": "disk", "len": 4194304, "offset": 4194304, "speed": 65536, "type": "commit"}}
 
 === Start mirror job and exit qemu ===
@@ -42,7 +40,6 @@ Formatting 'TEST_DIR/t.qcow2.copy', fmt=qcow2 size=67108864 cluster_size=65536 l
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "disk"}}
 {"return": {}}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_CANCELLED", "data": {"device": "disk", "len": 4194304, "offset": 4194304, "speed": 65536, "type": "mirror"}}
 
 === Start backup job and exit qemu ===
@@ -53,7 +50,6 @@ Formatting 'TEST_DIR/t.qcow2.copy', fmt=qcow2 size=67108864 cluster_size=65536 l
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "disk"}}
 {"return": {}}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_CANCELLED", "data": {"device": "disk", "len": 67108864, "offset": 65536, "speed": 65536, "type": "backup"}}
 
 === Start streaming job and exit qemu ===
@@ -63,7 +59,6 @@ Formatting 'TEST_DIR/t.qcow2.copy', fmt=qcow2 size=67108864 cluster_size=65536 l
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "disk"}}
 {"return": {}}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_CANCELLED", "data": {"device": "disk", "len": 67108864, "offset": 524288, "speed": 65536, "type": "stream"}}
 No errors were found on the image.
 *** done
diff --git a/tests/qemu-iotests/191.out b/tests/qemu-iotests/191.out
index 31a0c7d4c4..1e1479c6e4 100644
--- a/tests/qemu-iotests/191.out
+++ b/tests/qemu-iotests/191.out
@@ -382,16 +382,6 @@ wrote 65536/65536 bytes at offset 1048576
     "return": {
     }
 }
-{
-    "timestamp": {
-        "seconds":  TIMESTAMP,
-        "microseconds":  TIMESTAMP
-    },
-    "event": "SHUTDOWN",
-    "data": {
-        "guest": false
-    }
-}
 image: TEST_DIR/t.IMGFMT
 file format: IMGFMT
 virtual size: 64M (67108864 bytes)
@@ -799,16 +789,6 @@ wrote 65536/65536 bytes at offset 1048576
     "return": {
     }
 }
-{
-    "timestamp": {
-        "seconds":  TIMESTAMP,
-        "microseconds":  TIMESTAMP
-    },
-    "event": "SHUTDOWN",
-    "data": {
-        "guest": false
-    }
-}
 image: TEST_DIR/t.IMGFMT
 file format: IMGFMT
 virtual size: 64M (67108864 bytes)
diff --git a/tests/qemu-iotests/195.out b/tests/qemu-iotests/195.out
index 7613575c64..4f002a7248 100644
--- a/tests/qemu-iotests/195.out
+++ b/tests/qemu-iotests/195.out
@@ -21,16 +21,6 @@ Testing: -drive if=none,file=TEST_DIR/t.IMGFMT,backing.node-name=mid
     "return": {
     }
 }
-{
-    "timestamp": {
-        "seconds":  TIMESTAMP,
-        "microseconds":  TIMESTAMP
-    },
-    "event": "SHUTDOWN",
-    "data": {
-        "guest": false
-    }
-}
 
 image: TEST_DIR/t.IMGFMT.mid
 file format: IMGFMT
@@ -58,16 +48,6 @@ Testing: -drive if=none,file=TEST_DIR/t.IMGFMT,node-name=top
     "return": {
     }
 }
-{
-    "timestamp": {
-        "seconds":  TIMESTAMP,
-        "microseconds":  TIMESTAMP
-    },
-    "event": "SHUTDOWN",
-    "data": {
-        "guest": false
-    }
-}
 
 image: TEST_DIR/t.IMGFMT
 file format: IMGFMT
diff --git a/tests/qemu-iotests/206.out b/tests/qemu-iotests/206.out
index 042342ae9d..12a57259ce 100644
--- a/tests/qemu-iotests/206.out
+++ b/tests/qemu-iotests/206.out
@@ -9,7 +9,6 @@ QMP_VERSION
 {"return": {}}
 {"return": {}}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
 
 image: TEST_DIR/t.IMGFMT
 file format: IMGFMT
@@ -29,7 +28,6 @@ QMP_VERSION
 {"return": {}}
 {"return": {}}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
 
 image: TEST_DIR/t.IMGFMT
 file format: IMGFMT
@@ -49,7 +47,6 @@ QMP_VERSION
 {"return": {}}
 {"return": {}}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
 
 image: TEST_DIR/t.IMGFMT
 file format: IMGFMT
@@ -69,7 +66,6 @@ QMP_VERSION
 {"return": {}}
 {"return": {}}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
 
 image: TEST_DIR/t.IMGFMT
 file format: IMGFMT
@@ -88,7 +84,6 @@ QMP_VERSION
 {"return": {}}
 {"return": {}}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
 
 image: TEST_DIR/t.IMGFMT
 file format: IMGFMT
@@ -142,7 +137,6 @@ QMP_VERSION
 {"return": {}}
 {"error": {"class": "GenericError", "desc": "Cannot find device=this doesn't exist nor node_name=this doesn't exist"}}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
 
 
 === Invalid sizes ===
@@ -155,7 +149,6 @@ QMP_VERSION
 {"error": {"class": "GenericError", "desc": "Could not resize image: Image size cannot be negative"}}
 {"error": {"class": "GenericError", "desc": "Could not resize image: Failed to grow the L1 table: File too large"}}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
 
 
 === Invalid version ===
@@ -167,7 +160,6 @@ QMP_VERSION
 {"error": {"class": "GenericError", "desc": "Lazy refcounts only supported with compatibility level 1.1 and above (use version=v3 or greater)"}}
 {"error": {"class": "GenericError", "desc": "Different refcount widths than 16 bits require compatibility level 1.1 or above (use version=v3 or greater)"}}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
 
 
 === Invalid backing file options ===
@@ -178,7 +170,6 @@ QMP_VERSION
 {"error": {"class": "GenericError", "desc": "Backing file and preallocation cannot be used at the same time"}}
 {"error": {"class": "GenericError", "desc": "Backing format cannot be used without backing file"}}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
 
 
 === Invalid cluster size ===
@@ -192,7 +183,6 @@ QMP_VERSION
 {"error": {"class": "GenericError", "desc": "Cluster size must be a power of two between 512 and 2048k"}}
 {"error": {"class": "GenericError", "desc": "Could not resize image: Failed to grow the L1 table: File too large"}}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
 
 
 === Invalid refcount width ===
@@ -204,6 +194,5 @@ QMP_VERSION
 {"error": {"class": "GenericError", "desc": "Refcount width must be a power of two and may not exceed 64 bits"}}
 {"error": {"class": "GenericError", "desc": "Refcount width must be a power of two and may not exceed 64 bits"}}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
 
 *** done
diff --git a/tests/qemu-iotests/207.out b/tests/qemu-iotests/207.out
index 417deee970..6078dbf443 100644
--- a/tests/qemu-iotests/207.out
+++ b/tests/qemu-iotests/207.out
@@ -7,7 +7,6 @@ QMP_VERSION
 {"return": {}}
 {"return": {}}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
 
 image: json:{"driver": "IMGFMT", "file": {"server.host": "127.0.0.1", "server.port": "22", "driver": "ssh", "path": "TEST_DIR/t.IMGFMT"}}
 file format: IMGFMT
@@ -24,7 +23,6 @@ QMP_VERSION
 {"return": {}}
 {"return": {}}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
 
 image: json:{"driver": "IMGFMT", "file": {"server.host": "127.0.0.1", "server.port": "22", "driver": "ssh", "path": "TEST_DIR/t.IMGFMT"}}
 file format: IMGFMT
@@ -34,7 +32,6 @@ QMP_VERSION
 {"return": {}}
 {"return": {}}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
 
 image: json:{"driver": "IMGFMT", "file": {"server.host": "127.0.0.1", "server.port": "22", "driver": "ssh", "path": "TEST_DIR/t.IMGFMT"}}
 file format: IMGFMT
@@ -45,7 +42,6 @@ QMP_VERSION
 {"error": {"class": "GenericError", "desc": "remote host key does not match host_key_check 'wrong'"}}
 {"return": {}}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
 
 image: json:{"driver": "IMGFMT", "file": {"server.host": "127.0.0.1", "server.port": "22", "driver": "ssh", "path": "TEST_DIR/t.IMGFMT"}}
 file format: IMGFMT
@@ -56,7 +52,6 @@ QMP_VERSION
 {"error": {"class": "GenericError", "desc": "remote host key does not match host_key_check 'wrong'"}}
 {"return": {}}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
 
 image: json:{"driver": "IMGFMT", "file": {"server.host": "127.0.0.1", "server.port": "22", "driver": "ssh", "path": "TEST_DIR/t.IMGFMT"}}
 file format: IMGFMT
@@ -70,6 +65,5 @@ QMP_VERSION
 {"error": {"class": "GenericError", "desc": "failed to open remote file '/this/is/not/an/existing/path': Failed opening remote file (libssh2 error code: -31)"}}
 {"error": {"class": "GenericError", "desc": "failed to authenticate using publickey authentication and the identities held by your ssh-agent"}}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
 
 *** done
diff --git a/tests/qemu-iotests/210.out b/tests/qemu-iotests/210.out
index 8198f8c829..9433ac0579 100644
--- a/tests/qemu-iotests/210.out
+++ b/tests/qemu-iotests/210.out
@@ -9,7 +9,6 @@ QMP_VERSION
 {"return": {}}
 {"return": {}}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
 
 image: json:{"driver": "IMGFMT", "file": {"driver": "file", "filename": "TEST_DIR/t.IMGFMT"}, "key-secret": "keysec0"}
 file format: IMGFMT
@@ -58,7 +57,6 @@ QMP_VERSION
 {"return": {}}
 {"return": {}}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
 
 image: json:{"driver": "IMGFMT", "file": {"driver": "file", "filename": "TEST_DIR/t.IMGFMT"}, "key-secret": "keysec0"}
 file format: IMGFMT
@@ -106,7 +104,6 @@ QMP_VERSION
 {"return": {}}
 {"error": {"class": "GenericError", "desc": "Cannot find device=this doesn't exist nor node_name=this doesn't exist"}}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
 
 
 === Zero size ===
@@ -116,7 +113,6 @@ QMP_VERSION
 {"return": {}}
 {"return": {}}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
 
 image: json:{"driver": "IMGFMT", "file": {"driver": "file", "filename": "TEST_DIR/t.IMGFMT"}, "key-secret": "keysec0"}
 file format: IMGFMT
@@ -131,7 +127,6 @@ QMP_VERSION
 {"error": {"class": "GenericError", "desc": "The requested file size is too large"}}
 {"error": {"class": "GenericError", "desc": "The requested file size is too large"}}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
 
 
 === Resize image with invalid sizes ===
@@ -144,7 +139,6 @@ QMP_VERSION
 {"error": {"class": "GenericError", "desc": "Invalid parameter type for 'size', expected: integer"}}
 {"error": {"class": "GenericError", "desc": "Parameter 'size' expects a >0 size"}}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
 
 image: json:{"driver": "IMGFMT", "file": {"driver": "file", "filename": "TEST_DIR/t.IMGFMT"}, "key-secret": "keysec0"}
 file format: IMGFMT
diff --git a/tests/qemu-iotests/211.out b/tests/qemu-iotests/211.out
index 3247bbaa64..ec0fb0f65d 100644
--- a/tests/qemu-iotests/211.out
+++ b/tests/qemu-iotests/211.out
@@ -9,7 +9,6 @@ QMP_VERSION
 {"return": {}}
 {"return": {}}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
 
 image: TEST_DIR/t.IMGFMT
 file format: IMGFMT
@@ -24,7 +23,6 @@ QMP_VERSION
 {"return": {}}
 {"return": {}}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
 
 image: TEST_DIR/t.IMGFMT
 file format: IMGFMT
@@ -39,7 +37,6 @@ QMP_VERSION
 {"return": {}}
 {"return": {}}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
 
 image: TEST_DIR/t.IMGFMT
 file format: IMGFMT
@@ -54,7 +51,6 @@ QMP_VERSION
 {"return": {}}
 {"error": {"class": "GenericError", "desc": "Cannot find device=this doesn't exist nor node_name=this doesn't exist"}}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
 
 
 === Zero size ===
@@ -64,7 +60,6 @@ QMP_VERSION
 {"return": {}}
 {"return": {}}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
 
 image: TEST_DIR/t.IMGFMT
 file format: IMGFMT
@@ -77,7 +72,6 @@ QMP_VERSION
 {"return": {}}
 {"return": {}}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
 
 image: TEST_DIR/t.IMGFMT
 file format: IMGFMT
@@ -92,6 +86,5 @@ QMP_VERSION
 {"error": {"class": "GenericError", "desc": "Unsupported VDI image size (size is 0x8000000000000000, max supported is 0x1fffff8000000)"}}
 {"error": {"class": "GenericError", "desc": "Unsupported VDI image size (size is 0x1fffff8000001, max supported is 0x1fffff8000000)"}}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
 
 *** done
diff --git a/tests/qemu-iotests/212.out b/tests/qemu-iotests/212.out
index 587de6fad0..56b20921b3 100644
--- a/tests/qemu-iotests/212.out
+++ b/tests/qemu-iotests/212.out
@@ -9,7 +9,6 @@ QMP_VERSION
 {"return": {}}
 {"return": {}}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
 
 image: TEST_DIR/t.IMGFMT
 file format: IMGFMT
@@ -23,7 +22,6 @@ QMP_VERSION
 {"return": {}}
 {"return": {}}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
 
 image: TEST_DIR/t.IMGFMT
 file format: IMGFMT
@@ -37,7 +35,6 @@ QMP_VERSION
 {"return": {}}
 {"return": {}}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
 
 image: TEST_DIR/t.IMGFMT
 file format: IMGFMT
@@ -50,7 +47,6 @@ QMP_VERSION
 {"return": {}}
 {"error": {"class": "GenericError", "desc": "Cannot find device=this doesn't exist nor node_name=this doesn't exist"}}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
 
 
 === Zero size ===
@@ -60,7 +56,6 @@ QMP_VERSION
 {"return": {}}
 {"return": {}}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
 
 image: TEST_DIR/t.IMGFMT
 file format: IMGFMT
@@ -73,7 +68,6 @@ QMP_VERSION
 {"return": {}}
 {"return": {}}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
 
 image: TEST_DIR/t.IMGFMT
 file format: IMGFMT
@@ -90,7 +84,6 @@ QMP_VERSION
 {"error": {"class": "GenericError", "desc": "Image size is too large for this cluster size"}}
 {"error": {"class": "GenericError", "desc": "Image size is too large for this cluster size"}}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
 
 
 === Invalid cluster size ===
@@ -106,6 +99,5 @@ QMP_VERSION
 {"error": {"class": "GenericError", "desc": "Image size is too large for this cluster size"}}
 {"error": {"class": "GenericError", "desc": "Image size is too large for this cluster size"}}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
 
 *** done
diff --git a/tests/qemu-iotests/213.out b/tests/qemu-iotests/213.out
index 8e8fc29cbc..b672e83b1e 100644
--- a/tests/qemu-iotests/213.out
+++ b/tests/qemu-iotests/213.out
@@ -9,7 +9,6 @@ QMP_VERSION
 {"return": {}}
 {"return": {}}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
 
 image: TEST_DIR/t.IMGFMT
 file format: IMGFMT
@@ -23,7 +22,6 @@ QMP_VERSION
 {"return": {}}
 {"return": {}}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
 
 image: TEST_DIR/t.IMGFMT
 file format: IMGFMT
@@ -37,7 +35,6 @@ QMP_VERSION
 {"return": {}}
 {"return": {}}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
 
 image: TEST_DIR/t.IMGFMT
 file format: IMGFMT
@@ -50,7 +47,6 @@ QMP_VERSION
 {"return": {}}
 {"error": {"class": "GenericError", "desc": "Cannot find device=this doesn't exist nor node_name=this doesn't exist"}}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
 
 
 === Zero size ===
@@ -60,7 +56,6 @@ QMP_VERSION
 {"return": {}}
 {"return": {}}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
 
 image: TEST_DIR/t.IMGFMT
 file format: IMGFMT
@@ -73,7 +68,6 @@ QMP_VERSION
 {"return": {}}
 {"return": {}}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
 
 image: TEST_DIR/t.IMGFMT
 file format: IMGFMT
@@ -89,7 +83,6 @@ QMP_VERSION
 {"error": {"class": "GenericError", "desc": "Image size too large; max of 64TB"}}
 {"error": {"class": "GenericError", "desc": "Image size too large; max of 64TB"}}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
 
 
 === Invalid block size ===
@@ -103,7 +96,6 @@ QMP_VERSION
 {"error": {"class": "GenericError", "desc": "Block size must not exceed 268435456"}}
 {"error": {"class": "GenericError", "desc": "Block size must be a multiple of 1 MB"}}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
 
 
 === Invalid log size ===
@@ -116,6 +108,5 @@ QMP_VERSION
 {"error": {"class": "GenericError", "desc": "Log size must be smaller than 4 GB"}}
 {"error": {"class": "GenericError", "desc": "Log size must be a multiple of 1 MB"}}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
 
 *** done
diff --git a/tests/qemu-iotests/common.filter b/tests/qemu-iotests/common.filter
index f08ee55046..13fe5c33eb 100644
--- a/tests/qemu-iotests/common.filter
+++ b/tests/qemu-iotests/common.filter
@@ -88,7 +88,10 @@ _filter_qmp()
     sed -e 's#\("\(micro\)\?seconds": \)[0-9]\+#\1 TIMESTAMP#g' \
         -e 's#^{"QMP":.*}$#QMP_VERSION#' \
         -e '/^    "QMP": {\s*$/, /^    }\s*$/ c\' \
-        -e '    QMP_VERSION'
+        -e '    QMP_VERSION' | \
+    tr '\n' '\r' | \
+    sed -e 's/{\s*"timestamp":\s*{\s*"seconds":\s*TIMESTAMP,\s*"microseconds":\s*TIMESTAMP\s*},\s*"event":\s*"SHUTDOWN",\s*"data":\s*{\s*"guest":\s*false\s*}\s*}\s//' | \
+    tr '\r' '\n'
 }
 
 # readline makes HMP command strings so long that git complains
-- 
2.17.0
