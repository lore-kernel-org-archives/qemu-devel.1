Received: from eggs.gnu.org ([2001:4830:134:3::10]:49561)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1cdhdD-0007bK-Qe
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 13:15:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1cdhdD-0001cW-0H
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 13:15:15 -0500
From: Jeff Cody <jcody@redhat.com>
Date: Tue, 14 Feb 2017 13:15:07 -0500
Message-Id: <261ff7cb02d96c98ea068f3ca255a747b88ebc10.1487096041.git.jcody@redhat.com>
Subject: [Qemu-devel] [PATCH 1/1] qemu-iotests: redirect nbd server stdout
 to /dev/null
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, mreitz@redhat.com

Some iotests (e.g. 174) try to filter the output of _make_test_image by
piping the stdout.  Pipe the server stdout to /dev/null, so that filter
pipe does not need to wait until process completion.

Signed-off-by: Jeff Cody <jcody@redhat.com>
---
 tests/qemu-iotests/common.rc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/qemu-iotests/common.rc b/tests/qemu-iotests/common.rc
index 6c0fd4c..08065dc 100644
--- a/tests/qemu-iotests/common.rc
+++ b/tests/qemu-iotests/common.rc
@@ -172,7 +172,7 @@ _make_test_img()
 
     # Start an NBD server on the image file, which is what we'll be talking to
     if [ $IMGPROTO = "nbd" ]; then
-        eval "$QEMU_NBD -v -t -b 127.0.0.1 -p 10810 -f $IMGFMT  $TEST_IMG_FILE &"
+        eval "$QEMU_NBD -v -t -b 127.0.0.1 -p 10810 -f $IMGFMT  $TEST_IMG_FILE >/dev/null &"
         sleep 1 # FIXME: qemu-nbd needs to be listening before we continue
     fi
 }
-- 
2.9.3
