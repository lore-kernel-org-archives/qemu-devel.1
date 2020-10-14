Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8003C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 11:49:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B62920848
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 11:49:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B62920848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39874 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSfHC-0005rX-PD
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 07:49:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45370)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kSf0N-0003Gp-Cv; Wed, 14 Oct 2020 07:31:39 -0400
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:40541)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kSf0I-0006Zm-M9; Wed, 14 Oct 2020 07:31:39 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailnew.nyi.internal (Postfix) with ESMTP id F2BE55801A3;
 Wed, 14 Oct 2020 07:31:32 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute4.internal (MEProxy); Wed, 14 Oct 2020 07:31:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm1; bh=ovCuSu5xZcwQj
 4NeLdHauQJzewSop174pla4Xd09OSw=; b=IctirxWO7rZvRpyrLiqxGxEOA6aH9
 N0SloYEh2AcYjc503/RfTRSlB7458caK6/bNyFdRYM/147vZGZj/24aDKlInDTHH
 yZ+V9h4MrXGKPdHk997F6hUV/xTPEqFO/XrHVOYmyNfqC62btPVcujhXx53/zNAm
 UCMc/yTOQz8MQT7QQaz1oiyEghP2L9RsXAegzvftsiSXNhOhPymugXk0wwEfs3f4
 Exc/DRYSi95GzC9m26JmM8OTnfeF2e6K0kIlfPRiUv7lWbGdhUL9+Zrdj34ABVxO
 6903P4L0ja4vhie9ga/F2QhrrqBuJ27tqCFTebWLl0p4ml3rLqHtQ5w4g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm1; bh=ovCuSu5xZcwQj4NeLdHauQJzewSop174pla4Xd09OSw=; b=rYg9q4sM
 Nwg4dPguw3DiTpg7RLfwrfnHbj6zS5gd0CXRAsB/0HxeW9+dLWvYA0DBgkPvsU/M
 evweKucK2MS+eFYrOOH0Tc8GbNTFftzu7/SO5U9ARd4d7Dz1KQx3SCkiJs7cShq2
 HWxNdCq8PPoZQ6YtpV+n6/g+V6k/d5HHqnMOdVkARZJOck7R6fld71fJGIm9wHR4
 Rv1rYYnvDyp7owqvNXfhzqaK76slKpdtir8FslSKf6uhK7LWF3j0i8UV7YSdtGwE
 jukWFNkAP2WtnXz6oVxP10YVDZoa7PnYmkBC8ua2oYAihMPBvJ6KQ20Cdi04GwMB
 cYxvfTuhHFph0w==
X-ME-Sender: <xms:lOGGXxxnuILuly3dXnG5JYqRGJcKqOef9MclrDvqCLr3WCreMia--A>
 <xme:lOGGXxQr7fIgsj_9VwJ88keKXGxw-nqxaGkECLq7J-nPKH4hI89SyGE6IC_u5VE6S
 4veCZh_29onignYIbA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedriedugdegudcutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepmfhlrghushcu
 lfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrthhtvg
 hrnhepueelteegieeuhffgkeefgfevjeeigfetkeeitdfgtdeifefhtdfhfeeuffevgfek
 necukfhppeektddrudeijedrleekrdduledtnecuvehluhhsthgvrhfuihiivgepudenuc
 frrghrrghmpehmrghilhhfrhhomhepihhtshesihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:lOGGX7Wnf4kvoZkZjc43YXfJce3oY1dLn25AH0rtC8ZHApQaFsZeLQ>
 <xmx:lOGGXzhyxhEzBzYnmOocipxv1057-VUlX2p3VSXlHONgEYOfa3qn6Q>
 <xmx:lOGGXzC2APTYGwUY03sSQXRmSyqU0lvb9Ks9YJNOBbKJ-TRCN5TmeQ>
 <xmx:lOGGX13LvYUcUPZ9uX4VyhhLrDBTu5vczm_nJCJdTL2cPrWgUBDj2g>
Received: from apples.local (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id 490793064686;
 Wed, 14 Oct 2020 07:31:31 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 5/9] hw/block/nvme: add the zone management receive command
