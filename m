Return-Path: <SRS0=9ZvH=C5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BD8EC43465
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Sep 2020 13:26:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0ABF820EDD
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Sep 2020 13:26:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0ABF820EDD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=maciej.szmigiero.name
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37274 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJzMS-0005I1-Rv
	for qemu-devel@archiver.kernel.org; Sun, 20 Sep 2020 09:26:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34570)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mail@maciej.szmigiero.name>)
 id 1kJzLb-00044Z-Qx
 for qemu-devel@nongnu.org; Sun, 20 Sep 2020 09:25:43 -0400
Received: from vps-vb.mhejs.net ([37.28.154.113]:44286)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mail@maciej.szmigiero.name>)
 id 1kJzLX-00037p-Ul
 for qemu-devel@nongnu.org; Sun, 20 Sep 2020 09:25:43 -0400
Received: from MUA
 by vps-vb.mhejs.net with esmtps (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
 (Exim 4.93.0.4) (envelope-from <mail@maciej.szmigiero.name>)
 id 1kJzLM-00087M-DX; Sun, 20 Sep 2020 15:25:28 +0200
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
To: "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>
Subject: [PATCH] pc-dimm: remove unnecessary get_vmstate_memory_region() method
Date: Sun, 20 Sep 2020 15:25:18 +0200
Message-Id: <9476ea5c7dc758b9b083a232eeb8d9b380b5e138.1600556464.git.maciej.szmigiero@oracle.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=37.28.154.113;
 envelope-from=mail@maciej.szmigiero.name; helo=vps-vb.mhejs.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/20 09:25:30
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>

The get_vmstate_memory_region() method from PCDIMMDeviceClass is only
ever called from this class and is never overridden, so it can be converted
into an ordinary function.

Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
---
 hw/mem/pc-dimm.c         | 33 ++++++++++++++-------------------
 include/hw/mem/pc-dimm.h |  5 -----
 2 files changed, 14 insertions(+), 24 deletions(-)

diff --git a/hw/mem/pc-dimm.c b/hw/mem/pc-dimm.c
index c30351070bb8..01c133f3b864 100644
--- a/hw/mem/pc-dimm.c
+++ b/hw/mem/pc-dimm.c
@@ -34,6 +34,16 @@
 
 static int pc_dimm_get_free_slot(const int *hint, int max_slots, Error **errp);
 
+static MemoryRegion *pc_dimm_get_memory_region(PCDIMMDevice *dimm, Error **errp)
+{
+    if (!dimm->hostmem) {
+        error_setg(errp, "'" PC_DIMM_MEMDEV_PROP "' property must be set");
+        return NULL;
+    }
+
+    return host_memory_backend_get_memory(dimm->hostmem);
+}
+
 void pc_dimm_pre_plug(PCDIMMDevice *dimm, MachineState *machine,
                       const uint64_t *legacy_align, Error **errp)
 {
@@ -66,9 +76,8 @@ void pc_dimm_pre_plug(PCDIMMDevice *dimm, MachineState *machine,
 
 void pc_dimm_plug(PCDIMMDevice *dimm, MachineState *machine, Error **errp)
 {
-    PCDIMMDeviceClass *ddc = PC_DIMM_GET_CLASS(dimm);
-    MemoryRegion *vmstate_mr = ddc->get_vmstate_memory_region(dimm,
-                                                              &error_abort);
+    MemoryRegion *vmstate_mr = pc_dimm_get_memory_region(dimm,
+                                                         &error_abort);
 
     memory_device_plug(MEMORY_DEVICE(dimm), machine);
     vmstate_register_ram(vmstate_mr, DEVICE(dimm));
@@ -76,9 +85,8 @@ void pc_dimm_plug(PCDIMMDevice *dimm, MachineState *machine, Error **errp)
 
 void pc_dimm_unplug(PCDIMMDevice *dimm, MachineState *machine)
 {
-    PCDIMMDeviceClass *ddc = PC_DIMM_GET_CLASS(dimm);
-    MemoryRegion *vmstate_mr = ddc->get_vmstate_memory_region(dimm,
-                                                              &error_abort);
+    MemoryRegion *vmstate_mr = pc_dimm_get_memory_region(dimm,
+                                                         &error_abort);
 
     memory_device_unplug(MEMORY_DEVICE(dimm), machine);
     vmstate_unregister_ram(vmstate_mr, DEVICE(dimm));
@@ -205,16 +213,6 @@ static void pc_dimm_unrealize(DeviceState *dev)
     host_memory_backend_set_mapped(dimm->hostmem, false);
 }
 
-static MemoryRegion *pc_dimm_get_memory_region(PCDIMMDevice *dimm, Error **errp)
-{
-    if (!dimm->hostmem) {
-        error_setg(errp, "'" PC_DIMM_MEMDEV_PROP "' property must be set");
-        return NULL;
-    }
-
-    return host_memory_backend_get_memory(dimm->hostmem);
-}
-
 static uint64_t pc_dimm_md_get_addr(const MemoryDeviceState *md)
 {
     return object_property_get_uint(OBJECT(md), PC_DIMM_ADDR_PROP,
@@ -266,7 +264,6 @@ static void pc_dimm_md_fill_device_info(const MemoryDeviceState *md,
 static void pc_dimm_class_init(ObjectClass *oc, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
-    PCDIMMDeviceClass *ddc = PC_DIMM_CLASS(oc);
     MemoryDeviceClass *mdc = MEMORY_DEVICE_CLASS(oc);
 
     dc->realize = pc_dimm_realize;
@@ -274,8 +271,6 @@ static void pc_dimm_class_init(ObjectClass *oc, void *data)
     device_class_set_props(dc, pc_dimm_properties);
     dc->desc = "DIMM memory module";
 
-    ddc->get_vmstate_memory_region = pc_dimm_get_memory_region;
-
     mdc->get_addr = pc_dimm_md_get_addr;
     mdc->set_addr = pc_dimm_md_set_addr;
     /* for a dimm plugged_size == region_size */
diff --git a/include/hw/mem/pc-dimm.h b/include/hw/mem/pc-dimm.h
index 1d570defc95b..6874d34943f8 100644
--- a/include/hw/mem/pc-dimm.h
+++ b/include/hw/mem/pc-dimm.h
@@ -56,9 +56,6 @@ struct PCDIMMDevice {
  * PCDIMMDeviceClass:
  * @realize: called after common dimm is realized so that the dimm based
  * devices get the chance to do specified operations.
- * @get_vmstate_memory_region: returns #MemoryRegion which indicates the
- * memory of @dimm should be kept during live migration. Will not fail
- * after the device was realized.
  */
 struct PCDIMMDeviceClass {
     /* private */
@@ -66,8 +63,6 @@ struct PCDIMMDeviceClass {
 
     /* public */
     void (*realize)(PCDIMMDevice *dimm, Error **errp);
-    MemoryRegion *(*get_vmstate_memory_region)(PCDIMMDevice *dimm,
-                                               Error **errp);
 };
 
 void pc_dimm_pre_plug(PCDIMMDevice *dimm, MachineState *machine,

