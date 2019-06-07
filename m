Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BF9CC28CC3
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 08:38:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0407F20B7C
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 08:38:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0407F20B7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46894 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZAOj-0005Qu-Br
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 04:38:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58894)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kraxel@redhat.com>) id 1hZAKs-0001mx-MH
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 04:34:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1hZAKr-00033p-Il
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 04:34:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55204)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1hZAKr-00030z-9e
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 04:34:53 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 929C3308FC4A;
 Fri,  7 Jun 2019 08:34:52 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-117-25.ams2.redhat.com
 [10.36.117.25])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DAFAE7D4E5;
 Fri,  7 Jun 2019 08:34:47 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 3B54716E1A; Fri,  7 Jun 2019 10:34:47 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri,  7 Jun 2019 10:34:44 +0200
Message-Id: <20190607083444.32175-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Fri, 07 Jun 2019 08:34:52 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH] edid: flip the default to enabled
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/hw/virtio/virtio-gpu.h | 2 +-
 hw/core/machine.c              | 8 +++++++-
 hw/display/bochs-display.c     | 2 +-
 hw/display/vga-pci.c           | 4 ++--
 4 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h
index 8ecac1987a7f..6dd57f2025ec 100644
--- a/include/hw/virtio/virtio-gpu.h
+++ b/include/hw/virtio/virtio-gpu.h
@@ -125,7 +125,7 @@ typedef struct VirtIOGPUBaseClass {
 #define VIRTIO_GPU_BASE_PROPERTIES(_state, _conf)                       \
     DEFINE_PROP_UINT32("max_outputs", _state, _conf.max_outputs, 1),    \
     DEFINE_PROP_BIT("edid", _state, _conf.flags, \
-                    VIRTIO_GPU_FLAG_EDID_ENABLED, false), \
+                    VIRTIO_GPU_FLAG_EDID_ENABLED, true), \
     DEFINE_PROP_UINT32("xres", _state, _conf.xres, 1024), \
     DEFINE_PROP_UINT32("yres", _state, _conf.yres, 768)
 
diff --git a/hw/core/machine.c b/hw/core/machine.c
index f1a0f45f9c83..84ebb8d24701 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -24,7 +24,13 @@
 #include "hw/pci/pci.h"
 #include "hw/mem/nvdimm.h"
 
-GlobalProperty hw_compat_4_0_1[] = {};
+GlobalProperty hw_compat_4_0_1[] = {
+    { "VGA",            "edid", "false" },
+    { "secondary-vga",  "edid", "false" },
+    { "bochs-display",  "edid", "false" },
+    { "virtio-vga",     "edid", "false" },
+    { "virtio-gpu-pci", "edid", "false" },
+};
 const size_t hw_compat_4_0_1_len = G_N_ELEMENTS(hw_compat_4_0_1);
 
 GlobalProperty hw_compat_4_0[] = {};
diff --git a/hw/display/bochs-display.c b/hw/display/bochs-display.c
index 3d439eb2407b..681a047d793c 100644
--- a/hw/display/bochs-display.c
+++ b/hw/display/bochs-display.c
@@ -336,7 +336,7 @@ static void bochs_display_exit(PCIDevice *dev)
 
 static Property bochs_display_properties[] = {
     DEFINE_PROP_SIZE("vgamem", BochsDisplayState, vgamem, 16 * MiB),
-    DEFINE_PROP_BOOL("edid", BochsDisplayState, enable_edid, false),
+    DEFINE_PROP_BOOL("edid", BochsDisplayState, enable_edid, true),
     DEFINE_EDID_PROPERTIES(BochsDisplayState, edid_info),
     DEFINE_PROP_END_OF_LIST(),
 };
diff --git a/hw/display/vga-pci.c b/hw/display/vga-pci.c
index a17c96e703fe..3b76457ab077 100644
--- a/hw/display/vga-pci.c
+++ b/hw/display/vga-pci.c
@@ -338,7 +338,7 @@ static Property vga_pci_properties[] = {
     DEFINE_PROP_BIT("qemu-extended-regs",
                     PCIVGAState, flags, PCI_VGA_FLAG_ENABLE_QEXT, true),
     DEFINE_PROP_BIT("edid",
-                    PCIVGAState, flags, PCI_VGA_FLAG_ENABLE_EDID, false),
+                    PCIVGAState, flags, PCI_VGA_FLAG_ENABLE_EDID, true),
     DEFINE_EDID_PROPERTIES(PCIVGAState, edid_info),
     DEFINE_PROP_BOOL("global-vmstate", PCIVGAState, vga.global_vmstate, false),
     DEFINE_PROP_END_OF_LIST(),
@@ -349,7 +349,7 @@ static Property secondary_pci_properties[] = {
     DEFINE_PROP_BIT("qemu-extended-regs",
                     PCIVGAState, flags, PCI_VGA_FLAG_ENABLE_QEXT, true),
     DEFINE_PROP_BIT("edid",
-                    PCIVGAState, flags, PCI_VGA_FLAG_ENABLE_EDID, false),
+                    PCIVGAState, flags, PCI_VGA_FLAG_ENABLE_EDID, true),
     DEFINE_EDID_PROPERTIES(PCIVGAState, edid_info),
     DEFINE_PROP_END_OF_LIST(),
 };
-- 
2.18.1


