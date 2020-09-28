Return-Path: <SRS0=Z1O7=DF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A6F1C4346E
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 02:45:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B340E22207
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 02:45:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="nX48aA1g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B340E22207
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55768 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMjA5-0008H4-Pr
	for qemu-devel@archiver.kernel.org; Sun, 27 Sep 2020 22:45:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46470)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=5334b480d=dmitry.fomichev@wdc.com>)
 id 1kMj1I-00074v-MZ; Sun, 27 Sep 2020 22:36:04 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:21619)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=5334b480d=dmitry.fomichev@wdc.com>)
 id 1kMj1D-0003Li-Ps; Sun, 27 Sep 2020 22:36:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1601260559; x=1632796559;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=NswH0YmaXPJb7y5Cllz+WVpmTIjykRa54e00djU4VSU=;
 b=nX48aA1gAC+d2LHCLYbCwX8fTfxH6RLeAl2qQWSmHK+A8XZ9d6PN/tO3
 IaCDf0in7JrKyu8xeA/QyblTCFTZvyjdQDInVwbLuYhGdT3+nLW/1Ego2
 TLYwZ+T2sxvRWrdov49dQZnqVQXbrRVz5glGCkYSAszu5SXICrRBB1VMq
 Os82/X1c73NXr36VEMx7OdFTy9sgdcQdfCBeat8cV0bicQYEWnU7OgsRT
 MSGYfioUY8dArjMKDBI3Q6mIlMg/k8mkCNRGXZqzwx26W6nB34ZAJYKI8
 Q5yrpXyQue2c5gM9yNJbxX4r7WUywXlqdD9ZlRFaBR0XrUHgmA3hTNMxF w==;
IronPort-SDR: S+zqGQYDwP7JfH/l/KYX9VO1+eRQeXiYEnP39EZNDYvwiWGy+UcDOHIY5g0wtTTp2mhsV+coAV
 6kg0g1tLd2W0aC1oMAo/S6pjjC1WzinJF464aE6TlW/Lt8kf+pdc0U1J09rnF+FiTtYe9+KXFx
 q7gelWsRKqaKKR4hSxlz16FJETgl0BDb7Hwh/V78ETsOgirLhs0zUmie9jThjBId8Kk3I7w8E9
 ga4YZ2HuRLVWsoBxcBH6bMZ67tVgOZEHNuBNilYWkBymrMa/i6eKAdTkxq9+ZaqkXnudqN6ed5
 Lqo=
X-IronPort-AV: E=Sophos;i="5.77,312,1596470400"; d="scan'208";a="258125246"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 28 Sep 2020 10:35:54 +0800
IronPort-SDR: jUPqLGmLFiziexB37yHXvhOgueRJYm4gLmkbBTnPu4pdm1AArpSolxn5+NRS4VYWdF94g52nAT
 8euqLAF23+BQ==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Sep 2020 19:22:50 -0700
IronPort-SDR: wtMtUuZ9xSPhZbMkrLXvg1aTvsSJHOjsunc0/ecFjxLe1zL9pzt+lDwDLKVkHkBt1QFrXzg9Zg
 B8qOXsXLzsTw==
WDCIronportException: Internal
Received: from unknown (HELO redsun50.ssa.fujisawa.hgst.com) ([10.149.66.24])
 by uls-op-cesaip02.wdc.com with ESMTP; 27 Sep 2020 19:35:52 -0700
From: Dmitry Fomichev <dmitry.fomichev@wdc.com>
To: Keith Busch <kbusch@kernel.org>, Klaus Jensen <k.jensen@samsung.com>,
 Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Maxim Levitsky <mlevitsk@redhat.com>, Fam Zheng <fam@euphon.net>
Subject: [PATCH v5 09/14] hw/block/nvme: Support Zoned Namespace Command Set
Date: Mon, 28 Sep 2020 11:35:23 +0900
Message-Id: <20200928023528.15260-10-dmitry.fomichev@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200928023528.15260-1-dmitry.fomichev@wdc.com>
References: <20200928023528.15260-1-dmitry.fomichev@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=68.232.141.245;
 envelope-from=prvs=5334b480d=dmitry.fomichev@wdc.com; helo=esa1.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/27 22:35:35
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
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
Cc: Niklas Cassel <niklas.cassel@wdc.com>,
 Damien Le Moal <damien.lemoal@wdc.com>, qemu-block@nongnu.org,
 Dmitry Fomichev <dmitry.fomichev@wdc.com>, qemu-devel@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>,
 Matias Bjorling <matias.bjorling@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The emulation code has been changed to advertise NVM Command Set when
"zoned" device property is not set (default) and Zoned Namespace
Command Set otherwise.

Handlers for three new NVMe commands introduced in Zoned Namespace
Command Set specification are added, namely for Zone Management
Receive, Zone Management Send and Zone Append.

Device initialization code has been extended to create a proper
configuration for zoned operation using device properties.

Read/Write command handler is modified to only allow writes at the
write pointer if the namespace is zoned. For Zone Append command,
writes implicitly happen at the write pointer and the starting write
pointer value is returned as the result of the command. Write Zeroes
handler is modified to add zoned checks that are identical to those
done as a part of Write flow.

The code to support for Zone Descriptor Extensions is not included in
this commit and ZDES 0 is always reported. A later commit in this
series will add ZDE support.

This commit doesn't yet include checks for active and open zone
limits. It is assumed that there are no limits on either active or
open zones.

Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
Signed-off-by: Hans Holmberg <hans.holmberg@wdc.com>
Signed-off-by: Ajay Joshi <ajay.joshi@wdc.com>
Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Signed-off-by: Matias Bjorling <matias.bjorling@wdc.com>
Signed-off-by: Aravind Ramesh <aravind.ramesh@wdc.com>
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Signed-off-by: Adam Manzanares <adam.manzanares@wdc.com>
Signed-off-by: Dmitry Fomichev <dmitry.fomichev@wdc.com>
---
 block/nvme.c         |   2 +-
 hw/block/nvme-ns.c   | 185 ++++++++-
 hw/block/nvme-ns.h   |   6 +-
 hw/block/nvme.c      | 872 +++++++++++++++++++++++++++++++++++++++++--
 include/block/nvme.h |   6 +-
 5 files changed, 1033 insertions(+), 38 deletions(-)

