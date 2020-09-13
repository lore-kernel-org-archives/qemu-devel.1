Return-Path: <SRS0=H3r+=CW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA682C433E2
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2020 22:25:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6626021548
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2020 22:25:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="h6MnKxuh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6626021548
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52992 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHaQd-0007Ni-J5
	for qemu-devel@archiver.kernel.org; Sun, 13 Sep 2020 18:24:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58830)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=518fa018e=dmitry.fomichev@wdc.com>)
 id 1kHaHA-0000Ku-Dy; Sun, 13 Sep 2020 18:15:12 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:42048)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=518fa018e=dmitry.fomichev@wdc.com>)
 id 1kHaH7-0001HC-SP; Sun, 13 Sep 2020 18:15:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1600035309; x=1631571309;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Okj0zWOoMynp62Hw0K8ghl0GkgndooCPCPmhwXslHUI=;
 b=h6MnKxuh8kKbp/WEcCz1UqJamvXy3SxM392GsoiEJET2M/EeIKAvCX7b
 X/qMB/cw8XBZXlL4Y7bLzGjtd09yz8F6JmCUm0BolIesuoGzf5fJ5R0pU
 V9XIYjn1O9EIIDCOPZC8UPnLYX03TpSOjbPaBbXSA5UYF37Mflnb+cQ84
 3WQOb/EUV3hzGVCC1SvlMQT1yq+ULb6PDmYTgJE0ZTV5/k0g+KAxEOFKa
 pDg2fMmdnpo/7G0Sx2p6TlmS14rlf/yPR2ctfxZGfaQ6XwOkRnDWBvB/W
 KEe0I8RFQgxXVU8OXgIAsDJXwZYM8SzPHMy3Ye7x4bjAUQomuE8z1SgRg w==;
IronPort-SDR: JzgOSY6CC/k6T/Ugwd1TTzQ7M+3cjyKIVnBmWGbF2A4WdZjJ23wXvj+JdJa6Y4OOWlrvQkoZVo
 rh0l9weKyESHTbd1xIHVFZFUuy8vCO+r/pIkvIi2h5kT0A7ksL/Hx5dplgTZW0RpDuubt9enAe
 6qb4gL5mcDU3hJRAtTGc6MqOxPCejUATnleoL7XpRa7hNfiECBXQsMkQnNGEDo4YFa8LjHSpN+
 vRIzraHSxlbDPUmbDttU276auhiwfeaTFoFIGT3Eb11CeYVL4TjBPRa+hxmTqv97E/dxzsw0NU
 qtA=
X-IronPort-AV: E=Sophos;i="5.76,423,1592841600"; d="scan'208";a="147179070"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 14 Sep 2020 06:15:07 +0800
IronPort-SDR: pbxizQDDPkC19jRGSiS2K6kDjXOQwBK2qbeApMTmZJwnxqfddjt8mw0/AU0sDHSlyV65gNBPm1
 3r0eSGKI0oeQ==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Sep 2020 15:02:20 -0700
IronPort-SDR: 28y+j4MGkZZMQQvI9Lt6v3OWzwI9rxrGM54fyN+nogGoPutE8VGPbRICtAv1FXPHghWVynmkSe
 T0qFUMpZ5A9w==
WDCIronportException: Internal
Received: from unknown (HELO redsun50.ssa.fujisawa.hgst.com) ([10.149.66.24])
 by uls-op-cesaip02.wdc.com with ESMTP; 13 Sep 2020 15:15:07 -0700
From: Dmitry Fomichev <dmitry.fomichev@wdc.com>
To: Keith Busch <kbusch@kernel.org>, Klaus Jensen <k.jensen@samsung.com>,
 Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Maxim Levitsky <mlevitsk@redhat.com>, Fam Zheng <fam@euphon.net>
Subject: [PATCH v3 11/15] hw/block/nvme: Introduce max active and open zone
 limits
Date: Mon, 14 Sep 2020 07:14:32 +0900
Message-Id: <20200913221436.22844-12-dmitry.fomichev@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200913221436.22844-1-dmitry.fomichev@wdc.com>
References: <20200913221436.22844-1-dmitry.fomichev@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.154.42;
 envelope-from=prvs=518fa018e=dmitry.fomichev@wdc.com; helo=esa4.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/13 18:14:44
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
 hw/block/nvme.c | 179 +++++++++++++++++++++++++++++++++++++++++++++++-
 hw/block/nvme.h |   4 ++
 2 files changed, 181 insertions(+), 2 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 0bf7471815..120b63cee4 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -176,6 +176,87 @@ static void nvme_remove_zone(NvmeCtrl *n, NvmeNamespace *ns, NvmeZoneList *zl,
     zone->prev = zone->next = 0;
 }
 
