Received: from eggs.gnu.org ([2001:4830:134:3::10]:48687)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gUBbt-0006NH-Gz
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 09:23:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gUBbs-0000Aw-N6
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 09:23:37 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue,  4 Dec 2018 18:20:22 +0400
Message-Id: <20181204142023.15982-19-marcandre.lureau@redhat.com>
In-Reply-To: <20181204142023.15982-1-marcandre.lureau@redhat.com>
References: <20181204142023.15982-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for-3.2 v5 18/19] hw/arm/virt: add virt-4.0
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
Cc: imammedo@redhat.com, ehabkost@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, "open list:Virt" <qemu-arm@nongnu.org>

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 hw/arm/virt.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 530c8ca89d..433374f0d0 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1797,7 +1797,7 @@ static void machvirt_machine_init(void)
 }
 type_init(machvirt_machine_init);
=20
-static void virt_3_1_instance_init(Object *obj)
+static void virt_4_0_instance_init(Object *obj)
 {
     VirtMachineState *vms =3D VIRT_MACHINE(obj);
     VirtMachineClass *vmc =3D VIRT_MACHINE_GET_CLASS(vms);
@@ -1867,10 +1867,28 @@ static void virt_3_1_instance_init(Object *obj)
     vms->irqmap =3D a15irqmap;
 }
=20
+static void virt_machine_4_0_options(MachineClass *mc)
+{
+}
+DEFINE_VIRT_MACHINE_AS_LATEST(4, 0)
+
+static GlobalProperty virt_compat_3_1[] =3D {
+    HW_COMPAT_3_1
+};
+
+static void virt_3_1_instance_init(Object *obj)
+{
+    virt_4_0_instance_init(obj);
+}
+
 static void virt_machine_3_1_options(MachineClass *mc)
 {
+    virt_machine_4_0_options(mc);
+    compat_props_add(mc->compat_props,
+                     virt_compat_3_1, G_N_ELEMENTS(virt_compat_3_1));
 }
-DEFINE_VIRT_MACHINE_AS_LATEST(3, 1)
+
+DEFINE_VIRT_MACHINE(3, 1)
=20
 static GlobalProperty virt_compat_3_0[] =3D {
     HW_COMPAT_3_0
--=20
2.20.0.rc1
