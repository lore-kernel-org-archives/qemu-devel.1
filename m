Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02EE3C4727E
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 20:50:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F455221EB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 20:50:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F455221EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49478 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLYBn-00075I-T2
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 16:50:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38720)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kLY7s-0004oL-4F; Thu, 24 Sep 2020 16:46:04 -0400
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:50613)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kLY7n-0007nW-Pu; Thu, 24 Sep 2020 16:45:59 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
 by mailnew.nyi.internal (Postfix) with ESMTP id 011B258050F;
 Thu, 24 Sep 2020 16:45:35 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute7.internal (MEProxy); Thu, 24 Sep 2020 16:45:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm1; bh=BgPkIH18OMgQX
 udcnjf7YrQrNRZbzRyLvu+71yK4H2s=; b=QpHeY6Iyi4iictfEGG0Qq7Ep61viE
 419/eYCz+tQTUSL+L2a3+YDZFjpWPTZg5oDkG6yyp5BQ3ZsJul3HdwyKzK6USyJ+
 SXGGZg+FSvo9XgKdK+Ybh9AgYpHfKUSfDabTF9k9WVS4XOrceZ6II7qVNzbRJcvd
 Sx9VwFCFfTHLIBz+KYVzfCr8mQCtV731qQykO+hPVUFcV7x6hMVBykve8NByZ0Uc
 AP0JUovi8dZgbsu9Fr40plpnNQO2ruyQJZWBM0PKNgIQ9w1CIwtfXNGZtdH7YyQ4
 McaxPbW+ocy1GIJFUI+VZK7uVgiNiGRMq9QrYtQ+p/ATo/BRv8gCo2jzw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm3; bh=BgPkIH18OMgQXudcnjf7YrQrNRZbzRyLvu+71yK4H2s=; b=WrQI+d36
 qXKMGVS420/IGHdzOHEFaGvWUY1YewM3EZ9uqdVmHnh4cpAOknp/3mU/R7m5bK2V
 fhuscjz7BO6b+m1MpcJ+luEGfmZXy/dNaFNySybxHiBRrcJa84PKLbat00EPAc5d
 Me1O8KZ6GFpUXzUevqYEZwrDNXbMVLK3lKim/EpGYebu2hr2cQae7/RR2B6iQib2
 v8hpyRhJJigilL0wWlWx/N4Gk9Ch/h2CWizSmxCAVHiwbW2BnzeNv/pzOVa9XWWI
 JtdbnIt/JYC8MNO4VRdt8BqFZ4HwHpsFyG8htTHcBsRMELOWA9XRro5Xgry/LnMt
 Twt2m3wrDe75yA==
X-ME-Sender: <xms:bQVtXzmNlkLb_wHt35ad86dFyTiSE-RjG2RrBxWY7oGic3QAhEiCrA>
 <xme:bQVtX21zfYN5yKOYfXOh6YZQVD0FfefOwLN03NYt0hoc3XZFrV3CKOan4Bt8jfcqF
 SQPNnw4UCD7oh2YgHs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudekgdduheduucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefmlhgruhhs
 ucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrghtth
 gvrhhnpeekudehfeethfdvvdegieffheekueeghefhudfghffhhfevjeejffeuhedugedu
 udenucffohhmrghinhepuhhtihhlihiirghtihhonhdrmhgrphenucfkphepkedtrdduie
 ejrdelkedrudeltdenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhl
 fhhrohhmpehithhssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:bQVtX5pr-pe2DWKV5SX2odAUfiBraCyVkxS7vwQbw21NmOvJ4-Z8Fw>
 <xmx:bQVtX7mYJ7VO7ZwCs2B8wEzwyrYK3_nevDmv24rO8jnGSnPoGIS6-A>
 <xmx:bQVtXx0B4imFb2ily_62JsDmNZUkCWSbRWyyA9DBrIDWHq7mDGlGFg>
 <xmx:bQVtX5_8ubKWV0iYYePhQk1C-UvS6C8MeoTOD2Vbuxe_L-STcCzUPg>
