Received: from eggs.gnu.org ([2001:4830:134:3::10]:54535)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1d3qNf-0005PR-Gr
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 16:51:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1d3qNc-0004Hs-GL
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 16:51:15 -0400
From: John Snow <jsnow@redhat.com>
Date: Thu, 27 Apr 2017 16:50:59 -0400
Message-Id: <20170427205100.9505-2-jsnow@redhat.com>
In-Reply-To: <20170427205100.9505-1-jsnow@redhat.com>
References: <20170427205100.9505-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH 1/2] iotests: clarify help text
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, kwolf@redhat.com, eblake@redhat.com, mreitz@redhat.com, John Snow <jsnow@redhat.com>

Split the help text to highlight the groups of options
a little better, carving out a clear "format" and
"protocols" section.

Signed-off-by: John Snow <jsnow@redhat.com>
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
2.9.3
