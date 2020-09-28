Return-Path: <SRS0=Z1O7=DF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32C05C4346E
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 02:44:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B929E22207
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 02:44:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="gPv0rUY0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B929E22207
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55480 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMj9j-0008A8-PR
	for qemu-devel@archiver.kernel.org; Sun, 27 Sep 2020 22:44:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46434)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=5334b480d=dmitry.fomichev@wdc.com>)
 id 1kMj1G-0006yg-7Q; Sun, 27 Sep 2020 22:36:02 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:24223)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=5334b480d=dmitry.fomichev@wdc.com>)
 id 1kMj1D-0003Qn-Q3; Sun, 27 Sep 2020 22:36:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1601260559; x=1632796559;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=6L3PlgujRKfdhSNMMi7uGGEnYVu22SDxebs0fKXdOCs=;
 b=gPv0rUY0/rB4Y0k6ihO99cHvGGKCpBeMRn1Gh9bw9zzaguJNYSly+GUa
 rzJEhM6wscNGq7uy6FgwJOCIysJEpx3PiFkdnORFmcu0XVA1VY8Adi52g
 3FC1fdwS2dWrBk9BTCOgIzdjWz5SqtQrXC+TDabU82ufwUD48wjJgRCh9
 3hk8pQ3pREM7xvyzf4lMFPv10m1Wgt77go8z7+NNVWitpawQRZpbM7+gL
 3bU42WguU/XAoNJCw0QKDnMAeYg5+oe/NJwQUjDU7HcXLf9kWpbKUf1Ya
 BEE1e33FI/UpRJ55bc3q18OfsOJ58YAzjHkuBnX7GmQ6+/JxJ7e7Y0u+u A==;
IronPort-SDR: eGESs7HT1BKTbCUhYEUPvseScAI6KBTQESy+4pO70b1vBr/AYinqnEcW5v91SCK5Rk2o+o2awt
 odC0AncH6m4gSJpIOcewi1//dnDW3UfClzGonnq6sWlRo9xHJHq4TEwEIELfLBScMKJhfgU0Do
 t/q5GgBWKHE4fG5ZJURi7nCMVx714sBIfG5HXX/N/OjYlzBb65C44XkW0p7D2E8MIb87aGBDul
 FvbJJv/4cpnEIZXkP2AEfIxS+awMm+49XRXC2gIBiyzVAl+fcbT4BLxJutc5QgPU4ipamHcaw8
 XN0=
X-IronPort-AV: E=Sophos;i="5.77,312,1596470400"; d="scan'208";a="258125249"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 28 Sep 2020 10:35:56 +0800
IronPort-SDR: 7pHlDm55yXzGvCyJ8DSohEAwiUSKloS15HYDwx0dP15HiIEih9yKtdpov0WNGUJGsA1GpiGxhh
 /xOteuQRTKVA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Sep 2020 19:22:52 -0700
IronPort-SDR: 3MZz5zYMDeF3R+wHcmx/PocsVaMUo0fOpddcru+h54XLmtc/34jlPR3eJmkO7En8/v/yNBJAxv
 tAFQMenEyMvQ==
WDCIronportException: Internal
Received: from unknown (HELO redsun50.ssa.fujisawa.hgst.com) ([10.149.66.24])
 by uls-op-cesaip02.wdc.com with ESMTP; 27 Sep 2020 19:35:55 -0700
From: Dmitry Fomichev <dmitry.fomichev@wdc.com>
To: Keith Busch <kbusch@kernel.org>, Klaus Jensen <k.jensen@samsung.com>,
 Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Maxim Levitsky <mlevitsk@redhat.com>, Fam Zheng <fam@euphon.net>
Subject: [PATCH v5 10/14] hw/block/nvme: Introduce max active and open zone
 limits
Date: Mon, 28 Sep 2020 11:35:24 +0900
Message-Id: <20200928023528.15260-11-dmitry.fomichev@wdc.com>
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

Added two module properties, "max_active" and "max_open" to control
the maximum number of zones that can be active or open. Once these
variables are set to non-default values, these limits are checked
during I/O and Too Many Active or Too Many Open command status is
returned if they are exceeded.

Signed-off-by: Hans Holmberg <hans.holmberg@wdc.com>
Signed-off-by: Dmitry Fomichev <dmitry.fomichev@wdc.com>
---
 hw/block/nvme-ns.c | 42 +++++++++++++++++++-
 hw/block/nvme-ns.h | 42 ++++++++++++++++++++
 hw/block/nvme.c    | 99 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 181 insertions(+), 2 deletions(-)

