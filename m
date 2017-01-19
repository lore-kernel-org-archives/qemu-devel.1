Received: from eggs.gnu.org ([2001:4830:134:3::10]:57194)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cUCRv-0007ky-Jc
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 08:08:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cUCRs-0006MG-Ca
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 08:08:19 -0500
From: Fam Zheng <famz@redhat.com>
Date: Thu, 19 Jan 2017 21:07:59 +0800
Message-Id: <20170119130759.28319-3-famz@redhat.com>
In-Reply-To: <20170119130759.28319-1-famz@redhat.com>
References: <20170119130759.28319-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH 2/2] iotests: Fix reference output for 059
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

It was broken by efaa7c4eeb7 when it dropped the device name "image"
from BB API.  Now this error message text is updated again, sync it up.

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 tests/qemu-iotests/059.out | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/qemu-iotests/059.out b/tests/qemu-iotests/059.out
index 678adb4..19bd50d 100644
--- a/tests/qemu-iotests/059.out
+++ b/tests/qemu-iotests/059.out
@@ -2361,5 +2361,5 @@ Offset          Length          Mapped to       File
 0x140000000     0x10000         0x50000         TEST_DIR/iotest-version3-s003.vmdk
 
 === Testing afl image with a very large capacity ===
-qemu-img: Can't get size of device 'image': File too large
+qemu-img: Can't get image size 'TEST_DIR/afl9.IMGFMT': File too large
 *** done
-- 
2.9.3
