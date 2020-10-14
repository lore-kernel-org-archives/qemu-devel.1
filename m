Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CE2FC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 11:42:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0B7D206CA
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 11:42:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0B7D206CA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57482 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSfAq-00017g-0b
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 07:42:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45382)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kSf0O-0003Hu-82; Wed, 14 Oct 2020 07:31:40 -0400
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:53405)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kSf0K-0006aG-GM; Wed, 14 Oct 2020 07:31:39 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailnew.nyi.internal (Postfix) with ESMTP id 9444D5802A4;
 Wed, 14 Oct 2020 07:31:35 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute4.internal (MEProxy); Wed, 14 Oct 2020 07:31:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm1; bh=qgTx0al2689cq
 flW72CmA9wziFW1NxGqtdd9cbDYS1k=; b=nrF4YB5NmSbn1QNocGlwv2P719LDk
 U3GqzyfIZk4jYCHQzV+9qt3j8AK3+kv6x2cYX9wnaMoC67LNxBnlyjA00xDacPi8
 l7x2/jnvjIeAunjOiiWTg8OzPH+Gml9IZwP0Ls2EN2PGHyJsMixybVUiSZLsWyTU
 u2AFi9UK72DS+O9uJCgUdOu0jSGyhtCirwy5QX33g5w+ewdDeksGFGAfG4ZrVrI+
 ifkCrLRFq/+FzXpJ4tWdaDQI4nB6kAUrLYs82CTl7vad/Fy7YRwQarb6D8Yw+ecF
 TZEARZgliUz4sn2lw858IX6HS8H2UnLxzoONTOHXN/9CYodv4Hrrh1REQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm1; bh=qgTx0al2689cqflW72CmA9wziFW1NxGqtdd9cbDYS1k=; b=VG8x+j0b
 QArePR3NEtg+0jg1vtA7wJjdDx5tuQA6xxTGMDcFNA2UgzRhlmumR5+uF4kpHVG3
 zkyafRUq81PwZWIz1rTAfbvQAbLGw3DP4bFr7dBoluE8riKOKqaCp3eliyl4ItPz
 APV4VCfj2S9Fh7NGev7Bk570m3I5YAj2XHrL1lewWsMzdxPFQUjMhI9MNoK8NJfZ
 scj3ObtkMwtuSs8PlI7TS58BvRTjiDG/RKEFYdVuG/Gm61CtOIlNktTnM9Ykb7tg
 pRYT2xBtm7OjJMOabIj58kNPazLJ6flAsxNb2JfvKpr0rdDtG9lK6Jqucnnrhtcn
 +IgW1LuPOS1fnA==
X-ME-Sender: <xms:l-GGX5LNMlzmGiHVRUENKThgp3vLwG0MDTN2dXxX9V9UZgmfHeq9IA>
 <xme:l-GGX1LP4EwX9pARrodHuR5lGtQk4jVY7UlkjGKtP4feZ_8ZLFWxNH5Ur0gdDahFh
 QbxyxQdDC-ePxX7zMI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedriedugdegudcutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepmfhlrghushcu
 lfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrthhtvg
 hrnhepueelteegieeuhffgkeefgfevjeeigfetkeeitdfgtdeifefhtdfhfeeuffevgfek
 necukfhppeektddrudeijedrleekrdduledtnecuvehluhhsthgvrhfuihiivgepfeenuc
 frrghrrghmpehmrghilhhfrhhomhepihhtshesihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:l-GGXxtK9OhsQ-ZDhprWSgkRADEWVXunJLLeRt6AYvo7SDwucQASUg>
 <xmx:l-GGX6Y7X6o45ld79fd8kURQQs6yxpD7iXOCjdoeiHHb6gLNZM_ptA>
 <xmx:l-GGXwZOb0eKl9SID7nHhR3p7YUXYw7TAtMwsfYvhWDd--X46oeYHw>
 <xmx:l-GGX1O7FmBMSuppm9oqdzZ-vtTzhqqYKyF84kchasCeujtpXjeIzg>
Received: from apples.local (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id 144553064610;
 Wed, 14 Oct 2020 07:31:33 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 7/9] hw/block/nvme: add the zone append command
Date: Wed, 14 Oct 2020 13:31:20 +0200
Message-Id: <20201014113122.388849-8-its@irrelevant.dk>
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

Add the Zone Append command.

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/block/nvme.h       |  6 ++++++
 include/block/nvme.h  |  7 +++++++
 hw/block/nvme.c       | 46 +++++++++++++++++++++++++++++++++++++++++++
 hw/block/trace-events |  1 +
 4 files changed, 60 insertions(+)

