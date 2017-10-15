Received: from eggs.gnu.org ([2001:4830:134:3::10]:49240)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1e3ZWu-0002y9-8E
	for qemu-devel@nongnu.org; Sat, 14 Oct 2017 23:23:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1e3ZWt-00075I-Ai
	for qemu-devel@nongnu.org; Sat, 14 Oct 2017 23:23:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60462)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1e3ZWt-00074r-4E
	for qemu-devel@nongnu.org; Sat, 14 Oct 2017 23:23:55 -0400
Date: Sun, 15 Oct 2017 06:23:53 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1508036858-13479-20-git-send-email-mst@redhat.com>
References: <1508036858-13479-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1508036858-13479-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL 19/26] xen/pt: Mark TYPE_XEN_PT_DEVICE as hybrid
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, Jan Beulich <JBeulich@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org

From: Eduardo Habkost <ehabkost@redhat.com>

xen-pt doesn't set the is_express field, but is supposed to be
able to handle PCI Express devices too.  Mark it as hybrid.

Suggested-by: Jan Beulich <JBeulich@suse.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/xen/xen_pt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/xen/xen_pt.c b/hw/xen/xen_pt.c
index 01df341..9bba717 100644
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
MST
