Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EAF0C4727D
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 09:02:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38AD820715
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 09:02:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38AD820715
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53940 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKeBl-000873-W0
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 05:02:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55774)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kKdvz-0005sj-M8; Tue, 22 Sep 2020 04:45:59 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:47803)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kKdvr-0000uA-NK; Tue, 22 Sep 2020 04:45:58 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
 by mailnew.nyi.internal (Postfix) with ESMTP id 63BE05803C9;
 Tue, 22 Sep 2020 04:45:50 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute7.internal (MEProxy); Tue, 22 Sep 2020 04:45:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm1; bh=eB6LxwuM91btm
 PGfe54upHhXi0ShMwLCVFDhrREwSt8=; b=zcqwwUXpJd6F3StVWE6DB+hQHWue1
 eM26gykGvJN8uYGUcsDueQ65HgGh4qNINI+1wudaJyqstuAy4ysYTK+P5zgCCAOt
 yXvWiZyFbmUA186MWKSswvyV2lJKXJLPJW74A8E8Yf/5imz8yY0ehQ/K6EOCuCaO
 CuUvfdttncXQGXRmVYiMUeSqb670fTVp9T8XwFhN1IVTWW5VinOzTVVP/NcPn1zF
 JpjQYMteZx1AP57tqJ8PwyVo4NzYgjCp8xs3mf8ApxLXznOraDZX5LmbXxT/xeDs
 u3L1X4nNXQGrgjF1W/4pkvlIitzVt2JFDZtUQXgI5nos5p6tUXrJYJKBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm3; bh=eB6LxwuM91btmPGfe54upHhXi0ShMwLCVFDhrREwSt8=; b=FmP3Ix9F
 uZBLaNOGmJc3TyFEDTy1TyXoThQ6q8Iwo2Qawz8PLFKoi4n9bTr1M8SlUWe9zRGh
 C1fZFw4TKEEb3d8893LVjuzZHU14J3zMJd9lPyTuKCLZIMjdwYAbfzVvlzQjkQAh
 ryx4tsoly+b5u0cjfKPBtUIzon6B5Zo7xenPVehBo7UbOhe74tE8KCrWHI02eb51
 rf7VjgxVg4hwYLpfI2hi8FDbvW/hzkTqefcwOQ70yCjLnH1tVyT3sBsonTapVAEa
 hfhpIomH2+fj97/ESKTggibACkqpwjAHjY+vJHYE1LAfk5G7ikbQCD3BpHQNN3ht
 KuAK+iivcOY6rA==
X-ME-Sender: <xms:vblpX4ZjqrAqnegBx1Blj1SRX4wwz4EA--lLArWU8VaATPgN7aKf7A>
 <xme:vblpXzbgdIl_CtvVw53XKaNdpwaCTR6WHiaJsD0TXQnegYTOLiK6r28gCRcxnLLNE
 r-ornvGay0yZVaDHk8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudeggddtkecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepmfhlrghushcu
 lfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrthhtvg
 hrnhepueelteegieeuhffgkeefgfevjeeigfetkeeitdfgtdeifefhtdfhfeeuffevgfek
 necukfhppeektddrudeijedrleekrdduledtnecuvehluhhsthgvrhfuihiivgepfeenuc
 frrghrrghmpehmrghilhhfrhhomhepihhtshesihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:vblpXy9TXAV2TsHmPleP1x8-hCcAd2RpycynT0flVayXrzc7rEm9LA>
 <xmx:vblpXyoRQ_HbdcsXa7OUF7K1jqyZHe_ckDctELigsebQ6so8_aWnTA>
 <xmx:vblpXzrP9XUU9iSxjVoPekrH4Fc1WY1efNH286jwN62E1B1cYS0FYQ>
 <xmx:vblpX_LjTpturPaH-CDmW3B9G2OJHbhYAGVUxa3_fWaOExFP7DLyKA>
Received: from apples.local (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id 494973064682;
 Tue, 22 Sep 2020 04:45:48 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 09/17] hw/block/nvme: refactor aio submission
Date: Tue, 22 Sep 2020 10:45:25 +0200
Message-Id: <20200922084533.1273962-10-its@irrelevant.dk>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200922084533.1273962-1-its@irrelevant.dk>
References: <20200922084533.1273962-1-its@irrelevant.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=66.111.4.230; envelope-from=its@irrelevant.dk;
 helo=new4-smtp.messagingengine.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 04:45:36
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
Cc: Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Klaus Jensen <k.jensen@samsung.com>, Max Reitz <mreitz@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Klaus Jensen <k.jensen@samsung.com>

