Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C552EC43463
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 20:58:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1345E221EC
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 20:58:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1345E221EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35214 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJNSG-0007aw-LE
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 16:58:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46466)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kJN7Z-0004sk-PA; Fri, 18 Sep 2020 16:36:41 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:52831)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kJN7X-0004ye-NF; Fri, 18 Sep 2020 16:36:41 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
 by mailnew.nyi.internal (Postfix) with ESMTP id EE9D0580221;
 Fri, 18 Sep 2020 16:36:38 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute7.internal (MEProxy); Fri, 18 Sep 2020 16:36:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm1; bh=zL/3+KtRDNOwv
 NsfOoBlodEVbAJkzysu81+CfpT2HGU=; b=rCDKT+Y10lojXgO+vCpt14ZhgF6TW
 MuJ4sjKhtFYz4TQnu9vk4OEZB+MpM0AlEoG6SteGPiGteyoLA7ANB6zeMrJCIBE8
 SfrtTk8LbPjd9X6tNuMvIcuM2KlBTdqAGYpu2yQlt5mYvNpdnLGiHKwJ6NhDDodn
 W83fYiaC3HoYX88ADgcVcNroV9t2omc6eA2nPCin3cQjJiF3WIMDMjLDR1/KIupS
 dDn5jE2fWy0clFf9lJfkEqVrmOo/gnZlEUPqwulaaUA+8tKl5rC/jDZWsqN9vpBS
 Y6TsGU9Gy8pMH8QLJNgrD/TGa+vYcEtyKDty2bsPKx2NqbpF8HmZNjGQg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm3; bh=zL/3+KtRDNOwvNsfOoBlodEVbAJkzysu81+CfpT2HGU=; b=qzMOB8it
 JOS21CFV17spThy0aFtm0Z2lHEgR/J9IaKVTzj2tBZPgybbDXoE/geGMQFNuPeZ7
 1CaQc6XYeyUddViLIuvxP5GReeiEJHO6gv4tFAtUp728OmVsC+HxCJFNbYBt/eNy
 VlhKgBVYluXLduoUuliRjapnvPAw8pcYYFcOyGzACGClA1qkwDH5Kx6k/ZMS1y+Y
 qUWWRSDsIvuFTpY4jTIeXzlEO8wd7RJr7YDCVv4ajY37DQMP5iSZ2Dzzqi6jssty
 vlikCPXKD1k1QnRzY7+Ko2PtqN6ezwjetf1T04QgzhdOUl3/CPa+xBXFSjHKXblQ
 RNKpAzsJDG8K9g==
X-ME-Sender: <xms:VhplX8EV193LXBqxDZehOkTIOW_FTLDuEp06kxtqlf50oJclZCF41A>
 <xme:VhplX1XFAWZkaJ6aWj-hSFhrS7N3jhpj9dypgqb04kF3Hucdh-T8NTaF-w5IkrZHi
 l3A9PLewwpIU0YoYqs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrtdeigdduhedvucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefmlhgruhhs
 ucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrghtth
 gvrhhnpeeuleetgeeiuefhgfekfefgveejiefgteekiedtgfdtieefhfdthfefueffvefg
 keenucfkphepkedtrdduieejrdelkedrudeltdenucevlhhushhtvghrufhiiigvpeehne
 curfgrrhgrmhepmhgrihhlfhhrohhmpehithhssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:VhplX2K7x51JQJzzw_GrHPg0w0FLcfzygHaX0xwOWrD0NSU9cUmQag>
 <xmx:VhplX-FAoJ-z5Q0V6w8nZ0QISyvtVu5H37ExCcaJluPOMsTPE9yVeQ>
 <xmx:VhplXyWKNRt9uX7pZTMf6ZxDZQXxWG5fC8VNR1JR3xCvLmsT3KtPyQ>
 <xmx:VhplX9FO6yaandua7V4IEwY2p62COL6bT0FGsmjUrCOpkrCOi2JYRQ>
Received: from apples.local (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id E172C3064674;
 Fri, 18 Sep 2020 16:36:36 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 09/17] hw/block/nvme: refactor aio submission
