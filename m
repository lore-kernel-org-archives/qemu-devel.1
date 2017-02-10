Received: from eggs.gnu.org ([2001:4830:134:3::10]:49602)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ccFc9-00021t-8P
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 13:08:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ccFc8-0003yN-FF
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 13:08:09 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:48480)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1ccFc8-0003sU-8n
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 13:08:08 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.84_2)
	(envelope-from <pm215@archaic.org.uk>) id 1ccFc6-0007cX-SP
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 18:08:06 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 10 Feb 2017 18:07:56 +0000
Message-Id: <1486750082-12324-7-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1486750082-12324-1-git-send-email-peter.maydell@linaro.org>
References: <1486750082-12324-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 06/12] hw/arm/virt: Declare virtio-mmio as dma
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

From: Alexander Graf <agraf@suse.de>

Virtio-mmio devices can directly access guest memory and do so in cache
coherent fashion. Tell the guest about that fact when it's using ACPI.

Signed-off-by: Alexander Graf <agraf@suse.de>
Reviewed-by: Laszlo Ersek <lersek@redhat.com>
Reviewed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Reviewed-by: Shannon Zhao <shannon.zhao@linaro.org>
Message-id: 1486644810-33181-3-git-send-email-agraf@suse.de
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
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
2.7.4
