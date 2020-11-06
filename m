Return-Path: <SRS0=tv2o=EM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 408ECC2D0A3
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 23:58:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8AC3D206FC
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 23:58:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="KrtbrNa8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AC3D206FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34086 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kbBcT-0003yX-FT
	for qemu-devel@archiver.kernel.org; Fri, 06 Nov 2020 18:58:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34326)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=572b21b8d=dmitry.fomichev@wdc.com>)
 id 1kbBOP-0005mY-7U; Fri, 06 Nov 2020 18:43:41 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:57376)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=572b21b8d=dmitry.fomichev@wdc.com>)
 id 1kbBOL-0003V2-78; Fri, 06 Nov 2020 18:43:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1604706217; x=1636242217;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=uhMYU7fhme0K9tPS7WLxkmrjtyjoUnongLOGA3/tMno=;
 b=KrtbrNa82EBOijhvt+wCIy9epe0rPDVb7APRodRV4wl6cTkvE4oBypzf
 SEUZf81jehEQ5aHGxI8a/Bk1Bklqw4rNzuf4jpSGcBlXfBs77qiERo/qi
 QOLMCELC+aoSQkSGUHlwLA2sbVlrJ+piWnpzRzkZcVoKTKLYsEng1CNUg
 pNC9QViU2hc8L8tl8vcAb8peVeALjN4EgNYHSesgMgETjhZs6o6tXPzFD
 WbhJfP5I7GPaHjXgTK4i9/6CTiqT/pYNz38IF4R4twm/+Y/g2z3gOat4e
 nPD0mfY40L+xU+of+fy2UQA/SB008k1swCWITDASRKq6cgBcJrFZcZjFL A==;
IronPort-SDR: Qi0JAKBwSGy8yB7yMEo4dnIdDqBlw1VhVn34amsbhPOIFuE71LBVhQzLHx3bhSvIQ55NFbGfXb
 ifdxqfuh4NkC27o+jrXWAsaKps8gIiUYxr0p2hoqTQyZ9zwvibteXeEOcvBnRMOac0j+5+Kc13
 M+c8/lg2Jyi0VyxHz4NNFXHi5HtC5leHCxCXQeNwVXtY3bZiSzzRbL63Koan6cQtoa2BUJZiBV
 AuhIbUywslz98yP9+jWcwPfxqNc2E7QGtu9DIQeTL8zqP6HDCZQ3nRQFPbUOiHeD0uc7HA3ppk
 6Z0=
X-IronPort-AV: E=Sophos;i="5.77,457,1596470400"; d="scan'208";a="153267074"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 07 Nov 2020 07:43:36 +0800
IronPort-SDR: pQGULjxK0aG9AAk+Y7+kxngzhgk0lIP0y5azSmfdV1SJhn3n3cSg4Bgzc6gQqsbArfLnI6DllR
 zIaV5HC2XQhX9b0AnV9pbYQld8p626rwgyjUdlpAljI4/+vVSMgBRBUuPjNmhESFBtvvj2T9zH
 3AHEVWUyP+cfgI9b9+SP83B3eTCuVKHnI+lV+4NpOlywWauXear+2EbAppylbler5ZEAcxbtOm
 9iN1bz2Z/+8G0IY8pvQ25urqxenXLalChz+19YGXkTIZiqtr+6SmUv67N+UIr7MEWg34bwQeGh
 2Prqc39k5+qo5aidcIv8g4ks
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Nov 2020 15:28:27 -0800
IronPort-SDR: w2N7p88GIimh1uJSFmOerWwsINwbSFVECWt6cc13bHm4lY349suBki/rhD3ThsaslHki+ssP/V
 VMIp0OFMx4ogdfVixIWSu5+772ljpPt1SmtNCZx7CV8DmkC0Lgcz5tO9tek+AhjBLBh48XDzB3
 CZP6gz5Av0rLK4UOvo7NzIiPJMICuUSKfdo8UW0PbTxs1G+WKIbEA3k+kFZkALikSx7KIaJc20
 EpjoJU3F/aGY88FTn+afxaOyr1Gr9vw0V+pg7y5wUUahkeHvKS5X7o15c8Qa6/xSN6ljT04bmr
 4rA=
WDCIronportException: Internal
Received: from unknown (HELO redsun50.ssa.fujisawa.hgst.com) ([10.149.66.24])
 by uls-op-cesaip01.wdc.com with ESMTP; 06 Nov 2020 15:43:34 -0800
From: Dmitry Fomichev <dmitry.fomichev@wdc.com>
To: Keith Busch <kbusch@kernel.org>, Klaus Jensen <k.jensen@samsung.com>,
 Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>,
 Fam Zheng <fam@euphon.net>
Subject: [PATCH v10 09/12] hw/block/nvme: Introduce max active and open zone
 limits
Date: Sat,  7 Nov 2020 08:43:02 +0900
Message-Id: <20201106234305.21339-10-dmitry.fomichev@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20201106234305.21339-1-dmitry.fomichev@wdc.com>
References: <20201106234305.21339-1-dmitry.fomichev@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.154.45;
 envelope-from=prvs=572b21b8d=dmitry.fomichev@wdc.com; helo=esa6.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/06 18:43:12
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

