Received: from eggs.gnu.org ([2001:4830:134:3::10]:34986)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1e05X1-0006hP-Ax
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 08:45:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1e05X0-0001xk-GG
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 08:45:39 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Thu,  5 Oct 2017 09:45:07 -0300
Message-Id: <20171005124507.14732-1-ehabkost@redhat.com>
In-Reply-To: <20171004130655.GK4760@localhost.localdomain>
Subject: [Qemu-devel] [PATCH] xen/pt: Mark TYPE_XEN_PT_DEVICE as hybrid
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Jan Beulich <JBeulich@suse.com>, Peter Maydell <peter.maydell@linaro.org>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Gerd Hoffmann <kraxel@redhat.com>, David Gibson <dgibson@redhat.com>, Jiri Slaby <jslaby@suse.cz>, Hannes Reinecke <hare@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org, Alexander Graf <agraf@suse.de>, =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>, Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org, Richard Henderson <rth@twiddle.net>, Artyom Tarasenko <atar4qemu@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Marcel Apfelbaum <marcel@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, qemu-arm@nongnu.org, Laine Stump <laine@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Yongbok Kim <yongbok.kim@imgtec.com>, Alistair Francis <alistair23@gmail.com>, John Snow <jsnow@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org, Igor Mammedov <imammedo@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>

xen-pt doesn't set the is_express field, but is supposed to be
able to handle PCI Express devices too.  Mark it as hybrid.

Suggested-by: Jan Beulich <JBeulich@suse.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 hw/xen/xen_pt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/xen/xen_pt.c b/hw/xen/xen_pt.c
index 01df3414d3..9bba717708 100644
--- a/hw/xen/xen_pt.c
+++ b/hw/xen/xen_pt.c
@@ -966,6 +966,7 @@ static const TypeInfo xen_pci_passthrough_info = {
     .class_init = xen_pci_passthrough_class_init,
     .interfaces = (InterfaceInfo[]) {
         { INTERFACE_CONVENTIONAL_PCI_DEVICE },
+        { INTERFACE_PCIE_DEVICE },
         { },
     },
 };
-- 
2.13.6
