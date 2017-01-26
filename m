Received: from eggs.gnu.org ([2001:4830:134:3::10]:36824)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=192659432=Paul.Durrant@citrix.com>)
	id 1cWgUm-0005fn-Of
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 04:37:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=192659432=Paul.Durrant@citrix.com>)
	id 1cWgUk-0003Sp-6S
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 04:37:32 -0500
Received: from smtp.citrix.com ([66.165.176.89]:20876)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=192659432=Paul.Durrant@citrix.com>)
	id 1cWgUk-0003QA-1r
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 04:37:30 -0500
From: Paul Durrant <paul.durrant@citrix.com>
Date: Thu, 26 Jan 2017 09:37:24 +0000
Message-ID: <1485423445-12302-3-git-send-email-paul.durrant@citrix.com>
In-Reply-To: <1485423445-12302-1-git-send-email-paul.durrant@citrix.com>
References: <1485423445-12302-1-git-send-email-paul.durrant@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v3 2/3] xen-platform: add support for
 unplugging NVMe disks...
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
emulated disk type. See [1] for the relevant tool-stack patch discussion.

[1] https://lists.xen.org/archives/html/xen-devel/2017-01/msg01225.html

Signed-off-by: Paul Durrant <paul.durrant@citrix.com>
---
Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: Anthony Perard <anthony.perard@citrix.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Eduardo Habkost <ehabkost@redhat.com>

v3:
- Add reference to xen-devel patch discussion in commit message as
  requested by Stefano.
---
 hw/i386/xen/xen_platform.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/i386/xen/xen_platform.c b/hw/i386/xen/xen_platform.c
index f50915f..7d41ebb 100644
--- a/hw/i386/xen/xen_platform.c
+++ b/hw/i386/xen/xen_platform.c
@@ -120,6 +120,7 @@ static void unplug_disks(PCIBus *b, PCIDevice *d, void *o)
         break;
 
     case PCI_CLASS_STORAGE_SCSI:
+    case PCI_CLASS_STORAGE_EXPRESS:
         object_unparent(OBJECT(d));
         break;
 
-- 
2.1.4
