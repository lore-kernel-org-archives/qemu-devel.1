Return-Path: <SRS0=LLOU=EL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8EB7C2D0A3
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 03:01:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47C3220825
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 03:01:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="EiwEYenf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47C3220825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40034 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaVWp-0000wf-7T
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 22:01:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55158)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=571894d84=dmitry.fomichev@wdc.com>)
 id 1kaVPi-0007tf-K8; Wed, 04 Nov 2020 21:54:15 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:49734)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=571894d84=dmitry.fomichev@wdc.com>)
 id 1kaVPf-0002fM-Uu; Wed, 04 Nov 2020 21:54:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1604544851; x=1636080851;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=RRYwzfEnj5UydKPdBoZHRXaFjKzjB6jrruTnWwQZgI0=;
 b=EiwEYenf1siMQtaY97E0krggTImFHyq+54YY6VfwukmiTDZc9Jl16G2Q
 DWFVxi8QHdB0Ak/MmKUG+yQA/bQiWRNAn5v7onGo9FNWsWLqpgS+LCAYb
 mMp/5gPfljhGuMfNNeP9U8IFaxfFZoArXifk+ZB6MpQB1oAee/i4k5nSQ
 agFOFv/FJV8gpxdHTofeG0PxN2aZQuq5dhtM567i6yQDupRdfBXQ7g1qY
 Y3lMAYoRQ7TLAS3bAnLdH3fscxwvWzxa/uwRIOaoCZR0KnI4derSPHthF
 TI9iXGVz31iO+TZ5P+ad41oVUoIAMradksFl29l1x5mzl/f3bUkZ7CYJl w==;
IronPort-SDR: qB6r74jAT11M91oRc/lP08f4M/2nnEr1lfr/BpKOdJDwYLRuU4Q7QZQeITDvf+i4gshF161nku
 TyprzPTZHWRzAjZbjXOEV+yzKY011K4vFA8mRLczidDT/xzGQoBt6SFLBdlz4AvkKZ/gk8ORvb
 nzFtfDv+RgMpGtkyGIHfuqWXYvrASAIUCY1bBnexUE50YZtZa5yb2uHfNcBInjODrhwPz2glPa
 3bELK7r3pw6WTn/V7lyNInXp0hHqUnIjvhBYEBeEBZnFOBZALBMTHcqTB6UCDNE+knMP8RycRV
 myE=
X-IronPort-AV: E=Sophos;i="5.77,452,1596470400"; d="scan'208";a="156335150"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 05 Nov 2020 10:54:09 +0800
IronPort-SDR: 9apKX+/BsHU/Yh1oMGCCWIdjb2wLjE5bUGJ2mT4q0QuIAzw55V1IGYAIN2F2y4gI+DiQ7PuyJE
 RtwYSC3rnlQxf/g5cFTo6tVYOurzxaSkz8MBw9fdnHbsVcqh29bfeDf/2ukiIq1678yP2W54Op
 Y9XveprMDNdGTAlMCUyNGo4JPvzVq9EBRDrKxEURzc2AQExElOftTkdXaGOwb8XyXIMm/0qXXO
 4phVkuGrakp1ZeVKpQjM5xj85Ey1lmrYvJ0dAfp5wR/iVd4XHjZz1h33vY9d42wSjzJD86tMoA
 gp/r80xG1EcIPFWol0Rlut+p
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2020 18:40:16 -0800
IronPort-SDR: mVD3P3myTvSCkPLLwIrEspivLbRMzYbCsmrMnAukhcxRTjereJY9UC3AaMBYYpxMQKZDi3uUoL
 TAZB/YMg1DXpTUOAToUegTeW4k6G6hrUVGxUwsGALlASYUGlatLet5g7SKj1aayB4cx0FOFHkz
 Bdwa8pQCV1SuD1abQfIXOj8QeB2fRneE7xrZFHC3vJ8cmX6Na6tRSNNNz3ZTr0LCi1FvZ1UwS5
 vXaC2lt3k+gCe1pLiEMSlD/P0BSbMRNd9Lme8XscpJQ9L1KNiiV1m1mZL3qttN0ihJsw2jfcFg
 aT8=
WDCIronportException: Internal
Received: from unknown (HELO redsun50.ssa.fujisawa.hgst.com) ([10.149.66.24])
 by uls-op-cesaip02.wdc.com with ESMTP; 04 Nov 2020 18:54:07 -0800
From: Dmitry Fomichev <dmitry.fomichev@wdc.com>
To: Keith Busch <kbusch@kernel.org>, Klaus Jensen <k.jensen@samsung.com>,
 Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>,
 Fam Zheng <fam@euphon.net>
