Received: from eggs.gnu.org ([2001:4830:134:3::10]:59805)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1euLn0-000067-O6
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 12:26:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1euLmz-0006Cn-VY
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 12:26:42 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:47010)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1euLmz-0006B9-Od
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 12:26:41 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1euLmy-00079u-LQ
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 17:26:40 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  9 Mar 2018 17:26:22 +0000
Message-Id: <20180309172622.4277-26-peter.maydell@linaro.org>
In-Reply-To: <20180309172622.4277-1-peter.maydell@linaro.org>
References: <20180309172622.4277-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 25/25] MAINTAINERS: Add entries for SD (SDHCI,
 SDBus, SDCard)
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

After spending months studying all the different SD Specifications
from the SD Association, voluntarily add myself as maintainer
for the SD code.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20180309153654.13518-9-f4bug@amsat.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index f409f3b158..354a18ce49 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1100,6 +1100,14 @@ M: Peter Crosthwaite <crosthwaite.peter@gmail.com>
 S: Maintained
 F: hw/ssi/xilinx_*
 
+SD (Secure Card)
+M: Philippe Mathieu-Daudé <f4bug@amsat.org>
+S: Odd Fixes
+F: include/hw/sd/sd*
+F: hw/sd/core.c
+F: hw/sd/sd*
+F: tests/sd*
+
 USB
 M: Gerd Hoffmann <kraxel@redhat.com>
 S: Maintained
-- 
2.16.2
