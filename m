Received: from eggs.gnu.org ([2001:4830:134:3::10]:44378)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cRjnc-0000WQ-K1
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 13:08:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cRjnb-0005L8-LR
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 13:08:32 -0500
Received: from mout.kundenserver.de ([212.227.17.24]:61457)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1cRjnb-0005KK-BI
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 13:08:31 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Thu, 12 Jan 2017 19:08:21 +0100
Message-Id: <1484244501-20283-5-git-send-email-laurent@vivier.eu>
In-Reply-To: <1484244501-20283-1-git-send-email-laurent@vivier.eu>
References: <1484244501-20283-1-git-send-email-laurent@vivier.eu>
Subject: [Qemu-devel] [PULL 4/4] m68k: Remove PCI and USB from config file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <huth@tuxfamily.org>, Laurent Vivier <laurent@vivier.eu>

From: Thomas Huth <huth@tuxfamily.org>

None of the ColdFire boards that we currently support has a PCI or
USB bus (and AFAIK the upcoming q800 machine does not support PCI
and USB either), so we do not need these settings the config file.

Signed-off-by: Thomas Huth <huth@tuxfamily.org>
Message-Id: <20170106083956.53d08923@thl530>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
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
