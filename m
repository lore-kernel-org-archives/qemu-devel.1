Received: from eggs.gnu.org ([2001:4830:134:3::10]:58504)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1e5RQp-000501-3H
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 03:09:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1e5RQl-0000MU-Qu
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 03:09:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49460)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1e5RQl-0000Ln-K4
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 03:09:19 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 96FED81DE9
	for <qemu-devel@nongnu.org>; Fri, 20 Oct 2017 07:09:18 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 20 Oct 2017 09:09:14 +0200
Message-Id: <20171020070914.7785-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH] ui: add qemu-keymap and shader to .gitignore
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 .gitignore | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/.gitignore b/.gitignore
index 620eec6b47..588769b250 100644
--- a/.gitignore
+++ b/.gitignore
@@ -14,6 +14,7 @@
 /trace/generated-tcg-tracers.h
 /ui/shader/texture-blit-frag.h
 /ui/shader/texture-blit-vert.h
+/ui/shader/texture-blit-flip-vert.h
 /ui/input-keymap-*.c
 *-timestamp
 /*-softmmu
@@ -45,6 +46,7 @@
 /qemu-io
 /qemu-ga
 /qemu-bridge-helper
+/qemu-keymap
 /qemu-monitor.texi
 /qemu-monitor-info.texi
 /qemu-version.h
-- 
2.9.3