+/*
+ * Take the first zone out from a list, return NULL if the list is empty.
+ */
+static NvmeZone *nvme_remove_zone_head(NvmeCtrl *n, NvmeNamespace *ns,
+                                       NvmeZoneList *zl)
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
+/*
+ * Check if we can open a zone without exceeding open/active limits.
+ * AOR stands for "Active and Open Resources" (see TP 4053 section 2.5).
+ */
+static int nvme_aor_check(NvmeCtrl *n, NvmeNamespace *ns,
+                          uint32_t act, uint32_t opn)
+{
+    if (n->params.max_active_zones != 0 &&
+        ns->nr_active_zones + act > n->params.max_active_zones) {
+        trace_pci_nvme_err_insuff_active_res(n->params.max_active_zones);
+        return NVME_ZONE_TOO_MANY_ACTIVE | NVME_DNR;
+    }
+    if (n->params.max_open_zones != 0 &&
+        ns->nr_open_zones + opn > n->params.max_open_zones) {
+        trace_pci_nvme_err_insuff_open_res(n->params.max_open_zones);
+        return NVME_ZONE_TOO_MANY_OPEN | NVME_DNR;
+    }
+
+    return NVME_SUCCESS;
+}
+
+static inline void nvme_aor_inc_open(NvmeCtrl *n, NvmeNamespace *ns)
+{
+    assert(ns->nr_open_zones >= 0);
+    if (n->params.max_open_zones) {
+        ns->nr_open_zones++;
+        assert(ns->nr_open_zones <= n->params.max_open_zones);
+    }
+}
+
+static inline void nvme_aor_dec_open(NvmeCtrl *n, NvmeNamespace *ns)
+{
+    if (n->params.max_open_zones) {
+        assert(ns->nr_open_zones > 0);
+        ns->nr_open_zones--;
+    }
+    assert(ns->nr_open_zones >= 0);
+}
+
+static inline void nvme_aor_inc_active(NvmeCtrl *n, NvmeNamespace *ns)
+{
+    assert(ns->nr_active_zones >= 0);
+    if (n->params.max_active_zones) {
+        ns->nr_active_zones++;
+        assert(ns->nr_active_zones <= n->params.max_active_zones);
+    }
+}
+
+static inline void nvme_aor_dec_active(NvmeCtrl *n, NvmeNamespace *ns)
+{
+    if (n->params.max_active_zones) {
+        assert(ns->nr_active_zones > 0);
+        ns->nr_active_zones--;
+        assert(ns->nr_active_zones >= ns->nr_open_zones);
+    }
+    assert(ns->nr_active_zones >= 0);
+}
+
 static void nvme_assign_zone_state(NvmeCtrl *n, NvmeNamespace *ns,
                                    NvmeZone *zone, uint8_t state)
 {
@@ -792,6 +873,41 @@ static uint16_t nvme_check_zone_read(NvmeCtrl *n, NvmeZone *zone, uint64_t slba,
     return status;
 }
 
+static void nvme_auto_transition_zone(NvmeCtrl *n, NvmeNamespace *ns,
+                                      bool implicit, bool adding_active)
+{
+    NvmeZone *zone;
+
+    if (implicit && n->params.max_open_zones &&
+        ns->nr_open_zones == n->params.max_open_zones) {
+        zone = nvme_remove_zone_head(n, ns, ns->imp_open_zones);
+        if (zone) {
+            /*
+             * Automatically close this implicitly open zone.
+             */
+            nvme_aor_dec_open(n, ns);
+            nvme_assign_zone_state(n, ns, zone, NVME_ZONE_STATE_CLOSED);
+        }
+    }
+}
+
+static uint16_t nvme_auto_open_zone(NvmeCtrl *n, NvmeNamespace *ns,
+                                    NvmeZone *zone)
+{
+    uint16_t status = NVME_SUCCESS;
+    uint8_t zs = nvme_get_zone_state(zone);
+
+    if (zs == NVME_ZONE_STATE_EMPTY) {
+        nvme_auto_transition_zone(n, ns, true, true);
+        status = nvme_aor_check(n, ns, 1, 1);
+    } else if (zs == NVME_ZONE_STATE_CLOSED) {
+        nvme_auto_transition_zone(n, ns, true, false);
+        status = nvme_aor_check(n, ns, 0, 1);
+    }
+
+    return status;
+}
+
 static inline uint32_t nvme_zone_idx(NvmeCtrl *n, uint64_t slba)
 {
     return n->zone_size_log2 > 0 ? slba >> n->zone_size_log2 :
@@ -827,7 +943,11 @@ static void nvme_finalize_zone_write(NvmeCtrl *n, NvmeRequest *req)
         switch (zs) {
         case NVME_ZONE_STATE_IMPLICITLY_OPEN:
         case NVME_ZONE_STATE_EXPLICITLY_OPEN:
+            nvme_aor_dec_open(n, ns);
+            /* fall through */
         case NVME_ZONE_STATE_CLOSED:
+            nvme_aor_dec_active(n, ns);
+            /* fall through */
         case NVME_ZONE_STATE_EMPTY:
             break;
         default:
@@ -837,7 +957,10 @@ static void nvme_finalize_zone_write(NvmeCtrl *n, NvmeRequest *req)
     } else {
         switch (zs) {
         case NVME_ZONE_STATE_EMPTY:
+            nvme_aor_inc_active(n, ns);
+            /* fall through */
         case NVME_ZONE_STATE_CLOSED:
+            nvme_aor_inc_open(n, ns);
             nvme_assign_zone_state(n, ns, zone,
                                    NVME_ZONE_STATE_IMPLICITLY_OPEN);
         }
@@ -922,6 +1045,11 @@ static uint16_t nvme_write_zeroes(NvmeCtrl *n, NvmeRequest *req)
                                                zone->d.wp);
             return NVME_ZONE_INVALID_WRITE | NVME_DNR;
         }
+
+        status = nvme_auto_open_zone(n, ns, zone);
+        if (status != NVME_SUCCESS) {
+            return status;
+        }
     }
 
     block_acct_start(blk_get_stats(n->conf.blk), &req->acct, 0,
@@ -993,6 +1121,12 @@ static uint16_t nvme_rw(NvmeCtrl *n, NvmeRequest *req, bool append)
                                                    zone->d.wp);
                 return NVME_ZONE_INVALID_WRITE | NVME_DNR;
             }
