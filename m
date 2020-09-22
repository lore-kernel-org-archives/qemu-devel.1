Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FD8DC2D0E2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 09:05:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69F582086A
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 09:05:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69F582086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59162 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKeEt-000270-1Q
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 05:05:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55724)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kKdvv-0005q1-Mi; Tue, 22 Sep 2020 04:45:57 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:49807)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kKdvh-0000t7-R7; Tue, 22 Sep 2020 04:45:54 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
 by mailnew.nyi.internal (Postfix) with ESMTP id D2ECC5803D1;
 Tue, 22 Sep 2020 04:45:40 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute7.internal (MEProxy); Tue, 22 Sep 2020 04:45:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm1; bh=vqoOboCFljmv0
 X3whNSZUuXyQI79V0ymN1bN/ulKMrE=; b=Pd2+GXirGajBLy68q0isn9Ocr5sBd
 D8q4FruZrnisSZ/K97Z0h/mojqrBqIze83jOlYfYxuMC2XSi4JXoMtSx6rdJ358r
 bvU2VHp5QWhkRIhgQjWhNqqigomADfQ79MhkWAss7H430gLvmP53QimICPlzwYzS
 SWj7oOrgoU/eSXUZcR79oRpSuD5uyRYllJq4jizk1XTcFyxDrHXdfM5FRJbq/MBK
 B3tIpH8REfr7C7qapRFZDYZ6/egrw95NmseSZCvmDjcUtpvASOKOnEyu0ajYzdee
 a+ZqsVdjub6O+JyTXa4Doi/ZNkP7x2ERqJTnUz0Ab43IYgnxN2z5au6aA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm3; bh=vqoOboCFljmv0X3whNSZUuXyQI79V0ymN1bN/ulKMrE=; b=uN/U4YSp
 diEW373wzfIN31bxwNzOjbXz8WkXodiU+4vNmsZrOc2ZtrRhsOW98Ctze6FK0LrC
 MEK7qJArECWKEDJ2YvQZr57J7v1YubI2W9wygYPt+qMWthlE8RMI8MIU6LgH0Kao
 /O67GYS+Ckm1cgXrRBv68P6Klg+Kdbe6J1s+H96m8RjYLQaMgHEUWwgFzMW1uZy4
 jb0TupHApaGwKimeEbUb5DW8QJf+K2avM2o9nsWYXM03fwjPaVAAHlI7XcI1NCq3
 7X7eancqZgwG5C1ozX2IdS7As45v4ysp/4pRhFWK8Eu8ReQ2S4j/omoEMm7st4wp
 RDcBRstJguDHuA==
X-ME-Sender: <xms:tLlpX40B6R5PjqqDHADEBIt8rnFSHEGE_wBQd2f20exiw5YxbbeYgA>
 <xme:tLlpXzFzjHzizOJRFM7Q9kFCjIl9ERQMU8ypIom0N9wKT75PHMlCnbvFsZZ2gqyPI
 bIC2SloP8XJOFlVoL4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudeggddtkecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepmfhlrghushcu
 lfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrthhtvg
 hrnhepueelteegieeuhffgkeefgfevjeeigfetkeeitdfgtdeifefhtdfhfeeuffevgfek
 necukfhppeektddrudeijedrleekrdduledtnecuvehluhhsthgvrhfuihiivgeptdenuc
 frrghrrghmpehmrghilhhfrhhomhepihhtshesihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:tLlpXw5q191NVG5vgh0lvptbo1guM4689j7y5a-3BoWcH16_lEODng>
 <xmx:tLlpXx0ozCviH5Ryue81biD_VK9aqDWa_7nSB7Dy_9BrgUvcJVhhJA>
 <xmx:tLlpX7Hm9m7w5X4NtPyst0dmi54kJIWgBS2Wgv9IEgMbAarLNFcZyw>
 <xmx:tLlpX60rLT2eiwV0ogrrDIm2j8tbPZcnrrxP71_gF9OBSe90Hsa18A>
Received: from apples.local (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id D7E063064688;
 Tue, 22 Sep 2020 04:45:38 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 03/17] hw/block/nvme: handle dma errors
Date: Tue, 22 Sep 2020 10:45:19 +0200
Message-Id: <20200922084533.1273962-4-its@irrelevant.dk>
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
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Handling DMA errors gracefully is required for the device to pass the
block/011 test ("disable PCI device while doing I/O") in the blktests
suite.

With this patch the device sets the Controller Fatal Status bit in the
CSTS register when failing to read from a submission queue or writing to
a completion queue; expecting the host to reset the controller.

If DMA errors occur at any other point in the execution of the command
(say, while mapping the PRPs), the command is aborted with a Data
Transfer Error status code.

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/block/nvme.c       | 41 +++++++++++++++++++++++++++++++----------
 hw/block/trace-events |  3 +++
 2 files changed, 34 insertions(+), 10 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 63078f600920..744ff3d86c22 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -140,14 +140,14 @@ static inline void *nvme_addr_to_cmb(NvmeCtrl *n, hwaddr addr)
     return &n->cmbuf[addr - n->ctrl_mem.addr];
 }
 
-static void nvme_addr_read(NvmeCtrl *n, hwaddr addr, void *buf, int size)
+static int nvme_addr_read(NvmeCtrl *n, hwaddr addr, void *buf, int size)
 {
     if (n->bar.cmbsz && nvme_addr_is_cmb(n, addr)) {
         memcpy(buf, nvme_addr_to_cmb(n, addr), size);
-        return;
+        return 0;
     }
 
-    pci_dma_read(&n->parent_obj, addr, buf, size);
+    return pci_dma_read(&n->parent_obj, addr, buf, size);
 }
 
 static int nvme_check_sqid(NvmeCtrl *n, uint16_t sqid)
