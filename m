Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA966C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 19:06:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3F2C2067B
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 19:06:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3F2C2067B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55696 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jijZm-0008Nj-Tw
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 15:06:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44604)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1jijXG-0005y4-Hk; Tue, 09 Jun 2020 15:03:46 -0400
Received: from charlie.dont.surf ([128.199.63.193]:40208)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1jijXE-0006h1-Ls; Tue, 09 Jun 2020 15:03:46 -0400
Received: from apples.local (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by charlie.dont.surf (Postfix) with ESMTPSA id D2BA9BF8E0;
 Tue,  9 Jun 2020 19:03:42 +0000 (UTC)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-block@nongnu.org
Subject: [PATCH v7 04/22] hw/block/nvme: move device parameters to separate
 struct
Date: Tue,  9 Jun 2020 21:03:15 +0200
Message-Id: <20200609190333.59390-5-its@irrelevant.dk>
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

Move device configuration parameters to separate struct to make it
explicit what is configurable and what is set internally.

Signed-off-by: Klaus Jensen <klaus.jensen@cnexlabs.com>
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
Message-Id: <20200514044611.734782-5-its@irrelevant.dk>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 hw/block/nvme.c | 49 ++++++++++++++++++++++++++-----------------------
 hw/block/nvme.h | 11 ++++++++---
 2 files changed, 34 insertions(+), 26 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 0d3f8f345f9a..bc2d9d2091d6 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -77,12 +77,12 @@ static void nvme_addr_read(NvmeCtrl *n, hwaddr addr, void *buf, int size)
 
 static int nvme_check_sqid(NvmeCtrl *n, uint16_t sqid)
 {
-    return sqid < n->num_queues && n->sq[sqid] != NULL ? 0 : -1;
+    return sqid < n->params.num_queues && n->sq[sqid] != NULL ? 0 : -1;
 }
 
 static int nvme_check_cqid(NvmeCtrl *n, uint16_t cqid)
 {
-    return cqid < n->num_queues && n->cq[cqid] != NULL ? 0 : -1;
+    return cqid < n->params.num_queues && n->cq[cqid] != NULL ? 0 : -1;
 }
 
 static void nvme_inc_cq_tail(NvmeCQueue *cq)
@@ -644,7 +644,7 @@ static uint16_t nvme_create_cq(NvmeCtrl *n, NvmeCmd *cmd)
         trace_pci_nvme_err_invalid_create_cq_addr(prp1);
         return NVME_INVALID_FIELD | NVME_DNR;
     }
