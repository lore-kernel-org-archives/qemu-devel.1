Received: from eggs.gnu.org ([2001:4830:134:3::10]:39559)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gJykL-0005qX-O0
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 05:38:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gJyWO-0005Ev-L9
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 05:23:48 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue,  6 Nov 2018 11:23:34 +0100
Message-Id: <20181106102335.20027-6-kraxel@redhat.com>
In-Reply-To: <20181106102335.20027-1-kraxel@redhat.com>
References: <20181106102335.20027-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH v2 5/6] tag cirrus as obsolete
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <agraf@suse.de>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Eric Blake <eblake@redhat.com>, qemu-ppc@nongnu.org, Richard Henderson <rth@twiddle.net>, =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>, Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>

Standard VGA should be used instead.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/display/cirrus_vga.c     | 3 +++
 hw/display/cirrus_vga_isa.c | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/hw/display/cirrus_vga.c b/hw/display/cirrus_vga.c
index d9b854d74d..8474415687 100644
--- a/hw/display/cirrus_vga.c
+++ b/hw/display/cirrus_vga.c
@@ -3024,6 +3024,9 @@ static void cirrus_vga_class_init(ObjectClass *klass, void *data)
     dc->vmsd = &vmstate_pci_cirrus_vga;
     dc->props = pci_vga_cirrus_properties;
     dc->hotpluggable = false;
+    klass->supported.state = SUPPORT_STATE_OBSOLETE;
+    klass->supported.help = "use \"-vga std\" instead, see "
+        "https://www.kraxel.org/blog/2014/10/qemu-using-cirrus-considered-harmful/";
 }
 
 static const TypeInfo cirrus_vga_info = {
diff --git a/hw/display/cirrus_vga_isa.c b/hw/display/cirrus_vga_isa.c
index fa10b74230..6bc83f7509 100644
--- a/hw/display/cirrus_vga_isa.c
+++ b/hw/display/cirrus_vga_isa.c
@@ -81,6 +81,9 @@ static void isa_cirrus_vga_class_init(ObjectClass *klass, void *data)
     dc->realize = isa_cirrus_vga_realizefn;
     dc->props = isa_cirrus_vga_properties;
     set_bit(DEVICE_CATEGORY_DISPLAY, dc->categories);
+    klass->supported.state = SUPPORT_STATE_OBSOLETE;
+    klass->supported.help = "use \"-vga std\" instead, see "
+        "https://www.kraxel.org/blog/2014/10/qemu-using-cirrus-considered-harmful/";
 }
 
 static const TypeInfo isa_cirrus_vga_info = {
-- 
2.9.3
