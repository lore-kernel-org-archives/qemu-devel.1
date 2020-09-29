Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38A40C4727C
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 23:37:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67F7E20773
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 23:37:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67F7E20773
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37754 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNPBO-00037w-03
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 19:37:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39104)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kNOuJ-0000k8-PT; Tue, 29 Sep 2020 19:19:39 -0400
Received: from wnew2-smtp.messagingengine.com ([64.147.123.27]:47833)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kNOuG-00009V-81; Tue, 29 Sep 2020 19:19:39 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailnew.west.internal (Postfix) with ESMTP id 5387FEB6;
 Tue, 29 Sep 2020 19:19:34 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute4.internal (MEProxy); Tue, 29 Sep 2020 19:19:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm1; bh=alqmpXbnFEBK9
 CpTS+wUokETkajaAEX9UfR5hF9sq50=; b=hp5z9JMoPmC4H1XpCr3xVpiDYhtN3
 tZ5VXUmtH8oGkapl6sdkT6LxaFCXJJDQM80rerfBi9bzUEPqRAfLX3HIEGWaXwyX
 SRI8vVmm1Sb/9RQCLGNtvOf6eClN7Z97wRsmcbiXwDkHyo7240Sugjmi/hcKb5eb
 h4REFwrmc2x0h/xPjmZV07FPFr/VHYNMLFbZmc9avxzFz0wj8RqjpYM2GLborXbP
 gl+wkGLNDj99j2kkjdvdvPjTs9V+ooCuH+63M1UuQ5e+Ohw827kAa1Y2RCZTat28
 8vMV99WaBy4n/PNraqgdcN8uck3/BxB63X1Ya7jUA2ZJgK2mfBFIwU3WQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm3; bh=alqmpXbnFEBK9CpTS+wUokETkajaAEX9UfR5hF9sq50=; b=IcrKP+Y/
 ap6PiB3DQWUHEO1hzjA5q1Eqf5xf5CiUzmErTRhuV/m40RqShKvsHgc6Tog5ZDB2
 AiXuX4kjrerOwZmFhwnkqF2oUBo+dF8/hFuUKg7y+EDiccwLk+xm2MT+2N34ZYM7
 GNncfTGEqEk9Bu/1BC7lQtUXOPm6HBpI+hQfk1SDPdvaYylORW0dSpzJ9/kpmnyP
 lAXx/7HL+p0t8a58qgk+qEtanTXVH3vdLFNMOQAmJ9/QXDZTjJwfatGVdsPqiYne
 zOt0wTjpPlGWZDb8h+hGV+iy8/ELNJ0t8WfDJ/p+1gXlRSweG4vK0/q5Y2gROCZF
 AgURSK9NC+dy/Q==
X-ME-Sender: <xms:BcFzX_hZ5lOwgjARylnzhgjwWbQxS2uulwFIm4WQhwYXKY_4Jwq8XA>
 <xme:BcFzX8A6f_YqBAnyJ1zfU4f-7gZrneLrOWAh07j0TTtoAFgZek2aS7f3qHcqVkV8a
 b2QfIP4dSH7RG5819Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrfedtgddujecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepmfhlrghushcu
 lfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrthhtvg
 hrnhepueelteegieeuhffgkeefgfevjeeigfetkeeitdfgtdeifefhtdfhfeeuffevgfek
 necukfhppeektddrudeijedrleekrdduledtnecuvehluhhsthgvrhfuihiivgepheenuc
 frrghrrghmpehmrghilhhfrhhomhepihhtshesihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:BcFzX_HbVOP4XV-92cdzdAomBz2NkRUrsd7VByMDwAxQ4lMQLmeD5w>
 <xmx:BcFzX8SXyw3OkqSxSx7w_aDiJCLcSykUGQP1GcY1fiDH-3jO4iYQaQ>
 <xmx:BcFzX8x6_ebPsUcsDH9Nmbhrix9vCR9JOqNqVzNgF3WMxXdKkgVy_w>
 <xmx:BcFzX7q9vhsFkW84jUCOWdNKk3kfIeE6wGKh3Vm58h5MMl-KnuB3rbtqke0>
Received: from apples.local (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id 6CAFF328005D;
 Tue, 29 Sep 2020 19:19:32 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 10/14] hw/block/nvme: add the zone management receive
 command
Date: Wed, 30 Sep 2020 01:19:13 +0200
Message-Id: <20200929231917.433586-11-its@irrelevant.dk>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200929231917.433586-1-its@irrelevant.dk>
References: <20200929231917.433586-1-its@irrelevant.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=64.147.123.27; envelope-from=its@irrelevant.dk;
 helo=wnew2-smtp.messagingengine.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/29 17:46:07
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
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
 hw/block/nvme-ns.h    |  11 +++-
 hw/block/nvme.h       |   1 +
 include/block/nvme.h  |  46 ++++++++++++++
 hw/block/nvme-ns.c    |  49 ++++++++++++---
 hw/block/nvme.c       | 135 ++++++++++++++++++++++++++++++++++++++++++
 hw/block/trace-events |   1 +
 6 files changed, 233 insertions(+), 10 deletions(-)

