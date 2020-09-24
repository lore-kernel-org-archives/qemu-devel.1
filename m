Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88453C4363D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 20:58:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 395022399A
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 20:58:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 395022399A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33404 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLYKN-0003rk-Vy
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 16:58:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38744)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kLY7u-0004oS-57; Thu, 24 Sep 2020 16:46:05 -0400
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:57013)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kLY7p-0007nc-EB; Thu, 24 Sep 2020 16:46:01 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
 by mailnew.nyi.internal (Postfix) with ESMTP id AF1A8580510;
 Thu, 24 Sep 2020 16:45:35 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute7.internal (MEProxy); Thu, 24 Sep 2020 16:45:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm1; bh=jJX1S5EFJOtee
 HHyJzPlCusHlpDaqRHoENFD4XbGnPA=; b=hXz3+vJAX81aNeTIt/DyfGQMrW8jU
 0sykkaLTRyJJguUaddj6DdJgySLA99pk/990deqhQ1FQkU5TPoD5Xprtoaa5HeKx
 wFgklJnMF5YkZTPC829CwNI2gYMmamVAgs9XVI/wVRwGDkdq0dgdw+mRjIC+Riul
 03xbbS7UG/lC9thye1XYCqpzLTTZe5fZZj1F9WoalZ9kjd5dycmlB5gwC8LOr6V6
 agNfT7WmrmLskSAu0vDZKmM9hwb1uDHb7NbnoOLm6WbFYAc7U9jan6nfiGYRHjTB
 NfI24iJuoHRDPm3Vo5DofVDkenDtfWhVoEMbpcUT4HAL5crsAzttoJgKQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm3; bh=jJX1S5EFJOteeHHyJzPlCusHlpDaqRHoENFD4XbGnPA=; b=afnq3BG6
 Be/ntPoXLTtPOwq7cRgEv2TOzu0NInNFXpVwbKKwjNBwywwYCEzgX2z4Ca4l69pX
 i9UbGFdjUlMkH8ETJuEbdenWiO7hhv+I+lGgTe7UCku79HYvPD2LZ02mYjH5ruHK
 qS49fiqyKk4qH83XERhYGMyfuBfv/e1BzLjCC+dfwz+L8+A7EeWD5Sd78BosJt+E
 6Bdd7ixO+lsAVEnQ194nnZURqAYtyQZPrRc7ZqMRDM4tm33LAloRAc1yJZp9IlZu
 miEsmJFUuz0gCvAxvvFRrVkFV6ORp3Cneg1ZBMA1ZS+E6b73AE3hLupJFbsq5OSb
 t9IYMKmI/muTrw==
X-ME-Sender: <xms:bwVtX5xYm40U_1F6DgFagPDLVTrzo_sGOvF3rNWd3LEZW7x3NrQrvA>
 <xme:bwVtX5T-hhw7ZOT0UtZhddWTCgiO1NzqufjS603Sz-yAxialPKC5KzUKzTFfrq_Dn
 iVnqO-UYtFImk19HsY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudekgdduheduucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefmlhgruhhs
 ucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrghtth
 gvrhhnpeeuleetgeeiuefhgfekfefgveejiefgteekiedtgfdtieefhfdthfefueffvefg
 keenucfkphepkedtrdduieejrdelkedrudeltdenucevlhhushhtvghrufhiiigvpeejne
 curfgrrhgrmhepmhgrihhlfhhrohhmpehithhssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:bwVtXzW1A25IXaOmw69iLE18-kYKF3B_EHAYgb-koz2QnT64VRV29Q>
 <xmx:bwVtX7gxIXT4F11HKTJ51NeiPd3VV9dJPHQTwBiN6h8ANM2FnoADAQ>
 <xmx:bwVtX7A_sebRosQxDAYJ1NMUbX1-ZTMMte0qWycavV98FAMxQVNk2Q>
 <xmx:bwVtX251l0zKGfDQB68SUqpXy9By26LQPtlxUcAMsWCG8qI5r-eygQ>
