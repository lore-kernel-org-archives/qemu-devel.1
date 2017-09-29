Received: from eggs.gnu.org ([2001:4830:134:3::10]:53518)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <michael@fritscher.net>) id 1dxtFB-00061P-8a
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 07:14:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <michael@fritscher.net>) id 1dxtF7-0007me-Gc
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 07:14:09 -0400
Received: from mifritscher.de ([188.40.170.105]:32972
	helo=mail.mifritscher.vserverkompetenz.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <michael@fritscher.net>)
	id 1dxtF7-0007lo-A3
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 07:14:05 -0400
From: Michael Fritscher <michael@fritscher.net>
Date: Fri, 29 Sep 2017 13:13:16 +0200
Message-Id: <20170929111323.6308-12-michael@fritscher.net>
In-Reply-To: <20170929111323.6308-1-michael@fritscher.net>
References: <20170929111323.6308-1-michael@fritscher.net>
Subject: [Qemu-devel] [PATCH 11/18] Sete ctx->xops to null on Windows.
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
 hw/9pfs/9p-local.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
index c4feca27bd..fdc0a5bc76 100644
--- a/hw/9pfs/9p-local.c
+++ b/hw/9pfs/9p-local.c
@@ -1429,6 +1429,9 @@ static int local_init(FsContext *ctx)
     }
 #endif
 
+#ifdef _WIN32
+    ctx->xops = 0;
+#else
     if (ctx->export_flags & V9FS_SM_PASSTHROUGH) {
         ctx->xops = passthrough_xattr_ops;
     } else if (ctx->export_flags & V9FS_SM_MAPPED) {
@@ -1442,6 +1445,7 @@ static int local_init(FsContext *ctx)
          */
         ctx->xops = passthrough_xattr_ops;
     }
+#endif
     ctx->export_flags |= V9FS_PATHNAME_FSCONTEXT;
 
     ctx->private = data;
-- 
2.13.2.windows.1
