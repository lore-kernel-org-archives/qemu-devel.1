Received: from eggs.gnu.org ([2001:4830:134:3::10]:33627)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eHgx3-0004r7-9A
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 21:09:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eHgx0-0001R2-1r
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 21:09:17 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Thu, 23 Nov 2017 03:08:20 +0100
Message-Id: <20171123020832.8165-6-mreitz@redhat.com>
In-Reply-To: <20171123020832.8165-1-mreitz@redhat.com>
References: <20171123020832.8165-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH 05/17] iotests: Fix _img_info for backslashes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>, Fam Zheng <famz@redhat.com>

read without -r eats backslashes.

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
