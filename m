Received: from eggs.gnu.org ([2001:4830:134:3::10]:47291)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1e6XhI-00076q-21
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 04:02:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1e6XhE-0006Uj-DP
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 04:02:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:23068)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1e6XhE-0006U8-7P
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 04:02:52 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 405563680A
	for <qemu-devel@nongnu.org>; Mon, 23 Oct 2017 08:02:51 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 23 Oct 2017 10:02:44 +0200
Message-Id: <20171023080245.31300-3-kraxel@redhat.com>
In-Reply-To: <20171023080245.31300-1-kraxel@redhat.com>
References: <20171023080245.31300-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 2/3] ui: add qemu-keymap and shader to .gitignore
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
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-id: 20171020070914.7785-1-kraxel@redhat.com
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