This pulls block layer aio submission/completion to common functions.

For completions, additionally map an AIO error to the Unrecovered Read
and Write Fault status codes.

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/block/nvme.h       |  14 +++++
 hw/block/nvme.c       | 136 ++++++++++++++++++++++++++++++------------
 hw/block/trace-events |   4 +-
 3 files changed, 114 insertions(+), 40 deletions(-)

diff --git a/hw/block/nvme.h b/hw/block/nvme.h
index ce9e931420d7..f355eccb323b 100644
--- a/hw/block/nvme.h
+++ b/hw/block/nvme.h
@@ -171,4 +171,18 @@ static inline uint64_t nvme_ns_nlbas(NvmeCtrl *n, NvmeNamespace *ns)
     return n->ns_size >> nvme_ns_lbads(ns);
 }
 
+static inline NvmeCQueue *nvme_cq(NvmeRequest *req)
+{
+    NvmeSQueue *sq = req->sq;
+    NvmeCtrl *n = sq->ctrl;
+
+    return n->cq[sq->cqid];
+}
+
+static inline NvmeCtrl *nvme_ctrl(NvmeRequest *req)
+{
+    NvmeSQueue *sq = req->sq;
+    return sq->ctrl;
+}
+
 #endif /* HW_NVME_H */
diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index bae43276bd6f..aa13809eaab2 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -614,30 +614,110 @@ static inline uint16_t nvme_check_bounds(NvmeCtrl *n, NvmeNamespace *ns,
 static void nvme_rw_cb(void *opaque, int ret)
 {
     NvmeRequest *req = opaque;
-    NvmeSQueue *sq = req->sq;
-    NvmeCtrl *n = sq->ctrl;
-    NvmeCQueue *cq = n->cq[sq->cqid];
+    NvmeCtrl *n = nvme_ctrl(req);
 
-    trace_pci_nvme_rw_cb(nvme_cid(req));
+    BlockBackend *blk = n->conf.blk;
+    BlockAcctCookie *acct = &req->acct;
+    BlockAcctStats *stats = blk_get_stats(blk);
+
+    Error *local_err = NULL;
+
+    trace_pci_nvme_rw_cb(nvme_cid(req), blk_name(blk));
 
     if (!ret) {
-        block_acct_done(blk_get_stats(n->conf.blk), &req->acct);
+        block_acct_done(stats, acct);
         req->status = NVME_SUCCESS;
     } else {
-        block_acct_failed(blk_get_stats(n->conf.blk), &req->acct);
-        req->status = NVME_INTERNAL_DEV_ERROR;
+        uint16_t status;
+
+        block_acct_failed(stats, acct);
+
+        switch (req->cmd.opcode) {
+        case NVME_CMD_READ:
+            status = NVME_UNRECOVERED_READ;
+            break;
+        case NVME_CMD_FLUSH:
+        case NVME_CMD_WRITE:
+        case NVME_CMD_WRITE_ZEROES:
+            status = NVME_WRITE_FAULT;
+            break;
+        default:
+            status = NVME_INTERNAL_DEV_ERROR;
+            break;
+        }
+
+        trace_pci_nvme_err_aio(nvme_cid(req), strerror(ret), status);
+
+        error_setg_errno(&local_err, -ret, "aio failed");
+        error_report_err(local_err);
+
+        req->status = status;
     }
 
-    nvme_enqueue_req_completion(cq, req);
+    nvme_enqueue_req_completion(nvme_cq(req), req);
+}
+
+static uint16_t nvme_do_aio(BlockBackend *blk, int64_t offset, size_t len,
+                            NvmeRequest *req)
+{
+    BlockAcctCookie *acct = &req->acct;
+    BlockAcctStats *stats = blk_get_stats(blk);
+
+    bool is_write = false;
+
+    trace_pci_nvme_do_aio(nvme_cid(req), req->cmd.opcode,
+                          nvme_io_opc_str(req->cmd.opcode), blk_name(blk),
+                          offset, len);
+
+    switch (req->cmd.opcode) {
+    case NVME_CMD_FLUSH:
+        block_acct_start(stats, acct, 0, BLOCK_ACCT_FLUSH);
+        req->aiocb = blk_aio_flush(blk, nvme_rw_cb, req);
+        break;
+
+    case NVME_CMD_WRITE_ZEROES:
+        block_acct_start(stats, acct, len, BLOCK_ACCT_WRITE);
+        req->aiocb = blk_aio_pwrite_zeroes(blk, offset, len,
+                                           BDRV_REQ_MAY_UNMAP, nvme_rw_cb,
+                                           req);
+        break;
+
+    case NVME_CMD_WRITE:
+        is_write = true;
+
+        /* fallthrough */
+
+    case NVME_CMD_READ:
+        block_acct_start(stats, acct, len,
+                         is_write ? BLOCK_ACCT_WRITE : BLOCK_ACCT_READ);
+
+        if (req->qsg.sg) {
+            if (is_write) {
+                req->aiocb = dma_blk_write(blk, &req->qsg, offset,
+                                           BDRV_SECTOR_SIZE, nvme_rw_cb, req);
+            } else {
+                req->aiocb = dma_blk_read(blk, &req->qsg, offset,
+                                          BDRV_SECTOR_SIZE, nvme_rw_cb, req);
+            }
+        } else {
+            if (is_write) {
+                req->aiocb = blk_aio_pwritev(blk, offset, &req->iov, 0,
+                                             nvme_rw_cb, req);
+            } else {
+                req->aiocb = blk_aio_preadv(blk, offset, &req->iov, 0,
+                                            nvme_rw_cb, req);
+            }
+        }
+
+        break;
+    }
+
+    return NVME_NO_COMPLETE;
 }
 
 static uint16_t nvme_flush(NvmeCtrl *n, NvmeRequest *req)
 {
-    block_acct_start(blk_get_stats(n->conf.blk), &req->acct, 0,
-                     BLOCK_ACCT_FLUSH);
-    req->aiocb = blk_aio_flush(n->conf.blk, nvme_rw_cb, req);
-
-    return NVME_NO_COMPLETE;
+    return nvme_do_aio(n->conf.blk, 0, 0, req);
 }
 
 static uint16_t nvme_write_zeroes(NvmeCtrl *n, NvmeRequest *req)
@@ -658,11 +738,7 @@ static uint16_t nvme_write_zeroes(NvmeCtrl *n, NvmeRequest *req)
         return status;
     }
 
