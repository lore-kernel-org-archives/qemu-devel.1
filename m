Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3935C2D0A8
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 18:32:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D67102193E
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 18:32:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Puno4wCm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D67102193E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54962 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kL9Z9-0007Ic-HE
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 14:32:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53738)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=5287de305=dmitry.fomichev@wdc.com>)
 id 1kL9OZ-0005MK-Bs; Wed, 23 Sep 2020 14:21:36 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:35018)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=5287de305=dmitry.fomichev@wdc.com>)
 id 1kL9OT-00087W-HV; Wed, 23 Sep 2020 14:21:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1600886231; x=1632422231;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=3KetV6nK27WeNS7OUUDqKj4KIVGYy59etCGap2IOGJU=;
 b=Puno4wCm3WbBZTBsx6jWRXCbz/gd+72HO9mM+gg2xb0MgzaAUhkr3vhG
 2Vs28b8rSDVrXmfKXUBTYXryf69dIBTL7h8Odup0LoVMSnXGqTHZR70r3
 VYsjsgOHAyRfGncmJivOTiU6KQSm0nyHcEmSLMJGJTt6z23SAVQL35USp
 NnITbGQiuKKzhcl6dICmfK+4uXO2ossVyn/wMEYZanFDGLWC92hSX9YKT
 jS0PG+LKTWOWWAg/e8U8OI32+sYjUlmiDSgkCFdtfuKbVeEGvkgVQaLwx
 LoEf3C0eDyQFcEs4EjRtpAKJ+ho6c0BibW0M+I++V02HX87XSMHKTUOQZ A==;
IronPort-SDR: fFC8/wzLwiqyA8yTrPKi37gATe3ZxNM6Kf5MYFjWvHxcaat95/okWW/av3p7Y7ZeyRS2oSRca2
 KWMmOrGGoWZL+sM4OVAPT5VkVAQia3WDH5aAeMjrgOiG+wT2ckIeshRGUKFCJyT6HOTZhDbUps
 D8n5V4h2Uun1z9xnTPUirzXuTGe2TtDmKtppQ0MrkQpb/tLBcm3qQtKCA6vm2DoRLXWiAOSovd
 ohFebPqTu6aNn/OTAdFSee1X6KQ6e5auJywVzqnaB/2pJbQm1rzc68dXhciKqgd3Ic99dujewm
 tv8=
X-IronPort-AV: E=Sophos;i="5.77,293,1596470400"; d="scan'208";a="251496390"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 24 Sep 2020 02:36:52 +0800
IronPort-SDR: lHTv8xJSU7ZtuVfXJjBCnumZVi1UYIZq1gotLaTzLNxiK+SryZge0zATiji2ppOdW37i7lJEsx
 tXP5us3BT7oQ==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Sep 2020 11:07:23 -0700
IronPort-SDR: 8YxnkWUupWPL0NP+z/p8pKj7Yih6Xt3SCA6wjCTSDWurS78+V/4v/vioX20DCLa8Je5O0lDCts
 Myv2EtCfO3sA==
WDCIronportException: Internal
Received: from unknown (HELO redsun50.ssa.fujisawa.hgst.com) ([10.149.66.24])
 by uls-op-cesaip02.wdc.com with ESMTP; 23 Sep 2020 11:21:15 -0700
From: Dmitry Fomichev <dmitry.fomichev@wdc.com>
To: Keith Busch <kbusch@kernel.org>, Klaus Jensen <k.jensen@samsung.com>,
 Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Maxim Levitsky <mlevitsk@redhat.com>, Fam Zheng <fam@euphon.net>
Subject: [PATCH v4 13/14] hw/block/nvme: Use zone metadata file for persistence
Date: Thu, 24 Sep 2020 03:20:20 +0900
Message-Id: <20200923182021.3724-14-dmitry.fomichev@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200923182021.3724-1-dmitry.fomichev@wdc.com>
References: <20200923182021.3724-1-dmitry.fomichev@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=68.232.143.124;
 envelope-from=prvs=5287de305=dmitry.fomichev@wdc.com; helo=esa2.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/23 14:20:48
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

