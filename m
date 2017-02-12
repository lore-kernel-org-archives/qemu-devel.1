Received: from eggs.gnu.org ([2001:4830:134:3::10]:46923)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ccj6H-00051Z-NU
	for qemu-devel@nongnu.org; Sat, 11 Feb 2017 20:37:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ccj6G-00075U-Pk
	for qemu-devel@nongnu.org; Sat, 11 Feb 2017 20:37:13 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Sun, 12 Feb 2017 02:36:47 +0100
Message-Id: <20170212013704.6378-2-mreitz@redhat.com>
In-Reply-To: <20170212013704.6378-1-mreitz@redhat.com>
References: <20170212013440.5919-1-mreitz@redhat.com>
	<20170212013704.6378-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PULL 04/21] iotests: Fix reference output for 059
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

From: Fam Zheng <famz@redhat.com>

It was broken by efaa7c4eeb7 when it dropped the device name "image"
from BB API.  Now this error message text is updated again, sync it up.

Signed-off-by: Fam Zheng <famz@redhat.com>
Message-id: 20170119130759.28319-3-famz@redhat.com
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/059.out | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/qemu-iotests/059.out b/tests/qemu-iotests/059.out
index 678adb4379..19bd50de1e 100644
--- a/tests/qemu-iotests/059.out
+++ b/tests/qemu-iotests/059.out
@@ -2361,5 +2361,5 @@ Offset          Length          Mapped to       File
 0x140000000     0x10000         0x50000         TEST_DIR/iotest-version3-s003.vmdk
 
 === Testing afl image with a very large capacity ===
-qemu-img: Can't get size of device 'image': File too large
+qemu-img: Can't get image size 'TEST_DIR/afl9.IMGFMT': File too large
 *** done
-- 
2.11.0
