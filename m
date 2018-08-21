Received: from eggs.gnu.org ([2001:4830:134:3::10]:51212)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fs1qA-0000mV-Fy
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 04:16:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fs1q7-0001Pk-Tz
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 04:16:38 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57414 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fs1q7-0001PM-P1
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 04:16:35 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 75D0C804BAAD
	for <qemu-devel@nongnu.org>; Tue, 21 Aug 2018 08:16:35 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 21 Aug 2018 10:16:28 +0200
Message-Id: <20180821081631.19160-2-kraxel@redhat.com>
In-Reply-To: <20180821081631.19160-1-kraxel@redhat.com>
References: <20180821081631.19160-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 1/4] hw/display/ramfb: Compile the ramfb code
 only when CONFIG_FW_CFG_DMA is set
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Thomas Huth <thuth@redhat.com>

From: Thomas Huth <thuth@redhat.com>

According to the ramfb_setup() function, the ramfb device needs fw_cfg
with DMA, so we should also only compile and link it into those targets
which support it, to avoid that the device shows up on systems where it
can not be used at all (e.g. s390x).

Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-id: 1534786083-26559-1-git-send-email-thuth@redhat.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/display/Makefile.objs | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/display/Makefile.objs b/hw/display/Makefile.objs
index fb8408c6d0..a606fb7404 100644
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
2.9.3