A ZNS drive that is emulated by this module is currently initialized
with all zones Empty upon startup. However, actual ZNS SSDs save the
state and condition of all zones in their internal NVRAM in the event
of power loss. When such a drive is powered up again, it closes or
finishes all zones that were open at the moment of shutdown. Besides
that, the write pointer position as well as the state and condition
of all zones is preserved across power-downs.

This commit adds the capability to have a persistent zone metadata
to the device. The new optional module property, "zone_file",
is introduced. If added to the command line, this property specifies
the name of the file that stores the zone metadata. If "zone_file" is
omitted, the device will be initialized with all zones empty, the same
as before.

If zone metadata is configured to be persistent, then zone descriptor
extensions also persist across controller shutdowns.

Signed-off-by: Dmitry Fomichev <dmitry.fomichev@wdc.com>
---
 hw/block/nvme.c       | 377 +++++++++++++++++++++++++++++++++++++++---
 hw/block/nvme.h       |  38 +++++
 hw/block/trace-events |   1 +
 3 files changed, 395 insertions(+), 21 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 4630be38d7..5f55e86a9a 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -111,6 +111,8 @@ static const uint32_t nvme_feature_cap[NVME_FID_MAX] = {
 };
 
 static void nvme_process_sq(void *opaque);
+static void nvme_sync_zone_file(NvmeCtrl *n, NvmeNamespace *ns,
+                                NvmeZone *zone, int len);
 
 static uint16_t nvme_cid(NvmeRequest *req)
 {
@@ -146,6 +148,7 @@ static void nvme_add_zone_tail(NvmeCtrl *n, NvmeNamespace *ns, NvmeZoneList *zl,
         zl->tail = idx;
     }
     zl->size++;
+    nvme_set_zone_meta_dirty(n, ns, true);
 }
 
 /*
@@ -162,12 +165,15 @@ static void nvme_remove_zone(NvmeCtrl *n, NvmeNamespace *ns, NvmeZoneList *zl,
     if (zl->size == 0) {
         zl->head = NVME_ZONE_LIST_NIL;
         zl->tail = NVME_ZONE_LIST_NIL;
+        nvme_set_zone_meta_dirty(n, ns, true);
     } else if (idx == zl->head) {
         zl->head = zone->next;
         ns->zone_array[zl->head].prev = NVME_ZONE_LIST_NIL;
+        nvme_set_zone_meta_dirty(n, ns, true);
     } else if (idx == zl->tail) {
         zl->tail = zone->prev;
         ns->zone_array[zl->tail].next = NVME_ZONE_LIST_NIL;
+        nvme_set_zone_meta_dirty(n, ns, true);
     } else {
         ns->zone_array[zone->next].prev = zone->prev;
         ns->zone_array[zone->prev].next = zone->next;
@@ -194,6 +200,7 @@ static NvmeZone *nvme_remove_zone_head(NvmeCtrl *n, NvmeNamespace *ns,
             ns->zone_array[zl->head].prev = NVME_ZONE_LIST_NIL;
         }
         zone->prev = zone->next = 0;
+        nvme_set_zone_meta_dirty(n, ns, true);
     }
 
     return zone;
@@ -290,11 +297,13 @@ static void nvme_assign_zone_state(NvmeCtrl *n, NvmeNamespace *ns,
         break;
     case NVME_ZONE_STATE_FULL:
         nvme_add_zone_tail(n, ns, ns->full_zones, zone);
+        /* fall through */
     case NVME_ZONE_STATE_READ_ONLY:
         break;
     default:
         zone->d.za = 0;
     }
+    nvme_sync_zone_file(n, ns, zone, sizeof(NvmeZone));
 }
 
 static bool nvme_addr_is_cmb(NvmeCtrl *n, hwaddr addr)