Date: Wed, 14 Oct 2020 13:31:18 +0200
Message-Id: <20201014113122.388849-6-its@irrelevant.dk>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201014113122.388849-1-its@irrelevant.dk>
References: <20201014113122.388849-1-its@irrelevant.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=66.111.4.229; envelope-from=its@irrelevant.dk;
 helo=new3-smtp.messagingengine.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/14 07:31:27
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 Stefan Hajnoczi <stefanha@redhat.com>, Klaus Jensen <its@irrelevant.dk>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Klaus Jensen <k.jensen@samsung.com>

Add the Zone Management Receive command.

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/block/nvme-ns.h    |   8 +++
 hw/block/nvme.h       |   1 +
 include/block/nvme.h  |  46 +++++++++++++
 hw/block/nvme-ns.c    |  12 +++-
 hw/block/nvme.c       | 146 ++++++++++++++++++++++++++++++++++++++++++
 hw/block/trace-events |   1 +
 6 files changed, 213 insertions(+), 1 deletion(-)

diff --git a/hw/block/nvme-ns.h b/hw/block/nvme-ns.h
index dd311012213e..a273e7f7ed4b 100644
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
@@ -55,6 +57,7 @@ typedef struct NvmeNamespace {
 
         NvmeZone           *zones;
         NvmeZoneDescriptor *zd;
+        uint8_t            *zde;
     } zns;
 } NvmeNamespace;
 
@@ -105,6 +108,11 @@ static inline uint64_t nvme_ns_zsze(NvmeNamespace *ns)
     return nvme_ns_lbafe(ns)->zsze;
 }
 
