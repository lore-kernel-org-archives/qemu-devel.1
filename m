Received: from eggs.gnu.org ([2001:4830:134:3::10]:50613)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fM8tT-0007nI-DA
	for qemu-devel@nongnu.org; Fri, 25 May 2018 05:20:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fM8tP-0007MY-AC
	for qemu-devel@nongnu.org; Fri, 25 May 2018 05:20:15 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40982 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fM8tP-0007Ls-6r
	for qemu-devel@nongnu.org; Fri, 25 May 2018 05:20:11 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D2129C12A8
	for <qemu-devel@nongnu.org>; Fri, 25 May 2018 09:20:10 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 25 May 2018 11:20:04 +0200
Message-Id: <20180525092004.13241-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH] usb: update docs
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

xhci is rock solid meanwhile.  So move it up in the docs and feature it
as prefered usb host adapter, instead of the old shy version saying "you
might want try ...".

Also a minor text update for the companion controller setup.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 docs/usb2.txt | 44 +++++++++++++++++++++++++-------------------
 1 file changed, 25 insertions(+), 19 deletions(-)

diff --git a/docs/usb2.txt b/docs/usb2.txt
index 09df45b5b1..1b0e62d187 100644
--- a/docs/usb2.txt
+++ b/docs/usb2.txt
@@ -1,6 +1,26 @@
 
-USB 2.0 Quick Start
-===================
+USB Quick Start
+===============
+
+xhci controller support
+-----------------------
+
+Qemu has xhci host adapter support.  The xhci hardware design is much
+more virtualization-friendly when compared to ehci and uhci, thus xhci
+emulation uses less resources (especially cpu).  So if your guest
+supports xhci (which should be the case for any operating system
+released in recent years) I recommend using it:
+
+    qemu -device qemu-xhci
+
+xhci supports USB 1.1, USB 2.0 and USB 3.0 devices, so this is the
+only controller you need.  With only a single usb controller (and
+therefore only a single usb bus) being present in the system there is
+no need to use the bus= parameter when adding usb devices.
+
+
+ehci controller support
+-----------------------
 
 The QEMU EHCI Adapter can be used with and without companion
 controllers.  See below for the companion controller mode.
@@ -47,29 +67,15 @@ specifies the first port the controller should attach to, which is
 needed as usually one ehci controller with six ports has three uhci
 companion controllers with two ports each.
 
-There is a config file in docs which will do all this for you, just
-try ...
+Result is a single usb bus which supports both USB 1.1 and USB 2.0
+devices.  There is a config file in docs which will do all this for
+you, just try ...
 
     qemu -readconfig docs/config/ich9-ehci-uhci.cfg
 
 ... then use "bus=ehci.0" to assign your usb devices to that bus.
 
 
-xhci controller support
------------------------
-
-There is also xhci host controller support available.  It got a lot
-less testing than ehci and there are a bunch of known limitations, so
-ehci may work better for you.  On the other hand the xhci hardware
-design is much more virtualization-friendly, thus xhci emulation uses
-less resources (especially cpu).  If you want to give xhci a try
-use this to add the host controller ...
-
-    qemu -device nec-usb-xhci,id=xhci
-
-... then use "bus=xhci.0" when assigning usb devices.
-
-
 More USB tips & tricks
 ======================
 
-- 
2.9.3