Add two module properties, "zoned.max_active" and "zoned.max_open"
to control the maximum number of zones that can be active or open.
Once these variables are set to non-default values, these limits are
checked during I/O and Too Many Active or Too Many Open command status
is returned if they are exceeded.

Signed-off-by: Hans Holmberg <hans.holmberg@wdc.com>
Signed-off-by: Dmitry Fomichev <dmitry.fomichev@wdc.com>
Reviewed-by: Niklas Cassel <Niklas.Cassel@wdc.com>
---
 hw/block/nvme-ns.h    | 41 +++++++++++++++++++
 hw/block/nvme-ns.c    | 30 +++++++++++++-
 hw/block/nvme.c       | 94 +++++++++++++++++++++++++++++++++++++++++++
 hw/block/trace-events |  2 +
 4 files changed, 165 insertions(+), 2 deletions(-)

diff --git a/hw/block/nvme-ns.h b/hw/block/nvme-ns.h
index d2631ff5a3..421bab0a57 100644
--- a/hw/block/nvme-ns.h
+++ b/hw/block/nvme-ns.h
@@ -33,6 +33,8 @@ typedef struct NvmeNamespaceParams {
     bool     cross_zone_read;
     uint64_t zone_size_bs;
     uint64_t zone_cap_bs;
+    uint32_t max_active_zones;
+    uint32_t max_open_zones;
 } NvmeNamespaceParams;
 
 typedef struct NvmeNamespace {
@@ -56,6 +58,8 @@ typedef struct NvmeNamespace {
     uint64_t        zone_capacity;
     uint64_t        zone_array_size;
     uint32_t        zone_size_log2;
+    int32_t         nr_open_zones;
+    int32_t         nr_active_zones;
 
     NvmeNamespaceParams params;
 } NvmeNamespace;
@@ -123,6 +127,43 @@ static inline bool nvme_wp_is_valid(NvmeZone *zone)
            st != NVME_ZONE_STATE_OFFLINE;
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
 int nvme_ns_setup(NvmeCtrl *n, NvmeNamespace *ns, Error **errp);
 void nvme_ns_drain(NvmeNamespace *ns);
 void nvme_ns_flush(NvmeNamespace *ns);
diff --git a/hw/block/nvme-ns.c b/hw/block/nvme-ns.c
index e6db7f7d3b..2e45838c15 100644
--- a/hw/block/nvme-ns.c
+++ b/hw/block/nvme-ns.c
@@ -119,6 +119,20 @@ static int nvme_calc_zone_geometry(NvmeNamespace *ns, Error **errp)
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
 
@@ -166,8 +180,8 @@ static int nvme_zoned_init_ns(NvmeCtrl *n, NvmeNamespace *ns, int lba_index,
     id_ns_z = g_malloc0(sizeof(NvmeIdNsZoned));
 
     /* MAR/MOR are zeroes-based, 0xffffffff means no limit */
-    id_ns_z->mar = 0xffffffff;
-    id_ns_z->mor = 0xffffffff;
+    id_ns_z->mar = cpu_to_le32(ns->params.max_active_zones - 1);
+    id_ns_z->mor = cpu_to_le32(ns->params.max_open_zones - 1);
     id_ns_z->zoc = 0;
     id_ns_z->ozcs = ns->params.cross_zone_read ? 0x01 : 0x00;
 
@@ -195,6 +209,7 @@ static void nvme_clear_zone(NvmeNamespace *ns, NvmeZone *zone)
             trace_pci_nvme_clear_ns_close(state, zone->d.zslba);
             nvme_set_zone_state(zone, NVME_ZONE_STATE_CLOSED);
         }
+        nvme_aor_inc_active(ns);
         QTAILQ_INSERT_HEAD(&ns->closed_zones, zone, entry);
     } else {
         trace_pci_nvme_clear_ns_reset(state, zone->d.zslba);
@@ -211,16 +226,23 @@ static void nvme_zoned_ns_shutdown(NvmeNamespace *ns)
 
     QTAILQ_FOREACH_SAFE(zone, &ns->closed_zones, entry, next) {
         QTAILQ_REMOVE(&ns->closed_zones, zone, entry);
+        nvme_aor_dec_active(ns);
         nvme_clear_zone(ns, zone);
     }
     QTAILQ_FOREACH_SAFE(zone, &ns->imp_open_zones, entry, next) {
         QTAILQ_REMOVE(&ns->imp_open_zones, zone, entry);
+        nvme_aor_dec_open(ns);
+        nvme_aor_dec_active(ns);
         nvme_clear_zone(ns, zone);
     }
     QTAILQ_FOREACH_SAFE(zone, &ns->exp_open_zones, entry, next) {
         QTAILQ_REMOVE(&ns->exp_open_zones, zone, entry);
+        nvme_aor_dec_open(ns);
+        nvme_aor_dec_active(ns);
         nvme_clear_zone(ns, zone);
     }
+
+    assert(ns->nr_open_zones == 0);
 }
 
 static int nvme_ns_check_constraints(NvmeNamespace *ns, Error **errp)
