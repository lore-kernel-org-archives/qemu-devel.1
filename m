Received: from eggs.gnu.org ([2001:4830:134:3::10]:46581)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <frasse.iglesias@gmail.com>) id 1eozMC-0000Rh-9L
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 17:28:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <frasse.iglesias@gmail.com>) id 1eozMB-0001Mr-BC
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 17:28:52 -0500
Received: from mail-lf0-x242.google.com ([2a00:1450:4010:c07::242]:45966)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <frasse.iglesias@gmail.com>)
	id 1eozMB-0001Ly-2w
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 17:28:51 -0500
Received: by mail-lf0-x242.google.com with SMTP id x196so9660438lfd.12
	for <qemu-devel@nongnu.org>; Thu, 22 Feb 2018 14:28:50 -0800 (PST)
From: Francisco Iglesias <frasse.iglesias@gmail.com>
Date: Thu, 22 Feb 2018 23:28:44 +0100
Message-Id: <20180222222844.7109-3-frasse.iglesias@gmail.com>
In-Reply-To: <20180222222844.7109-1-frasse.iglesias@gmail.com>
References: <20180222222844.7109-1-frasse.iglesias@gmail.com>
Subject: [Qemu-devel] [PATCH 2/2] xilinx_spips: Use 8 dummy cycles with the
 QIOR/QIOR4 commands
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: edgari@xilinx.com, alistai@xilinx.com, francisco.iglesias@feimtech.se, peter.maydell@linaro.org

Use 8 dummy cycles (4 dummy bytes) with the QIOR/QIOR4 commands in legacy mode
for matching what is expected by Micron (Numonyx) flashes (the default target
flash type of the QSPI).

Signed-off-by: Francisco Iglesias <frasse.iglesias@gmail.com>
---
 hw/ssi/xilinx_spips.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/ssi/xilinx_spips.c b/hw/ssi/xilinx_spips.c
index e566d179fe..eb7fc0ea71 100644
--- a/hw/ssi/xilinx_spips.c
+++ b/hw/ssi/xilinx_spips.c
@@ -578,7 +578,7 @@ static int xilinx_spips_num_dummies(XilinxQSPIPS *qs, uint8_t command)
         return 2;
     case QIOR:
     case QIOR_4:
-        return 5;
+        return 4;
     default:
         return -1;
     }
-- 
2.11.0
