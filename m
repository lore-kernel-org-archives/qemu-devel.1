Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7787C433E7
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 19:14:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E30F720E65
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 19:14:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E30F720E65
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49636 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSPki-0000w8-JV
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 15:14:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33748)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kSPfL-0005pD-N3; Tue, 13 Oct 2020 15:08:56 -0400
Received: from wnew4-smtp.messagingengine.com ([64.147.123.18]:53897)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kSPfJ-0005yO-0w; Tue, 13 Oct 2020 15:08:55 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailnew.west.internal (Postfix) with ESMTP id 5446EAFE;
 Tue, 13 Oct 2020 15:08:50 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute4.internal (MEProxy); Tue, 13 Oct 2020 15:08:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding; s=fm1; bh=lph34Y6i5P6gEjnalHg7A5kTvY
 P+CPCWWvqsWL3bDhM=; b=E0RyBZU2Y2nENHzjuNUBo4DZBNkfH0yOWpY2vijCNF
 MaN0Daq7LC6x4fXNIpl/tQ7+CKw15EasXBDgH6m7y5s04T8M8z/wq35EorTU75Sa
 jfzC3UxQqX7p6DfAqGJLqTLsXGo8sgUJSShmWlwVvS+lrlYpkCccSx5PV7vzpnQN
 W0IWFtv2VmQHV9anWd/pab5dvHRtHVUAkb3WpruLyWU1DYxT3Ln1qNLOPAxHz/Hm
 pQDOgjrAOpGqd1wPmn+aqBLHGOjg3YDa+nLGsfKZNFy4iE1ZyejcqaE5k7zO/HYt
 zweUWwkyV1ymGPEa8ctpkYklqqd5vNSJxhCfOkNm2Ecw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=lph34Y6i5P6gEjnal
 Hg7A5kTvYP+CPCWWvqsWL3bDhM=; b=OiNLozwyRaYyX4BjkXEm93SWP5ndrx3rE
 cTulS6IC/tnGWaFBP0qpy+dn7/Roig2HGUVBbe7u7gmfZ1kXxoYFiM3avb0ijIOI
 eNnpIu672hfks4/RLuzkjszx0EXdlEL7ejXryZarFuFfqaMiPxTQe94rBn6YCeMm
 t5IjHWhQ2BSlJj/DWbG1qDGBTUu6l0xbTF0FWms1gHj58VKY8Dprt8UbretmEtz3
 ka9ElM1g0OsAQcKXIVSL756F+zQgkWNsXu16uCNh25vEuQ7DpUpr6FARmr624E9c
 h6VLduNU127Tz6x/y9QDcWiXrUJWPcBKQ++G2QbsD22+hz9kTs61A==
X-ME-Sender: <xms:QPuFX_fIorl4bb5eqQ3RPMLVrmgHS6aysln52YMbjSie4H04beoWOw>
 <xme:QPuFX1OXhwhDcZbDzFTen8YxUB7_brthWKqS1Qzlx5MnrCet0Jxbgsik1IT7yRk6l
 yGNsBjWYVzz33ljiOw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrheelgddufeehucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefmlhgruhhsucfl
 vghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrghtthgvrh
 hnpefffeetleelhfdvuedtteelffevtdejhffhiefffeffhfehudevfefgteejkeegteen
 ucffohhmrghinhepuhhtihhlihiirghtihhonhdrmhgrphenucfkphepkedtrdduieejrd
 elkedrudeltdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhr
 ohhmpehithhssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:QPuFX4hYlOUG9sYyVHJRal1M-rW-jsd237mGQjAZmXSDKWdez83i7A>
 <xmx:QPuFXw9O99nPi7upPHMkRRsVs5zpOE7vfk4bHoVC0Zcc8e-sWRma2g>
 <xmx:QPuFX7t6hTLc7zZOQqtQj6Wu1EoggtE4Ox3iGba4nuQ_eC21paexbQ>
 <xmx:QfuFX1LhFW-jhRjgWIjoLvuppWK2_z-O4-d-fYrTP1hKvvwL2OY7LQsVu7c>
