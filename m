Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36519C433E7
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 11:53:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6515220848
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 11:53:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6515220848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43812 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSfLF-0007nM-Sz
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 07:53:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45388)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kSf0O-0003IH-GW; Wed, 14 Oct 2020 07:31:40 -0400
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:50849)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kSf0M-0006ad-5R; Wed, 14 Oct 2020 07:31:40 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailnew.nyi.internal (Postfix) with ESMTP id F0CF9580305;
 Wed, 14 Oct 2020 07:31:36 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute4.internal (MEProxy); Wed, 14 Oct 2020 07:31:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm1; bh=j+/vggxd/oMEg
 t1OV2/4ICDw5596Kcso6Bfe/BQ/RCY=; b=N18hKPyF/aS2bVsYO63vWQRwyAjqO
 kKJEYn8HumWJOZ/pYNXHIWBmVo/0OxbAQLAEpGc82GIgDSxMvMAKk77+P/wr2Vxy
 TNMo04X+vrGN9LfkqdPviw/g8RuTvriH2t3d9t5/9Zx4C7cuEyEQh06QU7G7CZ+m
 RbUid+JWT+HCiPOk5C+B4JMeTB/n/Lx8T8uWzP8cFSJF5JrkxRbLk1a87faJOfsY
 08M9hN23wcXbExuNQ4qG2PBSYoCrR6vJtKqX3zfEwclIbBu1Z5D+XcpCdIFGD06P
 DPENVnO9Sjt4dVkWhudeWtA5upHUai30E5mErA1HowljDb/yKS1fIFEYQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm1; bh=j+/vggxd/oMEgt1OV2/4ICDw5596Kcso6Bfe/BQ/RCY=; b=l62vxpbT
 yAaHvQ8VV7kdrp0xxiIPYffFvjWWwIuGhhEUE4aXUHy+2FALTF4ZQlP6kJmenwP2
 rQo+EcPo2aGpEMbNiNZQdGbTdcynB0FzNBrsSk7Wtjm6VkQZ0x43qCMbd0951ZDj
 whd5mfoynykPE9etq1fGtknWpGnf5147F2VrHyycXQ/64NmC5IGbgOV447KLhL+2
 wAT0PQjfVpGkJu80iT2zeL8ARmGlUkAWvgQ9KVeLs1SZURgtl6uVv9K67he1AqVV
 SLRBKxW8phkHDpcZuEg98X7j0fAVqwydn2YDXDbbzWm9Ijr7zRgzyLbvUaXax/0s
 /kwTA7QCB0bPOQ==
X-ME-Sender: <xms:mOGGX-88OMBpbl_9Fhdx2fxjmwz0mu29pUVycMvIqUkcKSBo11IKWA>
 <xme:mOGGX-vH-hSprauAucROu0STCuzLTx4f-PrAyn_fwSi3hLdASV_vTNg6v_FRUrQko
 UA2MosPuhiC7cexy98>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedriedugdegudcutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepmfhlrghushcu
 lfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrthhtvg
 hrnhepjeefjeejjeffleefuefhffdtvdfggedujedvvdfftddvhfegjeekheeuhfejjeeu
 necuffhomhgrihhnpehrvghsohhurhgtvghsrdgrtghtihhvvgdprhgvshhouhhrtggvsh
 drohhpvghnnecukfhppeektddrudeijedrleekrdduledtnecuvehluhhsthgvrhfuihii
 vgeptdenucfrrghrrghmpehmrghilhhfrhhomhepihhtshesihhrrhgvlhgvvhgrnhhtrd
 gukh
X-ME-Proxy: <xmx:mOGGX0CZaEzcYUB57TBwlQiAIHT08FEHZPlbeNqBxFPpVw4uCAqgeg>
 <xmx:mOGGX2csHI7n7sDcfyyhhoJpzumNaIR7atS_vJzxig1hljhh7CCxAg>
 <xmx:mOGGXzM2G0_LuU186vqTB4rCry8nhCVByjr9I2_fwbZmlPY6lk2dZw>
 <xmx:mOGGX_C7eibp1eBrHuUspHN9W19fWjucyFZJ8vZxfQQmsNXv1Ke91w>
Received: from apples.local (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id 7179F3064674;
 Wed, 14 Oct 2020 07:31:35 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 8/9] hw/block/nvme: track and enforce zone resources
Date: Wed, 14 Oct 2020 13:31:21 +0200
Message-Id: <20201014113122.388849-9-its@irrelevant.dk>
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

Track number of open/active resources.

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 docs/specs/nvme.txt  |  6 ++++
 hw/block/nvme-ns.h   |  7 +++++
 include/block/nvme.h |  2 ++
 hw/block/nvme-ns.c   | 25 +++++++++++++++--
 hw/block/nvme.c      | 66 +++++++++++++++++++++++++++++++++++++++++++-
 5 files changed, 102 insertions(+), 4 deletions(-)

