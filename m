Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED706C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 21:49:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B586F2168B
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 21:49:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Ghq7WX7Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B586F2168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37762 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlfwQ-0005LX-TM
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 17:49:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46250)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=430b82a1d=dmitry.fomichev@wdc.com>)
 id 1jlfiJ-0004Y7-AB; Wed, 17 Jun 2020 17:35:19 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:29866)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=430b82a1d=dmitry.fomichev@wdc.com>)
 id 1jlfiE-0005I4-99; Wed, 17 Jun 2020 17:35:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1592429714; x=1623965714;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=rmi02F+uclU5nynYawpXrWkddeuvL3BZWHmUPifm9xI=;
 b=Ghq7WX7YiLGoY0808Qsewfepe6qf5FmZn6KR5Ed1gHOFRxKOdpWui54x
 4Uk5KvGowa2Y94jMZjn9uUnyAplcgj8Crld8n/TVsr1meaYNhZhGgg2Vp
 doqR009TKbElaDdjVmQDcUMpcCaQcv2rN9LxHBeclzlIcb4auE+S9Sc2L
 oo4wqu9Q3lVjgRg4Mk965e8EuY7ptH+tJ+GN2rhv3cuntrshFNtm5aui6
 dpjc1raS7v6VEEFf+7MLSbc6bFatt2rIjiiv4fWpt5T2/b5kW/Gmni2SM
 xMO3HvNq2SzGZjMt8WOHyERio3o3VOm9JwbRsk4BTKhb1xap/KSZe4i3t A==;
IronPort-SDR: urrtczvvNqUSYgGGg4fwZ28pCehImY+DctLDeyuCez8kClc6D4N5lh+tlrhTIzAgtKgeHRmomj
 JzePp9JtVF3r8bgafjpnSLcvZwgyh9QCLjhwTYt3AqEoZDGuiOHKDoeOOL81AVYm6EAkVT6gTK
 uEu3mFGGHBlqVEdsW+sDSbvG52t416DjhCApKAZ89p1SyB1hciOQZ2DV/emTYq1pWi27syc2pO
 M/o64gUThNkIvf9tS4QjJmirn5OXBASsq7swMjaegfNRwFLTv6Dr4UyUqHRLAB1kbVuC65tUnx
 6PU=
X-IronPort-AV: E=Sophos;i="5.73,523,1583164800"; d="scan'208";a="249439834"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 18 Jun 2020 05:34:51 +0800
IronPort-SDR: sytCPdMjytxDDLnK1dxXyfYwSL661RbpXOPcNyuOy+9z/4MUXwS35Lr6gYrp586kAzYolq7dKl
 mW7mvwyYlNGvo0z+Fe+leKQlxnd2xbwDo=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jun 2020 14:23:32 -0700
IronPort-SDR: R97+zqbGmitN2Bn/Kf/fWfZTL/uu8+f/hKUt/cSOjqc6xYmqoGnJLcgjVZ2QJc3M/A7hxK3IxE
 foVorlpZnZmg==
WDCIronportException: Internal
Received: from unknown (HELO redsun50.ssa.fujisawa.hgst.com) ([10.149.66.24])
 by uls-op-cesaip02.wdc.com with ESMTP; 17 Jun 2020 14:34:50 -0700
From: Dmitry Fomichev <dmitry.fomichev@wdc.com>
To: Kevin Wolf <kwolf@redhat.com>, Keith Busch <kbusch@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Maxim Levitsky <mlevitsky@redhat.com>
Subject: [PATCH v2 13/18] hw/block/nvme: Set Finish/Reset Zone Recommended
 attributes
Date: Thu, 18 Jun 2020 06:34:10 +0900
Message-Id: <20200617213415.22417-14-dmitry.fomichev@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200617213415.22417-1-dmitry.fomichev@wdc.com>
References: <20200617213415.22417-1-dmitry.fomichev@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=68.232.141.245;
 envelope-from=prvs=430b82a1d=dmitry.fomichev@wdc.com; helo=esa1.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/17 17:34:28
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
 Matias Bjorling <matias.bjorling@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Added logic to set and reset FZR and RZR zone attributes. Four new
