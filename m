Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8A90C4363D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 21:10:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 418A822208
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 21:10:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 418A822208
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49086 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLYVH-0002UL-27
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 17:10:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38618)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kLY7Y-0004ZC-SS; Thu, 24 Sep 2020 16:45:41 -0400
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:43295)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kLY7T-0007nP-6b; Thu, 24 Sep 2020 16:45:40 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
 by mailnew.nyi.internal (Postfix) with ESMTP id 56D7E580509;
 Thu, 24 Sep 2020 16:45:33 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute7.internal (MEProxy); Thu, 24 Sep 2020 16:45:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm1; bh=iHh5SVDa7WZAZ
 iIwnoJA5VT73xcAn9ABMOivHzmv5kI=; b=Q3zTLCUcu109+KkBGezVZvmh7I++L
 XA+KF2WiEFCHttgugLeU9MeGCxFEAD2PaC+cspU2YiBci+BELee8O/a7rBeX7/7P
 FFVI98pVEzlkm3hZXjQHmVcbHqMxbpXxqJm8t0VgdyZvZB2ARfwh9je5ZpM4s7Cl
 St9FGl0MNDvlFgtG7WjYlc5r5k0UNOvjkEvEm7xw6LKXUnTq6V7S0F6GvIoZjdM0
 b01Ovdc1bDZ6mqnxQgEkkiMg+lYbFEk+z7GNcReeutsAbK+80j+31n0WRHMmhtsn
 rF62E6yvCFGex0eYGCsj4jDIUndlHsa7npSUfxUKJBOAL1bcIeXoqUhvw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm3; bh=iHh5SVDa7WZAZiIwnoJA5VT73xcAn9ABMOivHzmv5kI=; b=jbfIktMg
 vgKLO7b/Zcw1uGwhgC1tdVJnQ7g6XHSQNPvJ9JyKurQOXMLW0MHWPF3kl7Mbay5P
 jXw6FCJmRKtXGFY+wFL7LegPI6AF05gAldImg4K7zIffETx+zCWaPpP0gy85u4f6
 /0sqw8QyudQ4Kkw1VQ06kBCZfvz2GxgrDEYx88l8iTI5FZ0nt58DFf69erpwAx0e
 3kS/QVUPEtvKG051pOIANBqY4Jg98uKimDJAgWvAE7ff9wqATGh7BPhj1XF9uupQ
 cxDpgbWHVUodUW6lMm3eeEdp3zA42q3ylcdUDO+ZMhbj4wHo1U7cNfxWQVZ/LWJX
 sJPxQ3raBFsX2A==
X-ME-Sender: <xms:bAVtXw5HLYlZ8YWvL14QrCOFpqEmpcVTJLZ0Pk2Rcgko7RtoqHSa6Q>
 <xme:bAVtXx7x-wII8s3cdOJ71AW-YZ_6-8Hm92kWGnmBnQSR12gxcPyk5ubrtm6OUyQV6
 BslaBD-Ne-mH_tyPLk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudekgdduheduucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefmlhgruhhs
 ucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrghtth
 gvrhhnpeeuleetgeeiuefhgfekfefgveejiefgteekiedtgfdtieefhfdthfefueffvefg
 keenucfkphepkedtrdduieejrdelkedrudeltdenucevlhhushhtvghrufhiiigvpeegne
 curfgrrhgrmhepmhgrihhlfhhrohhmpehithhssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:bAVtX_f17uKBGKXhFMjX6xylLWxk4EZ-pchl0JrogVPEgQzhUvxnng>
 <xmx:bAVtX1IQUodDsqKo2QiAOcQuCtCs2uA5RMWRMnXHIthRs-yXk2EASg>
 <xmx:bAVtX0JjdrxiaCgOOIZzZ0ea7SvX2mBqJQMTNe1jJKnAHeAidzE20A>
 <xmx:bAVtX-gwfw_IKcO7TjN-KUZCc2c7gQA_FS8qECkWSD_PIDx92ctTzg>
