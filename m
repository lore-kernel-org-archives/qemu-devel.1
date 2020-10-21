Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87A8CC4363A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 22:27:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC0F32415A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 22:27:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC0F32415A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36856 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVMaA-00037E-IA
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 18:27:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59604)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kVMQX-000783-QK; Wed, 21 Oct 2020 18:17:49 -0400
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:43085)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kVMQS-00005F-QL; Wed, 21 Oct 2020 18:17:49 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.west.internal (Postfix) with ESMTP id E6C5E1271;
 Wed, 21 Oct 2020 18:17:42 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute4.internal (MEProxy); Wed, 21 Oct 2020 18:17:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm1; bh=ZWQHY5Y48T/9O
 mgwmOQypu6MRb7rFjILZY4fwf+4zJA=; b=HTMyv/v+WyLLLV0EeqsE6WrDoktw0
 YqFwxL/0jSuRAbPz0Pa2hma+PRakTZ2KEV5RSL96nsgdi7cTkWxU+88ujOIiHy7w
 aHQzxx0wrVeNoDmaI1ORJcmzFR47WHn1Und6nbfOTEyrrTxhkVlU+aeTtOpoeLhb
 Vu7Xd7Xpe8hp7RL3ZMEr+7ZPNSbbX89KF8pVL+i/bcoQyA8WgsTZ1KhNjwsFcSTv
 0D/+aiFf7Ss32ijQJrCXF3sxnLezOK8c7D61mlUNphTYkkmkBT70nj3b73GGKukv
 p7RH7FMbpw4zaEOYz+RkKl+QO1lro4mHyqmPZSxkH+jK7a+gaILEwWZLQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm1; bh=ZWQHY5Y48T/9OmgwmOQypu6MRb7rFjILZY4fwf+4zJA=; b=KNg7DsMi
 Weh7sGjuaXfwRBjdCOYkBZZJu8htTJhH7voYJykB2iulEq1/akNVcO3swpqAC1x1
 X/4hT5+N31iwl2yLtqr3CXr5IGAYe4RAS1G4Rbeh14S6lhpEOegtu2zX4oNicB47
 dQovgIQtrMBAN3DXE4UOxLM2KzFpr1WYbGBihVc+BHGwx5KhR9/BuD281Dil8owk
 ofIzYBwkj0rbHuPzgQGopCakZNr/fIkVCf50paLOjPhRI6T3fvfhrzmiD0+JZEmy
 kmW+pd8ZnI5Y4GmVVO/ONFQJvxH9Nm4YEtxRbsMuymmzNHqDd8g9Ij5DEPfOL3o9
 8bPqkyrDOggwrw==
X-ME-Sender: <xms:hrOQX1dZe70PjkCto9DdYcgcg5fGkNTnDK-M72vpbDEcCkORWFf-nQ>
 <xme:hrOQXzNQ85VIrSefxv4iYzgSLg1nohPiPGwcTPysi7niHfOx5q7XfJyn2ESlVQz9O
 zwCOXQAY1bBDiMdfoA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrjeeigddtiecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepmfhlrghushcu
 lfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrthhtvg
 hrnhepueelteegieeuhffgkeefgfevjeeigfetkeeitdfgtdeifefhtdfhfeeuffevgfek
 necukfhppeektddrudeijedrleekrdduledtnecuvehluhhsthgvrhfuihiivgepudenuc
 frrghrrghmpehmrghilhhfrhhomhepihhtshesihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:hrOQX-hPC5NkT-iK1vgOG-mHt-SvJWXKIgBUxy8qL2OfD0kZ2S-l9Q>
 <xmx:hrOQX-_hXuSIbkhRZWG6G2PsiYG16eDyvFgZw3OodBrJ7Z6A5FA4pw>
 <xmx:hrOQXxux-kHlI94NoLvJDSguL3i19vJdqc0FjkEErcPq5eJotfmBWg>
 <xmx:hrOQX7I62WjBHB5nfJ58ZZYt72U3UvkVSJN6o1uOG7hyIny_Jg1lVA>
Received: from apples.local (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id 671F0306467D;
 Wed, 21 Oct 2020 18:17:41 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 2/2] hw/block/nvme: add the dataset management command
Date: Thu, 22 Oct 2020 00:17:36 +0200
Message-Id: <20201021221736.100779-3-its@irrelevant.dk>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201021221736.100779-1-its@irrelevant.dk>
References: <20201021221736.100779-1-its@irrelevant.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=64.147.123.21; envelope-from=its@irrelevant.dk;
 helo=wout5-smtp.messagingengine.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/21 18:17:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
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
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Klaus Jensen <k.jensen@samsung.com>

Add support for the Dataset Management command and the Deallocate
attribute. Deallocation results in discards being sent to the underlying
block device. Whether of not the blocks are actually deallocated is
affected by the same factors as Write Zeroes (see previous commit).

     format | discard | dsm (512b)  dsm (4kb)  dsm (64kb)
    ------------------------------------------------------
      qcow2    ignore   n           n          n
      qcow2    unmap    n           n          y
      raw      ignore   n           n          n
      raw      unmap    n           y          y

Again, a raw format and 4kb LBAs are preferable.

See NVM Express 1.3d, Section 6.7 ("Dataset Management command").

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/block/nvme.h |  2 +
 hw/block/nvme.c | 99 ++++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 100 insertions(+), 1 deletion(-)