Received: from apples.local (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id D4800306467D;
 Thu, 24 Sep 2020 16:45:33 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Subject: [PATCH 12/16] hw/block/nvme: add the zone append command
Date: Thu, 24 Sep 2020 22:45:12 +0200
Message-Id: <20200924204516.1881843-13-its@irrelevant.dk>
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

Add the Zone Append command.

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/block/nvme.h       |  6 +++++
 include/block/nvme.h  |  7 ++++++
 hw/block/nvme.c       | 52 +++++++++++++++++++++++++++++++++++++++++--
 hw/block/trace-events |  1 +
 4 files changed, 64 insertions(+), 2 deletions(-)

diff --git a/hw/block/nvme.h b/hw/block/nvme.h
index c704663e0a3e..8cd2d936548e 100644
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
@@ -41,6 +45,7 @@ static inline bool nvme_req_is_write(NvmeRequest *req)
     switch (req->cmd.opcode) {
     case NVME_CMD_WRITE:
     case NVME_CMD_WRITE_ZEROES:
+    case NVME_CMD_ZONE_APPEND:
         return true;
     default:
         return false;
@@ -73,6 +78,7 @@ static inline const char *nvme_io_opc_str(uint8_t opc)
     case NVME_CMD_WRITE_ZEROES:     return "NVME_NVM_CMD_WRITE_ZEROES";
     case NVME_CMD_ZONE_MGMT_SEND:   return "NVME_ZONED_CMD_ZONE_MGMT_SEND";
     case NVME_CMD_ZONE_MGMT_RECV:   return "NVME_ZONED_CMD_ZONE_MGMT_RECV";
+    case NVME_CMD_ZONE_APPEND:      return "NVME_ZONED_CMD_ZONE_APPEND";
     default:                        return "NVME_NVM_CMD_UNKNOWN";
     }
 }
diff --git a/include/block/nvme.h b/include/block/nvme.h
index 967b42eb5da7..5f8914f594f4 100644
--- a/include/block/nvme.h
+++ b/include/block/nvme.h
@@ -483,6 +483,7 @@ enum NvmeIoCommands {
     NVME_CMD_DSM                = 0x09,
     NVME_CMD_ZONE_MGMT_SEND     = 0x79,
     NVME_CMD_ZONE_MGMT_RECV     = 0x7a,
+    NVME_CMD_ZONE_APPEND        = 0x7d,
 };
 
 typedef struct QEMU_PACKED NvmeDeleteQ {
@@ -1018,6 +1019,11 @@ enum NvmeIdCtrlLpa {
     NVME_LPA_EXTENDED = 1 << 2,
 };
 
+typedef struct QEMU_PACKED NvmeIdCtrlZns {
+    uint8_t zasl;
+    uint8_t rsvd1[4095];
+} NvmeIdCtrlZns;
+
 #define NVME_CTRL_SQES_MIN(sqes) ((sqes) & 0xf)
 #define NVME_CTRL_SQES_MAX(sqes) (((sqes) >> 4) & 0xf)
 #define NVME_CTRL_CQES_MIN(cqes) ((cqes) & 0xf)
@@ -1242,6 +1248,7 @@ static inline void _nvme_check_size(void)
     QEMU_BUILD_BUG_ON(sizeof(NvmeFwSlotInfoLog) != 512);
     QEMU_BUILD_BUG_ON(sizeof(NvmeSmartLog) != 512);
     QEMU_BUILD_BUG_ON(sizeof(NvmeIdCtrl) != 4096);
+    QEMU_BUILD_BUG_ON(sizeof(NvmeIdCtrlZns) != 4096);
     QEMU_BUILD_BUG_ON(sizeof(NvmeIdNsNvm) != 4096);
     QEMU_BUILD_BUG_ON(sizeof(NvmeIdNsZns) != 4096);
     QEMU_BUILD_BUG_ON(sizeof(NvmeSglDescriptor) != 16);
diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 51611ed32600..294bc2fb719d 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -166,6 +166,8 @@ static const NvmeEffectsLog nvme_effects[NVME_IOCS_MAX] = {
             [NVME_CMD_ZONE_MGMT_RECV] = NVME_EFFECTS_CSUPP,
             [NVME_CMD_ZONE_MGMT_SEND] = NVME_EFFECTS_CSUPP |
                                         NVME_EFFECTS_LBCC,
+            [NVME_CMD_ZONE_APPEND]    = NVME_EFFECTS_CSUPP |
+                                        NVME_EFFECTS_LBCC,
         },
     },
 };
