Received: from eggs.gnu.org ([2001:4830:134:3::10]:53556)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <michael@fritscher.net>) id 1dxtFE-00064p-FK
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 07:14:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <michael@fritscher.net>) id 1dxtFC-0007ps-Mi
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 07:14:12 -0400
Received: from mifritscher.de ([188.40.170.105]:33046
	helo=mail.mifritscher.vserverkompetenz.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <michael@fritscher.net>)
	id 1dxtFC-0007pa-Fj
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 07:14:10 -0400
From: Michael Fritscher <michael@fritscher.net>
Date: Fri, 29 Sep 2017 13:13:15 +0200
Message-Id: <20170929111323.6308-11-michael@fritscher.net>
In-Reply-To: <20170929111323.6308-1-michael@fritscher.net>
References: <20170929111323.6308-1-michael@fritscher.net>
Subject: [Qemu-devel] [PATCH 10/18] dirent has no d_off on Windows.
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
 hw/9pfs/9p-synth.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/9pfs/9p-synth.c b/hw/9pfs/9p-synth.c
index e1bf0438b8..7b8cc3b6e9 100644
--- a/hw/9pfs/9p-synth.c
+++ b/hw/9pfs/9p-synth.c
@@ -222,7 +222,9 @@ static void synth_direntry(V9fsSynthNode *node,
 {
     strcpy(entry->d_name, node->name);
     entry->d_ino = node->attr->inode;
+#ifndef _WIN32
     entry->d_off = off + 1;
+#endif
 }
 
 static struct dirent *synth_get_dentry(V9fsSynthNode *dir,
-- 
2.13.2.windows.1
