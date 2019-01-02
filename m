Received: from eggs.gnu.org ([208.118.235.92]:35890)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1geWgU-0004Ou-KS
	for qemu-devel@nongnu.org; Tue, 01 Jan 2019 21:55:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1geWgS-0005SO-VP
	for qemu-devel@nongnu.org; Tue, 01 Jan 2019 21:55:06 -0500
Message-Id: <849bd7369be13cbdc65d6e5e175b8e7f86528d72.1546394798.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1546394798.git.balaton@eik.bme.hu>
References: <cover.1546394798.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Date: Wed, 02 Jan 2019 03:06:38 +0100
Subject: [Qemu-devel] [PATCH 8/8] MAINTAINERS: Add more files to sam460ex
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Cc: David Gibson <david@gibson.dropbear.id.au>, Peter Maydell <peter.maydell@linaro.org>

The sm501 model belonged to SH before but that seems to be inactive
now and latest changes were for sam460ex which is the more active user
of this device at the moment so let's adopt sm501 for sam460ex.

Also add device tree and firmware sources and binaries.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 180695f5d3..d2b71f8c4c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1029,8 +1029,14 @@ sam460ex
 M: BALATON Zoltan <balaton@eik.bme.hu>
 L: qemu-ppc@nongnu.org
 S: Maintained
+F: hw/ppc/sam460ex.c
+F: hw/ppc/ppc440_pcix.c
+F: hw/display/sm501*
 F: hw/ide/sii3112.c
 F: hw/timer/m41t80.c
+F: pc-bios/canyonlands.dt[sb]
+F: pc-bios/u-boot-sam460ex-20100605.bin
+F: roms/u-boot-sam460ex
 
 SH4 Machines
 ------------
-- 
2.13.7
