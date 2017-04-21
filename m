Received: from eggs.gnu.org ([2001:4830:134:3::10]:47828)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d1TVK-0000tW-IW
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 04:01:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d1TVJ-0000Yp-IJ
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 04:01:22 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 21 Apr 2017 10:01:02 +0200
Message-Id: <1492761662-5644-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH] qemu_iotests: Remove _readlink()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, qemu-devel@nongnu.org

It is unused.

Suggestetd-by: Fam Zheng <famz@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/common.config | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/tests/qemu-iotests/common.config b/tests/qemu-iotests/common.config
index 1222e43..66f4e0b 100644
--- a/tests/qemu-iotests/common.config
+++ b/tests/qemu-iotests/common.config
@@ -204,23 +204,5 @@ fi
 
 export SAMPLE_IMG_DIR
 
-_readlink()
-{
-    if [ $# -ne 1 ]; then
-        echo "Usage: _readlink filename" 1>&2
-        exit 1
-    fi
-
-    perl -e "\$in=\"$1\";" -e '
-    $lnk = readlink($in);
-    if ($lnk =~ m!^/.*!) {
-        print "$lnk\n";
-    }
-    else {
-        chomp($dir = `dirname $in`);
-        print "$dir/$lnk\n";
-    }'
-}
-
 # make sure this script returns success
 true
-- 
1.8.3.1
