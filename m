Received: from eggs.gnu.org ([2001:4830:134:3::10]:56153)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d4CbV-0002Hg-Li
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 16:35:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d4CbU-0001ck-W4
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 16:35:01 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 28 Apr 2017 22:33:40 +0200
Message-Id: <1493411622-5343-33-git-send-email-kwolf@redhat.com>
In-Reply-To: <1493411622-5343-1-git-send-email-kwolf@redhat.com>
References: <1493411622-5343-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 32/34] iotests: clarify help text
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

From: John Snow <jsnow@redhat.com>

Split the help text to highlight the groups of options
a little better, carving out a clear "format" and
"protocols" section.

Signed-off-by: John Snow <jsnow@redhat.com>
Message-id: 20170427205100.9505-2-jsnow@redhat.com
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/common | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tests/qemu-iotests/common b/tests/qemu-iotests/common
index 9c6f972..fa8e69e 100644
--- a/tests/qemu-iotests/common
+++ b/tests/qemu-iotests/common
@@ -138,7 +138,7 @@ common options
     -v                  verbose
     -d                  debug
 
-check options
+image format options
     -raw                test raw (default)
     -bochs              test bochs
     -cloop              test cloop
@@ -150,14 +150,18 @@ check options
     -vpc                test vpc
     -vhdx               test vhdx
     -vmdk               test vmdk
+    -luks               test luks
+
+image protocol options
     -file               test file (default)
     -rbd                test rbd
     -sheepdog           test sheepdog
     -nbd                test nbd
     -ssh                test ssh
     -nfs                test nfs
-    -luks               test luks
     -vxhs               test vxhs
+
+other options
     -xdiff              graphical mode diff
     -nocache            use O_DIRECT on backing file
     -misalign           misalign memory allocations
-- 
1.8.3.1