Subject: [PATCH v9 10/12] hw/block/nvme: Support Zone Descriptor Extensions
Date: Thu,  5 Nov 2020 11:53:40 +0900
Message-Id: <20201105025342.9037-11-dmitry.fomichev@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20201105025342.9037-1-dmitry.fomichev@wdc.com>
References: <20201105025342.9037-1-dmitry.fomichev@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.153.141;
 envelope-from=prvs=571894d84=dmitry.fomichev@wdc.com; helo=esa3.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/04 21:53:45
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

Zone Descriptor Extension is a label that can be assigned to a zone.
It can be set to an Empty zone and it stays assigned until the zone
is reset.

This commit adds a new optional module property,
"zoned.descr_ext_size". Its value must be a multiple of 64 bytes.
If this value is non-zero, it becomes possible to assign extensions
of that size to any Empty zones. The default value for this property
is 0, therefore setting extensions is disabled by default.

Signed-off-by: Hans Holmberg <hans.holmberg@wdc.com>
Signed-off-by: Dmitry Fomichev <dmitry.fomichev@wdc.com>
Reviewed-by: Klaus Jensen <k.jensen@samsung.com>
Reviewed-by: Niklas Cassel <Niklas.Cassel@wdc.com>
---
 hw/block/nvme-ns.h    |  8 +++++++
 hw/block/nvme-ns.c    | 25 ++++++++++++++++++--
 hw/block/nvme.c       | 54 +++++++++++++++++++++++++++++++++++++++++--
 hw/block/trace-events |  2 ++
 4 files changed, 85 insertions(+), 4 deletions(-)

diff --git a/hw/block/nvme-ns.h b/hw/block/nvme-ns.h
index 421bab0a57..50a6a0e1ac 100644
--- a/hw/block/nvme-ns.h
+++ b/hw/block/nvme-ns.h
@@ -35,6 +35,7 @@ typedef struct NvmeNamespaceParams {
     uint64_t zone_cap_bs;
     uint32_t max_active_zones;
     uint32_t max_open_zones;
+    uint32_t zd_extension_size;
 } NvmeNamespaceParams;
 
 typedef struct NvmeNamespace {
@@ -58,6 +59,7 @@ typedef struct NvmeNamespace {
     uint64_t        zone_capacity;
     uint64_t        zone_array_size;
     uint32_t        zone_size_log2;
+    uint8_t         *zd_extensions;
     int32_t         nr_open_zones;
     int32_t         nr_active_zones;
 
@@ -127,6 +129,12 @@ static inline bool nvme_wp_is_valid(NvmeZone *zone)
            st != NVME_ZONE_STATE_OFFLINE;
 }
 
+static inline uint8_t *nvme_get_zd_extension(NvmeNamespace *ns,
+                                             uint32_t zone_idx)
+{
+    return &ns->zd_extensions[zone_idx * ns->params.zd_extension_size];
+}
+
 static inline void nvme_aor_inc_open(NvmeNamespace *ns)
 {
     assert(ns->nr_open_zones >= 0);
diff --git a/hw/block/nvme-ns.c b/hw/block/nvme-ns.c
index 2e45838c15..85dc73cf06 100644
--- a/hw/block/nvme-ns.c
+++ b/hw/block/nvme-ns.c
@@ -133,6 +133,18 @@ static int nvme_calc_zone_geometry(NvmeNamespace *ns, Error **errp)
         return -1;
     }
 
+    if (ns->params.zd_extension_size) {
+        if (ns->params.zd_extension_size & 0x3f) {
+            error_setg(errp,
+                "zone descriptor extension size must be a multiple of 64B");
+            return -1;
+        }
+        if ((ns->params.zd_extension_size >> 6) > 0xff) {
+            error_setg(errp, "zone descriptor extension size is too large");
+            return -1;
+        }
+    }
+
     return 0;
 }
 
@@ -144,6 +156,10 @@ static void nvme_init_zone_state(NvmeNamespace *ns)
     int i;
 
     ns->zone_array = g_malloc0(ns->zone_array_size);
+    if (ns->params.zd_extension_size) {
+        ns->zd_extensions = g_malloc0(ns->params.zd_extension_size *
+                                      ns->num_zones);
+    }
 
     QTAILQ_INIT(&ns->exp_open_zones);
     QTAILQ_INIT(&ns->imp_open_zones);