diff --git a/block/nvme.c b/block/nvme.c
index 05485fdd11..7a513c9a17 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -333,7 +333,7 @@ static inline int nvme_translate_error(const NvmeCqe *c)
 {
     uint16_t status = (le16_to_cpu(c->status) >> 1) & 0xFF;
     if (status) {
-        trace_nvme_error(le32_to_cpu(c->result),
+        trace_nvme_error(le32_to_cpu(c->result32),
                          le16_to_cpu(c->sq_head),
                          le16_to_cpu(c->sq_id),
                          le16_to_cpu(c->cid),
diff --git a/hw/block/nvme-ns.c b/hw/block/nvme-ns.c
index 31b7f986c3..6d9dc9205b 100644
--- a/hw/block/nvme-ns.c
+++ b/hw/block/nvme-ns.c
@@ -33,14 +33,14 @@ static void nvme_ns_init(NvmeNamespace *ns)
     NvmeIdNs *id_ns = &ns->id_ns;
 
     if (blk_get_flags(ns->blkconf.blk) & BDRV_O_UNMAP) {
-        ns->id_ns.dlfeat = 0x9;
+        ns->id_ns.dlfeat = 0x8;
     }
 
     id_ns->lbaf[0].ds = BDRV_SECTOR_BITS;
 
     id_ns->nsze = cpu_to_le64(nvme_ns_nlbas(ns));
 
-    ns->params.csi = NVME_CSI_NVM;
+    ns->csi = NVME_CSI_NVM;
     qemu_uuid_generate(&ns->params.uuid); /* TODO make UUIDs persistent */
 
     /* no thin provisioning */
@@ -73,7 +73,162 @@ static int nvme_ns_init_blk(NvmeCtrl *n, NvmeNamespace *ns, Error **errp)
     }
 
     lba_index = NVME_ID_NS_FLBAS_INDEX(ns->id_ns.flbas);
-    ns->id_ns.lbaf[lba_index].ds = 31 - clz32(n->conf.logical_block_size);
+    ns->id_ns.lbaf[lba_index].ds = 31 - clz32(ns->blkconf.logical_block_size);
+
+    return 0;
+}
+
+/*
+ * Add a zone to the tail of a zone list.
+ */
+void nvme_add_zone_tail(NvmeNamespace *ns, NvmeZoneList *zl, NvmeZone *zone)
+{
+    uint32_t idx = (uint32_t)(zone - ns->zone_array);
+
+    assert(nvme_zone_not_in_list(zone));
+
+    if (!zl->size) {
+        zl->head = zl->tail = idx;
+        zone->next = zone->prev = NVME_ZONE_LIST_NIL;
+    } else {
+        ns->zone_array[zl->tail].next = idx;
+        zone->prev = zl->tail;
+        zone->next = NVME_ZONE_LIST_NIL;
+        zl->tail = idx;
+    }
+    zl->size++;
+}
+
+/*
+ * Remove a zone from a zone list. The zone must be linked in the list.
+ */
+void nvme_remove_zone(NvmeNamespace *ns, NvmeZoneList *zl, NvmeZone *zone)
+{
+    uint32_t idx = (uint32_t)(zone - ns->zone_array);
+
+    assert(!nvme_zone_not_in_list(zone));
+
+    --zl->size;
+    if (zl->size == 0) {
+        zl->head = NVME_ZONE_LIST_NIL;
+        zl->tail = NVME_ZONE_LIST_NIL;
+    } else if (idx == zl->head) {
+        zl->head = zone->next;
+        ns->zone_array[zl->head].prev = NVME_ZONE_LIST_NIL;
+    } else if (idx == zl->tail) {
+        zl->tail = zone->prev;
+        ns->zone_array[zl->tail].next = NVME_ZONE_LIST_NIL;
+    } else {
+        ns->zone_array[zone->next].prev = zone->prev;
+        ns->zone_array[zone->prev].next = zone->next;
+    }
+
+    zone->prev = zone->next = 0;
+}
+
+static int nvme_calc_zone_geometry(NvmeNamespace *ns, Error **errp)
+{
+    uint64_t zone_size, zone_cap;
+    uint32_t nz, lbasz = ns->blkconf.logical_block_size;
+
+    if (ns->params.zone_size_mb) {
+        zone_size = ns->params.zone_size_mb;
+    } else {
+        zone_size = NVME_DEFAULT_ZONE_SIZE;
+    }
+    if (ns->params.zone_capacity_mb) {
+        zone_cap = ns->params.zone_capacity_mb;
+    } else {
+        zone_cap = zone_size;
+    }
+    ns->zone_size = zone_size * MiB / lbasz;
+    ns->zone_capacity = zone_cap * MiB / lbasz;
+    if (ns->zone_capacity > ns->zone_size) {
+        error_setg(errp, "zone capacity exceeds zone size");
+        return -1;
+    }
+
+    nz = DIV_ROUND_UP(ns->size / lbasz, ns->zone_size);
+    ns->num_zones = nz;
+    ns->zone_array_size = sizeof(NvmeZone) * nz;
+    ns->zone_size_log2 = 0;
+    if (is_power_of_2(ns->zone_size)) {
+        ns->zone_size_log2 = 63 - clz64(ns->zone_size);
+    }
+
+    return 0;
+}
+
+static void nvme_init_zone_meta(NvmeNamespace *ns)
+{
+    uint64_t start = 0, zone_size = ns->zone_size;
+    uint64_t capacity = ns->num_zones * zone_size;
+    NvmeZone *zone;
+    int i;
+
+    ns->zone_array = g_malloc0(ns->zone_array_size);
+    ns->exp_open_zones = g_malloc0(sizeof(NvmeZoneList));
+    ns->imp_open_zones = g_malloc0(sizeof(NvmeZoneList));
+    ns->closed_zones = g_malloc0(sizeof(NvmeZoneList));
+    ns->full_zones = g_malloc0(sizeof(NvmeZoneList));
+
+    nvme_init_zone_list(ns->exp_open_zones);
+    nvme_init_zone_list(ns->imp_open_zones);
+    nvme_init_zone_list(ns->closed_zones);
+    nvme_init_zone_list(ns->full_zones);
+
+    zone = ns->zone_array;
+    for (i = 0; i < ns->num_zones; i++, zone++) {
+        if (start + zone_size > capacity) {
+            zone_size = capacity - start;
+        }
+        zone->d.zt = NVME_ZONE_TYPE_SEQ_WRITE;
+        nvme_set_zone_state(zone, NVME_ZONE_STATE_EMPTY);
+        zone->d.za = 0;
+        zone->d.zcap = ns->zone_capacity;
+        zone->d.zslba = start;
+        zone->d.wp = start;
+        zone->w_ptr = start;
+        zone->prev = 0;
+        zone->next = 0;
+        start += zone_size;
+    }
+}
+
+static int nvme_zoned_init_ns(NvmeCtrl *n, NvmeNamespace *ns, int lba_index,
+                              Error **errp)
+{
+    NvmeIdNsZoned *id_ns_z;
+
+    if (n->params.fill_pattern == 0) {
+        ns->id_ns.dlfeat |= 0x01;
+    } else if (n->params.fill_pattern == 0xff) {
+        ns->id_ns.dlfeat |= 0x02;
+    }
+
+    if (nvme_calc_zone_geometry(ns, errp) != 0) {
+        return -1;
+    }
+
+    nvme_init_zone_meta(ns);
+
+    id_ns_z = g_malloc0(sizeof(NvmeIdNsZoned));
+
+    /* MAR/MOR are zeroes-based, 0xffffffff means no limit */
+    id_ns_z->mar = 0xffffffff;
+    id_ns_z->mor = 0xffffffff;
+    id_ns_z->zoc = 0;
+    id_ns_z->ozcs = ns->params.cross_zone_read ? 0x01 : 0x00;
+
+    id_ns_z->lbafe[lba_index].zsze = cpu_to_le64(ns->zone_size);
+    id_ns_z->lbafe[lba_index].zdes = 0; /* FIXME make helper */
+
+    ns->csi = NVME_CSI_ZONED;
+    ns->id_ns.ncap = cpu_to_le64(ns->zone_capacity * ns->num_zones);
+    ns->id_ns.nuse = ns->id_ns.ncap;
+    ns->id_ns.nsze = ns->id_ns.ncap;
+
+    ns->id_ns_zoned = id_ns_z;
 
     return 0;
 }
@@ -103,6 +258,12 @@ int nvme_ns_setup(NvmeCtrl *n, NvmeNamespace *ns, Error **errp)
         return -1;
     }
 
+    if (ns->params.zoned) {
+        if (nvme_zoned_init_ns(n, ns, 0, errp) != 0) {
+            return -1;
+        }
+    }
+
     return 0;
 }
 
@@ -116,6 +277,16 @@ void nvme_ns_flush(NvmeNamespace *ns)
     blk_flush(ns->blkconf.blk);
 }
 
