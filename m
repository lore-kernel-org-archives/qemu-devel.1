Return-Path: <SRS0=E5X6=CV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3007C2D0E0
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2020 23:05:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D60120723
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2020 23:05:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="k2Kby+g3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D60120723
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35746 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHEaW-00085y-I4
	for qemu-devel@archiver.kernel.org; Sat, 12 Sep 2020 19:05:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49054)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=517336518=dmitry.fomichev@wdc.com>)
 id 1kHEQb-0004rs-8W; Sat, 12 Sep 2020 18:55:29 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:26909)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=517336518=dmitry.fomichev@wdc.com>)
 id 1kHEQY-0005ef-NG; Sat, 12 Sep 2020 18:55:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1599951326; x=1631487326;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=xcY2j/8W2gFLX21Q3zxBsUT9jmjD/iDcFP+Spk0iA6U=;
 b=k2Kby+g3p25qN+8fR6ZN38TxPZfwZdnRWpE0SZ2ZzkK0XqZhY18csGmP
 RLNb2xszWRXYmCAT8YTlz4eLGamvwp4Zabpawr9Nd2STS7SqmjsSb9y8n
 YYvNnnF91+vNKyDHLSuC55sIsRdIlEOCSaDuogYBy4JqprzdzyNWcJH1z
 VgLUVUkA2WOXIG8UW2ul8Ot1AEGNZzcx8oF9okvOqgVTa6UzH5LHQbH6b
 +ytwUZyxBUHdQ7Rm7lsi5VlzXflEo0giLBa2+19GV3jc1ljDTZh/kMiSX
 6SnqMGqwmlUQkhu+fNHJwIEctF2FduVsbC12fMLn03v6LbLkhgdfuFVGv w==;
IronPort-SDR: S+2X7/PwQ0cBaPxH5QCcuUGzZFaWkp8s+bmsXo9RYdYdVjJj6zT6wrp1kKCqpN6F1RinkrLIC6
 8YYQ2Xi8zkSj7l5XHB7ylmzMMtJbqWwIcZKbD82t7rh4aJn+ZvOIi6CKksKIbjxTHF6dzqXEdf
 //FkssDd1dKzTiVuncmJdrTFhKABSPEYmaQNgBePEHhgn+XtnCYDmNa7h9F+o/KOwlKgG35ocw
 aoehlfpJa7GFZ7f0wkdZusiPjBO/KR9b1S2WSCNf9l6Owncd4mv6sw5nenxnjBQrKj+05d3VCz
 Ocg=
X-IronPort-AV: E=Sophos;i="5.76,420,1592841600"; d="scan'208";a="256834864"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 13 Sep 2020 06:55:03 +0800
IronPort-SDR: 2Ds0IL+ga3rOwXOVXU5pzJFrJcZIQ7Yb5qk2QRQc/NKiKkf8s0AIkg/YMSqpGF7GRQUTEq2d/f
 owcfpXrMXhGw==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Sep 2020 15:41:24 -0700
IronPort-SDR: 5gx5KLrlDqFUQjFktGc/5whg4cYQzSkRHsvQ9pk4WH2SG0PlI+t3oGT1x8rMVuc9pVRWXCMDw1
 sMXkUO0y+9Sw==
WDCIronportException: Internal
Received: from unknown (HELO redsun50.ssa.fujisawa.hgst.com) ([10.149.66.24])
 by uls-op-cesaip02.wdc.com with ESMTP; 12 Sep 2020 15:55:02 -0700
From: Dmitry Fomichev <dmitry.fomichev@wdc.com>
To: Keith Busch <kbusch@kernel.org>, Klaus Jensen <k.jensen@samsung.com>,
 Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Maxim Levitsky <mlevitsky@redhat.com>, Fam Zheng <fam@euphon.net>
Subject: [PATCH v2 12/15] hw/block/nvme: Support Zone Descriptor Extensions
Date: Sun, 13 Sep 2020 07:54:27 +0900
Message-Id: <20200912225430.1772-13-dmitry.fomichev@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200912225430.1772-1-dmitry.fomichev@wdc.com>
References: <20200912225430.1772-1-dmitry.fomichev@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=68.232.141.245;
 envelope-from=prvs=517336518=dmitry.fomichev@wdc.com; helo=esa1.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/12 18:54:38
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

This commit adds a new optional module property, "zone_descr_ext_size".
Its value must be a multiple of 64 bytes. If this value is non-zero,
it becomes possible to assign extensions of that size to any Empty
zones. The default value for this property is 0, therefore setting
extensions is disabled by default.

Signed-off-by: Hans Holmberg <hans.holmberg@wdc.com>
Signed-off-by: Dmitry Fomichev <dmitry.fomichev@wdc.com>
Reviewed-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/block/nvme.c | 73 ++++++++++++++++++++++++++++++++++++++++++++++---
 hw/block/nvme.h |  8 ++++++
 2 files changed, 77 insertions(+), 4 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index df536fd736..ec7fade674 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -1355,6 +1355,26 @@ static bool nvme_cond_offline_all(uint8_t state)
     return state == NVME_ZONE_STATE_READ_ONLY;
 }
 
