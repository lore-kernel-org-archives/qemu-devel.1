Received: from eggs.gnu.org ([2001:4830:134:3::10]:54205)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <th.huth@gmail.com>) id 1cfEk9-0001sE-77
	for qemu-devel@nongnu.org; Sat, 18 Feb 2017 18:48:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <th.huth@gmail.com>) id 1cfEk6-0007CY-E1
	for qemu-devel@nongnu.org; Sat, 18 Feb 2017 18:48:45 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36378)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <th.huth@gmail.com>) id 1cfEk6-0007CK-7s
	for qemu-devel@nongnu.org; Sat, 18 Feb 2017 18:48:42 -0500
Received: by mail-wm0-f67.google.com with SMTP id r18so8429740wmd.3
	for <qemu-devel@nongnu.org>; Sat, 18 Feb 2017 15:48:42 -0800 (PST)
From: Thomas Huth <huth@tuxfamily.org>
Date: Sun, 19 Feb 2017 00:48:33 +0100
Message-Id: <1487461713-23092-4-git-send-email-huth@tuxfamily.org>
In-Reply-To: <1487461713-23092-1-git-send-email-huth@tuxfamily.org>
References: <1487461713-23092-1-git-send-email-huth@tuxfamily.org>
Subject: [Qemu-devel] [PULL 3/3] MAINTAINERS: Add odd fixer for the ColdFire
 boards
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>

I did some work with real ColdFire boards in the past, and after
QOMifying most of the ColdFire devices recently, I feel confident
that I could at least take care of odd fixes for these boards.

Signed-off-by: Thomas Huth <huth@tuxfamily.org>
---
 MAINTAINERS | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3efe7c5..4714df8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -561,16 +561,19 @@ F: hw/lm32/milkymist.c
 M68K Machines
 -------------
 an5206
-S: Orphan
+M: Thomas Huth <huth@tuxfamily.org>
+S: Odd Fixes
 F: hw/m68k/an5206.c
 F: hw/m68k/mcf5206.c
 
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
