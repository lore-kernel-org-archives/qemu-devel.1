Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75153C433E7
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 21:53:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DEF8E20872
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 21:53:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="D52DlfWW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEF8E20872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49350 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSSEB-0000f1-2h
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 17:53:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47148)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=5487bf209=dmitry.fomichev@wdc.com>)
 id 1kSS44-0005gg-5n; Tue, 13 Oct 2020 17:42:36 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:45639)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=5487bf209=dmitry.fomichev@wdc.com>)
 id 1kSS3z-0001mW-A3; Tue, 13 Oct 2020 17:42:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1602625351; x=1634161351;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Q4R1gq2Cc+FcQjP3e7IJtnv9eBGGx/IC3puV32dgdh4=;
 b=D52DlfWW34q03lJsoy/6t4HWuC9Z864WY1iisebiC9O07Nf7P8+r5MB1
 Zr631a7k9eEmW+ZsiXLCHBI9z7YyEBFqraHyD8nuT4gBkGATPSiWLbuAh
 MLc0pCM7WY0MA3VSBLpNtUi6KnChlrGawZO3CES/tBm6yhLBbQA1h/Xa0
 8VbmFEKRonyZZG2+wjyGGhMDHulYOcMWtnBOTWTHetLJ2+EEIxNHQrRmw
 j08ciOpOXlijLMUqaQ9nhtZ6b/Xyg7lU9y3kFYACGAo8otVBdRk6QGRFv
 iLSs3JODRojKq5KMFM8KogtNKcXVv9YanvQ9vtc8j6jeCbywZiphzN2XG A==;
IronPort-SDR: EakAwplndvOdE+KT+qnNgjlE9UyquGknqK4bxvq9OccPHRWzImUdW6aXgPg5z8JdYGJzWxJJ2h
 1x1k2Ftt9I1Ozn1t40VyG/dqL8mzXcw9LIP74nCgCLwEr0ILhyqrvMgkCZ0BhV2sIRIBxgEMww
 Kg694mXA3netcVnhDOmeeL3Lnfd/YUbxbxliQ4lA35q56VipSD62n1PkvxeQh4fnhf/+8jEbSe
 XQrolL58yVV6X1MQ6lAFDhIfwxiBj0t0FZ3jHDT8UOlMbP9nWjvcjbseSVEhNPsPn6L5AQALL+
 U6M=
X-IronPort-AV: E=Sophos;i="5.77,371,1596470400"; d="scan'208";a="154185930"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 14 Oct 2020 05:42:30 +0800
IronPort-SDR: MupGGMB3+Yvv9JiBM3URvDiXcNfjp1S6PCe0VSPF/iCSN3rqA8jcLlS2967z1TMdQ/aoogGL70
 MgyyK1mVV5FIBv3ozK2FQ2iV7ebu1nEfIpABT+KFFCIuL58XIavt+6wRIEQbmhTuSaQrrwcIVR
 UKg+q+BDjjkOt7S416w1OZNQETnF580YLcu0cKeImL/8CMvzAqoyPCLkXzZmiHS+v/Gdi0FwcS
 +v9aYLQEj2YjHenetew3k+FSsfCo2VdYomHt/DLQ117MHX45c2vNpLROuQ/jcOplG4AmTYn8rC
 eEvCx2ZdvCAQQvhUVN5FNqGU
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Oct 2020 14:29:03 -0700
IronPort-SDR: WOGLg85n/3aCxTP3s0vJzMX5Bk4MPX/UZTAeWOX2ggV/xK9AOq/X1xF6IWM+89BhlOwZPFYus0
 iyvpjw+4V3uf9tdAxqlT+MIB7hx87cMwf/x6QgSzmLJmMa6th45L0NjapKGv1Ww0ruc8XPcopK
 nkHK6JrdKAS0i9zNAkyij5oE4/tMtJjXhq6V24xFHqPrkixr+o7Nyu8iSBqsl+gfLO5smVzO73
 n7ZEvjmn4fEBzcvHyFWtc9S8Jl2q6rMNbz/OGHDAP2XttAZEmA+mE1UQsdyAcxAO7T6E140iYm
 hdU=
WDCIronportException: Internal
Received: from unknown (HELO redsun50.ssa.fujisawa.hgst.com) ([10.149.66.24])
 by uls-op-cesaip02.wdc.com with ESMTP; 13 Oct 2020 14:42:28 -0700
From: Dmitry Fomichev <dmitry.fomichev@wdc.com>
To: Keith Busch <kbusch@kernel.org>, Klaus Jensen <k.jensen@samsung.com>,
 Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Maxim Levitsky <mlevitsk@redhat.com>, Fam Zheng <fam@euphon.net>
Subject: [PATCH v6 05/11] hw/block/nvme: Support Zoned Namespace Command Set
Date: Wed, 14 Oct 2020 06:42:06 +0900
Message-Id: <20201013214212.2152-6-dmitry.fomichev@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20201013214212.2152-1-dmitry.fomichev@wdc.com>
References: <20201013214212.2152-1-dmitry.fomichev@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.153.141;
 envelope-from=prvs=5487bf209=dmitry.fomichev@wdc.com; helo=esa3.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/13 17:42:19
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

Define values and structures that are needed to support Zoned
Namespace Command Set (NVMe TP 4053) in PCI NVMe controller emulator.
Define trace events where needed in newly introduced code.

In order to improve scalability, all open, closed and full zones
are organized in separate linked lists. Consequently, almost all
zone operations don't require scanning of the entire zone array
(which potentially can be quite large) - it is only necessary to
enumerate one or more zone lists.

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

Subsequent commits in this series add ZDE support and checks for
active and open zone limits.

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
 block/nvme.c          |   2 +-
 hw/block/nvme-ns.c    | 193 +++++++++
 hw/block/nvme-ns.h    |  54 +++
 hw/block/nvme.c       | 987 ++++++++++++++++++++++++++++++++++++++++--
 hw/block/nvme.h       |   9 +
 hw/block/trace-events |  21 +
 include/block/nvme.h  | 113 ++++-
 7 files changed, 1349 insertions(+), 30 deletions(-)

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
index 974aea33f7..fedfad595c 100644
--- a/hw/block/nvme-ns.c
+++ b/hw/block/nvme-ns.c
@@ -25,6 +25,7 @@
 #include "hw/qdev-properties.h"
 #include "hw/qdev-core.h"
 
+#include "trace.h"
 #include "nvme.h"
 #include "nvme-ns.h"
 
@@ -76,6 +77,171 @@ static int nvme_ns_init_blk(NvmeCtrl *n, NvmeNamespace *ns, Error **errp)
     return 0;
 }
 