+static uint16_t nvme_set_zd_ext(NvmeCtrl *n, NvmeNamespace *ns,
+    NvmeZone *zone, uint8_t state)
+{
+    uint16_t status;
+
+    if (state == NVME_ZONE_STATE_EMPTY) {
+        nvme_auto_transition_zone(n, ns, false, true);
+        status = nvme_aor_check(n, ns, 1, 0);
+        if (status != NVME_SUCCESS) {
+            return status;
+        }
+        nvme_aor_inc_active(n, ns);
+        zone->d.za |= NVME_ZA_ZD_EXT_VALID;
+        nvme_assign_zone_state(n, ns, zone, NVME_ZONE_STATE_CLOSED);
+        return NVME_SUCCESS;
+    }
+
+    return NVME_ZONE_INVAL_TRANSITION;
+}
+
 typedef uint16_t (*op_handler_t)(NvmeCtrl *, NvmeNamespace *, NvmeZone *,
                                  uint8_t);
 typedef bool (*need_to_proc_zone_t)(uint8_t);
@@ -1389,12 +1409,14 @@ static uint16_t nvme_zone_mgmt_send(NvmeCtrl *n, NvmeRequest *req)
     NvmeCmd *cmd = (NvmeCmd *)&req->cmd;
     NvmeNamespace *ns = req->ns;
     uint32_t dw13 = le32_to_cpu(cmd->cdw13);
+    uint64_t prp1, prp2;
     uint64_t slba = 0;
     uint32_t zone_idx = 0;
     uint16_t status;
     uint8_t action, state;
     bool all;
     NvmeZone *zone;
+    uint8_t *zd_ext;
 
     action = dw13 & 0xff;
     all = dw13 & 0x100;
@@ -1449,7 +1471,24 @@ static uint16_t nvme_zone_mgmt_send(NvmeCtrl *n, NvmeRequest *req)
 
     case NVME_ZONE_ACTION_SET_ZD_EXT:
         trace_pci_nvme_set_descriptor_extension(slba, zone_idx);
-        return NVME_INVALID_FIELD | NVME_DNR;
+        if (all || !n->params.zd_extension_size) {
+            return NVME_INVALID_FIELD | NVME_DNR;
+        }
+        zd_ext = nvme_get_zd_extension(n, ns, zone_idx);
+        prp1 = le64_to_cpu(cmd->dptr.prp1);
+        prp2 = le64_to_cpu(cmd->dptr.prp2);
+        status = nvme_dma_prp(n, zd_ext, n->params.zd_extension_size,
+                              prp1, prp2, DMA_DIRECTION_TO_DEVICE, req);
+        if (status) {
+            trace_pci_nvme_err_zd_extension_map_error(zone_idx);
+            return status;
+        }
+
+        status = nvme_set_zd_ext(n, ns, zone, state);
+        if (status == NVME_SUCCESS) {
+            trace_pci_nvme_zd_extension_set(zone_idx);
+            return status;
+        }
         break;
 
     default:
@@ -1529,7 +1568,7 @@ static uint16_t nvme_zone_mgmt_recv(NvmeCtrl *n, NvmeRequest *req)
         return NVME_INVALID_FIELD | NVME_DNR;
     }
 
-    if (zra == NVME_ZONE_REPORT_EXTENDED) {
+    if (zra == NVME_ZONE_REPORT_EXTENDED && !n->params.zd_extension_size) {
         return NVME_INVALID_FIELD | NVME_DNR;
     }
 
@@ -1541,6 +1580,9 @@ static uint16_t nvme_zone_mgmt_recv(NvmeCtrl *n, NvmeRequest *req)
     partial = (dw13 >> 16) & 0x01;
 
     zone_entry_sz = sizeof(NvmeZoneDescr);
+    if (zra == NVME_ZONE_REPORT_EXTENDED) {
+        zone_entry_sz += n->params.zd_extension_size;
+    }
 
     max_zones = (len - sizeof(NvmeZoneReportHeader)) / zone_entry_sz;
     buf = g_malloc0(len);
@@ -1572,6 +1614,14 @@ static uint16_t nvme_zone_mgmt_recv(NvmeCtrl *n, NvmeRequest *req)
             z->wp = cpu_to_le64(~0ULL);
         }
 
+        if (zra == NVME_ZONE_REPORT_EXTENDED) {
+            if (zs->d.za & NVME_ZA_ZD_EXT_VALID) {
+                memcpy(buf_p, nvme_get_zd_extension(n, ns, zone_idx),
+                       n->params.zd_extension_size);
+            }
+            buf_p += n->params.zd_extension_size;
+        }
+
         zone_idx++;
     }
 
