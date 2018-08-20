Received: from eggs.gnu.org ([2001:4830:134:3::10]:53007)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1frnyU-0000A4-As
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 13:28:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1frnyQ-0003O8-9Z
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 13:28:18 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46260 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1frnyM-0003L5-KA
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 13:28:12 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D28A040216F0
	for <qemu-devel@nongnu.org>; Mon, 20 Aug 2018 17:28:09 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
Date: Mon, 20 Aug 2018 19:28:03 +0200
Message-Id: <1534786083-26559-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH] hw/display/ramfb: Compile the ramfb code only
 when CONFIG_FW_CFG_DMA is set
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org

According to the ramfb_setup() function, the ramfb device needs fw_cfg
with DMA, so we should also only compile and link it into those targets
which support it, to avoid that the device shows up on systems where it
can not be used at all (e.g. s390x).

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/display/Makefile.objs | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/display/Makefile.objs b/hw/display/Makefile.objs
index fb8408c..a606fb7 100644
--- a/hw/display/Makefile.objs
+++ b/hw/display/Makefile.objs
@@ -1,5 +1,5 @@
-common-obj-y += ramfb.o
-common-obj-y += ramfb-standalone.o
+common-obj-$(CONFIG_FW_CFG_DMA) += ramfb.o
+common-obj-$(CONFIG_FW_CFG_DMA) += ramfb-standalone.o
 
 common-obj-$(CONFIG_ADS7846) += ads7846.o
 common-obj-$(CONFIG_VGA_CIRRUS) += cirrus_vga.o
-- 
1.8.3.1
