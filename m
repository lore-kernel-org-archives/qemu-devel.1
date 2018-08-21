Received: from eggs.gnu.org ([2001:4830:134:3::10]:37234)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fs2hk-0008Fh-0M
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 05:12:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fs2hd-0000e9-6N
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 05:11:58 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55384 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fs2hc-0000cE-U2
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 05:11:53 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 21 Aug 2018 11:11:42 +0200
Message-Id: <20180821091148.32220-2-kraxel@redhat.com>
In-Reply-To: <20180821091148.32220-1-kraxel@redhat.com>
References: <20180821091148.32220-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 1/7] docs/usb2.txt: ehci has six ports
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, npes87184 <npes87184@gmail.com>

From: npes87184 <npes87184@gmail.com>

In commit 5cc194caeb019cf1dae7f74ccbdf0401a56c2ac6,
the number of ehci ports is corrected to six. Fix docs
related to it.

Signed-off-by: npes87184 <npes87184@gmail.com>
Message-id: 20180801122410.10343-1-npes87184@gmail.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 docs/usb2.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/docs/usb2.txt b/docs/usb2.txt
index f63c8d9465..172614d3a7 100644
--- a/docs/usb2.txt
+++ b/docs/usb2.txt
@@ -94,8 +94,8 @@ physical port addressing
 
 First you can (for all USB devices) specify the physical port where
 the device will show up in the guest.  This can be done using the
-"port" property.  UHCI has two root ports (1,2).  EHCI has four root
-ports (1-4), the emulated (1.1) USB hub has eight ports.
+"port" property.  UHCI has two root ports (1,2).  EHCI has six root
+ports (1-6), the emulated (1.1) USB hub has eight ports.
 
 Plugging a tablet into UHCI port 1 works like this:
 
-- 
2.9.3
