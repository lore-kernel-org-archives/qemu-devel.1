Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77C66C4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 10:54:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BAAF12224E
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 10:54:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAAF12224E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56466 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXMcY-000257-7k
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 06:54:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38406)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kXMXv-0008O4-Lw; Tue, 27 Oct 2020 06:49:43 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:57665)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kXMXs-00024s-Ct; Tue, 27 Oct 2020 06:49:43 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.nyi.internal (Postfix) with ESMTP id 667675C0151;
 Tue, 27 Oct 2020 06:49:38 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute4.internal (MEProxy); Tue, 27 Oct 2020 06:49:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm1; bh=roxoMNw49As2y
 i23cCyby3/Age41Q4J1fpwY5qlhL6s=; b=dA9ISxKSK/eFJJWC1uMv1DofjLzYk
 OAssbRzm1pYznZj9vizBwE1Xf67o3Ihz/W2/gaKGA4nkLov74exawr4PeP86aqiI
 g7iNvKZ72lTu7ZjmuGTQZ4mfO7iIMN5uRkbNseDE/FaMY/YRjFd4/6VkHLDWI3Ky
 wr4ejTpseiyiWRqRwTlfFZR1zyqWGId4q4IleOrFCBSiTfliV+Mei7swVjFq8TJ1
 xXs21hHHPw5GI4A7nnI6w79IvibR0+/HMTmXc4L3B0Kc4JbTvhTlbYLt7WjZ6Ebn
 NoVyAXAky7cIGljXYoPXr1Ypw3ylF+ZRXVhn87T9U46Az0znAOKPkoZXg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm1; bh=roxoMNw49As2yi23cCyby3/Age41Q4J1fpwY5qlhL6s=; b=NCor4GKj
 zR2VpZ0jKMj4TD4GS+Xy5bAin87JhHPjTrWQrImJhOAYYQ9hQnKVu4eB873I0KoS
 iZaFQU0bfc9fDJEQID19AN3imSS7lAk15P5dZG1HPaFM/MO+THzZT8pdh+U4JfDQ
 oXDesnDfImjNozagydoLXQT8SLRT/KKcewDhT6KqnoleoDOqElKEZKyR74SXTe42
 SqLokzBc2La7fRGykDqLRc3VtlKsRJKMHprbCAO5V9LlFTPsTwZKL02AxM6BM52W
 WBwXYncDT8rqUyxiO3uPRgD5f0QBUkSEIyp2AbHtwnTO84KQlPsrijThHtaLkN1e
 f84785EjuSjSUQ==
X-ME-Sender: <xms:QvuXX0vnxsgGuzTDEoyuFiaTUTAwtRnOndrPZCkl7_aKRCDn4VBJYg>
 <xme:QvuXXxf5l7uBLPJa2S_VA4YhnkS479KvMqshGHhT787VKhlFXWkBjbhzdYaDNPnio
 lxhWF8mPw0ge56hRP4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrkeelgddvtdcutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepmfhlrghushcu
 lfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrthhtvg
 hrnhepueelteegieeuhffgkeefgfevjeeigfetkeeitdfgtdeifefhtdfhfeeuffevgfek
 necukfhppeektddrudeijedrleekrdduledtnecuvehluhhsthgvrhfuihiivgeptdenuc
 frrghrrghmpehmrghilhhfrhhomhepihhtshesihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:QvuXX_wQFPRP-lNx6C2VGbhbcWBxv4r4EphxFvzsSIZ-YnBzZ3A65Q>
 <xmx:QvuXX3MPAWk2sgX-IYoYqYgtdBVYcIQNQS_8X9pXR4SAEi1ackeRjA>
 <xmx:QvuXX0-qnN2oTkke2k3Schep7dSxSynpez4aGgGwelmDz76hpT_7gg>
 <xmx:QvuXXzbp5d0Sdr1QxNoaaVvJ9uglQcONHy2Q0a6olWVHI9u2P7tVSg>
Received: from apples.local (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id 5C40D3280065;
 Tue, 27 Oct 2020 06:49:37 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 03/30] hw/block/nvme: handle dma errors
Date: Tue, 27 Oct 2020 11:49:05 +0100
Message-Id: <20201027104932.558087-4-its@irrelevant.dk>
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
Reviewed-by: Keith Busch <kbusch@kernel.org>
---
 hw/block/nvme.c       | 41 +++++++++++++++++++++++++++++++----------
 hw/block/trace-events |  3 +++
 2 files changed, 34 insertions(+), 10 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 44fa5b90769b..7d328c08b894 100644
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
@@ -1606,7 +1622,12 @@ static void nvme_process_sq(void *opaque)
 
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
2.29.1


