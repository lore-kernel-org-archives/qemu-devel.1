Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB3B8C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 19:13:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 840B62067B
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 19:13:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 840B62067B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53692 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jijga-0002Qn-KT
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 15:13:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44618)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1jijXI-0005zp-56; Tue, 09 Jun 2020 15:03:48 -0400
Received: from charlie.dont.surf ([128.199.63.193]:40192)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1jijXD-0006gm-O7; Tue, 09 Jun 2020 15:03:47 -0400
Received: from apples.local (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by charlie.dont.surf (Postfix) with ESMTPSA id C6497BF7FA;
 Tue,  9 Jun 2020 19:03:41 +0000 (UTC)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-block@nongnu.org
Subject: [PATCH v7 02/22] hw/block/nvme: rename trace events to pci_nvme
Date: Tue,  9 Jun 2020 21:03:13 +0200
Message-Id: <20200609190333.59390-3-its@irrelevant.dk>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200609190333.59390-1-its@irrelevant.dk>
References: <20200609190333.59390-1-its@irrelevant.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=128.199.63.193; envelope-from=its@irrelevant.dk;
 helo=charlie.dont.surf
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 14:38:46
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, Klaus Jensen <k.jensen@samsung.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Klaus Jensen <its@irrelevant.dk>, Keith Busch <kbusch@kernel.org>,
 Javier Gonzalez <javier.gonz@samsung.com>,
 Maxim Levitsky <mlevitsk@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Klaus Jensen <k.jensen@samsung.com>

Change the prefix of all nvme device related trace events to 'pci_nvme'
to not clash with trace events from the nvme block driver.

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
Reviewed-by: Keith Busch <kbusch@kernel.org>
Message-Id: <20200514044611.734782-3-its@irrelevant.dk>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 hw/block/nvme.c       | 198 +++++++++++++++++++++---------------------
 hw/block/trace-events | 180 +++++++++++++++++++-------------------
 2 files changed, 188 insertions(+), 190 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index c1476e8b2a60..e8f5c5ab829b 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -125,16 +125,16 @@ static void nvme_irq_assert(NvmeCtrl *n, NvmeCQueue *cq)
 {
     if (cq->irq_enabled) {
         if (msix_enabled(&(n->parent_obj))) {
-            trace_nvme_irq_msix(cq->vector);
+            trace_pci_nvme_irq_msix(cq->vector);
             msix_notify(&(n->parent_obj), cq->vector);
         } else {
-            trace_nvme_irq_pin();
+            trace_pci_nvme_irq_pin();
             assert(cq->cqid < 64);
             n->irq_status |= 1 << cq->cqid;
             nvme_irq_check(n);
         }
     } else {
-        trace_nvme_irq_masked();
+        trace_pci_nvme_irq_masked();
     }
 }
 
@@ -159,7 +159,7 @@ static uint16_t nvme_map_prp(QEMUSGList *qsg, QEMUIOVector *iov, uint64_t prp1,
     int num_prps = (len >> n->page_bits) + 1;
 
     if (unlikely(!prp1)) {
-        trace_nvme_err_invalid_prp();
+        trace_pci_nvme_err_invalid_prp();
         return NVME_INVALID_FIELD | NVME_DNR;
     } else if (n->cmbsz && prp1 >= n->ctrl_mem.addr &&
                prp1 < n->ctrl_mem.addr + int128_get64(n->ctrl_mem.size)) {
@@ -173,7 +173,7 @@ static uint16_t nvme_map_prp(QEMUSGList *qsg, QEMUIOVector *iov, uint64_t prp1,
     len -= trans_len;
     if (len) {
         if (unlikely(!prp2)) {
-            trace_nvme_err_invalid_prp2_missing();
+            trace_pci_nvme_err_invalid_prp2_missing();
             goto unmap;
         }
         if (len > n->page_size) {
@@ -189,7 +189,7 @@ static uint16_t nvme_map_prp(QEMUSGList *qsg, QEMUIOVector *iov, uint64_t prp1,
 
                 if (i == n->max_prp_ents - 1 && len > n->page_size) {
                     if (unlikely(!prp_ent || prp_ent & (n->page_size - 1))) {
-                        trace_nvme_err_invalid_prplist_ent(prp_ent);
+                        trace_pci_nvme_err_invalid_prplist_ent(prp_ent);
                         goto unmap;
                     }
 
@@ -202,7 +202,7 @@ static uint16_t nvme_map_prp(QEMUSGList *qsg, QEMUIOVector *iov, uint64_t prp1,
                 }
 
                 if (unlikely(!prp_ent || prp_ent & (n->page_size - 1))) {
-                    trace_nvme_err_invalid_prplist_ent(prp_ent);
+                    trace_pci_nvme_err_invalid_prplist_ent(prp_ent);
                     goto unmap;
                 }
 
@@ -217,7 +217,7 @@ static uint16_t nvme_map_prp(QEMUSGList *qsg, QEMUIOVector *iov, uint64_t prp1,
             }
         } else {
             if (unlikely(prp2 & (n->page_size - 1))) {
-                trace_nvme_err_invalid_prp2_align(prp2);
+                trace_pci_nvme_err_invalid_prp2_align(prp2);
                 goto unmap;
             }
             if (qsg->nsg) {
@@ -265,20 +265,20 @@ static uint16_t nvme_dma_read_prp(NvmeCtrl *n, uint8_t *ptr, uint32_t len,
     QEMUIOVector iov;
     uint16_t status = NVME_SUCCESS;
 
-    trace_nvme_dma_read(prp1, prp2);
+    trace_pci_nvme_dma_read(prp1, prp2);
 
     if (nvme_map_prp(&qsg, &iov, prp1, prp2, len, n)) {
         return NVME_INVALID_FIELD | NVME_DNR;
     }
     if (qsg.nsg > 0) {
         if (unlikely(dma_buf_read(ptr, len, &qsg))) {
-            trace_nvme_err_invalid_dma();
+            trace_pci_nvme_err_invalid_dma();
             status = NVME_INVALID_FIELD | NVME_DNR;
         }
         qemu_sglist_destroy(&qsg);
     } else {
         if (unlikely(qemu_iovec_from_buf(&iov, 0, ptr, len) != len)) {
-            trace_nvme_err_invalid_dma();
+            trace_pci_nvme_err_invalid_dma();
             status = NVME_INVALID_FIELD | NVME_DNR;
         }
         qemu_iovec_destroy(&iov);
@@ -367,7 +367,7 @@ static uint16_t nvme_write_zeros(NvmeCtrl *n, NvmeNamespace *ns, NvmeCmd *cmd,
     uint32_t count = nlb << data_shift;
 
     if (unlikely(slba + nlb > ns->id_ns.nsze)) {
-        trace_nvme_err_invalid_lba_range(slba, nlb, ns->id_ns.nsze);
+        trace_pci_nvme_err_invalid_lba_range(slba, nlb, ns->id_ns.nsze);
         return NVME_LBA_RANGE | NVME_DNR;
     }
 
@@ -395,11 +395,11 @@ static uint16_t nvme_rw(NvmeCtrl *n, NvmeNamespace *ns, NvmeCmd *cmd,
     int is_write = rw->opcode == NVME_CMD_WRITE ? 1 : 0;
     enum BlockAcctType acct = is_write ? BLOCK_ACCT_WRITE : BLOCK_ACCT_READ;
 
-    trace_nvme_rw(is_write ? "write" : "read", nlb, data_size, slba);
+    trace_pci_nvme_rw(is_write ? "write" : "read", nlb, data_size, slba);
 
     if (unlikely((slba + nlb) > ns->id_ns.nsze)) {
         block_acct_invalid(blk_get_stats(n->conf.blk), acct);
-        trace_nvme_err_invalid_lba_range(slba, nlb, ns->id_ns.nsze);
+        trace_pci_nvme_err_invalid_lba_range(slba, nlb, ns->id_ns.nsze);
         return NVME_LBA_RANGE | NVME_DNR;
     }
 
@@ -434,7 +434,7 @@ static uint16_t nvme_io_cmd(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
     uint32_t nsid = le32_to_cpu(cmd->nsid);
 
     if (unlikely(nsid == 0 || nsid > n->num_namespaces)) {
-        trace_nvme_err_invalid_ns(nsid, n->num_namespaces);
+        trace_pci_nvme_err_invalid_ns(nsid, n->num_namespaces);
         return NVME_INVALID_NSID | NVME_DNR;
     }
 
@@ -448,7 +448,7 @@ static uint16_t nvme_io_cmd(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
     case NVME_CMD_READ:
         return nvme_rw(n, ns, cmd, req);
     default:
-        trace_nvme_err_invalid_opc(cmd->opcode);
+        trace_pci_nvme_err_invalid_opc(cmd->opcode);
         return NVME_INVALID_OPCODE | NVME_DNR;
     }
 }
@@ -473,11 +473,11 @@ static uint16_t nvme_del_sq(NvmeCtrl *n, NvmeCmd *cmd)
     uint16_t qid = le16_to_cpu(c->qid);
 
     if (unlikely(!qid || nvme_check_sqid(n, qid))) {
-        trace_nvme_err_invalid_del_sq(qid);
+        trace_pci_nvme_err_invalid_del_sq(qid);
         return NVME_INVALID_QID | NVME_DNR;
     }
 
-    trace_nvme_del_sq(qid);
+    trace_pci_nvme_del_sq(qid);
 
     sq = n->sq[qid];
     while (!QTAILQ_EMPTY(&sq->out_req_list)) {
@@ -541,26 +541,26 @@ static uint16_t nvme_create_sq(NvmeCtrl *n, NvmeCmd *cmd)
     uint16_t qflags = le16_to_cpu(c->sq_flags);
     uint64_t prp1 = le64_to_cpu(c->prp1);
 
-    trace_nvme_create_sq(prp1, sqid, cqid, qsize, qflags);
+    trace_pci_nvme_create_sq(prp1, sqid, cqid, qsize, qflags);
 
     if (unlikely(!cqid || nvme_check_cqid(n, cqid))) {
-        trace_nvme_err_invalid_create_sq_cqid(cqid);
+        trace_pci_nvme_err_invalid_create_sq_cqid(cqid);
         return NVME_INVALID_CQID | NVME_DNR;
     }
     if (unlikely(!sqid || !nvme_check_sqid(n, sqid))) {
-        trace_nvme_err_invalid_create_sq_sqid(sqid);
+        trace_pci_nvme_err_invalid_create_sq_sqid(sqid);
         return NVME_INVALID_QID | NVME_DNR;
     }
     if (unlikely(!qsize || qsize > NVME_CAP_MQES(n->bar.cap))) {
-        trace_nvme_err_invalid_create_sq_size(qsize);
+        trace_pci_nvme_err_invalid_create_sq_size(qsize);
         return NVME_MAX_QSIZE_EXCEEDED | NVME_DNR;
     }
     if (unlikely(!prp1 || prp1 & (n->page_size - 1))) {
-        trace_nvme_err_invalid_create_sq_addr(prp1);
+        trace_pci_nvme_err_invalid_create_sq_addr(prp1);
         return NVME_INVALID_FIELD | NVME_DNR;
     }
     if (unlikely(!(NVME_SQ_FLAGS_PC(qflags)))) {
-        trace_nvme_err_invalid_create_sq_qflags(NVME_SQ_FLAGS_PC(qflags));
+        trace_pci_nvme_err_invalid_create_sq_qflags(NVME_SQ_FLAGS_PC(qflags));
         return NVME_INVALID_FIELD | NVME_DNR;
     }
     sq = g_malloc0(sizeof(*sq));
@@ -586,17 +586,17 @@ static uint16_t nvme_del_cq(NvmeCtrl *n, NvmeCmd *cmd)
     uint16_t qid = le16_to_cpu(c->qid);
 
     if (unlikely(!qid || nvme_check_cqid(n, qid))) {
-        trace_nvme_err_invalid_del_cq_cqid(qid);
+        trace_pci_nvme_err_invalid_del_cq_cqid(qid);
         return NVME_INVALID_CQID | NVME_DNR;
     }
 
     cq = n->cq[qid];
     if (unlikely(!QTAILQ_EMPTY(&cq->sq_list))) {
-        trace_nvme_err_invalid_del_cq_notempty(qid);
+        trace_pci_nvme_err_invalid_del_cq_notempty(qid);
         return NVME_INVALID_QUEUE_DEL;
     }
     nvme_irq_deassert(n, cq);
-    trace_nvme_del_cq(qid);
+    trace_pci_nvme_del_cq(qid);
     nvme_free_cq(cq, n);
     return NVME_SUCCESS;
 }
@@ -629,27 +629,27 @@ static uint16_t nvme_create_cq(NvmeCtrl *n, NvmeCmd *cmd)
     uint16_t qflags = le16_to_cpu(c->cq_flags);
     uint64_t prp1 = le64_to_cpu(c->prp1);
 
-    trace_nvme_create_cq(prp1, cqid, vector, qsize, qflags,
-                         NVME_CQ_FLAGS_IEN(qflags) != 0);
+    trace_pci_nvme_create_cq(prp1, cqid, vector, qsize, qflags,
+                             NVME_CQ_FLAGS_IEN(qflags) != 0);
 
     if (unlikely(!cqid || !nvme_check_cqid(n, cqid))) {
-        trace_nvme_err_invalid_create_cq_cqid(cqid);
+        trace_pci_nvme_err_invalid_create_cq_cqid(cqid);
         return NVME_INVALID_CQID | NVME_DNR;
     }
     if (unlikely(!qsize || qsize > NVME_CAP_MQES(n->bar.cap))) {
-        trace_nvme_err_invalid_create_cq_size(qsize);
+        trace_pci_nvme_err_invalid_create_cq_size(qsize);
         return NVME_MAX_QSIZE_EXCEEDED | NVME_DNR;
     }
     if (unlikely(!prp1)) {
-        trace_nvme_err_invalid_create_cq_addr(prp1);
+        trace_pci_nvme_err_invalid_create_cq_addr(prp1);
         return NVME_INVALID_FIELD | NVME_DNR;
     }
     if (unlikely(vector > n->num_queues)) {
-        trace_nvme_err_invalid_create_cq_vector(vector);
+        trace_pci_nvme_err_invalid_create_cq_vector(vector);
         return NVME_INVALID_IRQ_VECTOR | NVME_DNR;
     }
     if (unlikely(!(NVME_CQ_FLAGS_PC(qflags)))) {
-        trace_nvme_err_invalid_create_cq_qflags(NVME_CQ_FLAGS_PC(qflags));
+        trace_pci_nvme_err_invalid_create_cq_qflags(NVME_CQ_FLAGS_PC(qflags));
         return NVME_INVALID_FIELD | NVME_DNR;
     }
 
@@ -664,7 +664,7 @@ static uint16_t nvme_identify_ctrl(NvmeCtrl *n, NvmeIdentify *c)
     uint64_t prp1 = le64_to_cpu(c->prp1);
     uint64_t prp2 = le64_to_cpu(c->prp2);
 
-    trace_nvme_identify_ctrl();
+    trace_pci_nvme_identify_ctrl();
 
     return nvme_dma_read_prp(n, (uint8_t *)&n->id_ctrl, sizeof(n->id_ctrl),
         prp1, prp2);
@@ -677,10 +677,10 @@ static uint16_t nvme_identify_ns(NvmeCtrl *n, NvmeIdentify *c)
     uint64_t prp1 = le64_to_cpu(c->prp1);
     uint64_t prp2 = le64_to_cpu(c->prp2);
 
-    trace_nvme_identify_ns(nsid);
+    trace_pci_nvme_identify_ns(nsid);
 
     if (unlikely(nsid == 0 || nsid > n->num_namespaces)) {
-        trace_nvme_err_invalid_ns(nsid, n->num_namespaces);
+        trace_pci_nvme_err_invalid_ns(nsid, n->num_namespaces);
         return NVME_INVALID_NSID | NVME_DNR;
     }
 
@@ -700,7 +700,7 @@ static uint16_t nvme_identify_nslist(NvmeCtrl *n, NvmeIdentify *c)
     uint16_t ret;
     int i, j = 0;
 
-    trace_nvme_identify_nslist(min_nsid);
+    trace_pci_nvme_identify_nslist(min_nsid);
 
     list = g_malloc0(data_len);
     for (i = 0; i < n->num_namespaces; i++) {
@@ -729,14 +729,14 @@ static uint16_t nvme_identify(NvmeCtrl *n, NvmeCmd *cmd)
     case 0x02:
         return nvme_identify_nslist(n, c);
     default:
-        trace_nvme_err_invalid_identify_cns(le32_to_cpu(c->cns));
+        trace_pci_nvme_err_invalid_identify_cns(le32_to_cpu(c->cns));
         return NVME_INVALID_FIELD | NVME_DNR;
     }
 }
 
 static inline void nvme_set_timestamp(NvmeCtrl *n, uint64_t ts)
 {
-    trace_nvme_setfeat_timestamp(ts);
+    trace_pci_nvme_setfeat_timestamp(ts);
 
     n->host_timestamp = le64_to_cpu(ts);
     n->timestamp_set_qemu_clock_ms = qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL);
@@ -769,7 +769,7 @@ static inline uint64_t nvme_get_timestamp(const NvmeCtrl *n)
     /* If the host timestamp is non-zero, set the timestamp origin */
     ts.origin = n->host_timestamp ? 0x01 : 0x00;
 
-    trace_nvme_getfeat_timestamp(ts.all);
+    trace_pci_nvme_getfeat_timestamp(ts.all);
 
     return cpu_to_le64(ts.all);
 }
@@ -793,17 +793,17 @@ static uint16_t nvme_get_feature(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
     switch (dw10) {
     case NVME_VOLATILE_WRITE_CACHE:
         result = blk_enable_write_cache(n->conf.blk);
-        trace_nvme_getfeat_vwcache(result ? "enabled" : "disabled");
+        trace_pci_nvme_getfeat_vwcache(result ? "enabled" : "disabled");
         break;
     case NVME_NUMBER_OF_QUEUES:
         result = cpu_to_le32((n->num_queues - 2) | ((n->num_queues - 2) << 16));
-        trace_nvme_getfeat_numq(result);
+        trace_pci_nvme_getfeat_numq(result);
         break;
     case NVME_TIMESTAMP:
         return nvme_get_feature_timestamp(n, cmd);
         break;
     default:
-        trace_nvme_err_invalid_getfeat(dw10);
+        trace_pci_nvme_err_invalid_getfeat(dw10);
         return NVME_INVALID_FIELD | NVME_DNR;
     }
 
@@ -839,9 +839,9 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
         blk_set_enable_write_cache(n->conf.blk, dw11 & 1);
         break;
     case NVME_NUMBER_OF_QUEUES:
-        trace_nvme_setfeat_numq((dw11 & 0xFFFF) + 1,
-                                ((dw11 >> 16) & 0xFFFF) + 1,
-                                n->num_queues - 1, n->num_queues - 1);
+        trace_pci_nvme_setfeat_numq((dw11 & 0xFFFF) + 1,
+                                    ((dw11 >> 16) & 0xFFFF) + 1,
+                                    n->num_queues - 1, n->num_queues - 1);
         req->cqe.result =
             cpu_to_le32((n->num_queues - 2) | ((n->num_queues - 2) << 16));
         break;
@@ -851,7 +851,7 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
         break;
 
     default:
-        trace_nvme_err_invalid_setfeat(dw10);
+        trace_pci_nvme_err_invalid_setfeat(dw10);
         return NVME_INVALID_FIELD | NVME_DNR;
     }
     return NVME_SUCCESS;
@@ -875,7 +875,7 @@ static uint16_t nvme_admin_cmd(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
     case NVME_ADM_CMD_GET_FEATURES:
         return nvme_get_feature(n, cmd, req);
     default:
-        trace_nvme_err_invalid_admin_opc(cmd->opcode);
+        trace_pci_nvme_err_invalid_admin_opc(cmd->opcode);
         return NVME_INVALID_OPCODE | NVME_DNR;
     }
 }
@@ -938,77 +938,77 @@ static int nvme_start_ctrl(NvmeCtrl *n)
     uint32_t page_size = 1 << page_bits;
 
     if (unlikely(n->cq[0])) {
-        trace_nvme_err_startfail_cq();
+        trace_pci_nvme_err_startfail_cq();
         return -1;
     }
     if (unlikely(n->sq[0])) {
-        trace_nvme_err_startfail_sq();
+        trace_pci_nvme_err_startfail_sq();
         return -1;
     }
     if (unlikely(!n->bar.asq)) {
-        trace_nvme_err_startfail_nbarasq();
+        trace_pci_nvme_err_startfail_nbarasq();
         return -1;
     }
     if (unlikely(!n->bar.acq)) {
-        trace_nvme_err_startfail_nbaracq();
+        trace_pci_nvme_err_startfail_nbaracq();
         return -1;
     }
     if (unlikely(n->bar.asq & (page_size - 1))) {
-        trace_nvme_err_startfail_asq_misaligned(n->bar.asq);
+        trace_pci_nvme_err_startfail_asq_misaligned(n->bar.asq);
         return -1;
     }
     if (unlikely(n->bar.acq & (page_size - 1))) {
-        trace_nvme_err_startfail_acq_misaligned(n->bar.acq);
+        trace_pci_nvme_err_startfail_acq_misaligned(n->bar.acq);
         return -1;
     }
     if (unlikely(NVME_CC_MPS(n->bar.cc) <
                  NVME_CAP_MPSMIN(n->bar.cap))) {
-        trace_nvme_err_startfail_page_too_small(
+        trace_pci_nvme_err_startfail_page_too_small(
                     NVME_CC_MPS(n->bar.cc),
                     NVME_CAP_MPSMIN(n->bar.cap));
         return -1;
     }
     if (unlikely(NVME_CC_MPS(n->bar.cc) >
                  NVME_CAP_MPSMAX(n->bar.cap))) {
-        trace_nvme_err_startfail_page_too_large(
+        trace_pci_nvme_err_startfail_page_too_large(
                     NVME_CC_MPS(n->bar.cc),
                     NVME_CAP_MPSMAX(n->bar.cap));
         return -1;
     }
     if (unlikely(NVME_CC_IOCQES(n->bar.cc) <
                  NVME_CTRL_CQES_MIN(n->id_ctrl.cqes))) {
-        trace_nvme_err_startfail_cqent_too_small(
+        trace_pci_nvme_err_startfail_cqent_too_small(
                     NVME_CC_IOCQES(n->bar.cc),
                     NVME_CTRL_CQES_MIN(n->bar.cap));
         return -1;
     }
     if (unlikely(NVME_CC_IOCQES(n->bar.cc) >
                  NVME_CTRL_CQES_MAX(n->id_ctrl.cqes))) {
-        trace_nvme_err_startfail_cqent_too_large(
+        trace_pci_nvme_err_startfail_cqent_too_large(
                     NVME_CC_IOCQES(n->bar.cc),
                     NVME_CTRL_CQES_MAX(n->bar.cap));
         return -1;
     }
     if (unlikely(NVME_CC_IOSQES(n->bar.cc) <
                  NVME_CTRL_SQES_MIN(n->id_ctrl.sqes))) {
-        trace_nvme_err_startfail_sqent_too_small(
+        trace_pci_nvme_err_startfail_sqent_too_small(
                     NVME_CC_IOSQES(n->bar.cc),
                     NVME_CTRL_SQES_MIN(n->bar.cap));
         return -1;
     }
     if (unlikely(NVME_CC_IOSQES(n->bar.cc) >
                  NVME_CTRL_SQES_MAX(n->id_ctrl.sqes))) {
-        trace_nvme_err_startfail_sqent_too_large(
+        trace_pci_nvme_err_startfail_sqent_too_large(
                     NVME_CC_IOSQES(n->bar.cc),
                     NVME_CTRL_SQES_MAX(n->bar.cap));
         return -1;
     }
     if (unlikely(!NVME_AQA_ASQS(n->bar.aqa))) {
-        trace_nvme_err_startfail_asqent_sz_zero();
+        trace_pci_nvme_err_startfail_asqent_sz_zero();
         return -1;
     }
     if (unlikely(!NVME_AQA_ACQS(n->bar.aqa))) {
-        trace_nvme_err_startfail_acqent_sz_zero();
+        trace_pci_nvme_err_startfail_acqent_sz_zero();
         return -1;
     }
 
@@ -1031,14 +1031,14 @@ static void nvme_write_bar(NvmeCtrl *n, hwaddr offset, uint64_t data,
     unsigned size)
 {
     if (unlikely(offset & (sizeof(uint32_t) - 1))) {
-        NVME_GUEST_ERR(nvme_ub_mmiowr_misaligned32,
+        NVME_GUEST_ERR(pci_nvme_ub_mmiowr_misaligned32,
                        "MMIO write not 32-bit aligned,"
                        " offset=0x%"PRIx64"", offset);
         /* should be ignored, fall through for now */
     }
 
     if (unlikely(size < sizeof(uint32_t))) {
-        NVME_GUEST_ERR(nvme_ub_mmiowr_toosmall,
+        NVME_GUEST_ERR(pci_nvme_ub_mmiowr_toosmall,
                        "MMIO write smaller than 32-bits,"
                        " offset=0x%"PRIx64", size=%u",
                        offset, size);
@@ -1048,32 +1048,30 @@ static void nvme_write_bar(NvmeCtrl *n, hwaddr offset, uint64_t data,
     switch (offset) {
     case 0xc:   /* INTMS */
         if (unlikely(msix_enabled(&(n->parent_obj)))) {
-            NVME_GUEST_ERR(nvme_ub_mmiowr_intmask_with_msix,
+            NVME_GUEST_ERR(pci_nvme_ub_mmiowr_intmask_with_msix,
                            "undefined access to interrupt mask set"
                            " when MSI-X is enabled");
             /* should be ignored, fall through for now */
         }
         n->bar.intms |= data & 0xffffffff;
         n->bar.intmc = n->bar.intms;
-        trace_nvme_mmio_intm_set(data & 0xffffffff,
-                                 n->bar.intmc);
+        trace_pci_nvme_mmio_intm_set(data & 0xffffffff, n->bar.intmc);
         nvme_irq_check(n);
         break;
     case 0x10:  /* INTMC */
         if (unlikely(msix_enabled(&(n->parent_obj)))) {
-            NVME_GUEST_ERR(nvme_ub_mmiowr_intmask_with_msix,
+            NVME_GUEST_ERR(pci_nvme_ub_mmiowr_intmask_with_msix,
                            "undefined access to interrupt mask clr"
                            " when MSI-X is enabled");
             /* should be ignored, fall through for now */
         }
         n->bar.intms &= ~(data & 0xffffffff);
         n->bar.intmc = n->bar.intms;
-        trace_nvme_mmio_intm_clr(data & 0xffffffff,
-                                 n->bar.intmc);
+        trace_pci_nvme_mmio_intm_clr(data & 0xffffffff, n->bar.intmc);
         nvme_irq_check(n);
         break;
     case 0x14:  /* CC */
-        trace_nvme_mmio_cfg(data & 0xffffffff);
+        trace_pci_nvme_mmio_cfg(data & 0xffffffff);
         /* Windows first sends data, then sends enable bit */
         if (!NVME_CC_EN(data) && !NVME_CC_EN(n->bar.cc) &&
             !NVME_CC_SHN(data) && !NVME_CC_SHN(n->bar.cc))
@@ -1084,42 +1082,42 @@ static void nvme_write_bar(NvmeCtrl *n, hwaddr offset, uint64_t data,
         if (NVME_CC_EN(data) && !NVME_CC_EN(n->bar.cc)) {
             n->bar.cc = data;
             if (unlikely(nvme_start_ctrl(n))) {
-                trace_nvme_err_startfail();
+                trace_pci_nvme_err_startfail();
                 n->bar.csts = NVME_CSTS_FAILED;
             } else {
-                trace_nvme_mmio_start_success();
+                trace_pci_nvme_mmio_start_success();
                 n->bar.csts = NVME_CSTS_READY;
             }
         } else if (!NVME_CC_EN(data) && NVME_CC_EN(n->bar.cc)) {
-            trace_nvme_mmio_stopped();
+            trace_pci_nvme_mmio_stopped();
             nvme_clear_ctrl(n);
             n->bar.csts &= ~NVME_CSTS_READY;
         }
         if (NVME_CC_SHN(data) && !(NVME_CC_SHN(n->bar.cc))) {
-            trace_nvme_mmio_shutdown_set();
+            trace_pci_nvme_mmio_shutdown_set();
             nvme_clear_ctrl(n);
             n->bar.cc = data;
             n->bar.csts |= NVME_CSTS_SHST_COMPLETE;
         } else if (!NVME_CC_SHN(data) && NVME_CC_SHN(n->bar.cc)) {
-            trace_nvme_mmio_shutdown_cleared();
+            trace_pci_nvme_mmio_shutdown_cleared();
             n->bar.csts &= ~NVME_CSTS_SHST_COMPLETE;
             n->bar.cc = data;
         }
         break;
     case 0x1C:  /* CSTS */
         if (data & (1 << 4)) {
-            NVME_GUEST_ERR(nvme_ub_mmiowr_ssreset_w1c_unsupported,
+            NVME_GUEST_ERR(pci_nvme_ub_mmiowr_ssreset_w1c_unsupported,
                            "attempted to W1C CSTS.NSSRO"
                            " but CAP.NSSRS is zero (not supported)");
         } else if (data != 0) {
-            NVME_GUEST_ERR(nvme_ub_mmiowr_ro_csts,
+            NVME_GUEST_ERR(pci_nvme_ub_mmiowr_ro_csts,
                            "attempted to set a read only bit"
                            " of controller status");
         }
         break;
     case 0x20:  /* NSSR */
         if (data == 0x4E564D65) {
-            trace_nvme_ub_mmiowr_ssreset_unsupported();
+            trace_pci_nvme_ub_mmiowr_ssreset_unsupported();
         } else {
             /* The spec says that writes of other values have no effect */
             return;
@@ -1127,55 +1125,55 @@ static void nvme_write_bar(NvmeCtrl *n, hwaddr offset, uint64_t data,
         break;
     case 0x24:  /* AQA */
         n->bar.aqa = data & 0xffffffff;
-        trace_nvme_mmio_aqattr(data & 0xffffffff);
+        trace_pci_nvme_mmio_aqattr(data & 0xffffffff);
         break;
     case 0x28:  /* ASQ */
         n->bar.asq = data;
-        trace_nvme_mmio_asqaddr(data);
+        trace_pci_nvme_mmio_asqaddr(data);
         break;
     case 0x2c:  /* ASQ hi */
         n->bar.asq |= data << 32;
-        trace_nvme_mmio_asqaddr_hi(data, n->bar.asq);
+        trace_pci_nvme_mmio_asqaddr_hi(data, n->bar.asq);
         break;
     case 0x30:  /* ACQ */
-        trace_nvme_mmio_acqaddr(data);
+        trace_pci_nvme_mmio_acqaddr(data);
         n->bar.acq = data;
         break;
     case 0x34:  /* ACQ hi */
         n->bar.acq |= data << 32;
-        trace_nvme_mmio_acqaddr_hi(data, n->bar.acq);
+        trace_pci_nvme_mmio_acqaddr_hi(data, n->bar.acq);
         break;
     case 0x38:  /* CMBLOC */
-        NVME_GUEST_ERR(nvme_ub_mmiowr_cmbloc_reserved,
+        NVME_GUEST_ERR(pci_nvme_ub_mmiowr_cmbloc_reserved,
                        "invalid write to reserved CMBLOC"
                        " when CMBSZ is zero, ignored");
         return;
     case 0x3C:  /* CMBSZ */
-        NVME_GUEST_ERR(nvme_ub_mmiowr_cmbsz_readonly,
+        NVME_GUEST_ERR(pci_nvme_ub_mmiowr_cmbsz_readonly,
                        "invalid write to read only CMBSZ, ignored");
         return;
     case 0xE00: /* PMRCAP */
-        NVME_GUEST_ERR(nvme_ub_mmiowr_pmrcap_readonly,
+        NVME_GUEST_ERR(pci_nvme_ub_mmiowr_pmrcap_readonly,
                        "invalid write to PMRCAP register, ignored");
         return;
     case 0xE04: /* TODO PMRCTL */
         break;
     case 0xE08: /* PMRSTS */
-        NVME_GUEST_ERR(nvme_ub_mmiowr_pmrsts_readonly,
+        NVME_GUEST_ERR(pci_nvme_ub_mmiowr_pmrsts_readonly,
                        "invalid write to PMRSTS register, ignored");
         return;
     case 0xE0C: /* PMREBS */
-        NVME_GUEST_ERR(nvme_ub_mmiowr_pmrebs_readonly,
+        NVME_GUEST_ERR(pci_nvme_ub_mmiowr_pmrebs_readonly,
                        "invalid write to PMREBS register, ignored");
         return;
     case 0xE10: /* PMRSWTP */
-        NVME_GUEST_ERR(nvme_ub_mmiowr_pmrswtp_readonly,
+        NVME_GUEST_ERR(pci_nvme_ub_mmiowr_pmrswtp_readonly,
                        "invalid write to PMRSWTP register, ignored");
         return;
     case 0xE14: /* TODO PMRMSC */
          break;
     default:
-        NVME_GUEST_ERR(nvme_ub_mmiowr_invalid,
+        NVME_GUEST_ERR(pci_nvme_ub_mmiowr_invalid,
                        "invalid MMIO write,"
                        " offset=0x%"PRIx64", data=%"PRIx64"",
                        offset, data);
@@ -1190,12 +1188,12 @@ static uint64_t nvme_mmio_read(void *opaque, hwaddr addr, unsigned size)
     uint64_t val = 0;
 
     if (unlikely(addr & (sizeof(uint32_t) - 1))) {
-        NVME_GUEST_ERR(nvme_ub_mmiord_misaligned32,
+        NVME_GUEST_ERR(pci_nvme_ub_mmiord_misaligned32,
                        "MMIO read not 32-bit aligned,"
                        " offset=0x%"PRIx64"", addr);
         /* should RAZ, fall through for now */
     } else if (unlikely(size < sizeof(uint32_t))) {
-        NVME_GUEST_ERR(nvme_ub_mmiord_toosmall,
+        NVME_GUEST_ERR(pci_nvme_ub_mmiord_toosmall,
                        "MMIO read smaller than 32-bits,"
                        " offset=0x%"PRIx64"", addr);
         /* should RAZ, fall through for now */
@@ -1213,7 +1211,7 @@ static uint64_t nvme_mmio_read(void *opaque, hwaddr addr, unsigned size)
         }
         memcpy(&val, ptr + addr, size);
     } else {
-        NVME_GUEST_ERR(nvme_ub_mmiord_invalid_ofs,
+        NVME_GUEST_ERR(pci_nvme_ub_mmiord_invalid_ofs,
                        "MMIO read beyond last register,"
                        " offset=0x%"PRIx64", returning 0", addr);
     }
@@ -1226,7 +1224,7 @@ static void nvme_process_db(NvmeCtrl *n, hwaddr addr, int val)
     uint32_t qid;
 
     if (unlikely(addr & ((1 << 2) - 1))) {
-        NVME_GUEST_ERR(nvme_ub_db_wr_misaligned,
+        NVME_GUEST_ERR(pci_nvme_ub_db_wr_misaligned,
                        "doorbell write not 32-bit aligned,"
                        " offset=0x%"PRIx64", ignoring", addr);
         return;
@@ -1241,7 +1239,7 @@ static void nvme_process_db(NvmeCtrl *n, hwaddr addr, int val)
 
         qid = (addr - (0x1000 + (1 << 2))) >> 3;
         if (unlikely(nvme_check_cqid(n, qid))) {
-            NVME_GUEST_ERR(nvme_ub_db_wr_invalid_cq,
+            NVME_GUEST_ERR(pci_nvme_ub_db_wr_invalid_cq,
                            "completion queue doorbell write"
                            " for nonexistent queue,"
                            " sqid=%"PRIu32", ignoring", qid);
@@ -1250,7 +1248,7 @@ static void nvme_process_db(NvmeCtrl *n, hwaddr addr, int val)
 
         cq = n->cq[qid];
         if (unlikely(new_head >= cq->size)) {
-            NVME_GUEST_ERR(nvme_ub_db_wr_invalid_cqhead,
+            NVME_GUEST_ERR(pci_nvme_ub_db_wr_invalid_cqhead,
                            "completion queue doorbell write value"
                            " beyond queue size, sqid=%"PRIu32","
                            " new_head=%"PRIu16", ignoring",
@@ -1279,7 +1277,7 @@ static void nvme_process_db(NvmeCtrl *n, hwaddr addr, int val)
 
         qid = (addr - 0x1000) >> 3;
         if (unlikely(nvme_check_sqid(n, qid))) {
-            NVME_GUEST_ERR(nvme_ub_db_wr_invalid_sq,
+            NVME_GUEST_ERR(pci_nvme_ub_db_wr_invalid_sq,
                            "submission queue doorbell write"
                            " for nonexistent queue,"
                            " sqid=%"PRIu32", ignoring", qid);
@@ -1288,7 +1286,7 @@ static void nvme_process_db(NvmeCtrl *n, hwaddr addr, int val)
 
         sq = n->sq[qid];
         if (unlikely(new_tail >= sq->size)) {
-            NVME_GUEST_ERR(nvme_ub_db_wr_invalid_sqtail,
+            NVME_GUEST_ERR(pci_nvme_ub_db_wr_invalid_sqtail,
                            "submission queue doorbell write value"
                            " beyond queue size, sqid=%"PRIu32","
                            " new_tail=%"PRIu16", ignoring",
diff --git a/hw/block/trace-events b/hw/block/trace-events
index aca54bda1423..958fcc5508d1 100644
--- a/hw/block/trace-events
+++ b/hw/block/trace-events
@@ -29,100 +29,100 @@ hd_geometry_guess(void *blk, uint32_t cyls, uint32_t heads, uint32_t secs, int t
 
 # nvme.c
 # nvme traces for successful events
-nvme_irq_msix(uint32_t vector) "raising MSI-X IRQ vector %u"
-nvme_irq_pin(void) "pulsing IRQ pin"
-nvme_irq_masked(void) "IRQ is masked"
-nvme_dma_read(uint64_t prp1, uint64_t prp2) "DMA read, prp1=0x%"PRIx64" prp2=0x%"PRIx64""
-nvme_rw(const char *verb, uint32_t blk_count, uint64_t byte_count, uint64_t lba) "%s %"PRIu32" blocks (%"PRIu64" bytes) from LBA %"PRIu64""
-nvme_create_sq(uint64_t addr, uint16_t sqid, uint16_t cqid, uint16_t qsize, uint16_t qflags) "create submission queue, addr=0x%"PRIx64", sqid=%"PRIu16", cqid=%"PRIu16", qsize=%"PRIu16", qflags=%"PRIu16""
-nvme_create_cq(uint64_t addr, uint16_t cqid, uint16_t vector, uint16_t size, uint16_t qflags, int ien) "create completion queue, addr=0x%"PRIx64", cqid=%"PRIu16", vector=%"PRIu16", qsize=%"PRIu16", qflags=%"PRIu16", ien=%d"
-nvme_del_sq(uint16_t qid) "deleting submission queue sqid=%"PRIu16""
-nvme_del_cq(uint16_t cqid) "deleted completion queue, cqid=%"PRIu16""
-nvme_identify_ctrl(void) "identify controller"
-nvme_identify_ns(uint16_t ns) "identify namespace, nsid=%"PRIu16""
-nvme_identify_nslist(uint16_t ns) "identify namespace list, nsid=%"PRIu16""
-nvme_getfeat_vwcache(const char* result) "get feature volatile write cache, result=%s"
-nvme_getfeat_numq(int result) "get feature number of queues, result=%d"
-nvme_setfeat_numq(int reqcq, int reqsq, int gotcq, int gotsq) "requested cq_count=%d sq_count=%d, responding with cq_count=%d sq_count=%d"
-nvme_setfeat_timestamp(uint64_t ts) "set feature timestamp = 0x%"PRIx64""
-nvme_getfeat_timestamp(uint64_t ts) "get feature timestamp = 0x%"PRIx64""
-nvme_mmio_intm_set(uint64_t data, uint64_t new_mask) "wrote MMIO, interrupt mask set, data=0x%"PRIx64", new_mask=0x%"PRIx64""
-nvme_mmio_intm_clr(uint64_t data, uint64_t new_mask) "wrote MMIO, interrupt mask clr, data=0x%"PRIx64", new_mask=0x%"PRIx64""
-nvme_mmio_cfg(uint64_t data) "wrote MMIO, config controller config=0x%"PRIx64""
-nvme_mmio_aqattr(uint64_t data) "wrote MMIO, admin queue attributes=0x%"PRIx64""
-nvme_mmio_asqaddr(uint64_t data) "wrote MMIO, admin submission queue address=0x%"PRIx64""
-nvme_mmio_acqaddr(uint64_t data) "wrote MMIO, admin completion queue address=0x%"PRIx64""
-nvme_mmio_asqaddr_hi(uint64_t data, uint64_t new_addr) "wrote MMIO, admin submission queue high half=0x%"PRIx64", new_address=0x%"PRIx64""
-nvme_mmio_acqaddr_hi(uint64_t data, uint64_t new_addr) "wrote MMIO, admin completion queue high half=0x%"PRIx64", new_address=0x%"PRIx64""
-nvme_mmio_start_success(void) "setting controller enable bit succeeded"
-nvme_mmio_stopped(void) "cleared controller enable bit"
-nvme_mmio_shutdown_set(void) "shutdown bit set"
-nvme_mmio_shutdown_cleared(void) "shutdown bit cleared"
+pci_nvme_irq_msix(uint32_t vector) "raising MSI-X IRQ vector %u"
+pci_nvme_irq_pin(void) "pulsing IRQ pin"
+pci_nvme_irq_masked(void) "IRQ is masked"
+pci_nvme_dma_read(uint64_t prp1, uint64_t prp2) "DMA read, prp1=0x%"PRIx64" prp2=0x%"PRIx64""
+pci_nvme_rw(const char *verb, uint32_t blk_count, uint64_t byte_count, uint64_t lba) "%s %"PRIu32" blocks (%"PRIu64" bytes) from LBA %"PRIu64""
+pci_nvme_create_sq(uint64_t addr, uint16_t sqid, uint16_t cqid, uint16_t qsize, uint16_t qflags) "create submission queue, addr=0x%"PRIx64", sqid=%"PRIu16", cqid=%"PRIu16", qsize=%"PRIu16", qflags=%"PRIu16""
+pci_nvme_create_cq(uint64_t addr, uint16_t cqid, uint16_t vector, uint16_t size, uint16_t qflags, int ien) "create completion queue, addr=0x%"PRIx64", cqid=%"PRIu16", vector=%"PRIu16", qsize=%"PRIu16", qflags=%"PRIu16", ien=%d"
+pci_nvme_del_sq(uint16_t qid) "deleting submission queue sqid=%"PRIu16""
+pci_nvme_del_cq(uint16_t cqid) "deleted completion queue, cqid=%"PRIu16""
+pci_nvme_identify_ctrl(void) "identify controller"
+pci_nvme_identify_ns(uint16_t ns) "identify namespace, nsid=%"PRIu16""
+pci_nvme_identify_nslist(uint16_t ns) "identify namespace list, nsid=%"PRIu16""
+pci_nvme_getfeat_vwcache(const char* result) "get feature volatile write cache, result=%s"
+pci_nvme_getfeat_numq(int result) "get feature number of queues, result=%d"
+pci_nvme_setfeat_numq(int reqcq, int reqsq, int gotcq, int gotsq) "requested cq_count=%d sq_count=%d, responding with cq_count=%d sq_count=%d"
+pci_nvme_setfeat_timestamp(uint64_t ts) "set feature timestamp = 0x%"PRIx64""
+pci_nvme_getfeat_timestamp(uint64_t ts) "get feature timestamp = 0x%"PRIx64""
+pci_nvme_mmio_intm_set(uint64_t data, uint64_t new_mask) "wrote MMIO, interrupt mask set, data=0x%"PRIx64", new_mask=0x%"PRIx64""
+pci_nvme_mmio_intm_clr(uint64_t data, uint64_t new_mask) "wrote MMIO, interrupt mask clr, data=0x%"PRIx64", new_mask=0x%"PRIx64""
+pci_nvme_mmio_cfg(uint64_t data) "wrote MMIO, config controller config=0x%"PRIx64""
+pci_nvme_mmio_aqattr(uint64_t data) "wrote MMIO, admin queue attributes=0x%"PRIx64""
+pci_nvme_mmio_asqaddr(uint64_t data) "wrote MMIO, admin submission queue address=0x%"PRIx64""
+pci_nvme_mmio_acqaddr(uint64_t data) "wrote MMIO, admin completion queue address=0x%"PRIx64""
+pci_nvme_mmio_asqaddr_hi(uint64_t data, uint64_t new_addr) "wrote MMIO, admin submission queue high half=0x%"PRIx64", new_address=0x%"PRIx64""
+pci_nvme_mmio_acqaddr_hi(uint64_t data, uint64_t new_addr) "wrote MMIO, admin completion queue high half=0x%"PRIx64", new_address=0x%"PRIx64""
+pci_nvme_mmio_start_success(void) "setting controller enable bit succeeded"
+pci_nvme_mmio_stopped(void) "cleared controller enable bit"
+pci_nvme_mmio_shutdown_set(void) "shutdown bit set"
+pci_nvme_mmio_shutdown_cleared(void) "shutdown bit cleared"
 
 # nvme traces for error conditions
-nvme_err_invalid_dma(void) "PRP/SGL is too small for transfer size"
-nvme_err_invalid_prplist_ent(uint64_t prplist) "PRP list entry is null or not page aligned: 0x%"PRIx64""
-nvme_err_invalid_prp2_align(uint64_t prp2) "PRP2 is not page aligned: 0x%"PRIx64""
-nvme_err_invalid_prp2_missing(void) "PRP2 is null and more data to be transferred"
-nvme_err_invalid_prp(void) "invalid PRP"
-nvme_err_invalid_ns(uint32_t ns, uint32_t limit) "invalid namespace %u not within 1-%u"
-nvme_err_invalid_opc(uint8_t opc) "invalid opcode 0x%"PRIx8""
-nvme_err_invalid_admin_opc(uint8_t opc) "invalid admin opcode 0x%"PRIx8""
-nvme_err_invalid_lba_range(uint64_t start, uint64_t len, uint64_t limit) "Invalid LBA start=%"PRIu64" len=%"PRIu64" limit=%"PRIu64""
-nvme_err_invalid_del_sq(uint16_t qid) "invalid submission queue deletion, sid=%"PRIu16""
-nvme_err_invalid_create_sq_cqid(uint16_t cqid) "failed creating submission queue, invalid cqid=%"PRIu16""
-nvme_err_invalid_create_sq_sqid(uint16_t sqid) "failed creating submission queue, invalid sqid=%"PRIu16""
-nvme_err_invalid_create_sq_size(uint16_t qsize) "failed creating submission queue, invalid qsize=%"PRIu16""
-nvme_err_invalid_create_sq_addr(uint64_t addr) "failed creating submission queue, addr=0x%"PRIx64""
-nvme_err_invalid_create_sq_qflags(uint16_t qflags) "failed creating submission queue, qflags=%"PRIu16""
-nvme_err_invalid_del_cq_cqid(uint16_t cqid) "failed deleting completion queue, cqid=%"PRIu16""
-nvme_err_invalid_del_cq_notempty(uint16_t cqid) "failed deleting completion queue, it is not empty, cqid=%"PRIu16""
-nvme_err_invalid_create_cq_cqid(uint16_t cqid) "failed creating completion queue, cqid=%"PRIu16""
-nvme_err_invalid_create_cq_size(uint16_t size) "failed creating completion queue, size=%"PRIu16""
-nvme_err_invalid_create_cq_addr(uint64_t addr) "failed creating completion queue, addr=0x%"PRIx64""
-nvme_err_invalid_create_cq_vector(uint16_t vector) "failed creating completion queue, vector=%"PRIu16""
-nvme_err_invalid_create_cq_qflags(uint16_t qflags) "failed creating completion queue, qflags=%"PRIu16""
-nvme_err_invalid_identify_cns(uint16_t cns) "identify, invalid cns=0x%"PRIx16""
-nvme_err_invalid_getfeat(int dw10) "invalid get features, dw10=0x%"PRIx32""
-nvme_err_invalid_setfeat(uint32_t dw10) "invalid set features, dw10=0x%"PRIx32""
-nvme_err_startfail_cq(void) "nvme_start_ctrl failed because there are non-admin completion queues"
-nvme_err_startfail_sq(void) "nvme_start_ctrl failed because there are non-admin submission queues"
-nvme_err_startfail_nbarasq(void) "nvme_start_ctrl failed because the admin submission queue address is null"
-nvme_err_startfail_nbaracq(void) "nvme_start_ctrl failed because the admin completion queue address is null"
-nvme_err_startfail_asq_misaligned(uint64_t addr) "nvme_start_ctrl failed because the admin submission queue address is misaligned: 0x%"PRIx64""
-nvme_err_startfail_acq_misaligned(uint64_t addr) "nvme_start_ctrl failed because the admin completion queue address is misaligned: 0x%"PRIx64""
-nvme_err_startfail_page_too_small(uint8_t log2ps, uint8_t maxlog2ps) "nvme_start_ctrl failed because the page size is too small: log2size=%u, min=%u"
-nvme_err_startfail_page_too_large(uint8_t log2ps, uint8_t maxlog2ps) "nvme_start_ctrl failed because the page size is too large: log2size=%u, max=%u"
-nvme_err_startfail_cqent_too_small(uint8_t log2ps, uint8_t maxlog2ps) "nvme_start_ctrl failed because the completion queue entry size is too small: log2size=%u, min=%u"
-nvme_err_startfail_cqent_too_large(uint8_t log2ps, uint8_t maxlog2ps) "nvme_start_ctrl failed because the completion queue entry size is too large: log2size=%u, max=%u"
-nvme_err_startfail_sqent_too_small(uint8_t log2ps, uint8_t maxlog2ps) "nvme_start_ctrl failed because the submission queue entry size is too small: log2size=%u, min=%u"
-nvme_err_startfail_sqent_too_large(uint8_t log2ps, uint8_t maxlog2ps) "nvme_start_ctrl failed because the submission queue entry size is too large: log2size=%u, max=%u"
-nvme_err_startfail_asqent_sz_zero(void) "nvme_start_ctrl failed because the admin submission queue size is zero"
-nvme_err_startfail_acqent_sz_zero(void) "nvme_start_ctrl failed because the admin completion queue size is zero"
-nvme_err_startfail(void) "setting controller enable bit failed"
+pci_nvme_err_invalid_dma(void) "PRP/SGL is too small for transfer size"
+pci_nvme_err_invalid_prplist_ent(uint64_t prplist) "PRP list entry is null or not page aligned: 0x%"PRIx64""
+pci_nvme_err_invalid_prp2_align(uint64_t prp2) "PRP2 is not page aligned: 0x%"PRIx64""
+pci_nvme_err_invalid_prp2_missing(void) "PRP2 is null and more data to be transferred"
+pci_nvme_err_invalid_prp(void) "invalid PRP"
+pci_nvme_err_invalid_ns(uint32_t ns, uint32_t limit) "invalid namespace %u not within 1-%u"
+pci_nvme_err_invalid_opc(uint8_t opc) "invalid opcode 0x%"PRIx8""
+pci_nvme_err_invalid_admin_opc(uint8_t opc) "invalid admin opcode 0x%"PRIx8""
+pci_nvme_err_invalid_lba_range(uint64_t start, uint64_t len, uint64_t limit) "Invalid LBA start=%"PRIu64" len=%"PRIu64" limit=%"PRIu64""
+pci_nvme_err_invalid_del_sq(uint16_t qid) "invalid submission queue deletion, sid=%"PRIu16""
+pci_nvme_err_invalid_create_sq_cqid(uint16_t cqid) "failed creating submission queue, invalid cqid=%"PRIu16""
+pci_nvme_err_invalid_create_sq_sqid(uint16_t sqid) "failed creating submission queue, invalid sqid=%"PRIu16""
+pci_nvme_err_invalid_create_sq_size(uint16_t qsize) "failed creating submission queue, invalid qsize=%"PRIu16""
+pci_nvme_err_invalid_create_sq_addr(uint64_t addr) "failed creating submission queue, addr=0x%"PRIx64""
+pci_nvme_err_invalid_create_sq_qflags(uint16_t qflags) "failed creating submission queue, qflags=%"PRIu16""
+pci_nvme_err_invalid_del_cq_cqid(uint16_t cqid) "failed deleting completion queue, cqid=%"PRIu16""
+pci_nvme_err_invalid_del_cq_notempty(uint16_t cqid) "failed deleting completion queue, it is not empty, cqid=%"PRIu16""
+pci_nvme_err_invalid_create_cq_cqid(uint16_t cqid) "failed creating completion queue, cqid=%"PRIu16""
+pci_nvme_err_invalid_create_cq_size(uint16_t size) "failed creating completion queue, size=%"PRIu16""
+pci_nvme_err_invalid_create_cq_addr(uint64_t addr) "failed creating completion queue, addr=0x%"PRIx64""
+pci_nvme_err_invalid_create_cq_vector(uint16_t vector) "failed creating completion queue, vector=%"PRIu16""
+pci_nvme_err_invalid_create_cq_qflags(uint16_t qflags) "failed creating completion queue, qflags=%"PRIu16""
+pci_nvme_err_invalid_identify_cns(uint16_t cns) "identify, invalid cns=0x%"PRIx16""
+pci_nvme_err_invalid_getfeat(int dw10) "invalid get features, dw10=0x%"PRIx32""
+pci_nvme_err_invalid_setfeat(uint32_t dw10) "invalid set features, dw10=0x%"PRIx32""
+pci_nvme_err_startfail_cq(void) "nvme_start_ctrl failed because there are non-admin completion queues"
+pci_nvme_err_startfail_sq(void) "nvme_start_ctrl failed because there are non-admin submission queues"
+pci_nvme_err_startfail_nbarasq(void) "nvme_start_ctrl failed because the admin submission queue address is null"
+pci_nvme_err_startfail_nbaracq(void) "nvme_start_ctrl failed because the admin completion queue address is null"
+pci_nvme_err_startfail_asq_misaligned(uint64_t addr) "nvme_start_ctrl failed because the admin submission queue address is misaligned: 0x%"PRIx64""
+pci_nvme_err_startfail_acq_misaligned(uint64_t addr) "nvme_start_ctrl failed because the admin completion queue address is misaligned: 0x%"PRIx64""
+pci_nvme_err_startfail_page_too_small(uint8_t log2ps, uint8_t maxlog2ps) "nvme_start_ctrl failed because the page size is too small: log2size=%u, min=%u"
+pci_nvme_err_startfail_page_too_large(uint8_t log2ps, uint8_t maxlog2ps) "nvme_start_ctrl failed because the page size is too large: log2size=%u, max=%u"
+pci_nvme_err_startfail_cqent_too_small(uint8_t log2ps, uint8_t maxlog2ps) "nvme_start_ctrl failed because the completion queue entry size is too small: log2size=%u, min=%u"
+pci_nvme_err_startfail_cqent_too_large(uint8_t log2ps, uint8_t maxlog2ps) "nvme_start_ctrl failed because the completion queue entry size is too large: log2size=%u, max=%u"
+pci_nvme_err_startfail_sqent_too_small(uint8_t log2ps, uint8_t maxlog2ps) "nvme_start_ctrl failed because the submission queue entry size is too small: log2size=%u, min=%u"
+pci_nvme_err_startfail_sqent_too_large(uint8_t log2ps, uint8_t maxlog2ps) "nvme_start_ctrl failed because the submission queue entry size is too large: log2size=%u, max=%u"
+pci_nvme_err_startfail_asqent_sz_zero(void) "nvme_start_ctrl failed because the admin submission queue size is zero"
+pci_nvme_err_startfail_acqent_sz_zero(void) "nvme_start_ctrl failed because the admin completion queue size is zero"
+pci_nvme_err_startfail(void) "setting controller enable bit failed"
 
 # Traces for undefined behavior
-nvme_ub_mmiowr_misaligned32(uint64_t offset) "MMIO write not 32-bit aligned, offset=0x%"PRIx64""
-nvme_ub_mmiowr_toosmall(uint64_t offset, unsigned size) "MMIO write smaller than 32 bits, offset=0x%"PRIx64", size=%u"
-nvme_ub_mmiowr_intmask_with_msix(void) "undefined access to interrupt mask set when MSI-X is enabled"
-nvme_ub_mmiowr_ro_csts(void) "attempted to set a read only bit of controller status"
-nvme_ub_mmiowr_ssreset_w1c_unsupported(void) "attempted to W1C CSTS.NSSRO but CAP.NSSRS is zero (not supported)"
-nvme_ub_mmiowr_ssreset_unsupported(void) "attempted NVM subsystem reset but CAP.NSSRS is zero (not supported)"
-nvme_ub_mmiowr_cmbloc_reserved(void) "invalid write to reserved CMBLOC when CMBSZ is zero, ignored"
-nvme_ub_mmiowr_cmbsz_readonly(void) "invalid write to read only CMBSZ, ignored"
-nvme_ub_mmiowr_pmrcap_readonly(void) "invalid write to read only PMRCAP, ignored"
-nvme_ub_mmiowr_pmrsts_readonly(void) "invalid write to read only PMRSTS, ignored"
-nvme_ub_mmiowr_pmrebs_readonly(void) "invalid write to read only PMREBS, ignored"
-nvme_ub_mmiowr_pmrswtp_readonly(void) "invalid write to read only PMRSWTP, ignored"
-nvme_ub_mmiowr_invalid(uint64_t offset, uint64_t data) "invalid MMIO write, offset=0x%"PRIx64", data=0x%"PRIx64""
-nvme_ub_mmiord_misaligned32(uint64_t offset) "MMIO read not 32-bit aligned, offset=0x%"PRIx64""
-nvme_ub_mmiord_toosmall(uint64_t offset) "MMIO read smaller than 32-bits, offset=0x%"PRIx64""
-nvme_ub_mmiord_invalid_ofs(uint64_t offset) "MMIO read beyond last register, offset=0x%"PRIx64", returning 0"
-nvme_ub_db_wr_misaligned(uint64_t offset) "doorbell write not 32-bit aligned, offset=0x%"PRIx64", ignoring"
-nvme_ub_db_wr_invalid_cq(uint32_t qid) "completion queue doorbell write for nonexistent queue, cqid=%"PRIu32", ignoring"
-nvme_ub_db_wr_invalid_cqhead(uint32_t qid, uint16_t new_head) "completion queue doorbell write value beyond queue size, cqid=%"PRIu32", new_head=%"PRIu16", ignoring"
-nvme_ub_db_wr_invalid_sq(uint32_t qid) "submission queue doorbell write for nonexistent queue, sqid=%"PRIu32", ignoring"
-nvme_ub_db_wr_invalid_sqtail(uint32_t qid, uint16_t new_tail) "submission queue doorbell write value beyond queue size, sqid=%"PRIu32", new_head=%"PRIu16", ignoring"
+pci_nvme_ub_mmiowr_misaligned32(uint64_t offset) "MMIO write not 32-bit aligned, offset=0x%"PRIx64""
+pci_nvme_ub_mmiowr_toosmall(uint64_t offset, unsigned size) "MMIO write smaller than 32 bits, offset=0x%"PRIx64", size=%u"
+pci_nvme_ub_mmiowr_intmask_with_msix(void) "undefined access to interrupt mask set when MSI-X is enabled"
+pci_nvme_ub_mmiowr_ro_csts(void) "attempted to set a read only bit of controller status"
+pci_nvme_ub_mmiowr_ssreset_w1c_unsupported(void) "attempted to W1C CSTS.NSSRO but CAP.NSSRS is zero (not supported)"
+pci_nvme_ub_mmiowr_ssreset_unsupported(void) "attempted NVM subsystem reset but CAP.NSSRS is zero (not supported)"
+pci_nvme_ub_mmiowr_cmbloc_reserved(void) "invalid write to reserved CMBLOC when CMBSZ is zero, ignored"
+pci_nvme_ub_mmiowr_cmbsz_readonly(void) "invalid write to read only CMBSZ, ignored"
+pci_nvme_ub_mmiowr_pmrcap_readonly(void) "invalid write to read only PMRCAP, ignored"
+pci_nvme_ub_mmiowr_pmrsts_readonly(void) "invalid write to read only PMRSTS, ignored"
+pci_nvme_ub_mmiowr_pmrebs_readonly(void) "invalid write to read only PMREBS, ignored"
+pci_nvme_ub_mmiowr_pmrswtp_readonly(void) "invalid write to read only PMRSWTP, ignored"
+pci_nvme_ub_mmiowr_invalid(uint64_t offset, uint64_t data) "invalid MMIO write, offset=0x%"PRIx64", data=0x%"PRIx64""
+pci_nvme_ub_mmiord_misaligned32(uint64_t offset) "MMIO read not 32-bit aligned, offset=0x%"PRIx64""
+pci_nvme_ub_mmiord_toosmall(uint64_t offset) "MMIO read smaller than 32-bits, offset=0x%"PRIx64""
+pci_nvme_ub_mmiord_invalid_ofs(uint64_t offset) "MMIO read beyond last register, offset=0x%"PRIx64", returning 0"
+pci_nvme_ub_db_wr_misaligned(uint64_t offset) "doorbell write not 32-bit aligned, offset=0x%"PRIx64", ignoring"
+pci_nvme_ub_db_wr_invalid_cq(uint32_t qid) "completion queue doorbell write for nonexistent queue, cqid=%"PRIu32", ignoring"
+pci_nvme_ub_db_wr_invalid_cqhead(uint32_t qid, uint16_t new_head) "completion queue doorbell write value beyond queue size, cqid=%"PRIu32", new_head=%"PRIu16", ignoring"
+pci_nvme_ub_db_wr_invalid_sq(uint32_t qid) "submission queue doorbell write for nonexistent queue, sqid=%"PRIu32", ignoring"
+pci_nvme_ub_db_wr_invalid_sqtail(uint32_t qid, uint16_t new_tail) "submission queue doorbell write value beyond queue size, sqid=%"PRIu32", new_head=%"PRIu16", ignoring"
 
 # xen-block.c
 xen_block_realize(const char *type, uint32_t disk, uint32_t partition) "%s d%up%u"
-- 
2.27.0


