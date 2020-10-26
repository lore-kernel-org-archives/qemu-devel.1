Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02E61C2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 06:06:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 488CC206A1
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 06:06:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 488CC206A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47274 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kWvdz-00055S-U9
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 02:06:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48662)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kWvZD-0002z0-VH; Mon, 26 Oct 2020 02:01:16 -0400
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:42833)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kWvZB-0000H8-If; Mon, 26 Oct 2020 02:01:15 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.west.internal (Postfix) with ESMTP id B9754D75;
 Mon, 26 Oct 2020 02:01:11 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute4.internal (MEProxy); Mon, 26 Oct 2020 02:01:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm1; bh=b7LQ34RL0ieHO
 3ZCZ6lcdLgVPcAPnqY+tlrvFfXUnHM=; b=1tATV1ldvkOc5PnzanM6HrxsotkH6
 O1cq5cfaTGTwNahTFVV9l2xj401mIZZ5P4SAHKk/+Bp9YMVsLieOLqvcykRCpTcC
 G2JYjUJJIY1f9YIWdUY/EhzAaO0VDAh6xYbrFGCSZb8YGMkvAadowzxfwEw9MpS1
 dDrcp+7B2kg7rpkWV2rOGtxL0dCFkNE6PcSv1nd8tj676m9zT8UPiG0+vg87pT7R
 FbklwfRzDLf0Zyi/IAM/aRl42X0eCkb31jqXsnN7F8h9R4CpGq5/bz8bi27MXccN
 60pWEpWRoIEGnhm5019AwVFWLDi3jL32Z12NSGh/0znoq8xBrUIe6/cfA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm1; bh=b7LQ34RL0ieHO3ZCZ6lcdLgVPcAPnqY+tlrvFfXUnHM=; b=Jsn9OHS9
 5vGwrFDRHNNAqZtoKGGDqdQGyUyl90QbmVlryLE2q/oXgB1UR+gKIZrNc3vo6pPU
 ZBuJGRn85WPcHsprKR4uUwNwigiXZrdgN6gHAGh5FyeuS+0JnqpEcBzEvZc9iPCf
 lfJMLsvhhKcqeYfF3lG93goP+YlCjPIZe2Lw1r5i7DSA9PFJvSIpAjpJ6B7yxCKS
 41gJVS8zLCyniZn4U2n6B+PJM2cHfcSq4RuOE/Ixh1bAxg5y1Ob5jYwUDcEVsHBK
 u+AJJ95QhrQLm3VW3D04vT9h4muFopI3c063B80IwrgpZhwXTaW9vcYTIk9NV4Ph
 0FDloW5xFoPAwg==
X-ME-Sender: <xms:J2aWX0rIjwOvpjz_ShN4NDvPdErOrJG-iaT3cu0Zmax-RgXyAQxEzg>
 <xme:J2aWX6rfWMr8SSPwtd0qfzLDYgGKegXsBsbXMug9vWZSaaPVoZuT7W9j7syUMe_Ci
 0kerAbyuxblYZ5OeHk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrkeehgdeludcutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepmfhlrghushcu
 lfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrthhtvg
 hrnhepueelteegieeuhffgkeefgfevjeeigfetkeeitdfgtdeifefhtdfhfeeuffevgfek
 necukfhppeektddrudeijedrleekrdduledtnecuvehluhhsthgvrhfuihiivgepudenuc
 frrghrrghmpehmrghilhhfrhhomhepihhtshesihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:J2aWX5NP4pT6UyuDasRizQGq-HjXWvdWfObwjCHQnjOUnlqzG1Js6Q>
 <xmx:J2aWX75fQdJX5FyPtme52U7kRyWAJ1z9EbCQshVm4VGJUhkCGLB82Q>
 <xmx:J2aWXz48RoUESC941aC2y_r9vpUtvMBuBxcc2S1M6SOMuuv-Zdvn-g>
 <xmx:J2aWX20aI8gTOh_v19uU3CUAnFfHw1maAiuAMgxlQeBRIuhaQee3hg>
Received: from apples.local (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id A091E328005D;
 Mon, 26 Oct 2020 02:01:09 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 3/3] hw/block/nvme: add the dataset management command