-    block_acct_start(blk_get_stats(n->conf.blk), &req->acct, 0,
-                     BLOCK_ACCT_WRITE);
-    req->aiocb = blk_aio_pwrite_zeroes(n->conf.blk, offset, count,
-                                       BDRV_REQ_MAY_UNMAP, nvme_rw_cb, req);
-    return NVME_NO_COMPLETE;
+    return nvme_do_aio(n->conf.blk, offset, count, req);
 }
 
 static uint16_t nvme_rw(NvmeCtrl *n, NvmeRequest *req)
@@ -674,8 +750,8 @@ static uint16_t nvme_rw(NvmeCtrl *n, NvmeRequest *req)
 
     uint64_t data_size = nvme_l2b(ns, nlb);
     uint64_t data_offset = nvme_l2b(ns, slba);
-    int is_write = rw->opcode == NVME_CMD_WRITE ? 1 : 0;
-    enum BlockAcctType acct = is_write ? BLOCK_ACCT_WRITE : BLOCK_ACCT_READ;
+    enum BlockAcctType acct = req->cmd.opcode == NVME_CMD_WRITE ?
+        BLOCK_ACCT_WRITE : BLOCK_ACCT_READ;
     uint16_t status;
 
     trace_pci_nvme_rw(nvme_cid(req), nvme_io_opc_str(rw->opcode), nlb,
@@ -698,25 +774,7 @@ static uint16_t nvme_rw(NvmeCtrl *n, NvmeRequest *req)
         goto invalid;
     }
 
