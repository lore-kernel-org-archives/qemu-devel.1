Received: from eggs.gnu.org ([2001:4830:134:3::10]:41509)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1ehPWT-00060p-E3
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 19:49:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1ehPVP-0000h2-Bd
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 19:48:09 -0500
Received: from mail-sn1nam01on0072.outbound.protection.outlook.com
	([104.47.32.72]:25856
	helo=NAM01-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alistai@xilinx.com>) id 1ehPVP-0000fs-09
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 19:47:03 -0500
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Thu, 1 Feb 2018 16:42:17 -0800
Message-ID: <fd4c2e3b9ee60652a3c09d8b225654e5167570ef.1517532021.git.alistair.francis@xilinx.com>
In-Reply-To: <cover.1517532021.git.alistair.francis@xilinx.com>
References: <cover.1517532021.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v5 6/6] xilinx_zynq: Specify the valid CPUs
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

List all possible valid CPU options.

Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
---

V5:
 - Use cpu_model names
V4:
 - Remove spaces
V3:
 - Make variable static
V2:
 - Fixup alignment

 hw/arm/xilinx_zynq.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/arm/xilinx_zynq.c b/hw/arm/xilinx_zynq.c
index 1836a4ed45..822e1889a5 100644
--- a/hw/arm/xilinx_zynq.c
+++ b/hw/arm/xilinx_zynq.c
@@ -313,6 +313,11 @@ static void zynq_init(MachineState *machine)
     arm_load_kernel(ARM_CPU(first_cpu), &zynq_binfo);
 }
=20
+static const char *xlnx_zynq_7000_valid_cpus[] =3D {
+    "cortex-a9",
+    NULL
+};
+
 static void zynq_machine_init(MachineClass *mc)
 {
     mc->desc =3D "Xilinx Zynq Platform Baseboard for Cortex-A9";
@@ -321,6 +326,7 @@ static void zynq_machine_init(MachineClass *mc)
     mc->no_sdcard =3D 1;
     mc->ignore_memory_transaction_failures =3D true;
     mc->default_cpu_type =3D ARM_CPU_TYPE_NAME("cortex-a9");
+    mc->valid_cpu_types =3D xlnx_zynq_7000_valid_cpus;
 }
=20
 DEFINE_MACHINE("xilinx-zynq-a9", zynq_machine_init)
--=20
2.14.1
