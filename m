Received: from eggs.gnu.org ([2001:4830:134:3::10]:53269)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fLAV5-0005vl-Rq
	for qemu-devel@nongnu.org; Tue, 22 May 2018 12:51:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fLAV3-0007qj-DE
	for qemu-devel@nongnu.org; Tue, 22 May 2018 12:51:03 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51766 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fLAV3-0007qP-9M
	for qemu-devel@nongnu.org; Tue, 22 May 2018 12:51:01 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C00CB6F59E
	for <qemu-devel@nongnu.org>; Tue, 22 May 2018 16:51:00 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 22 May 2018 18:50:58 +0200
Message-Id: <20180522165058.15404-7-kraxel@redhat.com>
In-Reply-To: <20180522165058.15404-1-kraxel@redhat.com>
References: <20180522165058.15404-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH v2 6/6] MAINTAINERS: add vga entries
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

Add entries for standard vga, virtio-gpu and cirrus.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 MAINTAINERS | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e187b1f18f..2af3ad5172 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1314,6 +1314,27 @@ S: Maintained
 F: include/hw/misc/unimp.h
 F: hw/misc/unimp.c
 
+Standard VGA
+M: Gerd Hoffmann <kraxel@redhat.com>
+S: Maintained
+F: hw/display/vga*
+F: hw/display/bochs-display.c
+F: include/hw/display/vga.h
+F: include/hw/display/bochs-vbe.h
+
+virtio-gpu
+M: Gerd Hoffmann <kraxel@redhat.com>
+S: Maintained
+F: hw/display/virtio-gpu*
+F: hw/display/virtio-vga.c
+F: include/hw/virtio/virtio-gpu.h
+
+Cirrus VGA
+M: Gerd Hoffmann <kraxel@redhat.com>
+S: Odd Fixes
+W: https://www.kraxel.org/blog/2014/10/qemu-using-cirrus-considered-harmful/
+F: hw/display/cirrus*
+
 Subsystems
 ----------
 Audio
-- 
2.9.3