Date: Mon, 26 Oct 2020 07:01:01 +0100
Message-Id: <20201026060101.371900-4-its@irrelevant.dk>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201026060101.371900-1-its@irrelevant.dk>
References: <20201026060101.371900-1-its@irrelevant.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=64.147.123.20; envelope-from=its@irrelevant.dk;
 helo=wout4-smtp.messagingengine.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/26 02:01:07
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Klaus Jensen <k.jensen@samsung.com>

Add support for the Dataset Management command and the Deallocate
attribute. Deallocation results in discards being sent to the underlying
block device. Whether of not the blocks are actually deallocated is
affected by the same factors as Write Zeroes (see previous commit).

     format | discard | dsm (512B)  dsm (4KiB)  dsm (64KiB)
    --------------------------------------------------------
      qcow2    ignore   n           n           n
      qcow2    unmap    n           n           y
      raw      ignore   n           n           n
      raw      unmap    n           y           y

Again, a raw format and 4KiB LBAs are preferable.

In order to set the Namespace Preferred Deallocate Granularity and
Alignment fields (NPDG and NPDA), choose a sane minimum discard
granularity of 4KiB. If we are using a passthru device supporting
discard at a 512B granularity, user should set the discard_granularity
property explicitly. NPDG and NPDA will also account for the
cluster_size of the block driver if required (i.e. for QCOW2).

See NVM Express 1.3d, Section 6.7 ("Dataset Management command").

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/block/nvme.h    |   2 +
 hw/block/nvme-ns.c |  36 ++++++++++++++--
 hw/block/nvme.c    | 102 ++++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 135 insertions(+), 5 deletions(-)

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
diff --git a/hw/block/nvme-ns.c b/hw/block/nvme-ns.c
index f1cc734c60f5..840651db7256 100644
--- a/hw/block/nvme-ns.c
+++ b/hw/block/nvme-ns.c
@@ -28,10 +28,14 @@
 #include "nvme.h"
 #include "nvme-ns.h"
 
-static void nvme_ns_init(NvmeNamespace *ns)
+#define MIN_DISCARD_GRANULARITY (4 * KiB)
+
+static int nvme_ns_init(NvmeNamespace *ns, Error **errp)
 {
+    BlockDriverInfo bdi;
     NvmeIdNs *id_ns = &ns->id_ns;
     int lba_index = NVME_ID_NS_FLBAS_INDEX(ns->id_ns.flbas);
+    int npdg, ret;
 
     ns->id_ns.dlfeat = 0x9;
 
@@ -43,8 +47,25 @@ static void nvme_ns_init(NvmeNamespace *ns)
     id_ns->ncap = id_ns->nsze;
     id_ns->nuse = id_ns->ncap;
 
-    /* support DULBE */
-    id_ns->nsfeat |= 0x4;
+    /* support DULBE and I/O optimization fields */
+    id_ns->nsfeat |= (0x4 | 0x10);
+
+    npdg = ns->blkconf.discard_granularity / ns->blkconf.logical_block_size;
+
+    ret = bdrv_get_info(blk_bs(ns->blkconf.blk), &bdi);
+    if (ret < 0) {
+        error_setg_errno(errp, -ret, "could not get block driver info");
+        return ret;
+    }
+
+    if (bdi.cluster_size &&
+        bdi.cluster_size > ns->blkconf.discard_granularity) {
+        npdg = bdi.cluster_size / ns->blkconf.logical_block_size;
+    }
+
+    id_ns->npda = id_ns->npdg = npdg - 1;
+
+    return 0;
 }
 
 static int nvme_ns_init_blk(NvmeCtrl *n, NvmeNamespace *ns, Error **errp)
@@ -59,6 +80,11 @@ static int nvme_ns_init_blk(NvmeCtrl *n, NvmeNamespace *ns, Error **errp)
         return -1;
     }
 
