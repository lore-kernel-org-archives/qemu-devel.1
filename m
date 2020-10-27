Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5756C388F9
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 11:18:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9171204FD
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 11:18:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9171204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33220 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXMzN-0000FL-G1
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 07:18:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38750)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kXMYY-0000RB-0e; Tue, 27 Oct 2020 06:50:22 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:36799)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kXMYU-0002CW-PU; Tue, 27 Oct 2020 06:50:21 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.nyi.internal (Postfix) with ESMTP id C11405C0170;
 Tue, 27 Oct 2020 06:49:56 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute4.internal (MEProxy); Tue, 27 Oct 2020 06:49:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm1; bh=hq58dUTEtshsr
 btaMR0Sah69lY6tV9NsjcrO3IUiRhc=; b=o4+bL576nk721xepcKH8NW6KpAtjU
 wgWeLn13rN8yI2dlKuRcl9wgclFkkqRXiQ5B8VaGfc9XbGXk0jK1ZRlWlAbrw17y
 l+CA/iJ+ymV9m1M8PW0CuucBDouFC8Wr9I/xOCk7sVGCKWc3lyBXlNyCsrC6MyRT
 wcBzZKiooj55uDQBYL70Car/XltzVNFLb5OYj1U0yHvLtSXJjaV0fY3mgd0Hkyrg
 06PDpbGaVBax44dw0kQuvlg25lw8COUAQOQ0QTp4j2L7oJnRItZFFvxZK8vlkf9g
 OkyXTelbHql6HWEENw0g2oeStQoxDTT++Ah4855yC7+8XR6xP48L1v48A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm1; bh=hq58dUTEtshsrbtaMR0Sah69lY6tV9NsjcrO3IUiRhc=; b=CRLqftl2
 zZdOPy+81tFWcbU3PVzc1jVMztZ22nfJMEWxXdB3XEZTP/ApoSB9IqErqLo1XV9A
 3AQu+6A3Xx+T1KVvMMB0rga4MT/qbKS6vg/FodL01XmRmCE6IAYSu3QCIKaL18MB
 l6FYDrA6wFEcNLLi0BxszRM5CqjcNIj4HsK1Srgw3B8mnwBeCcR4zbhJ5jzvRgVT
 q7IbRxdYHDrKA6Pc2egMFlU2bYChxu5iiKeSAHrk7zlzmeWuvrk834+AA0gp8rTw
 XDfZiPhq+ibNLwgReVPt4eLWZyxMnid7NeiIcmzgw0XQvHDV5zMOL1KyExA9tTRk
 44MOo16Wem6kyQ==
X-ME-Sender: <xms:VPuXX_iNwfXYb8eNSgvc_CQAVEnhy0kY8nyUA4liPxI8It_kjRemog>
 <xme:VPuXX8BejMHlg1PDiFKGruBJ40T92RqnvFmcdUNpdJOtgVf-ondk9qykMKhYSwUOT
 dWyG1Slanux2gamNOY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrkeelgddvtdcutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepmfhlrghushcu
 lfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrthhtvg
 hrnhepueelteegieeuhffgkeefgfevjeeigfetkeeitdfgtdeifefhtdfhfeeuffevgfek
 necukfhppeektddrudeijedrleekrdduledtnecuvehluhhsthgvrhfuihiivgepieenuc
 frrghrrghmpehmrghilhhfrhhomhepihhtshesihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:VPuXX_EvRVb_EE2vWHjN2VN8hY8AkKsAKZlYV8ZWRX8CZJYIMxSNXg>
 <xmx:VPuXX8Rbl1ksssKVXmL2jQKVRtIEz67AiBw30fiR_C-5y-Y0ttDN_g>
 <xmx:VPuXX8zu1-7yEXyvZYO_KNweErqxKNvLNMqiquFKVGPcDC-2CaH6ow>
 <xmx:VPuXX4-uPsmpS-KbCPXIwAEE9gFm4pk1S_jbTFBPZlR1vUsz3m1gIA>
Received: from apples.local (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id B6CFF328005E;
 Tue, 27 Oct 2020 06:49:55 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 19/30] hw/block/nvme: remove pointless rw indirection