Date: Fri, 18 Sep 2020 22:36:13 +0200
Message-Id: <20200918203621.602915-10-its@irrelevant.dk>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200918203621.602915-1-its@irrelevant.dk>
References: <20200918203621.602915-1-its@irrelevant.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=66.111.4.221; envelope-from=its@irrelevant.dk;
 helo=new1-smtp.messagingengine.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/18 16:36:27
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
Cc: Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Klaus Jensen <k.jensen@samsung.com>, Max Reitz <mreitz@redhat.com>,
 Klaus Jensen <its@irrelevant.dk>, Keith Busch <kbusch@kernel.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Klaus Jensen <k.jensen@samsung.com>

This pulls block layer aio submission/completion to common functions.

For completions, additionally map an AIO error to the Unrecovered Read
and Write Fault status codes.

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/block/nvme.h       |  25 ++++++++
 hw/block/nvme.c       | 136 +++++++++++++++++++++++++++++-------------
 hw/block/trace-events |   4 +-
 3 files changed, 124 insertions(+), 41 deletions(-)

diff --git a/hw/block/nvme.h b/hw/block/nvme.h
index ce9e931420d7..5741e93a0fb9 100644
--- a/hw/block/nvme.h
+++ b/hw/block/nvme.h
@@ -32,6 +32,17 @@ typedef struct NvmeRequest {
     QTAILQ_ENTRY(NvmeRequest)entry;
 } NvmeRequest;
 
+static inline bool nvme_req_is_write(NvmeRequest *req)
+{
+    switch (req->cmd.opcode) {
+    case NVME_CMD_WRITE:
+    case NVME_CMD_WRITE_ZEROES:
+        return true;
+    default:
+        return false;
+    }
+}
+
 static inline const char *nvme_adm_opc_str(uint8_t opc)
 {
     switch (opc) {
@@ -171,4 +182,18 @@ static inline uint64_t nvme_ns_nlbas(NvmeCtrl *n, NvmeNamespace *ns)
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
index 0b2aa6f92e7f..e6790c196d2b 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -614,30 +614,108 @@ static inline uint16_t nvme_check_bounds(NvmeCtrl *n, NvmeNamespace *ns,
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
+    bool is_write;
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
+    case NVME_CMD_READ:
+    case NVME_CMD_WRITE:
+        is_write = nvme_req_is_write(req);
+
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
@@ -658,11 +736,7 @@ static uint16_t nvme_write_zeroes(NvmeCtrl *n, NvmeRequest *req)
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
@@ -674,8 +748,7 @@ static uint16_t nvme_rw(NvmeCtrl *n, NvmeRequest *req)
 
     uint64_t data_size = nvme_l2b(ns, nlb);
     uint64_t data_offset = nvme_l2b(ns, slba);
-    int is_write = rw->opcode == NVME_CMD_WRITE ? 1 : 0;
-    enum BlockAcctType acct = is_write ? BLOCK_ACCT_WRITE : BLOCK_ACCT_READ;
+    bool is_write = nvme_req_is_write(req);
     uint16_t status;
 
     trace_pci_nvme_rw(nvme_cid(req), nvme_io_opc_str(rw->opcode), nlb,
@@ -698,28 +771,11 @@ static uint16_t nvme_rw(NvmeCtrl *n, NvmeRequest *req)
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
-    block_acct_invalid(blk_get_stats(n->conf.blk), acct);
+    block_acct_invalid(blk_get_stats(n->conf.blk),
+                       is_write ? BLOCK_ACCT_WRITE : BLOCK_ACCT_READ);
     return status;
 }
 
diff --git a/hw/block/trace-events b/hw/block/trace-events
index 63d8750dd96e..04a700c73f7d 100644
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
@@ -88,6 +89,7 @@ pci_nvme_mmio_shutdown_cleared(void) "shutdown bit cleared"
 pci_nvme_err_mdts(uint16_t cid, size_t len) "cid %"PRIu16" len %zu"
 pci_nvme_err_addr_read(uint64_t addr) "addr 0x%"PRIx64""
 pci_nvme_err_addr_write(uint64_t addr) "addr 0x%"PRIx64""
+pci_nvme_err_aio(uint16_t cid, const char *errname, uint16_t status) "cid %"PRIu16" err '%s' status 0x%"PRIx16""
 pci_nvme_err_invalid_dma(void) "PRP/SGL is too small for transfer size"
 pci_nvme_err_invalid_prplist_ent(uint64_t prplist) "PRP list entry is null or not page aligned: 0x%"PRIx64""
 pci_nvme_err_invalid_prp2_align(uint64_t prp2) "PRP2 is not page aligned: 0x%"PRIx64""
-- 
2.28.0


