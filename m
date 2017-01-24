Received: from eggs.gnu.org ([2001:4830:134:3::10]:37050)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=19091db4e=Paul.Durrant@citrix.com>)
	id 1cVzCU-0005F0-Mv
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 06:23:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=19091db4e=Paul.Durrant@citrix.com>)
	id 1cVzCR-0007B0-GL
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 06:23:46 -0500
Received: from smtp02.citrix.com ([66.165.176.63]:18800)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=19091db4e=Paul.Durrant@citrix.com>)
	id 1cVzCR-0007Aa-B1
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 06:23:43 -0500
From: Paul Durrant <paul.durrant@citrix.com>
Date: Tue, 24 Jan 2017 11:23:39 +0000
Message-ID: <1485257020-18542-3-git-send-email-paul.durrant@citrix.com>
In-Reply-To: <1485257020-18542-1-git-send-email-paul.durrant@citrix.com>
References: <1485257020-18542-1-git-send-email-paul.durrant@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 2/3] xen-platform: add support for unplugging
 NVMe disks...
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, xen-devel@lists.xenproject.org
Cc: Paul Durrant <paul.durrant@citrix.com>, Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>

...not just IDE and SCSI.

This patch allows the Xen tool-stack to fully support of NVMe as an
emulated disk type.

Signed-off-by: Paul Durrant <paul.durrant@citrix.com>
---
Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: Anthony Perard <anthony.perard@citrix.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Eduardo Habkost <ehabkost@redhat.com>
---
 hw/i386/xen/xen_platform.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/i386/xen/xen_platform.c b/hw/i386/xen/xen_platform.c
index 3708559..544da67 100644
--- a/hw/i386/xen/xen_platform.c
+++ b/hw/i386/xen/xen_platform.c
@@ -119,6 +119,7 @@ static void unplug_disks(PCIBus *b, PCIDevice *d, void *o)
         break;
 
     case PCI_CLASS_STORAGE_SCSI:
+    case PCI_CLASS_STORAGE_EXPRESS:
         object_unparent(OBJECT(d));
         break;
 
-- 
2.1.4