@@ -307,6 +307,7 @@ static uint16_t nvme_map_prp(NvmeCtrl *n, uint64_t prp1, uint64_t prp2,
     int num_prps = (len >> n->page_bits) + 1;
     uint16_t status;
     bool prp_list_in_cmb = false;
+    int ret;
 
     QEMUSGList *qsg = &req->qsg;
     QEMUIOVector *iov = &req->iov;
@@ -347,7 +348,11 @@ static uint16_t nvme_map_prp(NvmeCtrl *n, uint64_t prp1, uint64_t prp2,
 
             nents = (len + n->page_size - 1) >> n->page_bits;
             prp_trans = MIN(n->max_prp_ents, nents) * sizeof(uint64_t);
-            nvme_addr_read(n, prp2, (void *)prp_list, prp_trans);
+            ret = nvme_addr_read(n, prp2, (void *)prp_list, prp_trans);
+            if (ret) {
+                trace_pci_nvme_err_addr_read(prp2);
+                return NVME_DATA_TRAS_ERROR;
+            }
             while (len != 0) {
                 uint64_t prp_ent = le64_to_cpu(prp_list[i]);
 
@@ -364,8 +369,12 @@ static uint16_t nvme_map_prp(NvmeCtrl *n, uint64_t prp1, uint64_t prp2,
                     i = 0;
                     nents = (len + n->page_size - 1) >> n->page_bits;
                     prp_trans = MIN(n->max_prp_ents, nents) * sizeof(uint64_t);
-                    nvme_addr_read(n, prp_ent, (void *)prp_list,
-                        prp_trans);
+                    ret = nvme_addr_read(n, prp_ent, (void *)prp_list,
+                                         prp_trans);
+                    if (ret) {
+                        trace_pci_nvme_err_addr_read(prp_ent);
+                        return NVME_DATA_TRAS_ERROR;
+                    }
                     prp_ent = le64_to_cpu(prp_list[i]);
                 }
 
@@ -457,6 +466,7 @@ static void nvme_post_cqes(void *opaque)
     NvmeCQueue *cq = opaque;
     NvmeCtrl *n = cq->ctrl;
     NvmeRequest *req, *next;
+    int ret;
 
     QTAILQ_FOREACH_SAFE(req, &cq->req_list, entry, next) {
         NvmeSQueue *sq;
@@ -466,15 +476,21 @@ static void nvme_post_cqes(void *opaque)
             break;
         }
 
-        QTAILQ_REMOVE(&cq->req_list, req, entry);
         sq = req->sq;
         req->cqe.status = cpu_to_le16((req->status << 1) | cq->phase);
         req->cqe.sq_id = cpu_to_le16(sq->sqid);
         req->cqe.sq_head = cpu_to_le16(sq->head);
         addr = cq->dma_addr + cq->tail * n->cqe_size;
+        ret = pci_dma_write(&n->parent_obj, addr, (void *)&req->cqe,
+                            sizeof(req->cqe));
+        if (ret) {
+            trace_pci_nvme_err_addr_write(addr);
+            trace_pci_nvme_err_cfs();
+            n->bar.csts = NVME_CSTS_FAILED;
+            break;
+        }
+        QTAILQ_REMOVE(&cq->req_list, req, entry);
         nvme_inc_cq_tail(cq);
-        pci_dma_write(&n->parent_obj, addr, (void *)&req->cqe,
-            sizeof(req->cqe));
         nvme_req_exit(req);
         QTAILQ_INSERT_TAIL(&sq->req_list, req, entry);
     }
@@ -1611,7 +1627,12 @@ static void nvme_process_sq(void *opaque)
 
     while (!(nvme_sq_empty(sq) || QTAILQ_EMPTY(&sq->req_list))) {
         addr = sq->dma_addr + sq->head * n->sqe_size;
-        nvme_addr_read(n, addr, (void *)&cmd, sizeof(cmd));
+        if (nvme_addr_read(n, addr, (void *)&cmd, sizeof(cmd))) {
+            trace_pci_nvme_err_addr_read(addr);
+            trace_pci_nvme_err_cfs();
+            n->bar.csts = NVME_CSTS_FAILED;
+            break;
+        }
         nvme_inc_sq_head(sq);
 
         req = QTAILQ_FIRST(&sq->req_list);
diff --git a/hw/block/trace-events b/hw/block/trace-events
index 8ff4cbc4932c..5589db4a014f 100644
--- a/hw/block/trace-events
+++ b/hw/block/trace-events
@@ -86,6 +86,9 @@ pci_nvme_mmio_shutdown_cleared(void) "shutdown bit cleared"
 
 # nvme traces for error conditions
 pci_nvme_err_mdts(uint16_t cid, size_t len) "cid %"PRIu16" len %zu"
+pci_nvme_err_addr_read(uint64_t addr) "addr 0x%"PRIx64""
+pci_nvme_err_addr_write(uint64_t addr) "addr 0x%"PRIx64""
+pci_nvme_err_cfs(void) "controller fatal status"
 pci_nvme_err_invalid_dma(void) "PRP/SGL is too small for transfer size"
 pci_nvme_err_invalid_prplist_ent(uint64_t prplist) "PRP list entry is null or not page aligned: 0x%"PRIx64""
 pci_nvme_err_invalid_prp2_align(uint64_t prp2) "PRP2 is not page aligned: 0x%"PRIx64""
-- 
2.28.0