@@ -306,6 +328,10 @@ static Property nvme_ns_props[] = {
     DEFINE_PROP_SIZE("zoned.zcap", NvmeNamespace, params.zone_cap_bs, 0),
     DEFINE_PROP_BOOL("zoned.cross_read", NvmeNamespace,
                      params.cross_zone_read, false),
+    DEFINE_PROP_UINT32("zoned.max_active", NvmeNamespace,
+                       params.max_active_zones, 0),
+    DEFINE_PROP_UINT32("zoned.max_open", NvmeNamespace,
+                       params.max_open_zones, 0),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index f5390e6863..c6b3a5dcf7 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -199,6 +199,26 @@ static void nvme_assign_zone_state(NvmeNamespace *ns, NvmeZone *zone,
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
@@ -1193,6 +1213,41 @@ static uint16_t nvme_check_zone_read(NvmeNamespace *ns, uint64_t slba,
     return status;
 }
 
+static void nvme_auto_transition_zone(NvmeNamespace *ns, bool implicit,
+                                      bool adding_active)
+{
+    NvmeZone *zone;
+
+    if (implicit && ns->params.max_open_zones &&
+        ns->nr_open_zones == ns->params.max_open_zones) {
+        zone = QTAILQ_FIRST(&ns->imp_open_zones);
+        if (zone) {
+            /*
+             * Automatically close this implicitly open zone.
+             */
+            QTAILQ_REMOVE(&ns->imp_open_zones, zone, entry);
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
 static bool nvme_finalize_zoned_write(NvmeNamespace *ns, NvmeRequest *req,
                                       bool failed)
 {
@@ -1226,7 +1281,11 @@ static bool nvme_finalize_zoned_write(NvmeNamespace *ns, NvmeRequest *req,
         switch (nvme_get_zone_state(zone)) {
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
@@ -1255,7 +1314,10 @@ static uint64_t nvme_advance_zone_wp(NvmeNamespace *ns, NvmeZone *zone,
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
@@ -1449,6 +1511,11 @@ static uint16_t nvme_write(NvmeCtrl *n, NvmeRequest *req, bool append, bool wrz)
             goto invalid;
         }
 
+        status = nvme_auto_open_zone(ns, zone);
+        if (status != NVME_SUCCESS) {
+            goto invalid;
+        }
+
         if (append) {
             slba = zone->w_ptr;
         }
@@ -1529,9 +1596,27 @@ enum NvmeZoneProcessingMask {
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
@@ -1548,6 +1633,7 @@ static uint16_t nvme_close_zone(NvmeNamespace *ns, NvmeZone *zone,
     switch (state) {
     case NVME_ZONE_STATE_EXPLICITLY_OPEN:
     case NVME_ZONE_STATE_IMPLICITLY_OPEN:
+        nvme_aor_dec_open(ns);
         nvme_assign_zone_state(ns, zone, NVME_ZONE_STATE_CLOSED);
         /* fall through */
     case NVME_ZONE_STATE_CLOSED:
@@ -1563,7 +1649,11 @@ static uint16_t nvme_finish_zone(NvmeNamespace *ns, NvmeZone *zone,
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
@@ -1582,7 +1672,11 @@ static uint16_t nvme_reset_zone(NvmeNamespace *ns, NvmeZone *zone,
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
diff --git a/hw/block/trace-events b/hw/block/trace-events
index 4d910bb942..e674522883 100644
--- a/hw/block/trace-events
+++ b/hw/block/trace-events
@@ -122,6 +122,8 @@ pci_nvme_err_append_not_at_start(uint64_t slba, uint64_t zone) "appending at slb
 pci_nvme_err_zone_write_not_ok(uint64_t slba, uint32_t nlb, uint32_t status) "slba=%"PRIu64", nlb=%"PRIu32", status=0x%"PRIx16""
 pci_nvme_err_zone_read_not_ok(uint64_t slba, uint32_t nlb, uint32_t status) "slba=%"PRIu64", nlb=%"PRIu32", status=0x%"PRIx16""
 pci_nvme_err_append_too_large(uint64_t slba, uint32_t nlb, uint8_t zasl) "slba=%"PRIu64", nlb=%"PRIu32", zasl=%"PRIu8""
+pci_nvme_err_insuff_active_res(uint32_t max_active) "max_active=%"PRIu32" zone limit exceeded"
+pci_nvme_err_insuff_open_res(uint32_t max_open) "max_open=%"PRIu32" zone limit exceeded"
 pci_nvme_err_invalid_iocsci(uint32_t idx) "unsupported command set combination index %"PRIu32""
 pci_nvme_err_invalid_del_sq(uint16_t qid) "invalid submission queue deletion, sid=%"PRIu16""
 pci_nvme_err_invalid_create_sq_cqid(uint16_t cqid) "failed creating submission queue, invalid cqid=%"PRIu16""
-- 
2.21.0