Received: from apples.local (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id 8E5803064683;
 Thu, 24 Sep 2020 16:45:32 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Subject: [PATCH 11/16] hw/block/nvme: add the zone management send command
Date: Thu, 24 Sep 2020 22:45:11 +0200
Message-Id: <20200924204516.1881843-12-its@irrelevant.dk>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200924204516.1881843-1-its@irrelevant.dk>
References: <20200924204516.1881843-1-its@irrelevant.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=66.111.4.224; envelope-from=its@irrelevant.dk;
 helo=new2-smtp.messagingengine.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/24 14:55:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Klaus Jensen <k.jensen@samsung.com>,
 Max Reitz <mreitz@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Klaus Jensen <k.jensen@samsung.com>

Add the Zone Management Send command.

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/block/nvme.h       |   1 +
 include/block/nvme.h  |  29 +++
 hw/block/nvme.c       | 552 ++++++++++++++++++++++++++++++++++++++++--
 hw/block/trace-events |  11 +
 4 files changed, 574 insertions(+), 19 deletions(-)

diff --git a/hw/block/nvme.h b/hw/block/nvme.h
index 523eef0bcad8..c704663e0a3e 100644
--- a/hw/block/nvme.h
+++ b/hw/block/nvme.h
@@ -71,6 +71,7 @@ static inline const char *nvme_io_opc_str(uint8_t opc)
     case NVME_CMD_WRITE:            return "NVME_NVM_CMD_WRITE";
     case NVME_CMD_READ:             return "NVME_NVM_CMD_READ";
     case NVME_CMD_WRITE_ZEROES:     return "NVME_NVM_CMD_WRITE_ZEROES";
+    case NVME_CMD_ZONE_MGMT_SEND:   return "NVME_ZONED_CMD_ZONE_MGMT_SEND";
     case NVME_CMD_ZONE_MGMT_RECV:   return "NVME_ZONED_CMD_ZONE_MGMT_RECV";
     default:                        return "NVME_NVM_CMD_UNKNOWN";
     }
diff --git a/include/block/nvme.h b/include/block/nvme.h
index 9bacf48ee9e9..967b42eb5da7 100644
--- a/include/block/nvme.h
+++ b/include/block/nvme.h
@@ -481,6 +481,7 @@ enum NvmeIoCommands {
     NVME_CMD_COMPARE            = 0x05,
     NVME_CMD_WRITE_ZEROES       = 0x08,
     NVME_CMD_DSM                = 0x09,
+    NVME_CMD_ZONE_MGMT_SEND     = 0x79,
     NVME_CMD_ZONE_MGMT_RECV     = 0x7a,
 };
 
@@ -594,6 +595,32 @@ enum {
     NVME_RW_PRINFO_PRCHK_REF    = 1 << 10,
 };
 
