Received: from eggs.gnu.org ([209.51.188.92]:45883)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hJisk-0003N7-RO
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 14:14:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hJisj-0002Rb-Pj
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 14:14:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35118)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hJisj-0002NC-JP
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 14:14:01 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Thu, 25 Apr 2019 15:13:41 -0300
Message-Id: <20190425181342.15360-4-ehabkost@redhat.com>
In-Reply-To: <20190425181342.15360-1-ehabkost@redhat.com>
References: <20190425181342.15360-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 3/4] Categorize devices: iommu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Richard Henderson <rth@twiddle.net>, Ernest Esene <eroken1@gmail.com>

From: Ernest Esene <eroken1@gmail.com>

Set category and description for iommu devices.

Signed-off-by: Ernest Esene <eroken1@gmail.com>
Message-Id: <20190327170518.GA16887@erokenlabserver>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
[ehabkost: edited commit message]
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 hw/i386/amd_iommu.c   | 2 ++
 hw/i386/intel_iommu.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 6eabdf9917..4a4e2c7fd4 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -1601,6 +1601,8 @@ static void amdvi_class_init(ObjectClass *klass, void* data)
     dc_class->int_remap = amdvi_int_remap;
     /* Supported by the pc-q35-* machine types */
     dc->user_creatable = true;
+    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
+    dc->desc = "AMD IOMMU (AMD-Vi) DMA Remapping device";
 }
 
 static const TypeInfo amdvi = {
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 2558f48fe6..44b1231157 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -3741,6 +3741,8 @@ static void vtd_class_init(ObjectClass *klass, void *data)
     x86_class->int_remap = vtd_int_remap;
     /* Supported by the pc-q35-* machine types */
     dc->user_creatable = true;
+    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
+    dc->desc = "Intel IOMMU (VT-d) DMA Remapping device";
 }
 
 static const TypeInfo vtd_info = {
-- 
2.18.0.rc1.1.g3f1ff2140
