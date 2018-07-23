Received: from eggs.gnu.org ([2001:4830:134:3::10]:51280)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fhdyL-0002bD-Bb
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 12:46:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fhdyB-0005RH-4N
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 12:46:09 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon, 23 Jul 2018 18:45:24 +0200
Message-Id: <20180723164530.26599-2-kwolf@redhat.com>
In-Reply-To: <20180723164530.26599-1-kwolf@redhat.com>
References: <20180723164530.26599-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 1/7] qemu-iotests: Use host_device instead of
 file in 149
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, peter.maydell@linaro.org

The test case uses block devices with driver=file, which causes the test
to fail after commit 230ff73904 added a deprecation warning for this.
Fix the test case to use driver=host_device and update the reference
output accordingly.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/149     |   2 +-
 tests/qemu-iotests/149.out | 344 ++++++++++++++++++++++-----------------------
 2 files changed, 173 insertions(+), 173 deletions(-)

diff --git a/tests/qemu-iotests/149 b/tests/qemu-iotests/149
index d3ffa259db..9e0cad76f9 100755
--- a/tests/qemu-iotests/149
+++ b/tests/qemu-iotests/149
@@ -259,7 +259,7 @@ def qemu_io_image_args(config, dev=False):
     if dev:
         return [
             "--image-opts",
-            "driver=file,filename=%s" % config.device_path()]
+            "driver=host_device,filename=%s" % config.device_path()]
     else:
         return [
             "--object",
diff --git a/tests/qemu-iotests/149.out b/tests/qemu-iotests/149.out
index 5dea00bfa8..1407ce6dad 100644
--- a/tests/qemu-iotests/149.out
+++ b/tests/qemu-iotests/149.out
@@ -7,13 +7,13 @@ sudo cryptsetup -q -v luksFormat --cipher aes-xts-plain64 --key-size 512 --hash
 sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-256-xts-plain64-sha1.img qiotest-145-aes-256-xts-plain64-sha1
 # Write test pattern 0xa7
 sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain64-sha1
-qemu-io -c write -P 0xa7 100M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-xts-plain64-sha1
+qemu-io -c write -P 0xa7 100M 10M --image-opts driver=host_device,filename=/dev/mapper/qiotest-145-aes-256-xts-plain64-sha1
 wrote 10485760/10485760 bytes at offset 104857600
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 # Write test pattern 0x13
 sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain64-sha1
-qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-xts-plain64-sha1
+qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=host_device,filename=/dev/mapper/qiotest-145-aes-256-xts-plain64-sha1
 wrote 10485760/10485760 bytes at offset 3298534883328
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
@@ -43,13 +43,13 @@ wrote 10485760/10485760 bytes at offset 3298534883328
 sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-256-xts-plain64-sha1.img qiotest-145-aes-256-xts-plain64-sha1
 # Read test pattern 0x91
 sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain64-sha1
-qemu-io -c read -P 0x91 100M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-xts-plain64-sha1
+qemu-io -c read -P 0x91 100M 10M --image-opts driver=host_device,filename=/dev/mapper/qiotest-145-aes-256-xts-plain64-sha1
 read 10485760/10485760 bytes at offset 104857600
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 # Read test pattern 0x5e
 sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain64-sha1
-qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-xts-plain64-sha1
+qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=host_device,filename=/dev/mapper/qiotest-145-aes-256-xts-plain64-sha1
 read 10485760/10485760 bytes at offset 3298534883328
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
@@ -67,13 +67,13 @@ Formatting 'TEST_DIR/luks-aes-256-xts-plain64-sha1.img', fmt=luks size=439804651
 sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-256-xts-plain64-sha1.img qiotest-145-aes-256-xts-plain64-sha1
 # Write test pattern 0xa7
 sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain64-sha1
-qemu-io -c write -P 0xa7 100M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-xts-plain64-sha1
+qemu-io -c write -P 0xa7 100M 10M --image-opts driver=host_device,filename=/dev/mapper/qiotest-145-aes-256-xts-plain64-sha1
 wrote 10485760/10485760 bytes at offset 104857600
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 # Write test pattern 0x13
 sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain64-sha1
-qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-xts-plain64-sha1
+qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=host_device,filename=/dev/mapper/qiotest-145-aes-256-xts-plain64-sha1
 wrote 10485760/10485760 bytes at offset 3298534883328
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
@@ -103,13 +103,13 @@ wrote 10485760/10485760 bytes at offset 3298534883328
 sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-256-xts-plain64-sha1.img qiotest-145-aes-256-xts-plain64-sha1
 # Read test pattern 0x91
 sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain64-sha1
-qemu-io -c read -P 0x91 100M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-xts-plain64-sha1
+qemu-io -c read -P 0x91 100M 10M --image-opts driver=host_device,filename=/dev/mapper/qiotest-145-aes-256-xts-plain64-sha1
 read 10485760/10485760 bytes at offset 104857600
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 # Read test pattern 0x5e
 sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain64-sha1
-qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-xts-plain64-sha1
+qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=host_device,filename=/dev/mapper/qiotest-145-aes-256-xts-plain64-sha1
 read 10485760/10485760 bytes at offset 3298534883328
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
@@ -127,13 +127,13 @@ sudo cryptsetup -q -v luksFormat --cipher twofish-xts-plain64 --key-size 512 --h
 sudo cryptsetup -q -v luksOpen TEST_DIR/luks-twofish-256-xts-plain64-sha1.img qiotest-145-twofish-256-xts-plain64-sha1
 # Write test pattern 0xa7
 sudo chown UID:GID /dev/mapper/qiotest-145-twofish-256-xts-plain64-sha1
-qemu-io -c write -P 0xa7 100M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-twofish-256-xts-plain64-sha1
+qemu-io -c write -P 0xa7 100M 10M --image-opts driver=host_device,filename=/dev/mapper/qiotest-145-twofish-256-xts-plain64-sha1
 wrote 10485760/10485760 bytes at offset 104857600
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 # Write test pattern 0x13
 sudo chown UID:GID /dev/mapper/qiotest-145-twofish-256-xts-plain64-sha1
-qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-twofish-256-xts-plain64-sha1
+qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=host_device,filename=/dev/mapper/qiotest-145-twofish-256-xts-plain64-sha1
 wrote 10485760/10485760 bytes at offset 3298534883328
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
@@ -163,13 +163,13 @@ wrote 10485760/10485760 bytes at offset 3298534883328
 sudo cryptsetup -q -v luksOpen TEST_DIR/luks-twofish-256-xts-plain64-sha1.img qiotest-145-twofish-256-xts-plain64-sha1
 # Read test pattern 0x91
 sudo chown UID:GID /dev/mapper/qiotest-145-twofish-256-xts-plain64-sha1
-qemu-io -c read -P 0x91 100M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-twofish-256-xts-plain64-sha1
+qemu-io -c read -P 0x91 100M 10M --image-opts driver=host_device,filename=/dev/mapper/qiotest-145-twofish-256-xts-plain64-sha1
 read 10485760/10485760 bytes at offset 104857600
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 # Read test pattern 0x5e
 sudo chown UID:GID /dev/mapper/qiotest-145-twofish-256-xts-plain64-sha1
-qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-twofish-256-xts-plain64-sha1
+qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=host_device,filename=/dev/mapper/qiotest-145-twofish-256-xts-plain64-sha1
 read 10485760/10485760 bytes at offset 3298534883328
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
@@ -187,13 +187,13 @@ Formatting 'TEST_DIR/luks-twofish-256-xts-plain64-sha1.img', fmt=luks size=43980
 sudo cryptsetup -q -v luksOpen TEST_DIR/luks-twofish-256-xts-plain64-sha1.img qiotest-145-twofish-256-xts-plain64-sha1
 # Write test pattern 0xa7
 sudo chown UID:GID /dev/mapper/qiotest-145-twofish-256-xts-plain64-sha1
-qemu-io -c write -P 0xa7 100M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-twofish-256-xts-plain64-sha1
+qemu-io -c write -P 0xa7 100M 10M --image-opts driver=host_device,filename=/dev/mapper/qiotest-145-twofish-256-xts-plain64-sha1
 wrote 10485760/10485760 bytes at offset 104857600
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 # Write test pattern 0x13
 sudo chown UID:GID /dev/mapper/qiotest-145-twofish-256-xts-plain64-sha1
-qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-twofish-256-xts-plain64-sha1
+qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=host_device,filename=/dev/mapper/qiotest-145-twofish-256-xts-plain64-sha1
 wrote 10485760/10485760 bytes at offset 3298534883328
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
@@ -223,13 +223,13 @@ wrote 10485760/10485760 bytes at offset 3298534883328
 sudo cryptsetup -q -v luksOpen TEST_DIR/luks-twofish-256-xts-plain64-sha1.img qiotest-145-twofish-256-xts-plain64-sha1
 # Read test pattern 0x91
 sudo chown UID:GID /dev/mapper/qiotest-145-twofish-256-xts-plain64-sha1
-qemu-io -c read -P 0x91 100M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-twofish-256-xts-plain64-sha1
+qemu-io -c read -P 0x91 100M 10M --image-opts driver=host_device,filename=/dev/mapper/qiotest-145-twofish-256-xts-plain64-sha1
 read 10485760/10485760 bytes at offset 104857600
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 # Read test pattern 0x5e
 sudo chown UID:GID /dev/mapper/qiotest-145-twofish-256-xts-plain64-sha1
-qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-twofish-256-xts-plain64-sha1
+qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=host_device,filename=/dev/mapper/qiotest-145-twofish-256-xts-plain64-sha1
 read 10485760/10485760 bytes at offset 3298534883328
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
@@ -247,13 +247,13 @@ sudo cryptsetup -q -v luksFormat --cipher serpent-xts-plain64 --key-size 512 --h
 sudo cryptsetup -q -v luksOpen TEST_DIR/luks-serpent-256-xts-plain64-sha1.img qiotest-145-serpent-256-xts-plain64-sha1
 # Write test pattern 0xa7
 sudo chown UID:GID /dev/mapper/qiotest-145-serpent-256-xts-plain64-sha1
-qemu-io -c write -P 0xa7 100M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-serpent-256-xts-plain64-sha1
+qemu-io -c write -P 0xa7 100M 10M --image-opts driver=host_device,filename=/dev/mapper/qiotest-145-serpent-256-xts-plain64-sha1
 wrote 10485760/10485760 bytes at offset 104857600
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 # Write test pattern 0x13
 sudo chown UID:GID /dev/mapper/qiotest-145-serpent-256-xts-plain64-sha1
-qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-serpent-256-xts-plain64-sha1
+qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=host_device,filename=/dev/mapper/qiotest-145-serpent-256-xts-plain64-sha1
 wrote 10485760/10485760 bytes at offset 3298534883328
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
@@ -283,13 +283,13 @@ wrote 10485760/10485760 bytes at offset 3298534883328
 sudo cryptsetup -q -v luksOpen TEST_DIR/luks-serpent-256-xts-plain64-sha1.img qiotest-145-serpent-256-xts-plain64-sha1
 # Read test pattern 0x91
 sudo chown UID:GID /dev/mapper/qiotest-145-serpent-256-xts-plain64-sha1
-qemu-io -c read -P 0x91 100M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-serpent-256-xts-plain64-sha1
+qemu-io -c read -P 0x91 100M 10M --image-opts driver=host_device,filename=/dev/mapper/qiotest-145-serpent-256-xts-plain64-sha1
 read 10485760/10485760 bytes at offset 104857600
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 # Read test pattern 0x5e
 sudo chown UID:GID /dev/mapper/qiotest-145-serpent-256-xts-plain64-sha1
-qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-serpent-256-xts-plain64-sha1
+qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=host_device,filename=/dev/mapper/qiotest-145-serpent-256-xts-plain64-sha1
 read 10485760/10485760 bytes at offset 3298534883328
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
@@ -307,13 +307,13 @@ Formatting 'TEST_DIR/luks-serpent-256-xts-plain64-sha1.img', fmt=luks size=43980
 sudo cryptsetup -q -v luksOpen TEST_DIR/luks-serpent-256-xts-plain64-sha1.img qiotest-145-serpent-256-xts-plain64-sha1
 # Write test pattern 0xa7
 sudo chown UID:GID /dev/mapper/qiotest-145-serpent-256-xts-plain64-sha1
-qemu-io -c write -P 0xa7 100M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-serpent-256-xts-plain64-sha1
+qemu-io -c write -P 0xa7 100M 10M --image-opts driver=host_device,filename=/dev/mapper/qiotest-145-serpent-256-xts-plain64-sha1
 wrote 10485760/10485760 bytes at offset 104857600
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 # Write test pattern 0x13
 sudo chown UID:GID /dev/mapper/qiotest-145-serpent-256-xts-plain64-sha1
-qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-serpent-256-xts-plain64-sha1
+qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=host_device,filename=/dev/mapper/qiotest-145-serpent-256-xts-plain64-sha1
 wrote 10485760/10485760 bytes at offset 3298534883328
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
@@ -343,13 +343,13 @@ wrote 10485760/10485760 bytes at offset 3298534883328
 sudo cryptsetup -q -v luksOpen TEST_DIR/luks-serpent-256-xts-plain64-sha1.img qiotest-145-serpent-256-xts-plain64-sha1
 # Read test pattern 0x91
 sudo chown UID:GID /dev/mapper/qiotest-145-serpent-256-xts-plain64-sha1
-qemu-io -c read -P 0x91 100M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-serpent-256-xts-plain64-sha1
+qemu-io -c read -P 0x91 100M 10M --image-opts driver=host_device,filename=/dev/mapper/qiotest-145-serpent-256-xts-plain64-sha1
 read 10485760/10485760 bytes at offset 104857600
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 # Read test pattern 0x5e
 sudo chown UID:GID /dev/mapper/qiotest-145-serpent-256-xts-plain64-sha1
-qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-serpent-256-xts-plain64-sha1
+qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=host_device,filename=/dev/mapper/qiotest-145-serpent-256-xts-plain64-sha1
 read 10485760/10485760 bytes at offset 3298534883328
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
@@ -367,13 +367,13 @@ sudo cryptsetup -q -v luksFormat --cipher cast5-cbc-plain64 --key-size 128 --has
 sudo cryptsetup -q -v luksOpen TEST_DIR/luks-cast5-128-cbc-plain64-sha1.img qiotest-145-cast5-128-cbc-plain64-sha1
 # Write test pattern 0xa7
 sudo chown UID:GID /dev/mapper/qiotest-145-cast5-128-cbc-plain64-sha1
-qemu-io -c write -P 0xa7 100M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-cast5-128-cbc-plain64-sha1
+qemu-io -c write -P 0xa7 100M 10M --image-opts driver=host_device,filename=/dev/mapper/qiotest-145-cast5-128-cbc-plain64-sha1
 wrote 10485760/10485760 bytes at offset 104857600
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 # Write test pattern 0x13
 sudo chown UID:GID /dev/mapper/qiotest-145-cast5-128-cbc-plain64-sha1
-qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-cast5-128-cbc-plain64-sha1
+qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=host_device,filename=/dev/mapper/qiotest-145-cast5-128-cbc-plain64-sha1
 wrote 10485760/10485760 bytes at offset 3298534883328
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
@@ -403,13 +403,13 @@ wrote 10485760/10485760 bytes at offset 3298534883328
 sudo cryptsetup -q -v luksOpen TEST_DIR/luks-cast5-128-cbc-plain64-sha1.img qiotest-145-cast5-128-cbc-plain64-sha1
 # Read test pattern 0x91
 sudo chown UID:GID /dev/mapper/qiotest-145-cast5-128-cbc-plain64-sha1
-qemu-io -c read -P 0x91 100M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-cast5-128-cbc-plain64-sha1
+qemu-io -c read -P 0x91 100M 10M --image-opts driver=host_device,filename=/dev/mapper/qiotest-145-cast5-128-cbc-plain64-sha1
 read 10485760/10485760 bytes at offset 104857600
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 # Read test pattern 0x5e
 sudo chown UID:GID /dev/mapper/qiotest-145-cast5-128-cbc-plain64-sha1
-qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-cast5-128-cbc-plain64-sha1
+qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=host_device,filename=/dev/mapper/qiotest-145-cast5-128-cbc-plain64-sha1
 read 10485760/10485760 bytes at offset 3298534883328
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
@@ -427,13 +427,13 @@ Formatting 'TEST_DIR/luks-cast5-128-cbc-plain64-sha1.img', fmt=luks size=4398046
 sudo cryptsetup -q -v luksOpen TEST_DIR/luks-cast5-128-cbc-plain64-sha1.img qiotest-145-cast5-128-cbc-plain64-sha1
 # Write test pattern 0xa7
 sudo chown UID:GID /dev/mapper/qiotest-145-cast5-128-cbc-plain64-sha1
-qemu-io -c write -P 0xa7 100M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-cast5-128-cbc-plain64-sha1
+qemu-io -c write -P 0xa7 100M 10M --image-opts driver=host_device,filename=/dev/mapper/qiotest-145-cast5-128-cbc-plain64-sha1
 wrote 10485760/10485760 bytes at offset 104857600
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 # Write test pattern 0x13
 sudo chown UID:GID /dev/mapper/qiotest-145-cast5-128-cbc-plain64-sha1
-qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-cast5-128-cbc-plain64-sha1
+qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=host_device,filename=/dev/mapper/qiotest-145-cast5-128-cbc-plain64-sha1
 wrote 10485760/10485760 bytes at offset 3298534883328
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
@@ -463,13 +463,13 @@ wrote 10485760/10485760 bytes at offset 3298534883328
 sudo cryptsetup -q -v luksOpen TEST_DIR/luks-cast5-128-cbc-plain64-sha1.img qiotest-145-cast5-128-cbc-plain64-sha1
 # Read test pattern 0x91
 sudo chown UID:GID /dev/mapper/qiotest-145-cast5-128-cbc-plain64-sha1
-qemu-io -c read -P 0x91 100M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-cast5-128-cbc-plain64-sha1
+qemu-io -c read -P 0x91 100M 10M --image-opts driver=host_device,filename=/dev/mapper/qiotest-145-cast5-128-cbc-plain64-sha1
 read 10485760/10485760 bytes at offset 104857600
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 # Read test pattern 0x5e
 sudo chown UID:GID /dev/mapper/qiotest-145-cast5-128-cbc-plain64-sha1
-qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-cast5-128-cbc-plain64-sha1
+qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=host_device,filename=/dev/mapper/qiotest-145-cast5-128-cbc-plain64-sha1
 read 10485760/10485760 bytes at offset 3298534883328
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
@@ -488,13 +488,13 @@ sudo cryptsetup -q -v luksFormat --cipher aes-cbc-plain --key-size 256 --hash sh
 sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-256-cbc-plain-sha1.img qiotest-145-aes-256-cbc-plain-sha1
 # Write test pattern 0xa7
 sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-cbc-plain-sha1
-qemu-io -c write -P 0xa7 100M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-cbc-plain-sha1
+qemu-io -c write -P 0xa7 100M 10M --image-opts driver=host_device,filename=/dev/mapper/qiotest-145-aes-256-cbc-plain-sha1
 wrote 10485760/10485760 bytes at offset 104857600
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 # Write test pattern 0x13
 sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-cbc-plain-sha1
-qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-cbc-plain-sha1
+qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=host_device,filename=/dev/mapper/qiotest-145-aes-256-cbc-plain-sha1
 wrote 10485760/10485760 bytes at offset 3298534883328
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
@@ -524,13 +524,13 @@ wrote 10485760/10485760 bytes at offset 3298534883328
 sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-256-cbc-plain-sha1.img qiotest-145-aes-256-cbc-plain-sha1
 # Read test pattern 0x91
 sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-cbc-plain-sha1
-qemu-io -c read -P 0x91 100M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-cbc-plain-sha1
+qemu-io -c read -P 0x91 100M 10M --image-opts driver=host_device,filename=/dev/mapper/qiotest-145-aes-256-cbc-plain-sha1
 read 10485760/10485760 bytes at offset 104857600
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 # Read test pattern 0x5e
 sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-cbc-plain-sha1
-qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-cbc-plain-sha1
+qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=host_device,filename=/dev/mapper/qiotest-145-aes-256-cbc-plain-sha1
 read 10485760/10485760 bytes at offset 3298534883328
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
@@ -548,13 +548,13 @@ Formatting 'TEST_DIR/luks-aes-256-cbc-plain-sha1.img', fmt=luks size=43980465111
 sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-256-cbc-plain-sha1.img qiotest-145-aes-256-cbc-plain-sha1
 # Write test pattern 0xa7
 sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-cbc-plain-sha1
-qemu-io -c write -P 0xa7 100M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-cbc-plain-sha1
+qemu-io -c write -P 0xa7 100M 10M --image-opts driver=host_device,filename=/dev/mapper/qiotest-145-aes-256-cbc-plain-sha1
 wrote 10485760/10485760 bytes at offset 104857600
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 # Write test pattern 0x13
 sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-cbc-plain-sha1
-qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-cbc-plain-sha1
+qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=host_device,filename=/dev/mapper/qiotest-145-aes-256-cbc-plain-sha1
 wrote 10485760/10485760 bytes at offset 3298534883328
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
@@ -584,13 +584,13 @@ wrote 10485760/10485760 bytes at offset 3298534883328
 sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-256-cbc-plain-sha1.img qiotest-145-aes-256-cbc-plain-sha1
 # Read test pattern 0x91
 sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-cbc-plain-sha1
-qemu-io -c read -P 0x91 100M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-cbc-plain-sha1
+qemu-io -c read -P 0x91 100M 10M --image-opts driver=host_device,filename=/dev/mapper/qiotest-145-aes-256-cbc-plain-sha1
 read 10485760/10485760 bytes at offset 104857600
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 # Read test pattern 0x5e
 sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-cbc-plain-sha1
-qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-cbc-plain-sha1
+qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=host_device,filename=/dev/mapper/qiotest-145-aes-256-cbc-plain-sha1
 read 10485760/10485760 bytes at offset 3298534883328
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
@@ -608,13 +608,13 @@ sudo cryptsetup -q -v luksFormat --cipher aes-cbc-plain64 --key-size 256 --hash
 sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-256-cbc-plain64-sha1.img qiotest-145-aes-256-cbc-plain64-sha1
 # Write test pattern 0xa7
 sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-cbc-plain64-sha1
-qemu-io -c write -P 0xa7 100M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-cbc-plain64-sha1
+qemu-io -c write -P 0xa7 100M 10M --image-opts driver=host_device,filename=/dev/mapper/qiotest-145-aes-256-cbc-plain64-sha1
 wrote 10485760/10485760 bytes at offset 104857600
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 # Write test pattern 0x13
 sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-cbc-plain64-sha1
-qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-cbc-plain64-sha1
+qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=host_device,filename=/dev/mapper/qiotest-145-aes-256-cbc-plain64-sha1
 wrote 10485760/10485760 bytes at offset 3298534883328
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
@@ -644,13 +644,13 @@ wrote 10485760/10485760 bytes at offset 3298534883328
 sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-256-cbc-plain64-sha1.img qiotest-145-aes-256-cbc-plain64-sha1
 # Read test pattern 0x91
 sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-cbc-plain64-sha1
-qemu-io -c read -P 0x91 100M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-cbc-plain64-sha1
+qemu-io -c read -P 0x91 100M 10M --image-opts driver=host_device,filename=/dev/mapper/qiotest-145-aes-256-cbc-plain64-sha1
 read 10485760/10485760 bytes at offset 104857600
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 # Read test pattern 0x5e
 sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-cbc-plain64-sha1
-qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-cbc-plain64-sha1
+qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=host_device,filename=/dev/mapper/qiotest-145-aes-256-cbc-plain64-sha1
 read 10485760/10485760 bytes at offset 3298534883328
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
@@ -668,13 +668,13 @@ Formatting 'TEST_DIR/luks-aes-256-cbc-plain64-sha1.img', fmt=luks size=439804651
 sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-256-cbc-plain64-sha1.img qiotest-145-aes-256-cbc-plain64-sha1
 # Write test pattern 0xa7
 sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-cbc-plain64-sha1
-qemu-io -c write -P 0xa7 100M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-cbc-plain64-sha1
+qemu-io -c write -P 0xa7 100M 10M --image-opts driver=host_device,filename=/dev/mapper/qiotest-145-aes-256-cbc-plain64-sha1
 wrote 10485760/10485760 bytes at offset 104857600
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 # Write test pattern 0x13
 sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-cbc-plain64-sha1
-qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-cbc-plain64-sha1
+qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=host_device,filename=/dev/mapper/qiotest-145-aes-256-cbc-plain64-sha1
 wrote 10485760/10485760 bytes at offset 3298534883328
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
@@ -704,13 +704,13 @@ wrote 10485760/10485760 bytes at offset 3298534883328
 sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-256-cbc-plain64-sha1.img qiotest-145-aes-256-cbc-plain64-sha1
 # Read test pattern 0x91
 sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-cbc-plain64-sha1
-qemu-io -c read -P 0x91 100M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-cbc-plain64-sha1
+qemu-io -c read -P 0x91 100M 10M --image-opts driver=host_device,filename=/dev/mapper/qiotest-145-aes-256-cbc-plain64-sha1
 read 10485760/10485760 bytes at offset 104857600
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 # Read test pattern 0x5e
 sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-cbc-plain64-sha1
-qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-cbc-plain64-sha1
+qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=host_device,filename=/dev/mapper/qiotest-145-aes-256-cbc-plain64-sha1
 read 10485760/10485760 bytes at offset 3298534883328
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
@@ -728,13 +728,13 @@ sudo cryptsetup -q -v luksFormat --cipher aes-cbc-essiv:sha256 --key-size 256 --
 sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-256-cbc-essiv-sha256-sha1.img qiotest-145-aes-256-cbc-essiv-sha256-sha1
 # Write test pattern 0xa7
 sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-cbc-essiv-sha256-sha1
-qemu-io -c write -P 0xa7 100M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-cbc-essiv-sha256-sha1
+qemu-io -c write -P 0xa7 100M 10M --image-opts driver=host_device,filename=/dev/mapper/qiotest-145-aes-256-cbc-essiv-sha256-sha1
 wrote 10485760/10485760 bytes at offset 104857600
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 # Write test pattern 0x13
 sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-cbc-essiv-sha256-sha1
-qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-cbc-essiv-sha256-sha1
+qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=host_device,filename=/dev/mapper/qiotest-145-aes-256-cbc-essiv-sha256-sha1
 wrote 10485760/10485760 bytes at offset 3298534883328
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
@@ -764,13 +764,13 @@ wrote 10485760/10485760 bytes at offset 3298534883328
 sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-256-cbc-essiv-sha256-sha1.img qiotest-145-aes-256-cbc-essiv-sha256-sha1
 # Read test pattern 0x91
 sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-cbc-essiv-sha256-sha1
-qemu-io -c read -P 0x91 100M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-cbc-essiv-sha256-sha1
+qemu-io -c read -P 0x91 100M 10M --image-opts driver=host_device,filename=/dev/mapper/qiotest-145-aes-256-cbc-essiv-sha256-sha1
 read 10485760/10485760 bytes at offset 104857600
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 # Read test pattern 0x5e
 sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-cbc-essiv-sha256-sha1
-qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-cbc-essiv-sha256-sha1
+qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=host_device,filename=/dev/mapper/qiotest-145-aes-256-cbc-essiv-sha256-sha1
 read 10485760/10485760 bytes at offset 3298534883328
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
@@ -788,13 +788,13 @@ Formatting 'TEST_DIR/luks-aes-256-cbc-essiv-sha256-sha1.img', fmt=luks size=4398
 sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-256-cbc-essiv-sha256-sha1.img qiotest-145-aes-256-cbc-essiv-sha256-sha1
 # Write test pattern 0xa7
 sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-cbc-essiv-sha256-sha1
-qemu-io -c write -P 0xa7 100M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-cbc-essiv-sha256-sha1
+qemu-io -c write -P 0xa7 100M 10M --image-opts driver=host_device,filename=/dev/mapper/qiotest-145-aes-256-cbc-essiv-sha256-sha1
 wrote 10485760/10485760 bytes at offset 104857600
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 # Write test pattern 0x13
 sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-cbc-essiv-sha256-sha1
-qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-cbc-essiv-sha256-sha1
+qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=host_device,filename=/dev/mapper/qiotest-145-aes-256-cbc-essiv-sha256-sha1
 wrote 10485760/10485760 bytes at offset 3298534883328
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
@@ -824,13 +824,13 @@ wrote 10485760/10485760 bytes at offset 3298534883328
 sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-256-cbc-essiv-sha256-sha1.img qiotest-145-aes-256-cbc-essiv-sha256-sha1
 # Read test pattern 0x91
 sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-cbc-essiv-sha256-sha1
-qemu-io -c read -P 0x91 100M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-cbc-essiv-sha256-sha1
+qemu-io -c read -P 0x91 100M 10M --image-opts driver=host_device,filename=/dev/mapper/qiotest-145-aes-256-cbc-essiv-sha256-sha1
 read 10485760/10485760 bytes at offset 104857600
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 # Read test pattern 0x5e
 sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-cbc-essiv-sha256-sha1
-qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-cbc-essiv-sha256-sha1
+qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=host_device,filename=/dev/mapper/qiotest-145-aes-256-cbc-essiv-sha256-sha1
 read 10485760/10485760 bytes at offset 3298534883328
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
@@ -848,13 +848,13 @@ sudo cryptsetup -q -v luksFormat --cipher aes-xts-essiv:sha256 --key-size 512 --
 sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-256-xts-essiv-sha256-sha1.img qiotest-145-aes-256-xts-essiv-sha256-sha1
 # Write test pattern 0xa7
 sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-essiv-sha256-sha1
-qemu-io -c write -P 0xa7 100M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-xts-essiv-sha256-sha1
+qemu-io -c write -P 0xa7 100M 10M --image-opts driver=host_device,filename=/dev/mapper/qiotest-145-aes-256-xts-essiv-sha256-sha1
 wrote 10485760/10485760 bytes at offset 104857600
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 # Write test pattern 0x13
 sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-essiv-sha256-sha1
-qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-xts-essiv-sha256-sha1
+qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=host_device,filename=/dev/mapper/qiotest-145-aes-256-xts-essiv-sha256-sha1
 wrote 10485760/10485760 bytes at offset 3298534883328
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
@@ -884,13 +884,13 @@ wrote 10485760/10485760 bytes at offset 3298534883328
 sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-256-xts-essiv-sha256-sha1.img qiotest-145-aes-256-xts-essiv-sha256-sha1
 # Read test pattern 0x91
 sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-essiv-sha256-sha1
-qemu-io -c read -P 0x91 100M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-xts-essiv-sha256-sha1
+qemu-io -c read -P 0x91 100M 10M --image-opts driver=host_device,filename=/dev/mapper/qiotest-145-aes-256-xts-essiv-sha256-sha1
 read 10485760/10485760 bytes at offset 104857600
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 # Read test pattern 0x5e
 sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-essiv-sha256-sha1
-qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-xts-essiv-sha256-sha1
+qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=host_device,filename=/dev/mapper/qiotest-145-aes-256-xts-essiv-sha256-sha1
 read 10485760/10485760 bytes at offset 3298534883328
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
@@ -908,13 +908,13 @@ Formatting 'TEST_DIR/luks-aes-256-xts-essiv-sha256-sha1.img', fmt=luks size=4398
 sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-256-xts-essiv-sha256-sha1.img qiotest-145-aes-256-xts-essiv-sha256-sha1
 # Write test pattern 0xa7
 sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-essiv-sha256-sha1
-qemu-io -c write -P 0xa7 100M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-xts-essiv-sha256-sha1
+qemu-io -c write -P 0xa7 100M 10M --image-opts driver=host_device,filename=/dev/mapper/qiotest-145-aes-256-xts-essiv-sha256-sha1
 wrote 10485760/10485760 bytes at offset 104857600
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 # Write test pattern 0x13
 sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-essiv-sha256-sha1
-qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-xts-essiv-sha256-sha1
+qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=host_device,filename=/dev/mapper/qiotest-145-aes-256-xts-essiv-sha256-sha1
 wrote 10485760/10485760 bytes at offset 3298534883328
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
@@ -944,13 +944,13 @@ wrote 10485760/10485760 bytes at offset 3298534883328
 sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-256-xts-essiv-sha256-sha1.img qiotest-145-aes-256-xts-essiv-sha256-sha1
 # Read test pattern 0x91
 sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-essiv-sha256-sha1
-qemu-io -c read -P 0x91 100M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-xts-essiv-sha256-sha1
+qemu-io -c read -P 0x91 100M 10M --image-opts driver=host_device,filename=/dev/mapper/qiotest-145-aes-256-xts-essiv-sha256-sha1
 read 10485760/10485760 bytes at offset 104857600
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 # Read test pattern 0x5e
 sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-essiv-sha256-sha1
-qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-xts-essiv-sha256-sha1
+qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=host_device,filename=/dev/mapper/qiotest-145-aes-256-xts-essiv-sha256-sha1
 read 10485760/10485760 bytes at offset 3298534883328
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
@@ -968,13 +968,13 @@ sudo cryptsetup -q -v luksFormat --cipher aes-xts-plain64 --key-size 256 --hash
 sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-128-xts-plain64-sha256-sha1.img qiotest-145-aes-128-xts-plain64-sha256-sha1
 # Write test pattern 0xa7
 sudo chown UID:GID /dev/mapper/qiotest-145-aes-128-xts-plain64-sha256-sha1
-qemu-io -c write -P 0xa7 100M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-128-xts-plain64-sha256-sha1
+qemu-io -c write -P 0xa7 100M 10M --image-opts driver=host_device,filename=/dev/mapper/qiotest-145-aes-128-xts-plain64-sha256-sha1
 wrote 10485760/10485760 bytes at offset 104857600
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 # Write test pattern 0x13
 sudo chown UID:GID /dev/mapper/qiotest-145-aes-128-xts-plain64-sha256-sha1
-qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-128-xts-plain64-sha256-sha1
+qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=host_device,filename=/dev/mapper/qiotest-145-aes-128-xts-plain64-sha256-sha1
 wrote 10485760/10485760 bytes at offset 3298534883328
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
@@ -1004,13 +1004,13 @@ wrote 10485760/10485760 bytes at offset 3298534883328
 sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-128-xts-plain64-sha256-sha1.img qiotest-145-aes-128-xts-plain64-sha256-sha1
 # Read test pattern 0x91
 sudo chown UID:GID /dev/mapper/qiotest-145-aes-128-xts-plain64-sha256-sha1
-qemu-io -c read -P 0x91 100M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-128-xts-plain64-sha256-sha1
+qemu-io -c read -P 0x91 100M 10M --image-opts driver=host_device,filename=/dev/mapper/qiotest-145-aes-128-xts-plain64-sha256-sha1
 read 10485760/10485760 bytes at offset 104857600
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 # Read test pattern 0x5e
 sudo chown UID:GID /dev/mapper/qiotest-145-aes-128-xts-plain64-sha256-sha1
-qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-128-xts-plain64-sha256-sha1
+qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=host_device,filename=/dev/mapper/qiotest-145-aes-128-xts-plain64-sha256-sha1
 read 10485760/10485760 bytes at offset 3298534883328
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
@@ -1028,13 +1028,13 @@ Formatting 'TEST_DIR/luks-aes-128-xts-plain64-sha256-sha1.img', fmt=luks size=43
 sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-128-xts-plain64-sha256-sha1.img qiotest-145-aes-128-xts-plain64-sha256-sha1
 # Write test pattern 0xa7
 sudo chown UID:GID /dev/mapper/qiotest-145-aes-128-xts-plain64-sha256-sha1
-qemu-io -c write -P 0xa7 100M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-128-xts-plain64-sha256-sha1
+qemu-io -c write -P 0xa7 100M 10M --image-opts driver=host_device,filename=/dev/mapper/qiotest-145-aes-128-xts-plain64-sha256-sha1
 wrote 10485760/10485760 bytes at offset 104857600
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 # Write test pattern 0x13
 sudo chown UID:GID /dev/mapper/qiotest-145-aes-128-xts-plain64-sha256-sha1
-qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-128-xts-plain64-sha256-sha1
+qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=host_device,filename=/dev/mapper/qiotest-145-aes-128-xts-plain64-sha256-sha1
 wrote 10485760/10485760 bytes at offset 3298534883328
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
@@ -1064,13 +1064,13 @@ wrote 10485760/10485760 bytes at offset 3298534883328
 sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-128-xts-plain64-sha256-sha1.img qiotest-145-aes-128-xts-plain64-sha256-sha1
 # Read test pattern 0x91
 sudo chown UID:GID /dev/mapper/qiotest-145-aes-128-xts-plain64-sha256-sha1
-qemu-io -c read -P 0x91 100M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-128-xts-plain64-sha256-sha1
+qemu-io -c read -P 0x91 100M 10M --image-opts driver=host_device,filename=/dev/mapper/qiotest-145-aes-128-xts-plain64-sha256-sha1
 read 10485760/10485760 bytes at offset 104857600
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 # Read test pattern 0x5e
 sudo chown UID:GID /dev/mapper/qiotest-145-aes-128-xts-plain64-sha256-sha1
-qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-128-xts-plain64-sha256-sha1
+qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=host_device,filename=/dev/mapper/qiotest-145-aes-128-xts-plain64-sha256-sha1
 read 10485760/10485760 bytes at offset 3298534883328
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
@@ -1088,13 +1088,13 @@ sudo cryptsetup -q -v luksFormat --cipher aes-xts-plain64 --key-size 384 --hash
 sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-192-xts-plain64-sha256-sha1.img qiotest-145-aes-192-xts-plain64-sha256-sha1
 # Write test pattern 0xa7
 sudo chown UID:GID /dev/mapper/qiotest-145-aes-192-xts-plain64-sha256-sha1
-qemu-io -c write -P 0xa7 100M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-192-xts-plain64-sha256-sha1
+qemu-io -c write -P 0xa7 100M 10M --image-opts driver=host_device,filename=/dev/mapper/qiotest-145-aes-192-xts-plain64-sha256-sha1
 wrote 10485760/10485760 bytes at offset 104857600
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 # Write test pattern 0x13
 sudo chown UID:GID /dev/mapper/qiotest-145-aes-192-xts-plain64-sha256-sha1
-qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-192-xts-plain64-sha256-sha1
+qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=host_device,filename=/dev/mapper/qiotest-145-aes-192-xts-plain64-sha256-sha1
 wrote 10485760/10485760 bytes at offset 3298534883328
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
@@ -1124,13 +1124,13 @@ wrote 10485760/10485760 bytes at offset 3298534883328
 sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-192-xts-plain64-sha256-sha1.img qiotest-145-aes-192-xts-plain64-sha256-sha1
 # Read test pattern 0x91
 sudo chown UID:GID /dev/mapper/qiotest-145-aes-192-xts-plain64-sha256-sha1
-qemu-io -c read -P 0x91 100M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-192-xts-plain64-sha256-sha1
+qemu-io -c read -P 0x91 100M 10M --image-opts driver=host_device,filename=/dev/mapper/qiotest-145-aes-192-xts-plain64-sha256-sha1
 read 10485760/10485760 bytes at offset 104857600
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 # Read test pattern 0x5e
 sudo chown UID:GID /dev/mapper/qiotest-145-aes-192-xts-plain64-sha256-sha1
-qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-192-xts-plain64-sha256-sha1
+qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=host_device,filename=/dev/mapper/qiotest-145-aes-192-xts-plain64-sha256-sha1
 read 10485760/10485760 bytes at offset 3298534883328
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
@@ -1148,13 +1148,13 @@ Formatting 'TEST_DIR/luks-aes-192-xts-plain64-sha256-sha1.img', fmt=luks size=43
 sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-192-xts-plain64-sha256-sha1.img qiotest-145-aes-192-xts-plain64-sha256-sha1
 # Write test pattern 0xa7
 sudo chown UID:GID /dev/mapper/qiotest-145-aes-192-xts-plain64-sha256-sha1
-qemu-io -c write -P 0xa7 100M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-192-xts-plain64-sha256-sha1
+qemu-io -c write -P 0xa7 100M 10M --image-opts driver=host_device,filename=/dev/mapper/qiotest-145-aes-192-xts-plain64-sha256-sha1
 wrote 10485760/10485760 bytes at offset 104857600
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 # Write test pattern 0x13
 sudo chown UID:GID /dev/mapper/qiotest-145-aes-192-xts-plain64-sha256-sha1
-qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-192-xts-plain64-sha256-sha1
+qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=host_device,filename=/dev/mapper/qiotest-145-aes-192-xts-plain64-sha256-sha1
 wrote 10485760/10485760 bytes at offset 3298534883328
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
@@ -1184,13 +1184,13 @@ wrote 10485760/10485760 bytes at offset 3298534883328
 sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-192-xts-plain64-sha256-sha1.img qiotest-145-aes-192-xts-plain64-sha256-sha1
 # Read test pattern 0x91
 sudo chown UID:GID /dev/mapper/qiotest-145-aes-192-xts-plain64-sha256-sha1
-qemu-io -c read -P 0x91 100M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-192-xts-plain64-sha256-sha1
+qemu-io -c read -P 0x91 100M 10M --image-opts driver=host_device,filename=/dev/mapper/qiotest-145-aes-192-xts-plain64-sha256-sha1
 read 10485760/10485760 bytes at offset 104857600
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 # Read test pattern 0x5e
 sudo chown UID:GID /dev/mapper/qiotest-145-aes-192-xts-plain64-sha256-sha1
-qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-192-xts-plain64-sha256-sha1
+qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=host_device,filename=/dev/mapper/qiotest-145-aes-192-xts-plain64-sha256-sha1
 read 10485760/10485760 bytes at offset 3298534883328
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
@@ -1208,13 +1208,13 @@ sudo cryptsetup -q -v luksFormat --cipher twofish-xts-plain64 --key-size 256 --h
 sudo cryptsetup -q -v luksOpen TEST_DIR/luks-twofish-128-xts-plain64-sha1.img qiotest-145-twofish-128-xts-plain64-sha1
 # Write test pattern 0xa7
 sudo chown UID:GID /dev/mapper/qiotest-145-twofish-128-xts-plain64-sha1
-qemu-io -c write -P 0xa7 100M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-twofish-128-xts-plain64-sha1
+qemu-io -c write -P 0xa7 100M 10M --image-opts driver=host_device,filename=/dev/mapper/qiotest-145-twofish-128-xts-plain64-sha1
 wrote 10485760/10485760 bytes at offset 104857600
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 # Write test pattern 0x13
 sudo chown UID:GID /dev/mapper/qiotest-145-twofish-128-xts-plain64-sha1
-qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-twofish-128-xts-plain64-sha1
+qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=host_device,filename=/dev/mapper/qiotest-145-twofish-128-xts-plain64-sha1
 wrote 10485760/10485760 bytes at offset 3298534883328
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
@@ -1244,13 +1244,13 @@ wrote 10485760/10485760 bytes at offset 3298534883328
 sudo cryptsetup -q -v luksOpen TEST_DIR/luks-twofish-128-xts-plain64-sha1.img qiotest-145-twofish-128-xts-plain64-sha1
 # Read test pattern 0x91
 sudo chown UID:GID /dev/mapper/qiotest-145-twofish-128-xts-plain64-sha1
-qemu-io -c read -P 0x91 100M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-twofish-128-xts-plain64-sha1
+qemu-io -c read -P 0x91 100M 10M --image-opts driver=host_device,filename=/dev/mapper/qiotest-145-twofish-128-xts-plain64-sha1
 read 10485760/10485760 bytes at offset 104857600
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 # Read test pattern 0x5e
 sudo chown UID:GID /dev/mapper/qiotest-145-twofish-128-xts-plain64-sha1
-qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-twofish-128-xts-plain64-sha1
+qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=host_device,filename=/dev/mapper/qiotest-145-twofish-128-xts-plain64-sha1
 read 10485760/10485760 bytes at offset 3298534883328
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
@@ -1268,13 +1268,13 @@ Formatting 'TEST_DIR/luks-twofish-128-xts-plain64-sha1.img', fmt=luks size=43980
 sudo cryptsetup -q -v luksOpen TEST_DIR/luks-twofish-128-xts-plain64-sha1.img qiotest-145-twofish-128-xts-plain64-sha1
 # Write test pattern 0xa7
 sudo chown UID:GID /dev/mapper/qiotest-145-twofish-128-xts-plain64-sha1
-qemu-io -c write -P 0xa7 100M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-twofish-128-xts-plain64-sha1
+qemu-io -c write -P 0xa7 100M 10M --image-opts driver=host_device,filename=/dev/mapper/qiotest-145-twofish-128-xts-plain64-sha1
 wrote 10485760/10485760 bytes at offset 104857600
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 # Write test pattern 0x13
 sudo chown UID:GID /dev/mapper/qiotest-145-twofish-128-xts-plain64-sha1
-qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-twofish-128-xts-plain64-sha1
+qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=host_device,filename=/dev/mapper/qiotest-145-twofish-128-xts-plain64-sha1
 wrote 10485760/10485760 bytes at offset 3298534883328
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
@@ -1304,13 +1304,13 @@ wrote 10485760/10485760 bytes at offset 3298534883328
 sudo cryptsetup -q -v luksOpen TEST_DIR/luks-twofish-128-xts-plain64-sha1.img qiotest-145-twofish-128-xts-plain64-sha1
 # Read test pattern 0x91
 sudo chown UID:GID /dev/mapper/qiotest-145-twofish-128-xts-plain64-sha1
-qemu-io -c read -P 0x91 100M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-twofish-128-xts-plain64-sha1
+qemu-io -c read -P 0x91 100M 10M --image-opts driver=host_device,filename=/dev/mapper/qiotest-145-twofish-128-xts-plain64-sha1
 read 10485760/10485760 bytes at offset 104857600
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 # Read test pattern 0x5e
 sudo chown UID:GID /dev/mapper/qiotest-145-twofish-128-xts-plain64-sha1
-qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-twofish-128-xts-plain64-sha1
+qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=host_device,filename=/dev/mapper/qiotest-145-twofish-128-xts-plain64-sha1
 read 10485760/10485760 bytes at offset 3298534883328
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
@@ -1329,13 +1329,13 @@ sudo cryptsetup -q -v luksFormat --cipher serpent-xts-plain64 --key-size 256 --h
 sudo cryptsetup -q -v luksOpen TEST_DIR/luks-serpent-128-xts-plain64-sha1.img qiotest-145-serpent-128-xts-plain64-sha1
 # Write test pattern 0xa7
 sudo chown UID:GID /dev/mapper/qiotest-145-serpent-128-xts-plain64-sha1
-qemu-io -c write -P 0xa7 100M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-serpent-128-xts-plain64-sha1
+qemu-io -c write -P 0xa7 100M 10M --image-opts driver=host_device,filename=/dev/mapper/qiotest-145-serpent-128-xts-plain64-sha1
 wrote 10485760/10485760 bytes at offset 104857600
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 # Write test pattern 0x13
 sudo chown UID:GID /dev/mapper/qiotest-145-serpent-128-xts-plain64-sha1
-qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-serpent-128-xts-plain64-sha1
+qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=host_device,filename=/dev/mapper/qiotest-145-serpent-128-xts-plain64-sha1
 wrote 10485760/10485760 bytes at offset 3298534883328
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
@@ -1365,13 +1365,13 @@ wrote 10485760/10485760 bytes at offset 3298534883328
 sudo cryptsetup -q -v luksOpen TEST_DIR/luks-serpent-128-xts-plain64-sha1.img qiotest-145-serpent-128-xts-plain64-sha1
 # Read test pattern 0x91
 sudo chown UID:GID /dev/mapper/qiotest-145-serpent-128-xts-plain64-sha1
-qemu-io -c read -P 0x91 100M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-serpent-128-xts-plain64-sha1
+qemu-io -c read -P 0x91 100M 10M --image-opts driver=host_device,filename=/dev/mapper/qiotest-145-serpent-128-xts-plain64-sha1
 read 10485760/10485760 bytes at offset 104857600
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 # Read test pattern 0x5e
 sudo chown UID:GID /dev/mapper/qiotest-145-serpent-128-xts-plain64-sha1
-qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-serpent-128-xts-plain64-sha1
+qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=host_device,filename=/dev/mapper/qiotest-145-serpent-128-xts-plain64-sha1
 read 10485760/10485760 bytes at offset 3298534883328
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
@@ -1389,13 +1389,13 @@ Formatting 'TEST_DIR/luks-serpent-128-xts-plain64-sha1.img', fmt=luks size=43980
 sudo cryptsetup -q -v luksOpen TEST_DIR/luks-serpent-128-xts-plain64-sha1.img qiotest-145-serpent-128-xts-plain64-sha1
 # Write test pattern 0xa7
 sudo chown UID:GID /dev/mapper/qiotest-145-serpent-128-xts-plain64-sha1
-qemu-io -c write -P 0xa7 100M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-serpent-128-xts-plain64-sha1
+qemu-io -c write -P 0xa7 100M 10M --image-opts driver=host_device,filename=/dev/mapper/qiotest-145-serpent-128-xts-plain64-sha1
 wrote 10485760/10485760 bytes at offset 104857600
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 # Write test pattern 0x13
 sudo chown UID:GID /dev/mapper/qiotest-145-serpent-128-xts-plain64-sha1
-qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-serpent-128-xts-plain64-sha1
+qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=host_device,filename=/dev/mapper/qiotest-145-serpent-128-xts-plain64-sha1
 wrote 10485760/10485760 bytes at offset 3298534883328
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
@@ -1425,13 +1425,13 @@ wrote 10485760/10485760 bytes at offset 3298534883328
 sudo cryptsetup -q -v luksOpen TEST_DIR/luks-serpent-128-xts-plain64-sha1.img qiotest-145-serpent-128-xts-plain64-sha1
 # Read test pattern 0x91
 sudo chown UID:GID /dev/mapper/qiotest-145-serpent-128-xts-plain64-sha1
-qemu-io -c read -P 0x91 100M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-serpent-128-xts-plain64-sha1
+qemu-io -c read -P 0x91 100M 10M --image-opts driver=host_device,filename=/dev/mapper/qiotest-145-serpent-128-xts-plain64-sha1
 read 10485760/10485760 bytes at offset 104857600
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 # Read test pattern 0x5e
 sudo chown UID:GID /dev/mapper/qiotest-145-serpent-128-xts-plain64-sha1
-qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-serpent-128-xts-plain64-sha1
+qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=host_device,filename=/dev/mapper/qiotest-145-serpent-128-xts-plain64-sha1
 read 10485760/10485760 bytes at offset 3298534883328
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
@@ -1449,13 +1449,13 @@ sudo cryptsetup -q -v luksFormat --cipher serpent-xts-plain64 --key-size 384 --h
 sudo cryptsetup -q -v luksOpen TEST_DIR/luks-serpent-192-xts-plain64-sha1.img qiotest-145-serpent-192-xts-plain64-sha1
 # Write test pattern 0xa7
 sudo chown UID:GID /dev/mapper/qiotest-145-serpent-192-xts-plain64-sha1
-qemu-io -c write -P 0xa7 100M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-serpent-192-xts-plain64-sha1
+qemu-io -c write -P 0xa7 100M 10M --image-opts driver=host_device,filename=/dev/mapper/qiotest-145-serpent-192-xts-plain64-sha1
 wrote 10485760/10485760 bytes at offset 104857600
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 # Write test pattern 0x13
 sudo chown UID:GID /dev/mapper/qiotest-145-serpent-192-xts-plain64-sha1
-qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-serpent-192-xts-plain64-sha1
+qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=host_device,filename=/dev/mapper/qiotest-145-serpent-192-xts-plain64-sha1
 wrote 10485760/10485760 bytes at offset 3298534883328
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
@@ -1485,13 +1485,13 @@ wrote 10485760/10485760 bytes at offset 3298534883328
 sudo cryptsetup -q -v luksOpen TEST_DIR/luks-serpent-192-xts-plain64-sha1.img qiotest-145-serpent-192-xts-plain64-sha1
 # Read test pattern 0x91
 sudo chown UID:GID /dev/mapper/qiotest-145-serpent-192-xts-plain64-sha1
-qemu-io -c read -P 0x91 100M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-serpent-192-xts-plain64-sha1
+qemu-io -c read -P 0x91 100M 10M --image-opts driver=host_device,filename=/dev/mapper/qiotest-145-serpent-192-xts-plain64-sha1
 read 10485760/10485760 bytes at offset 104857600
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 # Read test pattern 0x5e
 sudo chown UID:GID /dev/mapper/qiotest-145-serpent-192-xts-plain64-sha1
-qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-serpent-192-xts-plain64-sha1
+qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=host_device,filename=/dev/mapper/qiotest-145-serpent-192-xts-plain64-sha1
 read 10485760/10485760 bytes at offset 3298534883328
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
@@ -1509,13 +1509,13 @@ Formatting 'TEST_DIR/luks-serpent-192-xts-plain64-sha1.img', fmt=luks size=43980
 sudo cryptsetup -q -v luksOpen TEST_DIR/luks-serpent-192-xts-plain64-sha1.img qiotest-145-serpent-192-xts-plain64-sha1
 # Write test pattern 0xa7
 sudo chown UID:GID /dev/mapper/qiotest-145-serpent-192-xts-plain64-sha1
-qemu-io -c write -P 0xa7 100M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-serpent-192-xts-plain64-sha1
+qemu-io -c write -P 0xa7 100M 10M --image-opts driver=host_device,filename=/dev/mapper/qiotest-145-serpent-192-xts-plain64-sha1
 wrote 10485760/10485760 bytes at offset 104857600
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 # Write test pattern 0x13
 sudo chown UID:GID /dev/mapper/qiotest-145-serpent-192-xts-plain64-sha1
-qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-serpent-192-xts-plain64-sha1
+qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=host_device,filename=/dev/mapper/qiotest-145-serpent-192-xts-plain64-sha1
 wrote 10485760/10485760 bytes at offset 3298534883328
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
@@ -1545,13 +1545,13 @@ wrote 10485760/10485760 bytes at offset 3298534883328
 sudo cryptsetup -q -v luksOpen TEST_DIR/luks-serpent-192-xts-plain64-sha1.img qiotest-145-serpent-192-xts-plain64-sha1
 # Read test pattern 0x91
 sudo chown UID:GID /dev/mapper/qiotest-145-serpent-192-xts-plain64-sha1
-qemu-io -c read -P 0x91 100M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-serpent-192-xts-plain64-sha1
+qemu-io -c read -P 0x91 100M 10M --image-opts driver=host_device,filename=/dev/mapper/qiotest-145-serpent-192-xts-plain64-sha1
 read 10485760/10485760 bytes at offset 104857600
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 # Read test pattern 0x5e
 sudo chown UID:GID /dev/mapper/qiotest-145-serpent-192-xts-plain64-sha1
-qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-serpent-192-xts-plain64-sha1
+qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=host_device,filename=/dev/mapper/qiotest-145-serpent-192-xts-plain64-sha1
 read 10485760/10485760 bytes at offset 3298534883328
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
@@ -1571,13 +1571,13 @@ sudo cryptsetup -q -v luksFormat --cipher aes-xts-plain64 --key-size 512 --hash
 sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-256-xts-plain64-sha224.img qiotest-145-aes-256-xts-plain64-sha224
 # Write test pattern 0xa7
 sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain64-sha224
-qemu-io -c write -P 0xa7 100M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-xts-plain64-sha224
+qemu-io -c write -P 0xa7 100M 10M --image-opts driver=host_device,filename=/dev/mapper/qiotest-145-aes-256-xts-plain64-sha224
 wrote 10485760/10485760 bytes at offset 104857600
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 # Write test pattern 0x13
 sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain64-sha224
-qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-xts-plain64-sha224
+qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=host_device,filename=/dev/mapper/qiotest-145-aes-256-xts-plain64-sha224
 wrote 10485760/10485760 bytes at offset 3298534883328
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
@@ -1607,13 +1607,13 @@ wrote 10485760/10485760 bytes at offset 3298534883328
 sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-256-xts-plain64-sha224.img qiotest-145-aes-256-xts-plain64-sha224
 # Read test pattern 0x91
 sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain64-sha224
-qemu-io -c read -P 0x91 100M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-xts-plain64-sha224
+qemu-io -c read -P 0x91 100M 10M --image-opts driver=host_device,filename=/dev/mapper/qiotest-145-aes-256-xts-plain64-sha224
 read 10485760/10485760 bytes at offset 104857600
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 # Read test pattern 0x5e
 sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain64-sha224
-qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-xts-plain64-sha224
+qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=host_device,filename=/dev/mapper/qiotest-145-aes-256-xts-plain64-sha224
 read 10485760/10485760 bytes at offset 3298534883328
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
@@ -1631,13 +1631,13 @@ Formatting 'TEST_DIR/luks-aes-256-xts-plain64-sha224.img', fmt=luks size=4398046
 sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-256-xts-plain64-sha224.img qiotest-145-aes-256-xts-plain64-sha224
 # Write test pattern 0xa7
 sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain64-sha224
-qemu-io -c write -P 0xa7 100M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-xts-plain64-sha224
+qemu-io -c write -P 0xa7 100M 10M --image-opts driver=host_device,filename=/dev/mapper/qiotest-145-aes-256-xts-plain64-sha224
 wrote 10485760/10485760 bytes at offset 104857600
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 # Write test pattern 0x13
 sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain64-sha224
-qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-xts-plain64-sha224
+qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=host_device,filename=/dev/mapper/qiotest-145-aes-256-xts-plain64-sha224
 wrote 10485760/10485760 bytes at offset 3298534883328
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
@@ -1667,13 +1667,13 @@ wrote 10485760/10485760 bytes at offset 3298534883328
 sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-256-xts-plain64-sha224.img qiotest-145-aes-256-xts-plain64-sha224
 # Read test pattern 0x91
 sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain64-sha224
-qemu-io -c read -P 0x91 100M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-xts-plain64-sha224
+qemu-io -c read -P 0x91 100M 10M --image-opts driver=host_device,filename=/dev/mapper/qiotest-145-aes-256-xts-plain64-sha224
 read 10485760/10485760 bytes at offset 104857600
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 # Read test pattern 0x5e
 sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain64-sha224
-qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-xts-plain64-sha224
+qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=host_device,filename=/dev/mapper/qiotest-145-aes-256-xts-plain64-sha224
 read 10485760/10485760 bytes at offset 3298534883328
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
@@ -1691,13 +1691,13 @@ sudo cryptsetup -q -v luksFormat --cipher aes-xts-plain64 --key-size 512 --hash
 sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-256-xts-plain64-sha256.img qiotest-145-aes-256-xts-plain64-sha256
 # Write test pattern 0xa7
 sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain64-sha256
-qemu-io -c write -P 0xa7 100M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-xts-plain64-sha256
+qemu-io -c write -P 0xa7 100M 10M --image-opts driver=host_device,filename=/dev/mapper/qiotest-145-aes-256-xts-plain64-sha256
 wrote 10485760/10485760 bytes at offset 104857600
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 # Write test pattern 0x13
 sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain64-sha256
-qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-xts-plain64-sha256
+qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=host_device,filename=/dev/mapper/qiotest-145-aes-256-xts-plain64-sha256
 wrote 10485760/10485760 bytes at offset 3298534883328
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
@@ -1727,13 +1727,13 @@ wrote 10485760/10485760 bytes at offset 3298534883328
 sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-256-xts-plain64-sha256.img qiotest-145-aes-256-xts-plain64-sha256
 # Read test pattern 0x91
 sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain64-sha256
-qemu-io -c read -P 0x91 100M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-xts-plain64-sha256
+qemu-io -c read -P 0x91 100M 10M --image-opts driver=host_device,filename=/dev/mapper/qiotest-145-aes-256-xts-plain64-sha256
 read 10485760/10485760 bytes at offset 104857600
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 # Read test pattern 0x5e
 sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain64-sha256
-qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-xts-plain64-sha256
+qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=host_device,filename=/dev/mapper/qiotest-145-aes-256-xts-plain64-sha256
 read 10485760/10485760 bytes at offset 3298534883328
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
@@ -1751,13 +1751,13 @@ Formatting 'TEST_DIR/luks-aes-256-xts-plain64-sha256.img', fmt=luks size=4398046
 sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-256-xts-plain64-sha256.img qiotest-145-aes-256-xts-plain64-sha256
 # Write test pattern 0xa7
 sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain64-sha256
-qemu-io -c write -P 0xa7 100M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-xts-plain64-sha256
+qemu-io -c write -P 0xa7 100M 10M --image-opts driver=host_device,filename=/dev/mapper/qiotest-145-aes-256-xts-plain64-sha256
 wrote 10485760/10485760 bytes at offset 104857600
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 # Write test pattern 0x13
 sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain64-sha256
-qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-xts-plain64-sha256
+qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=host_device,filename=/dev/mapper/qiotest-145-aes-256-xts-plain64-sha256
 wrote 10485760/10485760 bytes at offset 3298534883328
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
@@ -1787,13 +1787,13 @@ wrote 10485760/10485760 bytes at offset 3298534883328
 sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-256-xts-plain64-sha256.img qiotest-145-aes-256-xts-plain64-sha256
 # Read test pattern 0x91
 sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain64-sha256
-qemu-io -c read -P 0x91 100M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-xts-plain64-sha256
+qemu-io -c read -P 0x91 100M 10M --image-opts driver=host_device,filename=/dev/mapper/qiotest-145-aes-256-xts-plain64-sha256
 read 10485760/10485760 bytes at offset 104857600
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 # Read test pattern 0x5e
 sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain64-sha256
-qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-xts-plain64-sha256
+qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=host_device,filename=/dev/mapper/qiotest-145-aes-256-xts-plain64-sha256
 read 10485760/10485760 bytes at offset 3298534883328
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
@@ -1811,13 +1811,13 @@ sudo cryptsetup -q -v luksFormat --cipher aes-xts-plain64 --key-size 512 --hash
 sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-256-xts-plain64-sha384.img qiotest-145-aes-256-xts-plain64-sha384
 # Write test pattern 0xa7
 sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain64-sha384
-qemu-io -c write -P 0xa7 100M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-xts-plain64-sha384
+qemu-io -c write -P 0xa7 100M 10M --image-opts driver=host_device,filename=/dev/mapper/qiotest-145-aes-256-xts-plain64-sha384
 wrote 10485760/10485760 bytes at offset 104857600
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 # Write test pattern 0x13
 sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain64-sha384
-qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-xts-plain64-sha384
+qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=host_device,filename=/dev/mapper/qiotest-145-aes-256-xts-plain64-sha384
 wrote 10485760/10485760 bytes at offset 3298534883328
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
@@ -1847,13 +1847,13 @@ wrote 10485760/10485760 bytes at offset 3298534883328
 sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-256-xts-plain64-sha384.img qiotest-145-aes-256-xts-plain64-sha384
 # Read test pattern 0x91
 sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain64-sha384
-qemu-io -c read -P 0x91 100M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-xts-plain64-sha384
+qemu-io -c read -P 0x91 100M 10M --image-opts driver=host_device,filename=/dev/mapper/qiotest-145-aes-256-xts-plain64-sha384
 read 10485760/10485760 bytes at offset 104857600
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 # Read test pattern 0x5e
 sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain64-sha384
-qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-xts-plain64-sha384
+qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=host_device,filename=/dev/mapper/qiotest-145-aes-256-xts-plain64-sha384
 read 10485760/10485760 bytes at offset 3298534883328
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
@@ -1871,13 +1871,13 @@ Formatting 'TEST_DIR/luks-aes-256-xts-plain64-sha384.img', fmt=luks size=4398046
 sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-256-xts-plain64-sha384.img qiotest-145-aes-256-xts-plain64-sha384
 # Write test pattern 0xa7
 sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain64-sha384
-qemu-io -c write -P 0xa7 100M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-xts-plain64-sha384
+qemu-io -c write -P 0xa7 100M 10M --image-opts driver=host_device,filename=/dev/mapper/qiotest-145-aes-256-xts-plain64-sha384
 wrote 10485760/10485760 bytes at offset 104857600
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 # Write test pattern 0x13
 sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain64-sha384
-qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-xts-plain64-sha384
+qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=host_device,filename=/dev/mapper/qiotest-145-aes-256-xts-plain64-sha384
 wrote 10485760/10485760 bytes at offset 3298534883328
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
@@ -1907,13 +1907,13 @@ wrote 10485760/10485760 bytes at offset 3298534883328
 sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-256-xts-plain64-sha384.img qiotest-145-aes-256-xts-plain64-sha384
 # Read test pattern 0x91
 sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain64-sha384
-qemu-io -c read -P 0x91 100M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-xts-plain64-sha384
+qemu-io -c read -P 0x91 100M 10M --image-opts driver=host_device,filename=/dev/mapper/qiotest-145-aes-256-xts-plain64-sha384
 read 10485760/10485760 bytes at offset 104857600
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 # Read test pattern 0x5e
 sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain64-sha384
-qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-xts-plain64-sha384
+qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=host_device,filename=/dev/mapper/qiotest-145-aes-256-xts-plain64-sha384
 read 10485760/10485760 bytes at offset 3298534883328
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
@@ -1931,13 +1931,13 @@ sudo cryptsetup -q -v luksFormat --cipher aes-xts-plain64 --key-size 512 --hash
 sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-256-xts-plain64-sha512.img qiotest-145-aes-256-xts-plain64-sha512
 # Write test pattern 0xa7
 sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain64-sha512
-qemu-io -c write -P 0xa7 100M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-xts-plain64-sha512
+qemu-io -c write -P 0xa7 100M 10M --image-opts driver=host_device,filename=/dev/mapper/qiotest-145-aes-256-xts-plain64-sha512
 wrote 10485760/10485760 bytes at offset 104857600
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 # Write test pattern 0x13
 sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain64-sha512
-qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-xts-plain64-sha512
+qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=host_device,filename=/dev/mapper/qiotest-145-aes-256-xts-plain64-sha512
 wrote 10485760/10485760 bytes at offset 3298534883328
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
@@ -1967,13 +1967,13 @@ wrote 10485760/10485760 bytes at offset 3298534883328
 sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-256-xts-plain64-sha512.img qiotest-145-aes-256-xts-plain64-sha512
 # Read test pattern 0x91
 sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain64-sha512
-qemu-io -c read -P 0x91 100M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-xts-plain64-sha512
+qemu-io -c read -P 0x91 100M 10M --image-opts driver=host_device,filename=/dev/mapper/qiotest-145-aes-256-xts-plain64-sha512
 read 10485760/10485760 bytes at offset 104857600
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 # Read test pattern 0x5e
 sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain64-sha512
-qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-xts-plain64-sha512
+qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=host_device,filename=/dev/mapper/qiotest-145-aes-256-xts-plain64-sha512
 read 10485760/10485760 bytes at offset 3298534883328
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
@@ -1991,13 +1991,13 @@ Formatting 'TEST_DIR/luks-aes-256-xts-plain64-sha512.img', fmt=luks size=4398046
 sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-256-xts-plain64-sha512.img qiotest-145-aes-256-xts-plain64-sha512
 # Write test pattern 0xa7
 sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain64-sha512
-qemu-io -c write -P 0xa7 100M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-xts-plain64-sha512
+qemu-io -c write -P 0xa7 100M 10M --image-opts driver=host_device,filename=/dev/mapper/qiotest-145-aes-256-xts-plain64-sha512
 wrote 10485760/10485760 bytes at offset 104857600
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 # Write test pattern 0x13
 sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain64-sha512
-qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-xts-plain64-sha512
+qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=host_device,filename=/dev/mapper/qiotest-145-aes-256-xts-plain64-sha512
 wrote 10485760/10485760 bytes at offset 3298534883328
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
@@ -2027,13 +2027,13 @@ wrote 10485760/10485760 bytes at offset 3298534883328
 sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-256-xts-plain64-sha512.img qiotest-145-aes-256-xts-plain64-sha512
 # Read test pattern 0x91
 sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain64-sha512
-qemu-io -c read -P 0x91 100M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-xts-plain64-sha512
+qemu-io -c read -P 0x91 100M 10M --image-opts driver=host_device,filename=/dev/mapper/qiotest-145-aes-256-xts-plain64-sha512
 read 10485760/10485760 bytes at offset 104857600
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 # Read test pattern 0x5e
 sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain64-sha512
-qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-xts-plain64-sha512
+qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=host_device,filename=/dev/mapper/qiotest-145-aes-256-xts-plain64-sha512
 read 10485760/10485760 bytes at offset 3298534883328
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
@@ -2051,13 +2051,13 @@ sudo cryptsetup -q -v luksFormat --cipher aes-xts-plain64 --key-size 512 --hash
 sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-256-xts-plain64-ripemd160.img qiotest-145-aes-256-xts-plain64-ripemd160
 # Write test pattern 0xa7
 sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain64-ripemd160
-qemu-io -c write -P 0xa7 100M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-xts-plain64-ripemd160
+qemu-io -c write -P 0xa7 100M 10M --image-opts driver=host_device,filename=/dev/mapper/qiotest-145-aes-256-xts-plain64-ripemd160
 wrote 10485760/10485760 bytes at offset 104857600
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 # Write test pattern 0x13
 sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain64-ripemd160
-qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-xts-plain64-ripemd160
+qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=host_device,filename=/dev/mapper/qiotest-145-aes-256-xts-plain64-ripemd160
 wrote 10485760/10485760 bytes at offset 3298534883328
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
@@ -2087,13 +2087,13 @@ wrote 10485760/10485760 bytes at offset 3298534883328
 sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-256-xts-plain64-ripemd160.img qiotest-145-aes-256-xts-plain64-ripemd160
 # Read test pattern 0x91
 sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain64-ripemd160
-qemu-io -c read -P 0x91 100M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-xts-plain64-ripemd160
+qemu-io -c read -P 0x91 100M 10M --image-opts driver=host_device,filename=/dev/mapper/qiotest-145-aes-256-xts-plain64-ripemd160
 read 10485760/10485760 bytes at offset 104857600
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 # Read test pattern 0x5e
 sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain64-ripemd160
-qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-xts-plain64-ripemd160
+qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=host_device,filename=/dev/mapper/qiotest-145-aes-256-xts-plain64-ripemd160
 read 10485760/10485760 bytes at offset 3298534883328
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
@@ -2111,13 +2111,13 @@ Formatting 'TEST_DIR/luks-aes-256-xts-plain64-ripemd160.img', fmt=luks size=4398
 sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-256-xts-plain64-ripemd160.img qiotest-145-aes-256-xts-plain64-ripemd160
 # Write test pattern 0xa7
 sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain64-ripemd160
-qemu-io -c write -P 0xa7 100M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-xts-plain64-ripemd160
+qemu-io -c write -P 0xa7 100M 10M --image-opts driver=host_device,filename=/dev/mapper/qiotest-145-aes-256-xts-plain64-ripemd160
 wrote 10485760/10485760 bytes at offset 104857600
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 # Write test pattern 0x13
 sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain64-ripemd160
-qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-xts-plain64-ripemd160
+qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=host_device,filename=/dev/mapper/qiotest-145-aes-256-xts-plain64-ripemd160
 wrote 10485760/10485760 bytes at offset 3298534883328
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
@@ -2147,13 +2147,13 @@ wrote 10485760/10485760 bytes at offset 3298534883328
 sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-256-xts-plain64-ripemd160.img qiotest-145-aes-256-xts-plain64-ripemd160
 # Read test pattern 0x91
 sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain64-ripemd160
-qemu-io -c read -P 0x91 100M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-xts-plain64-ripemd160
+qemu-io -c read -P 0x91 100M 10M --image-opts driver=host_device,filename=/dev/mapper/qiotest-145-aes-256-xts-plain64-ripemd160
 read 10485760/10485760 bytes at offset 104857600
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 # Read test pattern 0x5e
 sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain64-ripemd160
-qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-xts-plain64-ripemd160
+qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=host_device,filename=/dev/mapper/qiotest-145-aes-256-xts-plain64-ripemd160
 read 10485760/10485760 bytes at offset 3298534883328
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
@@ -2171,13 +2171,13 @@ sudo cryptsetup -q -v luksFormat --cipher aes-xts-plain --key-size 512 --hash sh
 sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-256-xts-plain-sha1-pwslot3.img qiotest-145-aes-256-xts-plain-sha1-pwslot3
 # Write test pattern 0xa7
 sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain-sha1-pwslot3
-qemu-io -c write -P 0xa7 100M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-xts-plain-sha1-pwslot3
+qemu-io -c write -P 0xa7 100M 10M --image-opts driver=host_device,filename=/dev/mapper/qiotest-145-aes-256-xts-plain-sha1-pwslot3
 wrote 10485760/10485760 bytes at offset 104857600
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 # Write test pattern 0x13
 sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain-sha1-pwslot3
-qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-xts-plain-sha1-pwslot3
+qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=host_device,filename=/dev/mapper/qiotest-145-aes-256-xts-plain-sha1-pwslot3
 wrote 10485760/10485760 bytes at offset 3298534883328
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
@@ -2207,13 +2207,13 @@ wrote 10485760/10485760 bytes at offset 3298534883328
 sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-256-xts-plain-sha1-pwslot3.img qiotest-145-aes-256-xts-plain-sha1-pwslot3
 # Read test pattern 0x91
 sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain-sha1-pwslot3
-qemu-io -c read -P 0x91 100M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-xts-plain-sha1-pwslot3
+qemu-io -c read -P 0x91 100M 10M --image-opts driver=host_device,filename=/dev/mapper/qiotest-145-aes-256-xts-plain-sha1-pwslot3
 read 10485760/10485760 bytes at offset 104857600
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 # Read test pattern 0x5e
 sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain-sha1-pwslot3
-qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-xts-plain-sha1-pwslot3
+qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=host_device,filename=/dev/mapper/qiotest-145-aes-256-xts-plain-sha1-pwslot3
 read 10485760/10485760 bytes at offset 3298534883328
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
@@ -2245,13 +2245,13 @@ sudo cryptsetup -q -v luksAddKey TEST_DIR/luks-aes-256-xts-plain-sha1-pwallslots
 sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-256-xts-plain-sha1-pwallslots.img qiotest-145-aes-256-xts-plain-sha1-pwallslots
 # Write test pattern 0xa7
 sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain-sha1-pwallslots
-qemu-io -c write -P 0xa7 100M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-xts-plain-sha1-pwallslots
+qemu-io -c write -P 0xa7 100M 10M --image-opts driver=host_device,filename=/dev/mapper/qiotest-145-aes-256-xts-plain-sha1-pwallslots
 wrote 10485760/10485760 bytes at offset 104857600
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 # Write test pattern 0x13
 sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain-sha1-pwallslots
-qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-xts-plain-sha1-pwallslots
+qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=host_device,filename=/dev/mapper/qiotest-145-aes-256-xts-plain-sha1-pwallslots
 wrote 10485760/10485760 bytes at offset 3298534883328
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
@@ -2281,13 +2281,13 @@ wrote 10485760/10485760 bytes at offset 3298534883328
 sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-256-xts-plain-sha1-pwallslots.img qiotest-145-aes-256-xts-plain-sha1-pwallslots
 # Read test pattern 0x91
 sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain-sha1-pwallslots
-qemu-io -c read -P 0x91 100M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-xts-plain-sha1-pwallslots
+qemu-io -c read -P 0x91 100M 10M --image-opts driver=host_device,filename=/dev/mapper/qiotest-145-aes-256-xts-plain-sha1-pwallslots
 read 10485760/10485760 bytes at offset 104857600
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 # Read test pattern 0x5e
 sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain-sha1-pwallslots
-qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-xts-plain-sha1-pwallslots
+qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=host_device,filename=/dev/mapper/qiotest-145-aes-256-xts-plain-sha1-pwallslots
 read 10485760/10485760 bytes at offset 3298534883328
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
@@ -2305,13 +2305,13 @@ Formatting 'TEST_DIR/luks-aes-256-xts-plain-sha1-pwallslots.img', fmt=luks size=
 sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-256-xts-plain-sha1-pwallslots.img qiotest-145-aes-256-xts-plain-sha1-pwallslots
 # Write test pattern 0xa7
 sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain-sha1-pwallslots
-qemu-io -c write -P 0xa7 100M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-xts-plain-sha1-pwallslots
+qemu-io -c write -P 0xa7 100M 10M --image-opts driver=host_device,filename=/dev/mapper/qiotest-145-aes-256-xts-plain-sha1-pwallslots
 wrote 10485760/10485760 bytes at offset 104857600
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 # Write test pattern 0x13
 sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain-sha1-pwallslots
-qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-xts-plain-sha1-pwallslots
+qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=host_device,filename=/dev/mapper/qiotest-145-aes-256-xts-plain-sha1-pwallslots
 wrote 10485760/10485760 bytes at offset 3298534883328
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
@@ -2341,13 +2341,13 @@ wrote 10485760/10485760 bytes at offset 3298534883328
 sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-256-xts-plain-sha1-pwallslots.img qiotest-145-aes-256-xts-plain-sha1-pwallslots
 # Read test pattern 0x91
 sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain-sha1-pwallslots
-qemu-io -c read -P 0x91 100M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-xts-plain-sha1-pwallslots
+qemu-io -c read -P 0x91 100M 10M --image-opts driver=host_device,filename=/dev/mapper/qiotest-145-aes-256-xts-plain-sha1-pwallslots
 read 10485760/10485760 bytes at offset 104857600
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 # Read test pattern 0x5e
 sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain-sha1-pwallslots
-qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-xts-plain-sha1-pwallslots
+qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=host_device,filename=/dev/mapper/qiotest-145-aes-256-xts-plain-sha1-pwallslots
 read 10485760/10485760 bytes at offset 3298534883328
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
@@ -2365,13 +2365,13 @@ sudo cryptsetup -q -v luksFormat --cipher aes-cbc-essiv:sha256 --key-size 256 --
 sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-256-cbc-essiv-auto-sha1.img qiotest-145-aes-256-cbc-essiv-auto-sha1
 # Write test pattern 0xa7
 sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-cbc-essiv-auto-sha1
-qemu-io -c write -P 0xa7 100M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-cbc-essiv-auto-sha1
+qemu-io -c write -P 0xa7 100M 10M --image-opts driver=host_device,filename=/dev/mapper/qiotest-145-aes-256-cbc-essiv-auto-sha1
 wrote 10485760/10485760 bytes at offset 104857600
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 # Write test pattern 0x13
 sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-cbc-essiv-auto-sha1
-qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-cbc-essiv-auto-sha1
+qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=host_device,filename=/dev/mapper/qiotest-145-aes-256-cbc-essiv-auto-sha1
 wrote 10485760/10485760 bytes at offset 3298534883328
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
@@ -2401,13 +2401,13 @@ wrote 10485760/10485760 bytes at offset 3298534883328
 sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-256-cbc-essiv-auto-sha1.img qiotest-145-aes-256-cbc-essiv-auto-sha1
 # Read test pattern 0x91
 sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-cbc-essiv-auto-sha1
-qemu-io -c read -P 0x91 100M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-cbc-essiv-auto-sha1
+qemu-io -c read -P 0x91 100M 10M --image-opts driver=host_device,filename=/dev/mapper/qiotest-145-aes-256-cbc-essiv-auto-sha1
 read 10485760/10485760 bytes at offset 104857600
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 # Read test pattern 0x5e
 sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-cbc-essiv-auto-sha1
-qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-cbc-essiv-auto-sha1
+qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=host_device,filename=/dev/mapper/qiotest-145-aes-256-cbc-essiv-auto-sha1
 read 10485760/10485760 bytes at offset 3298534883328
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
@@ -2425,13 +2425,13 @@ Formatting 'TEST_DIR/luks-aes-256-cbc-essiv-auto-sha1.img', fmt=luks size=439804
 sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-256-cbc-essiv-auto-sha1.img qiotest-145-aes-256-cbc-essiv-auto-sha1
 # Write test pattern 0xa7
 sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-cbc-essiv-auto-sha1
-qemu-io -c write -P 0xa7 100M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-cbc-essiv-auto-sha1
+qemu-io -c write -P 0xa7 100M 10M --image-opts driver=host_device,filename=/dev/mapper/qiotest-145-aes-256-cbc-essiv-auto-sha1
 wrote 10485760/10485760 bytes at offset 104857600
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 # Write test pattern 0x13
 sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-cbc-essiv-auto-sha1
-qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-cbc-essiv-auto-sha1
+qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=host_device,filename=/dev/mapper/qiotest-145-aes-256-cbc-essiv-auto-sha1
 wrote 10485760/10485760 bytes at offset 3298534883328
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
@@ -2461,13 +2461,13 @@ wrote 10485760/10485760 bytes at offset 3298534883328
 sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-256-cbc-essiv-auto-sha1.img qiotest-145-aes-256-cbc-essiv-auto-sha1
 # Read test pattern 0x91
 sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-cbc-essiv-auto-sha1
-qemu-io -c read -P 0x91 100M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-cbc-essiv-auto-sha1
+qemu-io -c read -P 0x91 100M 10M --image-opts driver=host_device,filename=/dev/mapper/qiotest-145-aes-256-cbc-essiv-auto-sha1
 read 10485760/10485760 bytes at offset 104857600
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 # Read test pattern 0x5e
 sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-cbc-essiv-auto-sha1
-qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-cbc-essiv-auto-sha1
+qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=host_device,filename=/dev/mapper/qiotest-145-aes-256-cbc-essiv-auto-sha1
 read 10485760/10485760 bytes at offset 3298534883328
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
@@ -2485,13 +2485,13 @@ sudo cryptsetup -q -v luksFormat --cipher aes-cbc-plain64:sha256 --key-size 256
 sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-256-cbc-plain64-sha256-sha1.img qiotest-145-aes-256-cbc-plain64-sha256-sha1
 # Write test pattern 0xa7
 sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-cbc-plain64-sha256-sha1
-qemu-io -c write -P 0xa7 100M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-cbc-plain64-sha256-sha1
+qemu-io -c write -P 0xa7 100M 10M --image-opts driver=host_device,filename=/dev/mapper/qiotest-145-aes-256-cbc-plain64-sha256-sha1
 wrote 10485760/10485760 bytes at offset 104857600
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 # Write test pattern 0x13
 sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-cbc-plain64-sha256-sha1
-qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-cbc-plain64-sha256-sha1
+qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=host_device,filename=/dev/mapper/qiotest-145-aes-256-cbc-plain64-sha256-sha1
 wrote 10485760/10485760 bytes at offset 3298534883328
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
@@ -2521,13 +2521,13 @@ wrote 10485760/10485760 bytes at offset 3298534883328
 sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-256-cbc-plain64-sha256-sha1.img qiotest-145-aes-256-cbc-plain64-sha256-sha1
 # Read test pattern 0x91
 sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-cbc-plain64-sha256-sha1
-qemu-io -c read -P 0x91 100M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-cbc-plain64-sha256-sha1
+qemu-io -c read -P 0x91 100M 10M --image-opts driver=host_device,filename=/dev/mapper/qiotest-145-aes-256-cbc-plain64-sha256-sha1
 read 10485760/10485760 bytes at offset 104857600
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 # Read test pattern 0x5e
 sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-cbc-plain64-sha256-sha1
-qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-cbc-plain64-sha256-sha1
+qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=host_device,filename=/dev/mapper/qiotest-145-aes-256-cbc-plain64-sha256-sha1
 read 10485760/10485760 bytes at offset 3298534883328
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
@@ -2545,13 +2545,13 @@ Formatting 'TEST_DIR/luks-aes-256-cbc-plain64-sha256-sha1.img', fmt=luks size=43
 sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-256-cbc-plain64-sha256-sha1.img qiotest-145-aes-256-cbc-plain64-sha256-sha1
 # Write test pattern 0xa7
 sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-cbc-plain64-sha256-sha1
-qemu-io -c write -P 0xa7 100M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-cbc-plain64-sha256-sha1
+qemu-io -c write -P 0xa7 100M 10M --image-opts driver=host_device,filename=/dev/mapper/qiotest-145-aes-256-cbc-plain64-sha256-sha1
 wrote 10485760/10485760 bytes at offset 104857600
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 # Write test pattern 0x13
 sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-cbc-plain64-sha256-sha1
-qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-cbc-plain64-sha256-sha1
+qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=host_device,filename=/dev/mapper/qiotest-145-aes-256-cbc-plain64-sha256-sha1
 wrote 10485760/10485760 bytes at offset 3298534883328
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
@@ -2581,13 +2581,13 @@ wrote 10485760/10485760 bytes at offset 3298534883328
 sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-256-cbc-plain64-sha256-sha1.img qiotest-145-aes-256-cbc-plain64-sha256-sha1
 # Read test pattern 0x91
 sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-cbc-plain64-sha256-sha1
-qemu-io -c read -P 0x91 100M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-cbc-plain64-sha256-sha1
+qemu-io -c read -P 0x91 100M 10M --image-opts driver=host_device,filename=/dev/mapper/qiotest-145-aes-256-cbc-plain64-sha256-sha1
 read 10485760/10485760 bytes at offset 104857600
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 # Read test pattern 0x5e
 sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-cbc-plain64-sha256-sha1
-qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-cbc-plain64-sha256-sha1
+qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=host_device,filename=/dev/mapper/qiotest-145-aes-256-cbc-plain64-sha256-sha1
 read 10485760/10485760 bytes at offset 3298534883328
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
-- 
2.13.6