+void nvme_ns_cleanup(NvmeNamespace *ns)
+{
+    g_free(ns->id_ns_zoned);
+    g_free(ns->zone_array);
+    g_free(ns->exp_open_zones);
+    g_free(ns->imp_open_zones);
+    g_free(ns->closed_zones);
+    g_free(ns->full_zones);
+}
+
 static void nvme_ns_realize(DeviceState *dev, Error **errp)
 {
     NvmeNamespace *ns = NVME_NS(dev);
@@ -133,6 +304,14 @@ static void nvme_ns_realize(DeviceState *dev, Error **errp)
 static Property nvme_ns_props[] = {
     DEFINE_BLOCK_PROPERTIES(NvmeNamespace, blkconf),
     DEFINE_PROP_UINT32("nsid", NvmeNamespace, params.nsid, 0),
+
+    DEFINE_PROP_BOOL("zoned", NvmeNamespace, params.zoned, false),
+    DEFINE_PROP_UINT64("zone_size", NvmeNamespace, params.zone_size_mb,
+                       NVME_DEFAULT_ZONE_SIZE),
+    DEFINE_PROP_UINT64("zone_capacity", NvmeNamespace,
+                       params.zone_capacity_mb, 0),
+    DEFINE_PROP_BOOL("cross_zone_read", NvmeNamespace,
+                      params.cross_zone_read, false),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/hw/block/nvme-ns.h b/hw/block/nvme-ns.h
index 04172f083e..daa13546c4 100644
--- a/hw/block/nvme-ns.h
+++ b/hw/block/nvme-ns.h
@@ -38,7 +38,6 @@ typedef struct NvmeZoneList {
 
 typedef struct NvmeNamespaceParams {
     uint32_t nsid;
-    uint8_t  csi;
     bool     attached;
     QemuUUID uuid;
 
@@ -52,6 +51,7 @@ typedef struct NvmeNamespace {
     DeviceState  parent_obj;
     BlockConf    blkconf;
     int32_t      bootindex;
+    uint8_t      csi;
     int64_t      size;
     NvmeIdNs     id_ns;
 
@@ -107,6 +107,7 @@ typedef struct NvmeCtrl NvmeCtrl;
 int nvme_ns_setup(NvmeCtrl *n, NvmeNamespace *ns, Error **errp);
 void nvme_ns_drain(NvmeNamespace *ns);
 void nvme_ns_flush(NvmeNamespace *ns);
+void nvme_ns_cleanup(NvmeNamespace *ns);
 
 static inline uint8_t nvme_get_zone_state(NvmeZone *zone)
 {
@@ -188,4 +189,7 @@ static inline NvmeZone *nvme_next_zone_in_list(NvmeNamespace *ns, NvmeZone *z,
     return &ns->zone_array[z->next];
 }
 
+void nvme_add_zone_tail(NvmeNamespace *ns, NvmeZoneList *zl, NvmeZone *zone);
+void nvme_remove_zone(NvmeNamespace *ns, NvmeZoneList *zl, NvmeZone *zone);
+
 #endif /* NVME_NS_H */
diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 63ad03d6d6..38e25a4d1f 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -54,6 +54,7 @@
 #include "qemu/osdep.h"
 #include "qemu/units.h"
 #include "qemu/error-report.h"
+#include "crypto/random.h"
 #include "hw/block/block.h"
 #include "hw/pci/msix.h"
 #include "hw/pci/pci.h"
@@ -127,6 +128,46 @@ static uint16_t nvme_sqid(NvmeRequest *req)
     return le16_to_cpu(req->sq->sqid);
 }
 
+static void nvme_assign_zone_state(NvmeNamespace *ns, NvmeZone *zone,
+                                   uint8_t state)
+{
+    if (!nvme_zone_not_in_list(zone)) {
+        switch (nvme_get_zone_state(zone)) {
+        case NVME_ZONE_STATE_EXPLICITLY_OPEN:
+            nvme_remove_zone(ns, ns->exp_open_zones, zone);
+            break;
+        case NVME_ZONE_STATE_IMPLICITLY_OPEN:
+            nvme_remove_zone(ns, ns->imp_open_zones, zone);
+            break;
+        case NVME_ZONE_STATE_CLOSED:
+            nvme_remove_zone(ns, ns->closed_zones, zone);
+            break;
+        case NVME_ZONE_STATE_FULL:
+            nvme_remove_zone(ns, ns->full_zones, zone);
+        }
+   }
+
+    nvme_set_zone_state(zone, state);
+
+    switch (state) {
+    case NVME_ZONE_STATE_EXPLICITLY_OPEN:
+        nvme_add_zone_tail(ns, ns->exp_open_zones, zone);
+        break;
+    case NVME_ZONE_STATE_IMPLICITLY_OPEN:
+        nvme_add_zone_tail(ns, ns->imp_open_zones, zone);
+        break;
+    case NVME_ZONE_STATE_CLOSED:
+        nvme_add_zone_tail(ns, ns->closed_zones, zone);
+        break;
+    case NVME_ZONE_STATE_FULL:
+        nvme_add_zone_tail(ns, ns->full_zones, zone);
+    case NVME_ZONE_STATE_READ_ONLY:
+        break;
+    default:
+        zone->d.za = 0;
+    }
+}
+
 static bool nvme_addr_is_cmb(NvmeCtrl *n, hwaddr addr)
 {
     hwaddr low = n->ctrl_mem.addr;
@@ -813,7 +854,7 @@ static void nvme_process_aers(void *opaque)
 
         req = n->aer_reqs[n->outstanding_aers];
 
-        result = (NvmeAerResult *) &req->cqe.result;
+        result = (NvmeAerResult *) &req->cqe.result32;
         result->event_type = event->result.event_type;
         result->event_info = event->result.event_info;
         result->log_page = event->result.log_page;
@@ -882,6 +923,200 @@ static inline uint16_t nvme_check_bounds(NvmeCtrl *n, NvmeNamespace *ns,
     return NVME_SUCCESS;
 }
 
+static void nvme_fill_data(QEMUSGList *qsg, QEMUIOVector *iov, uint64_t offset,
+                           uint32_t max_len, uint8_t pattern)
+{
+    ScatterGatherEntry *entry;
+    uint32_t len, ent_len;
+
+    if (qsg->nsg > 0) {
+        entry = qsg->sg;
+        len = qsg->size;
+        if (max_len) {
+            len = MIN(len, max_len);
+        }
+        for (; len > 0; len -= ent_len) {
+            ent_len = MIN(len, entry->len);
+            if (offset > ent_len) {
+                offset -= ent_len;
+            } else if (offset != 0) {
+                dma_memory_set(qsg->as, entry->base + offset,
+                               pattern, ent_len - offset);
+                offset = 0;
+            } else {
+                dma_memory_set(qsg->as, entry->base, pattern, ent_len);
+            }
+            entry++;
+        }
+    } else if (iov->iov) {
+        len = iov_size(iov->iov, iov->niov);
+        if (max_len) {
+            len = MIN(len, max_len);
+        }
+        qemu_iovec_memset(iov, offset, pattern, len - offset);
+    }
+}
+
+static uint16_t nvme_check_zone_write(NvmeZone *zone, uint64_t slba,
+                                      uint32_t nlb)
+{
+    uint16_t status;
+
+    if (unlikely((slba + nlb) > nvme_zone_wr_boundary(zone))) {
+        return NVME_ZONE_BOUNDARY_ERROR;
+    }
+
+    switch (nvme_get_zone_state(zone)) {
+    case NVME_ZONE_STATE_EMPTY:
+    case NVME_ZONE_STATE_IMPLICITLY_OPEN:
+    case NVME_ZONE_STATE_EXPLICITLY_OPEN:
+    case NVME_ZONE_STATE_CLOSED:
+        status = NVME_SUCCESS;
+        break;
+    case NVME_ZONE_STATE_FULL:
+        status = NVME_ZONE_FULL;
+        break;
+    case NVME_ZONE_STATE_OFFLINE:
+        status = NVME_ZONE_OFFLINE;
+        break;
+    case NVME_ZONE_STATE_READ_ONLY:
+        status = NVME_ZONE_READ_ONLY;
+        break;
+    default:
+        assert(false);
+    }
+    return status;
+}
+
+static uint16_t nvme_check_zone_read(NvmeNamespace *ns, NvmeZone *zone,
+                                     uint64_t slba, uint32_t nlb)
+{
+    uint64_t lba = slba, count;
+    uint16_t status;
+    uint8_t zs;
+
+    do {
+        if (!ns->params.cross_zone_read &&
+            (lba + nlb > nvme_zone_rd_boundary(ns, zone))) {
+            return NVME_ZONE_BOUNDARY_ERROR | NVME_DNR;
+        }
+
+        zs = nvme_get_zone_state(zone);
+        switch (zs) {
+        case NVME_ZONE_STATE_EMPTY:
+        case NVME_ZONE_STATE_IMPLICITLY_OPEN:
+        case NVME_ZONE_STATE_EXPLICITLY_OPEN:
+        case NVME_ZONE_STATE_FULL:
+        case NVME_ZONE_STATE_CLOSED:
+        case NVME_ZONE_STATE_READ_ONLY:
+            status = NVME_SUCCESS;
+            break;
+        case NVME_ZONE_STATE_OFFLINE:
+            status = NVME_ZONE_OFFLINE | NVME_DNR;
+            break;
+        default:
+            assert(false);
+        }
+        if (status != NVME_SUCCESS) {
+            break;
+        }
+
+        if (lba + nlb > nvme_zone_rd_boundary(ns, zone)) {
+            count = nvme_zone_rd_boundary(ns, zone) - lba;
+        } else {
+            count = nlb;
+        }
+
+        lba += count;
+        nlb -= count;
+        zone++;
+    } while (nlb);
+
+    return status;
+}
+
+static inline uint32_t nvme_zone_idx(NvmeNamespace *ns, uint64_t slba)
+{
+    return ns->zone_size_log2 > 0 ? slba >> ns->zone_size_log2 :
+                                    slba / ns->zone_size;
+}
+
+static bool nvme_finalize_zoned_write(NvmeNamespace *ns, NvmeRequest *req,
+                                      bool failed)
+{
+    NvmeRwCmd *rw = (NvmeRwCmd *)&req->cmd;
+    NvmeZone *zone;
+    uint64_t slba, start_wp = req->cqe.result64;
+    uint32_t nlb, zone_idx;
+    uint8_t zs;
+
+    if (rw->opcode != NVME_CMD_WRITE &&
+        rw->opcode != NVME_CMD_ZONE_APPEND &&
+        rw->opcode != NVME_CMD_WRITE_ZEROES) {
+        return false;
+    }
+
+    slba = le64_to_cpu(rw->slba);
+    nlb = le16_to_cpu(rw->nlb) + 1;
+    zone_idx = nvme_zone_idx(ns, slba);
+    assert(zone_idx < ns->num_zones);
+    zone = &ns->zone_array[zone_idx];
+
+    if (!failed && zone->w_ptr < start_wp + nlb) {
+        /*
+         * A preceding queued write to the zone has failed,
+         * now this write is not at the WP, fail it too.
+         */
+        failed = true;
+    }
+
+    if (failed) {
+        if (zone->w_ptr > start_wp) {
+            zone->w_ptr = start_wp;
+        }
+        req->cqe.result64 = 0;
+    } else if (zone->w_ptr == nvme_zone_wr_boundary(zone)) {
+        zs = nvme_get_zone_state(zone);
+        switch (zs) {
+        case NVME_ZONE_STATE_IMPLICITLY_OPEN:
+        case NVME_ZONE_STATE_EXPLICITLY_OPEN:
+        case NVME_ZONE_STATE_CLOSED:
+        case NVME_ZONE_STATE_EMPTY:
+            nvme_assign_zone_state(ns, zone, NVME_ZONE_STATE_FULL);
+            /* fall through */
+        case NVME_ZONE_STATE_FULL:
+            break;
+        default:
+            assert(false);
+        }
+        zone->d.wp = zone->w_ptr;
+    } else {
+        zone->d.wp += nlb;
+    }
+
+    return failed;
+}
+
+static uint64_t nvme_advance_zone_wp(NvmeNamespace *ns, NvmeZone *zone,
+                                     uint32_t nlb)
+{
+    uint64_t result = zone->w_ptr;
+    uint8_t zs;
+
+    zone->w_ptr += nlb;
+
+    if (zone->w_ptr < nvme_zone_wr_boundary(zone)) {
+        zs = nvme_get_zone_state(zone);
+        switch (zs) {
+        case NVME_ZONE_STATE_EMPTY:
+        case NVME_ZONE_STATE_CLOSED:
+            nvme_assign_zone_state(ns, zone, NVME_ZONE_STATE_IMPLICITLY_OPEN);
+        }
+    }
+
+    return result;
+}
+
 static void nvme_rw_cb(void *opaque, int ret)
 {
     NvmeRequest *req = opaque;
@@ -896,10 +1131,27 @@ static void nvme_rw_cb(void *opaque, int ret)
     trace_pci_nvme_rw_cb(nvme_cid(req), blk_name(blk));
 
     if (!ret) {
-        block_acct_done(stats, acct);
+        if (ns->params.zoned) {
+            if (nvme_finalize_zoned_write(ns, req, false)) {
+                ret = EIO;
+                block_acct_failed(stats, acct);
+                req->status = NVME_ZONE_INVALID_WRITE;
+            } else if (req->fill_ofs >= 0) {
+                nvme_fill_data(&req->qsg, &req->iov, req->fill_ofs,
+                               req->fill_len,
+                               nvme_ctrl(req)->params.fill_pattern);
+            }
+        }
+        if (!ret) {
+            block_acct_done(stats, acct);
+        }
     } else {
         uint16_t status;
 
+        if (ns->params.zoned) {
+            nvme_finalize_zoned_write(ns, req, true);
+        }
+
         block_acct_failed(stats, acct);
 
         switch (req->cmd.opcode) {
@@ -953,6 +1205,7 @@ static uint16_t nvme_do_aio(BlockBackend *blk, int64_t offset, size_t len,
         break;
 
     case NVME_CMD_WRITE:
+    case NVME_CMD_ZONE_APPEND:
         is_write = true;
 
         /* fallthrough */
@@ -997,8 +1250,10 @@ static uint16_t nvme_write_zeroes(NvmeCtrl *n, NvmeRequest *req)
     NvmeNamespace *ns = req->ns;
     uint64_t slba = le64_to_cpu(rw->slba);
     uint32_t nlb = (uint32_t)le16_to_cpu(rw->nlb) + 1;
+    NvmeZone *zone = NULL;
     uint64_t offset = nvme_l2b(ns, slba);
     uint32_t count = nvme_l2b(ns, nlb);
+    uint32_t zone_idx;
     uint16_t status;
 
     trace_pci_nvme_write_zeroes(nvme_cid(req), nvme_nsid(ns), slba, nlb);
@@ -1009,20 +1264,43 @@ static uint16_t nvme_write_zeroes(NvmeCtrl *n, NvmeRequest *req)
         return status;
     }
 
+    if (ns->params.zoned) {
+        zone_idx = nvme_zone_idx(ns, slba);
+        assert(zone_idx < ns->num_zones);
+        zone = &ns->zone_array[zone_idx];
+
+        status = nvme_check_zone_write(zone, slba, nlb);
+        if (status != NVME_SUCCESS) {
+            trace_pci_nvme_err_zone_write_not_ok(slba, nlb, status);
+            return status | NVME_DNR;
+        }
+
+        assert(nvme_wp_is_valid(zone));
+        if (unlikely(slba != zone->w_ptr)) {
+            trace_pci_nvme_err_write_not_at_wp(slba, zone->d.zslba,
+                                               zone->w_ptr);
+            return NVME_ZONE_INVALID_WRITE | NVME_DNR;
+        }
+
+        req->cqe.result64 = nvme_advance_zone_wp(ns, zone, nlb);
+    }
+
     return nvme_do_aio(ns->blkconf.blk, offset, count, req);
 }
 
-static uint16_t nvme_rw(NvmeCtrl *n, NvmeRequest *req)
+static uint16_t nvme_rw(NvmeCtrl *n, NvmeRequest *req, bool append)
 {
     NvmeRwCmd *rw = (NvmeRwCmd *)&req->cmd;
     NvmeNamespace *ns = req->ns;
-    uint32_t nlb = (uint32_t)le16_to_cpu(rw->nlb) + 1;
+    uint32_t nlb  = le32_to_cpu(rw->nlb) + 1;
     uint64_t slba = le64_to_cpu(rw->slba);
-
     uint64_t data_size = nvme_l2b(ns, nlb);
-    uint64_t data_offset = nvme_l2b(ns, slba);
-    enum BlockAcctType acct = req->cmd.opcode == NVME_CMD_WRITE ?
-        BLOCK_ACCT_WRITE : BLOCK_ACCT_READ;
+    uint64_t data_offset;
+
+    NvmeZone *zone = NULL;
+    uint32_t zone_idx = 0;
+    bool is_write = rw->opcode == NVME_CMD_WRITE || append;
+    enum BlockAcctType acct = is_write ? BLOCK_ACCT_WRITE : BLOCK_ACCT_READ;
     uint16_t status;
 
     trace_pci_nvme_rw(nvme_cid(req), nvme_io_opc_str(rw->opcode),
@@ -1040,18 +1318,468 @@ static uint16_t nvme_rw(NvmeCtrl *n, NvmeRequest *req)
         goto invalid;
     }
 
+    if (ns->params.zoned) {
+        zone_idx = nvme_zone_idx(ns, slba);
+        assert(zone_idx < ns->num_zones);
+        zone = &ns->zone_array[zone_idx];
+
+        if (is_write) {
+            status = nvme_check_zone_write(zone, slba, nlb);
+            if (status != NVME_SUCCESS) {
+                trace_pci_nvme_err_zone_write_not_ok(slba, nlb, status);
+                goto invalid;
+            }
+
+            assert(nvme_wp_is_valid(zone));
+            if (append) {
+                if (unlikely(slba != zone->d.zslba)) {
+                    trace_pci_nvme_err_append_not_at_start(slba, zone->d.zslba);
+                    status = NVME_ZONE_INVALID_WRITE | NVME_DNR;
+                    goto invalid;
+                }
+                if (data_size > (n->page_size << n->zasl)) {
+                    trace_pci_nvme_err_append_too_large(slba, nlb, n->zasl);
+                    status = NVME_INVALID_FIELD | NVME_DNR;
+                    goto invalid;
+                }
+                slba = zone->w_ptr;
+            } else if (unlikely(slba != zone->w_ptr)) {
+                trace_pci_nvme_err_write_not_at_wp(slba, zone->d.zslba,
+                                                   zone->w_ptr);
+                status = NVME_ZONE_INVALID_WRITE | NVME_DNR;
+                goto invalid;
+            }
+            req->fill_ofs = -1LL;
+        } else {
+            status = nvme_check_zone_read(ns, zone, slba, nlb);
+            if (status != NVME_SUCCESS) {
+                trace_pci_nvme_err_zone_read_not_ok(slba, nlb, status);
+                goto invalid;
+            }
+
+            if (slba + nlb > zone->w_ptr) {
+                /*
+                 * All or some data is read above the WP. Need to
+                 * fill out the buffer area that has no backing data
+                 * with a predefined data pattern (zeros by default)
+                 */
+                if (slba >= zone->w_ptr) {
+                    req->fill_ofs = 0;
+                } else {
+                    req->fill_ofs = nvme_l2b(ns, zone->w_ptr - slba);
+                }
+                req->fill_len = nvme_l2b(ns,
+                    nvme_zone_rd_boundary(ns, zone) - slba);
+            } else {
+                req->fill_ofs = -1LL;
+            }
+        }
+    } else if (append) {
+        trace_pci_nvme_err_invalid_opc(rw->opcode);
+        status = NVME_INVALID_OPCODE | NVME_DNR;
+        goto invalid;
+    }
+
     status = nvme_map_dptr(n, data_size, req);
     if (status) {
         goto invalid;
     }
 
+    if (ns->params.zoned) {
+        if (unlikely(req->fill_ofs == 0 &&
+            slba + nlb <= nvme_zone_rd_boundary(ns, zone))) {
+            /* No backend I/O necessary, only need to fill the buffer */
+            nvme_fill_data(&req->qsg, &req->iov, 0, 0, n->params.fill_pattern);
+            req->status = NVME_SUCCESS;
+            return NVME_SUCCESS;
+        }
+        if (is_write) {
+            req->cqe.result64 = nvme_advance_zone_wp(ns, zone, nlb);
+        }
+    }
+
+    data_offset = nvme_l2b(ns, slba);
+
     return nvme_do_aio(ns->blkconf.blk, data_offset, data_size, req);
 
 invalid:
     block_acct_invalid(blk_get_stats(ns->blkconf.blk), acct);
+    return status | NVME_DNR;
+}
+
+static uint16_t nvme_get_mgmt_zone_slba_idx(NvmeNamespace *ns, NvmeCmd *c,
+                                            uint64_t *slba, uint32_t *zone_idx)
+{
+    uint32_t dw10 = le32_to_cpu(c->cdw10);
+    uint32_t dw11 = le32_to_cpu(c->cdw11);
+
+    if (!ns->params.zoned) {
+        trace_pci_nvme_err_invalid_opc(c->opcode);
+        return NVME_INVALID_OPCODE | NVME_DNR;
+    }
+
+    *slba = ((uint64_t)dw11) << 32 | dw10;
+    if (unlikely(*slba >= ns->id_ns.nsze)) {
+        trace_pci_nvme_err_invalid_lba_range(*slba, 0, ns->id_ns.nsze);
+        *slba = 0;
+        return NVME_LBA_RANGE | NVME_DNR;
+    }
+
+    *zone_idx = nvme_zone_idx(ns, *slba);
+    assert(*zone_idx < ns->num_zones);
+
+    return NVME_SUCCESS;
+}
+
+static uint16_t nvme_open_zone(NvmeNamespace *ns, NvmeZone *zone,
+                               uint8_t state)
+{
+    switch (state) {
+    case NVME_ZONE_STATE_EMPTY:
+    case NVME_ZONE_STATE_CLOSED:
+    case NVME_ZONE_STATE_IMPLICITLY_OPEN:
+        nvme_assign_zone_state(ns, zone, NVME_ZONE_STATE_EXPLICITLY_OPEN);
+        /* fall through */
+    case NVME_ZONE_STATE_EXPLICITLY_OPEN:
+        return NVME_SUCCESS;
+    }
+
+    return NVME_ZONE_INVAL_TRANSITION;
+}
+
+static bool nvme_cond_open_all(uint8_t state)
+{
+    return state == NVME_ZONE_STATE_CLOSED;
+}
+
+static uint16_t nvme_close_zone(NvmeNamespace *ns, NvmeZone *zone,
+                                uint8_t state)
+{
+    switch (state) {
+    case NVME_ZONE_STATE_EXPLICITLY_OPEN:
+    case NVME_ZONE_STATE_IMPLICITLY_OPEN:
+        nvme_assign_zone_state(ns, zone, NVME_ZONE_STATE_CLOSED);
+        /* fall through */
+    case NVME_ZONE_STATE_CLOSED:
+        return NVME_SUCCESS;
+    }
+
+    return NVME_ZONE_INVAL_TRANSITION;
+}
+
+static bool nvme_cond_close_all(uint8_t state)
+{
+    return state == NVME_ZONE_STATE_IMPLICITLY_OPEN ||
+           state == NVME_ZONE_STATE_EXPLICITLY_OPEN;
+}
+
+static uint16_t nvme_finish_zone(NvmeNamespace *ns, NvmeZone *zone,
+                                 uint8_t state)
+{
+    switch (state) {
+    case NVME_ZONE_STATE_EXPLICITLY_OPEN:
+    case NVME_ZONE_STATE_IMPLICITLY_OPEN:
+    case NVME_ZONE_STATE_CLOSED:
+    case NVME_ZONE_STATE_EMPTY:
+        zone->w_ptr = nvme_zone_wr_boundary(zone);
+        zone->d.wp = zone->w_ptr;
+        nvme_assign_zone_state(ns, zone, NVME_ZONE_STATE_FULL);
+        /* fall through */
+    case NVME_ZONE_STATE_FULL:
+        return NVME_SUCCESS;
+    }
+
+    return NVME_ZONE_INVAL_TRANSITION;
+}
+
+static bool nvme_cond_finish_all(uint8_t state)
+{
+    return state == NVME_ZONE_STATE_IMPLICITLY_OPEN ||
+           state == NVME_ZONE_STATE_EXPLICITLY_OPEN ||
+           state == NVME_ZONE_STATE_CLOSED;
+}
+
+static uint16_t nvme_reset_zone(NvmeNamespace *ns, NvmeZone *zone,
+                                uint8_t state)
+{
+    switch (state) {
+    case NVME_ZONE_STATE_EXPLICITLY_OPEN:
+    case NVME_ZONE_STATE_IMPLICITLY_OPEN:
+    case NVME_ZONE_STATE_CLOSED:
+    case NVME_ZONE_STATE_FULL:
+        zone->w_ptr = zone->d.zslba;
+        zone->d.wp = zone->w_ptr;
+        nvme_assign_zone_state(ns, zone, NVME_ZONE_STATE_EMPTY);
+        /* fall through */
+    case NVME_ZONE_STATE_EMPTY:
+        return NVME_SUCCESS;
+    }
+
+    return NVME_ZONE_INVAL_TRANSITION;
+}
+
+static bool nvme_cond_reset_all(uint8_t state)
+{
+    return state == NVME_ZONE_STATE_IMPLICITLY_OPEN ||
+           state == NVME_ZONE_STATE_EXPLICITLY_OPEN ||
+           state == NVME_ZONE_STATE_CLOSED ||
+           state == NVME_ZONE_STATE_FULL;
+}
+
+static uint16_t nvme_offline_zone(NvmeNamespace *ns, NvmeZone *zone,
+                                  uint8_t state)
+{
+    switch (state) {
+    case NVME_ZONE_STATE_READ_ONLY:
+        nvme_assign_zone_state(ns, zone, NVME_ZONE_STATE_OFFLINE);
+        /* fall through */
+    case NVME_ZONE_STATE_OFFLINE:
+        return NVME_SUCCESS;
+    }
+
+    return NVME_ZONE_INVAL_TRANSITION;
+}
+
+static bool nvme_cond_offline_all(uint8_t state)
+{
+    return state == NVME_ZONE_STATE_READ_ONLY;
+}
+
+typedef uint16_t (*op_handler_t)(NvmeNamespace *, NvmeZone *,
+                                 uint8_t);
+typedef bool (*need_to_proc_zone_t)(uint8_t);
+
+static uint16_t name_do_zone_op(NvmeNamespace *ns, NvmeZone *zone,
+                                uint8_t state, bool all,
+                                op_handler_t op_hndlr,
+                                need_to_proc_zone_t proc_zone)
+{
+    int i;
+    uint16_t status = 0;
+
+    if (!all) {
+        status = op_hndlr(ns, zone, state);
+    } else {
+        for (i = 0; i < ns->num_zones; i++, zone++) {
+            state = nvme_get_zone_state(zone);
+            if (proc_zone(state)) {
+                status = op_hndlr(ns, zone, state);
+                if (status != NVME_SUCCESS) {
+                    break;
+                }
+            }
+        }
+    }
+
     return status;
 }
 
+static uint16_t nvme_zone_mgmt_send(NvmeCtrl *n, NvmeRequest *req)
+{
+    NvmeCmd *cmd = (NvmeCmd *)&req->cmd;
+    NvmeNamespace *ns = req->ns;
+    uint32_t dw13 = le32_to_cpu(cmd->cdw13);
+    uint64_t slba = 0;
+    uint32_t zone_idx = 0;
+    uint16_t status;
+    uint8_t action, state;
+    bool all;
+    NvmeZone *zone;
+
+    action = dw13 & 0xff;
+    all = dw13 & 0x100;
+
+    req->status = NVME_SUCCESS;
+
+    if (!all) {
+        status = nvme_get_mgmt_zone_slba_idx(ns, cmd, &slba, &zone_idx);
+        if (status) {
+            return status;
+        }
+    }
+
+    zone = &ns->zone_array[zone_idx];
+    if (slba != zone->d.zslba) {
+        trace_pci_nvme_err_unaligned_zone_cmd(action, slba, zone->d.zslba);
+        return NVME_INVALID_FIELD | NVME_DNR;
+    }
+    state = nvme_get_zone_state(zone);
+
+    switch (action) {
+
+    case NVME_ZONE_ACTION_OPEN:
+        trace_pci_nvme_open_zone(slba, zone_idx, all);
+        status = name_do_zone_op(ns, zone, state, all,
+                                 nvme_open_zone, nvme_cond_open_all);
+        break;
+
+    case NVME_ZONE_ACTION_CLOSE:
+        trace_pci_nvme_close_zone(slba, zone_idx, all);
+        status = name_do_zone_op(ns, zone, state, all,
+                                 nvme_close_zone, nvme_cond_close_all);
+        break;
+
+    case NVME_ZONE_ACTION_FINISH:
+        trace_pci_nvme_finish_zone(slba, zone_idx, all);
+        status = name_do_zone_op(ns, zone, state, all,
+                                 nvme_finish_zone, nvme_cond_finish_all);
+        break;
+
+    case NVME_ZONE_ACTION_RESET:
+        trace_pci_nvme_reset_zone(slba, zone_idx, all);
+        status = name_do_zone_op(ns, zone, state, all,
+                                 nvme_reset_zone, nvme_cond_reset_all);
+        break;
+
+    case NVME_ZONE_ACTION_OFFLINE:
+        trace_pci_nvme_offline_zone(slba, zone_idx, all);
+        status = name_do_zone_op(ns, zone, state, all,
+                                 nvme_offline_zone, nvme_cond_offline_all);
+        break;
+
+    case NVME_ZONE_ACTION_SET_ZD_EXT:
+        trace_pci_nvme_set_descriptor_extension(slba, zone_idx);
+        return NVME_INVALID_FIELD | NVME_DNR;
+        break;
+
+    default:
+        trace_pci_nvme_err_invalid_mgmt_action(action);
+        status = NVME_INVALID_FIELD;
+    }
+
+    if (status == NVME_ZONE_INVAL_TRANSITION) {
+        trace_pci_nvme_err_invalid_zone_state_transition(state, action, slba,
+                                                         zone->d.za);
+    }
+    if (status) {
+        status |= NVME_DNR;
+    }
+
+    return status;
+}
+
+static bool nvme_zone_matches_filter(uint32_t zafs, NvmeZone *zl)
+{
+    int zs = nvme_get_zone_state(zl);
+
+    switch (zafs) {
+    case NVME_ZONE_REPORT_ALL:
+        return true;
+    case NVME_ZONE_REPORT_EMPTY:
+        return zs == NVME_ZONE_STATE_EMPTY;
+    case NVME_ZONE_REPORT_IMPLICITLY_OPEN:
+        return zs == NVME_ZONE_STATE_IMPLICITLY_OPEN;
+    case NVME_ZONE_REPORT_EXPLICITLY_OPEN:
+        return zs == NVME_ZONE_STATE_EXPLICITLY_OPEN;
+    case NVME_ZONE_REPORT_CLOSED:
+        return zs == NVME_ZONE_STATE_CLOSED;
+    case NVME_ZONE_REPORT_FULL:
+        return zs == NVME_ZONE_STATE_FULL;
+    case NVME_ZONE_REPORT_READ_ONLY:
+        return zs == NVME_ZONE_STATE_READ_ONLY;
+    case NVME_ZONE_REPORT_OFFLINE:
+        return zs == NVME_ZONE_STATE_OFFLINE;
+    default:
+        return false;
+    }
+}
+
+static uint16_t nvme_zone_mgmt_recv(NvmeCtrl *n, NvmeRequest *req)
+{
+    NvmeCmd *cmd = (NvmeCmd *)&req->cmd;
+    NvmeNamespace *ns = req->ns;
+    /* cdw12 is zero-based number of dwords to return. Convert to bytes */
+    uint32_t len = (le32_to_cpu(cmd->cdw12) + 1) << 2;
+    uint32_t dw13 = le32_to_cpu(cmd->cdw13);
+    uint32_t zone_idx, zra, zrasf, partial;
+    uint64_t max_zones, nr_zones = 0;
+    uint16_t ret;
+    uint64_t slba;
+    NvmeZoneDescr *z;
+    NvmeZone *zs;
+    NvmeZoneReportHeader *header;
+    void *buf, *buf_p;
+    size_t zone_entry_sz;
+
+    req->status = NVME_SUCCESS;
+
+    ret = nvme_get_mgmt_zone_slba_idx(ns, cmd, &slba, &zone_idx);
+    if (ret) {
+        return ret;
+    }
+
+    if (len < sizeof(NvmeZoneReportHeader)) {
+        return NVME_INVALID_FIELD | NVME_DNR;
+    }
+
+    zra = dw13 & 0xff;
+    if (!(zra == NVME_ZONE_REPORT || zra == NVME_ZONE_REPORT_EXTENDED)) {
+        return NVME_INVALID_FIELD | NVME_DNR;
+    }
+
+    if (zra == NVME_ZONE_REPORT_EXTENDED) {
+        return NVME_INVALID_FIELD | NVME_DNR;
+    }
+
+    zrasf = (dw13 >> 8) & 0xff;
+    if (zrasf > NVME_ZONE_REPORT_OFFLINE) {
+        return NVME_INVALID_FIELD | NVME_DNR;
+    }
+
+    partial = (dw13 >> 16) & 0x01;
+
+    zone_entry_sz = sizeof(NvmeZoneDescr);
+
+    max_zones = (len - sizeof(NvmeZoneReportHeader)) / zone_entry_sz;
+    buf = g_malloc0(len);
+
+    header = (NvmeZoneReportHeader *)buf;
+    buf_p = buf + sizeof(NvmeZoneReportHeader);
+
+    while (zone_idx < ns->num_zones && nr_zones < max_zones) {
+        zs = &ns->zone_array[zone_idx];
+
+        if (!nvme_zone_matches_filter(zrasf, zs)) {
+            zone_idx++;
+            continue;
+        }
+
+        z = (NvmeZoneDescr *)buf_p;
+        buf_p += sizeof(NvmeZoneDescr);
+        nr_zones++;
+
+        z->zt = zs->d.zt;
+        z->zs = zs->d.zs;
+        z->zcap = cpu_to_le64(zs->d.zcap);
+        z->zslba = cpu_to_le64(zs->d.zslba);
+        z->za = zs->d.za;
+
+        if (nvme_wp_is_valid(zs)) {
+            z->wp = cpu_to_le64(zs->d.wp);
+        } else {
+            z->wp = cpu_to_le64(~0ULL);
+        }
+
+        zone_idx++;
+    }
+
+    if (!partial) {
+        for (; zone_idx < ns->num_zones; zone_idx++) {
+            zs = &ns->zone_array[zone_idx];
+            if (nvme_zone_matches_filter(zrasf, zs)) {
+                nr_zones++;
+            }
+        }
+    }
+    header->nr_zones = cpu_to_le64(nr_zones);
+
+    ret = nvme_dma(n, (uint8_t *)buf, len, DMA_DIRECTION_FROM_DEVICE, req);
+
+    g_free(buf);
+
+    return ret;
+}
+
 static uint16_t nvme_io_cmd(NvmeCtrl *n, NvmeRequest *req)
 {
     uint32_t nsid = le32_to_cpu(req->cmd.nsid);
@@ -1073,9 +1801,15 @@ static uint16_t nvme_io_cmd(NvmeCtrl *n, NvmeRequest *req)
         return nvme_flush(n, req);
     case NVME_CMD_WRITE_ZEROES:
         return nvme_write_zeroes(n, req);
+    case NVME_CMD_ZONE_APPEND:
+        return nvme_rw(n, req, true);
     case NVME_CMD_WRITE:
     case NVME_CMD_READ:
-        return nvme_rw(n, req);
+        return nvme_rw(n, req, false);
+    case NVME_CMD_ZONE_MGMT_SEND:
+        return nvme_zone_mgmt_send(n, req);
+    case NVME_CMD_ZONE_MGMT_RECV:
+        return nvme_zone_mgmt_recv(n, req);
     default:
         trace_pci_nvme_err_invalid_opc(req->cmd.opcode);
         return NVME_INVALID_OPCODE | NVME_DNR;
@@ -1301,7 +2035,7 @@ static uint16_t nvme_error_info(NvmeCtrl *n, uint8_t rae, uint32_t buf_len,
                     DMA_DIRECTION_FROM_DEVICE, req);
 }
 
-static uint16_t nvme_cmd_effects(NvmeCtrl *n, uint32_t buf_len,
+static uint16_t nvme_cmd_effects(NvmeCtrl *n, uint8_t csi, uint32_t buf_len,
                                  uint64_t off, NvmeRequest *req)
 {
     NvmeEffectsLog cmd_eff_log = {};
@@ -1326,11 +2060,20 @@ static uint16_t nvme_cmd_effects(NvmeCtrl *n, uint32_t buf_len,
     acs[NVME_ADM_CMD_GET_LOG_PAGE] = NVME_CMD_EFFECTS_CSUPP;
     acs[NVME_ADM_CMD_ASYNC_EV_REQ] = NVME_CMD_EFFECTS_CSUPP;
 
-    iocs[NVME_CMD_FLUSH] = NVME_CMD_EFFECTS_CSUPP | NVME_CMD_EFFECTS_LBCC;
-    iocs[NVME_CMD_WRITE_ZEROES] = NVME_CMD_EFFECTS_CSUPP |
-                                  NVME_CMD_EFFECTS_LBCC;
-    iocs[NVME_CMD_WRITE] = NVME_CMD_EFFECTS_CSUPP | NVME_CMD_EFFECTS_LBCC;
-    iocs[NVME_CMD_READ] = NVME_CMD_EFFECTS_CSUPP;
+    if (NVME_CC_CSS(n->bar.cc) != CSS_ADMIN_ONLY) {
+        iocs[NVME_CMD_FLUSH] = NVME_CMD_EFFECTS_CSUPP | NVME_CMD_EFFECTS_LBCC;
+        iocs[NVME_CMD_WRITE_ZEROES] = NVME_CMD_EFFECTS_CSUPP |
+                                      NVME_CMD_EFFECTS_LBCC;
+        iocs[NVME_CMD_WRITE] = NVME_CMD_EFFECTS_CSUPP | NVME_CMD_EFFECTS_LBCC;
+        iocs[NVME_CMD_READ] = NVME_CMD_EFFECTS_CSUPP;
+    }
+
+    if (csi == NVME_CSI_ZONED && NVME_CC_CSS(n->bar.cc) == CSS_CSI) {
+        iocs[NVME_CMD_ZONE_APPEND] = NVME_CMD_EFFECTS_CSUPP |
+                                     NVME_CMD_EFFECTS_LBCC;
+        iocs[NVME_CMD_ZONE_MGMT_SEND] = NVME_CMD_EFFECTS_CSUPP;
+        iocs[NVME_CMD_ZONE_MGMT_RECV] = NVME_CMD_EFFECTS_CSUPP;
+    }
 
     trans_len = MIN(sizeof(cmd_eff_log) - off, buf_len);
 
@@ -1349,6 +2092,7 @@ static uint16_t nvme_get_log(NvmeCtrl *n, NvmeRequest *req)
     uint8_t  lid = dw10 & 0xff;
     uint8_t  lsp = (dw10 >> 8) & 0xf;
     uint8_t  rae = (dw10 >> 15) & 0x1;
+    uint8_t csi = le32_to_cpu(cmd->cdw14) >> 24;
     uint32_t numdl, numdu;
     uint64_t off, lpol, lpou;
     size_t   len;
@@ -1382,7 +2126,7 @@ static uint16_t nvme_get_log(NvmeCtrl *n, NvmeRequest *req)
     case NVME_LOG_FW_SLOT_INFO:
         return nvme_fw_log_info(n, len, off, req);
     case NVME_LOG_CMD_EFFECTS:
-        return nvme_cmd_effects(n, len, off, req);
+        return nvme_cmd_effects(n, csi, len, off, req);
     default:
         trace_pci_nvme_err_invalid_log_page(nvme_cid(req), lid);
         return NVME_INVALID_FIELD | NVME_DNR;
@@ -1502,6 +2246,16 @@ static uint16_t nvme_rpt_empty_id_struct(NvmeCtrl *n, NvmeRequest *req)
     return nvme_dma(n, id, sizeof(id), DMA_DIRECTION_FROM_DEVICE, req);
 }
 
+static inline bool nvme_csi_has_nvm_support(NvmeNamespace *ns)
+{
+    switch (ns->csi) {
+    case NVME_CSI_NVM:
+    case NVME_CSI_ZONED:
+        return true;
+    }
+    return false;
+}
+
 static uint16_t nvme_identify_ctrl(NvmeCtrl *n, NvmeRequest *req)
 {
     trace_pci_nvme_identify_ctrl();
@@ -1513,11 +2267,16 @@ static uint16_t nvme_identify_ctrl(NvmeCtrl *n, NvmeRequest *req)
 static uint16_t nvme_identify_ctrl_csi(NvmeCtrl *n, NvmeRequest *req)
 {
     NvmeIdentify *c = (NvmeIdentify *)&req->cmd;
+    NvmeIdCtrlZoned id = {};
 
     trace_pci_nvme_identify_ctrl_csi(c->csi);
 
     if (c->csi == NVME_CSI_NVM) {
         return nvme_rpt_empty_id_struct(n, req);
+    } else if (c->csi == NVME_CSI_ZONED) {
+        id.zasl = n->zasl;
+        return nvme_dma(n, (uint8_t *)&id, sizeof(id),
+                        DMA_DIRECTION_FROM_DEVICE, req);
     }
 
     return NVME_INVALID_FIELD | NVME_DNR;
@@ -1545,8 +2304,12 @@ static uint16_t nvme_identify_ns(NvmeCtrl *n, NvmeRequest *req,
         return nvme_rpt_empty_id_struct(n, req);
     }
 
-    return nvme_dma(n, (uint8_t *)&ns->id_ns, sizeof(NvmeIdNs),
-                    DMA_DIRECTION_FROM_DEVICE, req);
+    if (c->csi == NVME_CSI_NVM && nvme_csi_has_nvm_support(ns)) {
+        return nvme_dma(n, (uint8_t *)&ns->id_ns, sizeof(NvmeIdNs),
+                        DMA_DIRECTION_FROM_DEVICE, req);
+    }
+
+    return NVME_INVALID_CMD_SET | NVME_DNR;
 }
 
 static uint16_t nvme_identify_ns_csi(NvmeCtrl *n, NvmeRequest *req,
@@ -1571,8 +2334,11 @@ static uint16_t nvme_identify_ns_csi(NvmeCtrl *n, NvmeRequest *req,
         return nvme_rpt_empty_id_struct(n, req);
     }
 
-    if (c->csi == NVME_CSI_NVM) {
+    if (c->csi == NVME_CSI_NVM && nvme_csi_has_nvm_support(ns)) {
         return nvme_rpt_empty_id_struct(n, req);
+    } else if (c->csi == NVME_CSI_ZONED && ns->csi == NVME_CSI_ZONED) {
+        return nvme_dma(n, (uint8_t *)ns->id_ns_zoned, sizeof(NvmeIdNsZoned),
+                        DMA_DIRECTION_FROM_DEVICE, req);
     }
 
     return NVME_INVALID_FIELD | NVME_DNR;
@@ -1634,7 +2400,7 @@ static uint16_t nvme_identify_nslist_csi(NvmeCtrl *n, NvmeRequest *req,
 
     trace_pci_nvme_identify_nslist_csi(min_nsid, c->csi);
 
-    if (c->csi != NVME_CSI_NVM) {
+    if (c->csi != NVME_CSI_NVM && c->csi != NVME_CSI_ZONED) {
         return NVME_INVALID_FIELD | NVME_DNR;
     }
 
@@ -1643,7 +2409,7 @@ static uint16_t nvme_identify_nslist_csi(NvmeCtrl *n, NvmeRequest *req,
         if (!ns) {
             continue;
         }
-        if (ns->params.nsid < min_nsid) {
+        if (ns->params.nsid < min_nsid || c->csi != ns->csi) {
             continue;
         }
         if (only_active && !ns->params.attached) {
@@ -1696,19 +2462,29 @@ static uint16_t nvme_identify_ns_descr_list(NvmeCtrl *n, NvmeRequest *req)
     desc->nidt = NVME_NIDT_CSI;
     desc->nidl = NVME_NIDL_CSI;
     list_ptr += sizeof(*desc);
-    *(uint8_t *)list_ptr = NVME_CSI_NVM;
+    *(uint8_t *)list_ptr = ns->csi;
 
     return nvme_dma(n, list, data_len, DMA_DIRECTION_FROM_DEVICE, req);
 }
 
 static uint16_t nvme_identify_cmd_set(NvmeCtrl *n, NvmeRequest *req)
 {
+    NvmeNamespace *ns;
     uint8_t list[NVME_IDENTIFY_DATA_SIZE] = {};
     static const int data_len = sizeof(list);
+    int i;
 
     trace_pci_nvme_identify_cmd_set();
 
     NVME_SET_CSI(*list, NVME_CSI_NVM);
+    for (i = 1; i <= n->num_namespaces; i++) {
+        ns = nvme_ns(n, i);
+        if (ns && ns->params.zoned) {
+            NVME_SET_CSI(*list, NVME_CSI_ZONED);
+            break;
+        }
+    }
+
     return nvme_dma(n, list, data_len, DMA_DIRECTION_FROM_DEVICE, req);
 }
 
@@ -1751,7 +2527,7 @@ static uint16_t nvme_abort(NvmeCtrl *n, NvmeRequest *req)
 {
     uint16_t sqid = le32_to_cpu(req->cmd.cdw10) & 0xffff;
 
-    req->cqe.result = 1;
+    req->cqe.result32 = 1;
     if (nvme_check_sqid(n, sqid)) {
         return NVME_INVALID_FIELD | NVME_DNR;
     }
@@ -1932,7 +2708,7 @@ defaults:
     }
 
 out:
-    req->cqe.result = cpu_to_le32(result);
+    req->cqe.result32 = cpu_to_le32(result);
     return NVME_SUCCESS;
 }
 
@@ -2057,8 +2833,8 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeRequest *req)
                                     ((dw11 >> 16) & 0xFFFF) + 1,
                                     n->params.max_ioqpairs,
                                     n->params.max_ioqpairs);
-        req->cqe.result = cpu_to_le32((n->params.max_ioqpairs - 1) |
-                                      ((n->params.max_ioqpairs - 1) << 16));
+        req->cqe.result32 = cpu_to_le32((n->params.max_ioqpairs - 1) |
+                                        ((n->params.max_ioqpairs - 1) << 16));
         break;
     case NVME_ASYNCHRONOUS_EVENT_CONF:
         n->features.async_config = dw11;
@@ -2310,16 +3086,28 @@ static int nvme_start_ctrl(NvmeCtrl *n)
             continue;
         }
         ns->params.attached = false;
-        switch (ns->params.csi) {
+        switch (ns->csi) {
         case NVME_CSI_NVM:
             if (NVME_CC_CSS(n->bar.cc) == CSS_NVM_ONLY ||
                 NVME_CC_CSS(n->bar.cc) == CSS_CSI) {
                 ns->params.attached = true;
             }
             break;
+        case NVME_CSI_ZONED:
+            if (NVME_CC_CSS(n->bar.cc) == CSS_CSI) {
+                ns->params.attached = true;
+            }
+            break;
         }
     }
 
+    if (!n->zasl_bs) {
+        assert(n->params.mdts);
+        n->zasl = n->params.mdts;
+    } else {
+        n->zasl = 31 - clz32(n->zasl_bs / n->page_size);
+    }
+
     nvme_set_timestamp(n, 0ULL);
 
     QTAILQ_INIT(&n->aer_queue);
@@ -2382,10 +3170,11 @@ static void nvme_write_bar(NvmeCtrl *n, hwaddr offset, uint64_t data,
                 case CSS_NVM_ONLY:
                     trace_pci_nvme_css_nvm_cset_selected_by_host(data &
                                                                  0xffffffff);
-                    break;
+                break;
                 case CSS_CSI:
                     NVME_SET_CC_CSS(n->bar.cc, CSS_CSI);
-                    trace_pci_nvme_css_all_csets_sel_by_host(data & 0xffffffff);
+                    trace_pci_nvme_css_all_csets_sel_by_host(data &
+                                                             0xffffffff);
                     break;
                 case CSS_ADMIN_ONLY:
                     break;
@@ -2780,6 +3569,12 @@ static void nvme_init_state(NvmeCtrl *n)
     n->features.temp_thresh_hi = NVME_TEMPERATURE_WARNING;
     n->starttime_ms = qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL);
     n->aer_reqs = g_new0(NvmeRequest *, n->params.aerl + 1);
+
+    if (!n->params.zasl_kb) {
+        n->zasl_bs = n->params.mdts ? 0 : NVME_DEFAULT_MAX_ZA_SIZE * KiB;
+    } else {
+        n->zasl_bs = n->params.zasl_kb * KiB;
+    }
 }
 
 int nvme_register_namespace(NvmeCtrl *n, NvmeNamespace *ns, Error **errp)
@@ -2985,8 +3780,9 @@ static void nvme_init_ctrl(NvmeCtrl *n, PCIDevice *pci_dev)
     NVME_CAP_SET_CQR(n->bar.cap, 1);
     NVME_CAP_SET_TO(n->bar.cap, 0xf);
     /*
-     * The device now always supports NS Types, but all commands
-     * that support CSI field will only handle NVM Command Set.
+     * The device now always supports NS Types, even when "zoned" property
+     * is set to zero. If this is the case, all commands that support CSI
+     * field only handle NVM Command Set.
      */
     NVME_CAP_SET_CSS(n->bar.cap, (CAP_CSS_NVM | CAP_CSS_CSI_SUPP));
     NVME_CAP_SET_MPSMAX(n->bar.cap, 4);
@@ -3033,9 +3829,21 @@ static void nvme_realize(PCIDevice *pci_dev, Error **errp)
 static void nvme_exit(PCIDevice *pci_dev)
 {
     NvmeCtrl *n = NVME(pci_dev);
+    NvmeNamespace *ns;
+    int i;
 
     nvme_clear_ctrl(n);
+
+    for (i = 1; i <= n->num_namespaces; i++) {
+        ns = nvme_ns(n, i);
+        if (!ns) {
+            continue;
+        }
+
+        nvme_ns_cleanup(ns);
+    }
     g_free(n->namespaces);
+
     g_free(n->cq);
     g_free(n->sq);
     g_free(n->aer_reqs);
@@ -3063,6 +3871,8 @@ static Property nvme_props[] = {
     DEFINE_PROP_UINT32("aer_max_queued", NvmeCtrl, params.aer_max_queued, 64),
     DEFINE_PROP_UINT8("mdts", NvmeCtrl, params.mdts, 7),
     DEFINE_PROP_BOOL("use-intel-id", NvmeCtrl, params.use_intel_id, false),
+    DEFINE_PROP_UINT8("fill_pattern", NvmeCtrl, params.fill_pattern, 0),
+    DEFINE_PROP_UINT32("zone_append_size_limit", NvmeCtrl, params.zasl_kb, 0),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/include/block/nvme.h b/include/block/nvme.h
index a7126e123f..628c665728 100644
--- a/include/block/nvme.h
+++ b/include/block/nvme.h
@@ -651,8 +651,10 @@ typedef struct QEMU_PACKED NvmeAerResult {
 } NvmeAerResult;
 
 typedef struct QEMU_PACKED NvmeCqe {
-    uint32_t    result;
-    uint32_t    rsvd;
+    union {
+        uint64_t     result64;
+        uint32_t     result32;
+    };
     uint16_t    sq_head;
     uint16_t    sq_id;
     uint16_t    cid;
-- 
2.21.0


