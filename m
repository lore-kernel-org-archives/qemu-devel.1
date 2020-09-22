Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 295DFC4727D
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 09:08:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C5D22086A
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 09:08:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C5D22086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36172 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKeI2-0004Tx-2V
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 05:08:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55966)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kKdwQ-0006bU-12; Tue, 22 Sep 2020 04:46:26 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:35135)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kKdwL-0000w2-TL; Tue, 22 Sep 2020 04:46:25 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
 by mailnew.nyi.internal (Postfix) with ESMTP id 1544D5803C0;
 Tue, 22 Sep 2020 04:46:01 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute7.internal (MEProxy); Tue, 22 Sep 2020 04:46:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm1; bh=ygCsk1klVp5Bt
 vkq8EHRBP9J4O6cR1aCfHbbVW8FnZ0=; b=dORBtAIfgqIzZ5s3YgI7lHAoB+SvY
 8mK0PKCY+eHjufYqsR1HaQMhnLm1IY/oJCAwNCUk42RMCrdxETJ9o0KBFI7lynZw
 VPYjpk6uhrNgDF1pBy5WXr88VYzWEd6c7LqlLKbbrdzjUPfOKE08iUUX288/qkE1
 6o9qlGUHHn+PzqQ8MdOgI0sSYBl+CPlOjWwprA6ehiOhPqG63U60QD5m40Ya0hoY
 dZJpJdS08bzYY4Sb2M+ZWGcUYbZAkH3xK5RBGZNN6zuRzfwtt0aH6RXRKbwW/JJD
 3iV+CX7fmznRWSD225XG1eI0zrfsbq5QS+Ghhcn8Z05bV4v695J7YA5TA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm3; bh=ygCsk1klVp5Btvkq8EHRBP9J4O6cR1aCfHbbVW8FnZ0=; b=sBpjrjyn
 4fhg6Bx93nVojo0ZH8C3a05e8DNEQiP27t2uPHYwIdLvQcYe8QC70r1MizPoKW/y
 vCQWuuQbySndatTkojrBgqnIMFvRLqbsVwhPNsOJ90Z4VZ9964IaR1jmewqm+QHK
 403Mb4uUasTIBEjGfekLO4vtfPaNQjlAgfbv84SwfNXZzuPFu0POVig2KML+3G1r
 BUKR8PALNz+tiHTeW/P8GUTYAp1ye7zD7P0DCIT7YPNeovNdV3ShO3g7Q1ft9c5k
 jU6Cjf30Br9uENEIahoMjQ0r/eLOoT7iCSWggbYMxOD8KF6OpfszP/r0Q6XuPzS4
 spGE/rZeSiJMsQ==
X-ME-Sender: <xms:x7lpXzEZT34g-7KQZjD9eq5phLEh9wqUmceyNzgKfT1yqq52zeKa4Q>
 <xme:x7lpXwXccdcoUH5_rUgWLgHMZmdS1t5V4JJIscSJ8V90u6ZPfJBsjRgUtWMQ5zJLd
 zJEg3guT0sNMBnsy4M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudeggddtkecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepmfhlrghushcu
 lfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrthhtvg
 hrnhepudeiteefjeejgeevhfejuedvueeigfffgfdvteetveetjeejueegudfhheegffek
 necuffhomhgrihhnpehquggvvhdrihgunecukfhppeektddrudeijedrleekrdduledtne
 cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepihhtshes
 ihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:x7lpX1KEIykcn3iQycobxYF_aFHtiSvjjgpR2Zz8zlHimPtm5p8enA>
 <xmx:x7lpXxFvfMl6cU1U_99jmbb6Ra56GTIYK5lgJcQf_EJ-sdZp1Jom3Q>
 <xmx:x7lpX5VUtPOvKm7S4rtw9KFrxhvfQpd5zDMcsWsScgiT4pINhSCkiQ>
 <xmx:x7lpX1ol5KXlLGL2J0C9S_l-akL9KMvugfP5g57P9MwkPHxpTWTD0EAKKho>
Received: from apples.local (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id CCCEB3064685;
 Tue, 22 Sep 2020 04:45:57 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 15/17] hw/block/nvme: support multiple namespaces
Date: Tue, 22 Sep 2020 10:45:31 +0200
Message-Id: <20200922084533.1273962-16-its@irrelevant.dk>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200922084533.1273962-1-its@irrelevant.dk>
References: <20200922084533.1273962-1-its@irrelevant.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=66.111.4.230; envelope-from=its@irrelevant.dk;
 helo=new4-smtp.messagingengine.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 04:45:36
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Klaus Jensen <k.jensen@samsung.com>, Max Reitz <mreitz@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Minwoo Im <minwoo.im.dev@gmail.com>,
 Klaus Jensen <its@irrelevant.dk>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Klaus Jensen <k.jensen@samsung.com>

This adds support for multiple namespaces by introducing a new 'nvme-ns'
device model. The nvme device creates a bus named from the device name
('id'). The nvme-ns devices then connect to this and registers
themselves with the nvme device.

This changes how an nvme device is created. Example with two namespaces:

  -drive file=nvme0n1.img,if=none,id=disk1
  -drive file=nvme0n2.img,if=none,id=disk2
  -device nvme,serial=deadbeef,id=nvme0
  -device nvme-ns,drive=disk1,bus=nvme0,nsid=1
  -device nvme-ns,drive=disk2,bus=nvme0,nsid=2

The drive property is kept on the nvme device to keep the change
backward compatible, but the property is now optional. Specifying a
drive for the nvme device will always create the namespace with nsid 1.

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
Reviewed-by: Keith Busch <kbusch@kernel.org>
Reviewed-by: Minwoo Im <minwoo.im.dev@gmail.com>
---
 hw/block/nvme-ns.h    |  74 +++++++++++++
 hw/block/nvme.h       |  46 ++++----
 hw/block/nvme-ns.c    | 167 ++++++++++++++++++++++++++++
 hw/block/nvme.c       | 249 +++++++++++++++++++++++++++---------------
 hw/block/meson.build  |   2 +-
 hw/block/trace-events |   6 +-
 6 files changed, 428 insertions(+), 116 deletions(-)
 create mode 100644 hw/block/nvme-ns.h
 create mode 100644 hw/block/nvme-ns.c

