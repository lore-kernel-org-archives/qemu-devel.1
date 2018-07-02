Received: from eggs.gnu.org ([2001:4830:134:3::10]:59233)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fa0yE-0004cV-Hb
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 11:42:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fa0yD-0006HZ-TB
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 11:42:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45400)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fa0yD-0006Gz-N6
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 11:42:29 -0400
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com
	[10.5.11.24])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E876D308FBA2
	for <qemu-devel@nongnu.org>; Mon,  2 Jul 2018 15:42:28 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon,  2 Jul 2018 17:42:22 +0200
Message-Id: <20180702154222.3130-8-kraxel@redhat.com>
In-Reply-To: <20180702154222.3130-1-kraxel@redhat.com>
References: <20180702154222.3130-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 7/7] ramfb: enable vgabios
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

Add vgabios binary to fw_cfg vgaroms.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/display/ramfb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/display/ramfb.c b/hw/display/ramfb.c
index 30f5c8da20..25c8ad7c25 100644
--- a/hw/display/ramfb.c
+++ b/hw/display/ramfb.c
@@ -88,6 +88,7 @@ RAMFBState *ramfb_setup(Error **errp)
 
     s = g_new0(RAMFBState, 1);
 
+    rom_add_vga("vgabios-ramfb.bin");
     fw_cfg_add_file_callback(fw_cfg, "etc/ramfb",
                              NULL, ramfb_fw_cfg_write, s,
                              &s->cfg, sizeof(s->cfg), false);
-- 
2.9.3
