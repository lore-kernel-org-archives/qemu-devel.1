Received: from eggs.gnu.org ([2001:4830:134:3::10]:55587)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fQZiY-0004m9-Gk
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 10:47:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fQZiV-00018j-Cr
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 10:47:18 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed,  6 Jun 2018 11:47:06 -0300
Message-Id: <20180606144706.29732-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] MAINTAINERS: Adopt the Gumstix
 computers-on-module machines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-arm@nongnu.org

These COMs are hard to find, and the companie dropped the support
few years ago.

Per the "Gumstix Product Changes, Known Issues, and EOL" pdf:

- Phasing out: PXA270-based Verdex product line
  September 2012

- Phasing out: PXA255-based Basix & Connex
  September 2009

However there are still booting SD card image availables, very
convenient to stress test the QEMU SD card implementation.
Therefore I volunteer to keep an eye on this file, while it
is useful for testing.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 MAINTAINERS | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 41cd3736a9..1825deb762 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -491,9 +491,10 @@ F: include/hw/arm/digic.h
 F: hw/*/digic*
 
 Gumstix
+M: Philippe Mathieu-Daudé <f4bug@amsat.org>
 L: qemu-devel@nongnu.org
 L: qemu-arm@nongnu.org
-S: Orphan
+S: Odd Fixes
 F: hw/arm/gumstix.c
 
 i.MX31
-- 
2.17.1
