Received: from eggs.gnu.org ([2001:4830:134:3::10]:52867)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fLsRI-0000My-A4
	for qemu-devel@nongnu.org; Thu, 24 May 2018 11:46:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fLsRE-00030t-7h
	for qemu-devel@nongnu.org; Thu, 24 May 2018 11:46:04 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34680 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fLsRE-00030V-3l
	for qemu-devel@nongnu.org; Thu, 24 May 2018 11:46:00 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B0AE8401EF00
	for <qemu-devel@nongnu.org>; Thu, 24 May 2018 15:45:59 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu, 24 May 2018 17:45:52 +0200
Message-Id: <20180524154556.17876-4-kraxel@redhat.com>
In-Reply-To: <20180524154556.17876-1-kraxel@redhat.com>
References: <20180524154556.17876-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 3/7] vga-pci: use PCI_VGA_MMIO_SIZE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Message-id: 20180522165058.15404-3-kraxel@redhat.com
---
 hw/display/vga-pci.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/hw/display/vga-pci.c b/hw/display/vga-pci.c
index fb3e4cd400..700ac58c69 100644
--- a/hw/display/vga-pci.c
+++ b/hw/display/vga-pci.c
@@ -232,7 +232,8 @@ static void pci_std_vga_realize(PCIDevice *dev, Error=
 **errp)
=20
     /* mmio bar for vga register access */
     if (d->flags & (1 << PCI_VGA_FLAG_ENABLE_MMIO)) {
-        memory_region_init(&d->mmio, NULL, "vga.mmio", 4096);
+        memory_region_init(&d->mmio, NULL, "vga.mmio",
+                           PCI_VGA_MMIO_SIZE);
=20
         if (d->flags & (1 << PCI_VGA_FLAG_ENABLE_QEXT)) {
             qext =3D true;
@@ -267,7 +268,8 @@ static void pci_secondary_vga_realize(PCIDevice *dev,=
 Error **errp)
     s->con =3D graphic_console_init(DEVICE(dev), 0, s->hw_ops, s);
=20
     /* mmio bar */
-    memory_region_init(&d->mmio, OBJECT(dev), "vga.mmio", 4096);
+    memory_region_init(&d->mmio, OBJECT(dev), "vga.mmio",
+                       PCI_VGA_MMIO_SIZE);
=20
     if (d->flags & (1 << PCI_VGA_FLAG_ENABLE_QEXT)) {
         qext =3D true;
--=20
2.9.3
