Received: from eggs.gnu.org ([2001:4830:134:3::10]:41331)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1ehPWK-0005ye-Ru
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 19:49:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1ehPVG-0000W2-OB
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 19:48:00 -0500
Received: from mail-sn1nam02on0058.outbound.protection.outlook.com
	([104.47.36.58]:26419
	helo=NAM02-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alistai@xilinx.com>) id 1ehPVG-0000Uc-AB
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 19:46:54 -0500
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Thu, 1 Feb 2018 16:42:10 -0800
Message-ID: <e394130fdcf7e19abfc584db75720546980075bf.1517532021.git.alistair.francis@xilinx.com>
In-Reply-To: <cover.1517532021.git.alistair.francis@xilinx.com>
References: <cover.1517532021.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v5 3/6] bcm2836: Use the Cortex-A7 instead of
 Cortex-A15
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: alistair.francis@xilinx.com, alistair23@gmail.com, ehabkost@redhat.com, marcel@redhat.com, imammedo@redhat.com, f4bug@amsat.org, peter.maydell@linaro.org

The BCM2836 uses a Cortex-A7 not a Cortex-A15. Update the device to use
the correct CPU.
https://www.raspberrypi.org/documentation/hardware/raspberrypi/bcm2836/QA7_=
rev3.4.pdf

Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
---
V3:
 - Use ARM_CPU_TYPE_NAME() macro
V2:
 - Fix the BCM2836 CPU

 hw/arm/bcm2836.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/arm/bcm2836.c b/hw/arm/bcm2836.c
index 8c43291112..c477772484 100644
--- a/hw/arm/bcm2836.c
+++ b/hw/arm/bcm2836.c
@@ -30,7 +30,7 @@ static void bcm2836_init(Object *obj)
=20
     for (n =3D 0; n < BCM2836_NCPUS; n++) {
         object_initialize(&s->cpus[n], sizeof(s->cpus[n]),
-                          "cortex-a15-" TYPE_ARM_CPU);
+                          ARM_CPU_TYPE_NAME("cortex-a7"));
         object_property_add_child(obj, "cpu[*]", OBJECT(&s->cpus[n]),
                                   &error_abort);
     }
--=20
2.14.1