+typedef struct QEMU_PACKED NvmeZoneManagementSendCmd {
+    uint8_t     opcode;
+    uint8_t     flags;
+    uint16_t    cid;
+    uint32_t    nsid;
+    uint32_t    rsvd8[4];
+    NvmeCmdDptr dptr;
+    uint64_t    slba;
+    uint32_t    rsvd48;
+    uint8_t     zsa;
+    uint8_t     zsflags;
+    uint16_t    rsvd54;
+    uint32_t    rsvd56[2];
+} NvmeZoneManagementSendCmd;
+
+#define NVME_CMD_ZONE_MGMT_SEND_SELECT_ALL(zsflags) ((zsflags) & 0x1)
+
+typedef enum NvmeZoneManagementSendAction {
+    NVME_CMD_ZONE_MGMT_SEND_CLOSE   = 0x1,
+    NVME_CMD_ZONE_MGMT_SEND_FINISH  = 0x2,
+    NVME_CMD_ZONE_MGMT_SEND_OPEN    = 0x3,
+    NVME_CMD_ZONE_MGMT_SEND_RESET   = 0x4,
+    NVME_CMD_ZONE_MGMT_SEND_OFFLINE = 0x5,
+    NVME_CMD_ZONE_MGMT_SEND_SET_ZDE = 0x10,
+} NvmeZoneManagementSendAction;
+
 typedef struct QEMU_PACKED NvmeZoneManagementRecvCmd {
     uint8_t     opcode;
     uint8_t     flags;
@@ -748,6 +775,7 @@ enum NvmeStatusCodes {
     NVME_ZONE_IS_READ_ONLY      = 0x01ba,
     NVME_ZONE_IS_OFFLINE        = 0x01bb,
     NVME_ZONE_INVALID_WRITE     = 0x01bc,
+    NVME_INVALID_ZONE_STATE_TRANSITION = 0x01bf,
     NVME_WRITE_FAULT            = 0x0280,
     NVME_UNRECOVERED_READ       = 0x0281,
     NVME_E2E_GUARD_ERROR        = 0x0282,
@@ -1207,6 +1235,7 @@ static inline void _nvme_check_size(void)
     QEMU_BUILD_BUG_ON(sizeof(NvmeIdentify) != 64);
     QEMU_BUILD_BUG_ON(sizeof(NvmeRwCmd) != 64);
     QEMU_BUILD_BUG_ON(sizeof(NvmeDsmCmd) != 64);
+    QEMU_BUILD_BUG_ON(sizeof(NvmeZoneManagementSendCmd) != 64);
     QEMU_BUILD_BUG_ON(sizeof(NvmeZoneManagementRecvCmd) != 64);
     QEMU_BUILD_BUG_ON(sizeof(NvmeRangeType) != 64);
     QEMU_BUILD_BUG_ON(sizeof(NvmeErrorLog) != 64);
diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 43ae89a0a6cb..51611ed32600 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -164,6 +164,8 @@ static const NvmeEffectsLog nvme_effects[NVME_IOCS_MAX] = {
         .iocs = {
             NVME_EFFECTS_NVM_INITIALIZER,
             [NVME_CMD_ZONE_MGMT_RECV] = NVME_EFFECTS_CSUPP,
+            [NVME_CMD_ZONE_MGMT_SEND] = NVME_EFFECTS_CSUPP |
+                                        NVME_EFFECTS_LBCC,
         },
     },
 };
@@ -1064,21 +1066,20 @@ static inline uint16_t nvme_check_dulbe(NvmeNamespace *ns, uint64_t slba,
     return NVME_SUCCESS;
 }
 
-static int nvme_allocate(NvmeNamespace *ns, uint64_t slba, uint32_t nlb)
+static int __nvme_allocate(NvmeNamespace *ns, uint64_t slba, uint32_t nlb,
+                           bool deallocate)
 {
     int nlongs, first;
     int64_t offset;
     unsigned long *map, *src;
     int ret;
 
-    if (!(ns->pstate.blk && nvme_check_dulbe(ns, slba, nlb))) {
-        return 0;
+    if (deallocate) {
+        bitmap_clear(ns->pstate.utilization.map, slba, nlb);
+    } else {
+        bitmap_set(ns->pstate.utilization.map, slba, nlb);
     }
 
-    trace_pci_nvme_allocate(nvme_nsid(ns), slba, nlb);
-
-    bitmap_set(ns->pstate.utilization.map, slba, nlb);
-
     nlongs = BITS_TO_LONGS(nlb) + 1;
     first = slba / BITS_PER_LONG;
     offset = ns->pstate.utilization.offset + first * sizeof(unsigned long);
@@ -1106,6 +1107,28 @@ static int nvme_allocate(NvmeNamespace *ns, uint64_t slba, uint32_t nlb)
     return ret;
 }
 
+static int nvme_allocate(NvmeNamespace *ns, uint64_t slba, uint32_t nlb)
+{
+    if (!(ns->pstate.blk && nvme_check_dulbe(ns, slba, nlb))) {
+        return 0;
+    }
+
+    trace_pci_nvme_allocate(nvme_nsid(ns), slba, nlb);
+
+    return __nvme_allocate(ns, slba, nlb, false /* deallocate */);
+}
+
+static int nvme_deallocate(NvmeNamespace *ns, uint64_t slba, uint32_t nlb)
+{
+    if (!ns->pstate.blk) {
+        return 0;
+    }
+
+    trace_pci_nvme_deallocate(nvme_nsid(ns), slba, nlb);
+
+    return __nvme_allocate(ns, slba, nlb, true /* deallocate */);
+}
+
 static int nvme_zns_commit_zone(NvmeNamespace *ns, NvmeZone *zone)
 {
     uint64_t zslba;
@@ -1125,6 +1148,139 @@ static int nvme_zns_commit_zone(NvmeNamespace *ns, NvmeZone *zone)
                       sizeof(NvmeZoneDescriptor), 0);
 }
 
+static int nvme_zns_commit_zde(NvmeNamespace *ns, NvmeZone *zone)
+{
+    uint64_t zslba;
+    int zidx;
+    size_t zdes_bytes;
+    int64_t offset;
+
+    if (!ns->pstate.blk) {
+        return 0;
+    }
+
+    zslba = nvme_zslba(zone);
+    zidx = nvme_ns_zone_idx(ns, zslba);
+    zdes_bytes = nvme_ns_zdes_bytes(ns);
+    offset = ns->pstate.zns.offset +
+        ns->zns.num_zones * sizeof(NvmeZoneDescriptor) +
+        zidx * zdes_bytes;
+
+    return blk_pwrite(ns->pstate.blk, offset, zone->zde, zdes_bytes, 0);
+}
+
+static inline void nvme_zone_reset_wp(NvmeZone *zone)
+{
+    zone->zd->wp = zone->zd->zslba;
+    zone->wp_staging = nvme_zslba(zone);
+}
+
+static uint16_t nvme_zrm_transition(NvmeNamespace *ns, NvmeZone *zone,
+                                    NvmeZoneState to)
+{
+    NvmeZoneState from = nvme_zs(zone);
+
+    /* fast path */
+    if (from == to) {
+        return NVME_SUCCESS;
+    }
+
+    switch (from) {
+    case NVME_ZS_ZSE:
+        break;
+
+    case NVME_ZS_ZSIO:
+    case NVME_ZS_ZSEO:
+        switch (to) {
+        case NVME_ZS_ZSEO:
+            break;
+
+        case NVME_ZS_ZSE:
+            nvme_zone_reset_wp(zone);
+
+            /* fallthrough */
+
+        case NVME_ZS_ZSO:
+            NVME_ZA_CLEAR_ALL(zone->zd->za);
+
+            /* fallthrough */
+
+        case NVME_ZS_ZSF:
+        case NVME_ZS_ZSRO:
+        case NVME_ZS_ZSC:
+            break;
+
+        default:
+            return NVME_INVALID_ZONE_STATE_TRANSITION | NVME_DNR;
+        }
+
+        break;
+
+    case NVME_ZS_ZSC:
+        switch (to) {
+        case NVME_ZS_ZSE:
+            nvme_zone_reset_wp(zone);
+
+            /* fallthrough */
+
+        case NVME_ZS_ZSO:
+            NVME_ZA_CLEAR_ALL(zone->zd->za);
+
+            /* fallthrough */
+
+        case NVME_ZS_ZSF:
+        case NVME_ZS_ZSRO:
+        case NVME_ZS_ZSIO:
+        case NVME_ZS_ZSEO:
+            break;
+
+        default:
+            return NVME_INVALID_ZONE_STATE_TRANSITION | NVME_DNR;
+        }
+
+        break;
+
+    case NVME_ZS_ZSRO:
+        switch (to) {
+        case NVME_ZS_ZSO:
+            NVME_ZA_CLEAR_ALL(zone->zd->za);
+            break;
+
+        default:
+            return NVME_INVALID_ZONE_STATE_TRANSITION | NVME_DNR;
+        }
+
+        break;
+
+    case NVME_ZS_ZSF:
+        switch (to) {
+        case NVME_ZS_ZSE:
+            nvme_zone_reset_wp(zone);
+
+            /* fallthrough */
+
+        case NVME_ZS_ZSO:
+            NVME_ZA_CLEAR_ALL(zone->zd->za);
+
+            /* fallthrough */
+
+        case NVME_ZS_ZSRO:
+            break;
+
+        default:
+            return NVME_INVALID_ZONE_STATE_TRANSITION | NVME_DNR;
+        }
+
+        break;
+
+    default:
+        return NVME_INVALID_ZONE_STATE_TRANSITION | NVME_DNR;
+    }
+
+    nvme_zs_set(zone, to);
+    return NVME_SUCCESS;
+}
+
 static void nvme_zns_advance_wp(NvmeRequest *req)
 {
     NvmeRwCmd *rw = (NvmeRwCmd *)&req->cmd;
@@ -1136,7 +1292,7 @@ static void nvme_zns_advance_wp(NvmeRequest *req)
     wp += nlb;
     zone->zd->wp = cpu_to_le64(wp);
     if (wp == nvme_zslba(zone) + nvme_zcap(zone)) {
-        nvme_zs_set(zone, NVME_ZS_ZSF);
+        nvme_zrm_transition(req->ns, zone, NVME_ZS_ZSF);
         if (nvme_zns_commit_zone(req->ns, zone) < 0) {
             req->status = NVME_INTERNAL_DEV_ERROR;
         }
@@ -1201,11 +1357,7 @@ static void nvme_rw_cb(void *opaque, int ret)
             NvmeZoneState zs = status == NVME_WRITE_FAULT ?
                 NVME_ZS_ZSRO : NVME_ZS_ZSO;
 
-            nvme_zs_set(zone, zs);
-            if (zs == NVME_ZS_ZSO) {
-                NVME_ZA_CLEAR_ALL(zone->zd->za);
-            }
-
+            nvme_zrm_transition(ns, zone, zs);
             if (nvme_zns_commit_zone(ns, zone) < 0) {
                 req->status = NVME_INTERNAL_DEV_ERROR;
             }
@@ -1273,6 +1425,364 @@ static uint16_t nvme_do_aio(BlockBackend *blk, int64_t offset, size_t len,
     return NVME_NO_COMPLETE;
 }
 
+static uint16_t nvme_zone_mgmt_send_close(NvmeCtrl *n, NvmeRequest *req,
+                                          NvmeZone *zone)
+{
+    NvmeNamespace *ns = req->ns;
+    uint16_t status;
+
+    trace_pci_nvme_zone_mgmt_send_close(nvme_cid(req), nvme_nsid(ns),
+                                        nvme_zslba(zone), nvme_zs_str(zone));
+
+    switch (nvme_zs(zone)) {
+    case NVME_ZS_ZSC:
+        return NVME_SUCCESS;
+
+    case NVME_ZS_ZSE:
+        /*
+         * The state machine in nvme_zrm_transition allows zones to transition
+         * from ZSE to ZSC. That transition is only valid if done as part Set
+         * Zone Descriptor, so do an early check here.
+         */
+        return NVME_INVALID_ZONE_STATE_TRANSITION | NVME_DNR;
+
+    default:
+        break;
+    }
+
+    status = nvme_zrm_transition(ns, zone, NVME_ZS_ZSC);
+    if (status) {
+        return status;
+    }
+
+    if (nvme_zns_commit_zone(ns, zone) < 0) {
+        return NVME_INTERNAL_DEV_ERROR;
+    }
+
+    return NVME_SUCCESS;
+}
+
+static uint16_t nvme_zone_mgmt_send_finish(NvmeCtrl *n, NvmeRequest *req,
+                                           NvmeZone *zone)
+{
+    NvmeNamespace *ns = req->ns;
+    uint16_t status;
+
+    trace_pci_nvme_zone_mgmt_send_finish(nvme_cid(req), nvme_nsid(ns),
+                                         nvme_zslba(zone), nvme_zs_str(zone));
+
+    if (nvme_zs(zone) == NVME_ZS_ZSF) {
+        return NVME_SUCCESS;
+    }
+
+    status = nvme_zrm_transition(ns, zone, NVME_ZS_ZSF);
+    if (status) {
+        return status;
+    }
+
+    if (nvme_zns_commit_zone(ns, zone) < 0) {
+        return NVME_INTERNAL_DEV_ERROR;
+    }
+
+    return NVME_SUCCESS;
+}
+
+static uint16_t nvme_zone_mgmt_send_open(NvmeCtrl *n, NvmeRequest *req,
+                                         NvmeZone *zone)
+{
+    NvmeNamespace *ns = req->ns;
+    uint16_t status;
+
+    trace_pci_nvme_zone_mgmt_send_open(nvme_cid(req), nvme_nsid(ns),
+                                       nvme_zslba(zone), nvme_zs_str(zone));
+
+    if (nvme_zs(zone) == NVME_ZS_ZSEO) {
+        return NVME_SUCCESS;
+    }
+
+    status = nvme_zrm_transition(ns, zone, NVME_ZS_ZSEO);
+    if (status) {
+        return status;
+    }
+
+    if (nvme_zns_commit_zone(ns, zone) < 0) {
+        return NVME_INTERNAL_DEV_ERROR;
+    }
+
+    return NVME_SUCCESS;
+}
+
+static uint16_t nvme_zone_mgmt_send_reset(NvmeCtrl *n, NvmeRequest *req,
+                                          NvmeZone *zone)
+{
+    NvmeNamespace *ns = req->ns;
+    uint64_t zslba = nvme_zslba(zone);
+    uint64_t zcap = nvme_zcap(zone);
+
+    trace_pci_nvme_zone_mgmt_send_reset(nvme_cid(req), nvme_nsid(ns),
+                                        nvme_zslba(zone), nvme_zs_str(zone));
+
+    switch (nvme_zs(zone)) {
+    case NVME_ZS_ZSIO:
+    case NVME_ZS_ZSEO:
+    case NVME_ZS_ZSC:
+    case NVME_ZS_ZSF:
+        if (blk_pdiscard(ns->blkconf.blk, nvme_l2b(ns, zslba),
+                         nvme_l2b(ns, zcap)) < 0) {
+            return NVME_INTERNAL_DEV_ERROR;
+        }
+
+        if (nvme_deallocate(ns, zslba, zcap) < 0) {
+            return NVME_INTERNAL_DEV_ERROR;
+        }
+
+        nvme_zrm_transition(ns, zone, NVME_ZS_ZSE);
+        if (nvme_zns_commit_zone(ns, zone) < 0) {
+            return NVME_INTERNAL_DEV_ERROR;
+        }
+
+        /* fallthrough */
+
+    case NVME_ZS_ZSE:
+        return NVME_SUCCESS;
+
+    default:
+        break;
+    }
+
+    return NVME_INVALID_ZONE_STATE_TRANSITION | NVME_DNR;
+}
+
+static uint16_t nvme_zone_mgmt_send_offline(NvmeCtrl *n, NvmeRequest *req,
+                                            NvmeZone *zone)
+{
+    NvmeNamespace *ns = req->ns;
+
+    trace_pci_nvme_zone_mgmt_send_offline(nvme_cid(req), nvme_nsid(ns),
+                                          nvme_zslba(zone), nvme_zs_str(zone));
+
+    switch (nvme_zs(zone)) {
+    case NVME_ZS_ZSRO:
+        if (nvme_deallocate(ns, nvme_zslba(zone), nvme_zcap(zone)) < 0) {
+            return NVME_INTERNAL_DEV_ERROR;
+        }
+
+        nvme_zrm_transition(ns, zone, NVME_ZS_ZSO);
+        if (nvme_zns_commit_zone(ns, zone) < 0) {
+            return NVME_INTERNAL_DEV_ERROR;
+        }
+
+        /* fallthrough */
+
+    case NVME_ZS_ZSO:
+        return NVME_SUCCESS;
+
+    default:
+        break;
+    }
+
+    return NVME_INVALID_ZONE_STATE_TRANSITION | NVME_DNR;
+}
+
+static uint16_t nvme_zone_mgmt_send_set_zde(NvmeCtrl *n, NvmeRequest *req,
+                                            NvmeZone *zone)
+{
+    NvmeNamespace *ns = req->ns;
+    uint16_t status;
+
+    trace_pci_nvme_zone_mgmt_send_set_zde(nvme_cid(req), nvme_nsid(ns),
+                                          nvme_zslba(zone), nvme_zs_str(zone));
+
+    if (nvme_zs(zone) != NVME_ZS_ZSE) {
+        trace_pci_nvme_err_invalid_zone_condition(nvme_cid(req),
+                                                  nvme_zslba(zone),
+                                                  nvme_zs(zone));
+        return NVME_INVALID_ZONE_STATE_TRANSITION | NVME_DNR;
+    }
+
+    status = nvme_check_mdts(n, nvme_ns_zdes_bytes(ns));
+    if (status) {
+        return status;
+    }
+
+    status = nvme_dma(n, zone->zde, nvme_ns_zdes_bytes(ns),
+                      DMA_DIRECTION_TO_DEVICE, req);
+    if (status) {
+        return status;
+    }
+
+    status = nvme_zrm_transition(ns, zone, NVME_ZS_ZSC);
+    if (status) {
+        return status;
+    }
+
+    if (nvme_zns_commit_zde(ns, zone) < 0) {
+        return NVME_INTERNAL_DEV_ERROR;
+    }
+
+    NVME_ZA_SET(zone->zd->za, NVME_ZA_ZDEV);
+
+    if (nvme_zns_commit_zone(ns, zone) < 0) {
+        return NVME_INTERNAL_DEV_ERROR;
+    }
+
+    return NVME_SUCCESS;
+}
+
+static uint16_t nvme_zone_mgmt_send_all(NvmeCtrl *n, NvmeRequest *req)
+{
+    NvmeZoneManagementSendCmd *send = (NvmeZoneManagementSendCmd *) &req->cmd;
+    NvmeNamespace *ns = req->ns;
+    NvmeZone *zone;
+
+    uint16_t status = NVME_SUCCESS;
+
+    trace_pci_nvme_zone_mgmt_send_all(nvme_cid(req), nvme_nsid(ns), send->zsa);
+
+    switch (send->zsa) {
+    case NVME_CMD_ZONE_MGMT_SEND_SET_ZDE:
+        return NVME_INVALID_FIELD | NVME_DNR;
+
+    case NVME_CMD_ZONE_MGMT_SEND_CLOSE:
+        for (int i = 0; i < ns->zns.num_zones; i++) {
+            zone = &ns->zns.zones[i];
+
+            switch (nvme_zs(zone)) {
+            case NVME_ZS_ZSIO:
+            case NVME_ZS_ZSEO:
+                status = nvme_zone_mgmt_send_close(n, req, zone);
+                if (status) {
+                    return status;
+                }
+
+            default:
+                continue;
+            }
+        }
+
+        break;
+
+    case NVME_CMD_ZONE_MGMT_SEND_FINISH:
+        for (int i = 0; i < ns->zns.num_zones; i++) {
+            zone = &ns->zns.zones[i];
+
+            switch (nvme_zs(zone)) {
+            case NVME_ZS_ZSIO:
+            case NVME_ZS_ZSEO:
+            case NVME_ZS_ZSC:
+                status = nvme_zone_mgmt_send_finish(n, req, zone);
+                if (status) {
+                    return status;
+                }
+
+            default:
+                continue;
+            }
+        }
+
+        break;
+
+    case NVME_CMD_ZONE_MGMT_SEND_OPEN:
+        for (int i = 0; i < ns->zns.num_zones; i++) {
+            zone = &ns->zns.zones[i];
+
+            if (nvme_zs(zone) == NVME_ZS_ZSC) {
+                status = nvme_zone_mgmt_send_open(n, req, zone);
+                if (status) {
+                    return status;
+                }
+            }
+        }
+
+        break;
+
+    case NVME_CMD_ZONE_MGMT_SEND_RESET:
+        for (int i = 0; i < ns->zns.num_zones; i++) {
+            zone = &ns->zns.zones[i];
+
+            switch (nvme_zs(zone)) {
+            case NVME_ZS_ZSIO:
+            case NVME_ZS_ZSEO:
+            case NVME_ZS_ZSC:
+            case NVME_ZS_ZSF:
+                status = nvme_zone_mgmt_send_reset(n, req, zone);
+                if (status) {
+                    return status;
+                }
+
+            default:
+                continue;
+            }
+        }
+
+        break;
+
+    case NVME_CMD_ZONE_MGMT_SEND_OFFLINE:
+        for (int i = 0; i < ns->zns.num_zones; i++) {
+            zone = &ns->zns.zones[i];
+
+            if (nvme_zs(zone) == NVME_ZS_ZSRO) {
+                status = nvme_zone_mgmt_send_offline(n, req, zone);
+                if (status) {
+                    return status;
+                }
+            }
+        }
+
+        break;
+    }
+
+    return NVME_SUCCESS;
+}
+
+static uint16_t nvme_zone_mgmt_send(NvmeCtrl *n, NvmeRequest *req)
+{
+    NvmeZoneManagementSendCmd *send = (NvmeZoneManagementSendCmd *) &req->cmd;
+    NvmeZoneManagementSendAction zsa = send->zsa;
+    NvmeNamespace *ns = req->ns;
+    NvmeZone *zone;
+    uint64_t zslba = le64_to_cpu(send->slba);
+
+    if (!nvme_ns_zoned(ns)) {
+        return NVME_INVALID_OPCODE | NVME_DNR;
+    }
+
+    trace_pci_nvme_zone_mgmt_send(nvme_cid(req), ns->params.nsid, zslba, zsa,
+                                  send->zsflags);
+
+    if (NVME_CMD_ZONE_MGMT_SEND_SELECT_ALL(send->zsflags)) {
+        return nvme_zone_mgmt_send_all(n, req);
+    }
+
+    if (zslba & (nvme_ns_zsze(ns) - 1)) {
+        trace_pci_nvme_err_invalid_zslba(nvme_cid(req), zslba);
+        return NVME_INVALID_FIELD | NVME_DNR;
+    }
+
+    zone = nvme_ns_get_zone(ns, zslba);
+    if (!zone) {
+        trace_pci_nvme_err_invalid_zone(nvme_cid(req), zslba);
+        return NVME_INVALID_FIELD | NVME_DNR;
+    }
+
+    switch (zsa) {
+    case NVME_CMD_ZONE_MGMT_SEND_CLOSE:
+        return nvme_zone_mgmt_send_close(n, req, zone);
+    case NVME_CMD_ZONE_MGMT_SEND_FINISH:
+        return nvme_zone_mgmt_send_finish(n, req, zone);
+    case NVME_CMD_ZONE_MGMT_SEND_OPEN:
+        return nvme_zone_mgmt_send_open(n, req, zone);
+    case NVME_CMD_ZONE_MGMT_SEND_RESET:
+        return nvme_zone_mgmt_send_reset(n, req, zone);
+    case NVME_CMD_ZONE_MGMT_SEND_OFFLINE:
+        return nvme_zone_mgmt_send_offline(n, req, zone);
+    case NVME_CMD_ZONE_MGMT_SEND_SET_ZDE:
+        return nvme_zone_mgmt_send_set_zde(n, req, zone);
+    }
+
+    return NVME_INVALID_FIELD | NVME_DNR;
+}
+
 static uint16_t nvme_zone_mgmt_recv(NvmeCtrl *n, NvmeRequest *req)
 {
     NvmeZoneManagementRecvCmd *recv;
@@ -1478,17 +1988,19 @@ static uint16_t nvme_rwz(NvmeCtrl *n, NvmeRequest *req)
             }
 
             switch (nvme_zs(zone)) {
-            case NVME_ZS_ZSE:
-            case NVME_ZS_ZSC:
-                nvme_zs_set(zone, NVME_ZS_ZSIO);
+            case NVME_ZS_ZSIO:
+            case NVME_ZS_ZSEO:
+                break;
+            default:
+                status = nvme_zrm_transition(ns, zone, NVME_ZS_ZSIO);
+                if (status) {
+                    goto invalid;
+                }
 
                 if (nvme_zns_commit_zone(req->ns, zone) < 0) {
                     status = NVME_INTERNAL_DEV_ERROR;
                     goto invalid;
                 }
-
-            default:
-                break;
             }
 
             zone->wp_staging += nlb;
@@ -1541,6 +2053,8 @@ static uint16_t nvme_io_cmd(NvmeCtrl *n, NvmeRequest *req)
     case NVME_CMD_WRITE:
     case NVME_CMD_READ:
         return nvme_rwz(n, req);
+    case NVME_CMD_ZONE_MGMT_SEND:
+        return nvme_zone_mgmt_send(n, req);
     case NVME_CMD_ZONE_MGMT_RECV:
         return nvme_zone_mgmt_recv(n, req);
     default:
diff --git a/hw/block/trace-events b/hw/block/trace-events
index a2671dadb1e8..d6342f5c555d 100644
--- a/hw/block/trace-events
+++ b/hw/block/trace-events
@@ -42,8 +42,18 @@ pci_nvme_io_cmd(uint16_t cid, uint32_t nsid, uint16_t sqid, uint8_t opcode, cons
 pci_nvme_admin_cmd(uint16_t cid, uint16_t sqid, uint8_t opcode, const char *opname) "cid %"PRIu16" sqid %"PRIu16" opc 0x%"PRIx8" opname '%s'"
 pci_nvme_rwz(uint16_t cid, const char *verb, uint32_t nsid, uint32_t nlb, uint64_t len, uint64_t lba) "cid %"PRIu16" opname '%s' nsid %"PRIu32" nlb %"PRIu32" len %"PRIu64" lba 0x%"PRIx64""
 pci_nvme_rw_cb(uint16_t cid, const char *blkname) "cid %"PRIu16" blk '%s'"
+pci_nvme_zone_mgmt_send(uint16_t cid, uint32_t nsid, uint64_t zslba, uint8_t zsa, uint8_t zsflags) "cid %"PRIu16" nsid %"PRIu32" zslba 0x%"PRIx64" zsa 0x%"PRIx8" zsflags 0x%"PRIx8""
+pci_nvme_zone_mgmt_send_all(uint16_t cid, uint32_t nsid, uint8_t za) "cid %"PRIu16" nsid %"PRIu32" za 0x%"PRIx8""
+pci_nvme_zone_mgmt_send_close(uint16_t cid, uint32_t nsid, uint64_t zslba, const char *zc) "cid %"PRIu16" nsid %"PRIu32" zslba 0x%"PRIx64" zc \"%s\""
+pci_nvme_zone_mgmt_send_finish(uint16_t cid, uint32_t nsid, uint64_t zslba, const char *zc) "cid %"PRIu16" nsid %"PRIu32" zslba 0x%"PRIx64" zc \"%s\""
+pci_nvme_zone_mgmt_send_open(uint16_t cid, uint32_t nsid, uint64_t zslba, const char *zc) "cid %"PRIu16" nsid %"PRIu32" zslba 0x%"PRIx64" zc \"%s\""
+pci_nvme_zone_mgmt_send_reset(uint16_t cid, uint32_t nsid, uint64_t zslba, const char *zc) "cid %"PRIu16" nsid %"PRIu32" zslba 0x%"PRIx64" zc \"%s\""
+pci_nvme_zone_mgmt_send_reset_cb(uint16_t cid, uint32_t nsid) "cid %"PRIu16" nsid %"PRIu32""
+pci_nvme_zone_mgmt_send_offline(uint16_t cid, uint32_t nsid, uint64_t zslba, const char *zc) "cid %"PRIu16" nsid %"PRIu32" zslba 0x%"PRIx64" zc \"%s\""
+pci_nvme_zone_mgmt_send_set_zde(uint16_t cid, uint32_t nsid, uint64_t zslba, const char *zc) "cid %"PRIu16" nsid %"PRIu32" zslba 0x%"PRIx64" zc \"%s\""
 pci_nvme_zone_mgmt_recv(uint16_t cid, uint32_t nsid, uint64_t slba, uint64_t len, uint8_t zra, uint8_t zrasp, uint8_t zrasf) "cid %"PRIu16" nsid %"PRIu32" slba 0x%"PRIx64" len %"PRIu64" zra 0x%"PRIx8" zrasp 0x%"PRIx8" zrasf 0x%"PRIx8""
 pci_nvme_allocate(uint32_t ns, uint64_t slba, uint32_t nlb) "nsid %"PRIu32" slba 0x%"PRIx64" nlb %"PRIu32""
+pci_nvme_deallocate(uint32_t ns, uint64_t slba, uint32_t nlb) "nsid %"PRIu32" slba 0x%"PRIx64" nlb %"PRIu32""
 pci_nvme_do_aio(uint16_t cid, uint8_t opc, const char *opname, const char *blkname, int64_t offset, size_t len) "cid %"PRIu16" opc 0x%"PRIx8" opname '%s' blk '%s' offset %"PRId64" len %zu"
 pci_nvme_create_sq(uint64_t addr, uint16_t sqid, uint16_t cqid, uint16_t qsize, uint16_t qflags) "create submission queue, addr=0x%"PRIx64", sqid=%"PRIu16", cqid=%"PRIu16", qsize=%"PRIu16", qflags=%"PRIu16""
 pci_nvme_create_cq(uint64_t addr, uint16_t cqid, uint16_t vector, uint16_t size, uint16_t qflags, int ien) "create completion queue, addr=0x%"PRIx64", cqid=%"PRIu16", vector=%"PRIu16", qsize=%"PRIu16", qflags=%"PRIu16", ien=%d"
@@ -134,6 +144,7 @@ pci_nvme_err_invalid_setfeat(uint32_t dw10) "invalid set features, dw10=0x%"PRIx
 pci_nvme_err_invalid_log_page(uint16_t cid, uint16_t lid) "cid %"PRIu16" lid 0x%"PRIx16""
 pci_nvme_err_invalid_zone(uint16_t cid, uint64_t lba) "cid %"PRIu16" lba 0x%"PRIx64""
 pci_nvme_err_invalid_zone_condition(uint16_t cid, uint64_t zslba, uint8_t condition) "cid %"PRIu16" zslba 0x%"PRIx64" condition 0x%"PRIx8""
+pci_nvme_err_invalid_zslba(uint16_t cid, uint64_t zslba) "cid %"PRIu16" zslba 0x%"PRIx64""
 pci_nvme_err_startfail_cq(void) "nvme_start_ctrl failed because there are non-admin completion queues"
 pci_nvme_err_startfail_sq(void) "nvme_start_ctrl failed because there are non-admin submission queues"
 pci_nvme_err_startfail_nbarasq(void) "nvme_start_ctrl failed because the admin submission queue address is null"
-- 
2.28.0


