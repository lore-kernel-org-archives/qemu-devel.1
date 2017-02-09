Received: from eggs.gnu.org ([2001:4830:134:3::10]:59188)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <agraf@suse.de>) id 1cboDy-0002be-Su
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 07:53:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <agraf@suse.de>) id 1cboDy-0007Q8-9d
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 07:53:22 -0500
From: Alexander Graf <agraf@suse.de>
Date: Thu,  9 Feb 2017 13:53:28 +0100
Message-Id: <1486644810-33181-3-git-send-email-agraf@suse.de>
In-Reply-To: <1486644810-33181-1-git-send-email-agraf@suse.de>
References: <1486644810-33181-1-git-send-email-agraf@suse.de>
Subject: [Qemu-devel] [PATCH v2 2/4] hw/arm/virt: Declare virtio-mmio as dma
 cache coherent in ACPI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, mst@redhat.com, Laszlo Ersek <lersek@redhat.com>, Shannon Zhao <shannon.zhao@linaro.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>

Virtio-mmio devices can directly access guest memory and do so in cache
coherent fashion. Tell the guest about that fact when it's using ACPI.

Signed-off-by: Alexander Graf <agraf@suse.de>
---
 hw/arm/virt-acpi-build.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 07a10ac..8955a9d 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -135,6 +135,7 @@ static void acpi_dsdt_add_virtio(Aml *scope,
         Aml *dev = aml_device("VR%02u", i);
         aml_append(dev, aml_name_decl("_HID", aml_string("LNRO0005")));
         aml_append(dev, aml_name_decl("_UID", aml_int(i)));
+        aml_append(dev, aml_name_decl("_CCA", aml_int(1)));
 
         Aml *crs = aml_resource_template();
         aml_append(crs, aml_memory32_fixed(base, size, AML_READ_WRITE));
-- 
2.10.0
