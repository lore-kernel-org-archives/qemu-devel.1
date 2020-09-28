Return-Path: <SRS0=Z1O7=DF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AB2BC4346E
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 02:48:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71E6522262
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 02:48:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="pVRIiYt2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71E6522262
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38808 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMjDJ-0004bx-Jw
	for qemu-devel@archiver.kernel.org; Sun, 27 Sep 2020 22:48:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46570)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=5334b480d=dmitry.fomichev@wdc.com>)
 id 1kMj1f-0007lo-FU; Sun, 27 Sep 2020 22:36:27 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:21635)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=5334b480d=dmitry.fomichev@wdc.com>)
 id 1kMj1c-0003Me-L2; Sun, 27 Sep 2020 22:36:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1601260584; x=1632796584;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=r8vzmyyR3tFyO2UWJ8Gnqxx1eAjN58tS1L3B7DncrmU=;
 b=pVRIiYt2jzvDr4ljf4qW2xo2eIczYxsgSB1kT1YvwF2I87CS/I+yDULV
 tDbxMm2/380ereNH7JMppumUU4rolDY6JVUY2NstBo1zeN2mMN4W1n4zI
 z+SFKIwGAE2IutQDiaETlHE0fNwh0KRlyaUfgWakB2w4MU2GU40/pwHAd
 MHpIMYHafSr1syUZ3Yefj3mtLWzr6tRk7MfW3Ic/Hmrwh1Da8ToVlTKWt
 khylJvSOwGtumRxMNLXeWcbq7aPqv5I0aqqNwFfFOefh7HvQEI/wAHlCI
 qHN7Uf+3uEQuHaOVjyLKmk00OJh/tepWjjh1/c8J7K7LLjhujm9cfm4Dn A==;
IronPort-SDR: zg04eFM0Lw5sZHCTL9J1JHXQymj7FZfSez6wGL1ZTCJ/fY6ygDnmPIhQvIXrEj7whVOTTySSOz
 LXdNtEPWodJRHpfK3bs7Ve7mV62wXJdcQli3uyoPHX7oXx79zlWUr9EJ6sIHMq7y0M73c/MSaf
 WHJ5a0Qo+ZDrGCgKIbyrg0wNJRIRm35ZysNIVq9eX2YixnELhyWz3iqbIsg/LB4+pVwIooJsVX
 2cxj6Ni6wbAkGHYGVfQM9dVOYUZleHrCS33jXyHwU2nXvsJR3tdq8tR54KJlEaLRXftJTh8WOL
 VMs=
X-IronPort-AV: E=Sophos;i="5.77,312,1596470400"; d="scan'208";a="258125252"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 28 Sep 2020 10:36:03 +0800
IronPort-SDR: BvUYic4SiQhf2kjyb1lfNmfcXnoV21DAiKVyygZ1ZXbT1JWRCL5MVvXVVkb6CwiiLtpVDnXrW8
 iE8h/O4/c5Xg==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Sep 2020 19:22:59 -0700
IronPort-SDR: OTFCS/5f4yBV75bxhZmptcCxO9QEFBfuH/crjULHD+BfQQtiC1b/Okq1bYoyYQOT8NDQIMWw+X
 xYtTf39xzINA==
WDCIronportException: Internal
Received: from unknown (HELO redsun50.ssa.fujisawa.hgst.com) ([10.149.66.24])
 by uls-op-cesaip02.wdc.com with ESMTP; 27 Sep 2020 19:36:01 -0700
From: Dmitry Fomichev <dmitry.fomichev@wdc.com>
To: Keith Busch <kbusch@kernel.org>, Klaus Jensen <k.jensen@samsung.com>,
 Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Maxim Levitsky <mlevitsk@redhat.com>, Fam Zheng <fam@euphon.net>
Subject: [PATCH v5 13/14] hw/block/nvme: Use zone metadata file for persistence
Date: Mon, 28 Sep 2020 11:35:27 +0900
Message-Id: <20200928023528.15260-14-dmitry.fomichev@wdc.com>
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
 hw/block/nvme-ns.c    | 341 ++++++++++++++++++++++++++++++++++++++++--
 hw/block/nvme-ns.h    |  33 ++++
 hw/block/nvme.c       |   2 +
 hw/block/trace-events |   1 +
 4 files changed, 362 insertions(+), 15 deletions(-)

diff --git a/hw/block/nvme-ns.c b/hw/block/nvme-ns.c
index 47751f2d54..a94021da81 100644
--- a/hw/block/nvme-ns.c
+++ b/hw/block/nvme-ns.c
@@ -20,12 +20,15 @@
 #include "hw/pci/pci.h"
 #include "sysemu/sysemu.h"
 #include "sysemu/block-backend.h"
