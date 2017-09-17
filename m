Received: from eggs.gnu.org ([2001:4830:134:3::10]:45673)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dtdAy-00065N-Lx
	for qemu-devel@nongnu.org; Sun, 17 Sep 2017 13:16:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dtdAt-0006A8-NI
	for qemu-devel@nongnu.org; Sun, 17 Sep 2017 13:16:12 -0400
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Sun, 17 Sep 2017 18:15:41 +0100
Message-Id: <1505668548-16616-2-git-send-email-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <1505668548-16616-1-git-send-email-mark.cave-ayland@ilande.co.uk>
References: <1505668548-16616-1-git-send-email-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH 1/8] ppc: QOMify g3beige machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, benh@kernel.crashing.org

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/ppc/mac_oldworld.c |   17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/mac_oldworld.c b/hw/ppc/mac_oldworld.c
index fcac399..5d1171d 100644
--- a/hw/ppc/mac_oldworld.c
+++ b/hw/ppc/mac_oldworld.c
@@ -380,8 +380,10 @@ static int heathrow_kvm_type(const char *arg)
     return 2;
 }
 
-static void heathrow_machine_init(MachineClass *mc)
+static void heathrow_class_init(ObjectClass *oc, void *data)
 {
+    MachineClass *mc = MACHINE_CLASS(oc);
+
     mc->desc = "Heathrow based PowerMAC";
     mc->init = ppc_heathrow_init;
     mc->block_default_type = IF_IDE;
@@ -394,4 +396,15 @@ static void heathrow_machine_init(MachineClass *mc)
     mc->kvm_type = heathrow_kvm_type;
 }
 
-DEFINE_MACHINE("g3beige", heathrow_machine_init)
+static const TypeInfo ppc_heathrow_machine_info = {
+    .name          = MACHINE_TYPE_NAME("g3beige"),
+    .parent        = TYPE_MACHINE,
+    .class_init    = heathrow_class_init
+};
+
+static void ppc_heathrow_register_types(void)
+{
+    type_register_static(&ppc_heathrow_machine_info);
+}
+
+type_init(ppc_heathrow_register_types);
-- 
1.7.10.4