Received: from apples.local (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id 837F53280069;
 Tue, 13 Oct 2020 15:08:47 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Subject: [PATCH] hw/block/nvme: add block utilization tracking
Date: Tue, 13 Oct 2020 21:08:46 +0200
Message-Id: <20201013190846.260841-1-its@irrelevant.dk>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=64.147.123.18; envelope-from=its@irrelevant.dk;
 helo=wnew4-smtp.messagingengine.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/13 15:08:51
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Klaus Jensen <k.jensen@samsung.com>, Max Reitz <mreitz@redhat.com>,
 Klaus Jensen <its@irrelevant.dk>, Keith Busch <kbusch@kernel.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Klaus Jensen <k.jensen@samsung.com>

This adds support for reporting the Deallocated or Unwritten Logical
Block error (DULBE). This requires tracking the allocated/deallocated
status of all logical blocks.

Introduce a bitmap that does this. The bitmap is always intialized to
all ones (aka, all blocks are allocated) on boot up. Blocks can then be
specifically deallocated using Write Zeroes. This ensures that we can
always guarantee zeroes to be returned from deallocated blocks.

When the device gains support for persistent state, the intention is to
remove the "allocated by default" behavior.

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/block/nvme-ns.h    | 10 ++++++
 include/block/nvme.h  |  5 +++
 hw/block/nvme-ns.c    | 10 ++++++
 hw/block/nvme.c       | 81 +++++++++++++++++++++++++++++++++++++++++++
 hw/block/trace-events |  2 ++
 5 files changed, 108 insertions(+)

diff --git a/hw/block/nvme-ns.h b/hw/block/nvme-ns.h
index 83734f4606e1..e91a83e2a03f 100644
--- a/hw/block/nvme-ns.h
+++ b/hw/block/nvme-ns.h
@@ -30,7 +30,17 @@ typedef struct NvmeNamespace {
     int64_t      size;
     NvmeIdNs     id_ns;
 
+    struct {
+        struct {
+            unsigned long *map;
+        } utilization;
+    } state;
+
     NvmeNamespaceParams params;
+
+    struct {
+        uint32_t err_rec;
+    } features;
 } NvmeNamespace;
 
 static inline uint32_t nvme_nsid(NvmeNamespace *ns)
diff --git a/include/block/nvme.h b/include/block/nvme.h
index 6de2d5aa75a9..2249d77c2129 100644
--- a/include/block/nvme.h
+++ b/include/block/nvme.h
@@ -686,6 +686,7 @@ enum NvmeStatusCodes {
     NVME_E2E_REF_ERROR          = 0x0284,
     NVME_CMP_FAILURE            = 0x0285,
     NVME_ACCESS_DENIED          = 0x0286,
+    NVME_DULB                   = 0x0287,
     NVME_MORE                   = 0x2000,
     NVME_DNR                    = 0x4000,
     NVME_NO_COMPLETE            = 0xffff,
@@ -902,6 +903,9 @@ enum NvmeIdCtrlLpa {
 #define NVME_AEC_NS_ATTR(aec)       ((aec >> 8) & 0x1)
 #define NVME_AEC_FW_ACTIVATION(aec) ((aec >> 9) & 0x1)
 
+#define NVME_ERR_REC_TLER(err_rec)  (err_rec & 0xffff)
+#define NVME_ERR_REC_DULBE(err_rec) (err_rec & 0x10000)
+
 enum NvmeFeatureIds {
     NVME_ARBITRATION                = 0x1,
     NVME_POWER_MANAGEMENT           = 0x2,
@@ -1022,6 +1026,7 @@ enum NvmeNsIdentifierType {
 
 
 #define NVME_ID_NS_NSFEAT_THIN(nsfeat)      ((nsfeat & 0x1))
+#define NVME_ID_NS_NSFEAT_DULBE(nsfeat)     ((nsfeat >> 2) & 0x1)
 #define NVME_ID_NS_FLBAS_EXTENDED(flbas)    ((flbas >> 4) & 0x1)
 #define NVME_ID_NS_FLBAS_INDEX(flbas)       ((flbas & 0xf))
 #define NVME_ID_NS_MC_SEPARATE(mc)          ((mc >> 1) & 0x1)
diff --git a/hw/block/nvme-ns.c b/hw/block/nvme-ns.c
index b69cdaf27e43..b221fe02cd13 100644
--- a/hw/block/nvme-ns.c
+++ b/hw/block/nvme-ns.c
@@ -47,6 +47,9 @@ static void nvme_ns_init(NvmeNamespace *ns)
 
     lba_index = NVME_ID_NS_FLBAS_INDEX(ns->id_ns.flbas);
     ns->id_ns.lbaf[lba_index].ds = 31 - clz32(ns->blkconf.logical_block_size);
+
+    /* support DULBE */
+    id_ns->nsfeat |= 0x4;
 }
 
 static int nvme_ns_init_blk(NvmeCtrl *n, NvmeNamespace *ns, Error **errp)
@@ -86,6 +89,8 @@ static int nvme_ns_check_constraints(NvmeNamespace *ns, Error **errp)
 
 int nvme_ns_setup(NvmeCtrl *n, NvmeNamespace *ns, Error **errp)
 {
+    uint64_t nlbas;
+
     if (nvme_ns_check_constraints(ns, errp)) {
         return -1;
     }
@@ -95,6 +100,11 @@ int nvme_ns_setup(NvmeCtrl *n, NvmeNamespace *ns, Error **errp)
     }
 
     nvme_ns_init(ns);
+
+    nlbas = nvme_ns_nlbas(ns);
+    ns->state.utilization.map = bitmap_new(nlbas);
+    bitmap_fill(ns->state.utilization.map, nlbas);
+
     if (nvme_register_namespace(n, ns, errp)) {
         return -1;
     }
diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 9d30ca69dcf1..b0cf328f8f2e 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -105,6 +105,7 @@ static const bool nvme_feature_support[NVME_FID_MAX] = {
 
 static const uint32_t nvme_feature_cap[NVME_FID_MAX] = {
     [NVME_TEMPERATURE_THRESHOLD]    = NVME_FEAT_CAP_CHANGE,
+    [NVME_ERROR_RECOVERY]           = NVME_FEAT_CAP_CHANGE | NVME_FEAT_CAP_NS,
     [NVME_VOLATILE_WRITE_CACHE]     = NVME_FEAT_CAP_CHANGE,
     [NVME_NUMBER_OF_QUEUES]         = NVME_FEAT_CAP_CHANGE,
     [NVME_ASYNCHRONOUS_EVENT_CONF]  = NVME_FEAT_CAP_CHANGE,
@@ -888,6 +889,38 @@ static inline uint16_t nvme_check_bounds(NvmeCtrl *n, NvmeNamespace *ns,
     return NVME_SUCCESS;
 }
 
+static inline uint16_t nvme_check_dulbe(NvmeNamespace *ns, uint64_t slba,
+                                        uint32_t nlb)
+{
+    uint64_t elba = slba + nlb;
+
+    if (find_next_zero_bit(ns->state.utilization.map, elba, slba) < elba) {
+        return NVME_DULB;
+    }
+
+    return NVME_SUCCESS;
+}
+
+static inline void nvme_allocate(NvmeNamespace *ns, uint64_t slba,
+                                 uint32_t nlb)
+{
+    if (!nvme_check_dulbe(ns, slba, nlb)) {
+        return;
+    }
+
+    trace_pci_nvme_allocate(nvme_nsid(ns), slba, nlb);
+
+    bitmap_set(ns->state.utilization.map, slba, nlb);
+}
+
+static inline void nvme_deallocate(NvmeNamespace *ns, uint64_t slba,
+                                   uint32_t nlb)
+{
+    trace_pci_nvme_deallocate(nvme_nsid(ns), slba, nlb);
+
+    bitmap_clear(ns->state.utilization.map, slba, nlb);
+}
+
 static void nvme_rw_cb(void *opaque, int ret)
 {
     NvmeRequest *req = opaque;
@@ -959,6 +992,8 @@ static uint16_t nvme_write_zeroes(NvmeCtrl *n, NvmeRequest *req)
         return status;
     }
 
+    nvme_deallocate(ns, slba, nlb);
+
     block_acct_start(blk_get_stats(req->ns->blkconf.blk), &req->acct, 0,
                      BLOCK_ACCT_WRITE);
     req->aiocb = blk_aio_pwrite_zeroes(req->ns->blkconf.blk, offset, count,
@@ -995,11 +1030,24 @@ static uint16_t nvme_rw(NvmeCtrl *n, NvmeRequest *req)
         goto invalid;
     }
 
+    if (acct == BLOCK_ACCT_READ) {
+        if (NVME_ERR_REC_DULBE(ns->features.err_rec)) {
+            status = nvme_check_dulbe(ns, slba, nlb);
+            if (status) {
+                goto invalid;
+            }
+        }
+    }
+
     status = nvme_map_dptr(n, data_size, req);
     if (status) {
         goto invalid;
     }
 
+    if (acct == BLOCK_ACCT_WRITE) {
+        nvme_allocate(ns, slba, nlb);
+    }
+
     block_acct_start(blk_get_stats(blk), &req->acct, data_size, acct);
     if (req->qsg.sg) {
         if (acct == BLOCK_ACCT_WRITE) {
@@ -1645,6 +1693,7 @@ static uint16_t nvme_get_feature(NvmeCtrl *n, NvmeRequest *req)
     uint8_t fid = NVME_GETSETFEAT_FID(dw10);
     NvmeGetFeatureSelect sel = NVME_GETFEAT_SELECT(dw10);
     uint16_t iv;
+    NvmeNamespace *ns;
 
     static const uint32_t nvme_feature_default[NVME_FID_MAX] = {
         [NVME_ARBITRATION] = NVME_ARB_AB_NOLIMIT,
@@ -1707,6 +1756,18 @@ static uint16_t nvme_get_feature(NvmeCtrl *n, NvmeRequest *req)
         }
 
         return NVME_INVALID_FIELD | NVME_DNR;
+    case NVME_ERROR_RECOVERY:
+        if (!nvme_nsid_valid(n, nsid)) {
+            return NVME_INVALID_NSID | NVME_DNR;
+        }
+
+        ns = nvme_ns(n, nsid);
+        if (unlikely(!ns)) {
+            return NVME_INVALID_FIELD | NVME_DNR;
+        }
+
+        result = ns->features.err_rec;
+        goto out;
     case NVME_VOLATILE_WRITE_CACHE:
         result = n->features.vwc;
         trace_pci_nvme_getfeat_vwcache(result ? "enabled" : "disabled");
@@ -1846,6 +1907,26 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeRequest *req)
                                NVME_LOG_SMART_INFO);
         }
 
+        break;
+    case NVME_ERROR_RECOVERY:
+        if (nsid == NVME_NSID_BROADCAST) {
+            for (int i = 1; i <= n->num_namespaces; i++) {
+                ns = nvme_ns(n, i);
+
+                if (!ns) {
+                    continue;
+                }
+
+                if (NVME_ID_NS_NSFEAT_DULBE(ns->id_ns.nsfeat)) {
+                    ns->features.err_rec = dw11;
+                }
+            }
+
+            break;
+        }
+
+        assert(ns);
+        ns->features.err_rec = dw11;
         break;
     case NVME_VOLATILE_WRITE_CACHE:
         n->features.vwc = dw11 & 0x1;
diff --git a/hw/block/trace-events b/hw/block/trace-events
index cab9913b1f2d..f8d1d4f952f1 100644
--- a/hw/block/trace-events
+++ b/hw/block/trace-events
@@ -43,6 +43,8 @@ pci_nvme_admin_cmd(uint16_t cid, uint16_t sqid, uint8_t opcode, const char *opna
 pci_nvme_rw(uint16_t cid, const char *verb, uint32_t nsid, uint32_t nlb, uint64_t count, uint64_t lba) "cid %"PRIu16" opname '%s' nsid %"PRIu32" nlb %"PRIu32" count %"PRIu64" lba 0x%"PRIx64""
 pci_nvme_rw_cb(uint16_t cid, const char *blkname) "cid %"PRIu16" blk '%s'"
 pci_nvme_write_zeroes(uint16_t cid, uint32_t nsid, uint64_t slba, uint32_t nlb) "cid %"PRIu16" nsid %"PRIu32" slba %"PRIu64" nlb %"PRIu32""
+pci_nvme_allocate(uint32_t ns, uint64_t slba, uint32_t nlb) "nsid %"PRIu32" slba 0x%"PRIx64" nlb %"PRIu32""
+pci_nvme_deallocate(uint32_t ns, uint64_t slba, uint32_t nlb) "nsid %"PRIu32" slba 0x%"PRIx64" nlb %"PRIu32""
 pci_nvme_create_sq(uint64_t addr, uint16_t sqid, uint16_t cqid, uint16_t qsize, uint16_t qflags) "create submission queue, addr=0x%"PRIx64", sqid=%"PRIu16", cqid=%"PRIu16", qsize=%"PRIu16", qflags=%"PRIu16""
 pci_nvme_create_cq(uint64_t addr, uint16_t cqid, uint16_t vector, uint16_t size, uint16_t qflags, int ien) "create completion queue, addr=0x%"PRIx64", cqid=%"PRIu16", vector=%"PRIu16", qsize=%"PRIu16", qflags=%"PRIu16", ien=%d"
 pci_nvme_del_sq(uint16_t qid) "deleting submission queue sqid=%"PRIu16""
-- 
2.28.0