Date: Tue, 27 Oct 2020 11:49:21 +0100
Message-Id: <20201027104932.558087-20-its@irrelevant.dk>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201027104932.558087-1-its@irrelevant.dk>
References: <20201027104932.558087-1-its@irrelevant.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=66.111.4.26; envelope-from=its@irrelevant.dk;
 helo=out2-smtp.messagingengine.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 06:49:36
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
Cc: Klaus Jensen <its@irrelevant.dk>, Keith Busch <kbusch@kernel.org>,
 qemu-block@nongnu.org, Klaus Jensen <k.jensen@samsung.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Keith Busch <kbusch@kernel.org>

The code switches on the opcode to invoke a function specific to that
opcode. There's no point in consolidating back to a common function that
just switches on that same opcode without any actual common code.
Restore the opcode specific behavior without going back through another
level of switches.

Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/block/nvme.c       | 91 ++++++++++++++-----------------------------
 hw/block/trace-events |  1 -
 2 files changed, 29 insertions(+), 63 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 2225b944f935..a168f0bf4adb 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -927,68 +927,12 @@ static void nvme_rw_cb(void *opaque, int ret)
     nvme_enqueue_req_completion(nvme_cq(req), req);
 }
 
-static uint16_t nvme_do_aio(BlockBackend *blk, int64_t offset, size_t len,
-                            NvmeRequest *req)
-{
-    BlockAcctCookie *acct = &req->acct;
-    BlockAcctStats *stats = blk_get_stats(blk);
-
-    bool is_write = false;
-
-    trace_pci_nvme_do_aio(nvme_cid(req), req->cmd.opcode,
-                          nvme_io_opc_str(req->cmd.opcode), blk_name(blk),
-                          offset, len);
-
-    switch (req->cmd.opcode) {
-    case NVME_CMD_FLUSH:
-        block_acct_start(stats, acct, 0, BLOCK_ACCT_FLUSH);
-        req->aiocb = blk_aio_flush(blk, nvme_rw_cb, req);
-        break;
-
-    case NVME_CMD_WRITE_ZEROES:
-        block_acct_start(stats, acct, len, BLOCK_ACCT_WRITE);
-        req->aiocb = blk_aio_pwrite_zeroes(blk, offset, len,
-                                           BDRV_REQ_MAY_UNMAP, nvme_rw_cb,
-                                           req);
-        break;
-
-    case NVME_CMD_WRITE:
-        is_write = true;
-
-        /* fallthrough */
-
-    case NVME_CMD_READ:
-        block_acct_start(stats, acct, len,
-                         is_write ? BLOCK_ACCT_WRITE : BLOCK_ACCT_READ);
-
-        if (req->qsg.sg) {
-            if (is_write) {
-                req->aiocb = dma_blk_write(blk, &req->qsg, offset,
-                                           BDRV_SECTOR_SIZE, nvme_rw_cb, req);
-            } else {
-                req->aiocb = dma_blk_read(blk, &req->qsg, offset,
-                                          BDRV_SECTOR_SIZE, nvme_rw_cb, req);
-            }
-        } else {
-            if (is_write) {
-                req->aiocb = blk_aio_pwritev(blk, offset, &req->iov, 0,
-                                             nvme_rw_cb, req);
-            } else {
-                req->aiocb = blk_aio_preadv(blk, offset, &req->iov, 0,
-                                            nvme_rw_cb, req);
-            }
-        }
-
-        break;
-    }
-
-    return NVME_NO_COMPLETE;
-}
-
 static uint16_t nvme_flush(NvmeCtrl *n, NvmeRequest *req)
 {
-    NvmeNamespace *ns = req->ns;
-    return nvme_do_aio(ns->blkconf.blk, 0, 0, req);
+    block_acct_start(blk_get_stats(req->ns->blkconf.blk), &req->acct, 0,
+                     BLOCK_ACCT_FLUSH);
+    req->aiocb = blk_aio_flush(req->ns->blkconf.blk, nvme_rw_cb, req);
+    return NVME_NO_COMPLETE;
 }
 
 static uint16_t nvme_write_zeroes(NvmeCtrl *n, NvmeRequest *req)
@@ -1009,7 +953,11 @@ static uint16_t nvme_write_zeroes(NvmeCtrl *n, NvmeRequest *req)
         return status;
     }
 