diff --git a/hw/block/nvme.h b/hw/block/nvme.h
index e080a2318a50..574333caa3f9 100644
--- a/hw/block/nvme.h
+++ b/hw/block/nvme.h
@@ -28,6 +28,7 @@ typedef struct NvmeRequest {
     struct NvmeNamespace    *ns;
     BlockAIOCB              *aiocb;
     uint16_t                status;
+    void                    *opaque;
     NvmeCqe                 cqe;
     NvmeCmd                 cmd;
     BlockAcctCookie         acct;
@@ -60,6 +61,7 @@ static inline const char *nvme_io_opc_str(uint8_t opc)
     case NVME_CMD_WRITE:            return "NVME_NVM_CMD_WRITE";
     case NVME_CMD_READ:             return "NVME_NVM_CMD_READ";
     case NVME_CMD_WRITE_ZEROES:     return "NVME_NVM_CMD_WRITE_ZEROES";
+    case NVME_CMD_DSM:              return "NVME_NVM_CMD_DSM";
     default:                        return "NVME_NVM_CMD_UNKNOWN";
     }
 }
diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 1758cfed965c..a6dd8ae8e220 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -959,6 +959,101 @@ static void nvme_rw_cb(void *opaque, int ret)
     nvme_enqueue_req_completion(nvme_cq(req), req);
 }
 
+static void nvme_aio_discard_cb(void *opaque, int ret)
+{
+    NvmeRequest *req = opaque;
+    int *discards = req->opaque;
+
+    trace_pci_nvme_aio_discard_cb(nvme_cid(req));
+
+    if (ret) {
+        req->status = NVME_INTERNAL_DEV_ERROR;
+        trace_pci_nvme_err_aio(nvme_cid(req), strerror(ret),
+                               req->status);
+    }
+
+    if (discards && --(*discards) > 0) {
+        return;
+    }
+
+    g_free(req->opaque);
+    req->opaque = NULL;
+
+    nvme_enqueue_req_completion(nvme_cq(req), req);
+}
+
+static uint16_t nvme_dsm(NvmeCtrl *n, NvmeRequest *req)
+{
+    NvmeNamespace *ns = req->ns;
+    NvmeDsmCmd *dsm = (NvmeDsmCmd *) &req->cmd;
+    NvmeDsmRange *range = NULL;
+    int *discards = NULL;
+
+    uint32_t attr = le32_to_cpu(dsm->attributes);
+    uint32_t nr = (le32_to_cpu(dsm->nr) & 0xff) + 1;
+
+    uint16_t status = NVME_SUCCESS;
+
+    trace_pci_nvme_dsm(nvme_cid(req), nvme_nsid(ns), nr, attr);
+
+    if (attr & NVME_DSMGMT_AD) {
+        int64_t offset;
+        size_t len;
+
+        range = g_new(NvmeDsmRange, nr);
+
+        status = nvme_dma(n, (uint8_t *)range, nr * sizeof(NvmeDsmRange),
+                          DMA_DIRECTION_TO_DEVICE, req);
+        if (status) {
+            goto out;
+        }
+
+        discards = g_new0(int, 1);
+        req->opaque = discards;
+
+        for (int i = 0; i < nr; i++) {
+            uint64_t slba = le64_to_cpu(range[i].slba);
+            uint32_t nlb = le32_to_cpu(range[i].nlb);
+
+            if (nvme_check_bounds(n, ns, slba, nlb)) {
+                trace_pci_nvme_err_invalid_lba_range(slba, nlb,
+                                                     ns->id_ns.nsze);
+                continue;
+            }
+
+            trace_pci_nvme_dsm_deallocate(nvme_cid(req), nvme_nsid(ns), slba,
+                                          nlb);
+
+            offset = nvme_l2b(ns, slba);
+            len = nvme_l2b(ns, nlb);
+
+            while (len) {
+                size_t bytes = MIN(BDRV_REQUEST_MAX_BYTES, len);
+
+                blk_aio_pdiscard(ns->blkconf.blk, offset, bytes,
+                                 nvme_aio_discard_cb, req);
+
+                (*discards)++;
+
+                offset += bytes;
+                len -= bytes;
+            }
+        }
+
+        if (*discards) {
+            status = NVME_NO_COMPLETE;
+        } else {
+            g_free(discards);
+            req->opaque = NULL;
+        }
+    }
+
+out:
+    g_free(range);
+
+    return status;
+}
+
 static uint16_t nvme_flush(NvmeCtrl *n, NvmeRequest *req)
 {
     block_acct_start(blk_get_stats(req->ns->blkconf.blk), &req->acct, 0,
@@ -1088,6 +1183,8 @@ static uint16_t nvme_io_cmd(NvmeCtrl *n, NvmeRequest *req)
     case NVME_CMD_WRITE:
     case NVME_CMD_READ:
         return nvme_rw(n, req);
+    case NVME_CMD_DSM:
+        return nvme_dsm(n, req);
     default:
         trace_pci_nvme_err_invalid_opc(req->cmd.opcode);
         return NVME_INVALID_OPCODE | NVME_DNR;
@@ -2810,7 +2907,7 @@ static void nvme_init_ctrl(NvmeCtrl *n, PCIDevice *pci_dev)
     id->cqes = (0x4 << 4) | 0x4;
     id->nn = cpu_to_le32(n->num_namespaces);
     id->oncs = cpu_to_le16(NVME_ONCS_WRITE_ZEROES | NVME_ONCS_TIMESTAMP |
-                           NVME_ONCS_FEATURES);
+                           NVME_ONCS_FEATURES | NVME_ONCS_DSM);
 
     id->vwc = 0x1;
     id->sgls = cpu_to_le32(NVME_CTRL_SGLS_SUPPORT_NO_ALIGN |
-- 
2.28.0


