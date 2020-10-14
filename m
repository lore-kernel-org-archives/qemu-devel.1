Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B0E9C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 08:48:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4F402080A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 08:48:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4F402080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37286 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kScS6-0003R6-HN
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 04:48:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37912)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kScNi-0001UU-3u; Wed, 14 Oct 2020 04:43:34 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:60183)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kScNf-0001sd-8k; Wed, 14 Oct 2020 04:43:33 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailnew.nyi.internal (Postfix) with ESMTP id 5F24A58023D;
 Wed, 14 Oct 2020 04:43:28 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute4.internal (MEProxy); Wed, 14 Oct 2020 04:43:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding; s=fm1; bh=rBUUMl53gL6MIRerg91k+fMm11
 EBeKl9WH2WuYUlCz0=; b=UacKeWg7oDdEfDpIIztDxn1rrbbCDjkB4Pu70Z6PPh
 1sXy7i8eQvuo+NO2y426tDrtCQo1hYpQAin7ceT2WCfynST+dVNF3XDvk6+kslff
 jnCW3WhAYu2PYn2kpjQpQOddfpdub+FGByz8ZWNkJ6+BzfHlwaj2Tb+L36pBfCfI
 ZOuebO/2okaN2GBv5M1nJMN/aXipo4V7yuVUlqVzECbvbI6ITNqtq+ljfE3ZxLYu
 L9t7dybeEtHGJ0dLRR1apB2e3Gb0QQVjSmZH/V1OEOCkcFglWDl6CZBVrb7Kzry4
 8EMf0VNweLUbB8sNt2ZAGgzdmXArIJW8uPwCHVRFC/OA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=rBUUMl53gL6MIRerg
 91k+fMm11EBeKl9WH2WuYUlCz0=; b=cqO+8YYSJF1OjbU3obBqDkz0TobC5mQbk
 fT+/PNV4jLae7mn/IQ+FZoszGu3HhQOROPBqG+cPiwzxqrb6UgIa/p25QBEaD8G+
 4SEPdUGxr5hADdxMH3y42DJpEf4JbEixHZ4QOUnCVHuISXBz3VVw8HMjR8IBTRUr
 d0XP+LTrbmJtHtxI4FtzxcCepM2lVVqgggWcLO0GsfXfpUX/6bdPC/nAB/GUoWEg
 Vn0/EDp2rqDSlkJt2iyNH6yV9lNRJeAasrMZnb0fSBCg9IZgDwPfo4Ui6V2TJCFf
 VjrAtGwy4rDrj9RPL79d4OdQKA+B1zlJbF7QJYhZFf8vAKtuxBlGQ==
X-ME-Sender: <xms:LrqGX6LydvkasJfrpwTngv4W5twvP_hN2Vk_BUalpADYx9tLFLcdkA>
 <xme:LrqGXyL38IYwrxDwBTKOeetZD-8ga2kAKi5KozKb9GQrmo7axPEUdsm48giupP-oU
 ZcGIAlMmathX-43rBs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedriedugddtjecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomhepmfhlrghushculfgv
 nhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrthhtvghrnh
 epfeevledvieekudeuffetgeegfeehvdffffejueeuleduhedvgeejveejhfdtteehnecu
 kfhppeektddrudeijedrleekrdduledtnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
 hrrghmpehmrghilhhfrhhomhepihhtshesihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:LrqGX6sdWjkTftBjJZVL6cxyZyomRZU8U1IrqpztTyL7-mW4Ng5LVQ>
 <xmx:LrqGX_avjUosCyVUzHjG3sjGVzictFrkmWpZ9P6oC0hyGgEx2qMZoQ>
 <xmx:LrqGXxa0dtFZf__UrLCLLUB603Nsbi2ymeH6KUwiQKjCHxPNbL3l2A>
 <xmx:L7qGXwUNxe_1IUTQeLjcOFTcxCjZnmyp7kw0uZ8Ksa6K6gF33f8N7w>