-    if (unlikely(vector > n->num_queues)) {
+    if (unlikely(vector > n->params.num_queues)) {
         trace_pci_nvme_err_invalid_create_cq_vector(vector);
         return NVME_INVALID_IRQ_VECTOR | NVME_DNR;
     }
@@ -796,7 +796,8 @@ static uint16_t nvme_get_feature(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
         trace_pci_nvme_getfeat_vwcache(result ? "enabled" : "disabled");
         break;
     case NVME_NUMBER_OF_QUEUES:
-        result = cpu_to_le32((n->num_queues - 2) | ((n->num_queues - 2) << 16));
+        result = cpu_to_le32((n->params.num_queues - 2) |
+                             ((n->params.num_queues - 2) << 16));
         trace_pci_nvme_getfeat_numq(result);
         break;
     case NVME_TIMESTAMP:
@@ -840,9 +841,10 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
     case NVME_NUMBER_OF_QUEUES:
         trace_pci_nvme_setfeat_numq((dw11 & 0xFFFF) + 1,
                                     ((dw11 >> 16) & 0xFFFF) + 1,
-                                    n->num_queues - 1, n->num_queues - 1);
-        req->cqe.result =
-            cpu_to_le32((n->num_queues - 2) | ((n->num_queues - 2) << 16));
+                                    n->params.num_queues - 1,
+                                    n->params.num_queues - 1);
+        req->cqe.result = cpu_to_le32((n->params.num_queues - 2) |
+                                      ((n->params.num_queues - 2) << 16));
         break;
     case NVME_TIMESTAMP:
         return nvme_set_feature_timestamp(n, cmd);
@@ -913,12 +915,12 @@ static void nvme_clear_ctrl(NvmeCtrl *n)
 
     blk_drain(n->conf.blk);
 
-    for (i = 0; i < n->num_queues; i++) {
+    for (i = 0; i < n->params.num_queues; i++) {
         if (n->sq[i] != NULL) {
             nvme_free_sq(n->sq[i], n);
         }
     }
-    for (i = 0; i < n->num_queues; i++) {
+    for (i = 0; i < n->params.num_queues; i++) {
         if (n->cq[i] != NULL) {
             nvme_free_cq(n->cq[i], n);
         }
@@ -1348,7 +1350,7 @@ static void nvme_realize(PCIDevice *pci_dev, Error **errp)
     int64_t bs_size;
     uint8_t *pci_conf;
 
-    if (!n->num_queues) {
+    if (!n->params.num_queues) {
         error_setg(errp, "num_queues can't be zero");
         return;
     }
@@ -1364,12 +1366,12 @@ static void nvme_realize(PCIDevice *pci_dev, Error **errp)
         return;
     }
 
-    if (!n->serial) {
+    if (!n->params.serial) {
         error_setg(errp, "serial property not set");
         return;
     }
 
-    if (!n->cmb_size_mb && n->pmrdev) {
+    if (!n->params.cmb_size_mb && n->pmrdev) {
         if (host_memory_backend_is_mapped(n->pmrdev)) {
             char *path = object_get_canonical_path_component(OBJECT(n->pmrdev));
             error_setg(errp, "can't use already busy memdev: %s", path);
@@ -1400,25 +1402,26 @@ static void nvme_realize(PCIDevice *pci_dev, Error **errp)
     n->num_namespaces = 1;
 
     /* num_queues is really number of pairs, so each has two doorbells */
-    n->reg_size = pow2ceil(NVME_REG_SIZE + 2 * n->num_queues * NVME_DB_SIZE);
+    n->reg_size = pow2ceil(NVME_REG_SIZE +
+                           2 * n->params.num_queues * NVME_DB_SIZE);
     n->ns_size = bs_size / (uint64_t)n->num_namespaces;
 
     n->namespaces = g_new0(NvmeNamespace, n->num_namespaces);
-    n->sq = g_new0(NvmeSQueue *, n->num_queues);
-    n->cq = g_new0(NvmeCQueue *, n->num_queues);
+    n->sq = g_new0(NvmeSQueue *, n->params.num_queues);
+    n->cq = g_new0(NvmeCQueue *, n->params.num_queues);
 
     memory_region_init_io(&n->iomem, OBJECT(n), &nvme_mmio_ops, n,
                           "nvme", n->reg_size);
     pci_register_bar(pci_dev, 0,
         PCI_BASE_ADDRESS_SPACE_MEMORY | PCI_BASE_ADDRESS_MEM_TYPE_64,
         &n->iomem);
-    msix_init_exclusive_bar(pci_dev, n->num_queues, 4, NULL);
+    msix_init_exclusive_bar(pci_dev, n->params.num_queues, 4, NULL);
 
     id->vid = cpu_to_le16(pci_get_word(pci_conf + PCI_VENDOR_ID));
     id->ssvid = cpu_to_le16(pci_get_word(pci_conf + PCI_SUBSYSTEM_VENDOR_ID));
     strpadcpy((char *)id->mn, sizeof(id->mn), "QEMU NVMe Ctrl", ' ');
     strpadcpy((char *)id->fr, sizeof(id->fr), "1.0", ' ');
-    strpadcpy((char *)id->sn, sizeof(id->sn), n->serial, ' ');
+    strpadcpy((char *)id->sn, sizeof(id->sn), n->params.serial, ' ');
     id->rab = 6;
     id->ieee[0] = 0x00;
     id->ieee[1] = 0x02;
@@ -1447,7 +1450,7 @@ static void nvme_realize(PCIDevice *pci_dev, Error **errp)
     n->bar.vs = 0x00010200;
     n->bar.intmc = n->bar.intms = 0;
 
-    if (n->cmb_size_mb) {
+    if (n->params.cmb_size_mb) {
 
         NVME_CMBLOC_SET_BIR(n->bar.cmbloc, 2);
         NVME_CMBLOC_SET_OFST(n->bar.cmbloc, 0);
@@ -1458,7 +1461,7 @@ static void nvme_realize(PCIDevice *pci_dev, Error **errp)
         NVME_CMBSZ_SET_RDS(n->bar.cmbsz, 1);
         NVME_CMBSZ_SET_WDS(n->bar.cmbsz, 1);
         NVME_CMBSZ_SET_SZU(n->bar.cmbsz, 2); /* MBs */
-        NVME_CMBSZ_SET_SZ(n->bar.cmbsz, n->cmb_size_mb);
+        NVME_CMBSZ_SET_SZ(n->bar.cmbsz, n->params.cmb_size_mb);
 
         n->cmbloc = n->bar.cmbloc;
         n->cmbsz = n->bar.cmbsz;
@@ -1542,7 +1545,7 @@ static void nvme_exit(PCIDevice *pci_dev)
     g_free(n->cq);
     g_free(n->sq);
 
-    if (n->cmb_size_mb) {
+    if (n->params.cmb_size_mb) {
         g_free(n->cmbuf);
     }
 
@@ -1556,9 +1559,9 @@ static Property nvme_props[] = {
     DEFINE_BLOCK_PROPERTIES(NvmeCtrl, conf),
     DEFINE_PROP_LINK("pmrdev", NvmeCtrl, pmrdev, TYPE_MEMORY_BACKEND,
                      HostMemoryBackend *),
-    DEFINE_PROP_STRING("serial", NvmeCtrl, serial),
-    DEFINE_PROP_UINT32("cmb_size_mb", NvmeCtrl, cmb_size_mb, 0),
-    DEFINE_PROP_UINT32("num_queues", NvmeCtrl, num_queues, 64),
+    DEFINE_PROP_STRING("serial", NvmeCtrl, params.serial),
+    DEFINE_PROP_UINT32("cmb_size_mb", NvmeCtrl, params.cmb_size_mb, 0),
+    DEFINE_PROP_UINT32("num_queues", NvmeCtrl, params.num_queues, 64),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/hw/block/nvme.h b/hw/block/nvme.h
index 6520a9f0bead..9df244c93c02 100644
--- a/hw/block/nvme.h
+++ b/hw/block/nvme.h
@@ -1,7 +1,14 @@
 #ifndef HW_NVME_H
 #define HW_NVME_H
+
 #include "block/nvme.h"
 
+typedef struct NvmeParams {
+    char     *serial;
+    uint32_t num_queues;
+    uint32_t cmb_size_mb;
+} NvmeParams;
+
 typedef struct NvmeAsyncEvent {
     QSIMPLEQ_ENTRY(NvmeAsyncEvent) entry;
     NvmeAerResult result;
@@ -63,6 +70,7 @@ typedef struct NvmeCtrl {
     MemoryRegion ctrl_mem;
     NvmeBar      bar;
     BlockConf    conf;
+    NvmeParams   params;
 
     uint32_t    page_size;
     uint16_t    page_bits;
@@ -71,10 +79,8 @@ typedef struct NvmeCtrl {
     uint16_t    sqe_size;
     uint32_t    reg_size;
     uint32_t    num_namespaces;
-    uint32_t    num_queues;
     uint32_t    max_q_ents;
     uint64_t    ns_size;
-    uint32_t    cmb_size_mb;
     uint32_t    cmbsz;
     uint32_t    cmbloc;
     uint8_t     *cmbuf;
@@ -82,7 +88,6 @@ typedef struct NvmeCtrl {
     uint64_t    host_timestamp;                 /* Timestamp sent by the host */
     uint64_t    timestamp_set_qemu_clock_ms;    /* QEMU clock time */
 
-    char            *serial;
     HostMemoryBackend *pmrdev;
 
     NvmeNamespace   *namespaces;
-- 
2.27.0


