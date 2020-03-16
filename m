Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E28DC0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 16:56:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3B1420679
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 16:56:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3B1420679
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42910 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDt2t-0005cq-Ui
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 12:56:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53059)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <its@irrelevant.dk>) id 1jDqkb-0008Uq-QO
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 10:29:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <its@irrelevant.dk>) id 1jDqkW-0008Ii-UX
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 10:29:53 -0400
Received: from charlie.dont.surf ([128.199.63.193]:48434)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <its@irrelevant.dk>)
 id 1jDqkK-0006eU-Oz; Mon, 16 Mar 2020 10:29:37 -0400
Received: from apples.local (80-62-117-52-mobile.dk.customer.tdc.net
 [80.62.117.52])
 by charlie.dont.surf (Postfix) with ESMTPSA id 0B2A3BF5E1;
 Mon, 16 Mar 2020 14:29:34 +0000 (UTC)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-block@nongnu.org
Subject: [PATCH v6 01/42] nvme: rename trace events to nvme_dev
Date: Mon, 16 Mar 2020 07:28:47 -0700
Message-Id: <20200316142928.153431-2-its@irrelevant.dk>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200316142928.153431-1-its@irrelevant.dk>
References: <20200316142928.153431-1-its@irrelevant.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 128.199.63.193
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
Cc: Kevin Wolf <kwolf@redhat.com>, Beata Michalska <beata.michalska@linaro.org>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Klaus Jensen <its@irrelevant.dk>, Keith Busch <kbusch@kernel.org>,
 Javier Gonzalez <javier.gonz@samsung.com>,
 Maxim Levitsky <mlevitsk@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Klaus Jensen <k.jensen@samsung.com>

Change the prefix of all nvme device related trace events to 'nvme_dev'
to not clash with trace events from the nvme block driver.

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
Acked-by: Keith Busch <kbusch@kernel.org>
Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 hw/block/nvme.c       | 188 +++++++++++++++++++++---------------------
 hw/block/trace-events | 172 +++++++++++++++++++-------------------
 2 files changed, 180 insertions(+), 180 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index d28335cbf377..3e4b18956ed2 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -112,16 +112,16 @@ static void nvme_irq_assert(NvmeCtrl *n, NvmeCQueue=
 *cq)
 {
     if (cq->irq_enabled) {
         if (msix_enabled(&(n->parent_obj))) {
-            trace_nvme_irq_msix(cq->vector);
+            trace_nvme_dev_irq_msix(cq->vector);
             msix_notify(&(n->parent_obj), cq->vector);
         } else {
-            trace_nvme_irq_pin();
+            trace_nvme_dev_irq_pin();
             assert(cq->cqid < 64);
             n->irq_status |=3D 1 << cq->cqid;
             nvme_irq_check(n);
         }
     } else {
-        trace_nvme_irq_masked();
+        trace_nvme_dev_irq_masked();
     }
 }
