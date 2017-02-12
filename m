Received: from eggs.gnu.org ([2001:4830:134:3::10]:34745)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <th.huth@gmail.com>) id 1cd2yp-00031V-Lx
	for qemu-devel@nongnu.org; Sun, 12 Feb 2017 17:50:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <th.huth@gmail.com>) id 1cd2ym-00030f-Bk
	for qemu-devel@nongnu.org; Sun, 12 Feb 2017 17:50:51 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35071)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <th.huth@gmail.com>) id 1cd2ym-00030A-5S
	for qemu-devel@nongnu.org; Sun, 12 Feb 2017 17:50:48 -0500
Received: by mail-wm0-f67.google.com with SMTP id u63so16382589wmu.2
	for <qemu-devel@nongnu.org>; Sun, 12 Feb 2017 14:50:46 -0800 (PST)
From: Thomas Huth <huth@tuxfamily.org>
Date: Sun, 12 Feb 2017 23:50:35 +0100
Message-Id: <1486939835-3452-3-git-send-email-huth@tuxfamily.org>
In-Reply-To: <1486939835-3452-1-git-send-email-huth@tuxfamily.org>
References: <1486939835-3452-1-git-send-email-huth@tuxfamily.org>
Subject: [Qemu-devel] [PATCH 2/2] MAINTAINERS: Add odd fixer the ColdFire
 boards
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>

I did some work with real ColdFire boards in the past, and after
QOMifying most of the ColdFire devices recently, too, I feel confident
that I could at least take care of odd fixes for these boards.

Signed-off-by: Thomas Huth <huth@tuxfamily.org>
---
 MAINTAINERS | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7afbada..4fb2ed0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -561,7 +561,8 @@ F: hw/lm32/milkymist.c
 M68K Machines
 -------------
 an5206
-S: Orphan
+M: Thomas Huth <huth@tuxfamily.org>
+S: Odd Fixes
 F: hw/m68k/an5206.c
 F: hw/m68k/mcf5206.c
 
@@ -570,11 +571,13 @@ S: Orphan
 F: hw/m68k/dummy_m68k.c
 
 mcf5208
-S: Orphan
+M: Thomas Huth <huth@tuxfamily.org>
+S: Odd Fixes
 F: hw/m68k/mcf5208.c
 F: hw/m68k/mcf_intc.c
 F: hw/char/mcf_uart.c
 F: hw/net/mcf_fec.c
+F: include/hw/m68k/mcf*.h
 
 MicroBlaze Machines
 -------------------
-- 
2.7.4