-    if (req->qsg.nsg > 0) {
-        block_acct_start(blk_get_stats(n->conf.blk), &req->acct, req->qsg.size,
-                         acct);
-        req->aiocb = is_write ?
-            dma_blk_write(n->conf.blk, &req->qsg, data_offset, BDRV_SECTOR_SIZE,
-                          nvme_rw_cb, req) :
-            dma_blk_read(n->conf.blk, &req->qsg, data_offset, BDRV_SECTOR_SIZE,
-                         nvme_rw_cb, req);
-    } else {
-        block_acct_start(blk_get_stats(n->conf.blk), &req->acct, req->iov.size,
-                         acct);
-        req->aiocb = is_write ?
-            blk_aio_pwritev(n->conf.blk, data_offset, &req->iov, 0, nvme_rw_cb,
-                            req) :
-            blk_aio_preadv(n->conf.blk, data_offset, &req->iov, 0, nvme_rw_cb,
-                           req);
-    }
-
-    return NVME_NO_COMPLETE;
+    return nvme_do_aio(n->conf.blk, data_offset, data_size, req);
 
 invalid:
     block_acct_invalid(blk_get_stats(n->conf.blk), acct);
diff --git a/hw/block/trace-events b/hw/block/trace-events
index 024786f4833c..9a6c5fb3dd55 100644
--- a/hw/block/trace-events
+++ b/hw/block/trace-events
@@ -39,8 +39,9 @@ pci_nvme_map_prp(uint64_t trans_len, uint32_t len, uint64_t prp1, uint64_t prp2,
 pci_nvme_io_cmd(uint16_t cid, uint32_t nsid, uint16_t sqid, uint8_t opcode, const char *opname) "cid %"PRIu16" nsid %"PRIu32" sqid %"PRIu16" opc 0x%"PRIx8" opname '%s'"
 pci_nvme_admin_cmd(uint16_t cid, uint16_t sqid, uint8_t opcode, const char *opname) "cid %"PRIu16" sqid %"PRIu16" opc 0x%"PRIx8" opname '%s'"
 pci_nvme_rw(uint16_t cid, const char *verb, uint32_t nlb, uint64_t count, uint64_t lba) "cid %"PRIu16" '%s' nlb %"PRIu32" count %"PRIu64" lba 0x%"PRIx64""
-pci_nvme_rw_cb(uint16_t cid) "cid %"PRIu16""
+pci_nvme_rw_cb(uint16_t cid, const char *blkname) "cid %"PRIu16" blk '%s'"
 pci_nvme_write_zeroes(uint16_t cid, uint64_t slba, uint32_t nlb) "cid %"PRIu16" slba %"PRIu64" nlb %"PRIu32""
+pci_nvme_do_aio(uint16_t cid, uint8_t opc, const char *opname, const char *blkname, int64_t offset, size_t len) "cid %"PRIu16" opc 0x%"PRIx8" opname '%s' blk '%s' offset %"PRId64" len %zu"
 pci_nvme_create_sq(uint64_t addr, uint16_t sqid, uint16_t cqid, uint16_t qsize, uint16_t qflags) "create submission queue, addr=0x%"PRIx64", sqid=%"PRIu16", cqid=%"PRIu16", qsize=%"PRIu16", qflags=%"PRIu16""
 pci_nvme_create_cq(uint64_t addr, uint16_t cqid, uint16_t vector, uint16_t size, uint16_t qflags, int ien) "create completion queue, addr=0x%"PRIx64", cqid=%"PRIu16", vector=%"PRIu16", qsize=%"PRIu16", qflags=%"PRIu16", ien=%d"
 pci_nvme_del_sq(uint16_t qid) "deleting submission queue sqid=%"PRIu16""
@@ -89,6 +90,7 @@ pci_nvme_err_mdts(uint16_t cid, size_t len) "cid %"PRIu16" len %zu"
 pci_nvme_err_addr_read(uint64_t addr) "addr 0x%"PRIx64""
 pci_nvme_err_addr_write(uint64_t addr) "addr 0x%"PRIx64""
 pci_nvme_err_cfs(void) "controller fatal status"
+pci_nvme_err_aio(uint16_t cid, const char *errname, uint16_t status) "cid %"PRIu16" err '%s' status 0x%"PRIx16""
 pci_nvme_err_invalid_dma(void) "PRP/SGL is too small for transfer size"
 pci_nvme_err_invalid_prplist_ent(uint64_t prplist) "PRP list entry is null or not page aligned: 0x%"PRIx64""
 pci_nvme_err_invalid_prp2_align(uint64_t prp2) "PRP2 is not page aligned: 0x%"PRIx64""
-- 
2.28.0