diff --git a/hw/block/nvme.h b/hw/block/nvme.h
index 658f15bb5fd1..de128e9bb174 100644
--- a/hw/block/nvme.h
+++ b/hw/block/nvme.h
@@ -16,6 +16,10 @@ typedef struct NvmeParams {
     uint32_t aer_max_queued;
     uint8_t  mdts;
     bool     use_intel_id;
+
+    struct {
+        uint8_t zasl;
+    } zns;
 } NvmeParams;
 
 typedef struct NvmeAsyncEvent {
@@ -42,6 +46,7 @@ static inline bool nvme_req_is_write(NvmeRequest *req)
     switch (req->cmd.opcode) {
     case NVME_CMD_WRITE:
     case NVME_CMD_WRITE_ZEROES:
+    case NVME_CMD_ZONE_APPEND:
         return true;
     default:
         return false;
@@ -74,6 +79,7 @@ static inline const char *nvme_io_opc_str(uint8_t opc)
     case NVME_CMD_WRITE_ZEROES:     return "NVME_NVM_CMD_WRITE_ZEROES";
     case NVME_CMD_ZONE_MGMT_SEND:   return "NVME_ZONED_CMD_ZONE_MGMT_SEND";
     case NVME_CMD_ZONE_MGMT_RECV:   return "NVME_ZONED_CMD_ZONE_MGMT_RECV";
+    case NVME_CMD_ZONE_APPEND:      return "NVME_ZONED_CMD_ZONE_APPEND";
     default:                        return "NVME_NVM_CMD_UNKNOWN";
     }
 }
diff --git a/include/block/nvme.h b/include/block/nvme.h
index 4181d0068edb..aecefefd43b6 100644
--- a/include/block/nvme.h
+++ b/include/block/nvme.h
@@ -482,6 +482,7 @@ enum NvmeIoCommands {
     NVME_CMD_DSM                = 0x09,
     NVME_CMD_ZONE_MGMT_SEND     = 0x79,
     NVME_CMD_ZONE_MGMT_RECV     = 0x7a,
+    NVME_CMD_ZONE_APPEND        = 0x7d,
 };
 
 typedef struct QEMU_PACKED NvmeDeleteQ {
@@ -1016,6 +1017,11 @@ enum NvmeIdCtrlLpa {
     NVME_LPA_EXTENDED     = 1 << 2,
 };
 
+typedef struct QEMU_PACKED NvmeIdCtrlZns {
+    uint8_t zasl;
+    uint8_t rsvd1[4095];
+} NvmeIdCtrlZns;
+
 #define NVME_CTRL_SQES_MIN(sqes) ((sqes) & 0xf)
 #define NVME_CTRL_SQES_MAX(sqes) (((sqes) >> 4) & 0xf)
 #define NVME_CTRL_CQES_MIN(cqes) ((cqes) & 0xf)
@@ -1240,6 +1246,7 @@ static inline void _nvme_check_size(void)
     QEMU_BUILD_BUG_ON(sizeof(NvmeFwSlotInfoLog) != 512);
     QEMU_BUILD_BUG_ON(sizeof(NvmeSmartLog) != 512);
     QEMU_BUILD_BUG_ON(sizeof(NvmeIdCtrl) != 4096);
+    QEMU_BUILD_BUG_ON(sizeof(NvmeIdCtrlZns) != 4096);
     QEMU_BUILD_BUG_ON(sizeof(NvmeIdNsNvm) != 4096);
     QEMU_BUILD_BUG_ON(sizeof(NvmeIdNsZns) != 4096);
     QEMU_BUILD_BUG_ON(sizeof(NvmeSglDescriptor) != 16);
diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index e02c89b1496b..947554c48b35 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -165,6 +165,8 @@ static const NvmeEffectsLog nvme_effects[NVME_IOCS_MAX] = {
             [NVME_CMD_ZONE_MGMT_RECV] = NVME_EFFECTS_CSUPP,
             [NVME_CMD_ZONE_MGMT_SEND] = NVME_EFFECTS_CSUPP |
                                         NVME_EFFECTS_LBCC,
+            [NVME_CMD_ZONE_APPEND]    = NVME_EFFECTS_CSUPP |
+                                        NVME_EFFECTS_LBCC,
         },
     },
 };
@@ -1040,6 +1042,21 @@ static inline uint16_t nvme_check_mdts(NvmeCtrl *n, size_t len)
     return NVME_SUCCESS;
 }
 
