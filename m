Received: from eggs.gnu.org ([2001:4830:134:3::10]:54370)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1eRSJ7-0001vA-4q
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 19:32:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1eRSJ3-00072e-7g
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 19:32:25 -0500
Received: from mail-co1nam03on0077.outbound.protection.outlook.com
	([104.47.40.77]:14131
	helo=NAM03-CO1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alistai@xilinx.com>) id 1eRSJ2-000724-VI
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 19:32:21 -0500
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Tue, 19 Dec 2017 16:27:56 -0800
Message-ID: <4a3fcaca266b4d766c968b18c7c15d820404594a.1513729519.git.alistair.francis@xilinx.com>
In-Reply-To: <cover.1513729519.git.alistair.francis@xilinx.com>
References: <cover.1513729519.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 3/5] raspi: Specify the valid CPUs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: alistair.francis@xilinx.com, alistair23@gmail.com, ehabkost@redhat.com, marcel@redhat.com, imammedo@redhat.com, f4bug@amsat.org

List all possible valid CPU options.

Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
---

V4:
 - Remove spaces
V3:
 - Add static property
V2:
 - Fix the indentation

 hw/arm/raspi.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
index cd5fa8c3dc..bd175e8c16 100644
--- a/hw/arm/raspi.c
+++ b/hw/arm/raspi.c
@@ -158,6 +158,11 @@ static void raspi2_init(MachineState *machine)
     setup_boot(machine, 2, machine->ram_size - vcram_size);
 }
=20
+static const char *raspi2_valid_cpus[] =3D {
+    ARM_CPU_TYPE_NAME("cortex-a7"),
+    NULL
+};
+
 static void raspi2_machine_init(MachineClass *mc)
 {
     mc->desc =3D "Raspberry Pi 2";
@@ -171,5 +176,7 @@ static void raspi2_machine_init(MachineClass *mc)
     mc->default_cpus =3D BCM2836_NCPUS;
     mc->default_ram_size =3D 1024 * 1024 * 1024;
     mc->ignore_memory_transaction_failures =3D true;
+    mc->default_cpu_type =3D ARM_CPU_TYPE_NAME("cortex-a7");
+    mc->valid_cpu_types =3D raspi2_valid_cpus;
 };
 DEFINE_MACHINE("raspi2", raspi2_machine_init)
--=20
2.14.1