Received: from apples.local (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id 4709D3064686;
 Thu, 24 Sep 2020 16:45:31 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Subject: [PATCH 10/16] hw/block/nvme: add the zone management receive command
Date: Thu, 24 Sep 2020 22:45:10 +0200
Message-Id: <20200924204516.1881843-11-its@irrelevant.dk>
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

Add the Zone Management Receive command.

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/block/nvme-ns.h    |   8 +++
 hw/block/nvme.h       |   1 +
 include/block/nvme.h  |  46 ++++++++++++++
 hw/block/nvme-ns.c    |  35 ++++++++++-
 hw/block/nvme.c       | 135 ++++++++++++++++++++++++++++++++++++++++++
 hw/block/trace-events |   1 +
 6 files changed, 223 insertions(+), 3 deletions(-)

diff --git a/hw/block/nvme-ns.h b/hw/block/nvme-ns.h
index c15bfcfc5a08..5a695334a052 100644
--- a/hw/block/nvme-ns.h
+++ b/hw/block/nvme-ns.h
@@ -27,11 +27,13 @@ typedef struct NvmeNamespaceParams {
     struct {
         uint64_t zcap;
         uint64_t zsze;
+        uint8_t  zdes;
     } zns;
 } NvmeNamespaceParams;
 
 typedef struct NvmeZone {
     NvmeZoneDescriptor *zd;
+    uint8_t            *zde;
 
     uint64_t wp_staging;
 } NvmeZone;
@@ -68,6 +70,7 @@ typedef struct NvmeNamespace {
 
         NvmeZone           *zones;
         NvmeZoneDescriptor *zd;
+        uint8_t            *zde;
     } zns;
 } NvmeNamespace;
 
@@ -160,6 +163,11 @@ static inline void nvme_zs_set(NvmeZone *zone, NvmeZoneState zs)
     zone->zd->zs = zs << 4;
 }
 
+static inline size_t nvme_ns_zdes_bytes(NvmeNamespace *ns)
+{
+    return ns->params.zns.zdes << 6;
+}
+
 static inline bool nvme_ns_zone_wp_valid(NvmeZone *zone)
 {
     switch (nvme_zs(zone)) {
diff --git a/hw/block/nvme.h b/hw/block/nvme.h
index f66ed9ab7eff..523eef0bcad8 100644
--- a/hw/block/nvme.h
+++ b/hw/block/nvme.h
@@ -71,6 +71,7 @@ static inline const char *nvme_io_opc_str(uint8_t opc)
     case NVME_CMD_WRITE:            return "NVME_NVM_CMD_WRITE";
     case NVME_CMD_READ:             return "NVME_NVM_CMD_READ";
     case NVME_CMD_WRITE_ZEROES:     return "NVME_NVM_CMD_WRITE_ZEROES";
+    case NVME_CMD_ZONE_MGMT_RECV:   return "NVME_ZONED_CMD_ZONE_MGMT_RECV";
     default:                        return "NVME_NVM_CMD_UNKNOWN";
     }
 }
