Received: from eggs.gnu.org ([2001:4830:134:3::10]:34410)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <th.huth@gmail.com>) id 1cPP89-0002xB-G2
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 02:40:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <th.huth@gmail.com>) id 1cPP86-0003oO-DM
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 02:40:05 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35074)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <th.huth@gmail.com>) id 1cPP86-0003oB-6v
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 02:40:02 -0500
Received: by mail-wm0-f66.google.com with SMTP id l2so2957714wml.2
	for <qemu-devel@nongnu.org>; Thu, 05 Jan 2017 23:40:00 -0800 (PST)
Date: Fri, 6 Jan 2017 08:39:56 +0100
From: Thomas Huth <huth@tuxfamily.org>
Message-ID: <20170106083956.53d08923@thl530>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH] m68k: Remove PCI and USB from config file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, QEMU Developers <qemu-devel@nongnu.org>

None of the ColdFire boards that we currently support has a PCI or
USB bus (and AFAIK the upcoming q800 machine does not support PCI
and USB either), so we do not need these settings the config file.

Signed-off-by: Thomas Huth <huth@tuxfamily.org>
---
 default-configs/m68k-softmmu.mak | 2 --
 1 file changed, 2 deletions(-)

diff --git a/default-configs/m68k-softmmu.mak b/default-configs/m68k-softmmu.mak
index d9552df..60f7cdf 100644
--- a/default-configs/m68k-softmmu.mak
+++ b/default-configs/m68k-softmmu.mak
@@ -1,6 +1,4 @@
 # Default configuration for m68k-softmmu
 
-include pci.mak
-include usb.mak
 CONFIG_COLDFIRE=y
 CONFIG_PTIMER=y
-- 
2.7.4
