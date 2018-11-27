Received: from eggs.gnu.org ([2001:4830:134:3::10]:48336)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gRZj6-0005Sq-U7
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 04:32:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gRZj2-0006cu-0B
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 04:32:16 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 27 Nov 2018 13:28:00 +0400
Message-Id: <20181127092801.21777-28-marcandre.lureau@redhat.com>
In-Reply-To: <20181127092801.21777-1-marcandre.lureau@redhat.com>
References: <20181127092801.21777-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for-3.2 v4 27/28] hw/arm/virt: add virt-3.2
 machine type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: imammedo@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, "open list:Virt" <qemu-arm@nongnu.org>

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 hw/arm/virt.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index d106a8a8c7..22343db485 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1796,7 +1796,7 @@ static void machvirt_machine_init(void)
 }
 type_init(machvirt_machine_init);
=20
-static void virt_3_1_instance_init(Object *obj)
+static void virt_3_2_instance_init(Object *obj)
 {
     VirtMachineState *vms =3D VIRT_MACHINE(obj);
     VirtMachineClass *vmc =3D VIRT_MACHINE_GET_CLASS(vms);
@@ -1866,10 +1866,26 @@ static void virt_3_1_instance_init(Object *obj)
     vms->irqmap =3D a15irqmap;
 }
=20
+static void virt_machine_3_2_options(MachineClass *mc)
+{
+}
+DEFINE_VIRT_MACHINE_AS_LATEST(3, 2)
+
+#define VIRT_COMPAT_3_1 \
+    HW_COMPAT_3_1
+
+static void virt_3_1_instance_init(Object *obj)
+{
+    virt_3_2_instance_init(obj);
+}
+
 static void virt_machine_3_1_options(MachineClass *mc)
 {
+    virt_machine_3_2_options(mc);
+    SET_COMPAT(mc, VIRT_COMPAT_3_1);
 }
-DEFINE_VIRT_MACHINE_AS_LATEST(3, 1)
+
+DEFINE_VIRT_MACHINE(3, 1)
=20
 #define VIRT_COMPAT_3_0 \
     HW_COMPAT_3_0
--=20
2.20.0.rc1
