Received: from eggs.gnu.org ([2001:4830:134:3::10]:51651)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cu7C6-0004lV-61
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 20:47:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cu7C3-0006Ds-SP
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 20:47:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52436)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cu7C3-0006CU-MS
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 20:47:03 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Fri, 31 Mar 2017 21:46:11 -0300
Message-Id: <20170401004624.30886-7-ehabkost@redhat.com>
In-Reply-To: <20170401004624.30886-1-ehabkost@redhat.com>
References: <20170401004624.30886-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [RFC 06/19] iommu: Remove FIXME comment about
 user_creatable=true
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laszlo Ersek <lersek@redhat.com>, Alexander Graf <agraf@suse.de>, Marcel Apfelbaum <marcel@redhat.com>, Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Markus Armbruster <armbru@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

amd-iommu and intel-iommu are really meant to be used with
-device, so they need user_creatable=true. Remove the FIXME
comment.

Cc: Marcel Apfelbaum <marcel@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 hw/i386/amd_iommu.c   | 4 ----
 hw/i386/intel_iommu.c | 4 ----
 2 files changed, 8 deletions(-)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 1d139f3f6a..748c3648bb 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -1186,10 +1186,6 @@ static void amdvi_class_init(ObjectClass *klass, void* data)
     dc->vmsd = &vmstate_amdvi;
     dc->hotpluggable = false;
     dc_class->realize = amdvi_realize;
-    /*
-     * FIXME: Set only for compatibility on q35 machine-type.
-     * Probably never meant to be user-creatable
-     */
     dc->user_creatable = true;
 }
 
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 5e5125f34b..1db33df5b7 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -2601,10 +2601,6 @@ static void vtd_class_init(ObjectClass *klass, void *data)
     dc->hotpluggable = false;
     x86_class->realize = vtd_realize;
     x86_class->int_remap = vtd_int_remap;
-    /*
-     * FIXME: Set only for compatibility on q35 machine-type.
-     * Probably never meant to be user-creatable
-     */
     dc->user_creatable = true;
 }
 
-- 
2.11.0.259.g40922b1