diff --git a/hw/block/nvme-ns.h b/hw/block/nvme-ns.h
index e16f50dc4bb8..82cb0b0bce82 100644
--- a/hw/block/nvme-ns.h
+++ b/hw/block/nvme-ns.h
@@ -37,9 +37,10 @@ typedef struct NvmePstateHeader {
     struct {
         uint64_t zcap;
         uint64_t zsze;
+        uint8_t  zdes;
     } QEMU_PACKED zns;
 
-    uint8_t  rsvd3088[1008];
+    uint8_t  rsvd3089[1007];
 } QEMU_PACKED NvmePstateHeader;
 
 typedef struct NvmeNamespaceParams {
@@ -50,11 +51,13 @@ typedef struct NvmeNamespaceParams {
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
@@ -91,6 +94,7 @@ typedef struct NvmeNamespace {
 
         NvmeZone           *zones;
         NvmeZoneDescriptor *zd;
+        uint8_t            *zde;
     } zns;
 } NvmeNamespace;
 
@@ -183,6 +187,11 @@ static inline void nvme_zs_set(NvmeZone *zone, NvmeZoneState zs)
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
index ba32ea6d1326..bc49c7f2674f 100644
--- a/hw/block/nvme-ns.c
+++ b/hw/block/nvme-ns.c
@@ -86,6 +86,9 @@ static void nvme_ns_zns_init_zones(NvmeNamespace *ns)
 
         zone = &ns->zns.zones[i];
         zone->zd = &ns->zns.zd[i];
+        if (ns->params.zns.zdes) {
+            zone->zde = &ns->zns.zde[i];
+        }
         zone->wp_staging = zslba;
 
         zd = zone->zd;
@@ -106,11 +109,15 @@ static void nvme_ns_init_zoned(NvmeNamespace *ns)
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
@@ -148,7 +155,7 @@ static int nvme_ns_pstate_init(NvmeNamespace *ns, Error **errp)
     BlockBackend *blk = ns->pstate.blk;
     NvmePstateHeader header;
     uint64_t nlbas = nvme_ns_nlbas(ns);
-    size_t bitmap_len, pstate_len, zd_len = 0;
+    size_t bitmap_len, pstate_len, zd_len = 0, zde_len = 0;
     int ret;
 
     ret = nvme_blk_truncate(blk, sizeof(NvmePstateHeader), errp);
@@ -170,6 +177,7 @@ static int nvme_ns_pstate_init(NvmeNamespace *ns, Error **errp)
         header.zns.zsze = ns->params.zns.zsze ?
             cpu_to_le64(ns->params.zns.zsze) :
             cpu_to_le64(pow2ceil(ns->params.zns.zcap));
+        header.zns.zdes = ns->params.zns.zdes;
     }
 
     ret = blk_pwrite(blk, 0, &header, sizeof(header), 0);
@@ -181,9 +189,11 @@ static int nvme_ns_pstate_init(NvmeNamespace *ns, Error **errp)
     bitmap_len = DIV_ROUND_UP(nlbas, sizeof(unsigned long));
     if (nvme_ns_zoned(ns)) {
         zd_len = ns->zns.num_zones * sizeof(NvmeZoneDescriptor);
+        zde_len = nvme_ns_zoned(ns) ?
+            ns->zns.num_zones * nvme_ns_zdes_bytes(ns) : 0;
     }