+static inline size_t nvme_ns_zdes_bytes(NvmeNamespace *ns)
+{
+    return ns->params.zns.zdes << 6;
+}
+
 /* calculate the number of LBAs that the namespace can accomodate */
 static inline uint64_t nvme_ns_nlbas(NvmeNamespace *ns)
 {
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
index cf566032a9fa..fdbb3a0d5490 100644
--- a/include/block/nvme.h
+++ b/include/block/nvme.h
@@ -480,6 +480,7 @@ enum NvmeIoCommands {
     NVME_CMD_COMPARE            = 0x05,
     NVME_CMD_WRITE_ZEROES       = 0x08,
     NVME_CMD_DSM                = 0x09,
+    NVME_CMD_ZONE_MGMT_RECV     = 0x7a,
 };
 
 typedef struct QEMU_PACKED NvmeDeleteQ {
@@ -592,6 +593,44 @@ enum {
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
@@ -810,6 +849,12 @@ typedef struct QEMU_PACKED NvmeZoneDescriptor {
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
@@ -1161,6 +1206,7 @@ static inline void _nvme_check_size(void)
     QEMU_BUILD_BUG_ON(sizeof(NvmeIdentify) != 64);
     QEMU_BUILD_BUG_ON(sizeof(NvmeRwCmd) != 64);
     QEMU_BUILD_BUG_ON(sizeof(NvmeDsmCmd) != 64);
+    QEMU_BUILD_BUG_ON(sizeof(NvmeZoneManagementRecvCmd) != 64);
     QEMU_BUILD_BUG_ON(sizeof(NvmeRangeType) != 64);
     QEMU_BUILD_BUG_ON(sizeof(NvmeErrorLog) != 64);
     QEMU_BUILD_BUG_ON(sizeof(NvmeFwSlotInfoLog) != 512);
diff --git a/hw/block/nvme-ns.c b/hw/block/nvme-ns.c
index 1a5e99e50578..0922b67dd6d8 100644
--- a/hw/block/nvme-ns.c
+++ b/hw/block/nvme-ns.c
@@ -59,6 +59,9 @@ static void nvme_ns_zns_init_zones(NvmeNamespace *ns)
 
         zone = &ns->zns.zones[i];
         zone->zd = &ns->zns.zd[i];
+        if (ns->params.zns.zdes) {
+            zone->zde = &ns->zns.zde[i];
+        }
         zone->wp_staging = zslba;
 
         zd = zone->zd;
@@ -79,11 +82,15 @@ static void nvme_ns_init_zoned(NvmeNamespace *ns)
         id_ns_zns->lbafe[i].zsze = ns->params.zns.zsze ?
             cpu_to_le64(ns->params.zns.zsze) :
             cpu_to_le64(pow2ceil(ns->params.zns.zcap));
+        id_ns_zns->lbafe[i].zdes = ns->params.zns.zdes;
     }
 
     ns->zns.num_zones = nvme_ns_nlbas(ns) / nvme_ns_zsze(ns);
     ns->zns.zones = g_malloc0_n(ns->zns.num_zones, sizeof(NvmeZone));
     ns->zns.zd = g_malloc0_n(ns->zns.num_zones, sizeof(NvmeZoneDescriptor));
+    if (ns->params.zns.zdes) {
+        ns->zns.zde = g_malloc0_n(ns->zns.num_zones, nvme_ns_zdes_bytes(ns));
+    }
 
     id_ns_zns->mar = 0xffffffff;
     id_ns_zns->mor = 0xffffffff;
@@ -126,6 +133,7 @@ void nvme_ns_zns_init_zone_state(NvmeNamespace *ns)
     for (int i = 0; i < ns->zns.num_zones; i++) {
         NvmeZone *zone = &ns->zns.zones[i];
         zone->zd = &ns->zns.zd[i];
+        zone->zde = &ns->zns.zde[i];
 
         zone->wp_staging = nvme_wp(zone);
 
@@ -137,7 +145,8 @@ void nvme_ns_zns_init_zone_state(NvmeNamespace *ns)
             break;
 
         case NVME_ZS_ZSC:
-            if (nvme_wp(zone) == nvme_zslba(zone)) {
+            if (nvme_wp(zone) == nvme_zslba(zone) &&
+                !(zone->zd->za & NVME_ZA_ZDEV)) {
                 nvme_zs_set(zone, NVME_ZS_ZSE);
             }
 
@@ -262,6 +271,7 @@ static Property nvme_ns_props[] = {
     DEFINE_PROP_UUID("uuid", NvmeNamespace, params.uuid),
     DEFINE_PROP_UINT64("zns.zcap", NvmeNamespace, params.zns.zcap, 0),
     DEFINE_PROP_UINT64("zns.zsze", NvmeNamespace, params.zns.zsze, 0),
+    DEFINE_PROP_UINT8("zns.zdes", NvmeNamespace, params.zns.zdes, 0),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 0b8d66c56d3f..a92cd02d8955 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -162,6 +162,7 @@ static const NvmeEffectsLog nvme_effects[NVME_IOCS_MAX] = {
 
         .iocs = {
             NVME_EFFECTS_NVM_INITIALIZER,
+            [NVME_CMD_ZONE_MGMT_RECV] = NVME_EFFECTS_CSUPP,
         },
     },
 };
@@ -1083,6 +1084,7 @@ static uint16_t nvme_zrm_transition(NvmeNamespace *ns, NvmeZone *zone,
                                     NvmeZoneState to)
 {
     NvmeZoneState from = nvme_zs(zone);
+    NvmeZoneDescriptor *zd = zone->zd;
 
     trace_pci_nvme_zrm_transition(ns->params.nsid, nvme_zslba(zone), from, to);
 
@@ -1099,6 +1101,10 @@ static uint16_t nvme_zrm_transition(NvmeNamespace *ns, NvmeZone *zone,
         switch (to) {
         case NVME_ZS_ZSE:
         case NVME_ZS_ZSO:
+            NVME_ZA_CLEAR_ALL(zd->za);
+
+            /* fallthrough */
+
         case NVME_ZS_ZSEO:
         case NVME_ZS_ZSF:
         case NVME_ZS_ZSRO:
@@ -1115,6 +1121,10 @@ static uint16_t nvme_zrm_transition(NvmeNamespace *ns, NvmeZone *zone,
         switch (to) {
         case NVME_ZS_ZSE:
         case NVME_ZS_ZSO:
+            NVME_ZA_CLEAR_ALL(zd->za);
+
+            /* fallthrough */
+
         case NVME_ZS_ZSF:
         case NVME_ZS_ZSRO:
         case NVME_ZS_ZSIO:
@@ -1130,6 +1140,7 @@ static uint16_t nvme_zrm_transition(NvmeNamespace *ns, NvmeZone *zone,
     case NVME_ZS_ZSRO:
         switch (to) {
         case NVME_ZS_ZSO:
+            NVME_ZA_CLEAR_ALL(zd->za);
             break;
 
         default:
@@ -1142,6 +1153,10 @@ static uint16_t nvme_zrm_transition(NvmeNamespace *ns, NvmeZone *zone,
         switch (to) {
         case NVME_ZS_ZSE:
         case NVME_ZS_ZSO:
+            NVME_ZA_CLEAR_ALL(zd->za);
+
+            /* fallthrough */
+
         case NVME_ZS_ZSRO:
             break;
 
@@ -1239,6 +1254,135 @@ static void nvme_rw_cb(void *opaque, int ret)
     nvme_enqueue_req_completion(nvme_cq(req), req);
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
+    if (!nvme_ns_zone(ns, slba)) {
+        trace_pci_nvme_err_invalid_zone(nvme_cid(req), slba);
+        return NVME_INVALID_FIELD | NVME_DNR;
+    }
+
+    zidx_begin = zidx = slba / nvme_ns_zsze(ns);
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
     block_acct_start(blk_get_stats(req->ns->blkconf.blk), &req->acct, 0,
@@ -1427,6 +1571,8 @@ static uint16_t nvme_io_cmd(NvmeCtrl *n, NvmeRequest *req)
     case NVME_CMD_WRITE:
     case NVME_CMD_READ:
         return nvme_rw(n, req);
+    case NVME_CMD_ZONE_MGMT_RECV:
+        return nvme_zone_mgmt_recv(n, req);
     default:
         trace_pci_nvme_err_invalid_opc(req->cmd.opcode);
         return NVME_INVALID_OPCODE | NVME_DNR;
diff --git a/hw/block/trace-events b/hw/block/trace-events
index 2ccd53e1a55e..546aea3221dc 100644
--- a/hw/block/trace-events
+++ b/hw/block/trace-events
@@ -43,6 +43,7 @@ pci_nvme_admin_cmd(uint16_t cid, uint16_t sqid, uint8_t opcode, const char *opna
 pci_nvme_rw(uint16_t cid, const char *verb, uint32_t nsid, uint32_t nlb, uint64_t count, uint64_t lba) "cid %"PRIu16" opname '%s' nsid %"PRIu32" nlb %"PRIu32" count %"PRIu64" lba 0x%"PRIx64""
 pci_nvme_rw_cb(uint16_t cid, const char *blkname) "cid %"PRIu16" blk '%s'"
 pci_nvme_write_zeroes(uint16_t cid, uint32_t nsid, uint64_t slba, uint32_t nlb) "cid %"PRIu16" nsid %"PRIu32" slba %"PRIu64" nlb %"PRIu32""
+pci_nvme_zone_mgmt_recv(uint16_t cid, uint32_t nsid, uint64_t slba, uint64_t len, uint8_t zra, uint8_t zrasp, uint8_t zrasf) "cid %"PRIu16" nsid %"PRIu32" slba 0x%"PRIx64" len %"PRIu64" zra 0x%"PRIx8" zrasp 0x%"PRIx8" zrasf 0x%"PRIx8""
 pci_nvme_create_sq(uint64_t addr, uint16_t sqid, uint16_t cqid, uint16_t qsize, uint16_t qflags) "create submission queue, addr=0x%"PRIx64", sqid=%"PRIu16", cqid=%"PRIu16", qsize=%"PRIu16", qflags=%"PRIu16""
 pci_nvme_create_cq(uint64_t addr, uint16_t cqid, uint16_t vector, uint16_t size, uint16_t qflags, int ien) "create completion queue, addr=0x%"PRIx64", cqid=%"PRIu16", vector=%"PRIu16", qsize=%"PRIu16", qflags=%"PRIu16", ien=%d"
 pci_nvme_del_sq(uint16_t qid) "deleting submission queue sqid=%"PRIu16""
-- 
2.28.0


