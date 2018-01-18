Received: from eggs.gnu.org ([2001:4830:134:3::10]:46184)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ebzfW-0000xg-0i
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 21:11:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ebzfV-0004ry-6Q
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 21:11:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57212)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1ebzfV-0004rZ-0L
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 21:11:05 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Thu, 18 Jan 2018 00:09:51 -0200
Message-Id: <20180118021000.27203-11-ehabkost@redhat.com>
In-Reply-To: <20180118021000.27203-1-ehabkost@redhat.com>
References: <20180118021000.27203-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 10/19] xen: Add only xen-sysdev to dynamic
 sysbus device list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org, Juergen Gross <jgross@suse.com>

There's no need to make the machine allow every possible sysbus
device.  We can now just add xen-sysdev to the allowed list.

Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: Anthony Perard <anthony.perard@citrix.com>
Cc: xen-devel@lists.xenproject.org
Cc: Juergen Gross <jgross@suse.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Message-Id: <20171125151610.20547-6-ehabkost@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Acked-by: Anthony PERARD <anthony.perard@citrix.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 hw/xen/xen_backend.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/hw/xen/xen_backend.c b/hw/xen/xen_backend.c
index 82380ea9ee..7445b506ac 100644
--- a/hw/xen/xen_backend.c
+++ b/hw/xen/xen_backend.c
@@ -564,12 +564,7 @@ static void xen_set_dynamic_sysbus(void)
     ObjectClass *oc =3D object_get_class(machine);
     MachineClass *mc =3D MACHINE_CLASS(oc);
=20
-    /*
-     * Emulate old mc->has_dynamic_sysbus=3Dtrue assignment
-     *
-     *TODO: add only Xen devices to the list
-     */
-    machine_class_allow_dynamic_sysbus_dev(mc, TYPE_SYS_BUS_DEVICE);
+    machine_class_allow_dynamic_sysbus_dev(mc, TYPE_XENSYSDEV);
 }
=20
 int xen_be_register(const char *type, struct XenDevOps *ops)
--=20
2.14.3