diff --git a/docs/specs/nvme.txt b/docs/specs/nvme.txt
index 80cb34406255..03bb4d9516b4 100644
--- a/docs/specs/nvme.txt
+++ b/docs/specs/nvme.txt
@@ -14,6 +14,12 @@ The nvme device (-device nvme) emulates an NVM Express Controller.
      zns.zcap; if the zone capacity is a power of two, the zone size will be
      set to that, otherwise it will default to the next power of two.
 
+  `zns.mar`; Specifies the number of active resources available. This is a 0s
+     based value.
+
+  `zns.mor`; Specifies the number of open resources available. This is a 0s
+     based value.
+
 
 Reference Specifications
 ------------------------
diff --git a/hw/block/nvme-ns.h b/hw/block/nvme-ns.h
index a273e7f7ed4b..3d0269eef6f0 100644
--- a/hw/block/nvme-ns.h
+++ b/hw/block/nvme-ns.h
@@ -28,6 +28,8 @@ typedef struct NvmeNamespaceParams {
         uint64_t zcap;
         uint64_t zsze;
         uint8_t  zdes;
+        uint32_t mar;
+        uint32_t mor;
     } zns;
 } NvmeNamespaceParams;
 
@@ -58,6 +60,11 @@ typedef struct NvmeNamespace {
         NvmeZone           *zones;
         NvmeZoneDescriptor *zd;
         uint8_t            *zde;
+
+        struct {
+            uint32_t open;
+            uint32_t active;
+        } resources;
     } zns;
 } NvmeNamespace;
 
diff --git a/include/block/nvme.h b/include/block/nvme.h
index aecefefd43b6..4ca5f3fb15eb 100644
--- a/include/block/nvme.h
+++ b/include/block/nvme.h
@@ -775,6 +775,8 @@ enum NvmeStatusCodes {
     NVME_ZONE_IS_READ_ONLY      = 0x01ba,
     NVME_ZONE_IS_OFFLINE        = 0x01bb,
     NVME_ZONE_INVALID_WRITE     = 0x01bc,
+    NVME_TOO_MANY_ACTIVE_ZONES  = 0x01bd,
+    NVME_TOO_MANY_OPEN_ZONES    = 0x01be,
     NVME_INVALID_ZONE_STATE_TRANSITION = 0x01bf,
     NVME_WRITE_FAULT            = 0x0280,
     NVME_UNRECOVERED_READ       = 0x0281,
diff --git a/hw/block/nvme-ns.c b/hw/block/nvme-ns.c
index 0922b67dd6d8..a01cc5eeb445 100644
--- a/hw/block/nvme-ns.c
+++ b/hw/block/nvme-ns.c
@@ -92,8 +92,8 @@ static void nvme_ns_init_zoned(NvmeNamespace *ns)
         ns->zns.zde = g_malloc0_n(ns->zns.num_zones, nvme_ns_zdes_bytes(ns));
     }
 
-    id_ns_zns->mar = 0xffffffff;
-    id_ns_zns->mor = 0xffffffff;
+    id_ns_zns->mar = cpu_to_le32(ns->params.zns.mar);
+    id_ns_zns->mor = cpu_to_le32(ns->params.zns.mor);
 }
 
 static void nvme_ns_init(NvmeNamespace *ns)