diff --git a/include/block/nvme.h b/include/block/nvme.h
index 2e523c9d97b4..9bacf48ee9e9 100644
--- a/include/block/nvme.h
+++ b/include/block/nvme.h
@@ -481,6 +481,7 @@ enum NvmeIoCommands {
     NVME_CMD_COMPARE            = 0x05,
     NVME_CMD_WRITE_ZEROES       = 0x08,
     NVME_CMD_DSM                = 0x09,
+    NVME_CMD_ZONE_MGMT_RECV     = 0x7a,
 };
 
 typedef struct QEMU_PACKED NvmeDeleteQ {
@@ -593,6 +594,44 @@ enum {
     NVME_RW_PRINFO_PRCHK_REF    = 1 << 10,
 };
 
+typedef struct QEMU_PACKED NvmeZoneManagementRecvCmd {
+    uint8_t     opcode;
+    uint8_t     flags;
+    uint16_t    cid;
+    uint32_t    nsid;
+    uint8_t     rsvd8[16];
+    NvmeCmdDptr dptr;
+    uint64_t    slba;
+    uint32_t    numdw;
+    uint8_t     zra;
+    uint8_t     zrasp;
+    uint8_t     zrasf;
+    uint8_t     rsvd55[9];
+} NvmeZoneManagementRecvCmd;
+
+typedef enum NvmeZoneManagementRecvAction {
+    NVME_CMD_ZONE_MGMT_RECV_REPORT_ZONES          = 0x0,
+    NVME_CMD_ZONE_MGMT_RECV_EXTENDED_REPORT_ZONES = 0x1,
+} NvmeZoneManagementRecvAction;
+
+typedef enum NvmeZoneManagementRecvActionSpecificField {
+    NVME_CMD_ZONE_MGMT_RECV_LIST_ALL  = 0x0,
+    NVME_CMD_ZONE_MGMT_RECV_LIST_ZSE  = 0x1,
+    NVME_CMD_ZONE_MGMT_RECV_LIST_ZSIO = 0x2,
+    NVME_CMD_ZONE_MGMT_RECV_LIST_ZSEO = 0x3,
+    NVME_CMD_ZONE_MGMT_RECV_LIST_ZSC  = 0x4,
+    NVME_CMD_ZONE_MGMT_RECV_LIST_ZSF  = 0x5,
+    NVME_CMD_ZONE_MGMT_RECV_LIST_ZSRO = 0x6,
+    NVME_CMD_ZONE_MGMT_RECV_LIST_ZSO  = 0x7,
+} NvmeZoneManagementRecvActionSpecificField;
+
+#define NVME_CMD_ZONE_MGMT_RECEIVE_PARTIAL 0x1
+
+typedef struct QEMU_PACKED NvmeZoneReportHeader {
+    uint64_t num_zones;
+    uint8_t  rsvd[56];
+} NvmeZoneReportHeader;
+
 typedef struct QEMU_PACKED NvmeDsmCmd {
     uint8_t     opcode;
     uint8_t     flags;
@@ -812,6 +851,12 @@ typedef struct QEMU_PACKED NvmeZoneDescriptor {
     uint8_t  rsvd32[32];
 } NvmeZoneDescriptor;
 
+#define NVME_ZA_ZDEV (1 << 7)
+
+#define NVME_ZA_SET(za, attrs)   ((za) |= (attrs))
+#define NVME_ZA_CLEAR(za, attrs) ((za) &= ~(attrs))
+#define NVME_ZA_CLEAR_ALL(za)    ((za) = 0x0)
+
 enum NvmeSmartWarn {
     NVME_SMART_SPARE                  = 1 << 0,
     NVME_SMART_TEMPERATURE            = 1 << 1,
@@ -1162,6 +1207,7 @@ static inline void _nvme_check_size(void)
     QEMU_BUILD_BUG_ON(sizeof(NvmeIdentify) != 64);
     QEMU_BUILD_BUG_ON(sizeof(NvmeRwCmd) != 64);
     QEMU_BUILD_BUG_ON(sizeof(NvmeDsmCmd) != 64);
+    QEMU_BUILD_BUG_ON(sizeof(NvmeZoneManagementRecvCmd) != 64);
     QEMU_BUILD_BUG_ON(sizeof(NvmeRangeType) != 64);
     QEMU_BUILD_BUG_ON(sizeof(NvmeErrorLog) != 64);
     QEMU_BUILD_BUG_ON(sizeof(NvmeFwSlotInfoLog) != 512);
diff --git a/hw/block/nvme-ns.c b/hw/block/nvme-ns.c
index 872c46f2f2f0..0fb196c7103e 100644
--- a/hw/block/nvme-ns.c
+++ b/hw/block/nvme-ns.c
@@ -85,6 +85,9 @@ static void nvme_ns_zns_init_zones(NvmeNamespace *ns)
         zslba = i * zsze;
         zone = nvme_ns_get_zone(ns, zslba);
         zone->zd = &ns->zns.zd[i];
+        if (ns->params.zns.zdes) {
+            zone->zde = &ns->zns.zde[i];
+        }
 
         zd = zone->zd;
 
@@ -104,11 +107,15 @@ static void nvme_ns_init_zoned(NvmeNamespace *ns)
     for (int i = 0; i <= id_ns->nlbaf; i++) {
         id_ns_zns->lbafe[i].zsze = ns->params.zns.zsze ?
             ns->params.zns.zsze : cpu_to_le64(pow2ceil(ns->params.zns.zcap));
+        id_ns_zns->lbafe[i].zdes = ns->params.zns.zdes;
     }
 
     ns->zns.num_zones = nvme_ns_nlbas(ns) / nvme_ns_zsze(ns);
     ns->zns.zones = g_malloc0_n(ns->zns.num_zones, sizeof(NvmeZone));
     ns->zns.zd = g_malloc0_n(ns->zns.num_zones, sizeof(NvmeZoneDescriptor));
+    if (ns->params.zns.zdes) {
+        ns->zns.zde = g_malloc0_n(ns->zns.num_zones, nvme_ns_zdes_bytes(ns));
+    }
 
     id_ns->ncap = ns->zns.num_zones * ns->params.zns.zcap;
 
@@ -148,7 +155,7 @@ static int nvme_ns_setup_blk_pstate(NvmeNamespace *ns, Error **errp)
     BlockBackend *blk = ns->pstate.blk;
     uint64_t perm, shared_perm;
     ssize_t len;
-    size_t util_len, zd_len, pstate_len;
+    size_t util_len, zd_len, zde_len, pstate_len;
     int ret;
 
     perm = BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE;
@@ -162,7 +169,9 @@ static int nvme_ns_setup_blk_pstate(NvmeNamespace *ns, Error **errp)
     util_len = DIV_ROUND_UP(nvme_ns_nlbas(ns), 8);
     zd_len = nvme_ns_zoned(ns) ?
         ns->zns.num_zones * sizeof(NvmeZoneDescriptor) : 0;
-    pstate_len = ROUND_UP(util_len + zd_len, BDRV_SECTOR_SIZE);
+    zde_len = nvme_ns_zoned(ns) ?
+        ns->zns.num_zones * nvme_ns_zdes_bytes(ns) : 0;
+    pstate_len = ROUND_UP(util_len + zd_len + zde_len, BDRV_SECTOR_SIZE);
 
     len = blk_getlength(blk);
     if (len < 0) {
@@ -213,9 +222,19 @@ static int nvme_ns_setup_blk_pstate(NvmeNamespace *ns, Error **errp)
                 return ret;
             }
 
+            if (zde_len) {
+                ret = blk_pread(blk, util_len + zd_len, ns->zns.zde,
+                                zde_len);
+                if (ret < 0) {
+                    error_setg_errno(errp, -ret, "could not read pstate");
+                    return ret;
+                }
+            }
+
             for (int i = 0; i < ns->zns.num_zones; i++) {
                 NvmeZone *zone = &ns->zns.zones[i];
                 zone->zd = &ns->zns.zd[i];
+                zone->zde = &ns->zns.zde[i];
 
                 zone->wp_staging = nvme_wp(zone);
 
@@ -227,7 +246,8 @@ static int nvme_ns_setup_blk_pstate(NvmeNamespace *ns, Error **errp)
                     continue;
 
                 case NVME_ZS_ZSC:
-                    if (nvme_wp(zone) == nvme_zslba(zone)) {
+                    if (nvme_wp(zone) == nvme_zslba(zone) &&
+                        !(zone->zd->za & NVME_ZA_ZDEV)) {
                         nvme_zs_set(zone, NVME_ZS_ZSE);
                     }
 
@@ -248,6 +268,14 @@ static int nvme_ns_setup_blk_pstate(NvmeNamespace *ns, Error **errp)
             error_setg_errno(errp, -ret, "could not write pstate");
             return ret;
         }
+
+        if (zde_len) {
+            ret = blk_pwrite(blk, util_len + zd_len, ns->zns.zde, zde_len, 0);
+            if (ret < 0) {
+                error_setg_errno(errp, -ret, "could not write pstate");
+                return ret;
+            }
+        }
     }
 
     return 0;
@@ -389,6 +417,7 @@ static Property nvme_ns_props[] = {
     DEFINE_PROP_UINT8("iocs", NvmeNamespace, params.iocs, NVME_IOCS_NVM),
     DEFINE_PROP_UINT64("zns.zcap", NvmeNamespace, params.zns.zcap, 0),
     DEFINE_PROP_UINT64("zns.zsze", NvmeNamespace, params.zns.zsze, 0),
+    DEFINE_PROP_UINT8("zns.zdes", NvmeNamespace, params.zns.zdes, 0),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index b0179291b966..43ae89a0a6cb 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -163,6 +163,7 @@ static const NvmeEffectsLog nvme_effects[NVME_IOCS_MAX] = {
 
         .iocs = {
             NVME_EFFECTS_NVM_INITIALIZER,
+            [NVME_CMD_ZONE_MGMT_RECV] = NVME_EFFECTS_CSUPP,
         },
     },
 };
@@ -1201,6 +1202,9 @@ static void nvme_rw_cb(void *opaque, int ret)
                 NVME_ZS_ZSRO : NVME_ZS_ZSO;
 
             nvme_zs_set(zone, zs);
+            if (zs == NVME_ZS_ZSO) {
+                NVME_ZA_CLEAR_ALL(zone->zd->za);
+            }
 
             if (nvme_zns_commit_zone(ns, zone) < 0) {
                 req->status = NVME_INTERNAL_DEV_ERROR;
@@ -1269,6 +1273,135 @@ static uint16_t nvme_do_aio(BlockBackend *blk, int64_t offset, size_t len,
     return NVME_NO_COMPLETE;
 }
 
+static uint16_t nvme_zone_mgmt_recv(NvmeCtrl *n, NvmeRequest *req)
+{
+    NvmeZoneManagementRecvCmd *recv;
+    NvmeZoneManagementRecvAction zra;
+    NvmeZoneManagementRecvActionSpecificField zrasp;
+    NvmeNamespace *ns = req->ns;
+    NvmeZone *zone;
+
+    uint8_t *buf, *bufp, zs_list;
+    uint64_t slba;
+    int num_zones = 0, zidx = 0, zidx_begin;
+    uint16_t zes, status;
+    size_t len;
+
+    recv = (NvmeZoneManagementRecvCmd *) &req->cmd;
+
+    zra = recv->zra;
+    zrasp = recv->zrasp;
+    slba = le64_to_cpu(recv->slba);
+    len = (le32_to_cpu(recv->numdw) + 1) << 2;
+
+    if (!nvme_ns_zoned(ns)) {
+        return NVME_INVALID_OPCODE | NVME_DNR;
+    }
+
+    trace_pci_nvme_zone_mgmt_recv(nvme_cid(req), nvme_nsid(ns), slba, len,
+                                  zra, zrasp, recv->zrasf);
+
+    if (!len) {
+        return NVME_SUCCESS;
+    }
+
+    switch (zrasp) {
+    case NVME_CMD_ZONE_MGMT_RECV_LIST_ALL:
+        zs_list = 0;
+        break;
+
+    case NVME_CMD_ZONE_MGMT_RECV_LIST_ZSE:
+        zs_list = NVME_ZS_ZSE;
+        break;
+
+    case NVME_CMD_ZONE_MGMT_RECV_LIST_ZSIO:
+        zs_list = NVME_ZS_ZSIO;
+        break;
+
+    case NVME_CMD_ZONE_MGMT_RECV_LIST_ZSEO:
+        zs_list = NVME_ZS_ZSEO;
+        break;
+
+    case NVME_CMD_ZONE_MGMT_RECV_LIST_ZSC:
+        zs_list = NVME_ZS_ZSC;
+        break;
+
+    case NVME_CMD_ZONE_MGMT_RECV_LIST_ZSF:
+        zs_list = NVME_ZS_ZSF;
+        break;
+
+    case NVME_CMD_ZONE_MGMT_RECV_LIST_ZSRO:
+        zs_list = NVME_ZS_ZSRO;
+        break;
+
+    case NVME_CMD_ZONE_MGMT_RECV_LIST_ZSO:
+        zs_list = NVME_ZS_ZSO;
+        break;
+    default:
+        return NVME_INVALID_FIELD | NVME_DNR;
+    }
+
+    status = nvme_check_mdts(n, len);
+    if (status) {
+        return status;
+    }
+
+    if (!nvme_ns_get_zone(ns, slba)) {
+        trace_pci_nvme_err_invalid_zone(nvme_cid(req), slba);
+        return NVME_INVALID_FIELD | NVME_DNR;
+    }
+
+    zidx_begin = zidx = nvme_ns_zone_idx(ns, slba);
+    zes = sizeof(NvmeZoneDescriptor);
+    if (zra == NVME_CMD_ZONE_MGMT_RECV_EXTENDED_REPORT_ZONES) {
+        zes += nvme_ns_zdes_bytes(ns);
+    }
+
+    buf = bufp = g_malloc0(len);
+    bufp += sizeof(NvmeZoneReportHeader);
+
+    while ((bufp + zes) - buf <= len && zidx < ns->zns.num_zones) {
+        zone = &ns->zns.zones[zidx++];
+
+        if (zs_list && zs_list != nvme_zs(zone)) {
+            continue;
+        }
+
+        num_zones++;
+
+        memcpy(bufp, zone->zd, sizeof(NvmeZoneDescriptor));
+
+        if (zra == NVME_CMD_ZONE_MGMT_RECV_EXTENDED_REPORT_ZONES) {
+            memcpy(bufp + sizeof(NvmeZoneDescriptor), zone->zde,
+                   nvme_ns_zdes_bytes(ns));
+        }
+
+        bufp += zes;
+    }
+
+    if (!(recv->zrasf & NVME_CMD_ZONE_MGMT_RECEIVE_PARTIAL)) {
+        if (!zs_list) {
+            num_zones = ns->zns.num_zones - zidx_begin;
+        } else {
+            num_zones = 0;
+            for (int i = zidx_begin; i < ns->zns.num_zones; i++) {
+                zone = &ns->zns.zones[i];
+
+                if (zs_list == nvme_zs(zone)) {
+                    num_zones++;
+                }
+            }
+        }
+    }
+
+    stq_le_p(buf, (uint64_t)num_zones);
+
+    status = nvme_dma(n, buf, len, DMA_DIRECTION_FROM_DEVICE, req);
+    g_free(buf);
+
+    return status;
+}
+
 static uint16_t nvme_flush(NvmeCtrl *n, NvmeRequest *req)
 {
     NvmeNamespace *ns = req->ns;
@@ -1408,6 +1541,8 @@ static uint16_t nvme_io_cmd(NvmeCtrl *n, NvmeRequest *req)
     case NVME_CMD_WRITE:
     case NVME_CMD_READ:
         return nvme_rwz(n, req);
+    case NVME_CMD_ZONE_MGMT_RECV:
+        return nvme_zone_mgmt_recv(n, req);
     default:
         trace_pci_nvme_err_invalid_opc(req->cmd.opcode);
         return NVME_INVALID_OPCODE | NVME_DNR;
diff --git a/hw/block/trace-events b/hw/block/trace-events
index d46a7a4942bb..a2671dadb1e8 100644
--- a/hw/block/trace-events
+++ b/hw/block/trace-events
@@ -42,6 +42,7 @@ pci_nvme_io_cmd(uint16_t cid, uint32_t nsid, uint16_t sqid, uint8_t opcode, cons
 pci_nvme_admin_cmd(uint16_t cid, uint16_t sqid, uint8_t opcode, const char *opname) "cid %"PRIu16" sqid %"PRIu16" opc 0x%"PRIx8" opname '%s'"
 pci_nvme_rwz(uint16_t cid, const char *verb, uint32_t nsid, uint32_t nlb, uint64_t len, uint64_t lba) "cid %"PRIu16" opname '%s' nsid %"PRIu32" nlb %"PRIu32" len %"PRIu64" lba 0x%"PRIx64""
 pci_nvme_rw_cb(uint16_t cid, const char *blkname) "cid %"PRIu16" blk '%s'"
+pci_nvme_zone_mgmt_recv(uint16_t cid, uint32_t nsid, uint64_t slba, uint64_t len, uint8_t zra, uint8_t zrasp, uint8_t zrasf) "cid %"PRIu16" nsid %"PRIu32" slba 0x%"PRIx64" len %"PRIu64" zra 0x%"PRIx8" zrasp 0x%"PRIx8" zrasf 0x%"PRIx8""
 pci_nvme_allocate(uint32_t ns, uint64_t slba, uint32_t nlb) "nsid %"PRIu32" slba 0x%"PRIx64" nlb %"PRIu32""
 pci_nvme_do_aio(uint16_t cid, uint8_t opc, const char *opname, const char *blkname, int64_t offset, size_t len) "cid %"PRIu16" opc 0x%"PRIx8" opname '%s' blk '%s' offset %"PRId64" len %zu"
 pci_nvme_create_sq(uint64_t addr, uint16_t sqid, uint16_t cqid, uint16_t qsize, uint16_t qflags) "create submission queue, addr=0x%"PRIx64", sqid=%"PRIu16", cqid=%"PRIu16", qsize=%"PRIu16", qflags=%"PRIu16""
-- 
2.28.0