Received: from apples.local (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id E25F63280060;
 Wed, 14 Oct 2020 04:43:25 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Subject: [PATCH v2] hw/block/nvme: add dulbe support
Date: Wed, 14 Oct 2020 10:43:24 +0200
Message-Id: <20201014084324.333774-1-its@irrelevant.dk>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=66.111.4.221; envelope-from=its@irrelevant.dk;
 helo=new1-smtp.messagingengine.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/14 04:43:28
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Klaus Jensen <k.jensen@samsung.com>, Max Reitz <mreitz@redhat.com>,
 Klaus Jensen <its@irrelevant.dk>, Keith Busch <kbusch@kernel.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Klaus Jensen <k.jensen@samsung.com>

This adds support for reporting the Deallocated or Unwritten Logical
Block error (DULBE).

Rely on the block status reported by the block layer. Here, we consider
blocks with the BDRV_BLOCK_ZERO status to deallocated. This is because a
pdiscard or write zeroes with unmap won't result in the block having the
BDRV_BLOCK_ALLOCATED status removed in all cases, but the
BDRV_BLOCK_ZERO status will most likely be set.

This works best with the raw driver and 4K LBAs since holes can then be
punched on a block basis. For a qcow2 backing file, the cluster size is
far larger and block will only be marked with BDRV_BLOCK_ZERO if a full
cluster is zeroes or discarded. This is consistent with the spec since
Write Zeroes "should" deallocate the block if the Deallocate attribute
is set and "may" deallocate if the Deallocate attribute is not set.
Here, we always try to unmap (discard) the block and it may or may not
succeed.

While DSM is not implemented yet, the "advisory" nature of it would also
allow this behavior to be consistent with the spec.

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
v2: rely on bdrv_block_status instead of bitmap tracking (Keith).
---
 hw/block/nvme-ns.h   |  4 +++
 include/block/nvme.h |  5 +++
 hw/block/nvme-ns.c   |  4 +++
 hw/block/nvme.c      | 73 ++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 86 insertions(+)

diff --git a/hw/block/nvme-ns.h b/hw/block/nvme-ns.h
index 83734f4606e1..44bf6271b744 100644
--- a/hw/block/nvme-ns.h
+++ b/hw/block/nvme-ns.h
@@ -31,6 +31,10 @@ typedef struct NvmeNamespace {
     NvmeIdNs     id_ns;
 
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
index 31c80cdf5b5f..475c6fe44084 100644
--- a/hw/block/nvme-ns.c
+++ b/hw/block/nvme-ns.c
@@ -44,6 +44,9 @@ static void nvme_ns_init(NvmeNamespace *ns)
     /* no thin provisioning */
     id_ns->ncap = id_ns->nsze;
     id_ns->nuse = id_ns->ncap;
+
+    /* support DULBE */
+    id_ns->nsfeat |= 0x4;
 }
 
 static int nvme_ns_init_blk(NvmeCtrl *n, NvmeNamespace *ns, Error **errp)
@@ -92,6 +95,7 @@ int nvme_ns_setup(NvmeCtrl *n, NvmeNamespace *ns, Error **errp)
     }
 
     nvme_ns_init(ns);
+
     if (nvme_register_namespace(n, ns, errp)) {
         return -1;
     }
diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 9d30ca69dcf1..b4f47448575b 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -105,6 +105,7 @@ static const bool nvme_feature_support[NVME_FID_MAX] = {
 
 static const uint32_t nvme_feature_cap[NVME_FID_MAX] = {
     [NVME_TEMPERATURE_THRESHOLD]    = NVME_FEAT_CAP_CHANGE,
+    [NVME_ERROR_RECOVERY]           = NVME_FEAT_CAP_CHANGE | NVME_FEAT_CAP_NS,
     [NVME_VOLATILE_WRITE_CACHE]     = NVME_FEAT_CAP_CHANGE,
     [NVME_NUMBER_OF_QUEUES]         = NVME_FEAT_CAP_CHANGE,
     [NVME_ASYNCHRONOUS_EVENT_CONF]  = NVME_FEAT_CAP_CHANGE,
@@ -888,6 +889,36 @@ static inline uint16_t nvme_check_bounds(NvmeCtrl *n, NvmeNamespace *ns,
     return NVME_SUCCESS;
 }
 
+static uint16_t nvme_check_dulbe(NvmeNamespace *ns, uint64_t slba,
+                                 uint32_t nlb)
+{
+    BlockDriverState *bs = blk_bs(ns->blkconf.blk);
+
+    int64_t pnum = 0, bytes = nvme_l2b(ns, nlb);
+    int64_t offset = nvme_l2b(ns, slba);
+    int ret;
+
+    /*
+     * `pnum` holds the number of bytes after offset that shares the same
+     * allocation status as the byte at offset. If `pnum` is different from
+     * `bytes`, we should check the allocation status of the next range and
+     * continue this until all bytes have been checked.
+     */
+    do {
+        bytes -= pnum;
+
+        ret = bdrv_block_status(bs, offset, bytes, &pnum, NULL, NULL);
+
+        if (!(ret & BDRV_BLOCK_ALLOCATED) || ret & BDRV_BLOCK_ZERO) {
+            return NVME_DULB;
+        }
+
+        offset += pnum;
+    } while (pnum != bytes);
+
+    return NVME_SUCCESS;
+}
+
 static void nvme_rw_cb(void *opaque, int ret)
 {
     NvmeRequest *req = opaque;
@@ -995,6 +1026,15 @@ static uint16_t nvme_rw(NvmeCtrl *n, NvmeRequest *req)
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
@@ -1645,6 +1685,7 @@ static uint16_t nvme_get_feature(NvmeCtrl *n, NvmeRequest *req)
     uint8_t fid = NVME_GETSETFEAT_FID(dw10);
     NvmeGetFeatureSelect sel = NVME_GETFEAT_SELECT(dw10);
     uint16_t iv;
+    NvmeNamespace *ns;
 
     static const uint32_t nvme_feature_default[NVME_FID_MAX] = {
         [NVME_ARBITRATION] = NVME_ARB_AB_NOLIMIT,
@@ -1707,6 +1748,18 @@ static uint16_t nvme_get_feature(NvmeCtrl *n, NvmeRequest *req)
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
@@ -1846,6 +1899,26 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeRequest *req)
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
-- 
2.28.0