+static inline uint16_t nvme_check_zasl(NvmeCtrl *n, size_t len)
+{
+    uint8_t zasl = n->params.zns.zasl;
+
+    if (!zasl) {
+        return nvme_check_mdts(n, len);
+    }
+
+    if (len > n->page_size << zasl) {
+        return NVME_INVALID_FIELD | NVME_DNR;
+    }
+
+    return NVME_SUCCESS;
+}
+
 static inline uint16_t nvme_check_bounds(NvmeCtrl *n, NvmeNamespace *ns,
                                          uint64_t slba, uint32_t nlb)
 {
@@ -1848,6 +1865,24 @@ static uint16_t nvme_rw(NvmeCtrl *n, NvmeRequest *req)
         zone = nvme_ns_zone(ns, slba);
         assert(zone);
 
+        if (req->cmd.opcode == NVME_CMD_ZONE_APPEND) {
+            uint64_t wp = zone->wp_staging;
+
+            if (slba != nvme_zslba(zone)) {
+                trace_pci_nvme_err_invalid_zslba(nvme_cid(req), slba);
+                return NVME_INVALID_FIELD | NVME_DNR;
+            }
+
+            status = nvme_check_zasl(n, data_size);
+            if (status) {
+                trace_pci_nvme_err_zasl(nvme_cid(req), data_size);
+                goto invalid;
+            }
+
+            slba = wp;
+            rw->slba = req->cqe.qw0 = cpu_to_le64(wp);
+        }
+
         status = nvme_check_zone(n, slba, nlb, req, zone);
         if (status) {
             goto invalid;
@@ -1942,6 +1977,7 @@ static uint16_t nvme_io_cmd(NvmeCtrl *n, NvmeRequest *req)
         return nvme_write_zeroes(n, req);
     case NVME_CMD_WRITE:
     case NVME_CMD_READ:
+    case NVME_CMD_ZONE_APPEND:
         return nvme_rw(n, req);
     case NVME_CMD_ZONE_MGMT_SEND:
         return nvme_zone_mgmt_send(n, req);
@@ -3635,6 +3671,11 @@ static void nvme_check_constraints(NvmeCtrl *n, Error **errp)
         return;
     }
 
+    if (params->zns.zasl && params->zns.zasl > params->mdts) {
+        error_setg(errp, "zns.zasl must be less than or equal to mdts");
+        return;
+    }
+
     if (!n->params.cmb_size_mb && n->pmrdev) {
         if (host_memory_backend_is_mapped(n->pmrdev)) {
             error_setg(errp, "can't use already busy memdev: %s",
@@ -3812,12 +3853,16 @@ static void nvme_init_pci(NvmeCtrl *n, PCIDevice *pci_dev, Error **errp)
 static void nvme_init_ctrl(NvmeCtrl *n, PCIDevice *pci_dev)
 {
     NvmeIdCtrl *id = &n->id_ctrl;
+    NvmeIdCtrlZns *id_zns;
     uint8_t *pci_conf = pci_dev->config;
     char *subnqn;
 
     n->id_ctrl_iocss[NVME_IOCS_NVM] = g_new0(NvmeIdCtrl, 1);
     n->id_ctrl_iocss[NVME_IOCS_ZONED] = g_new0(NvmeIdCtrl, 1);
 
+    id_zns = n->id_ctrl_iocss[NVME_IOCS_ZONED];
+    id_zns->zasl = n->params.zns.zasl;
+
     id->vid = cpu_to_le16(pci_get_word(pci_conf + PCI_VENDOR_ID));
     id->ssvid = cpu_to_le16(pci_get_word(pci_conf + PCI_SUBSYSTEM_VENDOR_ID));
     strpadcpy((char *)id->mn, sizeof(id->mn), "QEMU NVMe Ctrl", ' ');
@@ -3955,6 +4000,7 @@ static Property nvme_props[] = {
     DEFINE_PROP_UINT32("aer_max_queued", NvmeCtrl, params.aer_max_queued, 64),
     DEFINE_PROP_UINT8("mdts", NvmeCtrl, params.mdts, 7),
     DEFINE_PROP_BOOL("use-intel-id", NvmeCtrl, params.use_intel_id, false),
+    DEFINE_PROP_UINT8("zns.zasl", NvmeCtrl, params.zns.zasl, 0),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/hw/block/trace-events b/hw/block/trace-events
index bc3e10f298d2..2363412a9375 100644
--- a/hw/block/trace-events
+++ b/hw/block/trace-events
@@ -102,6 +102,7 @@ pci_nvme_mmio_shutdown_cleared(void) "shutdown bit cleared"
 
 # nvme traces for error conditions
 pci_nvme_err_mdts(uint16_t cid, size_t len) "cid %"PRIu16" len %zu"
+pci_nvme_err_zasl(uint16_t cid, size_t len) "cid %"PRIu16" len %zu"
 pci_nvme_err_req_status(uint16_t cid, uint32_t nsid, uint16_t status, uint8_t opc) "cid %"PRIu16" nsid %"PRIu32" status 0x%"PRIx16" opc 0x%"PRIx8""
 pci_nvme_err_addr_read(uint64_t addr) "addr 0x%"PRIx64""
 pci_nvme_err_addr_write(uint64_t addr) "addr 0x%"PRIx64""
-- 
2.28.0