@@ -2686,7 +2736,6 @@ static uint16_t nvme_aer(NvmeCtrl *n, NvmeRequest *req)
 
     n->aer_reqs[n->outstanding_aers] = req;
     n->outstanding_aers++;
-
     if (!QTAILQ_EMPTY(&n->aer_queue)) {
         nvme_process_aers(n);
     }
@@ -3320,6 +3369,7 @@ static int nvme_init_zone_meta(NvmeCtrl *n, NvmeNamespace *ns,
     ns->imp_open_zones = g_malloc0(sizeof(NvmeZoneList));
     ns->closed_zones = g_malloc0(sizeof(NvmeZoneList));
     ns->full_zones = g_malloc0(sizeof(NvmeZoneList));
+    ns->zd_extensions = g_malloc0(n->params.zd_extension_size * n->num_zones);
     zone = ns->zone_array;
 
     nvme_init_zone_list(ns->exp_open_zones);
@@ -3390,6 +3440,17 @@ static void nvme_zoned_init_ctrl(NvmeCtrl *n, Error **errp)
                     " adjusting", n->params.max_active_zones, nz);
         n->params.max_active_zones = nz;
     }
+    if (n->params.zd_extension_size) {
+        if (n->params.zd_extension_size & 0x3f) {
+            error_setg(errp,
+                "zone descriptor extension size must be a multiple of 64B");
+            return;
+        }
+        if ((n->params.zd_extension_size >> 6) > 0xff) {
+            error_setg(errp, "zone descriptor extension size is too large");
+            return;
+        }
+    }
 
     return;
 }
@@ -3414,7 +3475,8 @@ static int nvme_zoned_init_ns(NvmeCtrl *n, NvmeNamespace *ns, int lba_index,
     ns->id_ns_zoned->ozcs = n->params.cross_zone_read ? 0x01 : 0x00;
 
     ns->id_ns_zoned->lbafe[lba_index].zsze = cpu_to_le64(n->zone_size);
-    ns->id_ns_zoned->lbafe[lba_index].zdes = 0;
+    ns->id_ns_zoned->lbafe[lba_index].zdes =
+        n->params.zd_extension_size >> 6; /* Units of 64B */
 
     if (n->params.fill_pattern == 0) {
         ns->id_ns.dlfeat = 0x01;
@@ -3437,6 +3499,7 @@ static void nvme_zoned_clear(NvmeCtrl *n)
         g_free(ns->imp_open_zones);
         g_free(ns->closed_zones);
         g_free(ns->full_zones);
+        g_free(ns->zd_extensions);
     }
 }
 
@@ -3805,6 +3868,8 @@ static Property nvme_props[] = {
                        NVME_DEFAULT_ZONE_SIZE),
     DEFINE_PROP_UINT64("zone_capacity", NvmeCtrl, params.zone_capacity_mb, 0),
     DEFINE_PROP_UINT32("zone_append_size_limit", NvmeCtrl, params.zasl_kb, 0),
+    DEFINE_PROP_UINT32("zone_descr_ext_size", NvmeCtrl,
+                       params.zd_extension_size, 0),
     DEFINE_PROP_UINT32("max_active", NvmeCtrl, params.max_active_zones, 0),
     DEFINE_PROP_UINT32("max_open", NvmeCtrl, params.max_open_zones, 0),
     DEFINE_PROP_BOOL("cross_zone_read", NvmeCtrl, params.cross_zone_read, true),
diff --git a/hw/block/nvme.h b/hw/block/nvme.h
index 4a3b23ed72..e53388ba66 100644
--- a/hw/block/nvme.h
+++ b/hw/block/nvme.h
@@ -24,6 +24,7 @@ typedef struct NvmeParams {
     uint64_t    zone_capacity_mb;
     uint32_t    max_active_zones;
     uint32_t    max_open_zones;
+    uint32_t    zd_extension_size;
 } NvmeParams;
 
 typedef struct NvmeAsyncEvent {
@@ -105,6 +106,7 @@ typedef struct NvmeNamespace {
     NvmeZoneList    *imp_open_zones;
     NvmeZoneList    *closed_zones;
     NvmeZoneList    *full_zones;
+    uint8_t         *zd_extensions;
     int32_t         nr_open_zones;
     int32_t         nr_active_zones;
 } NvmeNamespace;
@@ -218,6 +220,12 @@ static inline bool nvme_wp_is_valid(NvmeZone *zone)
            st != NVME_ZONE_STATE_OFFLINE;
 }
 
+static inline uint8_t *nvme_get_zd_extension(NvmeCtrl *n, NvmeNamespace *ns,
+                                             uint32_t zone_idx)
+{
+    return &ns->zd_extensions[zone_idx * n->params.zd_extension_size];
+}
+
 /*
  * Initialize a zone list head.
  */
-- 
2.21.0