diff --git a/hw/block/nvme-ns.c b/hw/block/nvme-ns.c
index 6d9dc9205b..63a2e3f47d 100644
--- a/hw/block/nvme-ns.c
+++ b/hw/block/nvme-ns.c
@@ -126,6 +126,28 @@ void nvme_remove_zone(NvmeNamespace *ns, NvmeZoneList *zl, NvmeZone *zone)
     zone->prev = zone->next = 0;
 }
 
+/*
+ * Take the first zone out from a list, return NULL if the list is empty.
+ */
+NvmeZone *nvme_remove_zone_head(NvmeNamespace *ns, NvmeZoneList *zl)
+{
+    NvmeZone *zone = nvme_peek_zone_head(ns, zl);
+
+    if (zone) {
+        --zl->size;
+        if (zl->size == 0) {
+            zl->head = NVME_ZONE_LIST_NIL;
+            zl->tail = NVME_ZONE_LIST_NIL;
+        } else {
+            zl->head = zone->next;
+            ns->zone_array[zl->head].prev = NVME_ZONE_LIST_NIL;
+        }
+        zone->prev = zone->next = 0;
+    }
+
+    return zone;
+}
+
 static int nvme_calc_zone_geometry(NvmeNamespace *ns, Error **errp)
 {
     uint64_t zone_size, zone_cap;
@@ -156,6 +178,20 @@ static int nvme_calc_zone_geometry(NvmeNamespace *ns, Error **errp)
         ns->zone_size_log2 = 63 - clz64(ns->zone_size);
     }
 
+    /* Make sure that the values of all ZNS properties are sane */
+    if (ns->params.max_open_zones > nz) {
+        error_setg(errp,
+                   "max_open_zones value %u exceeds the number of zones %u",
+                   ns->params.max_open_zones, nz);
+        return -1;
+    }
+    if (ns->params.max_active_zones > nz) {
+        error_setg(errp,
+                   "max_active_zones value %u exceeds the number of zones %u",
+                   ns->params.max_active_zones, nz);
+        return -1;
+    }
+
     return 0;
 }
 
