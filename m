Received: from eggs.gnu.org ([2001:4830:134:3::10]:53448)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <michael@fritscher.net>) id 1dxtF8-0005y9-DO
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 07:14:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <michael@fritscher.net>) id 1dxtF4-0007kc-J2
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 07:14:06 -0400
Received: from mifritscher.de ([188.40.170.105]:32932
	helo=mail.mifritscher.vserverkompetenz.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <michael@fritscher.net>)
	id 1dxtF4-0007kK-Ce
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 07:14:02 -0400
From: Michael Fritscher <michael@fritscher.net>
Date: Fri, 29 Sep 2017 13:13:09 +0200
Message-Id: <20170929111323.6308-5-michael@fritscher.net>
In-Reply-To: <20170929111323.6308-1-michael@fritscher.net>
References: <20170929111323.6308-1-michael@fritscher.net>
Subject: [Qemu-devel] [PATCH 04/18] Don't include sys/resource.h on Windows.
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: gkurz@linux.vnet.ibm.com, sw@weilnetz.de, aneesh.kumar@linux.vnet.ibm.com, mst@redhat.com, qemu-devel@nongnu.org
Cc: Michael Fritscher <michael@fritscher.net>
List-ID: <qemu-devel.nongnu.org>

Signed-off-by: Michael Fritscher <michael@fritscher.net>
---
 hw/9pfs/9p.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/9pfs/9p.h b/hw/9pfs/9p.h
index d1cfeaf10e..c2dd782620 100644
--- a/hw/9pfs/9p.h
+++ b/hw/9pfs/9p.h
@@ -3,7 +3,9 @@
 
 #include <dirent.h>
 #include <utime.h>
-#include <sys/resource.h>
+#ifndef _WIN32
+# include <sys/resource.h>
+#endif
 #include "fsdev/file-op-9p.h"
 #include "fsdev/9p-iov-marshal.h"
 #include "qemu/thread.h"
-- 
2.13.2.windows.1
