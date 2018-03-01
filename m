Received: from eggs.gnu.org ([2001:4830:134:3::10]:33780)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1erMJu-0003iX-TF
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 06:24:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1erMJt-000875-O0
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 06:24:18 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:46704)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1erMJt-00085k-FY
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 06:24:17 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1erMJi-0000Xn-Ko
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 11:24:06 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu,  1 Mar 2018 11:23:24 +0000
Message-Id: <20180301112403.12487-4-peter.maydell@linaro.org>
In-Reply-To: <20180301112403.12487-1-peter.maydell@linaro.org>
References: <20180301112403.12487-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 03/42] xilinx_spips: Use 8 dummy cycles with the
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

From: Francisco Iglesias <frasse.iglesias@gmail.com>

Use 8 dummy cycles (4 dummy bytes) with the QIOR/QIOR4 commands in legacy mode
for matching what is expected by Micron (Numonyx) flashes (the default target
flash type of the QSPI).

Signed-off-by: Francisco Iglesias <frasse.iglesias@gmail.com>
Tested-by: Alistair Francis <alistair.francis@xilinx.com>
Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>
Message-id: 20180223232233.31482-3-frasse.iglesias@gmail.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
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
2.16.2
