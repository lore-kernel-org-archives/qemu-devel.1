Received: from eggs.gnu.org ([2001:4830:134:3::10]:53385)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <michael@fritscher.net>) id 1dxtF5-0005vp-Og
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 07:14:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <michael@fritscher.net>) id 1dxtF2-0007jg-VH
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 07:14:03 -0400
Received: from mifritscher.de ([188.40.170.105]:32910
	helo=mail.mifritscher.vserverkompetenz.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <michael@fritscher.net>)
	id 1dxtF2-0007ix-PF
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 07:14:00 -0400
From: Michael Fritscher <michael@fritscher.net>
Date: Fri, 29 Sep 2017 13:13:08 +0200
Message-Id: <20170929111323.6308-4-michael@fritscher.net>
In-Reply-To: <20170929111323.6308-1-michael@fritscher.net>
References: <20170929111323.6308-1-michael@fritscher.net>
Subject: [Qemu-devel] [PATCH 03/18] Disable the proxy fsdev under Windows.
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
 fsdev/qemu-fsdev.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fsdev/qemu-fsdev.c b/fsdev/qemu-fsdev.c
index 266e442b87..9f6d33365d 100644
--- a/fsdev/qemu-fsdev.c
+++ b/fsdev/qemu-fsdev.c
@@ -26,7 +26,9 @@ static FsDriverTable FsDrivers[] = {
     { .name = "handle", .ops = &handle_ops},
 #endif
     { .name = "synth", .ops = &synth_ops},
+#ifndef WIN32
     { .name = "proxy", .ops = &proxy_ops},
+#endif
 };
 
 int qemu_fsdev_add(QemuOpts *opts)
-- 
2.13.2.windows.1