diff --git a/hw/block/nvme-ns.h b/hw/block/nvme-ns.h
new file mode 100644
index 000000000000..83734f4606e1
--- /dev/null
+++ b/hw/block/nvme-ns.h
@@ -0,0 +1,74 @@
+/*
+ * QEMU NVM Express Virtual Namespace
+ *
+ * Copyright (c) 2019 CNEX Labs
+ * Copyright (c) 2020 Samsung Electronics
+ *
+ * Authors:
+ *  Klaus Jensen      <k.jensen@samsung.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2. See the
+ * COPYING file in the top-level directory.
+ *
+ */
+
+#ifndef NVME_NS_H
+#define NVME_NS_H
+
+#define TYPE_NVME_NS "nvme-ns"
+#define NVME_NS(obj) \
+    OBJECT_CHECK(NvmeNamespace, (obj), TYPE_NVME_NS)
+
+typedef struct NvmeNamespaceParams {
+    uint32_t nsid;
+} NvmeNamespaceParams;
+
+typedef struct NvmeNamespace {
+    DeviceState  parent_obj;
+    BlockConf    blkconf;
+    int32_t      bootindex;
+    int64_t      size;
+    NvmeIdNs     id_ns;
+
+    NvmeNamespaceParams params;
+} NvmeNamespace;
+
+static inline uint32_t nvme_nsid(NvmeNamespace *ns)
+{
+    if (ns) {
+        return ns->params.nsid;
+    }
+
+    return -1;
+}
+
+static inline NvmeLBAF *nvme_ns_lbaf(NvmeNamespace *ns)
+{
+    NvmeIdNs *id_ns = &ns->id_ns;
+    return &id_ns->lbaf[NVME_ID_NS_FLBAS_INDEX(id_ns->flbas)];
+}
+
+static inline uint8_t nvme_ns_lbads(NvmeNamespace *ns)
+{
+    return nvme_ns_lbaf(ns)->ds;
+}
+
+/* calculate the number of LBAs that the namespace can accomodate */
+static inline uint64_t nvme_ns_nlbas(NvmeNamespace *ns)
+{
+    return ns->size >> nvme_ns_lbads(ns);
+}
+
+/* convert an LBA to the equivalent in bytes */
+static inline size_t nvme_l2b(NvmeNamespace *ns, uint64_t lba)
+{
+    return lba << nvme_ns_lbads(ns);
+}
+
+typedef struct NvmeCtrl NvmeCtrl;
+
+int nvme_ns_setup(NvmeCtrl *n, NvmeNamespace *ns, Error **errp);
+void nvme_ns_drain(NvmeNamespace *ns);
+void nvme_ns_flush(NvmeNamespace *ns);
+
+#endif /* NVME_NS_H */
diff --git a/hw/block/nvme.h b/hw/block/nvme.h
index f355eccb323b..d96ec15cdffb 100644
--- a/hw/block/nvme.h
+++ b/hw/block/nvme.h
@@ -2,6 +2,9 @@
 #define HW_NVME_H
 
 #include "block/nvme.h"