driver properties are added to control the timing of setting and
resetting these attributes. FZR/RZR delay lasts from the zone
operation and until when the corresponding zone attribute is set.
FZR/RZR limits set the time period between setting FZR or RZR
attribute and resetting it simulating the internal controller action
on that zone.

Signed-off-by: Dmitry Fomichev <dmitry.fomichev@wdc.com>
---
 hw/block/nvme.c | 99 +++++++++++++++++++++++++++++++++++++++++++++++++
 hw/block/nvme.h | 13 ++++++-
 2 files changed, 111 insertions(+), 1 deletion(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index a29cbfcc96..c3898448c7 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -201,6 +201,84 @@ static inline void nvme_aor_dec_active(NvmeCtrl *n, NvmeNamespace *ns)
     assert(ns->nr_active_zones >= 0);
 }
 
+static void nvme_set_rzr(NvmeCtrl *n, NvmeNamespace *ns, NvmeZone *zone)
+{
+    assert(zone->flags & NVME_ZFLAGS_SET_RZR);
+    zone->tstamp = qemu_clock_get_ns(QEMU_CLOCK_REALTIME);
+    zone->flags &= ~NVME_ZFLAGS_TS_DELAY;
+    zone->d.za |= NVME_ZA_RESET_RECOMMENDED;
+    zone->flags &= ~NVME_ZFLAGS_SET_RZR;
+    trace_pci_nvme_zone_reset_recommended(zone->d.zslba);
+}
+
+static void nvme_clear_rzr(NvmeCtrl *n, NvmeNamespace *ns,
+    NvmeZone *zone, bool notify)
+{
+    if (n->params.rrl_usec) {
+        zone->flags &= ~(NVME_ZFLAGS_SET_RZR | NVME_ZFLAGS_TS_DELAY);
+        notify = notify && (zone->d.za & NVME_ZA_RESET_RECOMMENDED);
+        zone->d.za &= ~NVME_ZA_RESET_RECOMMENDED;
+        zone->tstamp = 0;
+    }
+}
+
+static void nvme_set_fzr(NvmeCtrl *n, NvmeNamespace *ns, NvmeZone *zone)
+{
+    assert(zone->flags & NVME_ZFLAGS_SET_FZR);
+    zone->tstamp = qemu_clock_get_ns(QEMU_CLOCK_REALTIME);
+    zone->flags &= ~NVME_ZFLAGS_TS_DELAY;
+    zone->d.za |= NVME_ZA_FINISH_RECOMMENDED;
+    zone->flags &= ~NVME_ZFLAGS_SET_FZR;
+    trace_pci_nvme_zone_finish_recommended(zone->d.zslba);
+}
+
+static void nvme_clear_fzr(NvmeCtrl *n, NvmeNamespace *ns,
+    NvmeZone *zone, bool notify)
+{
+    if (n->params.frl_usec) {
+        zone->flags &= ~(NVME_ZFLAGS_SET_FZR | NVME_ZFLAGS_TS_DELAY);
+        notify = notify && (zone->d.za & NVME_ZA_FINISH_RECOMMENDED);
+        zone->d.za &= ~NVME_ZA_FINISH_RECOMMENDED;
+        zone->tstamp = 0;
+    }
+}
+
+static void nvme_schedule_rzr(NvmeCtrl *n, NvmeNamespace *ns, NvmeZone *zone)
+{
+    if (n->params.frl_usec) {
+        zone->flags &= ~(NVME_ZFLAGS_SET_FZR | NVME_ZFLAGS_TS_DELAY);
+        zone->d.za &= ~NVME_ZA_FINISH_RECOMMENDED;
+        zone->tstamp = 0;
+    }
+    if (n->params.rrl_usec) {
+        zone->flags |= NVME_ZFLAGS_SET_RZR;
+        if (n->params.rzr_delay_usec) {
+            zone->tstamp = qemu_clock_get_ns(QEMU_CLOCK_REALTIME);
+            zone->flags |= NVME_ZFLAGS_TS_DELAY;
+        } else {
+            nvme_set_rzr(n, ns, zone);
+        }
+    }
+}
+
+static void nvme_schedule_fzr(NvmeCtrl *n, NvmeNamespace *ns, NvmeZone *zone)
+{
+    if (n->params.rrl_usec) {
+        zone->flags &= ~(NVME_ZFLAGS_SET_RZR | NVME_ZFLAGS_TS_DELAY);
+        zone->d.za &= ~NVME_ZA_RESET_RECOMMENDED;
+        zone->tstamp = 0;
+    }
+    if (n->params.frl_usec) {
+        zone->flags |= NVME_ZFLAGS_SET_FZR;
+        if (n->params.fzr_delay_usec) {
+            zone->tstamp = qemu_clock_get_ns(QEMU_CLOCK_REALTIME);
+            zone->flags |= NVME_ZFLAGS_TS_DELAY;
+        } else {
+            nvme_set_fzr(n, ns, zone);
+        }
+    }
+}
+
 static void nvme_assign_zone_state(NvmeCtrl *n, NvmeNamespace *ns,
     NvmeZone *zone, uint8_t state)
 {
@@ -208,15 +286,19 @@ static void nvme_assign_zone_state(NvmeCtrl *n, NvmeNamespace *ns,
         switch (nvme_get_zone_state(zone)) {
         case NVME_ZONE_STATE_EXPLICITLY_OPEN:
             nvme_remove_zone(n, ns, ns->exp_open_zones, zone);
+            nvme_clear_fzr(n, ns, zone, false);
             break;
         case NVME_ZONE_STATE_IMPLICITLY_OPEN:
             nvme_remove_zone(n, ns, ns->imp_open_zones, zone);
+            nvme_clear_fzr(n, ns, zone, false);
             break;
         case NVME_ZONE_STATE_CLOSED:
             nvme_remove_zone(n, ns, ns->closed_zones, zone);
+            nvme_clear_fzr(n, ns, zone, false);
             break;
         case NVME_ZONE_STATE_FULL:
             nvme_remove_zone(n, ns, ns->full_zones, zone);
+            nvme_clear_rzr(n, ns, zone, false);
         }
    }
 
@@ -225,15 +307,19 @@ static void nvme_assign_zone_state(NvmeCtrl *n, NvmeNamespace *ns,
     switch (state) {
     case NVME_ZONE_STATE_EXPLICITLY_OPEN:
         nvme_add_zone_tail(n, ns, ns->exp_open_zones, zone);
+        nvme_schedule_fzr(n, ns, zone);
         break;
     case NVME_ZONE_STATE_IMPLICITLY_OPEN:
         nvme_add_zone_tail(n, ns, ns->imp_open_zones, zone);
+        nvme_schedule_fzr(n, ns, zone);
         break;
     case NVME_ZONE_STATE_CLOSED:
         nvme_add_zone_tail(n, ns, ns->closed_zones, zone);
+        nvme_schedule_fzr(n, ns, zone);
         break;
     case NVME_ZONE_STATE_FULL:
         nvme_add_zone_tail(n, ns, ns->full_zones, zone);
+        nvme_schedule_rzr(n, ns, zone);
         break;
     default:
         zone->d.za = 0;
@@ -555,6 +641,7 @@ static void nvme_auto_transition_zone(NvmeCtrl *n, NvmeNamespace *ns,
             zone->d.za &= ~(NVME_ZA_FINISH_RECOMMENDED |
                             NVME_ZA_RESET_RECOMMENDED);
             zone->d.za |= NVME_ZA_FINISHED_BY_CTLR;
+            zone->flags = 0;
             zone->tstamp = 0;
             trace_pci_nvme_zone_finished_by_controller(zone->d.zslba);
         }
@@ -2624,6 +2711,11 @@ static void nvme_zoned_init_ctrl(NvmeCtrl *n, Error **errp)
     n->num_zones = nz;
     n->zone_array_size = sizeof(NvmeZone) * nz;
 
+    n->params.rzr_delay_usec *= SCALE_MS;
+    n->params.rrl_usec *= SCALE_MS;
+    n->params.fzr_delay_usec *= SCALE_MS;
+    n->params.frl_usec *= SCALE_MS;
+
     /* Make sure that the values of all Zoned Command Set properties are sane */
     if (n->params.max_open_zones > nz) {
         n->params.max_open_zones = nz;
@@ -2651,6 +2743,8 @@ static int nvme_zoned_init_ns(NvmeCtrl *n, NvmeNamespace *ns, int lba_index,
     /* MAR/MOR are zeroes-based, 0xffffffff means no limit */
     ns->id_ns_zoned->mar = cpu_to_le32(n->params.max_active_zones - 1);
     ns->id_ns_zoned->mor = cpu_to_le32(n->params.max_open_zones - 1);
+    ns->id_ns_zoned->rrl = cpu_to_le32(n->params.rrl_usec / (1000 * SCALE_MS));
+    ns->id_ns_zoned->frl = cpu_to_le32(n->params.frl_usec / (1000 * SCALE_MS));
     ns->id_ns_zoned->zoc = cpu_to_le16(n->params.active_excursions ? 0x2 : 0);
     ns->id_ns_zoned->ozcs = n->params.cross_zone_read ? 0x01 : 0x00;
 
@@ -3012,6 +3106,11 @@ static Property nvme_props[] = {
     DEFINE_PROP_UINT32("zone_append_max_size", NvmeCtrl, params.zamds_bs, 0),
     DEFINE_PROP_INT32("max_active", NvmeCtrl, params.max_active_zones, 0),
     DEFINE_PROP_INT32("max_open", NvmeCtrl, params.max_open_zones, 0),
+    DEFINE_PROP_UINT64("reset_rcmnd_delay", NvmeCtrl, params.rzr_delay_usec, 0),
+    DEFINE_PROP_UINT64("reset_rcmnd_limit", NvmeCtrl, params.rrl_usec, 0),
+    DEFINE_PROP_UINT64("finish_rcmnd_delay", NvmeCtrl,
+                       params.fzr_delay_usec, 0),
+    DEFINE_PROP_UINT64("finish_rcmnd_limit", NvmeCtrl, params.frl_usec, 0),
     DEFINE_PROP_BOOL("cross_zone_read", NvmeCtrl, params.cross_zone_read, true),
     DEFINE_PROP_BOOL("active_excursions", NvmeCtrl, params.active_excursions,
                      false),
diff --git a/hw/block/nvme.h b/hw/block/nvme.h
index 8a0aaeb09a..be1920f1ef 100644
--- a/hw/block/nvme.h
+++ b/hw/block/nvme.h
@@ -22,6 +22,10 @@ typedef struct NvmeParams {
     uint64_t    zone_capacity;
     int32_t     max_active_zones;
     int32_t     max_open_zones;
+    uint64_t    rzr_delay_usec;
+    uint64_t    rrl_usec;
+    uint64_t    fzr_delay_usec;
+    uint64_t    frl_usec;
 } NvmeParams;
 
 typedef struct NvmeAsyncEvent {
@@ -77,12 +81,19 @@ typedef struct NvmeCQueue {
     QTAILQ_HEAD(, NvmeRequest) req_list;
 } NvmeCQueue;
 
+enum NvmeZoneFlags {
+    NVME_ZFLAGS_TS_DELAY = 1 << 0,
+    NVME_ZFLAGS_SET_RZR  = 1 << 1,
+    NVME_ZFLAGS_SET_FZR  = 1 << 2,
+};
+
 typedef struct NvmeZone {
     NvmeZoneDescr   d;
     uint64_t        tstamp;
+    uint32_t        flags;
     uint32_t        next;
     uint32_t        prev;
-    uint8_t         rsvd80[8];
+    uint8_t         rsvd84[4];
 } NvmeZone;
 
 #define NVME_ZONE_LIST_NIL    UINT_MAX
-- 
2.21.0