@@ -215,8 +251,8 @@ static int nvme_zoned_init_ns(NvmeCtrl *n, NvmeNamespace *ns, int lba_index,
     id_ns_z = g_malloc0(sizeof(NvmeIdNsZoned));
 
     /* MAR/MOR are zeroes-based, 0xffffffff means no limit */
-    id_ns_z->mar = 0xffffffff;
-    id_ns_z->mor = 0xffffffff;
+    id_ns_z->mar = cpu_to_le32(ns->params.max_active_zones - 1);
+    id_ns_z->mor = cpu_to_le32(ns->params.max_open_zones - 1);
     id_ns_z->zoc = 0;
     id_ns_z->ozcs = ns->params.cross_zone_read ? 0x01 : 0x00;
 
@@ -312,6 +348,8 @@ static Property nvme_ns_props[] = {
                        params.zone_capacity_mb, 0),
     DEFINE_PROP_BOOL("cross_zone_read", NvmeNamespace,
                       params.cross_zone_read, false),
+    DEFINE_PROP_UINT32("max_active", NvmeNamespace, params.max_active_zones, 0),
+    DEFINE_PROP_UINT32("max_open", NvmeNamespace, params.max_open_zones, 0),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/hw/block/nvme-ns.h b/hw/block/nvme-ns.h
index daa13546c4..0664fe0892 100644
--- a/hw/block/nvme-ns.h
+++ b/hw/block/nvme-ns.h
@@ -45,6 +45,8 @@ typedef struct NvmeNamespaceParams {
     bool     cross_zone_read;
     uint64_t zone_size_mb;
     uint64_t zone_capacity_mb;
+    uint32_t max_active_zones;
+    uint32_t max_open_zones;
 } NvmeNamespaceParams;
 
 typedef struct NvmeNamespace {
@@ -66,6 +68,8 @@ typedef struct NvmeNamespace {
     uint64_t        zone_capacity;
     uint64_t        zone_array_size;
     uint32_t        zone_size_log2;
+    int32_t         nr_open_zones;
+    int32_t         nr_active_zones;
 
     NvmeNamespaceParams params;
 } NvmeNamespace;
@@ -189,7 +193,45 @@ static inline NvmeZone *nvme_next_zone_in_list(NvmeNamespace *ns, NvmeZone *z,
     return &ns->zone_array[z->next];
 }
 
+static inline void nvme_aor_inc_open(NvmeNamespace *ns)
+{
+    assert(ns->nr_open_zones >= 0);
+    if (ns->params.max_open_zones) {
+        ns->nr_open_zones++;
+        assert(ns->nr_open_zones <= ns->params.max_open_zones);
+    }
+}
+
+static inline void nvme_aor_dec_open(NvmeNamespace *ns)
+{
+    if (ns->params.max_open_zones) {
+        assert(ns->nr_open_zones > 0);
+        ns->nr_open_zones--;
+    }
+    assert(ns->nr_open_zones >= 0);
+}
+
+static inline void nvme_aor_inc_active(NvmeNamespace *ns)
+{
+    assert(ns->nr_active_zones >= 0);
+    if (ns->params.max_active_zones) {
+        ns->nr_active_zones++;
+        assert(ns->nr_active_zones <= ns->params.max_active_zones);
+    }
+}
+
+static inline void nvme_aor_dec_active(NvmeNamespace *ns)
+{
+    if (ns->params.max_active_zones) {
+        assert(ns->nr_active_zones > 0);
+        ns->nr_active_zones--;
+        assert(ns->nr_active_zones >= ns->nr_open_zones);
+    }
+    assert(ns->nr_active_zones >= 0);
+}
+
 void nvme_add_zone_tail(NvmeNamespace *ns, NvmeZoneList *zl, NvmeZone *zone);
 void nvme_remove_zone(NvmeNamespace *ns, NvmeZoneList *zl, NvmeZone *zone);
+NvmeZone *nvme_remove_zone_head(NvmeNamespace *ns, NvmeZoneList *zl);
 
 #endif /* NVME_NS_H */
diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 38e25a4d1f..40947aa659 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -168,6 +168,26 @@ static void nvme_assign_zone_state(NvmeNamespace *ns, NvmeZone *zone,
     }
 }
 
+/*
+ * Check if we can open a zone without exceeding open/active limits.
+ * AOR stands for "Active and Open Resources" (see TP 4053 section 2.5).
+ */
+static int nvme_aor_check(NvmeNamespace *ns, uint32_t act, uint32_t opn)
+{
+    if (ns->params.max_active_zones != 0 &&
+        ns->nr_active_zones + act > ns->params.max_active_zones) {
+        trace_pci_nvme_err_insuff_active_res(ns->params.max_active_zones);
+        return NVME_ZONE_TOO_MANY_ACTIVE | NVME_DNR;
+    }
+    if (ns->params.max_open_zones != 0 &&
+        ns->nr_open_zones + opn > ns->params.max_open_zones) {
+        trace_pci_nvme_err_insuff_open_res(ns->params.max_open_zones);
+        return NVME_ZONE_TOO_MANY_OPEN | NVME_DNR;
+    }
+
+    return NVME_SUCCESS;
+}
+
 static bool nvme_addr_is_cmb(NvmeCtrl *n, hwaddr addr)
 {
     hwaddr low = n->ctrl_mem.addr;
@@ -1035,6 +1055,40 @@ static uint16_t nvme_check_zone_read(NvmeNamespace *ns, NvmeZone *zone,
     return status;
 }
 
+static void nvme_auto_transition_zone(NvmeNamespace *ns, bool implicit,
+                                      bool adding_active)
+{
+    NvmeZone *zone;
+
+    if (implicit && ns->params.max_open_zones &&
+        ns->nr_open_zones == ns->params.max_open_zones) {
+        zone = nvme_remove_zone_head(ns, ns->imp_open_zones);
+        if (zone) {
+            /*
+             * Automatically close this implicitly open zone.
+             */
+            nvme_aor_dec_open(ns);
+            nvme_assign_zone_state(ns, zone, NVME_ZONE_STATE_CLOSED);
+        }
+    }
+}
+
+static uint16_t nvme_auto_open_zone(NvmeNamespace *ns, NvmeZone *zone)
+{
+    uint16_t status = NVME_SUCCESS;
+    uint8_t zs = nvme_get_zone_state(zone);
+
+    if (zs == NVME_ZONE_STATE_EMPTY) {
+        nvme_auto_transition_zone(ns, true, true);
+        status = nvme_aor_check(ns, 1, 1);
+    } else if (zs == NVME_ZONE_STATE_CLOSED) {
+        nvme_auto_transition_zone(ns, true, false);
+        status = nvme_aor_check(ns, 0, 1);
+    }
+
+    return status;
+}
+
 static inline uint32_t nvme_zone_idx(NvmeNamespace *ns, uint64_t slba)
 {
     return ns->zone_size_log2 > 0 ? slba >> ns->zone_size_log2 :
@@ -1080,7 +1134,11 @@ static bool nvme_finalize_zoned_write(NvmeNamespace *ns, NvmeRequest *req,
         switch (zs) {
         case NVME_ZONE_STATE_IMPLICITLY_OPEN:
         case NVME_ZONE_STATE_EXPLICITLY_OPEN:
+            nvme_aor_dec_open(ns);
+            /* fall through */
         case NVME_ZONE_STATE_CLOSED:
+            nvme_aor_dec_active(ns);
+            /* fall through */
         case NVME_ZONE_STATE_EMPTY:
             nvme_assign_zone_state(ns, zone, NVME_ZONE_STATE_FULL);
             /* fall through */
@@ -1109,7 +1167,10 @@ static uint64_t nvme_advance_zone_wp(NvmeNamespace *ns, NvmeZone *zone,
         zs = nvme_get_zone_state(zone);
         switch (zs) {
         case NVME_ZONE_STATE_EMPTY:
+            nvme_aor_inc_active(ns);
+            /* fall through */
         case NVME_ZONE_STATE_CLOSED:
+            nvme_aor_inc_open(ns);
             nvme_assign_zone_state(ns, zone, NVME_ZONE_STATE_IMPLICITLY_OPEN);
         }
     }
@@ -1282,6 +1343,11 @@ static uint16_t nvme_write_zeroes(NvmeCtrl *n, NvmeRequest *req)
             return NVME_ZONE_INVALID_WRITE | NVME_DNR;
         }
 
+        status = nvme_auto_open_zone(ns, zone);
+        if (status != NVME_SUCCESS) {
+            return status;
+        }
+
         req->cqe.result64 = nvme_advance_zone_wp(ns, zone, nlb);
     }
 
@@ -1349,6 +1415,12 @@ static uint16_t nvme_rw(NvmeCtrl *n, NvmeRequest *req, bool append)
                 status = NVME_ZONE_INVALID_WRITE | NVME_DNR;
                 goto invalid;
             }
+
+            status = nvme_auto_open_zone(ns, zone);
+            if (status != NVME_SUCCESS) {
+                return status;
+            }
+
             req->fill_ofs = -1LL;
         } else {
             status = nvme_check_zone_read(ns, zone, slba, nlb);
@@ -1434,9 +1506,27 @@ static uint16_t nvme_get_mgmt_zone_slba_idx(NvmeNamespace *ns, NvmeCmd *c,
 static uint16_t nvme_open_zone(NvmeNamespace *ns, NvmeZone *zone,
                                uint8_t state)
 {
+    uint16_t status;
+
     switch (state) {
     case NVME_ZONE_STATE_EMPTY:
+        nvme_auto_transition_zone(ns, false, true);
+        status = nvme_aor_check(ns, 1, 0);
+        if (status != NVME_SUCCESS) {
+            return status;
+        }
+        nvme_aor_inc_active(ns);
+        /* fall through */
     case NVME_ZONE_STATE_CLOSED:
+        status = nvme_aor_check(ns, 0, 1);
+        if (status != NVME_SUCCESS) {
+            if (state == NVME_ZONE_STATE_EMPTY) {
+                nvme_aor_dec_active(ns);
+            }
+            return status;
+        }
+        nvme_aor_inc_open(ns);
+        /* fall through */
     case NVME_ZONE_STATE_IMPLICITLY_OPEN:
         nvme_assign_zone_state(ns, zone, NVME_ZONE_STATE_EXPLICITLY_OPEN);
         /* fall through */
@@ -1458,6 +1548,7 @@ static uint16_t nvme_close_zone(NvmeNamespace *ns, NvmeZone *zone,
     switch (state) {
     case NVME_ZONE_STATE_EXPLICITLY_OPEN:
     case NVME_ZONE_STATE_IMPLICITLY_OPEN:
+        nvme_aor_dec_open(ns);
         nvme_assign_zone_state(ns, zone, NVME_ZONE_STATE_CLOSED);
         /* fall through */
     case NVME_ZONE_STATE_CLOSED:
@@ -1479,7 +1570,11 @@ static uint16_t nvme_finish_zone(NvmeNamespace *ns, NvmeZone *zone,
     switch (state) {
     case NVME_ZONE_STATE_EXPLICITLY_OPEN:
     case NVME_ZONE_STATE_IMPLICITLY_OPEN:
+        nvme_aor_dec_open(ns);
+        /* fall through */
     case NVME_ZONE_STATE_CLOSED:
+        nvme_aor_dec_active(ns);
+        /* fall through */
     case NVME_ZONE_STATE_EMPTY:
         zone->w_ptr = nvme_zone_wr_boundary(zone);
         zone->d.wp = zone->w_ptr;
@@ -1505,7 +1600,11 @@ static uint16_t nvme_reset_zone(NvmeNamespace *ns, NvmeZone *zone,
     switch (state) {
     case NVME_ZONE_STATE_EXPLICITLY_OPEN:
     case NVME_ZONE_STATE_IMPLICITLY_OPEN:
+        nvme_aor_dec_open(ns);
+        /* fall through */
     case NVME_ZONE_STATE_CLOSED:
+        nvme_aor_dec_active(ns);
+        /* fall through */
     case NVME_ZONE_STATE_FULL:
         zone->w_ptr = zone->d.zslba;
         zone->d.wp = zone->w_ptr;
-- 
2.21.0


