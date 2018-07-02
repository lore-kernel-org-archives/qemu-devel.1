Received: from eggs.gnu.org ([2001:4830:134:3::10]:59188)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fa0yC-0004al-M3
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 11:42:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fa0yB-0006G2-Ts
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 11:42:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39664)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fa0yB-0006Fi-NW
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 11:42:27 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EAEDE30E6862
	for <qemu-devel@nongnu.org>; Mon,  2 Jul 2018 15:42:26 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon,  2 Jul 2018 17:42:18 +0200
Message-Id: <20180702154222.3130-4-kraxel@redhat.com>
In-Reply-To: <20180702154222.3130-1-kraxel@redhat.com>
References: <20180702154222.3130-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 3/7] seabios: enable ide dma
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

QNX reportedly requires this to boot.
Should also speed up booting other guests.

Note: Upstream seabios defaults this to 'n' to due to known problems
on physical hardware (qemu not affected), and wouldn't flip the default
to 'y'.  So we adjust our local build config accordingly.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 roms/config.seabios-128k | 1 +
 roms/config.seabios-256k | 1 +
 2 files changed, 2 insertions(+)

diff --git a/roms/config.seabios-128k b/roms/config.seabios-128k
index 486ef0e132..35b5a07d8f 100644
--- a/roms/config.seabios-128k
+++ b/roms/config.seabios-128k
@@ -2,6 +2,7 @@
 # need to turn off features (xhci,uas) to make it fit into 128k
 CONFIG_QEMU=y
 CONFIG_ROM_SIZE=128
+CONFIG_ATA_DMA=y
 CONFIG_BOOTSPLASH=n
 CONFIG_XEN=n
 CONFIG_USB_OHCI=n
diff --git a/roms/config.seabios-256k b/roms/config.seabios-256k
index 65e5015c2f..b14b614fcc 100644
--- a/roms/config.seabios-256k
+++ b/roms/config.seabios-256k
@@ -1,3 +1,4 @@
 # for qemu machine types 2.0 + newer
 CONFIG_QEMU=y
 CONFIG_ROM_SIZE=256
+CONFIG_ATA_DMA=y
-- 
2.9.3
