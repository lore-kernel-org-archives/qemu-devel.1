Received: from eggs.gnu.org ([2001:4830:134:3::10]:56615)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sundeep.lkml@gmail.com>) id 1eE7ic-0004Jt-TE
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 00:55:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sundeep.lkml@gmail.com>) id 1eE7iY-0003gn-HZ
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 00:55:38 -0500
From: Subbaraya Sundeep <sundeep.lkml@gmail.com>
Date: Mon, 13 Nov 2017 11:25:20 +0530
Message-Id: <1510552520-3566-1-git-send-email-sundeep.lkml@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [Qemu devel PATCH v2] MAINTAINERS: Add entries for
 Smartfusion2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: peter.maydell@linaro.org, alistair23@gmail.com, f4bug@amsat.org, Subbaraya Sundeep <sundeep.lkml@gmail.com>

Voluntarily add myself as maintainer for Smartfusion2

Signed-off-by: Subbaraya Sundeep <sundeep.lkml@gmail.com>
Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
v2:
	reframed commit message as per Alistair's comment.
	Renamed MSF2 SoC -> SmartFusion2
			MSF2 SOM -> Emcraft M2S-FG484
		as per Philippe's comments.

 MAINTAINERS | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0cd4d02..ffd77b4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -564,6 +564,23 @@ M: Alistair Francis <alistair@alistair23.me>
 S: Maintained
 F: hw/arm/netduino2.c
 
+SmartFusion2
+M: Subbaraya Sundeep <sundeep.lkml@gmail.com>
+S: Maintained
+F: hw/arm/msf2-soc.c
+F: hw/misc/msf2-sysreg.c
+F: hw/timer/mss-timer.c
+F: hw/ssi/mss-spi.c
+F: include/hw/arm/msf2-soc.h
+F: include/hw/misc/msf2-sysreg.h
+F: include/hw/timer/mss-timer.h
+F: include/hw/ssi/mss-spi.h
+
+Emcraft M2S-FG484
+M: Subbaraya Sundeep <sundeep.lkml@gmail.com>
+S: Maintained
+F: hw/arm/msf2-som.c
+
 CRIS Machines
 -------------
 Axis Dev88
-- 
2.5.0
