Received: from eggs.gnu.org ([2001:4830:134:3::10]:40597)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1cVxZv-0005ox-4J
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 04:39:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1cVxZn-0000hu-6V
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 04:39:51 -0500
From: Michael Tokarev <mjt@tls.msk.ru>
Date: Tue, 24 Jan 2017 12:39:05 +0300
Message-Id: <b26a6a65fd0b46a18a9d23ef3867b5e9d3a5469c.1485250702.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1485250702.git.mjt@msgid.tls.msk.ru>
References: <cover.1485250702.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1485250702.git.mjt@msgid.tls.msk.ru>
References: <cover.1485250702.git.mjt@msgid.tls.msk.ru>
Subject: [Qemu-devel] [PULL 01/31] doc: don't mention -memory, it is -m
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>, qemu-trivial@nongnu.org

Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 qemu-options.hx | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/qemu-options.hx b/qemu-options.hx
index 80df526..232f737 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -250,7 +250,7 @@ use is discouraged as it may be removed from future versions.
 ETEXI
 
 DEF("m", HAS_ARG, QEMU_OPTION_m,
-    "-m[emory] [size=]megs[,slots=n,maxmem=size]\n"
+    "-m [size=]megs[,slots=n,maxmem=size]\n"
     "                configure guest RAM\n"
     "                size: initial amount of guest memory\n"
     "                slots: number of hotplug slots (default: none)\n"
-- 
2.1.4
