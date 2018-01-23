Received: from eggs.gnu.org ([2001:4830:134:3::10]:57843)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1edz9t-0003cY-IV
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 09:02:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1edz9o-0005uI-3I
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 09:02:41 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 23 Jan 2018 15:01:47 +0100
Message-Id: <20180123140201.31163-16-kwolf@redhat.com>
In-Reply-To: <20180123140201.31163-1-kwolf@redhat.com>
References: <20180123140201.31163-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 15/29] iotests: Fix _img_info for backslashes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

From: Max Reitz <mreitz@redhat.com>

read without -r eats backslashes.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Message-id: 20171123020832.8165-6-mreitz@redhat.com
Reviewed-by: Fam Zheng <famz@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/common.rc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/qemu-iotests/common.rc b/tests/qemu-iotests/common.rc
index dbae7d74ba..6fa0495e10 100644
--- a/tests/qemu-iotests/common.rc
+++ b/tests/qemu-iotests/common.rc
@@ -338,7 +338,7 @@ _img_info()
             -e "s#$IMGFMT#IMGFMT#g" \
             -e "/^disk size:/ D" \
             -e "/actual-size/ D" | \
-        while IFS='' read line; do
+        while IFS='' read -r line; do
             if [[ $format_specific == 1 ]]; then
                 discard=0
             elif [[ $line == "Format specific information:" ]]; then
-- 
2.13.6