+#include "sysemu/hostmem.h"
+#include "qom/object_interfaces.h"
 #include "qapi/error.h"
 #include "crypto/random.h"
 
 #include "hw/qdev-properties.h"
 #include "hw/qdev-core.h"
 
+#include "trace.h"
 #include "nvme.h"
 #include "nvme-ns.h"
 
@@ -98,6 +101,7 @@ void nvme_add_zone_tail(NvmeNamespace *ns, NvmeZoneList *zl, NvmeZone *zone)
         zl->tail = idx;
     }
     zl->size++;
+    nvme_set_zone_meta_dirty(ns);
 }
 
 /*
@@ -113,12 +117,15 @@ void nvme_remove_zone(NvmeNamespace *ns, NvmeZoneList *zl, NvmeZone *zone)
     if (zl->size == 0) {
         zl->head = NVME_ZONE_LIST_NIL;
         zl->tail = NVME_ZONE_LIST_NIL;
+        nvme_set_zone_meta_dirty(ns);
     } else if (idx == zl->head) {
         zl->head = zone->next;
         ns->zone_array[zl->head].prev = NVME_ZONE_LIST_NIL;
+        nvme_set_zone_meta_dirty(ns);
     } else if (idx == zl->tail) {
         zl->tail = zone->prev;
         ns->zone_array[zl->tail].next = NVME_ZONE_LIST_NIL;
+        nvme_set_zone_meta_dirty(ns);
     } else {
         ns->zone_array[zone->next].prev = zone->prev;
         ns->zone_array[zone->prev].next = zone->next;
@@ -144,6 +151,7 @@ NvmeZone *nvme_remove_zone_head(NvmeNamespace *ns, NvmeZoneList *zl)
             ns->zone_array[zl->head].prev = NVME_ZONE_LIST_NIL;
         }
         zone->prev = zone->next = 0;
+        nvme_set_zone_meta_dirty(ns);
     }
 
     return zone;
@@ -219,11 +227,119 @@ static int nvme_calc_zone_geometry(NvmeNamespace *ns, Error **errp)
         }
     }
 
+    ns->meta_size = sizeof(NvmeZoneMeta) + ns->zone_array_size +
+                          nz * ns->params.zd_extension_size;
+    ns->meta_size = ROUND_UP(ns->meta_size, qemu_real_host_page_size);
+
+    return 0;
+}
+
+static int nvme_validate_zone_file(NvmeNamespace *ns, uint64_t capacity)
+{
+    NvmeZoneMeta *meta = ns->zone_meta;
+    NvmeZone *zone = ns->zone_array;
+    uint64_t start = 0, zone_size = ns->zone_size;
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
+    if (meta->zone_capacity != ns->zone_capacity) {
+        return 4;
+    }
+    if (meta->nr_offline_zones != ns->params.nr_offline_zones) {
+        return 5;
+    }
+    if (meta->nr_rdonly_zones != ns->params.nr_rdonly_zones) {
+        return 6;
+    }
+    if (meta->lba_size != ns->blkconf.logical_block_size) {
+        return 7;
+    }
+    if (meta->zd_extension_size != ns->params.zd_extension_size) {
+        return 8;
+    }
+
+    for (i = 0; i < ns->num_zones; i++, zone++) {
+        if (start + zone_size > capacity) {
+            zone_size = capacity - start;
+        }
+        if (zone->d.zt != NVME_ZONE_TYPE_SEQ_WRITE) {
+            return 9;
+        }
+        if (zone->d.zcap != ns->zone_capacity) {
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
     return 0;
 }
 
 static void nvme_init_zone_meta(NvmeNamespace *ns)
 {
+    NvmeZoneMeta *meta = ns->zone_meta;
     uint64_t start = 0, zone_size = ns->zone_size;
     uint64_t capacity = ns->num_zones * zone_size;
     NvmeZone *zone;
@@ -231,14 +347,26 @@ static void nvme_init_zone_meta(NvmeNamespace *ns)
     int i;
     uint16_t zs;
 
-    ns->zone_array = g_malloc0(ns->zone_array_size);
-    ns->exp_open_zones = g_malloc0(sizeof(NvmeZoneList));
-    ns->imp_open_zones = g_malloc0(sizeof(NvmeZoneList));
-    ns->closed_zones = g_malloc0(sizeof(NvmeZoneList));
-    ns->full_zones = g_malloc0(sizeof(NvmeZoneList));
-    if (ns->params.zd_extension_size) {
-        ns->zd_extensions = g_malloc0(ns->params.zd_extension_size *
-                                      ns->num_zones);
+    if (ns->params.zone_file) {
+        meta->magic = NVME_ZONE_META_MAGIC;
+        meta->version = NVME_ZONE_META_VER;
+        meta->zone_size = zone_size;
+        meta->zone_capacity = ns->zone_capacity;
+        meta->lba_size = ns->blkconf.logical_block_size;
+        meta->nr_offline_zones = ns->params.nr_offline_zones;
+        meta->nr_rdonly_zones = ns->params.nr_rdonly_zones;
+        meta->zd_extension_size = ns->params.zd_extension_size;
+    } else {
+        assert(!ns->zone_meta);
+        ns->zone_array = g_malloc0(ns->zone_array_size);
+        ns->exp_open_zones = g_malloc0(sizeof(NvmeZoneList));
+        ns->imp_open_zones = g_malloc0(sizeof(NvmeZoneList));
+        ns->closed_zones = g_malloc0(sizeof(NvmeZoneList));
+        ns->full_zones = g_malloc0(sizeof(NvmeZoneList));
+        if (ns->params.zd_extension_size) {
+            ns->zd_extensions = g_malloc0(ns->params.zd_extension_size *
+                                          ns->num_zones);
+        }
     }
 
     nvme_init_zone_list(ns->exp_open_zones);
@@ -293,12 +421,180 @@ static void nvme_init_zone_meta(NvmeNamespace *ns)
             i--;
         }
     }
+
+    if (ns->params.zone_file) {
+        nvme_set_zone_meta_dirty(ns);
+    }
+}
+
+static int nvme_open_zone_file(NvmeNamespace *ns, bool *init_meta,
+                               Error **errp)
+{
+    Object *file_be;
+    HostMemoryBackend *fb;
+    struct stat statbuf;
+    int ret;
+
+    ret = stat(ns->params.zone_file, &statbuf);
+    if (ret && errno == ENOENT) {
+        *init_meta = true;
+    } else if (!S_ISREG(statbuf.st_mode)) {
+        error_setg(errp, "\"%s\" is not a regular file",
+                   ns->params.zone_file);
+        return -1;
+    }
+
+    file_be = object_new(TYPE_MEMORY_BACKEND_FILE);
+    object_property_set_str(file_be, "mem-path", ns->params.zone_file,
+                            &error_abort);
+    object_property_set_int(file_be, "size", ns->meta_size, &error_abort);
+    object_property_set_bool(file_be, "share", true, &error_abort);
+    object_property_set_bool(file_be, "discard-data", false, &error_abort);
+    if (!user_creatable_complete(USER_CREATABLE(file_be), errp)) {
+        object_unref(file_be);
+        return -1;
+    }
+    object_property_add_child(OBJECT(ns), "_fb", file_be);
+    object_unref(file_be);
+
+    fb = MEMORY_BACKEND(file_be);
+    ns->zone_mr = host_memory_backend_get_memory(fb);
+
+    return 0;
+}
+
+static int nvme_map_zone_file(NvmeNamespace *ns, bool *init_meta)
+{
+    ns->zone_meta = (void *)memory_region_get_ram_ptr(ns->zone_mr);
+    ns->zone_array = (NvmeZone *)(ns->zone_meta + 1);
+    ns->exp_open_zones = &ns->zone_meta->exp_open_zones;
+    ns->imp_open_zones = &ns->zone_meta->imp_open_zones;
+    ns->closed_zones = &ns->zone_meta->closed_zones;
+    ns->full_zones = &ns->zone_meta->full_zones;
+
+    if (ns->params.zd_extension_size) {
+        ns->zd_extensions = (uint8_t *)(ns->zone_meta + 1);
+        ns->zd_extensions += ns->zone_array_size;
+    }
+
+    return 0;
+}
+
+void nvme_sync_zone_file(NvmeNamespace *ns, NvmeZone *zone, int len)
+{
+    uintptr_t z = (uintptr_t)zone, off = z - (uintptr_t)ns->zone_meta;
+
+    if (ns->zone_meta) {
+        memory_region_msync(ns->zone_mr, off, len);
+
+        if (ns->zone_meta->dirty) {
+            ns->zone_meta->dirty = false;
+            memory_region_msync(ns->zone_mr, 0, sizeof(NvmeZoneMeta));
+        }
+    }
+}
+
+/*
+ * Close or finish all the zones that might be still open after power-down.
+ */
+static void nvme_prepare_zones(NvmeNamespace *ns)
+{
+    NvmeZone *zone;
+    uint32_t set_state;
+    int i;
+
+    assert(!ns->nr_active_zones);
+    assert(!ns->nr_open_zones);
+
+    zone = ns->zone_array;
+    for (i = 0; i < ns->num_zones; i++, zone++) {
+        switch (nvme_get_zone_state(zone)) {
+        case NVME_ZONE_STATE_IMPLICITLY_OPEN:
+            nvme_remove_zone(ns, ns->imp_open_zones, zone);
+            break;
+        case NVME_ZONE_STATE_EXPLICITLY_OPEN:
+            nvme_remove_zone(ns, ns->exp_open_zones, zone);
+            break;
+        case NVME_ZONE_STATE_CLOSED:
+            nvme_aor_inc_active(ns);
+            /* fall through */
+        default:
+            continue;
+        }
+
+        if (zone->d.za & NVME_ZA_ZD_EXT_VALID) {
+            set_state = NVME_ZONE_STATE_CLOSED;
+        } else if (zone->d.wp == zone->d.zslba) {
+            set_state = NVME_ZONE_STATE_EMPTY;
+        } else if (ns->params.max_active_zones == 0 ||
+                   ns->nr_active_zones < ns->params.max_active_zones) {
+            set_state = NVME_ZONE_STATE_CLOSED;
+        } else {
+            set_state = NVME_ZONE_STATE_FULL;
+        }
+
+        switch (set_state) {
+        case NVME_ZONE_STATE_CLOSED:
+            trace_pci_nvme_power_on_close(nvme_get_zone_state(zone),
+                                          zone->d.zslba);
+            nvme_aor_inc_active(ns);
+            nvme_add_zone_tail(ns, ns->closed_zones, zone);
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
+static int nvme_load_zone_meta(NvmeNamespace *ns, bool *init_meta)
+{
+    uint64_t capacity = ns->num_zones * ns->zone_size;
+    int ret = 0;
+
+    if (ns->params.zone_file) {
+        ret = nvme_map_zone_file(ns, init_meta);
+        trace_pci_nvme_mapped_zone_file(ns->params.zone_file, ret);
+        if (ret < 0) {
+            return ret;
+        }
+
+        if (!*init_meta) {
+            ret = nvme_validate_zone_file(ns, capacity);
+            if (ret) {
+                trace_pci_nvme_err_zone_file_invalid(ret);
+                *init_meta = true;
+            }
+        }
+    } else {
+        *init_meta = true;
+    }
+
+    if (*init_meta) {
+        nvme_init_zone_meta(ns);
+        trace_pci_nvme_initialized_zone_file(ns->params.zone_file);
+    } else {
+        nvme_prepare_zones(ns);
+    }
+    nvme_sync_zone_file(ns, ns->zone_array, ns->zone_array_size);
+
+    return 0;
 }
 
 static int nvme_zoned_init_ns(NvmeCtrl *n, NvmeNamespace *ns, int lba_index,
                               Error **errp)
 {
     NvmeIdNsZoned *id_ns_z;
+    int ret;
+    bool init_meta = false;
 
     if (n->params.fill_pattern == 0) {
         ns->id_ns.dlfeat |= 0x01;
@@ -310,7 +606,17 @@ static int nvme_zoned_init_ns(NvmeCtrl *n, NvmeNamespace *ns, int lba_index,
         return -1;
     }
 
-    nvme_init_zone_meta(ns);
+    if (ns->params.zone_file) {
+        if (nvme_open_zone_file(ns, &init_meta, errp) != 0) {
+            return -1;
+        }
+    }
+
+    ret = nvme_load_zone_meta(ns, &init_meta);
+    if (ret) {
+        error_setg(errp, "could not load/init zone metadata, err=%d", ret);
+        return -1;
+    }
 
     id_ns_z = g_malloc0(sizeof(NvmeIdNsZoned));
 
@@ -376,17 +682,21 @@ void nvme_ns_drain(NvmeNamespace *ns)
 void nvme_ns_flush(NvmeNamespace *ns)
 {
     blk_flush(ns->blkconf.blk);
+
+    nvme_sync_zone_file(ns, ns->zone_array, ns->zone_array_size);
 }
 
 void nvme_ns_cleanup(NvmeNamespace *ns)
 {
+    if (!ns->params.zone_file)  {
+        g_free(ns->zone_array);
+        g_free(ns->exp_open_zones);
+        g_free(ns->imp_open_zones);
+        g_free(ns->closed_zones);
+        g_free(ns->full_zones);
+        g_free(ns->zd_extensions);
+    }
     g_free(ns->id_ns_zoned);
-    g_free(ns->zone_array);
-    g_free(ns->exp_open_zones);
-    g_free(ns->imp_open_zones);
-    g_free(ns->closed_zones);
-    g_free(ns->full_zones);
-    g_free(ns->zd_extensions);
 }
 
 static void nvme_ns_realize(DeviceState *dev, Error **errp)
@@ -422,6 +732,7 @@ static Property nvme_ns_props[] = {
                        params.nr_offline_zones, 0),
     DEFINE_PROP_UINT32("rdonly_zones", NvmeNamespace,
                        params.nr_rdonly_zones, 0),
+    DEFINE_PROP_STRING("zone_file", NvmeNamespace, params.zone_file),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/hw/block/nvme-ns.h b/hw/block/nvme-ns.h
index e9b90f9677..4ff0955f91 100644
--- a/hw/block/nvme-ns.h
+++ b/hw/block/nvme-ns.h
@@ -36,6 +36,27 @@ typedef struct NvmeZoneList {
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
 typedef struct NvmeNamespaceParams {
     uint32_t nsid;
     bool     attached;
@@ -50,6 +71,7 @@ typedef struct NvmeNamespaceParams {
     uint32_t zd_extension_size;
     uint32_t nr_offline_zones;
     uint32_t nr_rdonly_zones;
+    char     *zone_file;
 } NvmeNamespaceParams;
 
 typedef struct NvmeNamespace {
@@ -62,6 +84,7 @@ typedef struct NvmeNamespace {
 
     NvmeIdNsZoned   *id_ns_zoned;
     NvmeZone        *zone_array;
+    NvmeZoneMeta    *zone_meta;
     NvmeZoneList    *exp_open_zones;
     NvmeZoneList    *imp_open_zones;
     NvmeZoneList    *closed_zones;
@@ -74,6 +97,8 @@ typedef struct NvmeNamespace {
     uint8_t         *zd_extensions;
     int32_t         nr_open_zones;
     int32_t         nr_active_zones;
+    MemoryRegion    *zone_mr;
+    size_t          meta_size;
 
     NvmeNamespaceParams params;
 } NvmeNamespace;
@@ -110,6 +135,13 @@ static inline size_t nvme_l2b(NvmeNamespace *ns, uint64_t lba)
     return lba << nvme_ns_lbads(ns);
 }
 
+static inline void nvme_set_zone_meta_dirty(NvmeNamespace *ns)
+{
+    if (ns->params.zone_file) {
+        ns->zone_meta->dirty = true;
+    }
+}
+
 typedef struct NvmeCtrl NvmeCtrl;
 
 int nvme_ns_setup(NvmeCtrl *n, NvmeNamespace *ns, Error **errp);
@@ -243,5 +275,6 @@ static inline void nvme_aor_dec_active(NvmeNamespace *ns)
 void nvme_add_zone_tail(NvmeNamespace *ns, NvmeZoneList *zl, NvmeZone *zone);
 void nvme_remove_zone(NvmeNamespace *ns, NvmeZoneList *zl, NvmeZone *zone);
 NvmeZone *nvme_remove_zone_head(NvmeNamespace *ns, NvmeZoneList *zl);
+void nvme_sync_zone_file(NvmeNamespace *ns, NvmeZone *zone, int len);
 
 #endif /* NVME_NS_H */
diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 80973f3ff6..ff7d43d38f 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -165,6 +165,8 @@ static void nvme_assign_zone_state(NvmeNamespace *ns, NvmeZone *zone,
     default:
         zone->d.za = 0;
     }
+
+    nvme_sync_zone_file(ns, zone, sizeof(NvmeZone));
 }
 
 /*
diff --git a/hw/block/trace-events b/hw/block/trace-events
index 386f28e457..1ea4846443 100644
--- a/hw/block/trace-events
+++ b/hw/block/trace-events
@@ -103,6 +103,7 @@ pci_nvme_zd_extension_set(uint32_t zone_idx) "set descriptor extension for zone_
 pci_nvme_power_on_close(uint32_t state, uint64_t slba) "zone state=%"PRIu32", slba=%"PRIu64" transitioned to Closed state"
 pci_nvme_power_on_reset(uint32_t state, uint64_t slba) "zone state=%"PRIu32", slba=%"PRIu64" transitioned to Empty state"
 pci_nvme_power_on_full(uint32_t state, uint64_t slba) "zone state=%"PRIu32", slba=%"PRIu64" transitioned to Full state"
+pci_nvme_initialized_zone_file(char *zfile_name) "mapped zone file %s"
 pci_nvme_mapped_zone_file(char *zfile_name, int ret) "mapped zone file %s, error %d"
 
 # nvme traces for error conditions
-- 
2.21.0


