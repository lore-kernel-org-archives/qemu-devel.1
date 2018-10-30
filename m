Received: from eggs.gnu.org ([2001:4830:134:3::10]:53659)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gHRyC-0000xr-Ib
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 07:14:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gHRy9-00085D-1f
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 07:14:00 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 30 Oct 2018 12:13:47 +0100
Message-Id: <20181030111348.14713-4-kraxel@redhat.com>
In-Reply-To: <20181030111348.14713-1-kraxel@redhat.com>
References: <20181030111348.14713-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH 3/4] tag cirrus as obsolete
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <agraf@suse.de>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Eric Blake <eblake@redhat.com>, qemu-ppc@nongnu.org, Richard Henderson <rth@twiddle.net>, Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>

Standard VGA should be used instead.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/display/cirrus_vga.c     | 3 +++
 hw/display/cirrus_vga_isa.c | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/hw/display/cirrus_vga.c b/hw/display/cirrus_vga.c
index d9b854d74d..ec2cefb46f 100644
--- a/hw/display/cirrus_vga.c
+++ b/hw/display/cirrus_vga.c
@@ -3024,6 +3024,9 @@ static void cirrus_vga_class_init(ObjectClass *klass, void *data)
     dc->vmsd = &vmstate_pci_cirrus_vga;
     dc->props = pci_vga_cirrus_properties;
     dc->hotpluggable = false;
+    dc->supported.state = SUPPORT_STATE_OBSOLETE;
+    dc->supported.reason = "use \"-vga std\" instead, see "
+        "https://www.kraxel.org/blog/2014/10/qemu-using-cirrus-considered-harmful/";
 }
 
 static const TypeInfo cirrus_vga_info = {
diff --git a/hw/display/cirrus_vga_isa.c b/hw/display/cirrus_vga_isa.c
index fa10b74230..cfe2cad9e0 100644
--- a/hw/display/cirrus_vga_isa.c
+++ b/hw/display/cirrus_vga_isa.c
@@ -81,6 +81,9 @@ static void isa_cirrus_vga_class_init(ObjectClass *klass, void *data)
     dc->realize = isa_cirrus_vga_realizefn;
     dc->props = isa_cirrus_vga_properties;
     set_bit(DEVICE_CATEGORY_DISPLAY, dc->categories);
+    dc->supported.state = SUPPORT_STATE_OBSOLETE;
+    dc->supported.reason = "use \"-vga std\" instead, see "
+        "https://www.kraxel.org/blog/2014/10/qemu-using-cirrus-considered-harmful/";
 }
 
 static const TypeInfo isa_cirrus_vga_info = {
-- 
2.9.3