=20
@@ -146,7 +146,7 @@ static uint16_t nvme_map_prp(QEMUSGList *qsg, QEMUIOV=
ector *iov, uint64_t prp1,
     int num_prps =3D (len >> n->page_bits) + 1;
=20
     if (unlikely(!prp1)) {
-        trace_nvme_err_invalid_prp();
+        trace_nvme_dev_err_invalid_prp();
         return NVME_INVALID_FIELD | NVME_DNR;
     } else if (n->cmbsz && prp1 >=3D n->ctrl_mem.addr &&
                prp1 < n->ctrl_mem.addr + int128_get64(n->ctrl_mem.size))=
 {
@@ -160,7 +160,7 @@ static uint16_t nvme_map_prp(QEMUSGList *qsg, QEMUIOV=
ector *iov, uint64_t prp1,
     len -=3D trans_len;
     if (len) {
         if (unlikely(!prp2)) {
-            trace_nvme_err_invalid_prp2_missing();
+            trace_nvme_dev_err_invalid_prp2_missing();
             goto unmap;
         }
         if (len > n->page_size) {
@@ -176,7 +176,7 @@ static uint16_t nvme_map_prp(QEMUSGList *qsg, QEMUIOV=
ector *iov, uint64_t prp1,
=20
                 if (i =3D=3D n->max_prp_ents - 1 && len > n->page_size) =
{
                     if (unlikely(!prp_ent || prp_ent & (n->page_size - 1=
))) {
-                        trace_nvme_err_invalid_prplist_ent(prp_ent);
+                        trace_nvme_dev_err_invalid_prplist_ent(prp_ent);
                         goto unmap;
                     }
=20
@@ -189,7 +189,7 @@ static uint16_t nvme_map_prp(QEMUSGList *qsg, QEMUIOV=
ector *iov, uint64_t prp1,
                 }
=20
                 if (unlikely(!prp_ent || prp_ent & (n->page_size - 1))) =
{
-                    trace_nvme_err_invalid_prplist_ent(prp_ent);
+                    trace_nvme_dev_err_invalid_prplist_ent(prp_ent);
                     goto unmap;
                 }
=20
@@ -204,7 +204,7 @@ static uint16_t nvme_map_prp(QEMUSGList *qsg, QEMUIOV=
ector *iov, uint64_t prp1,
             }
         } else {
             if (unlikely(prp2 & (n->page_size - 1))) {
-                trace_nvme_err_invalid_prp2_align(prp2);
+                trace_nvme_dev_err_invalid_prp2_align(prp2);
                 goto unmap;
             }
             if (qsg->nsg) {
@@ -252,20 +252,20 @@ static uint16_t nvme_dma_read_prp(NvmeCtrl *n, uint=
8_t *ptr, uint32_t len,
     QEMUIOVector iov;
     uint16_t status =3D NVME_SUCCESS;
=20
-    trace_nvme_dma_read(prp1, prp2);
+    trace_nvme_dev_dma_read(prp1, prp2);
=20
     if (nvme_map_prp(&qsg, &iov, prp1, prp2, len, n)) {
         return NVME_INVALID_FIELD | NVME_DNR;
     }
     if (qsg.nsg > 0) {
         if (unlikely(dma_buf_read(ptr, len, &qsg))) {
-            trace_nvme_err_invalid_dma();
+            trace_nvme_dev_err_invalid_dma();
             status =3D NVME_INVALID_FIELD | NVME_DNR;
         }
         qemu_sglist_destroy(&qsg);
     } else {
         if (unlikely(qemu_iovec_from_buf(&iov, 0, ptr, len) !=3D len)) {
-            trace_nvme_err_invalid_dma();
+            trace_nvme_dev_err_invalid_dma();
             status =3D NVME_INVALID_FIELD | NVME_DNR;
         }
         qemu_iovec_destroy(&iov);
@@ -354,7 +354,7 @@ static uint16_t nvme_write_zeros(NvmeCtrl *n, NvmeNam=
espace *ns, NvmeCmd *cmd,
     uint32_t count =3D nlb << data_shift;
=20
     if (unlikely(slba + nlb > ns->id_ns.nsze)) {
-        trace_nvme_err_invalid_lba_range(slba, nlb, ns->id_ns.nsze);
+        trace_nvme_dev_err_invalid_lba_range(slba, nlb, ns->id_ns.nsze);
         return NVME_LBA_RANGE | NVME_DNR;
     }
=20
@@ -382,11 +382,11 @@ static uint16_t nvme_rw(NvmeCtrl *n, NvmeNamespace =
*ns, NvmeCmd *cmd,
     int is_write =3D rw->opcode =3D=3D NVME_CMD_WRITE ? 1 : 0;
     enum BlockAcctType acct =3D is_write ? BLOCK_ACCT_WRITE : BLOCK_ACCT=
_READ;
=20
-    trace_nvme_rw(is_write ? "write" : "read", nlb, data_size, slba);
+    trace_nvme_dev_rw(is_write ? "write" : "read", nlb, data_size, slba)=
;
=20
     if (unlikely((slba + nlb) > ns->id_ns.nsze)) {
         block_acct_invalid(blk_get_stats(n->conf.blk), acct);
-        trace_nvme_err_invalid_lba_range(slba, nlb, ns->id_ns.nsze);
+        trace_nvme_dev_err_invalid_lba_range(slba, nlb, ns->id_ns.nsze);
         return NVME_LBA_RANGE | NVME_DNR;
     }
=20
@@ -421,7 +421,7 @@ static uint16_t nvme_io_cmd(NvmeCtrl *n, NvmeCmd *cmd=
, NvmeRequest *req)
     uint32_t nsid =3D le32_to_cpu(cmd->nsid);
=20
     if (unlikely(nsid =3D=3D 0 || nsid > n->num_namespaces)) {
-        trace_nvme_err_invalid_ns(nsid, n->num_namespaces);
+        trace_nvme_dev_err_invalid_ns(nsid, n->num_namespaces);
         return NVME_INVALID_NSID | NVME_DNR;
     }
=20
@@ -435,7 +435,7 @@ static uint16_t nvme_io_cmd(NvmeCtrl *n, NvmeCmd *cmd=
, NvmeRequest *req)
     case NVME_CMD_READ:
         return nvme_rw(n, ns, cmd, req);
     default:
-        trace_nvme_err_invalid_opc(cmd->opcode);
+        trace_nvme_dev_err_invalid_opc(cmd->opcode);
         return NVME_INVALID_OPCODE | NVME_DNR;
     }
 }
@@ -460,11 +460,11 @@ static uint16_t nvme_del_sq(NvmeCtrl *n, NvmeCmd *c=
md)
     uint16_t qid =3D le16_to_cpu(c->qid);
=20
     if (unlikely(!qid || nvme_check_sqid(n, qid))) {
-        trace_nvme_err_invalid_del_sq(qid);
+        trace_nvme_dev_err_invalid_del_sq(qid);
         return NVME_INVALID_QID | NVME_DNR;
     }
=20
-    trace_nvme_del_sq(qid);
+    trace_nvme_dev_del_sq(qid);
=20
     sq =3D n->sq[qid];
     while (!QTAILQ_EMPTY(&sq->out_req_list)) {
@@ -528,26 +528,26 @@ static uint16_t nvme_create_sq(NvmeCtrl *n, NvmeCmd=
 *cmd)
     uint16_t qflags =3D le16_to_cpu(c->sq_flags);
     uint64_t prp1 =3D le64_to_cpu(c->prp1);
=20
-    trace_nvme_create_sq(prp1, sqid, cqid, qsize, qflags);
+    trace_nvme_dev_create_sq(prp1, sqid, cqid, qsize, qflags);
=20
     if (unlikely(!cqid || nvme_check_cqid(n, cqid))) {
-        trace_nvme_err_invalid_create_sq_cqid(cqid);
+        trace_nvme_dev_err_invalid_create_sq_cqid(cqid);
         return NVME_INVALID_CQID | NVME_DNR;
     }
     if (unlikely(!sqid || !nvme_check_sqid(n, sqid))) {
-        trace_nvme_err_invalid_create_sq_sqid(sqid);
+        trace_nvme_dev_err_invalid_create_sq_sqid(sqid);
         return NVME_INVALID_QID | NVME_DNR;
     }
     if (unlikely(!qsize || qsize > NVME_CAP_MQES(n->bar.cap))) {
-        trace_nvme_err_invalid_create_sq_size(qsize);
+        trace_nvme_dev_err_invalid_create_sq_size(qsize);
         return NVME_MAX_QSIZE_EXCEEDED | NVME_DNR;
     }
     if (unlikely(!prp1 || prp1 & (n->page_size - 1))) {
-        trace_nvme_err_invalid_create_sq_addr(prp1);
+        trace_nvme_dev_err_invalid_create_sq_addr(prp1);
         return NVME_INVALID_FIELD | NVME_DNR;
     }
     if (unlikely(!(NVME_SQ_FLAGS_PC(qflags)))) {
-        trace_nvme_err_invalid_create_sq_qflags(NVME_SQ_FLAGS_PC(qflags)=
);
+        trace_nvme_dev_err_invalid_create_sq_qflags(NVME_SQ_FLAGS_PC(qfl=
ags));
         return NVME_INVALID_FIELD | NVME_DNR;
     }
     sq =3D g_malloc0(sizeof(*sq));
@@ -573,17 +573,17 @@ static uint16_t nvme_del_cq(NvmeCtrl *n, NvmeCmd *c=
md)
     uint16_t qid =3D le16_to_cpu(c->qid);
=20
     if (unlikely(!qid || nvme_check_cqid(n, qid))) {
-        trace_nvme_err_invalid_del_cq_cqid(qid);
+        trace_nvme_dev_err_invalid_del_cq_cqid(qid);
         return NVME_INVALID_CQID | NVME_DNR;
     }
=20
     cq =3D n->cq[qid];
     if (unlikely(!QTAILQ_EMPTY(&cq->sq_list))) {
-        trace_nvme_err_invalid_del_cq_notempty(qid);
+        trace_nvme_dev_err_invalid_del_cq_notempty(qid);
         return NVME_INVALID_QUEUE_DEL;
     }
     nvme_irq_deassert(n, cq);
-    trace_nvme_del_cq(qid);
+    trace_nvme_dev_del_cq(qid);
     nvme_free_cq(cq, n);
     return NVME_SUCCESS;
 }
@@ -616,27 +616,27 @@ static uint16_t nvme_create_cq(NvmeCtrl *n, NvmeCmd=
 *cmd)
     uint16_t qflags =3D le16_to_cpu(c->cq_flags);
     uint64_t prp1 =3D le64_to_cpu(c->prp1);
=20
-    trace_nvme_create_cq(prp1, cqid, vector, qsize, qflags,
-                         NVME_CQ_FLAGS_IEN(qflags) !=3D 0);
+    trace_nvme_dev_create_cq(prp1, cqid, vector, qsize, qflags,
+                             NVME_CQ_FLAGS_IEN(qflags) !=3D 0);
=20
     if (unlikely(!cqid || !nvme_check_cqid(n, cqid))) {
-        trace_nvme_err_invalid_create_cq_cqid(cqid);
+        trace_nvme_dev_err_invalid_create_cq_cqid(cqid);
         return NVME_INVALID_CQID | NVME_DNR;
     }
     if (unlikely(!qsize || qsize > NVME_CAP_MQES(n->bar.cap))) {
-        trace_nvme_err_invalid_create_cq_size(qsize);
+        trace_nvme_dev_err_invalid_create_cq_size(qsize);
         return NVME_MAX_QSIZE_EXCEEDED | NVME_DNR;
     }
     if (unlikely(!prp1)) {
-        trace_nvme_err_invalid_create_cq_addr(prp1);
+        trace_nvme_dev_err_invalid_create_cq_addr(prp1);
         return NVME_INVALID_FIELD | NVME_DNR;
     }
     if (unlikely(vector > n->num_queues)) {
-        trace_nvme_err_invalid_create_cq_vector(vector);
+        trace_nvme_dev_err_invalid_create_cq_vector(vector);
         return NVME_INVALID_IRQ_VECTOR | NVME_DNR;
     }
     if (unlikely(!(NVME_CQ_FLAGS_PC(qflags)))) {
-        trace_nvme_err_invalid_create_cq_qflags(NVME_CQ_FLAGS_PC(qflags)=
);
+        trace_nvme_dev_err_invalid_create_cq_qflags(NVME_CQ_FLAGS_PC(qfl=
ags));
         return NVME_INVALID_FIELD | NVME_DNR;
     }
=20
@@ -651,7 +651,7 @@ static uint16_t nvme_identify_ctrl(NvmeCtrl *n, NvmeI=
dentify *c)
     uint64_t prp1 =3D le64_to_cpu(c->prp1);
     uint64_t prp2 =3D le64_to_cpu(c->prp2);
=20
-    trace_nvme_identify_ctrl();
+    trace_nvme_dev_identify_ctrl();
=20
     return nvme_dma_read_prp(n, (uint8_t *)&n->id_ctrl, sizeof(n->id_ctr=
l),
         prp1, prp2);
@@ -664,10 +664,10 @@ static uint16_t nvme_identify_ns(NvmeCtrl *n, NvmeI=
dentify *c)
     uint64_t prp1 =3D le64_to_cpu(c->prp1);
     uint64_t prp2 =3D le64_to_cpu(c->prp2);
=20
-    trace_nvme_identify_ns(nsid);
+    trace_nvme_dev_identify_ns(nsid);
=20
     if (unlikely(nsid =3D=3D 0 || nsid > n->num_namespaces)) {
-        trace_nvme_err_invalid_ns(nsid, n->num_namespaces);
+        trace_nvme_dev_err_invalid_ns(nsid, n->num_namespaces);
         return NVME_INVALID_NSID | NVME_DNR;
     }
=20
@@ -687,7 +687,7 @@ static uint16_t nvme_identify_nslist(NvmeCtrl *n, Nvm=
eIdentify *c)
     uint16_t ret;
     int i, j =3D 0;
=20
-    trace_nvme_identify_nslist(min_nsid);
+    trace_nvme_dev_identify_nslist(min_nsid);
=20
     list =3D g_malloc0(data_len);
     for (i =3D 0; i < n->num_namespaces; i++) {
@@ -716,14 +716,14 @@ static uint16_t nvme_identify(NvmeCtrl *n, NvmeCmd =
*cmd)
     case 0x02:
         return nvme_identify_nslist(n, c);
     default:
-        trace_nvme_err_invalid_identify_cns(le32_to_cpu(c->cns));
+        trace_nvme_dev_err_invalid_identify_cns(le32_to_cpu(c->cns));
         return NVME_INVALID_FIELD | NVME_DNR;
     }
 }
=20
 static inline void nvme_set_timestamp(NvmeCtrl *n, uint64_t ts)
 {
-    trace_nvme_setfeat_timestamp(ts);
+    trace_nvme_dev_setfeat_timestamp(ts);
=20
     n->host_timestamp =3D le64_to_cpu(ts);
     n->timestamp_set_qemu_clock_ms =3D qemu_clock_get_ms(QEMU_CLOCK_VIRT=
UAL);
@@ -756,7 +756,7 @@ static inline uint64_t nvme_get_timestamp(const NvmeC=
trl *n)
     /* If the host timestamp is non-zero, set the timestamp origin */
     ts.origin =3D n->host_timestamp ? 0x01 : 0x00;
=20
-    trace_nvme_getfeat_timestamp(ts.all);
+    trace_nvme_dev_getfeat_timestamp(ts.all);
=20
     return cpu_to_le64(ts.all);
 }
@@ -780,17 +780,17 @@ static uint16_t nvme_get_feature(NvmeCtrl *n, NvmeC=
md *cmd, NvmeRequest *req)
     switch (dw10) {
     case NVME_VOLATILE_WRITE_CACHE:
         result =3D blk_enable_write_cache(n->conf.blk);
-        trace_nvme_getfeat_vwcache(result ? "enabled" : "disabled");
+        trace_nvme_dev_getfeat_vwcache(result ? "enabled" : "disabled");
         break;
     case NVME_NUMBER_OF_QUEUES:
         result =3D cpu_to_le32((n->num_queues - 2) | ((n->num_queues - 2=
) << 16));
-        trace_nvme_getfeat_numq(result);
+        trace_nvme_dev_getfeat_numq(result);
         break;
     case NVME_TIMESTAMP:
         return nvme_get_feature_timestamp(n, cmd);
         break;
     default:
-        trace_nvme_err_invalid_getfeat(dw10);
+        trace_nvme_dev_err_invalid_getfeat(dw10);
         return NVME_INVALID_FIELD | NVME_DNR;
     }
=20
@@ -826,9 +826,9 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeCmd=
 *cmd, NvmeRequest *req)
         blk_set_enable_write_cache(n->conf.blk, dw11 & 1);
         break;
     case NVME_NUMBER_OF_QUEUES:
-        trace_nvme_setfeat_numq((dw11 & 0xFFFF) + 1,
-                                ((dw11 >> 16) & 0xFFFF) + 1,
-                                n->num_queues - 1, n->num_queues - 1);
+        trace_nvme_dev_setfeat_numq((dw11 & 0xFFFF) + 1,
+                                    ((dw11 >> 16) & 0xFFFF) + 1,
+                                    n->num_queues - 1, n->num_queues - 1=
);
         req->cqe.result =3D
             cpu_to_le32((n->num_queues - 2) | ((n->num_queues - 2) << 16=
));
         break;
@@ -838,7 +838,7 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeCmd=
 *cmd, NvmeRequest *req)
         break;
=20
     default:
-        trace_nvme_err_invalid_setfeat(dw10);
+        trace_nvme_dev_err_invalid_setfeat(dw10);
         return NVME_INVALID_FIELD | NVME_DNR;
     }
     return NVME_SUCCESS;
@@ -862,7 +862,7 @@ static uint16_t nvme_admin_cmd(NvmeCtrl *n, NvmeCmd *=
cmd, NvmeRequest *req)
     case NVME_ADM_CMD_GET_FEATURES:
         return nvme_get_feature(n, cmd, req);
     default:
-        trace_nvme_err_invalid_admin_opc(cmd->opcode);
+        trace_nvme_dev_err_invalid_admin_opc(cmd->opcode);
         return NVME_INVALID_OPCODE | NVME_DNR;
     }
 }
@@ -925,77 +925,77 @@ static int nvme_start_ctrl(NvmeCtrl *n)
     uint32_t page_size =3D 1 << page_bits;
=20
     if (unlikely(n->cq[0])) {
-        trace_nvme_err_startfail_cq();
+        trace_nvme_dev_err_startfail_cq();
         return -1;
     }
     if (unlikely(n->sq[0])) {
-        trace_nvme_err_startfail_sq();
+        trace_nvme_dev_err_startfail_sq();
         return -1;
     }
     if (unlikely(!n->bar.asq)) {
-        trace_nvme_err_startfail_nbarasq();
+        trace_nvme_dev_err_startfail_nbarasq();
         return -1;
     }
     if (unlikely(!n->bar.acq)) {
-        trace_nvme_err_startfail_nbaracq();
+        trace_nvme_dev_err_startfail_nbaracq();
         return -1;
     }
     if (unlikely(n->bar.asq & (page_size - 1))) {
-        trace_nvme_err_startfail_asq_misaligned(n->bar.asq);
+        trace_nvme_dev_err_startfail_asq_misaligned(n->bar.asq);
         return -1;
     }
     if (unlikely(n->bar.acq & (page_size - 1))) {
-        trace_nvme_err_startfail_acq_misaligned(n->bar.acq);
+        trace_nvme_dev_err_startfail_acq_misaligned(n->bar.acq);
         return -1;
     }
     if (unlikely(NVME_CC_MPS(n->bar.cc) <
                  NVME_CAP_MPSMIN(n->bar.cap))) {
-        trace_nvme_err_startfail_page_too_small(
+        trace_nvme_dev_err_startfail_page_too_small(
                     NVME_CC_MPS(n->bar.cc),
                     NVME_CAP_MPSMIN(n->bar.cap));
         return -1;
     }
     if (unlikely(NVME_CC_MPS(n->bar.cc) >
                  NVME_CAP_MPSMAX(n->bar.cap))) {
-        trace_nvme_err_startfail_page_too_large(
+        trace_nvme_dev_err_startfail_page_too_large(
                     NVME_CC_MPS(n->bar.cc),
                     NVME_CAP_MPSMAX(n->bar.cap));
         return -1;
     }
     if (unlikely(NVME_CC_IOCQES(n->bar.cc) <
                  NVME_CTRL_CQES_MIN(n->id_ctrl.cqes))) {
-        trace_nvme_err_startfail_cqent_too_small(
+        trace_nvme_dev_err_startfail_cqent_too_small(
                     NVME_CC_IOCQES(n->bar.cc),
                     NVME_CTRL_CQES_MIN(n->bar.cap));
         return -1;
     }
     if (unlikely(NVME_CC_IOCQES(n->bar.cc) >
                  NVME_CTRL_CQES_MAX(n->id_ctrl.cqes))) {
-        trace_nvme_err_startfail_cqent_too_large(
+        trace_nvme_dev_err_startfail_cqent_too_large(
                     NVME_CC_IOCQES(n->bar.cc),
                     NVME_CTRL_CQES_MAX(n->bar.cap));
         return -1;
     }
     if (unlikely(NVME_CC_IOSQES(n->bar.cc) <
                  NVME_CTRL_SQES_MIN(n->id_ctrl.sqes))) {
-        trace_nvme_err_startfail_sqent_too_small(
+        trace_nvme_dev_err_startfail_sqent_too_small(
                     NVME_CC_IOSQES(n->bar.cc),
                     NVME_CTRL_SQES_MIN(n->bar.cap));
         return -1;
     }
     if (unlikely(NVME_CC_IOSQES(n->bar.cc) >
                  NVME_CTRL_SQES_MAX(n->id_ctrl.sqes))) {
-        trace_nvme_err_startfail_sqent_too_large(
+        trace_nvme_dev_err_startfail_sqent_too_large(
                     NVME_CC_IOSQES(n->bar.cc),
                     NVME_CTRL_SQES_MAX(n->bar.cap));
         return -1;
     }
     if (unlikely(!NVME_AQA_ASQS(n->bar.aqa))) {
-        trace_nvme_err_startfail_asqent_sz_zero();
+        trace_nvme_dev_err_startfail_asqent_sz_zero();
         return -1;
     }
     if (unlikely(!NVME_AQA_ACQS(n->bar.aqa))) {
-        trace_nvme_err_startfail_acqent_sz_zero();
+        trace_nvme_dev_err_startfail_acqent_sz_zero();
         return -1;
     }
=20
@@ -1018,14 +1018,14 @@ static void nvme_write_bar(NvmeCtrl *n, hwaddr of=
fset, uint64_t data,
     unsigned size)
 {
     if (unlikely(offset & (sizeof(uint32_t) - 1))) {
-        NVME_GUEST_ERR(nvme_ub_mmiowr_misaligned32,
+        NVME_GUEST_ERR(nvme_dev_ub_mmiowr_misaligned32,
                        "MMIO write not 32-bit aligned,"
                        " offset=3D0x%"PRIx64"", offset);
         /* should be ignored, fall through for now */
     }
=20
     if (unlikely(size < sizeof(uint32_t))) {
-        NVME_GUEST_ERR(nvme_ub_mmiowr_toosmall,
+        NVME_GUEST_ERR(nvme_dev_ub_mmiowr_toosmall,
                        "MMIO write smaller than 32-bits,"
                        " offset=3D0x%"PRIx64", size=3D%u",
                        offset, size);
@@ -1035,32 +1035,32 @@ static void nvme_write_bar(NvmeCtrl *n, hwaddr of=
fset, uint64_t data,
     switch (offset) {
     case 0xc:   /* INTMS */
         if (unlikely(msix_enabled(&(n->parent_obj)))) {
-            NVME_GUEST_ERR(nvme_ub_mmiowr_intmask_with_msix,
+            NVME_GUEST_ERR(nvme_dev_ub_mmiowr_intmask_with_msix,
                            "undefined access to interrupt mask set"
                            " when MSI-X is enabled");
             /* should be ignored, fall through for now */
         }
         n->bar.intms |=3D data & 0xffffffff;
         n->bar.intmc =3D n->bar.intms;
-        trace_nvme_mmio_intm_set(data & 0xffffffff,
+        trace_nvme_dev_mmio_intm_set(data & 0xffffffff,
                                  n->bar.intmc);
         nvme_irq_check(n);
         break;
     case 0x10:  /* INTMC */
         if (unlikely(msix_enabled(&(n->parent_obj)))) {
-            NVME_GUEST_ERR(nvme_ub_mmiowr_intmask_with_msix,
+            NVME_GUEST_ERR(nvme_dev_ub_mmiowr_intmask_with_msix,
                            "undefined access to interrupt mask clr"
                            " when MSI-X is enabled");
             /* should be ignored, fall through for now */
         }
         n->bar.intms &=3D ~(data & 0xffffffff);
         n->bar.intmc =3D n->bar.intms;
-        trace_nvme_mmio_intm_clr(data & 0xffffffff,
+        trace_nvme_dev_mmio_intm_clr(data & 0xffffffff,
                                  n->bar.intmc);
         nvme_irq_check(n);
         break;
     case 0x14:  /* CC */
-        trace_nvme_mmio_cfg(data & 0xffffffff);
+        trace_nvme_dev_mmio_cfg(data & 0xffffffff);
         /* Windows first sends data, then sends enable bit */
         if (!NVME_CC_EN(data) && !NVME_CC_EN(n->bar.cc) &&
             !NVME_CC_SHN(data) && !NVME_CC_SHN(n->bar.cc))
@@ -1071,42 +1071,42 @@ static void nvme_write_bar(NvmeCtrl *n, hwaddr of=
fset, uint64_t data,
         if (NVME_CC_EN(data) && !NVME_CC_EN(n->bar.cc)) {
             n->bar.cc =3D data;
             if (unlikely(nvme_start_ctrl(n))) {
-                trace_nvme_err_startfail();
+                trace_nvme_dev_err_startfail();
                 n->bar.csts =3D NVME_CSTS_FAILED;
             } else {
-                trace_nvme_mmio_start_success();
+                trace_nvme_dev_mmio_start_success();
                 n->bar.csts =3D NVME_CSTS_READY;
             }
         } else if (!NVME_CC_EN(data) && NVME_CC_EN(n->bar.cc)) {
-            trace_nvme_mmio_stopped();
+            trace_nvme_dev_mmio_stopped();
             nvme_clear_ctrl(n);
             n->bar.csts &=3D ~NVME_CSTS_READY;
         }
         if (NVME_CC_SHN(data) && !(NVME_CC_SHN(n->bar.cc))) {
-            trace_nvme_mmio_shutdown_set();
+            trace_nvme_dev_mmio_shutdown_set();
             nvme_clear_ctrl(n);
             n->bar.cc =3D data;
             n->bar.csts |=3D NVME_CSTS_SHST_COMPLETE;
         } else if (!NVME_CC_SHN(data) && NVME_CC_SHN(n->bar.cc)) {
-            trace_nvme_mmio_shutdown_cleared();
+            trace_nvme_dev_mmio_shutdown_cleared();
             n->bar.csts &=3D ~NVME_CSTS_SHST_COMPLETE;
             n->bar.cc =3D data;
         }
         break;
     case 0x1C:  /* CSTS */
         if (data & (1 << 4)) {
-            NVME_GUEST_ERR(nvme_ub_mmiowr_ssreset_w1c_unsupported,
+            NVME_GUEST_ERR(nvme_dev_ub_mmiowr_ssreset_w1c_unsupported,
                            "attempted to W1C CSTS.NSSRO"
                            " but CAP.NSSRS is zero (not supported)");
         } else if (data !=3D 0) {
-            NVME_GUEST_ERR(nvme_ub_mmiowr_ro_csts,
+            NVME_GUEST_ERR(nvme_dev_ub_mmiowr_ro_csts,
                            "attempted to set a read only bit"
                            " of controller status");
         }
         break;
     case 0x20:  /* NSSR */
         if (data =3D=3D 0x4E564D65) {
-            trace_nvme_ub_mmiowr_ssreset_unsupported();
+            trace_nvme_dev_ub_mmiowr_ssreset_unsupported();
         } else {
             /* The spec says that writes of other values have no effect =
*/
             return;
@@ -1114,35 +1114,35 @@ static void nvme_write_bar(NvmeCtrl *n, hwaddr of=
fset, uint64_t data,
         break;
     case 0x24:  /* AQA */
         n->bar.aqa =3D data & 0xffffffff;
-        trace_nvme_mmio_aqattr(data & 0xffffffff);
+        trace_nvme_dev_mmio_aqattr(data & 0xffffffff);
         break;
     case 0x28:  /* ASQ */
         n->bar.asq =3D data;
-        trace_nvme_mmio_asqaddr(data);
+        trace_nvme_dev_mmio_asqaddr(data);
         break;
     case 0x2c:  /* ASQ hi */
         n->bar.asq |=3D data << 32;
-        trace_nvme_mmio_asqaddr_hi(data, n->bar.asq);
+        trace_nvme_dev_mmio_asqaddr_hi(data, n->bar.asq);
         break;
     case 0x30:  /* ACQ */
-        trace_nvme_mmio_acqaddr(data);
+        trace_nvme_dev_mmio_acqaddr(data);
         n->bar.acq =3D data;
         break;
     case 0x34:  /* ACQ hi */
         n->bar.acq |=3D data << 32;
-        trace_nvme_mmio_acqaddr_hi(data, n->bar.acq);
+        trace_nvme_dev_mmio_acqaddr_hi(data, n->bar.acq);
         break;
     case 0x38:  /* CMBLOC */
-        NVME_GUEST_ERR(nvme_ub_mmiowr_cmbloc_reserved,
+        NVME_GUEST_ERR(nvme_dev_ub_mmiowr_cmbloc_reserved,
                        "invalid write to reserved CMBLOC"
                        " when CMBSZ is zero, ignored");
         return;
     case 0x3C:  /* CMBSZ */
-        NVME_GUEST_ERR(nvme_ub_mmiowr_cmbsz_readonly,
+        NVME_GUEST_ERR(nvme_dev_ub_mmiowr_cmbsz_readonly,
                        "invalid write to read only CMBSZ, ignored");
         return;
     default:
-        NVME_GUEST_ERR(nvme_ub_mmiowr_invalid,
+        NVME_GUEST_ERR(nvme_dev_ub_mmiowr_invalid,
                        "invalid MMIO write,"
                        " offset=3D0x%"PRIx64", data=3D%"PRIx64"",
                        offset, data);
@@ -1157,12 +1157,12 @@ static uint64_t nvme_mmio_read(void *opaque, hwad=
dr addr, unsigned size)
     uint64_t val =3D 0;
=20
     if (unlikely(addr & (sizeof(uint32_t) - 1))) {
-        NVME_GUEST_ERR(nvme_ub_mmiord_misaligned32,
+        NVME_GUEST_ERR(nvme_dev_ub_mmiord_misaligned32,
                        "MMIO read not 32-bit aligned,"
                        " offset=3D0x%"PRIx64"", addr);
         /* should RAZ, fall through for now */
     } else if (unlikely(size < sizeof(uint32_t))) {
-        NVME_GUEST_ERR(nvme_ub_mmiord_toosmall,
+        NVME_GUEST_ERR(nvme_dev_ub_mmiord_toosmall,
                        "MMIO read smaller than 32-bits,"
                        " offset=3D0x%"PRIx64"", addr);
         /* should RAZ, fall through for now */
@@ -1171,7 +1171,7 @@ static uint64_t nvme_mmio_read(void *opaque, hwaddr=
 addr, unsigned size)
     if (addr < sizeof(n->bar)) {
         memcpy(&val, ptr + addr, size);
     } else {
-        NVME_GUEST_ERR(nvme_ub_mmiord_invalid_ofs,
+        NVME_GUEST_ERR(nvme_dev_ub_mmiord_invalid_ofs,
                        "MMIO read beyond last register,"
                        " offset=3D0x%"PRIx64", returning 0", addr);
     }
@@ -1184,7 +1184,7 @@ static void nvme_process_db(NvmeCtrl *n, hwaddr add=
r, int val)
     uint32_t qid;
=20
     if (unlikely(addr & ((1 << 2) - 1))) {
-        NVME_GUEST_ERR(nvme_ub_db_wr_misaligned,
+        NVME_GUEST_ERR(nvme_dev_ub_db_wr_misaligned,
                        "doorbell write not 32-bit aligned,"
                        " offset=3D0x%"PRIx64", ignoring", addr);
         return;
@@ -1199,7 +1199,7 @@ static void nvme_process_db(NvmeCtrl *n, hwaddr add=
r, int val)
=20
         qid =3D (addr - (0x1000 + (1 << 2))) >> 3;
         if (unlikely(nvme_check_cqid(n, qid))) {
-            NVME_GUEST_ERR(nvme_ub_db_wr_invalid_cq,
+            NVME_GUEST_ERR(nvme_dev_ub_db_wr_invalid_cq,
                            "completion queue doorbell write"
                            " for nonexistent queue,"
                            " sqid=3D%"PRIu32", ignoring", qid);
@@ -1208,7 +1208,7 @@ static void nvme_process_db(NvmeCtrl *n, hwaddr add=
r, int val)
=20
         cq =3D n->cq[qid];
         if (unlikely(new_head >=3D cq->size)) {
-            NVME_GUEST_ERR(nvme_ub_db_wr_invalid_cqhead,
+            NVME_GUEST_ERR(nvme_dev_ub_db_wr_invalid_cqhead,
                            "completion queue doorbell write value"
                            " beyond queue size, sqid=3D%"PRIu32","
                            " new_head=3D%"PRIu16", ignoring",
@@ -1237,7 +1237,7 @@ static void nvme_process_db(NvmeCtrl *n, hwaddr add=
r, int val)
=20
         qid =3D (addr - 0x1000) >> 3;
         if (unlikely(nvme_check_sqid(n, qid))) {
-            NVME_GUEST_ERR(nvme_ub_db_wr_invalid_sq,
+            NVME_GUEST_ERR(nvme_dev_ub_db_wr_invalid_sq,
                            "submission queue doorbell write"
                            " for nonexistent queue,"
                            " sqid=3D%"PRIu32", ignoring", qid);
@@ -1246,7 +1246,7 @@ static void nvme_process_db(NvmeCtrl *n, hwaddr add=
r, int val)
=20
         sq =3D n->sq[qid];
         if (unlikely(new_tail >=3D sq->size)) {
-            NVME_GUEST_ERR(nvme_ub_db_wr_invalid_sqtail,
+            NVME_GUEST_ERR(nvme_dev_ub_db_wr_invalid_sqtail,
                            "submission queue doorbell write value"
                            " beyond queue size, sqid=3D%"PRIu32","
                            " new_tail=3D%"PRIu16", ignoring",
diff --git a/hw/block/trace-events b/hw/block/trace-events
index c03e80c2c9c9..ade506ea2bb2 100644
--- a/hw/block/trace-events
+++ b/hw/block/trace-events
@@ -29,96 +29,96 @@ hd_geometry_guess(void *blk, uint32_t cyls, uint32_t =
heads, uint32_t secs, int t
=20
 # nvme.c
 # nvme traces for successful events
-nvme_irq_msix(uint32_t vector) "raising MSI-X IRQ vector %u"
-nvme_irq_pin(void) "pulsing IRQ pin"
-nvme_irq_masked(void) "IRQ is masked"
-nvme_dma_read(uint64_t prp1, uint64_t prp2) "DMA read, prp1=3D0x%"PRIx64=
" prp2=3D0x%"PRIx64""
-nvme_rw(const char *verb, uint32_t blk_count, uint64_t byte_count, uint6=
4_t lba) "%s %"PRIu32" blocks (%"PRIu64" bytes) from LBA %"PRIu64""
-nvme_create_sq(uint64_t addr, uint16_t sqid, uint16_t cqid, uint16_t qsi=
ze, uint16_t qflags) "create submission queue, addr=3D0x%"PRIx64", sqid=3D=
%"PRIu16", cqid=3D%"PRIu16", qsize=3D%"PRIu16", qflags=3D%"PRIu16""
-nvme_create_cq(uint64_t addr, uint16_t cqid, uint16_t vector, uint16_t s=
ize, uint16_t qflags, int ien) "create completion queue, addr=3D0x%"PRIx6=
4", cqid=3D%"PRIu16", vector=3D%"PRIu16", qsize=3D%"PRIu16", qflags=3D%"P=
RIu16", ien=3D%d"
-nvme_del_sq(uint16_t qid) "deleting submission queue sqid=3D%"PRIu16""
-nvme_del_cq(uint16_t cqid) "deleted completion queue, sqid=3D%"PRIu16""
-nvme_identify_ctrl(void) "identify controller"
-nvme_identify_ns(uint16_t ns) "identify namespace, nsid=3D%"PRIu16""
-nvme_identify_nslist(uint16_t ns) "identify namespace list, nsid=3D%"PRI=
u16""
-nvme_getfeat_vwcache(const char* result) "get feature volatile write cac=
he, result=3D%s"
-nvme_getfeat_numq(int result) "get feature number of queues, result=3D%d=
"
-nvme_setfeat_numq(int reqcq, int reqsq, int gotcq, int gotsq) "requested=
 cq_count=3D%d sq_count=3D%d, responding with cq_count=3D%d sq_count=3D%d=
"
-nvme_setfeat_timestamp(uint64_t ts) "set feature timestamp =3D 0x%"PRIx6=
4""
-nvme_getfeat_timestamp(uint64_t ts) "get feature timestamp =3D 0x%"PRIx6=
4""
-nvme_mmio_intm_set(uint64_t data, uint64_t new_mask) "wrote MMIO, interr=
upt mask set, data=3D0x%"PRIx64", new_mask=3D0x%"PRIx64""
-nvme_mmio_intm_clr(uint64_t data, uint64_t new_mask) "wrote MMIO, interr=
upt mask clr, data=3D0x%"PRIx64", new_mask=3D0x%"PRIx64""
-nvme_mmio_cfg(uint64_t data) "wrote MMIO, config controller config=3D0x%=
"PRIx64""
-nvme_mmio_aqattr(uint64_t data) "wrote MMIO, admin queue attributes=3D0x=
%"PRIx64""
-nvme_mmio_asqaddr(uint64_t data) "wrote MMIO, admin submission queue add=
ress=3D0x%"PRIx64""
-nvme_mmio_acqaddr(uint64_t data) "wrote MMIO, admin completion queue add=
ress=3D0x%"PRIx64""
-nvme_mmio_asqaddr_hi(uint64_t data, uint64_t new_addr) "wrote MMIO, admi=
n submission queue high half=3D0x%"PRIx64", new_address=3D0x%"PRIx64""
-nvme_mmio_acqaddr_hi(uint64_t data, uint64_t new_addr) "wrote MMIO, admi=
n completion queue high half=3D0x%"PRIx64", new_address=3D0x%"PRIx64""
-nvme_mmio_start_success(void) "setting controller enable bit succeeded"
-nvme_mmio_stopped(void) "cleared controller enable bit"
-nvme_mmio_shutdown_set(void) "shutdown bit set"
-nvme_mmio_shutdown_cleared(void) "shutdown bit cleared"
+nvme_dev_irq_msix(uint32_t vector) "raising MSI-X IRQ vector %u"
+nvme_dev_irq_pin(void) "pulsing IRQ pin"
+nvme_dev_irq_masked(void) "IRQ is masked"
+nvme_dev_dma_read(uint64_t prp1, uint64_t prp2) "DMA read, prp1=3D0x%"PR=
Ix64" prp2=3D0x%"PRIx64""
+nvme_dev_rw(const char *verb, uint32_t blk_count, uint64_t byte_count, u=
int64_t lba) "%s %"PRIu32" blocks (%"PRIu64" bytes) from LBA %"PRIu64""
+nvme_dev_create_sq(uint64_t addr, uint16_t sqid, uint16_t cqid, uint16_t=
 qsize, uint16_t qflags) "create submission queue, addr=3D0x%"PRIx64", sq=
id=3D%"PRIu16", cqid=3D%"PRIu16", qsize=3D%"PRIu16", qflags=3D%"PRIu16""
+nvme_dev_create_cq(uint64_t addr, uint16_t cqid, uint16_t vector, uint16=
_t size, uint16_t qflags, int ien) "create completion queue, addr=3D0x%"P=
RIx64", cqid=3D%"PRIu16", vector=3D%"PRIu16", qsize=3D%"PRIu16", qflags=3D=
%"PRIu16", ien=3D%d"
+nvme_dev_del_sq(uint16_t qid) "deleting submission queue sqid=3D%"PRIu16=
""
+nvme_dev_del_cq(uint16_t cqid) "deleted completion queue, sqid=3D%"PRIu1=
6""
+nvme_dev_identify_ctrl(void) "identify controller"
+nvme_dev_identify_ns(uint16_t ns) "identify namespace, nsid=3D%"PRIu16""
+nvme_dev_identify_nslist(uint16_t ns) "identify namespace list, nsid=3D%=
"PRIu16""
+nvme_dev_getfeat_vwcache(const char* result) "get feature volatile write=
 cache, result=3D%s"
+nvme_dev_getfeat_numq(int result) "get feature number of queues, result=3D=
%d"
+nvme_dev_setfeat_numq(int reqcq, int reqsq, int gotcq, int gotsq) "reque=
sted cq_count=3D%d sq_count=3D%d, responding with cq_count=3D%d sq_count=3D=
%d"
+nvme_dev_setfeat_timestamp(uint64_t ts) "set feature timestamp =3D 0x%"P=
RIx64""
+nvme_dev_getfeat_timestamp(uint64_t ts) "get feature timestamp =3D 0x%"P=
RIx64""
+nvme_dev_mmio_intm_set(uint64_t data, uint64_t new_mask) "wrote MMIO, in=
terrupt mask set, data=3D0x%"PRIx64", new_mask=3D0x%"PRIx64""
+nvme_dev_mmio_intm_clr(uint64_t data, uint64_t new_mask) "wrote MMIO, in=
terrupt mask clr, data=3D0x%"PRIx64", new_mask=3D0x%"PRIx64""
+nvme_dev_mmio_cfg(uint64_t data) "wrote MMIO, config controller config=3D=
0x%"PRIx64""
+nvme_dev_mmio_aqattr(uint64_t data) "wrote MMIO, admin queue attributes=3D=
0x%"PRIx64""
+nvme_dev_mmio_asqaddr(uint64_t data) "wrote MMIO, admin submission queue=
 address=3D0x%"PRIx64""
+nvme_dev_mmio_acqaddr(uint64_t data) "wrote MMIO, admin completion queue=
 address=3D0x%"PRIx64""
+nvme_dev_mmio_asqaddr_hi(uint64_t data, uint64_t new_addr) "wrote MMIO, =
admin submission queue high half=3D0x%"PRIx64", new_address=3D0x%"PRIx64"=
"
+nvme_dev_mmio_acqaddr_hi(uint64_t data, uint64_t new_addr) "wrote MMIO, =
admin completion queue high half=3D0x%"PRIx64", new_address=3D0x%"PRIx64"=
"
+nvme_dev_mmio_start_success(void) "setting controller enable bit succeed=
ed"
+nvme_dev_mmio_stopped(void) "cleared controller enable bit"
+nvme_dev_mmio_shutdown_set(void) "shutdown bit set"
+nvme_dev_mmio_shutdown_cleared(void) "shutdown bit cleared"
=20
 # nvme traces for error conditions
-nvme_err_invalid_dma(void) "PRP/SGL is too small for transfer size"
-nvme_err_invalid_prplist_ent(uint64_t prplist) "PRP list entry is null o=
r not page aligned: 0x%"PRIx64""
-nvme_err_invalid_prp2_align(uint64_t prp2) "PRP2 is not page aligned: 0x=
%"PRIx64""
-nvme_err_invalid_prp2_missing(void) "PRP2 is null and more data to be tr=
ansferred"
-nvme_err_invalid_prp(void) "invalid PRP"
-nvme_err_invalid_ns(uint32_t ns, uint32_t limit) "invalid namespace %u n=
ot within 1-%u"
-nvme_err_invalid_opc(uint8_t opc) "invalid opcode 0x%"PRIx8""
-nvme_err_invalid_admin_opc(uint8_t opc) "invalid admin opcode 0x%"PRIx8"=
"
-nvme_err_invalid_lba_range(uint64_t start, uint64_t len, uint64_t limit)=
 "Invalid LBA start=3D%"PRIu64" len=3D%"PRIu64" limit=3D%"PRIu64""
-nvme_err_invalid_del_sq(uint16_t qid) "invalid submission queue deletion=
, sid=3D%"PRIu16""
-nvme_err_invalid_create_sq_cqid(uint16_t cqid) "failed creating submissi=
on queue, invalid cqid=3D%"PRIu16""
-nvme_err_invalid_create_sq_sqid(uint16_t sqid) "failed creating submissi=
on queue, invalid sqid=3D%"PRIu16""
-nvme_err_invalid_create_sq_size(uint16_t qsize) "failed creating submiss=
ion queue, invalid qsize=3D%"PRIu16""
-nvme_err_invalid_create_sq_addr(uint64_t addr) "failed creating submissi=
on queue, addr=3D0x%"PRIx64""
-nvme_err_invalid_create_sq_qflags(uint16_t qflags) "failed creating subm=
ission queue, qflags=3D%"PRIu16""
-nvme_err_invalid_del_cq_cqid(uint16_t cqid) "failed deleting completion =
queue, cqid=3D%"PRIu16""
-nvme_err_invalid_del_cq_notempty(uint16_t cqid) "failed deleting complet=
ion queue, it is not empty, cqid=3D%"PRIu16""
-nvme_err_invalid_create_cq_cqid(uint16_t cqid) "failed creating completi=
on queue, cqid=3D%"PRIu16""
-nvme_err_invalid_create_cq_size(uint16_t size) "failed creating completi=
on queue, size=3D%"PRIu16""
-nvme_err_invalid_create_cq_addr(uint64_t addr) "failed creating completi=
on queue, addr=3D0x%"PRIx64""
-nvme_err_invalid_create_cq_vector(uint16_t vector) "failed creating comp=
letion queue, vector=3D%"PRIu16""
-nvme_err_invalid_create_cq_qflags(uint16_t qflags) "failed creating comp=
letion queue, qflags=3D%"PRIu16""
-nvme_err_invalid_identify_cns(uint16_t cns) "identify, invalid cns=3D0x%=
"PRIx16""
-nvme_err_invalid_getfeat(int dw10) "invalid get features, dw10=3D0x%"PRI=
x32""
-nvme_err_invalid_setfeat(uint32_t dw10) "invalid set features, dw10=3D0x=
%"PRIx32""
-nvme_err_startfail_cq(void) "nvme_start_ctrl failed because there are no=
n-admin completion queues"
-nvme_err_startfail_sq(void) "nvme_start_ctrl failed because there are no=
n-admin submission queues"
-nvme_err_startfail_nbarasq(void) "nvme_start_ctrl failed because the adm=
in submission queue address is null"
-nvme_err_startfail_nbaracq(void) "nvme_start_ctrl failed because the adm=
in completion queue address is null"
-nvme_err_startfail_asq_misaligned(uint64_t addr) "nvme_start_ctrl failed=
 because the admin submission queue address is misaligned: 0x%"PRIx64""
-nvme_err_startfail_acq_misaligned(uint64_t addr) "nvme_start_ctrl failed=
 because the admin completion queue address is misaligned: 0x%"PRIx64""
-nvme_err_startfail_page_too_small(uint8_t log2ps, uint8_t maxlog2ps) "nv=
me_start_ctrl failed because the page size is too small: log2size=3D%u, m=
in=3D%u"
-nvme_err_startfail_page_too_large(uint8_t log2ps, uint8_t maxlog2ps) "nv=
me_start_ctrl failed because the page size is too large: log2size=3D%u, m=
ax=3D%u"
-nvme_err_startfail_cqent_too_small(uint8_t log2ps, uint8_t maxlog2ps) "n=
vme_start_ctrl failed because the completion queue entry size is too smal=
l: log2size=3D%u, min=3D%u"
-nvme_err_startfail_cqent_too_large(uint8_t log2ps, uint8_t maxlog2ps) "n=
vme_start_ctrl failed because the completion queue entry size is too larg=
e: log2size=3D%u, max=3D%u"
-nvme_err_startfail_sqent_too_small(uint8_t log2ps, uint8_t maxlog2ps) "n=
vme_start_ctrl failed because the submission queue entry size is too smal=
l: log2size=3D%u, min=3D%u"
-nvme_err_startfail_sqent_too_large(uint8_t log2ps, uint8_t maxlog2ps) "n=
vme_start_ctrl failed because the submission queue entry size is too larg=
e: log2size=3D%u, max=3D%u"
-nvme_err_startfail_asqent_sz_zero(void) "nvme_start_ctrl failed because =
the admin submission queue size is zero"
-nvme_err_startfail_acqent_sz_zero(void) "nvme_start_ctrl failed because =
the admin completion queue size is zero"
-nvme_err_startfail(void) "setting controller enable bit failed"
+nvme_dev_err_invalid_dma(void) "PRP/SGL is too small for transfer size"
+nvme_dev_err_invalid_prplist_ent(uint64_t prplist) "PRP list entry is nu=
ll or not page aligned: 0x%"PRIx64""
+nvme_dev_err_invalid_prp2_align(uint64_t prp2) "PRP2 is not page aligned=
: 0x%"PRIx64""
+nvme_dev_err_invalid_prp2_missing(void) "PRP2 is null and more data to b=
e transferred"
+nvme_dev_err_invalid_prp(void) "invalid PRP"
+nvme_dev_err_invalid_ns(uint32_t ns, uint32_t limit) "invalid namespace =
%u not within 1-%u"
+nvme_dev_err_invalid_opc(uint8_t opc) "invalid opcode 0x%"PRIx8""
+nvme_dev_err_invalid_admin_opc(uint8_t opc) "invalid admin opcode 0x%"PR=
Ix8""
+nvme_dev_err_invalid_lba_range(uint64_t start, uint64_t len, uint64_t li=
mit) "Invalid LBA start=3D%"PRIu64" len=3D%"PRIu64" limit=3D%"PRIu64""
+nvme_dev_err_invalid_del_sq(uint16_t qid) "invalid submission queue dele=
tion, sid=3D%"PRIu16""
+nvme_dev_err_invalid_create_sq_cqid(uint16_t cqid) "failed creating subm=
ission queue, invalid cqid=3D%"PRIu16""
+nvme_dev_err_invalid_create_sq_sqid(uint16_t sqid) "failed creating subm=
ission queue, invalid sqid=3D%"PRIu16""
+nvme_dev_err_invalid_create_sq_size(uint16_t qsize) "failed creating sub=
mission queue, invalid qsize=3D%"PRIu16""
+nvme_dev_err_invalid_create_sq_addr(uint64_t addr) "failed creating subm=
ission queue, addr=3D0x%"PRIx64""
+nvme_dev_err_invalid_create_sq_qflags(uint16_t qflags) "failed creating =
submission queue, qflags=3D%"PRIu16""
+nvme_dev_err_invalid_del_cq_cqid(uint16_t cqid) "failed deleting complet=
ion queue, cqid=3D%"PRIu16""
+nvme_dev_err_invalid_del_cq_notempty(uint16_t cqid) "failed deleting com=
pletion queue, it is not empty, cqid=3D%"PRIu16""
+nvme_dev_err_invalid_create_cq_cqid(uint16_t cqid) "failed creating comp=
letion queue, cqid=3D%"PRIu16""
+nvme_dev_err_invalid_create_cq_size(uint16_t size) "failed creating comp=
letion queue, size=3D%"PRIu16""
+nvme_dev_err_invalid_create_cq_addr(uint64_t addr) "failed creating comp=
letion queue, addr=3D0x%"PRIx64""
+nvme_dev_err_invalid_create_cq_vector(uint16_t vector) "failed creating =
completion queue, vector=3D%"PRIu16""
+nvme_dev_err_invalid_create_cq_qflags(uint16_t qflags) "failed creating =
completion queue, qflags=3D%"PRIu16""
+nvme_dev_err_invalid_identify_cns(uint16_t cns) "identify, invalid cns=3D=
0x%"PRIx16""
+nvme_dev_err_invalid_getfeat(int dw10) "invalid get features, dw10=3D0x%=
"PRIx32""
+nvme_dev_err_invalid_setfeat(uint32_t dw10) "invalid set features, dw10=3D=
0x%"PRIx32""
+nvme_dev_err_startfail_cq(void) "nvme_start_ctrl failed because there ar=
e non-admin completion queues"
+nvme_dev_err_startfail_sq(void) "nvme_start_ctrl failed because there ar=
e non-admin submission queues"
+nvme_dev_err_startfail_nbarasq(void) "nvme_start_ctrl failed because the=
 admin submission queue address is null"
+nvme_dev_err_startfail_nbaracq(void) "nvme_start_ctrl failed because the=
 admin completion queue address is null"
+nvme_dev_err_startfail_asq_misaligned(uint64_t addr) "nvme_start_ctrl fa=
iled because the admin submission queue address is misaligned: 0x%"PRIx64=
""
+nvme_dev_err_startfail_acq_misaligned(uint64_t addr) "nvme_start_ctrl fa=
iled because the admin completion queue address is misaligned: 0x%"PRIx64=
""
+nvme_dev_err_startfail_page_too_small(uint8_t log2ps, uint8_t maxlog2ps)=
 "nvme_start_ctrl failed because the page size is too small: log2size=3D%=
u, min=3D%u"
+nvme_dev_err_startfail_page_too_large(uint8_t log2ps, uint8_t maxlog2ps)=
 "nvme_start_ctrl failed because the page size is too large: log2size=3D%=
u, max=3D%u"
+nvme_dev_err_startfail_cqent_too_small(uint8_t log2ps, uint8_t maxlog2ps=
) "nvme_start_ctrl failed because the completion queue entry size is too =
small: log2size=3D%u, min=3D%u"
+nvme_dev_err_startfail_cqent_too_large(uint8_t log2ps, uint8_t maxlog2ps=
) "nvme_start_ctrl failed because the completion queue entry size is too =
large: log2size=3D%u, max=3D%u"
+nvme_dev_err_startfail_sqent_too_small(uint8_t log2ps, uint8_t maxlog2ps=
) "nvme_start_ctrl failed because the submission queue entry size is too =
small: log2size=3D%u, min=3D%u"
+nvme_dev_err_startfail_sqent_too_large(uint8_t log2ps, uint8_t maxlog2ps=
) "nvme_start_ctrl failed because the submission queue entry size is too =
large: log2size=3D%u, max=3D%u"
+nvme_dev_err_startfail_asqent_sz_zero(void) "nvme_start_ctrl failed beca=
use the admin submission queue size is zero"
+nvme_dev_err_startfail_acqent_sz_zero(void) "nvme_start_ctrl failed beca=
use the admin completion queue size is zero"
+nvme_dev_err_startfail(void) "setting controller enable bit failed"
=20
 # Traces for undefined behavior
-nvme_ub_mmiowr_misaligned32(uint64_t offset) "MMIO write not 32-bit alig=
ned, offset=3D0x%"PRIx64""
-nvme_ub_mmiowr_toosmall(uint64_t offset, unsigned size) "MMIO write smal=
ler than 32 bits, offset=3D0x%"PRIx64", size=3D%u"
-nvme_ub_mmiowr_intmask_with_msix(void) "undefined access to interrupt ma=
sk set when MSI-X is enabled"
-nvme_ub_mmiowr_ro_csts(void) "attempted to set a read only bit of contro=
ller status"
-nvme_ub_mmiowr_ssreset_w1c_unsupported(void) "attempted to W1C CSTS.NSSR=
O but CAP.NSSRS is zero (not supported)"
-nvme_ub_mmiowr_ssreset_unsupported(void) "attempted NVM subsystem reset =
but CAP.NSSRS is zero (not supported)"
-nvme_ub_mmiowr_cmbloc_reserved(void) "invalid write to reserved CMBLOC w=
hen CMBSZ is zero, ignored"
-nvme_ub_mmiowr_cmbsz_readonly(void) "invalid write to read only CMBSZ, i=
gnored"
-nvme_ub_mmiowr_invalid(uint64_t offset, uint64_t data) "invalid MMIO wri=
te, offset=3D0x%"PRIx64", data=3D0x%"PRIx64""
-nvme_ub_mmiord_misaligned32(uint64_t offset) "MMIO read not 32-bit align=
ed, offset=3D0x%"PRIx64""
-nvme_ub_mmiord_toosmall(uint64_t offset) "MMIO read smaller than 32-bits=
, offset=3D0x%"PRIx64""
-nvme_ub_mmiord_invalid_ofs(uint64_t offset) "MMIO read beyond last regis=
ter, offset=3D0x%"PRIx64", returning 0"
-nvme_ub_db_wr_misaligned(uint64_t offset) "doorbell write not 32-bit ali=
gned, offset=3D0x%"PRIx64", ignoring"
-nvme_ub_db_wr_invalid_cq(uint32_t qid) "completion queue doorbell write =
for nonexistent queue, cqid=3D%"PRIu32", ignoring"
-nvme_ub_db_wr_invalid_cqhead(uint32_t qid, uint16_t new_head) "completio=
n queue doorbell write value beyond queue size, cqid=3D%"PRIu32", new_hea=
d=3D%"PRIu16", ignoring"
-nvme_ub_db_wr_invalid_sq(uint32_t qid) "submission queue doorbell write =
for nonexistent queue, sqid=3D%"PRIu32", ignoring"
-nvme_ub_db_wr_invalid_sqtail(uint32_t qid, uint16_t new_tail) "submissio=
n queue doorbell write value beyond queue size, sqid=3D%"PRIu32", new_hea=
d=3D%"PRIu16", ignoring"
+nvme_dev_ub_mmiowr_misaligned32(uint64_t offset) "MMIO write not 32-bit =
aligned, offset=3D0x%"PRIx64""
+nvme_dev_ub_mmiowr_toosmall(uint64_t offset, unsigned size) "MMIO write =
smaller than 32 bits, offset=3D0x%"PRIx64", size=3D%u"
+nvme_dev_ub_mmiowr_intmask_with_msix(void) "undefined access to interrup=
t mask set when MSI-X is enabled"
+nvme_dev_ub_mmiowr_ro_csts(void) "attempted to set a read only bit of co=
ntroller status"
+nvme_dev_ub_mmiowr_ssreset_w1c_unsupported(void) "attempted to W1C CSTS.=
NSSRO but CAP.NSSRS is zero (not supported)"
+nvme_dev_ub_mmiowr_ssreset_unsupported(void) "attempted NVM subsystem re=
set but CAP.NSSRS is zero (not supported)"
+nvme_dev_ub_mmiowr_cmbloc_reserved(void) "invalid write to reserved CMBL=
OC when CMBSZ is zero, ignored"
+nvme_dev_ub_mmiowr_cmbsz_readonly(void) "invalid write to read only CMBS=
Z, ignored"
+nvme_dev_ub_mmiowr_invalid(uint64_t offset, uint64_t data) "invalid MMIO=
 write, offset=3D0x%"PRIx64", data=3D0x%"PRIx64""
+nvme_dev_ub_mmiord_misaligned32(uint64_t offset) "MMIO read not 32-bit a=
ligned, offset=3D0x%"PRIx64""
+nvme_dev_ub_mmiord_toosmall(uint64_t offset) "MMIO read smaller than 32-=
bits, offset=3D0x%"PRIx64""
+nvme_dev_ub_mmiord_invalid_ofs(uint64_t offset) "MMIO read beyond last r=
egister, offset=3D0x%"PRIx64", returning 0"
+nvme_dev_ub_db_wr_misaligned(uint64_t offset) "doorbell write not 32-bit=
 aligned, offset=3D0x%"PRIx64", ignoring"
+nvme_dev_ub_db_wr_invalid_cq(uint32_t qid) "completion queue doorbell wr=
ite for nonexistent queue, cqid=3D%"PRIu32", ignoring"
+nvme_dev_ub_db_wr_invalid_cqhead(uint32_t qid, uint16_t new_head) "compl=
etion queue doorbell write value beyond queue size, cqid=3D%"PRIu32", new=
_head=3D%"PRIu16", ignoring"
+nvme_dev_ub_db_wr_invalid_sq(uint32_t qid) "submission queue doorbell wr=
ite for nonexistent queue, sqid=3D%"PRIu32", ignoring"
+nvme_dev_ub_db_wr_invalid_sqtail(uint32_t qid, uint16_t new_tail) "submi=
ssion queue doorbell write value beyond queue size, sqid=3D%"PRIu32", new=
_head=3D%"PRIu16", ignoring"
=20
 # xen-block.c
 xen_block_realize(const char *type, uint32_t disk, uint32_t partition) "=
%s d%up%u"
--=20
2.25.1


