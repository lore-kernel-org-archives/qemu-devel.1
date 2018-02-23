Received: from eggs.gnu.org ([2001:4830:134:3::10]:49602)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <frasse.iglesias@gmail.com>) id 1epMfq-0006KX-P7
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 18:22:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <frasse.iglesias@gmail.com>) id 1epMfn-00027c-G5
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 18:22:42 -0500
Received: from mail-lf0-x243.google.com ([2a00:1450:4010:c07::243]:47054)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <frasse.iglesias@gmail.com>)
	id 1epMfn-00026Q-7S
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 18:22:39 -0500
Received: by mail-lf0-x243.google.com with SMTP id r80so14566588lfe.13
	for <qemu-devel@nongnu.org>; Fri, 23 Feb 2018 15:22:39 -0800 (PST)
From: Francisco Iglesias <frasse.iglesias@gmail.com>
Date: Sat, 24 Feb 2018 00:22:33 +0100
Message-Id: <20180223232233.31482-3-frasse.iglesias@gmail.com>
In-Reply-To: <20180223232233.31482-1-frasse.iglesias@gmail.com>
References: <20180223232233.31482-1-frasse.iglesias@gmail.com>
Subject: [Qemu-devel] [PATCH v2 2/2] xilinx_spips: Use 8 dummy cycles with
 the QIOR/QIOR4 commands
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
Tested-by: Alistair Francis <alistair.francis@xilinx.com>
Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>
---
 hw/ssi/xilinx_spips.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/ssi/xilinx_spips.c b/hw/ssi/xilinx_spips.c
index 0cb484ecf4..426f971311 100644
--- a/hw/ssi/xilinx_spips.c
+++ b/hw/ssi/xilinx_spips.c
@@ -577,7 +577,7 @@ static int xilinx_spips_num_dummies(XilinxQSPIPS *qs, uint8_t command)
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
