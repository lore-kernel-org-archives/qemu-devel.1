Received: from eggs.gnu.org ([2001:4830:134:3::10]:51891)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fXrHF-00024V-Fx
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 12:57:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fXrHE-0007Ec-Jp
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 12:57:13 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:43034)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fXrHE-0007CU-D8
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 12:57:12 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fXrH5-0008U0-0B
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 17:57:03 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 26 Jun 2018 17:56:30 +0100
Message-Id: <20180626165658.31394-5-peter.maydell@linaro.org>
In-Reply-To: <20180626165658.31394-1-peter.maydell@linaro.org>
References: <20180626165658.31394-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 04/32] MAINTAINERS: Adopt the Gumstix
 computers-on-module machines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

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
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-id: 20180606144706.29732-1-f4bug@amsat.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 MAINTAINERS | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2874ddce609..1676b1ba712 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -501,9 +501,10 @@ F: include/hw/arm/digic.h
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
