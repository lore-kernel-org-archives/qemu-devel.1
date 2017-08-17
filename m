Received: from eggs.gnu.org ([2001:4830:134:3::10]:40690)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=3958fb005=anthony.perard@citrix.com>)
	id 1diNaZ-0005lN-Kp
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 12:24:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=3958fb005=anthony.perard@citrix.com>)
	id 1diNaW-0003Eq-H6
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 12:24:07 -0400
Received: from smtp.citrix.com ([66.165.176.89]:18727)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=3958fb005=anthony.perard@citrix.com>)
	id 1diNaW-0003Ee-9X
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 12:24:04 -0400
From: Anthony PERARD <anthony.perard@citrix.com>
Date: Thu, 17 Aug 2017 17:23:45 +0100
Message-ID: <20170817162347.1590-2-anthony.perard@citrix.com>
In-Reply-To: <20170817162347.1590-1-anthony.perard@citrix.com>
References: <20170817162347.1590-1-anthony.perard@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH for-2.10 v3 1/3] hw/acpi: Limit hotplug to root
 bus on legacy mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Anthony PERARD <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>

Signed-off-by: Anthony PERARD <anthony.perard@citrix.com>
---
New patch in V3
---
 hw/acpi/pcihp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/acpi/pcihp.c b/hw/acpi/pcihp.c
index c420a388ea..9db3c2eaf2 100644
--- a/hw/acpi/pcihp.c
+++ b/hw/acpi/pcihp.c
@@ -273,7 +273,7 @@ static void pci_write(void *opaque, hwaddr addr, uint64_t data,
                       addr, data);
         break;
     case PCI_SEL_BASE:
-        s->hotplug_select = data;
+        s->hotplug_select = s->legacy_piix ? ACPI_PCIHP_BSEL_DEFAULT : data;
         ACPI_PCIHP_DPRINTF("pcisel write %" HWADDR_PRIx " <== %" PRIu64 "\n",
                       addr, data);
     default:
-- 
Anthony PERARD