@@ -130,6 +130,11 @@ static void nvme_ns_init(NvmeNamespace *ns)
 
 void nvme_ns_zns_init_zone_state(NvmeNamespace *ns)
 {
+    ns->zns.resources.active = ns->params.zns.mar != 0xffffffff ?
+        ns->params.zns.mar + 1 : ns->zns.num_zones;
+    ns->zns.resources.open = ns->params.zns.mor != 0xffffffff ?
+        ns->params.zns.mor + 1 : ns->zns.num_zones;
+
     for (int i = 0; i < ns->zns.num_zones; i++) {
         NvmeZone *zone = &ns->zns.zones[i];
         zone->zd = &ns->zns.zd[i];
@@ -148,9 +153,15 @@ void nvme_ns_zns_init_zone_state(NvmeNamespace *ns)
             if (nvme_wp(zone) == nvme_zslba(zone) &&
                 !(zone->zd->za & NVME_ZA_ZDEV)) {
                 nvme_zs_set(zone, NVME_ZS_ZSE);
+                break;
             }
 
-            break;
+            if (ns->zns.resources.active) {
+                ns->zns.resources.active--;
+                break;
+            }
+
+            /* fallthrough */
 
         case NVME_ZS_ZSIO:
         case NVME_ZS_ZSEO:
@@ -207,6 +218,12 @@ static int nvme_ns_check_constraints(NvmeNamespace *ns, Error **errp)
             return -1;
         }
 
+        if (ns->params.zns.mor > ns->params.zns.mar) {
+            error_setg(errp, "maximum open resources (zns.mor) must be less "
+                       "than or equal to maximum active resources (zns.mar)");
+            return -1;
+        }
+
         break;
 
     default:
@@ -272,6 +289,8 @@ static Property nvme_ns_props[] = {
     DEFINE_PROP_UINT64("zns.zcap", NvmeNamespace, params.zns.zcap, 0),
     DEFINE_PROP_UINT64("zns.zsze", NvmeNamespace, params.zns.zsze, 0),
     DEFINE_PROP_UINT8("zns.zdes", NvmeNamespace, params.zns.zdes, 0),
+    DEFINE_PROP_UINT32("zns.mar", NvmeNamespace, params.zns.mar, 0xffffffff),
+    DEFINE_PROP_UINT32("zns.mor", NvmeNamespace, params.zns.mor, 0xffffffff),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 947554c48b35..cc637b3a68e9 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -1119,6 +1119,40 @@ static uint16_t nvme_zrm_transition(NvmeNamespace *ns, NvmeZone *zone,
 
     switch (from) {
     case NVME_ZS_ZSE:
+        switch (to) {
+        case NVME_ZS_ZSF:
+        case NVME_ZS_ZSRO:
+        case NVME_ZS_ZSO:
+            break;
+
+        case NVME_ZS_ZSC:
+            if (!ns->zns.resources.active) {
+                return NVME_TOO_MANY_ACTIVE_ZONES;
+            }
+
+            ns->zns.resources.active--;
+
+            break;
+
+        case NVME_ZS_ZSIO:
+        case NVME_ZS_ZSEO:
+            if (!ns->zns.resources.active) {
+                return NVME_TOO_MANY_ACTIVE_ZONES;
+            }
+
+            if (!ns->zns.resources.open) {
+                return NVME_TOO_MANY_OPEN_ZONES;
+            }
+
+            ns->zns.resources.active--;
+            ns->zns.resources.open--;
+
+            break;
+
+        default:
+            return NVME_INVALID_ZONE_STATE_TRANSITION | NVME_DNR;
+        }
+
         break;
 
     case NVME_ZS_ZSIO:
@@ -1137,7 +1171,13 @@ static uint16_t nvme_zrm_transition(NvmeNamespace *ns, NvmeZone *zone,
         case NVME_ZS_ZSEO:
         case NVME_ZS_ZSF:
         case NVME_ZS_ZSRO:
+            ns->zns.resources.active++;
+
+            /* fallthrough */
+
         case NVME_ZS_ZSC:
+            ns->zns.resources.open++;
+
             break;
 
         default:
@@ -1160,8 +1200,18 @@ static uint16_t nvme_zrm_transition(NvmeNamespace *ns, NvmeZone *zone,
 
         case NVME_ZS_ZSF:
         case NVME_ZS_ZSRO:
+            ns->zns.resources.active++;
+
+            break;
+
         case NVME_ZS_ZSIO:
         case NVME_ZS_ZSEO:
+            if (!ns->zns.resources.open) {
+                return NVME_TOO_MANY_OPEN_ZONES;
+            }
+
+            ns->zns.resources.open--;
+
             break;
 
         default:
@@ -1492,7 +1542,7 @@ static uint16_t nvme_zone_mgmt_send_all(NvmeCtrl *n, NvmeRequest *req)
     NvmeZoneManagementSendCmd *send = (NvmeZoneManagementSendCmd *) &req->cmd;
     NvmeNamespace *ns = req->ns;
     NvmeZone *zone;
-    int *countp = NULL;
+    int count, *countp = NULL;
     uint16_t status = NVME_SUCCESS;
 
     trace_pci_nvme_zone_mgmt_send_all(nvme_cid(req), nvme_nsid(ns), send->zsa);
@@ -1541,6 +1591,20 @@ static uint16_t nvme_zone_mgmt_send_all(NvmeCtrl *n, NvmeRequest *req)
         break;
 
     case NVME_CMD_ZONE_MGMT_SEND_OPEN:
+        count = 0;
+
+        for (int i = 0; i < ns->zns.num_zones; i++) {
+            zone = &ns->zns.zones[i];
+
+            if (nvme_zs(zone) == NVME_ZS_ZSC) {
+                count++;
+            }
+        }
+
+        if (count > ns->zns.resources.open) {
+            return NVME_TOO_MANY_OPEN_ZONES;
+        }
+
         for (int i = 0; i < ns->zns.num_zones; i++) {
             zone = &ns->zns.zones[i];
 
-- 
2.28.0