+static int nvme_calc_zone_geometry(NvmeNamespace *ns, Error **errp)
+{
+    uint64_t zone_size, zone_cap;
+    uint32_t nz, lbasz = ns->blkconf.logical_block_size;
+
+    if (ns->params.zone_size_bs) {
+        zone_size = ns->params.zone_size_bs;
+    } else {
+        zone_size = NVME_DEFAULT_ZONE_SIZE;
+    }
+    if (ns->params.zone_cap_bs) {
+        zone_cap = ns->params.zone_cap_bs;
+    } else {
+        zone_cap = zone_size;
+    }
+    if (zone_cap > zone_size) {
+        error_setg(errp, "zone capacity %luB exceeds zone size %luB",
+                   zone_cap, zone_size);
+        return -1;
+    }
+    if (zone_size < lbasz) {
+        error_setg(errp, "zone size %luB too small, must be at least %uB",
+                   zone_size, lbasz);
+        return -1;
+    }
+    if (zone_cap < lbasz) {
+        error_setg(errp, "zone capacity %luB too small, must be at least %uB",
+                   zone_cap, lbasz);
+        return -1;
+    }
+    ns->zone_size = zone_size / lbasz;
+    ns->zone_capacity = zone_cap / lbasz;
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
+static void nvme_init_zone_state(NvmeNamespace *ns)
+{
+    uint64_t start = 0, zone_size = ns->zone_size;
+    uint64_t capacity = ns->num_zones * zone_size;
+    NvmeZone *zone;
+    int i;
+
+    ns->zone_array = g_malloc0(ns->zone_array_size);
+
+    QTAILQ_INIT(&ns->exp_open_zones);
+    QTAILQ_INIT(&ns->imp_open_zones);
+    QTAILQ_INIT(&ns->closed_zones);
+    QTAILQ_INIT(&ns->full_zones);
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
+        start += zone_size;
+    }
+}
+
+static int nvme_zoned_init_ns(NvmeCtrl *n, NvmeNamespace *ns, int lba_index,
+                              Error **errp)
+{
+    NvmeIdNsZoned *id_ns_z;
+
+    if (n->params.fill_pattern == 0xff) {
+        ns->id_ns.dlfeat |= 0x02;
+    }
+    if (n->params.fill_pattern != 0x00) {
+        ns->id_ns.dlfeat &= ~0x01;
+    }
+
+    if (nvme_calc_zone_geometry(ns, errp) != 0) {
+        return -1;
+    }
+
+    nvme_init_zone_state(ns);
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
+    id_ns_z->lbafe[lba_index].zdes = 0;
+
+    ns->csi = NVME_CSI_ZONED;
+    ns->id_ns.nsze = cpu_to_le64(ns->zone_size * ns->num_zones);
+    ns->id_ns.ncap = cpu_to_le64(ns->zone_capacity * ns->num_zones);
+    ns->id_ns.nuse = ns->id_ns.ncap;
+
+    ns->id_ns_zoned = id_ns_z;
+
+    return 0;
+}
+
+/*
+ * Close or finish all the zones that are currently open.
+ */
+static void nvme_zoned_clear_ns(NvmeNamespace *ns)
+{
+    NvmeZone *zone;
+    uint32_t set_state;
+    int i;
+
+    zone = ns->zone_array;
+    for (i = 0; i < ns->num_zones; i++, zone++) {
+        switch (nvme_get_zone_state(zone)) {
+        case NVME_ZONE_STATE_IMPLICITLY_OPEN:
+            QTAILQ_REMOVE(&ns->imp_open_zones, zone, entry);
+            break;
+        case NVME_ZONE_STATE_EXPLICITLY_OPEN:
+            QTAILQ_REMOVE(&ns->exp_open_zones, zone, entry);
+            break;
+        case NVME_ZONE_STATE_CLOSED:
+            /* fall through */
+        default:
+            continue;
+        }
+
+        if (zone->d.wp == zone->d.zslba) {
+            set_state = NVME_ZONE_STATE_EMPTY;
+        } else {
+            set_state = NVME_ZONE_STATE_CLOSED;
+        }
+
+        switch (set_state) {
+        case NVME_ZONE_STATE_CLOSED:
+            trace_pci_nvme_clear_ns_close(nvme_get_zone_state(zone),
+                                          zone->d.zslba);
+            QTAILQ_INSERT_TAIL(&ns->closed_zones, zone, entry);
+            break;
+        case NVME_ZONE_STATE_EMPTY:
+            trace_pci_nvme_clear_ns_reset(nvme_get_zone_state(zone),
+                                          zone->d.zslba);
+            break;
+        case NVME_ZONE_STATE_FULL:
+            trace_pci_nvme_clear_ns_full(nvme_get_zone_state(zone),
+                                         zone->d.zslba);
+            zone->d.wp = nvme_zone_wr_boundary(zone);
+            QTAILQ_INSERT_TAIL(&ns->full_zones, zone, entry);
+        }
+
+        zone->w_ptr = zone->d.wp;
+        nvme_set_zone_state(zone, set_state);
+    }
+}
+
 static int nvme_ns_check_constraints(NvmeNamespace *ns, Error **errp)
 {
     if (!ns->blkconf.blk) {
@@ -97,6 +263,12 @@ int nvme_ns_setup(NvmeCtrl *n, NvmeNamespace *ns, Error **errp)
     }
 
     nvme_ns_init(ns);
+    if (ns->params.zoned) {
+        if (nvme_zoned_init_ns(n, ns, 0, errp) != 0) {
+            return -1;
+        }
+    }
+
     if (nvme_register_namespace(n, ns, errp)) {
         return -1;
     }
@@ -114,6 +286,21 @@ void nvme_ns_flush(NvmeNamespace *ns)
     blk_flush(ns->blkconf.blk);
 }
 