-    pstate_len = ROUND_UP(sizeof(NvmePstateHeader) + bitmap_len + zd_len,
-                          BDRV_SECTOR_SIZE);
+    pstate_len = ROUND_UP(sizeof(NvmePstateHeader) + bitmap_len + zd_len +
+                          zde_len, BDRV_SECTOR_SIZE);
 
     ret = nvme_blk_truncate(blk, pstate_len, errp);
     if (ret < 0) {
@@ -213,6 +223,7 @@ void nvme_ns_zns_init_zone_state(NvmeNamespace *ns)
     for (int i = 0; i < ns->zns.num_zones; i++) {
         NvmeZone *zone = &ns->zns.zones[i];
         zone->zd = &ns->zns.zd[i];
+        zone->zde = &ns->zns.zde[i];
 
         zone->wp_staging = nvme_wp(zone);
 
@@ -224,7 +235,8 @@ void nvme_ns_zns_init_zone_state(NvmeNamespace *ns)
             continue;
 
         case NVME_ZS_ZSC:
-            if (nvme_wp(zone) == nvme_zslba(zone)) {
+            if (nvme_wp(zone) == nvme_zslba(zone) &&
+                !(zone->zd->za & NVME_ZA_ZDEV)) {
                 nvme_zs_set(zone, NVME_ZS_ZSE);
             }
 
@@ -243,7 +255,7 @@ static int nvme_ns_pstate_load(NvmeNamespace *ns, size_t len, Error **errp)
     BlockBackend *blk = ns->pstate.blk;
     NvmePstateHeader header;
     uint64_t nlbas = nvme_ns_nlbas(ns);
-    size_t bitmap_len, pstate_len, zd_len = 0;
+    size_t bitmap_len, pstate_len, zd_len = 0, zde_len = 0;
     unsigned long *map;
     int ret;
 
@@ -294,12 +306,21 @@ static int nvme_ns_pstate_load(NvmeNamespace *ns, size_t len, Error **errp)
         return -1;
     }
 
+    if (header.zns.zdes != ns->params.zns.zdes) {
+        error_setg(errp, "zns.zdes parameter inconsistent with pstate "
+                   "(pstate %u; parameter %u)",
+                   header.zns.zdes, ns->params.zns.zdes);
+        return -1;
+    }
+
     bitmap_len = DIV_ROUND_UP(nlbas, sizeof(unsigned long));
     if (nvme_ns_zoned(ns)) {
         zd_len = ns->zns.num_zones * sizeof(NvmeZoneDescriptor);
+        zde_len = nvme_ns_zoned(ns) ?
+            ns->zns.num_zones * nvme_ns_zdes_bytes(ns) : 0;
     }
-    pstate_len = ROUND_UP(sizeof(NvmePstateHeader) + bitmap_len + zd_len,
-                          BDRV_SECTOR_SIZE);
+    pstate_len = ROUND_UP(sizeof(NvmePstateHeader) + bitmap_len + zd_len +
+                          zde_len, BDRV_SECTOR_SIZE);
 
     if (len != pstate_len) {
         error_setg(errp, "pstate size mismatch "
@@ -335,10 +356,19 @@ static int nvme_ns_pstate_load(NvmeNamespace *ns, size_t len, Error **errp)
             return ret;
         }
 
+        if (zde_len) {
+            ret = blk_pread(blk, ns->pstate.zns.offset + zd_len, ns->zns.zde,
+                            zde_len);
+            if (ret < 0) {
+                error_setg_errno(errp, -ret, "could not read zone descriptor "
+                                 "extensions from pstate");
+                return ret;
+            }
+        }
+
         nvme_ns_zns_init_zone_state(ns);
 
-        ret = blk_pwrite(blk, ns->pstate.utilization.offset + bitmap_len,
-                         ns->zns.zd, zd_len, 0);
+        ret = blk_pwrite(blk, ns->pstate.zns.offset, ns->zns.zd, zd_len, 0);
         if (ret < 0) {
             error_setg_errno(errp, -ret,
                              "could not write zone descriptors to pstate");
@@ -516,6 +546,7 @@ static Property nvme_ns_props[] = {
     DEFINE_PROP_UINT8("iocs", NvmeNamespace, params.iocs, NVME_IOCS_NVM),
     DEFINE_PROP_UINT64("zns.zcap", NvmeNamespace, params.zns.zcap, 0),
     DEFINE_PROP_UINT64("zns.zsze", NvmeNamespace, params.zns.zsze, 0),
+    DEFINE_PROP_UINT8("zns.zdes", NvmeNamespace, params.zns.zdes, 0),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 0c7d269c1b5a..1e6c57752769 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -163,6 +163,7 @@ static const NvmeEffectsLog nvme_effects[NVME_IOCS_MAX] = {
 
         .iocs = {
             NVME_EFFECTS_NVM_INITIALIZER,
+            [NVME_CMD_ZONE_MGMT_RECV] = NVME_EFFECTS_CSUPP,
         },
     },
 };
@@ -1218,6 +1219,9 @@ static void nvme_rw_cb(void *opaque, int ret)
                 NVME_ZS_ZSRO : NVME_ZS_ZSO;
 
             nvme_zs_set(zone, zs);
+            if (zs == NVME_ZS_ZSO) {
+                NVME_ZA_CLEAR_ALL(zone->zd->za);
+            }
 
             if (nvme_zns_commit_zone(ns, zone) < 0) {
                 req->status = NVME_INTERNAL_DEV_ERROR;
@@ -1286,6 +1290,135 @@ static uint16_t nvme_do_aio(BlockBackend *blk, int64_t offset, size_t len,
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
@@ -1425,6 +1558,8 @@ static uint16_t nvme_io_cmd(NvmeCtrl *n, NvmeRequest *req)
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