+    if (ns->blkconf.discard_granularity == -1) {
+        ns->blkconf.discard_granularity =
+            MAX(ns->blkconf.logical_block_size, MIN_DISCARD_GRANULARITY);
+    }
+
     ns->size = blk_getlength(ns->blkconf.blk);
     if (ns->size < 0) {
         error_setg_errno(errp, -ns->size, "could not get blockdev size");
@@ -92,7 +118,9 @@ int nvme_ns_setup(NvmeCtrl *n, NvmeNamespace *ns, Error **errp)
         return -1;
     }
 
-    nvme_ns_init(ns);
+    if (nvme_ns_init(ns, errp)) {
+        return -1;
+    }
 
     if (nvme_register_namespace(n, ns, errp)) {
         return -1;
diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 4ab0705f5a92..d4e187beee08 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -959,6 +959,104 @@ static void nvme_rw_cb(void *opaque, int ret)
     nvme_enqueue_req_completion(nvme_cq(req), req);
 }
 
+static void nvme_aio_discard_cb(void *opaque, int ret)
+{
+    NvmeRequest *req = opaque;
+    uintptr_t *discards = (uintptr_t *)&req->opaque;
+
+    trace_pci_nvme_aio_discard_cb(nvme_cid(req));
+
+    if (ret) {
+        req->status = NVME_INTERNAL_DEV_ERROR;
+        trace_pci_nvme_err_aio(nvme_cid(req), strerror(ret),
+                               req->status);
+    }
+
+    (*discards)--;
+
+    if (*discards) {
+        return;
+    }
+
+    req->opaque = NULL;
+
+    nvme_enqueue_req_completion(nvme_cq(req), req);
+}
+
+static uint16_t nvme_dsm(NvmeCtrl *n, NvmeRequest *req)
+{
+    NvmeNamespace *ns = req->ns;
+    NvmeDsmCmd *dsm = (NvmeDsmCmd *) &req->cmd;
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
+        NvmeDsmRange range[nr];
+        uintptr_t *discards = (uintptr_t *)&req->opaque;
+
+        status = nvme_dma(n, (uint8_t *)range, sizeof(range),
+                          DMA_DIRECTION_TO_DEVICE, req);
+        if (status) {
+            return status;
+        }
+
+        /*
+         * AIO callbacks may be called immediately, so initialize discards to 1
+         * to make sure the the callback does not complete the request before
+         * all discards have been issued.
+         */
+        *discards = 1;
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
+                (*discards)++;
+
+                blk_aio_pdiscard(ns->blkconf.blk, offset, bytes,
+                                 nvme_aio_discard_cb, req);
+
+                offset += bytes;
+                len -= bytes;
+            }
+        }
+
+        /* account for the 1-initialization */
+        (*discards)--;
+
+        if (*discards) {
+            status = NVME_NO_COMPLETE;
+        } else {
+            req->opaque = NULL;
+            status = req->status;
+        }
+    }
+
+    return status;
+}
+
 static uint16_t nvme_flush(NvmeCtrl *n, NvmeRequest *req)
 {
     block_acct_start(blk_get_stats(req->ns->blkconf.blk), &req->acct, 0,
@@ -1088,6 +1186,8 @@ static uint16_t nvme_io_cmd(NvmeCtrl *n, NvmeRequest *req)
     case NVME_CMD_WRITE:
     case NVME_CMD_READ:
         return nvme_rw(n, req);
+    case NVME_CMD_DSM:
+        return nvme_dsm(n, req);
     default:
         trace_pci_nvme_err_invalid_opc(req->cmd.opcode);
         return NVME_INVALID_OPCODE | NVME_DNR;
@@ -2813,7 +2913,7 @@ static void nvme_init_ctrl(NvmeCtrl *n, PCIDevice *pci_dev)
     id->cqes = (0x4 << 4) | 0x4;
     id->nn = cpu_to_le32(n->num_namespaces);
     id->oncs = cpu_to_le16(NVME_ONCS_WRITE_ZEROES | NVME_ONCS_TIMESTAMP |
-                           NVME_ONCS_FEATURES);
+                           NVME_ONCS_FEATURES | NVME_ONCS_DSM);
 
     id->vwc = 0x1;
     id->sgls = cpu_to_le32(NVME_CTRL_SGLS_SUPPORT_NO_ALIGN |
-- 
2.29.1


