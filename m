Received: from eggs.gnu.org ([2001:4830:134:3::10]:53869)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cgIiK-0002qd-CG
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 17:15:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cgIiH-0004Rx-6F
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 17:15:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41650)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cgIiH-0004Rd-0R
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 17:15:13 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 18E1480462
	for <qemu-devel@nongnu.org>; Tue, 21 Feb 2017 22:15:13 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 21 Feb 2017 23:14:51 +0100
Message-Id: <1487715299-21102-2-git-send-email-kraxel@redhat.com>
In-Reply-To: <1487715299-21102-1-git-send-email-kraxel@redhat.com>
References: <1487715299-21102-1-git-send-email-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH 1/9] sysemu: add defines for sparc & ppc
 graphics_*
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

Add defines for the sparc and ppc arch specific graphics defaults.
They return the graphic_* values these variables are non-zero, and
the default values otherwise.

After switching over ppc and sparc to use these we don't need the
arch-specific initialization for the graphic_* variables any more.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/sysemu/sysemu.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
index 576c7ce..9450788 100644
--- a/include/sysemu/sysemu.h
+++ b/include/sysemu/sysemu.h
@@ -142,9 +142,16 @@ typedef enum {
 extern int vga_interface_type;
 #define xenfb_enabled (vga_interface_type == VGA_XENFB)
 
+#define sparc_graphic_width  (graphic_width  ? graphic_width  : 1024)
+#define sparc_graphic_height (graphic_height ? graphic_height :  768)
+#define sparc_graphic_depth  (graphic_depth  ? graphic_depth  :    8)
+#define ppc_graphic_width    (graphic_width  ? graphic_width  :  800)
+#define ppc_graphic_height   (graphic_height ? graphic_height :  600)
+#define ppc_graphic_depth    (graphic_depth  ? graphic_depth  :   32)
 extern int graphic_width;
 extern int graphic_height;
 extern int graphic_depth;
+
 extern int display_opengl;
 extern const char *keyboard_layout;
 extern int win2k_install_hack;
-- 
1.8.3.1
