Received: from eggs.gnu.org ([2001:4830:134:3::10]:50483)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <npes87184@gmail.com>) id 1fkqBE-00040Y-3d
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 08:24:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <npes87184@gmail.com>) id 1fkqBA-00012k-VS
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 08:24:40 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:38416)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <npes87184@gmail.com>) id 1fkqBA-00012Q-OS
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 08:24:36 -0400
Received: by mail-pf1-x444.google.com with SMTP id x17-v6so7787011pfh.5
	for <qemu-devel@nongnu.org>; Wed, 01 Aug 2018 05:24:36 -0700 (PDT)
From: npes87184 <npes87184@gmail.com>
Date: Wed,  1 Aug 2018 20:24:10 +0800
Message-Id: <20180801122410.10343-1-npes87184@gmail.com>
Subject: [Qemu-devel] [PATCH] docs/usb2.txt: ehci has six ports
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com, npes87184 <npes87184@gmail.com>

In commit 5cc194caeb019cf1dae7f74ccbdf0401a56c2ac6,
the number of ehci ports is corrected to six. Fix docs
related to it.

Signed-off-by: npes87184 <npes87184@gmail.com>
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
2.17.1
