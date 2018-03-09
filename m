Received: from eggs.gnu.org ([2001:4830:134:3::10]:50409)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1euK51-0006Rw-Ep
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 10:37:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1euK50-0008GU-2I
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 10:37:11 -0500
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:35281)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1euK4z-0008Fv-Sh
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 10:37:10 -0500
Received: by mail-wr0-x244.google.com with SMTP id a27so1744586wra.2
	for <qemu-devel@nongnu.org>; Fri, 09 Mar 2018 07:37:09 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri,  9 Mar 2018 16:36:54 +0100
Message-Id: <20180309153654.13518-9-f4bug@amsat.org>
In-Reply-To: <20180309153654.13518-1-f4bug@amsat.org>
References: <20180309153654.13518-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 8/8] MAINTAINERS: Add entries for SD (SDHCI,
 SDBus, SDCard)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair@alistair23.me>, Peter Maydell <peter.maydell@linaro.org>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org

After spending months studying all the different SD Specifications
from the SD Association, voluntarily add myself as maintainer
for the SD code.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index b7c4130388..0446724642 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1089,6 +1089,14 @@ M: Peter Crosthwaite <crosthwaite.peter@gmail.com>
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