@@ -1041,6 +1043,21 @@ static inline uint16_t nvme_check_mdts(NvmeCtrl *n, size_t len)
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
@@ -1393,6 +1410,7 @@ static uint16_t nvme_do_aio(BlockBackend *blk, int64_t offset, size_t len,
         break;
 
     case NVME_CMD_WRITE:
+    case NVME_CMD_ZONE_APPEND:
         is_write = true;
 
         /* fallthrough */
@@ -1928,7 +1946,7 @@ static uint16_t nvme_rwz(NvmeCtrl *n, NvmeRequest *req)
     uint32_t nlb = (uint32_t)le16_to_cpu(rw->nlb) + 1;
     size_t len = nvme_l2b(ns, nlb);
 
-    bool is_write = nvme_req_is_write(req);
+    bool is_append, is_write = nvme_req_is_write(req);
     uint16_t status;
 
     trace_pci_nvme_rwz(nvme_cid(req), nvme_io_opc_str(rw->opcode),
@@ -1942,6 +1960,25 @@ static uint16_t nvme_rwz(NvmeCtrl *n, NvmeRequest *req)
             goto invalid;
         }
 
+        if (req->cmd.opcode == NVME_CMD_ZONE_APPEND) {
+            is_append = true;
+            uint64_t wp = zone->wp_staging;
+
+            if (slba != nvme_zslba(zone)) {
+                trace_pci_nvme_err_invalid_zslba(nvme_cid(req), slba);
+                return NVME_INVALID_FIELD | NVME_DNR;
+            }
+
+            status = nvme_check_zasl(n, len);
+            if (status) {
+                trace_pci_nvme_err_zasl(nvme_cid(req), len);
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
@@ -1980,7 +2017,7 @@ static uint16_t nvme_rwz(NvmeCtrl *n, NvmeRequest *req)
 
     if (is_write) {
         if (zone) {
-            if (zone->wp_staging != nvme_wp(zone)) {
+            if (!is_append && (zone->wp_staging != nvme_wp(zone))) {
                 trace_pci_nvme_err_zone_pending_writes(nvme_cid(req),
                                                        nvme_zslba(zone),
                                                        nvme_wp(zone),
@@ -2052,6 +2089,7 @@ static uint16_t nvme_io_cmd(NvmeCtrl *n, NvmeRequest *req)
     case NVME_CMD_WRITE_ZEROES:
     case NVME_CMD_WRITE:
     case NVME_CMD_READ:
+    case NVME_CMD_ZONE_APPEND:
         return nvme_rwz(n, req);
     case NVME_CMD_ZONE_MGMT_SEND:
         return nvme_zone_mgmt_send(n, req);
@@ -3718,6 +3756,11 @@ static void nvme_check_constraints(NvmeCtrl *n, Error **errp)
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
@@ -3894,12 +3937,16 @@ static void nvme_init_pci(NvmeCtrl *n, PCIDevice *pci_dev, Error **errp)
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
@@ -4036,6 +4083,7 @@ static Property nvme_props[] = {
     DEFINE_PROP_UINT32("aer_max_queued", NvmeCtrl, params.aer_max_queued, 64),
     DEFINE_PROP_UINT8("mdts", NvmeCtrl, params.mdts, 7),
     DEFINE_PROP_BOOL("use-intel-id", NvmeCtrl, params.use_intel_id, false),
+    DEFINE_PROP_UINT8("zns.zasl", NvmeCtrl, params.zns.zasl, 0),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/hw/block/trace-events b/hw/block/trace-events
index d6342f5c555d..929409b79b41 100644
--- a/hw/block/trace-events
+++ b/hw/block/trace-events
@@ -103,6 +103,7 @@ pci_nvme_mmio_shutdown_cleared(void) "shutdown bit cleared"
 
 # nvme traces for error conditions
 pci_nvme_err_mdts(uint16_t cid, size_t len) "cid %"PRIu16" len %zu"
+pci_nvme_err_zasl(uint16_t cid, size_t len) "cid %"PRIu16" len %zu"
 pci_nvme_err_req_status(uint16_t cid, uint32_t nsid, uint16_t status, uint8_t opc) "cid %"PRIu16" nsid %"PRIu32" status 0x%"PRIx16" opc 0x%"PRIx8""
 pci_nvme_err_dulbe(uint16_t cid, uint64_t slba, uint32_t nlb) "cid %"PRIu16" slba 0x%"PRIx64" nlb %"PRIu32""
 pci_nvme_err_addr_read(uint64_t addr) "addr 0x%"PRIx64""
-- 
2.28.0