@@ -3398,9 +3407,114 @@ static const MemoryRegionOps nvme_cmb_ops = {
     },
 };
 
-static int nvme_init_zone_meta(NvmeCtrl *n, NvmeNamespace *ns,
+static int nvme_validate_zone_file(NvmeCtrl *n, NvmeNamespace *ns,
+                                   uint64_t capacity)
+{
+    NvmeZoneMeta *meta = ns->zone_meta;
+    NvmeZone *zone = ns->zone_array;
+    uint64_t start = 0, zone_size = n->zone_size;
+    int i, n_imp_open = 0, n_exp_open = 0, n_closed = 0, n_full = 0;
+
+    if (meta->magic != NVME_ZONE_META_MAGIC) {
+        return 1;
+    }
+    if (meta->version != NVME_ZONE_META_VER) {
+        return 2;
+    }
+    if (meta->zone_size != zone_size) {
+        return 3;
+    }
+    if (meta->zone_capacity != n->zone_capacity) {
+        return 4;
+    }
+    if (meta->nr_offline_zones != n->params.nr_offline_zones) {
+        return 5;
+    }
+    if (meta->nr_rdonly_zones != n->params.nr_rdonly_zones) {
+        return 6;
+    }
+    if (meta->lba_size != n->conf.logical_block_size) {
+        return 7;
+    }
+    if (meta->zd_extension_size != n->params.zd_extension_size) {
+        return 8;
+    }
+
+    for (i = 0; i < n->num_zones; i++, zone++) {
+        if (start + zone_size > capacity) {
+            zone_size = capacity - start;
+        }
+        if (zone->d.zt != NVME_ZONE_TYPE_SEQ_WRITE) {
+            return 9;
+        }
+        if (zone->d.zcap != n->zone_capacity) {
+            return 10;
+        }
+        if (zone->d.zslba != start) {
+            return 11;
+        }
+        switch (nvme_get_zone_state(zone)) {
+        case NVME_ZONE_STATE_EMPTY:
+        case NVME_ZONE_STATE_OFFLINE:
+        case NVME_ZONE_STATE_READ_ONLY:
+            if (zone->d.wp != start) {
+                return 12;
+            }
+            break;
+        case NVME_ZONE_STATE_IMPLICITLY_OPEN:
+            if (zone->d.wp < start ||
+                zone->d.wp >= zone->d.zslba + zone->d.zcap) {
+                return 13;
+            }
+            n_imp_open++;
+            break;
+        case NVME_ZONE_STATE_EXPLICITLY_OPEN:
+            if (zone->d.wp < start ||
+                zone->d.wp >= zone->d.zslba + zone->d.zcap) {
+                return 13;
+            }
+            n_exp_open++;
+            break;
+        case NVME_ZONE_STATE_CLOSED:
+            if (zone->d.wp < start ||
+                zone->d.wp >= zone->d.zslba + zone->d.zcap) {
+                return 13;
+            }
+            n_closed++;
+            break;
+        case NVME_ZONE_STATE_FULL:
+            if (zone->d.wp != zone->d.zslba + zone->d.zcap) {
+                return 14;
+            }
+            n_full++;
+            break;
+        default:
+            return 15;
+        }
+
+        start += zone_size;
+    }
+
+    if (n_exp_open != nvme_zone_list_size(ns->exp_open_zones)) {
+        return 16;
+    }
+    if (n_imp_open != nvme_zone_list_size(ns->imp_open_zones)) {
+        return 17;
+    }
+    if (n_closed != nvme_zone_list_size(ns->closed_zones)) {
+        return 18;
+    }
+    if (n_full != nvme_zone_list_size(ns->full_zones)) {
+        return 19;
+    }
+
+    return 0;
+}
+
+static int nvme_init_zone_file(NvmeCtrl *n, NvmeNamespace *ns,
                                uint64_t capacity)
 {
+    NvmeZoneMeta *meta = ns->zone_meta;
     NvmeZone *zone;
     Error *err;
     uint64_t start = 0, zone_size = n->zone_size;
@@ -3408,18 +3522,33 @@ static int nvme_init_zone_meta(NvmeCtrl *n, NvmeNamespace *ns,
     int i;
     uint16_t zs;
 
-    ns->zone_array = g_malloc0(n->zone_array_size);
-    ns->exp_open_zones = g_malloc0(sizeof(NvmeZoneList));
-    ns->imp_open_zones = g_malloc0(sizeof(NvmeZoneList));
-    ns->closed_zones = g_malloc0(sizeof(NvmeZoneList));
-    ns->full_zones = g_malloc0(sizeof(NvmeZoneList));
-    ns->zd_extensions = g_malloc0(n->params.zd_extension_size * n->num_zones);
+    if (n->params.zone_file) {
+        meta->magic = NVME_ZONE_META_MAGIC;
+        meta->version = NVME_ZONE_META_VER;
+        meta->zone_size = zone_size;
+        meta->zone_capacity = n->zone_capacity;
+        meta->lba_size = n->conf.logical_block_size;
+        meta->nr_offline_zones = n->params.nr_offline_zones;
+        meta->nr_rdonly_zones = n->params.nr_rdonly_zones;
+        meta->zd_extension_size = n->params.zd_extension_size;
+    } else {
+        ns->zone_array = g_malloc0(n->zone_array_size);
+        ns->exp_open_zones = g_malloc0(sizeof(NvmeZoneList));
+        ns->imp_open_zones = g_malloc0(sizeof(NvmeZoneList));
+        ns->closed_zones = g_malloc0(sizeof(NvmeZoneList));
+        ns->full_zones = g_malloc0(sizeof(NvmeZoneList));
+        ns->zd_extensions =
+            g_malloc0(n->params.zd_extension_size * n->num_zones);
+    }
     zone = ns->zone_array;
 
     nvme_init_zone_list(ns->exp_open_zones);
     nvme_init_zone_list(ns->imp_open_zones);
     nvme_init_zone_list(ns->closed_zones);
     nvme_init_zone_list(ns->full_zones);
+    if (n->params.zone_file) {
+        nvme_set_zone_meta_dirty(n, ns, true);
+    }
 
     for (i = 0; i < n->num_zones; i++, zone++) {
         if (start + zone_size > capacity) {
@@ -3471,7 +3600,196 @@ static int nvme_init_zone_meta(NvmeCtrl *n, NvmeNamespace *ns,
     return 0;
 }
 
-static void nvme_zoned_init_ctrl(NvmeCtrl *n, Error **errp)
+static void nvme_open_zone_file(NvmeCtrl *n, bool *init_meta, Error **errp)
+{
+#ifdef CONFIG_POSIX
+
+    struct stat statbuf;
+    Error *local_err = NULL;
+    size_t fsize;
+    int ret;
+
+    ret = stat(n->params.zone_file, &statbuf);
+    if (ret && errno == ENOENT) {
+        *init_meta = true;
+    } else if (!S_ISREG(statbuf.st_mode)) {
+        error_setg(errp, "\"%s\" is not a regular file",
+                   n->params.zone_file);
+        return;
+    }
+
+    n->zone_file_fd = open(n->params.zone_file,
+                           O_RDWR | O_LARGEFILE | O_BINARY | O_CREAT, 0644);
+    if (n->zone_file_fd < 0) {
+        error_setg_errno(errp, errno, "failed to create zone file \"%s\"",
+                         n->params.zone_file);
+        return;
+    }
+
+    fsize = n->meta_size * n->num_namespaces;
+
+    if (stat(n->params.zone_file, &statbuf)) {
+        error_setg_errno(errp, errno, "can't stat zone file \"%s\"",
+                         n->params.zone_file);
+        return;
+    }
+    if (statbuf.st_size != fsize) {
+        ret = ftruncate(n->zone_file_fd, fsize);
+        if (ret < 0) {
+            error_setg_errno(errp, errno, "can't truncate zone file \"%s\"",
+                             n->params.zone_file);
+            return;
+        }
+        *init_meta = true;
+    }
+
+    memory_region_init_ram_from_fd(&n->zone_mem, OBJECT(n), "nvme-zone-meta",
+                                   fsize, true, n->zone_file_fd, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+    }
+
+    if (*init_meta) {
+        trace_pci_nvme_initialized_zone_file(n->params.zone_file);
+    }
+    return;
+
+#else
+
+    error_setg(errp, "zone metadata file not supported on this host");
+
+#endif /* CONFIG_POSIX */
+}
+
+static int nvme_map_zone_file(NvmeCtrl *n, NvmeNamespace *ns, bool *init_meta)
+{
+    ns->zone_meta = (void *)memory_region_get_ram_ptr(&n->zone_mem) +
+                    n->meta_size * (ns->nsid - 1);
+
+    ns->zone_array = (NvmeZone *)(ns->zone_meta + 1);
+    ns->exp_open_zones = &ns->zone_meta->exp_open_zones;
+    ns->imp_open_zones = &ns->zone_meta->imp_open_zones;
+    ns->closed_zones = &ns->zone_meta->closed_zones;
+    ns->full_zones = &ns->zone_meta->full_zones;
+
+    if (n->params.zd_extension_size) {
+        ns->zd_extensions = (uint8_t *)(ns->zone_meta + 1);
+        ns->zd_extensions += n->zone_array_size;
+    }
+
+    return 0;
+}
+
+static void nvme_sync_zone_file(NvmeCtrl *n, NvmeNamespace *ns,
+                                NvmeZone *zone, int len)
+{
+    uintptr_t z = (uintptr_t)zone, off = z - (uintptr_t)ns->zone_meta;
+
+    memory_region_msync(&n->zone_mem, off, len);
+
+    if (nvme_zone_meta_dirty(n, ns)) {
+        nvme_set_zone_meta_dirty(n, ns, false);
+        memory_region_msync(&n->zone_mem, 0, sizeof(NvmeZoneMeta));
+    }
+}
+
+/*
+ * Close or finish all the zones that might be still open after power-down.
+ */
+static void nvme_prepare_zones(NvmeCtrl *n, NvmeNamespace *ns)
+{
+    NvmeZone *zone;
+    uint32_t set_state;
+    int i;
+
+    assert(!ns->nr_active_zones);
+    assert(!ns->nr_open_zones);
+
+    zone = ns->zone_array;
+    for (i = 0; i < n->num_zones; i++, zone++) {
+        switch (nvme_get_zone_state(zone)) {
+        case NVME_ZONE_STATE_IMPLICITLY_OPEN:
+            nvme_remove_zone(n, ns, ns->imp_open_zones, zone);
+            break;
+        case NVME_ZONE_STATE_EXPLICITLY_OPEN:
+            nvme_remove_zone(n, ns, ns->exp_open_zones, zone);
+            break;
+        case NVME_ZONE_STATE_CLOSED:
+            nvme_aor_inc_active(n, ns);
+            /* fall through */
+        default:
+            continue;
+        }
+
+        if (zone->d.za & NVME_ZA_ZD_EXT_VALID) {
+            set_state = NVME_ZONE_STATE_CLOSED;
+        } else if (zone->d.wp == zone->d.zslba) {
+            set_state = NVME_ZONE_STATE_EMPTY;
+        } else if (n->params.max_active_zones == 0 ||
+                   ns->nr_active_zones < n->params.max_active_zones) {
+            set_state = NVME_ZONE_STATE_CLOSED;
+        } else {
+            set_state = NVME_ZONE_STATE_FULL;
+        }
+
+        switch (set_state) {
+        case NVME_ZONE_STATE_CLOSED:
+            trace_pci_nvme_power_on_close(nvme_get_zone_state(zone),
+                                          zone->d.zslba);
+            nvme_aor_inc_active(n, ns);
+            nvme_add_zone_tail(n, ns, ns->closed_zones, zone);
+            break;
+        case NVME_ZONE_STATE_EMPTY:
+            trace_pci_nvme_power_on_reset(nvme_get_zone_state(zone),
+                                          zone->d.zslba);
+            break;
+        case NVME_ZONE_STATE_FULL:
+            trace_pci_nvme_power_on_full(nvme_get_zone_state(zone),
+                                         zone->d.zslba);
+            zone->d.wp = nvme_zone_wr_boundary(zone);
+        }
+
+        zone->w_ptr = zone->d.wp;
+        nvme_set_zone_state(zone, set_state);
+    }
+}
+
+static int nvme_load_zone_meta(NvmeCtrl *n, NvmeNamespace *ns,
+                               uint64_t capacity, bool init_meta)
+{
+    int ret = 0;
+
+    if (n->params.zone_file) {
+        ret = nvme_map_zone_file(n, ns, &init_meta);
+        trace_pci_nvme_mapped_zone_file(n->params.zone_file, ret);
+        if (ret < 0) {
+            return ret;
+        }
+
+        if (!init_meta) {
+            ret = nvme_validate_zone_file(n, ns, capacity);
+            if (ret) {
+                trace_pci_nvme_err_zone_file_invalid(ret);
+                init_meta = true;
+            }
+        }
+    } else {
+        init_meta = true;
+    }
+
+    if (init_meta) {
+        ret = nvme_init_zone_file(n, ns, capacity);
+    } else {
+        nvme_prepare_zones(n, ns);
+    }
+    if (!ret && n->params.zone_file) {
+        nvme_sync_zone_file(n, ns, ns->zone_array, n->zone_array_size);
+    }
+
+    return ret;
+}
+
+static void nvme_zoned_init_ctrl(NvmeCtrl *n, bool *init_meta, Error **errp)
 {
     uint64_t zone_size, zone_cap;
     uint32_t nz;
@@ -3501,6 +3819,10 @@ static void nvme_zoned_init_ctrl(NvmeCtrl *n, Error **errp)
         n->zone_size_log2 = 63 - clz64(n->zone_size);
     }
 
+    n->meta_size = sizeof(NvmeZoneMeta) + n->zone_array_size +
+                          nz * n->params.zd_extension_size;
+    n->meta_size = ROUND_UP(n->meta_size, qemu_real_host_page_size);
+
     if (!n->params.zasl_kb) {
         n->zasl_bs = n->params.mdts ? 0 : NVME_DEFAULT_MAX_ZA_SIZE * KiB;
     } else {
@@ -3540,17 +3862,22 @@ static void nvme_zoned_init_ctrl(NvmeCtrl *n, Error **errp)
         }
     }
 
+    if (n->params.zone_file) {
+        nvme_open_zone_file(n, init_meta, errp);
+    }
+
     return;
 }
 
 static int nvme_zoned_init_ns(NvmeCtrl *n, NvmeNamespace *ns, int lba_index,
-                              Error **errp)
+                              bool init_meta, Error **errp)
 {
     int ret;
 
-    ret = nvme_init_zone_meta(n, ns, n->num_zones * n->zone_size);
+    ret = nvme_load_zone_meta(n, ns, n->num_zones * n->zone_size,
+                              init_meta);
     if (ret) {
-        error_setg(errp, "could not init zone metadata");
+        error_setg(errp, "could not load/init zone metadata");
         return -1;
     }
 
@@ -3579,15 +3906,20 @@ static void nvme_zoned_clear(NvmeCtrl *n)
 {
     int i;
 
+    if (n->params.zone_file)  {
+        close(n->zone_file_fd);
+    }
     for (i = 0; i < n->num_namespaces; i++) {
         NvmeNamespace *ns = &n->namespaces[i];
         g_free(ns->id_ns_zoned);
-        g_free(ns->zone_array);
-        g_free(ns->exp_open_zones);
-        g_free(ns->imp_open_zones);
-        g_free(ns->closed_zones);
-        g_free(ns->full_zones);
-        g_free(ns->zd_extensions);
+        if (!n->params.zone_file) {
+            g_free(ns->zone_array);
+            g_free(ns->exp_open_zones);
+            g_free(ns->imp_open_zones);
+            g_free(ns->closed_zones);
+            g_free(ns->full_zones);
+            g_free(ns->zd_extensions);
+        }
     }
 }
 
@@ -3676,7 +4008,8 @@ static void nvme_init_blk(NvmeCtrl *n, Error **errp)
     n->ns_size = bs_size;
 }
 
-static void nvme_init_namespace(NvmeCtrl *n, NvmeNamespace *ns, Error **errp)
+static void nvme_init_namespace(NvmeCtrl *n, NvmeNamespace *ns, bool init_meta,
+                                Error **errp)
 {
     NvmeIdNs *id_ns = &ns->id_ns;
     int lba_index;
@@ -3690,7 +4023,7 @@ static void nvme_init_namespace(NvmeCtrl *n, NvmeNamespace *ns, Error **errp)
     if (n->params.zoned) {
         ns->csi = NVME_CSI_ZONED;
         id_ns->ncap = cpu_to_le64(n->zone_capacity * n->num_zones);
-        if (nvme_zoned_init_ns(n, ns, lba_index, errp) != 0) {
+        if (nvme_zoned_init_ns(n, ns, lba_index, init_meta, errp) != 0) {
             return;
         }
     } else {
@@ -3874,6 +4207,7 @@ static void nvme_realize(PCIDevice *pci_dev, Error **errp)
     NvmeCtrl *n = NVME(pci_dev);
     NvmeNamespace *ns;
     Error *local_err = NULL;
+    bool init_meta = false;
 
     int i;
 
@@ -3897,7 +4231,7 @@ static void nvme_realize(PCIDevice *pci_dev, Error **errp)
     }
 
     if (n->params.zoned) {
-        nvme_zoned_init_ctrl(n, &local_err);
+        nvme_zoned_init_ctrl(n, &init_meta, &local_err);
         if (local_err) {
             error_propagate(errp, local_err);
             return;
@@ -3908,7 +4242,7 @@ static void nvme_realize(PCIDevice *pci_dev, Error **errp)
     ns = n->namespaces;
     for (i = 0; i < n->num_namespaces; i++, ns++) {
         ns->nsid = i + 1;
-        nvme_init_namespace(n, ns, &local_err);
+        nvme_init_namespace(n, ns, init_meta, &local_err);
         if (local_err) {
             error_propagate(errp, local_err);
             return;
@@ -3956,6 +4290,7 @@ static Property nvme_props[] = {
                        NVME_DEFAULT_ZONE_SIZE),
     DEFINE_PROP_UINT64("zone_capacity", NvmeCtrl, params.zone_capacity_mb, 0),
     DEFINE_PROP_UINT32("zone_append_size_limit", NvmeCtrl, params.zasl_kb, 0),
+    DEFINE_PROP_STRING("zone_file", NvmeCtrl, params.zone_file),
     DEFINE_PROP_UINT32("zone_descr_ext_size", NvmeCtrl,
                        params.zd_extension_size, 0),
     DEFINE_PROP_UINT32("max_active", NvmeCtrl, params.max_active_zones, 0),
diff --git a/hw/block/nvme.h b/hw/block/nvme.h
index dea0c12792..021c049e1f 100644
--- a/hw/block/nvme.h
+++ b/hw/block/nvme.h
@@ -18,6 +18,7 @@ typedef struct NvmeParams {
 
     bool        zoned;
     bool        cross_zone_read;
+    char        *zone_file;
     uint8_t     fill_pattern;
     uint32_t    zasl_kb;
     uint64_t    zone_size_mb;
@@ -95,6 +96,27 @@ typedef struct NvmeZoneList {
     uint8_t         rsvd12[4];
 } NvmeZoneList;
 
+#define NVME_ZONE_META_MAGIC 0x3aebaa70
+#define NVME_ZONE_META_VER  1
+
+typedef struct NvmeZoneMeta {
+    uint32_t        magic;
+    uint32_t        version;
+    uint64_t        zone_size;
+    uint64_t        zone_capacity;
+    uint32_t        nr_offline_zones;
+    uint32_t        nr_rdonly_zones;
+    uint32_t        lba_size;
+    uint32_t        rsvd40;
+    NvmeZoneList    exp_open_zones;
+    NvmeZoneList    imp_open_zones;
+    NvmeZoneList    closed_zones;
+    NvmeZoneList    full_zones;
+    uint8_t         zd_extension_size;
+    uint8_t         dirty;
+    uint8_t         rsvd594[3990];
+} NvmeZoneMeta;
+
 typedef struct NvmeNamespace {
     NvmeIdNs        id_ns;
     uint32_t        nsid;
@@ -104,6 +126,7 @@ typedef struct NvmeNamespace {
 
     NvmeIdNsZoned   *id_ns_zoned;
     NvmeZone        *zone_array;
+    NvmeZoneMeta    *zone_meta;
     NvmeZoneList    *exp_open_zones;
     NvmeZoneList    *imp_open_zones;
     NvmeZoneList    *closed_zones;
@@ -169,8 +192,10 @@ typedef struct NvmeCtrl {
     QTAILQ_HEAD(, NvmeAsyncEvent) aer_queue;
     int         aer_queued;
 
+    MemoryRegion    zone_mem;
     int             zone_file_fd;
     uint32_t        num_zones;
+    size_t          meta_size;
     uint64_t        zone_size;
     uint64_t        zone_capacity;
     uint64_t        zone_array_size;
@@ -279,4 +304,17 @@ static inline NvmeZone *nvme_next_zone_in_list(NvmeNamespace *ns, NvmeZone *z,
     return &ns->zone_array[z->next];
 }
 
+static inline bool nvme_zone_meta_dirty(NvmeCtrl *n, NvmeNamespace *ns)
+{
+    return n->params.zone_file ? ns->zone_meta->dirty : false;
+}
+
+static inline void nvme_set_zone_meta_dirty(NvmeCtrl *n, NvmeNamespace *ns,
+                                            bool yesno)
+{
+    if (n->params.zone_file) {
+        ns->zone_meta->dirty = yesno;
+    }
+}
+
 #endif /* HW_NVME_H */
diff --git a/hw/block/trace-events b/hw/block/trace-events
index 53c7a2fd1f..7ee983b9df 100644
--- a/hw/block/trace-events
+++ b/hw/block/trace-events
@@ -100,6 +100,7 @@ pci_nvme_zd_extension_set(uint32_t zone_idx) "set descriptor extension for zone_
 pci_nvme_power_on_close(uint32_t state, uint64_t slba) "zone state=%"PRIu32", slba=%"PRIu64" transitioned to Closed state"
 pci_nvme_power_on_reset(uint32_t state, uint64_t slba) "zone state=%"PRIu32", slba=%"PRIu64" transitioned to Empty state"
 pci_nvme_power_on_full(uint32_t state, uint64_t slba) "zone state=%"PRIu32", slba=%"PRIu64" transitioned to Full state"
+pci_nvme_initialized_zone_file(char *zfile_name) "mapped zone file %s"
 pci_nvme_mapped_zone_file(char *zfile_name, int ret) "mapped zone file %s, error %d"
 
 # nvme traces for error conditions
-- 
2.21.0


