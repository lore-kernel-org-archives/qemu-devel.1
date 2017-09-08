Received: from eggs.gnu.org ([2001:4830:134:3::10]:48974)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dqK7k-0006Xo-Fh
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 10:19:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dqK7h-0004pe-Du
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 10:19:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58084)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dqK7h-0004ov-7i
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 10:19:09 -0400
Date: Fri, 8 Sep 2017 17:19:07 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1504880304-12069-4-git-send-email-mst@redhat.com>
References: <1504880304-12069-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1504880304-12069-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL 03/17] hw/acpi: Limit hotplug to root bus on
 legacy mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Anthony PERARD <anthony.perard@citrix.com>, Igor Mammedov <imammedo@redhat.com>

From: Anthony PERARD <anthony.perard@citrix.com>

Signed-off-by: Anthony PERARD <anthony.perard@citrix.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/acpi/pcihp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/acpi/pcihp.c b/hw/acpi/pcihp.c
index c420a38..9db3c2e 100644
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
MST
