Received: from eggs.gnu.org ([2001:4830:134:3::10]:55523)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d4Cao-0001dA-1M
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 16:34:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d4Can-0001D1-AN
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 16:34:18 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 28 Apr 2017 22:33:20 +0200
Message-Id: <1493411622-5343-13-git-send-email-kwolf@redhat.com>
In-Reply-To: <1493411622-5343-1-git-send-email-kwolf@redhat.com>
References: <1493411622-5343-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 12/34] qemu_iotests: Remove _readlink()
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

It is unused.

Suggested-by: Fam Zheng <famz@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Fam Zheng <famz@redhat.com>
---
 tests/qemu-iotests/common.config | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/tests/qemu-iotests/common.config b/tests/qemu-iotests/common.config
index 5ee00a1..d1b45f5 100644
--- a/tests/qemu-iotests/common.config
+++ b/tests/qemu-iotests/common.config
@@ -217,23 +217,5 @@ fi
 
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