+void nvme_ns_clear(NvmeNamespace *ns)
+{
+    if (ns->params.zoned) {
+        nvme_zoned_clear_ns(ns);
+    }
+}
+
+void nvme_ns_cleanup(NvmeNamespace *ns)
+{
+    if (ns->params.zoned) {
+        g_free(ns->id_ns_zoned);
+        g_free(ns->zone_array);
+    }
+}
+
 static void nvme_ns_realize(DeviceState *dev, Error **errp)
 {
     NvmeNamespace *ns = NVME_NS(dev);
@@ -133,6 +320,12 @@ static Property nvme_ns_props[] = {
     DEFINE_PROP_UINT32("nsid", NvmeNamespace, params.nsid, 0),
     DEFINE_PROP_UUID("uuid", NvmeNamespace, params.uuid),
     DEFINE_PROP_BOOL("attached", NvmeNamespace, params.attached, true),
+    DEFINE_PROP_BOOL("zoned", NvmeNamespace, params.zoned, false),
+    DEFINE_PROP_SIZE("zone_size", NvmeNamespace, params.zone_size_bs,
+                     NVME_DEFAULT_ZONE_SIZE),
+    DEFINE_PROP_SIZE("zone_capacity", NvmeNamespace, params.zone_cap_bs, 0),
+    DEFINE_PROP_BOOL("cross_zone_read", NvmeNamespace,
+                     params.cross_zone_read, false),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/hw/block/nvme-ns.h b/hw/block/nvme-ns.h
index d6b2808b97..170cbb8cdc 100644
--- a/hw/block/nvme-ns.h
+++ b/hw/block/nvme-ns.h
@@ -19,10 +19,21 @@
 #define NVME_NS(obj) \
     OBJECT_CHECK(NvmeNamespace, (obj), TYPE_NVME_NS)
 
+typedef struct NvmeZone {
+    NvmeZoneDescr   d;
+    uint64_t        w_ptr;
+    QTAILQ_ENTRY(NvmeZone) entry;
+} NvmeZone;
+
 typedef struct NvmeNamespaceParams {
     uint32_t nsid;
     bool     attached;
     QemuUUID uuid;
+
+    bool     zoned;
+    bool     cross_zone_read;
+    uint64_t zone_size_bs;
+    uint64_t zone_cap_bs;
 } NvmeNamespaceParams;
 
 typedef struct NvmeNamespace {
@@ -34,6 +45,18 @@ typedef struct NvmeNamespace {
     const uint32_t *iocs;
     uint8_t      csi;
 
+    NvmeIdNsZoned   *id_ns_zoned;
+    NvmeZone        *zone_array;
+    QTAILQ_HEAD(, NvmeZone) exp_open_zones;
+    QTAILQ_HEAD(, NvmeZone) imp_open_zones;
+    QTAILQ_HEAD(, NvmeZone) closed_zones;
+    QTAILQ_HEAD(, NvmeZone) full_zones;
+    uint32_t        num_zones;
+    uint64_t        zone_size;
+    uint64_t        zone_capacity;
+    uint64_t        zone_array_size;
+    uint32_t        zone_size_log2;
+
     NvmeNamespaceParams params;
 } NvmeNamespace;
 
@@ -71,8 +94,39 @@ static inline size_t nvme_l2b(NvmeNamespace *ns, uint64_t lba)
 
 typedef struct NvmeCtrl NvmeCtrl;
 
+static inline uint8_t nvme_get_zone_state(NvmeZone *zone)
+{
+    return zone->d.zs >> 4;
+}
+
+static inline void nvme_set_zone_state(NvmeZone *zone, enum NvmeZoneState state)
+{
+    zone->d.zs = state << 4;
+}
+
+static inline uint64_t nvme_zone_rd_boundary(NvmeNamespace *ns, NvmeZone *zone)
+{
+    return zone->d.zslba + ns->zone_size;
+}
+
+static inline uint64_t nvme_zone_wr_boundary(NvmeZone *zone)
+{
+    return zone->d.zslba + zone->d.zcap;
+}
+
+static inline bool nvme_wp_is_valid(NvmeZone *zone)
+{
+    uint8_t st = nvme_get_zone_state(zone);
+
+    return st != NVME_ZONE_STATE_FULL &&
+           st != NVME_ZONE_STATE_READ_ONLY &&
+           st != NVME_ZONE_STATE_OFFLINE;
+}
+
 int nvme_ns_setup(NvmeCtrl *n, NvmeNamespace *ns, Error **errp);
 void nvme_ns_drain(NvmeNamespace *ns);
 void nvme_ns_flush(NvmeNamespace *ns);
+void nvme_ns_clear(NvmeNamespace *ns);
+void nvme_ns_cleanup(NvmeNamespace *ns);
 
 #endif /* NVME_NS_H */
diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 2b4488575b..2e663713c7 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -133,6 +133,16 @@ static const uint32_t nvme_cse_iocs_nvm[256] = {
     [NVME_CMD_READ]                 = NVME_CMD_EFF_CSUPP,
 };
 
+static const uint32_t nvme_cse_iocs_zoned[256] = {
+    [NVME_CMD_FLUSH]                = NVME_CMD_EFF_CSUPP | NVME_CMD_EFF_LBCC,
+    [NVME_CMD_WRITE_ZEROES]         = NVME_CMD_EFF_CSUPP | NVME_CMD_EFF_LBCC,
+    [NVME_CMD_WRITE]                = NVME_CMD_EFF_CSUPP | NVME_CMD_EFF_LBCC,
+    [NVME_CMD_READ]                 = NVME_CMD_EFF_CSUPP,
+    [NVME_CMD_ZONE_APPEND]          = NVME_CMD_EFF_CSUPP | NVME_CMD_EFF_LBCC,
+    [NVME_CMD_ZONE_MGMT_SEND]       = NVME_CMD_EFF_CSUPP,
+    [NVME_CMD_ZONE_MGMT_RECV]       = NVME_CMD_EFF_CSUPP,
+};
+
 static void nvme_process_sq(void *opaque);
 
 static uint16_t nvme_cid(NvmeRequest *req)
@@ -149,6 +159,46 @@ static uint16_t nvme_sqid(NvmeRequest *req)
     return le16_to_cpu(req->sq->sqid);
 }
 
+static void nvme_assign_zone_state(NvmeNamespace *ns, NvmeZone *zone,
+                                   uint8_t state)
+{
+    if (QTAILQ_IN_USE(zone, entry)) {
+        switch (nvme_get_zone_state(zone)) {
+        case NVME_ZONE_STATE_EXPLICITLY_OPEN:
+            QTAILQ_REMOVE(&ns->exp_open_zones, zone, entry);
+            break;
+        case NVME_ZONE_STATE_IMPLICITLY_OPEN:
+            QTAILQ_REMOVE(&ns->imp_open_zones, zone, entry);
+            break;
+        case NVME_ZONE_STATE_CLOSED:
+            QTAILQ_REMOVE(&ns->closed_zones, zone, entry);
+            break;
+        case NVME_ZONE_STATE_FULL:
+            QTAILQ_REMOVE(&ns->full_zones, zone, entry);
+        }
+    }
+
+    nvme_set_zone_state(zone, state);
+
+    switch (state) {
+    case NVME_ZONE_STATE_EXPLICITLY_OPEN:
+        QTAILQ_INSERT_TAIL(&ns->exp_open_zones, zone, entry);
+        break;
+    case NVME_ZONE_STATE_IMPLICITLY_OPEN:
+        QTAILQ_INSERT_TAIL(&ns->imp_open_zones, zone, entry);
+        break;
+    case NVME_ZONE_STATE_CLOSED:
+        QTAILQ_INSERT_TAIL(&ns->closed_zones, zone, entry);
+        break;
+    case NVME_ZONE_STATE_FULL:
+        QTAILQ_INSERT_TAIL(&ns->full_zones, zone, entry);
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
@@ -841,7 +891,7 @@ static void nvme_process_aers(void *opaque)
 
         req = n->aer_reqs[n->outstanding_aers];
 
-        result = (NvmeAerResult *) &req->cqe.result;
+        result = (NvmeAerResult *) &req->cqe.result32;
         result->event_type = event->result.event_type;
         result->event_info = event->result.event_info;
         result->log_page = event->result.log_page;
@@ -910,6 +960,326 @@ static inline uint16_t nvme_check_bounds(NvmeCtrl *n, NvmeNamespace *ns,
     return NVME_SUCCESS;
 }
 
+static void nvme_fill_read_data(NvmeRequest *req, uint64_t offset,
+                                uint32_t max_len, uint8_t pattern)
+{
+    QEMUSGList *qsg = &req->qsg;
+    QEMUIOVector *iov = &req->iov;
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
+static inline uint32_t nvme_zone_idx(NvmeNamespace *ns, uint64_t slba)
+{
+    return ns->zone_size_log2 > 0 ? slba >> ns->zone_size_log2 :
+                                    slba / ns->zone_size;
+}
+
+static inline NvmeZone *nvme_get_zone_by_slba(NvmeNamespace *ns, uint64_t slba)
+{
+    uint32_t zone_idx = nvme_zone_idx(ns, slba);
+
+    assert(zone_idx < ns->num_zones);
+    return &ns->zone_array[zone_idx];
+}
+
+static uint16_t nvme_zone_state_ok_to_write(NvmeZone *zone)
+{
+    uint16_t status;
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
+
+    return status;
+}
+
+static uint16_t nvme_check_zone_write(NvmeCtrl *n, NvmeNamespace *ns,
+                                      NvmeZone *zone, uint64_t slba,
+                                      uint32_t nlb, bool append)
+{
+    uint16_t status;
+
+    if (unlikely((slba + nlb) > nvme_zone_wr_boundary(zone))) {
+        status = NVME_ZONE_BOUNDARY_ERROR;
+    } else {
+        status = nvme_zone_state_ok_to_write(zone);
+    }
+
+    if (status != NVME_SUCCESS) {
+        trace_pci_nvme_err_zone_write_not_ok(slba, nlb, status);
+    } else {
+        assert(nvme_wp_is_valid(zone));
+        if (append) {
+            if (unlikely(slba != zone->d.zslba)) {
+                trace_pci_nvme_err_append_not_at_start(slba, zone->d.zslba);
+                status = NVME_ZONE_INVALID_WRITE;
+            }
+            if (nvme_l2b(ns, nlb) > (n->page_size << n->zasl)) {
+                trace_pci_nvme_err_append_too_large(slba, nlb, n->zasl);
+                status = NVME_INVALID_FIELD;
+            }
+        } else if (unlikely(slba != zone->w_ptr)) {
+            trace_pci_nvme_err_write_not_at_wp(slba, zone->d.zslba,
+                                               zone->w_ptr);
+            status = NVME_ZONE_INVALID_WRITE;
+        }
+    }
+
+    return status;
+}
+
+static uint16_t nvme_zone_state_ok_to_read(NvmeZone *zone)
+{
+    uint16_t status;
+
+    switch (nvme_get_zone_state(zone)) {
+    case NVME_ZONE_STATE_EMPTY:
+    case NVME_ZONE_STATE_IMPLICITLY_OPEN:
+    case NVME_ZONE_STATE_EXPLICITLY_OPEN:
+    case NVME_ZONE_STATE_FULL:
+    case NVME_ZONE_STATE_CLOSED:
+    case NVME_ZONE_STATE_READ_ONLY:
+        status = NVME_SUCCESS;
+        break;
+    case NVME_ZONE_STATE_OFFLINE:
+        status = NVME_ZONE_OFFLINE | NVME_DNR;
+        break;
+    default:
+        assert(false);
+    }
+
+    return status;
+}
+
+typedef struct NvmeReadFillCtx {
+    uint64_t  pre_rd_fill_slba;
+    uint64_t  read_slba;
+    uint64_t  post_rd_fill_slba;
+
+    uint32_t  pre_rd_fill_nlb;
+    uint32_t  read_nlb;
+    uint32_t  post_rd_fill_nlb;
+} NvmeReadFillCtx;
+
+static uint16_t nvme_check_zone_read(NvmeNamespace *ns, NvmeZone *zone,
+                                     uint64_t slba, uint32_t nlb,
+                                     NvmeReadFillCtx *rfc)
+{
+    NvmeZone *next_zone;
+    uint64_t bndry = nvme_zone_rd_boundary(ns, zone);
+    uint64_t end = slba + nlb, wp1, wp2;
+    uint16_t status;
+
+    rfc->pre_rd_fill_slba = ~0ULL;
+    rfc->pre_rd_fill_nlb = 0;
+    rfc->read_slba = slba;
+    rfc->read_nlb = nlb;
+    rfc->post_rd_fill_slba = ~0ULL;
+    rfc->post_rd_fill_nlb = 0;
+
+    status = nvme_zone_state_ok_to_read(zone);
+    if (status != NVME_SUCCESS) {
+        ;
+    } else if (likely(end <= bndry)) {
+        if (end > zone->w_ptr) {
+            wp1 = zone->w_ptr;
+            if (slba >= wp1) {
+                /* No i/o necessary, just fill */
+                rfc->pre_rd_fill_slba = slba;
+                rfc->pre_rd_fill_nlb = nlb;
+                rfc->read_nlb = 0;
+            } else {
+                rfc->read_nlb = wp1 - slba;
+                rfc->post_rd_fill_slba = wp1;
+                rfc->post_rd_fill_nlb = nlb - rfc->read_nlb;
+           }
+        }
+    } else if (!ns->params.cross_zone_read) {
+        status = NVME_ZONE_BOUNDARY_ERROR;
+    } else {
+        /*
+         * Read across zone boundary, look at the next zone.
+         * Earlier bounds checks ensure that the current zone
+         * is not the last one.
+         */
+        next_zone = zone + 1;
+        status = nvme_zone_state_ok_to_read(next_zone);
+        if (status != NVME_SUCCESS) {
+            ;
+        } else if (end > nvme_zone_rd_boundary(ns, next_zone)) {
+            /*
+             * As zone size is much larger than a typical maximum
+             * i/o size in real hardware, allow the i/o range
+             * to span no more than one pair of zones.
+             */
+            status = NVME_ZONE_BOUNDARY_ERROR;
+        } else {
+            wp1 = zone->w_ptr;
+            wp2 = next_zone->w_ptr;
+            if (wp2 == bndry) {
+                if (slba >= wp1) {
+                    /* Again, no i/o necessary, just fill */
+                    rfc->pre_rd_fill_slba = slba;
+                    rfc->pre_rd_fill_nlb = nlb;
+                    rfc->read_nlb = 0;
+                } else {
+                    rfc->read_nlb = wp1 - slba;
+                    rfc->post_rd_fill_slba = wp1;
+                    rfc->post_rd_fill_nlb = nlb - rfc->read_nlb;
+                }
+            } else if (slba < wp1) {
+                if (end > wp2) {
+                    if (wp1 == bndry) {
+                        rfc->post_rd_fill_slba = wp2;
+                        rfc->post_rd_fill_nlb = end - wp2;
+                        rfc->read_nlb = wp2 - slba;
+                    } else {
+                        rfc->pre_rd_fill_slba = wp2;
+                        rfc->pre_rd_fill_nlb = end - wp2;
+                        rfc->read_nlb = wp2 - slba;
+                        rfc->post_rd_fill_slba = wp1;
+                        rfc->post_rd_fill_nlb = bndry - wp1;
+                    }
+                } else {
+                    rfc->post_rd_fill_slba = wp1;
+                    rfc->post_rd_fill_nlb = bndry - wp1;
+                }
+            } else {
+                if (end > wp2) {
+                    rfc->pre_rd_fill_slba = slba;
+                    rfc->pre_rd_fill_nlb = end - slba;
+                    rfc->read_slba = bndry;
+                    rfc->read_nlb = wp2 - bndry;
+                } else {
+                    rfc->read_slba = bndry;
+                    rfc->read_nlb = end - bndry;
+                    rfc->post_rd_fill_slba = slba;
+                    rfc->post_rd_fill_nlb = bndry - slba;
+                }
+            }
+        }
+    }
+
+    return status;
+}
+
+static bool nvme_finalize_zoned_write(NvmeNamespace *ns, NvmeRequest *req,
+                                      bool failed)
+{
+    NvmeRwCmd *rw = (NvmeRwCmd *)&req->cmd;
+    NvmeZone *zone;
+    uint64_t slba, start_wp = req->cqe.result64;
+    uint32_t nlb;
+
+    if (rw->opcode != NVME_CMD_WRITE &&
+        rw->opcode != NVME_CMD_ZONE_APPEND &&
+        rw->opcode != NVME_CMD_WRITE_ZEROES) {
+        return false;
+    }
+
+    slba = le64_to_cpu(rw->slba);
+    nlb = le16_to_cpu(rw->nlb) + 1;
+    zone = nvme_get_zone_by_slba(ns, slba);
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
+            zone->d.wp = start_wp;
+        }
+        req->cqe.result64 = 0;
+    } else if (zone->w_ptr == nvme_zone_wr_boundary(zone)) {
+        switch (nvme_get_zone_state(zone)) {
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
@@ -924,10 +1294,27 @@ static void nvme_rw_cb(void *opaque, int ret)
     trace_pci_nvme_rw_cb(nvme_cid(req), blk_name(blk));
 
     if (!ret) {
-        block_acct_done(stats, acct);
+        if (ns->params.zoned) {
+            if (nvme_finalize_zoned_write(ns, req, false)) {
+                ret = EIO;
+                block_acct_failed(stats, acct);
+                req->status = NVME_ZONE_INVALID_WRITE;
+            } else if (req->fill_len) {
+                nvme_fill_read_data(req, req->fill_ofs, req->fill_len,
+                                    nvme_ctrl(req)->params.fill_pattern);
+                req->fill_len = 0;
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
@@ -969,8 +1356,10 @@ static uint16_t nvme_write_zeroes(NvmeCtrl *n, NvmeRequest *req)
     NvmeNamespace *ns = req->ns;
     uint64_t slba = le64_to_cpu(rw->slba);
     uint32_t nlb = (uint32_t)le16_to_cpu(rw->nlb) + 1;
+    NvmeZone *zone;
     uint64_t offset = nvme_l2b(ns, slba);
     uint32_t count = nvme_l2b(ns, nlb);
+    BlockBackend *blk = ns->blkconf.blk;
     uint16_t status;
 
     trace_pci_nvme_write_zeroes(nvme_cid(req), nvme_nsid(ns), slba, nlb);
@@ -981,24 +1370,41 @@ static uint16_t nvme_write_zeroes(NvmeCtrl *n, NvmeRequest *req)
         return status;
     }
 
-    block_acct_start(blk_get_stats(req->ns->blkconf.blk), &req->acct, 0,
-                     BLOCK_ACCT_WRITE);
-    req->aiocb = blk_aio_pwrite_zeroes(req->ns->blkconf.blk, offset, count,
+    if (ns->params.zoned) {
+        zone = nvme_get_zone_by_slba(ns, slba);
+
+        status = nvme_check_zone_write(n, ns, zone, slba, nlb, false);
+        if (status != NVME_SUCCESS) {
+            goto invalid;
+        }
+
+        req->cqe.result64 = nvme_advance_zone_wp(ns, zone, nlb);
+    }
+
+    block_acct_start(blk_get_stats(blk), &req->acct, 0, BLOCK_ACCT_WRITE);
+    req->aiocb = blk_aio_pwrite_zeroes(blk, offset, count,
                                        BDRV_REQ_MAY_UNMAP, nvme_rw_cb, req);
     return NVME_NO_COMPLETE;
+
+invalid:
+    block_acct_invalid(blk_get_stats(blk), BLOCK_ACCT_WRITE);
+    return status | NVME_DNR;
 }
 
-static uint16_t nvme_rw(NvmeCtrl *n, NvmeRequest *req)
+static uint16_t nvme_rw(NvmeCtrl *n, NvmeRequest *req, bool append)
 {
     NvmeRwCmd *rw = (NvmeRwCmd *)&req->cmd;
     NvmeNamespace *ns = req->ns;
     uint32_t nlb = (uint32_t)le16_to_cpu(rw->nlb) + 1;
     uint64_t slba = le64_to_cpu(rw->slba);
-
     uint64_t data_size = nvme_l2b(ns, nlb);
-    uint64_t data_offset = nvme_l2b(ns, slba);
-    enum BlockAcctType acct = req->cmd.opcode == NVME_CMD_WRITE ?
-        BLOCK_ACCT_WRITE : BLOCK_ACCT_READ;
+    uint64_t data_offset, fill_ofs;
+
+    NvmeZone *zone;
+    uint32_t fill_len;
+    NvmeReadFillCtx rfc;
+    bool is_write = rw->opcode == NVME_CMD_WRITE || append;
+    enum BlockAcctType acct = is_write ? BLOCK_ACCT_WRITE : BLOCK_ACCT_READ;
     BlockBackend *blk = ns->blkconf.blk;
     uint16_t status;
 
@@ -1017,14 +1423,71 @@ static uint16_t nvme_rw(NvmeCtrl *n, NvmeRequest *req)
         goto invalid;
     }
 
+    if (ns->params.zoned) {
+        zone = nvme_get_zone_by_slba(ns, slba);
+
+        if (is_write) {
+            status = nvme_check_zone_write(n, ns, zone, slba, nlb, append);
+            if (status != NVME_SUCCESS) {
+                goto invalid;
+            }
+
+            if (append) {
+                slba = zone->w_ptr;
+            }
+
+            req->cqe.result64 = nvme_advance_zone_wp(ns, zone, nlb);
+        } else {
+            status = nvme_check_zone_read(ns, zone, slba, nlb, &rfc);
+            if (status != NVME_SUCCESS) {
+                trace_pci_nvme_err_zone_read_not_ok(slba, nlb, status);
+                goto invalid;
+            }
+        }
+    } else if (append) {
+        trace_pci_nvme_err_invalid_opc(rw->opcode);
+        status = NVME_INVALID_OPCODE;
+        goto invalid;
+    }
+
+    data_offset = nvme_l2b(ns, slba);
+
     status = nvme_map_dptr(n, data_size, req);
     if (status) {
         goto invalid;
     }
 
+    if (ns->params.zoned) {
+        if (is_write) {
+            req->cqe.result64 = nvme_advance_zone_wp(ns, zone, nlb);
+        } else {
+            if (rfc.pre_rd_fill_nlb) {
+                fill_ofs = nvme_l2b(ns, rfc.pre_rd_fill_slba - slba);
+                fill_len = nvme_l2b(ns, rfc.pre_rd_fill_nlb);
+                nvme_fill_read_data(req, fill_ofs, fill_len,
+                                    n->params.fill_pattern);
+            }
+            if (!rfc.read_nlb) {
+                /* No backend I/O necessary, only needed to fill the buffer */
+                req->status = NVME_SUCCESS;
+                return NVME_SUCCESS;
+            }
+            if (rfc.post_rd_fill_nlb) {
+                req->fill_ofs = nvme_l2b(ns, rfc.post_rd_fill_slba - slba);
+                req->fill_len = nvme_l2b(ns, rfc.post_rd_fill_nlb);
+            } else {
+                req->fill_len = 0;
+            }
+            slba = rfc.read_slba;
+            data_size = nvme_l2b(ns, rfc.read_nlb);
+        }
+    }
+
+    data_offset = nvme_l2b(ns, slba);
+
     block_acct_start(blk_get_stats(blk), &req->acct, data_size, acct);
     if (req->qsg.sg) {
-        if (acct == BLOCK_ACCT_WRITE) {
+        if (is_write) {
             req->aiocb = dma_blk_write(blk, &req->qsg, data_offset,
                                        BDRV_SECTOR_SIZE, nvme_rw_cb, req);
         } else {
@@ -1032,7 +1495,7 @@ static uint16_t nvme_rw(NvmeCtrl *n, NvmeRequest *req)
                                       BDRV_SECTOR_SIZE, nvme_rw_cb, req);
         }
     } else {
-        if (acct == BLOCK_ACCT_WRITE) {
+        if (is_write) {
             req->aiocb = blk_aio_pwritev(blk, data_offset, &req->iov, 0,
                                          nvme_rw_cb, req);
         } else {
@@ -1043,10 +1506,383 @@ static uint16_t nvme_rw(NvmeCtrl *n, NvmeRequest *req)
     return NVME_NO_COMPLETE;
 
 invalid:
-    block_acct_invalid(blk_get_stats(ns->blkconf.blk), acct);
+    block_acct_invalid(blk_get_stats(blk), acct);
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
@@ -1076,9 +1912,15 @@ static uint16_t nvme_io_cmd(NvmeCtrl *n, NvmeRequest *req)
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
         assert(false);
     }
@@ -1320,10 +2162,11 @@ static uint16_t nvme_error_info(NvmeCtrl *n, uint8_t rae, uint32_t buf_len,
                     DMA_DIRECTION_FROM_DEVICE, req);
 }
 
-static uint16_t nvme_cmd_effects(NvmeCtrl *n, uint32_t buf_len,
+static uint16_t nvme_cmd_effects(NvmeCtrl *n, uint8_t csi, uint32_t buf_len,
                                  uint64_t off, NvmeRequest *req)
 {
     NvmeEffectsLog log = {};
+    const uint32_t *src_iocs = NULL;
     uint32_t *dst_acs = log.acs, *dst_iocs = log.iocs;
     uint32_t trans_len;
     int i;
@@ -1335,13 +2178,31 @@ static uint16_t nvme_cmd_effects(NvmeCtrl *n, uint32_t buf_len,
         return NVME_INVALID_FIELD | NVME_DNR;
     }
 
+    switch (NVME_CC_CSS(n->bar.cc)) {
+    case NVME_CC_CSS_NVM:
+        src_iocs = nvme_cse_iocs_nvm;
+        break;
+    case NVME_CC_CSS_CSI:
+        switch (csi) {
+        case NVME_CSI_NVM:
+            src_iocs = nvme_cse_iocs_nvm;
+            break;
+        case NVME_CSI_ZONED:
+            src_iocs = nvme_cse_iocs_zoned;
+            break;
+        }
+        /* fall through */
+    case NVME_CC_CSS_ADMIN_ONLY:
+        break;
+    }
+
     for (i = 0; i < 256; i++) {
         dst_acs[i] = nvme_cse_acs[i];
     }
 
-    if (NVME_CC_CSS(n->bar.cc) != NVME_CC_CSS_ADMIN_ONLY) {
+    if (src_iocs) {
         for (i = 0; i < 256; i++) {
-            dst_iocs[i] = nvme_cse_iocs_nvm[i];
+            dst_iocs[i] = src_iocs[i];
         }
     }
 
@@ -1362,6 +2223,7 @@ static uint16_t nvme_get_log(NvmeCtrl *n, NvmeRequest *req)
     uint8_t  lid = dw10 & 0xff;
     uint8_t  lsp = (dw10 >> 8) & 0xf;
     uint8_t  rae = (dw10 >> 15) & 0x1;
+    uint8_t csi = le32_to_cpu(cmd->cdw14) >> 24;
     uint32_t numdl, numdu;
     uint64_t off, lpol, lpou;
     size_t   len;
@@ -1395,7 +2257,7 @@ static uint16_t nvme_get_log(NvmeCtrl *n, NvmeRequest *req)
     case NVME_LOG_FW_SLOT_INFO:
         return nvme_fw_log_info(n, len, off, req);
     case NVME_LOG_CMD_EFFECTS:
-        return nvme_cmd_effects(n, len, off, req);
+        return nvme_cmd_effects(n, csi, len, off, req);
     default:
         trace_pci_nvme_err_invalid_log_page(nvme_cid(req), lid);
         return NVME_INVALID_FIELD | NVME_DNR;
@@ -1515,6 +2377,16 @@ static uint16_t nvme_rpt_empty_id_struct(NvmeCtrl *n, NvmeRequest *req)
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
@@ -1526,11 +2398,16 @@ static uint16_t nvme_identify_ctrl(NvmeCtrl *n, NvmeRequest *req)
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
@@ -1558,8 +2435,12 @@ static uint16_t nvme_identify_ns(NvmeCtrl *n, NvmeRequest *req,
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
@@ -1584,8 +2465,11 @@ static uint16_t nvme_identify_ns_csi(NvmeCtrl *n, NvmeRequest *req,
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
@@ -1647,7 +2531,7 @@ static uint16_t nvme_identify_nslist_csi(NvmeCtrl *n, NvmeRequest *req,
 
     trace_pci_nvme_identify_nslist_csi(min_nsid, c->csi);
 
-    if (c->csi != NVME_CSI_NVM) {
+    if (c->csi != NVME_CSI_NVM && c->csi != NVME_CSI_ZONED) {
         return NVME_INVALID_FIELD | NVME_DNR;
     }
 
@@ -1656,7 +2540,7 @@ static uint16_t nvme_identify_nslist_csi(NvmeCtrl *n, NvmeRequest *req,
         if (!ns) {
             continue;
         }
-        if (ns->params.nsid < min_nsid) {
+        if (ns->params.nsid < min_nsid || c->csi != ns->csi) {
             continue;
         }
         if (only_active && !ns->params.attached) {
@@ -1726,6 +2610,8 @@ static uint16_t nvme_identify_cmd_set(NvmeCtrl *n, NvmeRequest *req)
     trace_pci_nvme_identify_cmd_set();
 
     NVME_SET_CSI(*list, NVME_CSI_NVM);
+    NVME_SET_CSI(*list, NVME_CSI_ZONED);
+
     return nvme_dma(n, list, data_len, DMA_DIRECTION_FROM_DEVICE, req);
 }
 
@@ -1768,7 +2654,7 @@ static uint16_t nvme_abort(NvmeCtrl *n, NvmeRequest *req)
 {
     uint16_t sqid = le32_to_cpu(req->cmd.cdw10) & 0xffff;
 
-    req->cqe.result = 1;
+    req->cqe.result32 = 1;
     if (nvme_check_sqid(n, sqid)) {
         return NVME_INVALID_FIELD | NVME_DNR;
     }
@@ -1953,7 +2839,7 @@ defaults:
     }
 
 out:
-    req->cqe.result = cpu_to_le32(result);
+    req->cqe.result32 = cpu_to_le32(result);
     return NVME_SUCCESS;
 }
 
@@ -2084,8 +2970,8 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeRequest *req)
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
@@ -2240,6 +3126,15 @@ static void nvme_clear_ctrl(NvmeCtrl *n)
         nvme_ns_flush(ns);
     }
 
+    for (i = 1; i <= n->num_namespaces; i++) {
+        ns = nvme_ns(n, i);
+        if (!ns) {
+            continue;
+        }
+
+        nvme_ns_clear(ns);
+    }
+
     n->bar.cc = 0;
 }
 
@@ -2260,6 +3155,11 @@ static void nvme_select_ns_iocs(NvmeCtrl *n)
                 ns->iocs = nvme_cse_iocs_nvm;
             }
             break;
+        case NVME_CSI_ZONED:
+            if (NVME_CC_CSS(n->bar.cc) == NVME_CC_CSS_CSI) {
+                ns->iocs = nvme_cse_iocs_zoned;
+            }
+            break;
         }
     }
 }
@@ -2358,6 +3258,17 @@ static int nvme_start_ctrl(NvmeCtrl *n)
     nvme_init_sq(&n->admin_sq, n, n->bar.asq, 0, 0,
                  NVME_AQA_ASQS(n->bar.aqa) + 1);
 
+    if (!n->params.zasl_bs) {
+        n->zasl = n->params.mdts;
+    } else {
+        if (n->params.zasl_bs < n->page_size) {
+            trace_pci_nvme_err_startfail_zasl_too_small(n->params.zasl_bs,
+                                                        n->page_size);
+            return -1;
+        }
+        n->zasl = 31 - clz32(n->params.zasl_bs / n->page_size);
+    }
+
     nvme_set_timestamp(n, 0ULL);
 
     QTAILQ_INIT(&n->aer_queue);
@@ -2782,6 +3693,13 @@ static void nvme_check_constraints(NvmeCtrl *n, Error **errp)
 
         host_memory_backend_set_mapped(n->pmrdev, true);
     }
+
+    if (n->params.zasl_bs) {
+        if (!is_power_of_2(n->params.zasl_bs)) {
+            error_setg(errp, "zone append size limit has to be a power of 2");
+            return;
+        }
+    }
 }
 
 static void nvme_init_state(NvmeCtrl *n)
@@ -3047,9 +3965,21 @@ static void nvme_realize(PCIDevice *pci_dev, Error **errp)
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
@@ -3077,6 +4007,9 @@ static Property nvme_props[] = {
     DEFINE_PROP_UINT32("aer_max_queued", NvmeCtrl, params.aer_max_queued, 64),
     DEFINE_PROP_UINT8("mdts", NvmeCtrl, params.mdts, 7),
     DEFINE_PROP_BOOL("use-intel-id", NvmeCtrl, params.use_intel_id, false),
+    DEFINE_PROP_UINT8("fill_pattern", NvmeCtrl, params.fill_pattern, 0),
+    DEFINE_PROP_SIZE32("zone_append_size_limit", NvmeCtrl, params.zasl_bs,
+                       NVME_DEFAULT_MAX_ZA_SIZE),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/hw/block/nvme.h b/hw/block/nvme.h
index e080a2318a..c406cb1c65 100644
--- a/hw/block/nvme.h
+++ b/hw/block/nvme.h
@@ -6,6 +6,9 @@
 
 #define NVME_MAX_NAMESPACES 256
 
+#define NVME_DEFAULT_ZONE_SIZE   (128 * MiB)
+#define NVME_DEFAULT_MAX_ZA_SIZE (128 * KiB)
+
 typedef struct NvmeParams {
     char     *serial;
     uint32_t num_queues; /* deprecated since 5.1 */
@@ -16,6 +19,8 @@ typedef struct NvmeParams {
     uint32_t aer_max_queued;
     uint8_t  mdts;
     bool     use_intel_id;
+    uint8_t  fill_pattern;
+    uint32_t zasl_bs;
 } NvmeParams;
 
 typedef struct NvmeAsyncEvent {
@@ -28,6 +33,8 @@ typedef struct NvmeRequest {
     struct NvmeNamespace    *ns;
     BlockAIOCB              *aiocb;
     uint16_t                status;
+    uint64_t                fill_ofs;
+    uint32_t                fill_len;
     NvmeCqe                 cqe;
     NvmeCmd                 cmd;
     BlockAcctCookie         acct;
@@ -147,6 +154,8 @@ typedef struct NvmeCtrl {
     QTAILQ_HEAD(, NvmeAsyncEvent) aer_queue;
     int         aer_queued;
 
+    uint8_t     zasl;
+
     NvmeNamespace   namespace;
     NvmeNamespace   *namespaces[NVME_MAX_NAMESPACES];
     NvmeSQueue      **sq;
diff --git a/hw/block/trace-events b/hw/block/trace-events
index 65b964c894..af53e31fcb 100644
--- a/hw/block/trace-events
+++ b/hw/block/trace-events
@@ -90,6 +90,15 @@ pci_nvme_mmio_stopped(void) "cleared controller enable bit"
 pci_nvme_mmio_shutdown_set(void) "shutdown bit set"
 pci_nvme_mmio_shutdown_cleared(void) "shutdown bit cleared"
 pci_nvme_cmd_supp_and_effects_log_read(void) "commands supported and effects log read"
+pci_nvme_open_zone(uint64_t slba, uint32_t zone_idx, int all) "open zone, slba=%"PRIu64", idx=%"PRIu32", all=%"PRIi32""
+pci_nvme_close_zone(uint64_t slba, uint32_t zone_idx, int all) "close zone, slba=%"PRIu64", idx=%"PRIu32", all=%"PRIi32""
+pci_nvme_finish_zone(uint64_t slba, uint32_t zone_idx, int all) "finish zone, slba=%"PRIu64", idx=%"PRIu32", all=%"PRIi32""
+pci_nvme_reset_zone(uint64_t slba, uint32_t zone_idx, int all) "reset zone, slba=%"PRIu64", idx=%"PRIu32", all=%"PRIi32""
+pci_nvme_offline_zone(uint64_t slba, uint32_t zone_idx, int all) "offline zone, slba=%"PRIu64", idx=%"PRIu32", all=%"PRIi32""
+pci_nvme_set_descriptor_extension(uint64_t slba, uint32_t zone_idx) "set zone descriptor extension, slba=%"PRIu64", idx=%"PRIu32""
+pci_nvme_clear_ns_close(uint32_t state, uint64_t slba) "zone state=%"PRIu32", slba=%"PRIu64" transitioned to Closed state"
+pci_nvme_clear_ns_reset(uint32_t state, uint64_t slba) "zone state=%"PRIu32", slba=%"PRIu64" transitioned to Empty state"
+pci_nvme_clear_ns_full(uint32_t state, uint64_t slba) "zone state=%"PRIu32", slba=%"PRIu64" transitioned to Full state"
 
 # nvme traces for error conditions
 pci_nvme_err_mdts(uint16_t cid, size_t len) "cid %"PRIu16" len %zu"
@@ -109,8 +118,18 @@ pci_nvme_err_invalid_prp(void) "invalid PRP"
 pci_nvme_err_invalid_opc(uint8_t opc) "invalid opcode 0x%"PRIx8""
 pci_nvme_err_invalid_admin_opc(uint8_t opc) "invalid admin opcode 0x%"PRIx8""
 pci_nvme_err_invalid_lba_range(uint64_t start, uint64_t len, uint64_t limit) "Invalid LBA start=%"PRIu64" len=%"PRIu64" limit=%"PRIu64""
+pci_nvme_err_unaligned_zone_cmd(uint8_t action, uint64_t slba, uint64_t zslba) "unaligned zone op 0x%"PRIx32", got slba=%"PRIu64", zslba=%"PRIu64""
+pci_nvme_err_invalid_zone_state_transition(uint8_t state, uint8_t action, uint64_t slba, uint8_t attrs) "0x%"PRIx32"->0x%"PRIx32", slba=%"PRIu64", attrs=0x%"PRIx32""
+pci_nvme_err_write_not_at_wp(uint64_t slba, uint64_t zone, uint64_t wp) "writing at slba=%"PRIu64", zone=%"PRIu64", but wp=%"PRIu64""
+pci_nvme_err_append_not_at_start(uint64_t slba, uint64_t zone) "appending at slba=%"PRIu64", but zone=%"PRIu64""
+pci_nvme_err_zone_write_not_ok(uint64_t slba, uint32_t nlb, uint32_t status) "slba=%"PRIu64", nlb=%"PRIu32", status=0x%"PRIx16""
+pci_nvme_err_zone_read_not_ok(uint64_t slba, uint32_t nlb, uint32_t status) "slba=%"PRIu64", nlb=%"PRIu32", status=0x%"PRIx16""
+pci_nvme_err_append_too_large(uint64_t slba, uint32_t nlb, uint8_t zasl) "slba=%"PRIu64", nlb=%"PRIu32", zasl=%"PRIu8""
+pci_nvme_err_insuff_active_res(uint32_t max_active) "max_active=%"PRIu32" zone limit exceeded"
+pci_nvme_err_insuff_open_res(uint32_t max_open) "max_open=%"PRIu32" zone limit exceeded"
 pci_nvme_err_invalid_effects_log_offset(uint64_t ofs) "commands supported and effects log offset must be 0, got %"PRIu64""
 pci_nvme_err_only_nvm_cmd_set_avail(void) "setting 110b CC.CSS, but only NVM command set is enabled"
+pci_nvme_err_only_zoned_cmd_set_avail(void) "setting 001b CC.CSS, but only ZONED+NVM command set is enabled"
 pci_nvme_err_invalid_iocsci(uint32_t idx) "unsupported command set combination index %"PRIu32""
 pci_nvme_err_invalid_del_sq(uint16_t qid) "invalid submission queue deletion, sid=%"PRIu16""
 pci_nvme_err_invalid_create_sq_cqid(uint16_t cqid) "failed creating submission queue, invalid cqid=%"PRIu16""
@@ -144,7 +163,9 @@ pci_nvme_err_startfail_sqent_too_large(uint8_t log2ps, uint8_t maxlog2ps) "nvme_
 pci_nvme_err_startfail_css(uint8_t css) "nvme_start_ctrl failed because invalid command set selected:%u"
 pci_nvme_err_startfail_asqent_sz_zero(void) "nvme_start_ctrl failed because the admin submission queue size is zero"
 pci_nvme_err_startfail_acqent_sz_zero(void) "nvme_start_ctrl failed because the admin completion queue size is zero"
+pci_nvme_err_startfail_zasl_too_small(uint32_t zasl, uint32_t pagesz) "nvme_start_ctrl failed because zone append size limit %"PRIu32" is too small, needs to be >= %"PRIu32""
 pci_nvme_err_startfail(void) "setting controller enable bit failed"
+pci_nvme_err_invalid_mgmt_action(int action) "action=0x%"PRIx8""
 
 # Traces for undefined behavior
 pci_nvme_ub_mmiowr_misaligned32(uint64_t offset) "MMIO write not 32-bit aligned, offset=0x%"PRIx64""
diff --git a/include/block/nvme.h b/include/block/nvme.h
index 27125c9d28..54bc93b6ab 100644
--- a/include/block/nvme.h
+++ b/include/block/nvme.h
@@ -489,6 +489,9 @@ enum NvmeIoCommands {
     NVME_CMD_COMPARE            = 0x05,
     NVME_CMD_WRITE_ZEROES       = 0x08,
     NVME_CMD_DSM                = 0x09,
+    NVME_CMD_ZONE_MGMT_SEND     = 0x79,
+    NVME_CMD_ZONE_MGMT_RECV     = 0x7a,
+    NVME_CMD_ZONE_APPEND        = 0x7d,
 };
 
 typedef struct QEMU_PACKED NvmeDeleteQ {
@@ -649,8 +652,10 @@ typedef struct QEMU_PACKED NvmeAerResult {
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
@@ -678,6 +683,7 @@ enum NvmeStatusCodes {
     NVME_SGL_DESCR_TYPE_INVALID = 0x0011,
     NVME_INVALID_USE_OF_CMB     = 0x0012,
     NVME_CMD_SET_CMB_REJECTED   = 0x002b,
+    NVME_INVALID_CMD_SET        = 0x002c,
     NVME_LBA_RANGE              = 0x0080,
     NVME_CAP_EXCEEDED           = 0x0081,
     NVME_NS_NOT_READY           = 0x0082,
@@ -702,6 +708,14 @@ enum NvmeStatusCodes {
     NVME_CONFLICTING_ATTRS      = 0x0180,
     NVME_INVALID_PROT_INFO      = 0x0181,
     NVME_WRITE_TO_RO            = 0x0182,
+    NVME_ZONE_BOUNDARY_ERROR    = 0x01b8,
+    NVME_ZONE_FULL              = 0x01b9,
+    NVME_ZONE_READ_ONLY         = 0x01ba,
+    NVME_ZONE_OFFLINE           = 0x01bb,
+    NVME_ZONE_INVALID_WRITE     = 0x01bc,
+    NVME_ZONE_TOO_MANY_ACTIVE   = 0x01bd,
+    NVME_ZONE_TOO_MANY_OPEN     = 0x01be,
+    NVME_ZONE_INVAL_TRANSITION  = 0x01bf,
     NVME_WRITE_FAULT            = 0x0280,
     NVME_UNRECOVERED_READ       = 0x0281,
     NVME_E2E_GUARD_ERROR        = 0x0282,
@@ -886,6 +900,11 @@ typedef struct QEMU_PACKED NvmeIdCtrl {
     uint8_t     vs[1024];
 } NvmeIdCtrl;
 
+typedef struct NvmeIdCtrlZoned {
+    uint8_t     zasl;
+    uint8_t     rsvd1[4095];
+} NvmeIdCtrlZoned;
+
 enum NvmeIdCtrlOacs {
     NVME_OACS_SECURITY  = 1 << 0,
     NVME_OACS_FORMAT    = 1 << 1,
@@ -1011,6 +1030,12 @@ typedef struct QEMU_PACKED NvmeLBAF {
     uint8_t     rp;
 } NvmeLBAF;
 
+typedef struct QEMU_PACKED NvmeLBAFE {
+    uint64_t    zsze;
+    uint8_t     zdes;
+    uint8_t     rsvd9[7];
+} NvmeLBAFE;
+
 #define NVME_NSID_BROADCAST 0xffffffff
 
 typedef struct QEMU_PACKED NvmeIdNs {
@@ -1065,10 +1090,24 @@ enum NvmeNsIdentifierType {
 
 enum NvmeCsi {
     NVME_CSI_NVM                = 0x00,
+    NVME_CSI_ZONED              = 0x02,
 };
 
 #define NVME_SET_CSI(vec, csi) (vec |= (uint8_t)(1 << (csi)))
 
+typedef struct QEMU_PACKED NvmeIdNsZoned {
+    uint16_t    zoc;
+    uint16_t    ozcs;
+    uint32_t    mar;
+    uint32_t    mor;
+    uint32_t    rrl;
+    uint32_t    frl;
+    uint8_t     rsvd20[2796];
+    NvmeLBAFE   lbafe[16];
+    uint8_t     rsvd3072[768];
+    uint8_t     vs[256];
+} NvmeIdNsZoned;
+
 /*Deallocate Logical Block Features*/
 #define NVME_ID_NS_DLFEAT_GUARD_CRC(dlfeat)       ((dlfeat) & 0x10)
 #define NVME_ID_NS_DLFEAT_WRITE_ZEROES(dlfeat)    ((dlfeat) & 0x08)
@@ -1100,6 +1139,71 @@ enum NvmeIdNsDps {
     DPS_FIRST_EIGHT = 8,
 };
 
+enum NvmeZoneAttr {
+    NVME_ZA_FINISHED_BY_CTLR         = 1 << 0,
+    NVME_ZA_FINISH_RECOMMENDED       = 1 << 1,
+    NVME_ZA_RESET_RECOMMENDED        = 1 << 2,
+    NVME_ZA_ZD_EXT_VALID             = 1 << 7,
+};
+
+typedef struct QEMU_PACKED NvmeZoneReportHeader {
+    uint64_t    nr_zones;
+    uint8_t     rsvd[56];
+} NvmeZoneReportHeader;
+
+enum NvmeZoneReceiveAction {
+    NVME_ZONE_REPORT                 = 0,
+    NVME_ZONE_REPORT_EXTENDED        = 1,
+};
+
+enum NvmeZoneReportType {
+    NVME_ZONE_REPORT_ALL             = 0,
+    NVME_ZONE_REPORT_EMPTY           = 1,
+    NVME_ZONE_REPORT_IMPLICITLY_OPEN = 2,
+    NVME_ZONE_REPORT_EXPLICITLY_OPEN = 3,
+    NVME_ZONE_REPORT_CLOSED          = 4,
+    NVME_ZONE_REPORT_FULL            = 5,
+    NVME_ZONE_REPORT_READ_ONLY       = 6,
+    NVME_ZONE_REPORT_OFFLINE         = 7,
+};
+
+enum NvmeZoneType {
+    NVME_ZONE_TYPE_RESERVED          = 0x00,
+    NVME_ZONE_TYPE_SEQ_WRITE         = 0x02,
+};
+
+enum NvmeZoneSendAction {
+    NVME_ZONE_ACTION_RSD             = 0x00,
+    NVME_ZONE_ACTION_CLOSE           = 0x01,
+    NVME_ZONE_ACTION_FINISH          = 0x02,
+    NVME_ZONE_ACTION_OPEN            = 0x03,
+    NVME_ZONE_ACTION_RESET           = 0x04,
+    NVME_ZONE_ACTION_OFFLINE         = 0x05,
+    NVME_ZONE_ACTION_SET_ZD_EXT      = 0x10,
+};
+
+typedef struct QEMU_PACKED NvmeZoneDescr {
+    uint8_t     zt;
+    uint8_t     zs;
+    uint8_t     za;
+    uint8_t     rsvd3[5];
+    uint64_t    zcap;
+    uint64_t    zslba;
+    uint64_t    wp;
+    uint8_t     rsvd32[32];
+} NvmeZoneDescr;
+
+enum NvmeZoneState {
+    NVME_ZONE_STATE_RESERVED         = 0x00,
+    NVME_ZONE_STATE_EMPTY            = 0x01,
+    NVME_ZONE_STATE_IMPLICITLY_OPEN  = 0x02,
+    NVME_ZONE_STATE_EXPLICITLY_OPEN  = 0x03,
+    NVME_ZONE_STATE_CLOSED           = 0x04,
+    NVME_ZONE_STATE_READ_ONLY        = 0x0D,
+    NVME_ZONE_STATE_FULL             = 0x0E,
+    NVME_ZONE_STATE_OFFLINE          = 0x0F,
+};
+
 static inline void _nvme_check_size(void)
 {
     QEMU_BUILD_BUG_ON(sizeof(NvmeBar) != 4096);
@@ -1119,9 +1223,14 @@ static inline void _nvme_check_size(void)
     QEMU_BUILD_BUG_ON(sizeof(NvmeSmartLog) != 512);
     QEMU_BUILD_BUG_ON(sizeof(NvmeEffectsLog) != 4096);
     QEMU_BUILD_BUG_ON(sizeof(NvmeIdCtrl) != 4096);
+    QEMU_BUILD_BUG_ON(sizeof(NvmeIdCtrlZoned) != 4096);
     QEMU_BUILD_BUG_ON(sizeof(NvmeIdNsDescr) != 4);
+    QEMU_BUILD_BUG_ON(sizeof(NvmeLBAF) != 4);
+    QEMU_BUILD_BUG_ON(sizeof(NvmeLBAFE) != 16);
     QEMU_BUILD_BUG_ON(sizeof(NvmeIdNs) != 4096);
+    QEMU_BUILD_BUG_ON(sizeof(NvmeIdNsZoned) != 4096);
     QEMU_BUILD_BUG_ON(sizeof(NvmeSglDescriptor) != 16);
     QEMU_BUILD_BUG_ON(sizeof(NvmeIdNsDescr) != 4);
+    QEMU_BUILD_BUG_ON(sizeof(NvmeZoneDescr) != 64);
 }
 #endif
-- 
2.21.0