-    return nvme_do_aio(ns->blkconf.blk, offset, count, req);
+    block_acct_start(blk_get_stats(req->ns->blkconf.blk), &req->acct, 0,
+                     BLOCK_ACCT_WRITE);
+    req->aiocb = blk_aio_pwrite_zeroes(req->ns->blkconf.blk, offset, count,
+                                       BDRV_REQ_MAY_UNMAP, nvme_rw_cb, req);
+    return NVME_NO_COMPLETE;
 }
 
 static uint16_t nvme_rw(NvmeCtrl *n, NvmeRequest *req)
@@ -1023,6 +971,7 @@ static uint16_t nvme_rw(NvmeCtrl *n, NvmeRequest *req)
     uint64_t data_offset = nvme_l2b(ns, slba);
     enum BlockAcctType acct = req->cmd.opcode == NVME_CMD_WRITE ?
         BLOCK_ACCT_WRITE : BLOCK_ACCT_READ;
+    BlockBackend *blk = ns->blkconf.blk;
     uint16_t status;
 
     trace_pci_nvme_rw(nvme_cid(req), nvme_io_opc_str(rw->opcode),
@@ -1045,7 +994,25 @@ static uint16_t nvme_rw(NvmeCtrl *n, NvmeRequest *req)
         goto invalid;
     }
 
-    return nvme_do_aio(ns->blkconf.blk, data_offset, data_size, req);
+    block_acct_start(blk_get_stats(blk), &req->acct, data_size, acct);
+    if (req->qsg.sg) {
+        if (acct == BLOCK_ACCT_WRITE) {
+            req->aiocb = dma_blk_write(blk, &req->qsg, data_offset,
+                                       BDRV_SECTOR_SIZE, nvme_rw_cb, req);
+        } else {
+            req->aiocb = dma_blk_read(blk, &req->qsg, data_offset,
+                                      BDRV_SECTOR_SIZE, nvme_rw_cb, req);
+        }
+    } else {
+        if (acct == BLOCK_ACCT_WRITE) {
+            req->aiocb = blk_aio_pwritev(blk, data_offset, &req->iov, 0,
+                                         nvme_rw_cb, req);
+        } else {
+            req->aiocb = blk_aio_preadv(blk, data_offset, &req->iov, 0,
+                                        nvme_rw_cb, req);
+        }
+    }
+    return NVME_NO_COMPLETE;
 
 invalid:
     block_acct_invalid(blk_get_stats(ns->blkconf.blk), acct);
diff --git a/hw/block/trace-events b/hw/block/trace-events
index 446cca08e9ab..e56d688b88d3 100644
--- a/hw/block/trace-events
+++ b/hw/block/trace-events
@@ -43,7 +43,6 @@ pci_nvme_admin_cmd(uint16_t cid, uint16_t sqid, uint8_t opcode, const char *opna
 pci_nvme_rw(uint16_t cid, const char *verb, uint32_t nsid, uint32_t nlb, uint64_t count, uint64_t lba) "cid %"PRIu16" opname '%s' nsid %"PRIu32" nlb %"PRIu32" count %"PRIu64" lba 0x%"PRIx64""
 pci_nvme_rw_cb(uint16_t cid, const char *blkname) "cid %"PRIu16" blk '%s'"
 pci_nvme_write_zeroes(uint16_t cid, uint32_t nsid, uint64_t slba, uint32_t nlb) "cid %"PRIu16" nsid %"PRIu32" slba %"PRIu64" nlb %"PRIu32""
-pci_nvme_do_aio(uint16_t cid, uint8_t opc, const char *opname, const char *blkname, int64_t offset, size_t len) "cid %"PRIu16" opc 0x%"PRIx8" opname '%s' blk '%s' offset %"PRId64" len %zu"
 pci_nvme_create_sq(uint64_t addr, uint16_t sqid, uint16_t cqid, uint16_t qsize, uint16_t qflags) "create submission queue, addr=0x%"PRIx64", sqid=%"PRIu16", cqid=%"PRIu16", qsize=%"PRIu16", qflags=%"PRIu16""
 pci_nvme_create_cq(uint64_t addr, uint16_t cqid, uint16_t vector, uint16_t size, uint16_t qflags, int ien) "create completion queue, addr=0x%"PRIx64", cqid=%"PRIu16", vector=%"PRIu16", qsize=%"PRIu16", qflags=%"PRIu16", ien=%d"
 pci_nvme_del_sq(uint16_t qid) "deleting submission queue sqid=%"PRIu16""
-- 
2.29.1