@@ -186,7 +202,8 @@ static int nvme_zoned_init_ns(NvmeCtrl *n, NvmeNamespace *ns, int lba_index,
     id_ns_z->ozcs = ns->params.cross_zone_read ? 0x01 : 0x00;
 
     id_ns_z->lbafe[lba_index].zsze = cpu_to_le64(ns->zone_size);
-    id_ns_z->lbafe[lba_index].zdes = 0;
+    id_ns_z->lbafe[lba_index].zdes =
+        ns->params.zd_extension_size >> 6; /* Units of 64B */
 
     ns->csi = NVME_CSI_ZONED;
     ns->id_ns.nsze = cpu_to_le64(ns->zone_size * ns->num_zones);
@@ -204,7 +221,8 @@ static void nvme_clear_zone(NvmeNamespace *ns, NvmeZone *zone)
 
     zone->w_ptr = zone->d.wp;
     state = nvme_get_zone_state(zone);
-    if (zone->d.wp != zone->d.zslba) {
+    if (zone->d.wp != zone->d.zslba ||
+        (zone->d.za & NVME_ZA_ZD_EXT_VALID)) {
         if (state != NVME_ZONE_STATE_CLOSED) {
             trace_pci_nvme_clear_ns_close(state, zone->d.zslba);
             nvme_set_zone_state(zone, NVME_ZONE_STATE_CLOSED);
@@ -301,6 +319,7 @@ void nvme_ns_cleanup(NvmeNamespace *ns)
     if (ns->params.zoned) {
         g_free(ns->id_ns_zoned);
         g_free(ns->zone_array);
+        g_free(ns->zd_extensions);
     }
 }
 
@@ -332,6 +351,8 @@ static Property nvme_ns_props[] = {
                        params.max_active_zones, 0),
     DEFINE_PROP_UINT32("zoned.max_open", NvmeNamespace,
                        params.max_open_zones, 0),
+    DEFINE_PROP_UINT32("zoned.descr_ext_size", NvmeNamespace,
+                       params.zd_extension_size, 0),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index cbfd58b7c1..0db51995cc 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -1703,6 +1703,26 @@ static uint16_t nvme_offline_zone(NvmeNamespace *ns, NvmeZone *zone,
     return NVME_ZONE_INVAL_TRANSITION;
 }
 
+static uint16_t nvme_set_zd_ext(NvmeNamespace *ns, NvmeZone *zone)
+{
+    uint16_t status;
+    uint8_t state = nvme_get_zone_state(zone);
+
+    if (state == NVME_ZONE_STATE_EMPTY) {
+        nvme_auto_transition_zone(ns, false, true);
+        status = nvme_aor_check(ns, 1, 0);
+        if (status != NVME_SUCCESS) {
+            return status;
+        }
+        nvme_aor_inc_active(ns);
+        zone->d.za |= NVME_ZA_ZD_EXT_VALID;
+        nvme_assign_zone_state(ns, zone, NVME_ZONE_STATE_CLOSED);
+        return NVME_SUCCESS;
+    }
+
+    return NVME_ZONE_INVAL_TRANSITION;
+}
+
 static uint16_t nvme_bulk_proc_zone(NvmeNamespace *ns, NvmeZone *zone,
                                     enum NvmeZoneProcessingMask proc_mask,
                                     op_handler_t op_hndlr)
@@ -1798,6 +1818,7 @@ static uint16_t nvme_zone_mgmt_send(NvmeCtrl *n, NvmeRequest *req)
     NvmeCmd *cmd = (NvmeCmd *)&req->cmd;
     NvmeNamespace *ns = req->ns;
     NvmeZone *zone;
+    uint8_t *zd_ext;
     uint32_t dw13 = le32_to_cpu(cmd->cdw13);
     uint64_t slba = 0;
     uint32_t zone_idx = 0;
@@ -1870,7 +1891,22 @@ static uint16_t nvme_zone_mgmt_send(NvmeCtrl *n, NvmeRequest *req)
 
     case NVME_ZONE_ACTION_SET_ZD_EXT:
         trace_pci_nvme_set_descriptor_extension(slba, zone_idx);
-        return NVME_INVALID_FIELD | NVME_DNR;
+        if (all || !ns->params.zd_extension_size) {
+            return NVME_INVALID_FIELD | NVME_DNR;
+        }
+        zd_ext = nvme_get_zd_extension(ns, zone_idx);
+        status = nvme_dma(n, zd_ext, ns->params.zd_extension_size,
+                          DMA_DIRECTION_TO_DEVICE, req);
+        if (status) {
+            trace_pci_nvme_err_zd_extension_map_error(zone_idx);
+            return status;
+        }
+
+        status = nvme_set_zd_ext(ns, zone);
+        if (status == NVME_SUCCESS) {
+            trace_pci_nvme_zd_extension_set(zone_idx);
+            return status;
+        }
         break;
 
     default:
@@ -1940,7 +1976,10 @@ static uint16_t nvme_zone_mgmt_recv(NvmeCtrl *n, NvmeRequest *req)
     }
 
     zra = dw13 & 0xff;
-    if (zra != NVME_ZONE_REPORT) {
+    if (zra != NVME_ZONE_REPORT && zra != NVME_ZONE_REPORT_EXTENDED) {
+        return NVME_INVALID_FIELD | NVME_DNR;
+    }
+    if (zra == NVME_ZONE_REPORT_EXTENDED && !ns->params.zd_extension_size) {
         return NVME_INVALID_FIELD | NVME_DNR;
     }
 
@@ -1961,6 +2000,9 @@ static uint16_t nvme_zone_mgmt_recv(NvmeCtrl *n, NvmeRequest *req)
     partial = (dw13 >> 16) & 0x01;
 
     zone_entry_sz = sizeof(NvmeZoneDescr);
+    if (zra == NVME_ZONE_REPORT_EXTENDED) {
+        zone_entry_sz += ns->params.zd_extension_size;
+    }
 
     max_zones = (data_size - sizeof(NvmeZoneReportHeader)) / zone_entry_sz;
     buf = g_malloc0(data_size);
@@ -1992,6 +2034,14 @@ static uint16_t nvme_zone_mgmt_recv(NvmeCtrl *n, NvmeRequest *req)
             z->wp = cpu_to_le64(~0ULL);
         }
 
+        if (zra == NVME_ZONE_REPORT_EXTENDED) {
+            if (zs->d.za & NVME_ZA_ZD_EXT_VALID) {
+                memcpy(buf_p, nvme_get_zd_extension(ns, zone_idx),
+                       ns->params.zd_extension_size);
+            }
+            buf_p += ns->params.zd_extension_size;
+        }
+
         zone_idx++;
     }
 
diff --git a/hw/block/trace-events b/hw/block/trace-events
index e674522883..d42d2c8d61 100644
--- a/hw/block/trace-events
+++ b/hw/block/trace-events
@@ -95,6 +95,7 @@ pci_nvme_finish_zone(uint64_t slba, uint32_t zone_idx, int all) "finish zone, sl
 pci_nvme_reset_zone(uint64_t slba, uint32_t zone_idx, int all) "reset zone, slba=%"PRIu64", idx=%"PRIu32", all=%"PRIi32""
 pci_nvme_offline_zone(uint64_t slba, uint32_t zone_idx, int all) "offline zone, slba=%"PRIu64", idx=%"PRIu32", all=%"PRIi32""
 pci_nvme_set_descriptor_extension(uint64_t slba, uint32_t zone_idx) "set zone descriptor extension, slba=%"PRIu64", idx=%"PRIu32""
+pci_nvme_zd_extension_set(uint32_t zone_idx) "set descriptor extension for zone_idx=%"PRIu32""
 pci_nvme_clear_ns_close(uint32_t state, uint64_t slba) "zone state=%"PRIu32", slba=%"PRIu64" transitioned to Closed state"
 pci_nvme_clear_ns_reset(uint32_t state, uint64_t slba) "zone state=%"PRIu32", slba=%"PRIu64" transitioned to Empty state"
 
@@ -124,6 +125,7 @@ pci_nvme_err_zone_read_not_ok(uint64_t slba, uint32_t nlb, uint32_t status) "slb
 pci_nvme_err_append_too_large(uint64_t slba, uint32_t nlb, uint8_t zasl) "slba=%"PRIu64", nlb=%"PRIu32", zasl=%"PRIu8""
 pci_nvme_err_insuff_active_res(uint32_t max_active) "max_active=%"PRIu32" zone limit exceeded"
 pci_nvme_err_insuff_open_res(uint32_t max_open) "max_open=%"PRIu32" zone limit exceeded"
+pci_nvme_err_zd_extension_map_error(uint32_t zone_idx) "can't map descriptor extension for zone_idx=%"PRIu32""
 pci_nvme_err_invalid_iocsci(uint32_t idx) "unsupported command set combination index %"PRIu32""
 pci_nvme_err_invalid_del_sq(uint16_t qid) "invalid submission queue deletion, sid=%"PRIu16""
 pci_nvme_err_invalid_create_sq_cqid(uint16_t cqid) "failed creating submission queue, invalid cqid=%"PRIu16""
-- 
2.21.0


