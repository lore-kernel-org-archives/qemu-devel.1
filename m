Received: from eggs.gnu.org ([2001:4830:134:3::10]:47522)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gHGqn-0001NG-QS
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 19:21:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gHGqi-0000DT-V0
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 19:21:37 -0400
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Tue, 30 Oct 2018 00:20:58 +0100
Message-Id: <20181029232100.8454-2-philmd@redhat.com>
In-Reply-To: <20181029232100.8454-1-philmd@redhat.com>
References: <20181029232100.8454-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 1/3] hw/arm/xilinx_zynq: Use the ARRAY_SIZE
 macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Guenter Roeck <linux@roeck-us.net>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Igor Mitsyanko <i.mitsyanko@gmail.com>, Alistair Francis <alistair@alistair23.me>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, qemu-devel@nongnu.org, qemu-arm@nongnu.org

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/arm/xilinx_zynq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/arm/xilinx_zynq.c b/hw/arm/xilinx_zynq.c
index f1496d2927..57497b0c4d 100644
--- a/hw/arm/xilinx_zynq.c
+++ b/hw/arm/xilinx_zynq.c
@@ -294,7 +294,7 @@ static void zynq_init(MachineState *machine)
     busdev =3D SYS_BUS_DEVICE(dev);
     sysbus_mmio_map(busdev, 0, 0xF8003000);
     sysbus_connect_irq(busdev, 0, pic[45-IRQ_OFFSET]); /* abort irq line=
 */
-    for (n =3D 0; n < 8; ++n) { /* event irqs */
+    for (n =3D 0; n < ARRAY_SIZE(dma_irqs); ++n) { /* event irqs */
         sysbus_connect_irq(busdev, n + 1, pic[dma_irqs[n] - IRQ_OFFSET])=
;
     }
=20
--=20
2.17.2
