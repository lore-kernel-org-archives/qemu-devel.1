Received: from eggs.gnu.org ([209.51.188.92]:57675)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gh08X-0005cc-QD
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 17:46:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gh08U-0006XR-8w
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 17:46:16 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Wed,  9 Jan 2019 09:45:35 +1100
Message-Id: <20190108224600.23125-5-david@gibson.dropbear.id.au>
In-Reply-To: <20190108224600.23125-1-david@gibson.dropbear.id.au>
References: <20190108224600.23125-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 04/29] MAINTAINERS: Add more files to sam460ex
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: groug@kaod.org, clg@kaod.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, BALATON Zoltan <balaton@eik.bme.hu>, David Gibson <david@gibson.dropbear.id.au>

From: BALATON Zoltan <balaton@eik.bme.hu>

The sm501 model belonged to SH before but that seems to be inactive
now and latest changes were for sam460ex which is the more active user
of this device at the moment so let's adopt sm501 for sam460ex.

Also add device tree and firmware sources and binaries.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0bfd95a4ef..fc0be06756 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1052,8 +1052,14 @@ sam460ex
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
=20
 SH4 Machines
 ------------
--=20
2.20.1
