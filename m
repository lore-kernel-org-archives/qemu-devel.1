Received: from eggs.gnu.org ([2001:4830:134:3::10]:53544)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <michael@fritscher.net>) id 1dxtFD-00063z-O1
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 07:14:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <michael@fritscher.net>) id 1dxtF8-0007n9-3F
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 07:14:11 -0400
Received: from mifritscher.de ([188.40.170.105]:32990
	helo=mail.mifritscher.vserverkompetenz.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <michael@fritscher.net>)
	id 1dxtF7-0007mO-Sc
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 07:14:06 -0400
From: Michael Fritscher <michael@fritscher.net>
Date: Fri, 29 Sep 2017 13:13:17 +0200
Message-Id: <20170929111323.6308-13-michael@fritscher.net>
In-Reply-To: <20170929111323.6308-1-michael@fritscher.net>
References: <20170929111323.6308-1-michael@fritscher.net>
Subject: [Qemu-devel] [PATCH 12/18] Buildfix in 9p-util.c.
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
 hw/9pfs/9p-util.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/9pfs/9p-util.c b/hw/9pfs/9p-util.c
index f709c27a1f..3330b59ef2 100644
--- a/hw/9pfs/9p-util.c
+++ b/hw/9pfs/9p-util.c
@@ -11,7 +11,9 @@
  */
 
 #include "qemu/osdep.h"
+#ifndef _WIN32
 #include "qemu/xattr.h"
+#endif
 #include "9p-util.h"
 
 ssize_t fgetxattrat_nofollow(int dirfd, const char *filename, const char *name,
-- 
2.13.2.windows.1
