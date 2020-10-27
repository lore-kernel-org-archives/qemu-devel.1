Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 132B5C388F9
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 18:09:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B6D520723
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 18:09:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B6D520723
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33770 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXTPf-0005mC-Mw
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 14:09:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50218)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kXTE3-0006Ci-WE; Tue, 27 Oct 2020 13:57:41 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:59495)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kXTE0-00075j-7G; Tue, 27 Oct 2020 13:57:39 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.nyi.internal (Postfix) with ESMTP id 59B325C0117;
 Tue, 27 Oct 2020 13:57:32 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute4.internal (MEProxy); Tue, 27 Oct 2020 13:57:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm1; bh=8epPye4uchEbh
 K3hY7n5aV6REppnb7T9Bsjkx4svSgs=; b=cS+37VWQRWUoaXJEbB4i1rkrqGEcL
 tGYqpvRQkndk+4L+19serorC3yix22lfiDW+2WESsn8vZaliMkexZ8h54ZdxqV+A
 w2YI1aBxG3NKBq5PSEi1tQHYPQ1SqUGMSpz1iaLav9TN9hjAZlWtZeB/SA7GN5E0
 IxcAZUZa5CdPRrey0XnjgPhuYacTvEjMT5gkGF7n5Sg/srHrhWrq3HUAhLDrTql5
 /2UPPfCulpG19ARUyf56Q/tuOlzqIuLAMP8VuwuBcnWKTCXMnXruJ1Qqr+dVZhiL
 e4a+bm+yk1G0vfZ4C8NRiMhkmGs3XNxd9Rf01L0JzNw/bSRJxNonwlhhw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm1; bh=8epPye4uchEbhK3hY7n5aV6REppnb7T9Bsjkx4svSgs=; b=WoC/B25s
 lYKPWawLy8v//45i2fPPocEzHt6fjje3eaefH0lth5x06a97q33Pe2Ap311ZVT5L
 eFli8/ZHNxMq9dTI6bEgHwK6jNjdQGPp5q9XKNPTjv0/uOZHojtGC661eSelYGqF
 pUuIhQv5HjeE9AoWrjhFCa29Pum4FkcAjf3mp3ax17DuWIkPtiuIQgrDWClemgS+
 wN9d0h9MfFN7XMqMERwpB+P6XpmuT/elIcpcFMBwsidqKzlBoPq/2rFmg56BiY7j
 65OU+pYvboAchLZXdejqOShKWaocKnIlpuKXDvrzbogbY5/mpKcVRTBcEr3epnqf
 d+qSsETzJf3xAQ==
X-ME-Sender: <xms:jF-YX1T80Imm0zUfndM182CtizPpCYipY-WU46-Ay_rl9MtEoAYgHQ>
 <xme:jF-YX-wDFS4foqDxE8bf35Cr48ojYEQ_q79oOvO4V2GhU7ffSm_chNvEh-6rJRAs5
 -1mraifqEbTVwBZdwQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrkeelgddutdejucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefmlhgruhhs
 ucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrghtth
 gvrhhnpeeuleetgeeiuefhgfekfefgveejiefgteekiedtgfdtieefhfdthfefueffvefg
 keenucfkphepkedtrdduieejrdelkedrudeltdenucevlhhushhtvghrufhiiigvpedtne
 curfgrrhgrmhepmhgrihhlfhhrohhmpehithhssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:jF-YX60Lab10s0gUCwIWA3r2OyPtbYx0rRZkHb-lUdcUOxe6fI1O1g>
 <xmx:jF-YX9DSlhQMyv7ev38j7GcId1RM8z3nLlrynbpvxXIyYt_8z-GQVw>
 <xmx:jF-YX-hmojmDJFBjcKhg2DogDXHQdj-_-EiTxURRjUBQy_BKfR2-7g>
 <xmx:jF-YX2c7cthnJWBYTUBZQoaLK2dUgh5RSRO-Acdd5Mehaum5HfDuXQ>
Received: from apples.local (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id 39E813280060;
 Tue, 27 Oct 2020 13:57:31 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 3/3] hw/block/nvme: add the dataset management command
Date: Tue, 27 Oct 2020 18:57:25 +0100
Message-Id: <20201027175725.586890-4-its@irrelevant.dk>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201027175725.586890-1-its@irrelevant.dk>
References: <20201027175725.586890-1-its@irrelevant.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=66.111.4.28; envelope-from=its@irrelevant.dk;
 helo=out4-smtp.messagingengine.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 13:57:29
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
 hw/block/nvme-ns.c |  30 +++++++++++--
 hw/block/nvme.c    | 102 ++++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 129 insertions(+), 5 deletions(-)

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
index f1cc734c60f5..2d69b5177b51 100644
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
+    int npdg;
 
     ns->id_ns.dlfeat = 0x9;
 
@@ -43,8 +47,19 @@ static void nvme_ns_init(NvmeNamespace *ns)
     id_ns->ncap = id_ns->nsze;
     id_ns->nuse = id_ns->ncap;
 
-    /* support DULBE */
-    id_ns->nsfeat |= 0x4;
+    /* support DULBE and I/O optimization fields */
+    id_ns->nsfeat |= (0x4 | 0x10);
+
+    npdg = ns->blkconf.discard_granularity / ns->blkconf.logical_block_size;
+
+    if (bdrv_get_info(blk_bs(ns->blkconf.blk), &bdi) >= 0 &&
+        bdi.cluster_size > ns->blkconf.discard_granularity) {
+        npdg = bdi.cluster_size / ns->blkconf.logical_block_size;
+    }
+
+    id_ns->npda = id_ns->npdg = npdg - 1;
+
+    return 0;
 }
 
 static int nvme_ns_init_blk(NvmeCtrl *n, NvmeNamespace *ns, Error **errp)
@@ -59,6 +74,11 @@ static int nvme_ns_init_blk(NvmeCtrl *n, NvmeNamespace *ns, Error **errp)
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
@@ -92,7 +112,9 @@ int nvme_ns_setup(NvmeCtrl *n, NvmeNamespace *ns, Error **errp)
         return -1;
     }
 
-    nvme_ns_init(ns);
+    if (nvme_ns_init(ns, errp)) {
+        return -1;
+    }
 
     if (nvme_register_namespace(n, ns, errp)) {
         return -1;
diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 44db841374eb..7c5e3cc3de0c 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -967,6 +967,104 @@ static void nvme_rw_cb(void *opaque, int ret)
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
@@ -1096,6 +1194,8 @@ static uint16_t nvme_io_cmd(NvmeCtrl *n, NvmeRequest *req)
     case NVME_CMD_WRITE:
     case NVME_CMD_READ:
         return nvme_rw(n, req);
+    case NVME_CMD_DSM:
+        return nvme_dsm(n, req);
     default:
         trace_pci_nvme_err_invalid_opc(req->cmd.opcode);
         return NVME_INVALID_OPCODE | NVME_DNR;
@@ -2821,7 +2921,7 @@ static void nvme_init_ctrl(NvmeCtrl *n, PCIDevice *pci_dev)
     id->cqes = (0x4 << 4) | 0x4;
     id->nn = cpu_to_le32(n->num_namespaces);
     id->oncs = cpu_to_le16(NVME_ONCS_WRITE_ZEROES | NVME_ONCS_TIMESTAMP |
-                           NVME_ONCS_FEATURES);
+                           NVME_ONCS_FEATURES | NVME_ONCS_DSM);
 
     id->vwc = 0x1;
     id->sgls = cpu_to_le32(NVME_CTRL_SGLS_SUPPORT_NO_ALIGN |
-- 
2.29.1