+
+            status = nvme_auto_open_zone(n, ns, zone);
+            if (status != NVME_SUCCESS) {
+                return status;
+            }
+
             req->fill_ofs = -1LL;
         } else {
             status = nvme_check_zone_read(n, zone, slba, nlb,
@@ -1085,9 +1219,27 @@ static uint16_t nvme_get_mgmt_zone_slba_idx(NvmeCtrl *n, NvmeNamespace *ns,
 static uint16_t nvme_open_zone(NvmeCtrl *n, NvmeNamespace *ns,
                                NvmeZone *zone, uint8_t state)
 {
+    uint16_t status;
+
     switch (state) {
     case NVME_ZONE_STATE_EMPTY:
+        nvme_auto_transition_zone(n, ns, false, true);
+        status = nvme_aor_check(n, ns, 1, 0);
+        if (status != NVME_SUCCESS) {
+            return status;
+        }
+        nvme_aor_inc_active(n, ns);
+        /* fall through */
     case NVME_ZONE_STATE_CLOSED:
+        status = nvme_aor_check(n, ns, 0, 1);
+        if (status != NVME_SUCCESS) {
+            if (state == NVME_ZONE_STATE_EMPTY) {
+                nvme_aor_dec_active(n, ns);
+            }
+            return status;
+        }
+        nvme_aor_inc_open(n, ns);
+        /* fall through */
     case NVME_ZONE_STATE_IMPLICITLY_OPEN:
         nvme_assign_zone_state(n, ns, zone, NVME_ZONE_STATE_EXPLICITLY_OPEN);
         /* fall through */
@@ -1109,6 +1261,7 @@ static uint16_t nvme_close_zone(NvmeCtrl *n,  NvmeNamespace *ns,
     switch (state) {
     case NVME_ZONE_STATE_EXPLICITLY_OPEN:
     case NVME_ZONE_STATE_IMPLICITLY_OPEN:
+        nvme_aor_dec_open(n, ns);
         nvme_assign_zone_state(n, ns, zone, NVME_ZONE_STATE_CLOSED);
         /* fall through */
     case NVME_ZONE_STATE_CLOSED:
@@ -1130,7 +1283,11 @@ static uint16_t nvme_finish_zone(NvmeCtrl *n, NvmeNamespace *ns,
     switch (state) {
     case NVME_ZONE_STATE_EXPLICITLY_OPEN:
     case NVME_ZONE_STATE_IMPLICITLY_OPEN:
+        nvme_aor_dec_open(n, ns);
+        /* fall through */
     case NVME_ZONE_STATE_CLOSED:
+        nvme_aor_dec_active(n, ns);
+        /* fall through */
     case NVME_ZONE_STATE_EMPTY:
         zone->d.wp = nvme_zone_wr_boundary(zone);
         nvme_assign_zone_state(n, ns, zone, NVME_ZONE_STATE_FULL);
@@ -1155,7 +1312,11 @@ static uint16_t nvme_reset_zone(NvmeCtrl *n, NvmeNamespace *ns,
     switch (state) {
     case NVME_ZONE_STATE_EXPLICITLY_OPEN:
     case NVME_ZONE_STATE_IMPLICITLY_OPEN:
+        nvme_aor_dec_open(n, ns);
+        /* fall through */
     case NVME_ZONE_STATE_CLOSED:
+        nvme_aor_dec_active(n, ns);
+        /* fall through */
     case NVME_ZONE_STATE_FULL:
         zone->d.wp = zone->d.zslba;
         nvme_assign_zone_state(n, ns, zone, NVME_ZONE_STATE_EMPTY);
@@ -3218,6 +3379,18 @@ static void nvme_zoned_init_ctrl(NvmeCtrl *n, Error **errp)
         n->zasl_bs = n->params.zasl_kb * KiB;
     }
 
+    /* Make sure that the values of all Zoned Command Set properties are sane */
+    if (n->params.max_open_zones > nz) {
+        warn_report("max_open_zones value %u exceeds the number of zones %u,"
+                    " adjusting", n->params.max_open_zones, nz);
+        n->params.max_open_zones = nz;
+    }
+    if (n->params.max_active_zones > nz) {
+        warn_report("max_active_zones value %u exceeds the number of zones %u,"
+                    " adjusting", n->params.max_active_zones, nz);
+        n->params.max_active_zones = nz;
+    }
+
     return;
 }
 
@@ -3235,8 +3408,8 @@ static int nvme_zoned_init_ns(NvmeCtrl *n, NvmeNamespace *ns, int lba_index,
     ns->id_ns_zoned = g_malloc0(sizeof(*ns->id_ns_zoned));
 
     /* MAR/MOR are zeroes-based, 0xffffffff means no limit */
-    ns->id_ns_zoned->mar = 0xffffffff;
-    ns->id_ns_zoned->mor = 0xffffffff;
+    ns->id_ns_zoned->mar = cpu_to_le32(n->params.max_active_zones - 1);
+    ns->id_ns_zoned->mor = cpu_to_le32(n->params.max_open_zones - 1);
     ns->id_ns_zoned->zoc = 0;
     ns->id_ns_zoned->ozcs = n->params.cross_zone_read ? 0x01 : 0x00;
 
@@ -3632,6 +3805,8 @@ static Property nvme_props[] = {
                        NVME_DEFAULT_ZONE_SIZE),
     DEFINE_PROP_UINT64("zone_capacity", NvmeCtrl, params.zone_capacity_mb, 0),
     DEFINE_PROP_UINT32("zone_append_size_limit", NvmeCtrl, params.zasl_kb, 0),
+    DEFINE_PROP_UINT32("max_active", NvmeCtrl, params.max_active_zones, 0),
+    DEFINE_PROP_UINT32("max_open", NvmeCtrl, params.max_open_zones, 0),
     DEFINE_PROP_BOOL("cross_zone_read", NvmeCtrl, params.cross_zone_read, true),
     DEFINE_PROP_UINT8("fill_pattern", NvmeCtrl, params.fill_pattern, 0),
     DEFINE_PROP_END_OF_LIST(),
diff --git a/hw/block/nvme.h b/hw/block/nvme.h
index 9514c58919..4a3b23ed72 100644
--- a/hw/block/nvme.h
+++ b/hw/block/nvme.h
@@ -22,6 +22,8 @@ typedef struct NvmeParams {
     uint32_t    zasl_kb;
     uint64_t    zone_size_mb;
     uint64_t    zone_capacity_mb;
+    uint32_t    max_active_zones;
+    uint32_t    max_open_zones;
 } NvmeParams;
 
 typedef struct NvmeAsyncEvent {
@@ -103,6 +105,8 @@ typedef struct NvmeNamespace {
     NvmeZoneList    *imp_open_zones;
     NvmeZoneList    *closed_zones;
     NvmeZoneList    *full_zones;
+    int32_t         nr_open_zones;
+    int32_t         nr_active_zones;
 } NvmeNamespace;
 
 static inline NvmeLBAF *nvme_ns_lbaf(NvmeNamespace *ns)
-- 
2.21.0


