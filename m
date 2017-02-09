Received: from eggs.gnu.org ([2001:4830:134:3::10]:59194)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <agraf@suse.de>) id 1cboDz-0002bg-4t
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 07:53:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <agraf@suse.de>) id 1cboDy-0007QN-Cv
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 07:53:23 -0500
From: Alexander Graf <agraf@suse.de>
Date: Thu,  9 Feb 2017 13:53:29 +0100
Message-Id: <1486644810-33181-4-git-send-email-agraf@suse.de>
In-Reply-To: <1486644810-33181-1-git-send-email-agraf@suse.de>
References: <1486644810-33181-1-git-send-email-agraf@suse.de>
Subject: [Qemu-devel] [PATCH v2 3/4] hw/arm/virt: Declare fwcfg as dma cache
 coherent in ACPI
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

Fw-cfg recently learned how to directly access guest memory and does so in
cache coherent fashion. Tell the guest about that fact when it's using ACPI.

Signed-off-by: Alexander Graf <agraf@suse.de>
---
 hw/arm/virt-acpi-build.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 8955a9d..0835e59 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -90,6 +90,7 @@ static void acpi_dsdt_add_fw_cfg(Aml *scope, const MemMapEntry *fw_cfg_memmap)
     aml_append(dev, aml_name_decl("_HID", aml_string("QEMU0002")));
     /* device present, functioning, decoding, not shown in UI */
     aml_append(dev, aml_name_decl("_STA", aml_int(0xB)));
+    aml_append(dev, aml_name_decl("_CCA", aml_int(1)));
 
     Aml *crs = aml_resource_template();
     aml_append(crs, aml_memory32_fixed(fw_cfg_memmap->base,
-- 
2.10.0
