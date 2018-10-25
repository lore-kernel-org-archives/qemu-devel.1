Received: from eggs.gnu.org ([2001:4830:134:3::10]:58017)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gFfni-00032b-CA
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 09:35:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gFfnf-00008B-HW
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 09:35:50 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Thu, 25 Oct 2018 10:32:33 -0300
Message-Id: <20181025133301.16578-16-ehabkost@redhat.com>
In-Reply-To: <20181025133301.16578-1-ehabkost@redhat.com>
References: <20181025133301.16578-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v2 15/43] hw/mips/malta: Remove unuseful code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <agraf@suse.de>, Rob Herring <robh@kernel.org>, libvir-list@redhat.com, Richard Henderson <rth@twiddle.net>, David Gibson <david@gibson.dropbear.id.au>, Eric Blake <eblake@redhat.com>, Igor Mammedov <imammedo@redhat.com>, qemu-arm@nongnu.org, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Markus Armbruster <armbru@redhat.com>, Artyom Tarasenko <atar4qemu@gmail.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Eduardo Habkost <ehabkost@redhat.com>, Michael Walle <michael@walle.cc>, Thomas Huth <thuth@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Aleksandar Markovic <amarkovic@wavecomp.com>, Aurelien Jarno <aurelien@aurel32.net>, Alistair Francis <alistair@alistair23.me>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Laurent Vivier <lvivier@redhat.com>, qemu-ppc@nongnu.org, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20181002212522.23303-13-f4bug@amsat.org>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 hw/mips/mips_malta.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
index 29b90bacf3..c1cf0fe12e 100644
--- a/hw/mips/mips_malta.c
+++ b/hw/mips/mips_malta.c
@@ -1422,23 +1422,10 @@ void mips_malta_init(MachineState *machine)
     pci_vga_init(pci_bus);
 }
=20
-static int mips_malta_sysbus_device_init(SysBusDevice *sysbusdev)
-{
-    return 0;
-}
-
-static void mips_malta_class_init(ObjectClass *klass, void *data)
-{
-    SysBusDeviceClass *k =3D SYS_BUS_DEVICE_CLASS(klass);
-
-    k->init =3D mips_malta_sysbus_device_init;
-}
-
 static const TypeInfo mips_malta_device =3D {
     .name          =3D TYPE_MIPS_MALTA,
     .parent        =3D TYPE_SYS_BUS_DEVICE,
     .instance_size =3D sizeof(MaltaState),
-    .class_init    =3D mips_malta_class_init,
 };
=20
 static void mips_malta_machine_init(MachineClass *mc)
--=20
2.18.0.rc1.1.g3f1ff2140