+#include "nvme-ns.h"
+
+#define NVME_MAX_NAMESPACES 256
 
 typedef struct NvmeParams {
     char     *serial;
@@ -90,26 +93,12 @@ typedef struct NvmeCQueue {
     QTAILQ_HEAD(, NvmeRequest) req_list;
 } NvmeCQueue;
 
-typedef struct NvmeNamespace {
-    NvmeIdNs        id_ns;
-} NvmeNamespace;
+#define TYPE_NVME_BUS "nvme-bus"
+#define NVME_BUS(obj) OBJECT_CHECK(NvmeBus, (obj), TYPE_NVME_BUS)
 
-static inline NvmeLBAF *nvme_ns_lbaf(NvmeNamespace *ns)
-{
-    NvmeIdNs *id_ns = &ns->id_ns;
-    return &id_ns->lbaf[NVME_ID_NS_FLBAS_INDEX(id_ns->flbas)];
-}
-
-static inline uint8_t nvme_ns_lbads(NvmeNamespace *ns)
-{
-    return nvme_ns_lbaf(ns)->ds;
-}
-
-/* convert an LBA to the equivalent in bytes */
-static inline size_t nvme_l2b(NvmeNamespace *ns, uint64_t lba)
-{
-    return lba << nvme_ns_lbads(ns);
-}
+typedef struct NvmeBus {
+    BusState parent_bus;
+} NvmeBus;
 
 #define TYPE_NVME "nvme"
 #define NVME(obj) \
@@ -121,6 +110,7 @@ typedef struct NvmeFeatureVal {
         uint16_t temp_thresh_low;
     };
     uint32_t    async_config;
+    uint32_t    vwc;
 } NvmeFeatureVal;
 
 typedef struct NvmeCtrl {
@@ -128,8 +118,9 @@ typedef struct NvmeCtrl {
     MemoryRegion iomem;
     MemoryRegion ctrl_mem;
     NvmeBar      bar;
-    BlockConf    conf;
     NvmeParams   params;
+    NvmeBus      bus;
+    BlockConf    conf;
 
     bool        qs_created;
     uint32_t    page_size;
@@ -140,7 +131,6 @@ typedef struct NvmeCtrl {
     uint32_t    reg_size;
     uint32_t    num_namespaces;
     uint32_t    max_q_ents;
-    uint64_t    ns_size;
     uint8_t     outstanding_aers;
     uint8_t     *cmbuf;
     uint32_t    irq_status;
@@ -156,7 +146,8 @@ typedef struct NvmeCtrl {
     QTAILQ_HEAD(, NvmeAsyncEvent) aer_queue;
     int         aer_queued;
 
-    NvmeNamespace   *namespaces;
+    NvmeNamespace   namespace;
+    NvmeNamespace   *namespaces[NVME_MAX_NAMESPACES];
     NvmeSQueue      **sq;
     NvmeCQueue      **cq;
     NvmeSQueue      admin_sq;
@@ -165,10 +156,13 @@ typedef struct NvmeCtrl {
     NvmeFeatureVal  features;
 } NvmeCtrl;
 
-/* calculate the number of LBAs that the namespace can accomodate */
-static inline uint64_t nvme_ns_nlbas(NvmeCtrl *n, NvmeNamespace *ns)
+static inline NvmeNamespace *nvme_ns(NvmeCtrl *n, uint32_t nsid)
 {
-    return n->ns_size >> nvme_ns_lbads(ns);
+    if (!nsid || nsid > n->num_namespaces) {
+        return NULL;
+    }
+
+    return n->namespaces[nsid - 1];
 }
 
 static inline NvmeCQueue *nvme_cq(NvmeRequest *req)
@@ -185,4 +179,6 @@ static inline NvmeCtrl *nvme_ctrl(NvmeRequest *req)
     return sq->ctrl;
 }
 
+int nvme_register_namespace(NvmeCtrl *n, NvmeNamespace *ns, Error **errp);
+
 #endif /* HW_NVME_H */
diff --git a/hw/block/nvme-ns.c b/hw/block/nvme-ns.c
new file mode 100644
index 000000000000..2ba0263ddaca
--- /dev/null
+++ b/hw/block/nvme-ns.c
@@ -0,0 +1,167 @@
+/*
+ * QEMU NVM Express Virtual Namespace
+ *
+ * Copyright (c) 2019 CNEX Labs
+ * Copyright (c) 2020 Samsung Electronics
+ *
+ * Authors:
+ *  Klaus Jensen      <k.jensen@samsung.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2. See the
+ * COPYING file in the top-level directory.
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/units.h"
+#include "qemu/cutils.h"
+#include "qemu/log.h"
+#include "hw/block/block.h"
+#include "hw/pci/pci.h"
+#include "sysemu/sysemu.h"
+#include "sysemu/block-backend.h"
+#include "qapi/error.h"
+
+#include "hw/qdev-properties.h"
+#include "hw/qdev-core.h"
+
+#include "nvme.h"
+#include "nvme-ns.h"
+
+static void nvme_ns_init(NvmeNamespace *ns)
+{
+    NvmeIdNs *id_ns = &ns->id_ns;
+
+    if (blk_get_flags(ns->blkconf.blk) & BDRV_O_UNMAP) {
+        ns->id_ns.dlfeat = 0x9;
+    }
+
+    id_ns->lbaf[0].ds = BDRV_SECTOR_BITS;
+
+    id_ns->nsze = cpu_to_le64(nvme_ns_nlbas(ns));
+
+    /* no thin provisioning */
+    id_ns->ncap = id_ns->nsze;
+    id_ns->nuse = id_ns->ncap;
+}
+
+static int nvme_ns_init_blk(NvmeCtrl *n, NvmeNamespace *ns, Error **errp)
+{
+    if (!blkconf_blocksizes(&ns->blkconf, errp)) {
+        return -1;
+    }
+
+    if (!blkconf_apply_backend_options(&ns->blkconf,
+                                       blk_is_read_only(ns->blkconf.blk),
+                                       false, errp)) {
+        return -1;
+    }
+
+    ns->size = blk_getlength(ns->blkconf.blk);
+    if (ns->size < 0) {
+        error_setg_errno(errp, -ns->size, "could not get blockdev size");
+        return -1;
+    }
+
+    if (blk_enable_write_cache(ns->blkconf.blk)) {
+        n->features.vwc = 0x1;
+    }
+
+    return 0;
+}
+
+static int nvme_ns_check_constraints(NvmeNamespace *ns, Error **errp)
+{
+    if (!ns->blkconf.blk) {
+        error_setg(errp, "block backend not configured");
+        return -1;
+    }
+
+    return 0;
+}
+
+int nvme_ns_setup(NvmeCtrl *n, NvmeNamespace *ns, Error **errp)
+{
+    if (nvme_ns_check_constraints(ns, errp)) {
+        return -1;
+    }
+
+    if (nvme_ns_init_blk(n, ns, errp)) {
+        return -1;
+    }
+
+    nvme_ns_init(ns);
+    if (nvme_register_namespace(n, ns, errp)) {
+        return -1;
+    }
+
+    return 0;
+}
+
+void nvme_ns_drain(NvmeNamespace *ns)
+{
+    blk_drain(ns->blkconf.blk);
+}
+
+void nvme_ns_flush(NvmeNamespace *ns)
+{
+    blk_flush(ns->blkconf.blk);
+}
+
+static void nvme_ns_realize(DeviceState *dev, Error **errp)
+{
+    NvmeNamespace *ns = NVME_NS(dev);
+    BusState *s = qdev_get_parent_bus(dev);
+    NvmeCtrl *n = NVME(s->parent);
+    Error *local_err = NULL;
+
+    if (nvme_ns_setup(n, ns, &local_err)) {
+        error_propagate_prepend(errp, local_err,
+                                "could not setup namespace: ");
+        return;
+    }
+}
+
+static Property nvme_ns_props[] = {
+    DEFINE_BLOCK_PROPERTIES(NvmeNamespace, blkconf),
+    DEFINE_PROP_UINT32("nsid", NvmeNamespace, params.nsid, 0),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void nvme_ns_class_init(ObjectClass *oc, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(oc);
+
+    set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
+
+    dc->bus_type = TYPE_NVME_BUS;
+    dc->realize = nvme_ns_realize;
+    device_class_set_props(dc, nvme_ns_props);
+    dc->desc = "Virtual NVMe namespace";
+}
+
+static void nvme_ns_instance_init(Object *obj)
+{
+    NvmeNamespace *ns = NVME_NS(obj);
+    char *bootindex = g_strdup_printf("/namespace@%d,0", ns->params.nsid);
+
+    device_add_bootindex_property(obj, &ns->bootindex, "bootindex",
+                                  bootindex, DEVICE(obj));
+
+    g_free(bootindex);
+}
+
+static const TypeInfo nvme_ns_info = {
+    .name = TYPE_NVME_NS,
+    .parent = TYPE_DEVICE,
+    .class_init = nvme_ns_class_init,
+    .instance_size = sizeof(NvmeNamespace),
+    .instance_init = nvme_ns_instance_init,
+};
+
+static void nvme_ns_register_types(void)
+{
+    type_register_static(&nvme_ns_info);
+}
+
+type_init(nvme_ns_register_types)
diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index f61076178a6d..d6749fdd96e1 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -17,12 +17,13 @@
 /**
  * Usage: add options:
  *      -drive file=<file>,if=none,id=<drive_id>
- *      -device nvme,drive=<drive_id>,serial=<serial>,id=<id[optional]>, \
+ *      -device nvme,serial=<serial>,id=<bus_name>, \
  *              cmb_size_mb=<cmb_size_mb[optional]>, \
  *              [pmrdev=<mem_backend_file_id>,] \
  *              max_ioqpairs=<N[optional]>, \
  *              aerl=<N[optional]>, aer_max_queued=<N[optional]>, \
  *              mdts=<N[optional]>
+ *      -device nvme-ns,drive=<drive_id>,bus=bus_name,nsid=<nsid>
  *
  * Note cmb_size_mb denotes size of CMB in MB. CMB is assumed to be at
  * offset 0 in BAR2 and supports only WDS, RDS and SQS for now.
@@ -69,6 +70,7 @@
 #include "qemu/cutils.h"
 #include "trace.h"
 #include "nvme.h"
+#include "nvme-ns.h"
 
 #define NVME_MAX_IOQPAIRS 0xffff
 #define NVME_DB_SIZE  4
@@ -155,6 +157,11 @@ static int nvme_addr_read(NvmeCtrl *n, hwaddr addr, void *buf, int size)
     return pci_dma_read(&n->parent_obj, addr, buf, size);
 }
 
+static bool nvme_nsid_valid(NvmeCtrl *n, uint32_t nsid)
+{
+    return nsid && (nsid == NVME_NSID_BROADCAST || nsid <= n->num_namespaces);
+}
+
 static int nvme_check_sqid(NvmeCtrl *n, uint16_t sqid)
 {
     return sqid < n->params.max_ioqpairs + 1 && n->sq[sqid] != NULL ? 0 : -1;
@@ -878,9 +885,9 @@ static inline uint16_t nvme_check_bounds(NvmeCtrl *n, NvmeNamespace *ns,
 static void nvme_rw_cb(void *opaque, int ret)
 {
     NvmeRequest *req = opaque;
-    NvmeCtrl *n = nvme_ctrl(req);
+    NvmeNamespace *ns = req->ns;
 
-    BlockBackend *blk = n->conf.blk;
+    BlockBackend *blk = ns->blkconf.blk;
     BlockAcctCookie *acct = &req->acct;
     BlockAcctStats *stats = blk_get_stats(blk);
 
@@ -980,7 +987,8 @@ static uint16_t nvme_do_aio(BlockBackend *blk, int64_t offset, size_t len,
 
 static uint16_t nvme_flush(NvmeCtrl *n, NvmeRequest *req)
 {
-    return nvme_do_aio(n->conf.blk, 0, 0, req);
+    NvmeNamespace *ns = req->ns;
+    return nvme_do_aio(ns->blkconf.blk, 0, 0, req);
 }
 
 static uint16_t nvme_write_zeroes(NvmeCtrl *n, NvmeRequest *req)
@@ -993,7 +1001,7 @@ static uint16_t nvme_write_zeroes(NvmeCtrl *n, NvmeRequest *req)
     uint32_t count = nvme_l2b(ns, nlb);
     uint16_t status;
 
-    trace_pci_nvme_write_zeroes(nvme_cid(req), slba, nlb);
+    trace_pci_nvme_write_zeroes(nvme_cid(req), nvme_nsid(ns), slba, nlb);
 
     status = nvme_check_bounds(n, ns, slba, nlb);
     if (status) {
@@ -1001,7 +1009,7 @@ static uint16_t nvme_write_zeroes(NvmeCtrl *n, NvmeRequest *req)
         return status;
     }
 
-    return nvme_do_aio(n->conf.blk, offset, count, req);
+    return nvme_do_aio(ns->blkconf.blk, offset, count, req);
 }
 
 static uint16_t nvme_rw(NvmeCtrl *n, NvmeRequest *req)
@@ -1017,8 +1025,8 @@ static uint16_t nvme_rw(NvmeCtrl *n, NvmeRequest *req)
         BLOCK_ACCT_WRITE : BLOCK_ACCT_READ;
     uint16_t status;
 
-    trace_pci_nvme_rw(nvme_cid(req), nvme_io_opc_str(rw->opcode), nlb,
-                      data_size, slba);
+    trace_pci_nvme_rw(nvme_cid(req), nvme_io_opc_str(rw->opcode),
+                      nvme_nsid(ns), nlb, data_size, slba);
 
     status = nvme_check_mdts(n, data_size);
     if (status) {
@@ -1037,10 +1045,10 @@ static uint16_t nvme_rw(NvmeCtrl *n, NvmeRequest *req)
         goto invalid;
     }
 
-    return nvme_do_aio(n->conf.blk, data_offset, data_size, req);
+    return nvme_do_aio(ns->blkconf.blk, data_offset, data_size, req);
 
 invalid:
-    block_acct_invalid(blk_get_stats(n->conf.blk), acct);
+    block_acct_invalid(blk_get_stats(ns->blkconf.blk), acct);
     return status;
 }
 
@@ -1051,12 +1059,15 @@ static uint16_t nvme_io_cmd(NvmeCtrl *n, NvmeRequest *req)
     trace_pci_nvme_io_cmd(nvme_cid(req), nsid, nvme_sqid(req),
                           req->cmd.opcode, nvme_io_opc_str(req->cmd.opcode));
 
-    if (unlikely(nsid == 0 || nsid > n->num_namespaces)) {
-        trace_pci_nvme_err_invalid_ns(nsid, n->num_namespaces);
+    if (!nvme_nsid_valid(n, nsid)) {
         return NVME_INVALID_NSID | NVME_DNR;
     }
 
-    req->ns = &n->namespaces[nsid - 1];
+    req->ns = nvme_ns(n, nsid);
+    if (unlikely(!req->ns)) {
+        return NVME_INVALID_FIELD | NVME_DNR;
+    }
+
     switch (req->cmd.opcode) {
     case NVME_CMD_FLUSH:
         return nvme_flush(n, req);
@@ -1196,18 +1207,24 @@ static uint16_t nvme_smart_info(NvmeCtrl *n, uint8_t rae, uint32_t buf_len,
     uint64_t units_read = 0, units_written = 0;
     uint64_t read_commands = 0, write_commands = 0;
     NvmeSmartLog smart;
-    BlockAcctStats *s;
 
     if (nsid && nsid != 0xffffffff) {
         return NVME_INVALID_FIELD | NVME_DNR;
     }
 
-    s = blk_get_stats(n->conf.blk);
+    for (int i = 1; i <= n->num_namespaces; i++) {
+        NvmeNamespace *ns = nvme_ns(n, i);
+        if (!ns) {
+            continue;
+        }
 
-    units_read = s->nr_bytes[BLOCK_ACCT_READ] >> BDRV_SECTOR_BITS;
-    units_written = s->nr_bytes[BLOCK_ACCT_WRITE] >> BDRV_SECTOR_BITS;
-    read_commands = s->nr_ops[BLOCK_ACCT_READ];
-    write_commands = s->nr_ops[BLOCK_ACCT_WRITE];
+        BlockAcctStats *s = blk_get_stats(ns->blkconf.blk);
+
+        units_read += s->nr_bytes[BLOCK_ACCT_READ] >> BDRV_SECTOR_BITS;
+        units_written += s->nr_bytes[BLOCK_ACCT_WRITE] >> BDRV_SECTOR_BITS;
+        read_commands += s->nr_ops[BLOCK_ACCT_READ];
+        write_commands += s->nr_ops[BLOCK_ACCT_WRITE];
+    }
 
     if (off > sizeof(smart)) {
         return NVME_INVALID_FIELD | NVME_DNR;
@@ -1451,18 +1468,23 @@ static uint16_t nvme_identify_ns(NvmeCtrl *n, NvmeRequest *req)
 {
     NvmeNamespace *ns;
     NvmeIdentify *c = (NvmeIdentify *)&req->cmd;
+    NvmeIdNs *id_ns, inactive = { 0 };
     uint32_t nsid = le32_to_cpu(c->nsid);
 
     trace_pci_nvme_identify_ns(nsid);
 
-    if (unlikely(nsid == 0 || nsid > n->num_namespaces)) {
-        trace_pci_nvme_err_invalid_ns(nsid, n->num_namespaces);
+    if (!nvme_nsid_valid(n, nsid) || nsid == NVME_NSID_BROADCAST) {
         return NVME_INVALID_NSID | NVME_DNR;
     }
 
-    ns = &n->namespaces[nsid - 1];
+    ns = nvme_ns(n, nsid);
+    if (unlikely(!ns)) {
+        id_ns = &inactive;
+    } else {
+        id_ns = &ns->id_ns;
+    }
 
-    return nvme_dma(n, (uint8_t *)&ns->id_ns, sizeof(ns->id_ns),
+    return nvme_dma(n, (uint8_t *)id_ns, sizeof(NvmeIdNs),
                     DMA_DIRECTION_FROM_DEVICE, req);
 }
 
@@ -1489,7 +1511,7 @@ static uint16_t nvme_identify_nslist(NvmeCtrl *n, NvmeRequest *req)
 
     list = g_malloc0(data_len);
     for (int i = 1; i <= n->num_namespaces; i++) {
-        if (i <= min_nsid) {
+        if (i <= min_nsid || !nvme_ns(n, i)) {
             continue;
         }
         list[j++] = cpu_to_le32(i);
@@ -1507,7 +1529,6 @@ static uint16_t nvme_identify_ns_descr_list(NvmeCtrl *n, NvmeRequest *req)
 {
     NvmeIdentify *c = (NvmeIdentify *)&req->cmd;
     uint32_t nsid = le32_to_cpu(c->nsid);
-
     uint8_t list[NVME_IDENTIFY_DATA_SIZE];
 
     struct data {
@@ -1521,11 +1542,14 @@ static uint16_t nvme_identify_ns_descr_list(NvmeCtrl *n, NvmeRequest *req)
 
     trace_pci_nvme_identify_ns_descr_list(nsid);
 
-    if (unlikely(nsid == 0 || nsid > n->num_namespaces)) {
-        trace_pci_nvme_err_invalid_ns(nsid, n->num_namespaces);
+    if (!nvme_nsid_valid(n, nsid) || nsid == NVME_NSID_BROADCAST) {
         return NVME_INVALID_NSID | NVME_DNR;
     }
 
+    if (unlikely(!nvme_ns(n, nsid))) {
+        return NVME_INVALID_FIELD | NVME_DNR;
+    }
+
     memset(list, 0x0, sizeof(list));
 
     /*
@@ -1643,7 +1667,7 @@ static uint16_t nvme_get_feature(NvmeCtrl *n, NvmeRequest *req)
     }
 
     if (nvme_feature_cap[fid] & NVME_FEAT_CAP_NS) {
-        if (!nsid || nsid > n->num_namespaces) {
+        if (!nvme_nsid_valid(n, nsid) || nsid == NVME_NSID_BROADCAST) {
             /*
              * The Reservation Notification Mask and Reservation Persistence
              * features require a status code of Invalid Field in Command when
@@ -1653,6 +1677,10 @@ static uint16_t nvme_get_feature(NvmeCtrl *n, NvmeRequest *req)
              */
             return NVME_INVALID_NSID | NVME_DNR;
         }
+
+        if (!nvme_ns(n, nsid)) {
+            return NVME_INVALID_FIELD | NVME_DNR;
+        }
     }
 
     switch (sel) {
@@ -1690,7 +1718,7 @@ static uint16_t nvme_get_feature(NvmeCtrl *n, NvmeRequest *req)
 
         return NVME_INVALID_FIELD | NVME_DNR;
     case NVME_VOLATILE_WRITE_CACHE:
-        result = blk_enable_write_cache(n->conf.blk);
+        result = n->features.vwc;
         trace_pci_nvme_getfeat_vwcache(result ? "enabled" : "disabled");
         goto out;
     case NVME_ASYNCHRONOUS_EVENT_CONF:
@@ -1761,6 +1789,8 @@ static uint16_t nvme_set_feature_timestamp(NvmeCtrl *n, NvmeRequest *req)
 
 static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeRequest *req)
 {
+    NvmeNamespace *ns;
+
     NvmeCmd *cmd = &req->cmd;
     uint32_t dw10 = le32_to_cpu(cmd->cdw10);
     uint32_t dw11 = le32_to_cpu(cmd->cdw11);
@@ -1779,12 +1809,18 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeRequest *req)
     }
 
     if (nvme_feature_cap[fid] & NVME_FEAT_CAP_NS) {
-        if (!nsid || (nsid != NVME_NSID_BROADCAST &&
-                      nsid > n->num_namespaces)) {
-            return NVME_INVALID_NSID | NVME_DNR;
+        if (nsid != NVME_NSID_BROADCAST) {
+            if (!nvme_nsid_valid(n, nsid)) {
+                return NVME_INVALID_NSID | NVME_DNR;
+            }
+
+            ns = nvme_ns(n, nsid);
+            if (unlikely(!ns)) {
+                return NVME_INVALID_FIELD | NVME_DNR;
+            }
         }
     } else if (nsid && nsid != NVME_NSID_BROADCAST) {
-        if (nsid > n->num_namespaces) {
+        if (!nvme_nsid_valid(n, nsid)) {
             return NVME_INVALID_NSID | NVME_DNR;
         }
 
@@ -1822,12 +1858,23 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeRequest *req)
 
         break;
     case NVME_VOLATILE_WRITE_CACHE:
-        if (!(dw11 & 0x1) && blk_enable_write_cache(n->conf.blk)) {
-            blk_flush(n->conf.blk);
+        n->features.vwc = dw11 & 0x1;
+
+        for (int i = 1; i <= n->num_namespaces; i++) {
+            ns = nvme_ns(n, i);
+            if (!ns) {
+                continue;
+            }
+
+            if (!(dw11 & 0x1) && blk_enable_write_cache(ns->blkconf.blk)) {
+                blk_flush(ns->blkconf.blk);
+            }
+
+            blk_set_enable_write_cache(ns->blkconf.blk, dw11 & 1);
         }
 
-        blk_set_enable_write_cache(n->conf.blk, dw11 & 1);
         break;
+
     case NVME_NUMBER_OF_QUEUES:
         if (n->qs_created) {
             return NVME_CMD_SEQ_ERROR | NVME_DNR;
@@ -1949,9 +1996,17 @@ static void nvme_process_sq(void *opaque)
 
 static void nvme_clear_ctrl(NvmeCtrl *n)
 {
+    NvmeNamespace *ns;
     int i;
 
-    blk_drain(n->conf.blk);
+    for (i = 1; i <= n->num_namespaces; i++) {
+        ns = nvme_ns(n, i);
+        if (!ns) {
+            continue;
+        }
+
+        nvme_ns_drain(ns);
+    }
 
     for (i = 0; i < n->params.max_ioqpairs + 1; i++) {
         if (n->sq[i] != NULL) {
@@ -1974,7 +2029,15 @@ static void nvme_clear_ctrl(NvmeCtrl *n)
     n->outstanding_aers = 0;
     n->qs_created = false;
 
-    blk_flush(n->conf.blk);
+    for (i = 1; i <= n->num_namespaces; i++) {
+        ns = nvme_ns(n, i);
+        if (!ns) {
+            continue;
+        }
+
+        nvme_ns_flush(ns);
+    }
+
     n->bar.cc = 0;
 }
 
@@ -2452,6 +2515,11 @@ static void nvme_check_constraints(NvmeCtrl *n, Error **errp)
         params->max_ioqpairs = params->num_queues - 1;
     }
 
+    if (n->conf.blk) {
+        warn_report("drive property is deprecated; "
+                    "please use an nvme-ns device instead");
+    }
+
     if (params->max_ioqpairs < 1 ||
         params->max_ioqpairs > NVME_MAX_IOQPAIRS) {
         error_setg(errp, "max_ioqpairs must be between 1 and %d",
@@ -2466,11 +2534,6 @@ static void nvme_check_constraints(NvmeCtrl *n, Error **errp)
         return;
     }
 
-    if (!n->conf.blk) {
-        error_setg(errp, "drive property not set");
-        return;
-    }
-
     if (!params->serial) {
         error_setg(errp, "serial property not set");
         return;
@@ -2494,11 +2557,10 @@ static void nvme_check_constraints(NvmeCtrl *n, Error **errp)
 
 static void nvme_init_state(NvmeCtrl *n)
 {
-    n->num_namespaces = 1;
+    n->num_namespaces = NVME_MAX_NAMESPACES;
     /* add one to max_ioqpairs to account for the admin queue pair */
     n->reg_size = pow2ceil(sizeof(NvmeBar) +
                            2 * (n->params.max_ioqpairs + 1) * NVME_DB_SIZE);
-    n->namespaces = g_new0(NvmeNamespace, n->num_namespaces);
     n->sq = g_new0(NvmeSQueue *, n->params.max_ioqpairs + 1);
     n->cq = g_new0(NvmeCQueue *, n->params.max_ioqpairs + 1);
     n->temperature = NVME_TEMPERATURE;
@@ -2507,34 +2569,41 @@ static void nvme_init_state(NvmeCtrl *n)
     n->aer_reqs = g_new0(NvmeRequest *, n->params.aerl + 1);
 }
 
-static void nvme_init_blk(NvmeCtrl *n, Error **errp)
+int nvme_register_namespace(NvmeCtrl *n, NvmeNamespace *ns, Error **errp)
 {
-    if (!blkconf_blocksizes(&n->conf, errp)) {
-        return;
-    }
-    blkconf_apply_backend_options(&n->conf, blk_is_read_only(n->conf.blk),
-                                  false, errp);
-}
+    uint32_t nsid = nvme_nsid(ns);
 
-static void nvme_init_namespace(NvmeCtrl *n, NvmeNamespace *ns, Error **errp)
-{
-    int64_t bs_size;
-    NvmeIdNs *id_ns = &ns->id_ns;
-
-    bs_size = blk_getlength(n->conf.blk);
-    if (bs_size < 0) {
-        error_setg_errno(errp, -bs_size, "could not get backing file size");
-        return;
+    if (nsid > NVME_MAX_NAMESPACES) {
+        error_setg(errp, "invalid namespace id (must be between 0 and %d)",
+                   NVME_MAX_NAMESPACES);
+        return -1;
     }
 
-    n->ns_size = bs_size;
+    if (!nsid) {
+        for (int i = 1; i <= n->num_namespaces; i++) {
+            NvmeNamespace *ns = nvme_ns(n, i);
+            if (!ns) {
+                nsid = i;
+                break;
+            }
+        }
 
-    id_ns->lbaf[0].ds = BDRV_SECTOR_BITS;
-    id_ns->nsze = cpu_to_le64(nvme_ns_nlbas(n, ns));
+        if (!nsid) {
+            error_setg(errp, "no free namespace id");
+            return -1;
+        }
+    } else {
+        if (n->namespaces[nsid - 1]) {
+            error_setg(errp, "namespace id '%d' is already in use", nsid);
+            return -1;
+        }
+    }
 
-    /* no thin provisioning */
-    id_ns->ncap = id_ns->nsze;
-    id_ns->nuse = id_ns->ncap;
+    trace_pci_nvme_register_namespace(nsid);
+
+    n->namespaces[nsid - 1] = ns;
+
+    return 0;
 }
 
 static void nvme_init_cmb(NvmeCtrl *n, PCIDevice *pci_dev)
@@ -2676,6 +2745,8 @@ static void nvme_init_ctrl(NvmeCtrl *n, PCIDevice *pci_dev)
     id->nn = cpu_to_le32(n->num_namespaces);
     id->oncs = cpu_to_le16(NVME_ONCS_WRITE_ZEROES | NVME_ONCS_TIMESTAMP |
                            NVME_ONCS_FEATURES);
+
+    id->vwc = 0x1;
     id->sgls = cpu_to_le32(NVME_CTRL_SGLS_SUPPORT_NO_ALIGN |
                            NVME_CTRL_SGLS_BITBUCKET);
 
@@ -2686,9 +2757,6 @@ static void nvme_init_ctrl(NvmeCtrl *n, PCIDevice *pci_dev)
     id->psd[0].mp = cpu_to_le16(0x9c4);
     id->psd[0].enlat = cpu_to_le32(0x10);
     id->psd[0].exlat = cpu_to_le32(0x4);
-    if (blk_enable_write_cache(n->conf.blk)) {
-        id->vwc = 1;
-    }
 
     n->bar.cap = 0;
     NVME_CAP_SET_MQES(n->bar.cap, 0x7ff);
@@ -2704,23 +2772,19 @@ static void nvme_init_ctrl(NvmeCtrl *n, PCIDevice *pci_dev)
 static void nvme_realize(PCIDevice *pci_dev, Error **errp)
 {
     NvmeCtrl *n = NVME(pci_dev);
+    NvmeNamespace *ns;
     Error *local_err = NULL;
 
-    int i;
-
     nvme_check_constraints(n, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
         return;
     }
 
-    nvme_init_state(n);
-    nvme_init_blk(n, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
-        return;
-    }
+    qbus_create_inplace(&n->bus, sizeof(NvmeBus), TYPE_NVME_BUS,
+                        &pci_dev->qdev, n->parent_obj.qdev.id);
 
+    nvme_init_state(n);
     nvme_init_pci(n, pci_dev, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
@@ -2729,10 +2793,12 @@ static void nvme_realize(PCIDevice *pci_dev, Error **errp)
 
     nvme_init_ctrl(n, pci_dev);
 
-    for (i = 0; i < n->num_namespaces; i++) {
-        nvme_init_namespace(n, &n->namespaces[i], &local_err);
-        if (local_err) {
-            error_propagate(errp, local_err);
+    /* setup a namespace if the controller drive property was given */
+    if (n->namespace.blkconf.blk) {
+        ns = &n->namespace;
+        ns->params.nsid = 1;
+
+        if (nvme_ns_setup(n, ns, errp)) {
             return;
         }
     }
@@ -2759,7 +2825,7 @@ static void nvme_exit(PCIDevice *pci_dev)
 }
 
 static Property nvme_props[] = {
-    DEFINE_BLOCK_PROPERTIES(NvmeCtrl, conf),
+    DEFINE_BLOCK_PROPERTIES(NvmeCtrl, namespace.blkconf),
     DEFINE_PROP_LINK("pmrdev", NvmeCtrl, pmrdev, TYPE_MEMORY_BACKEND,
                      HostMemoryBackend *),
     DEFINE_PROP_STRING("serial", NvmeCtrl, params.serial),
@@ -2800,26 +2866,35 @@ static void nvme_instance_init(Object *obj)
 {
     NvmeCtrl *s = NVME(obj);
 
-    device_add_bootindex_property(obj, &s->conf.bootindex,
-                                  "bootindex", "/namespace@1,0",
-                                  DEVICE(obj));
+    if (s->namespace.blkconf.blk) {
+        device_add_bootindex_property(obj, &s->namespace.blkconf.bootindex,
+                                      "bootindex", "/namespace@1,0",
+                                      DEVICE(obj));
+    }
 }
 
 static const TypeInfo nvme_info = {
     .name          = TYPE_NVME,
     .parent        = TYPE_PCI_DEVICE,
     .instance_size = sizeof(NvmeCtrl),
-    .class_init    = nvme_class_init,
     .instance_init = nvme_instance_init,
+    .class_init    = nvme_class_init,
     .interfaces = (InterfaceInfo[]) {
         { INTERFACE_PCIE_DEVICE },
         { }
     },
 };
 
+static const TypeInfo nvme_bus_info = {
+    .name = TYPE_NVME_BUS,
+    .parent = TYPE_BUS,
+    .instance_size = sizeof(NvmeBus),
+};
+
 static void nvme_register_types(void)
 {
     type_register_static(&nvme_info);
+    type_register_static(&nvme_bus_info);
 }
 
 type_init(nvme_register_types)
diff --git a/hw/block/meson.build b/hw/block/meson.build
index 78cad8f7cba1..602ca6c8541d 100644
--- a/hw/block/meson.build
+++ b/hw/block/meson.build
@@ -13,7 +13,7 @@ softmmu_ss.add(when: 'CONFIG_SSI_M25P80', if_true: files('m25p80.c'))
 softmmu_ss.add(when: 'CONFIG_SWIM', if_true: files('swim.c'))
 softmmu_ss.add(when: 'CONFIG_XEN', if_true: files('xen-block.c'))
 softmmu_ss.add(when: 'CONFIG_SH4', if_true: files('tc58128.c'))
-softmmu_ss.add(when: 'CONFIG_NVME_PCI', if_true: files('nvme.c'))
+softmmu_ss.add(when: 'CONFIG_NVME_PCI', if_true: files('nvme.c', 'nvme-ns.c'))
 
 specific_ss.add(when: 'CONFIG_VIRTIO_BLK', if_true: files('virtio-blk.c'))
 specific_ss.add(when: 'CONFIG_VHOST_USER_BLK', if_true: files('vhost-user-blk.c'))
diff --git a/hw/block/trace-events b/hw/block/trace-events
index 22ea6351441e..446cca08e9ab 100644
--- a/hw/block/trace-events
+++ b/hw/block/trace-events
@@ -29,6 +29,7 @@ hd_geometry_guess(void *blk, uint32_t cyls, uint32_t heads, uint32_t secs, int t
 
 # nvme.c
 # nvme traces for successful events
+pci_nvme_register_namespace(uint32_t nsid) "nsid %"PRIu32""
 pci_nvme_irq_msix(uint32_t vector) "raising MSI-X IRQ vector %u"
 pci_nvme_irq_pin(void) "pulsing IRQ pin"
 pci_nvme_irq_masked(void) "IRQ is masked"
@@ -39,9 +40,9 @@ pci_nvme_map_prp(uint64_t trans_len, uint32_t len, uint64_t prp1, uint64_t prp2,
 pci_nvme_map_sgl(uint16_t cid, uint8_t typ, uint64_t len) "cid %"PRIu16" type 0x%"PRIx8" len %"PRIu64""
 pci_nvme_io_cmd(uint16_t cid, uint32_t nsid, uint16_t sqid, uint8_t opcode, const char *opname) "cid %"PRIu16" nsid %"PRIu32" sqid %"PRIu16" opc 0x%"PRIx8" opname '%s'"
 pci_nvme_admin_cmd(uint16_t cid, uint16_t sqid, uint8_t opcode, const char *opname) "cid %"PRIu16" sqid %"PRIu16" opc 0x%"PRIx8" opname '%s'"
-pci_nvme_rw(uint16_t cid, const char *verb, uint32_t nlb, uint64_t count, uint64_t lba) "cid %"PRIu16" '%s' nlb %"PRIu32" count %"PRIu64" lba 0x%"PRIx64""
+pci_nvme_rw(uint16_t cid, const char *verb, uint32_t nsid, uint32_t nlb, uint64_t count, uint64_t lba) "cid %"PRIu16" opname '%s' nsid %"PRIu32" nlb %"PRIu32" count %"PRIu64" lba 0x%"PRIx64""
 pci_nvme_rw_cb(uint16_t cid, const char *blkname) "cid %"PRIu16" blk '%s'"
-pci_nvme_write_zeroes(uint16_t cid, uint64_t slba, uint32_t nlb) "cid %"PRIu16" slba %"PRIu64" nlb %"PRIu32""
+pci_nvme_write_zeroes(uint16_t cid, uint32_t nsid, uint64_t slba, uint32_t nlb) "cid %"PRIu16" nsid %"PRIu32" slba %"PRIu64" nlb %"PRIu32""
 pci_nvme_do_aio(uint16_t cid, uint8_t opc, const char *opname, const char *blkname, int64_t offset, size_t len) "cid %"PRIu16" opc 0x%"PRIx8" opname '%s' blk '%s' offset %"PRId64" len %zu"
 pci_nvme_create_sq(uint64_t addr, uint16_t sqid, uint16_t cqid, uint16_t qsize, uint16_t qflags) "create submission queue, addr=0x%"PRIx64", sqid=%"PRIu16", cqid=%"PRIu16", qsize=%"PRIu16", qflags=%"PRIu16""
 pci_nvme_create_cq(uint64_t addr, uint16_t cqid, uint16_t vector, uint16_t size, uint16_t qflags, int ien) "create completion queue, addr=0x%"PRIx64", cqid=%"PRIu16", vector=%"PRIu16", qsize=%"PRIu16", qflags=%"PRIu16", ien=%d"
@@ -100,7 +101,6 @@ pci_nvme_err_invalid_prplist_ent(uint64_t prplist) "PRP list entry is null or no
 pci_nvme_err_invalid_prp2_align(uint64_t prp2) "PRP2 is not page aligned: 0x%"PRIx64""
 pci_nvme_err_invalid_prp2_missing(void) "PRP2 is null and more data to be transferred"
 pci_nvme_err_invalid_prp(void) "invalid PRP"
-pci_nvme_err_invalid_ns(uint32_t ns, uint32_t limit) "invalid namespace %u not within 1-%u"
 pci_nvme_err_invalid_opc(uint8_t opc) "invalid opcode 0x%"PRIx8""
 pci_nvme_err_invalid_admin_opc(uint8_t opc) "invalid admin opcode 0x%"PRIx8""
 pci_nvme_err_invalid_lba_range(uint64_t start, uint64_t len, uint64_t limit) "Invalid LBA start=%"PRIu64" len=%"PRIu64" limit=%"PRIu64""
-- 
2.28.0


