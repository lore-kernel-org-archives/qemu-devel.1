Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E86DC43463
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 21:22:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6B2D22208
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 21:22:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6B2D22208
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55094 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJNq3-0003oJ-B7
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 17:22:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46562)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kJN80-0005Dn-Nf; Fri, 18 Sep 2020 16:37:08 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:43811)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kJN7x-0004zV-VD; Fri, 18 Sep 2020 16:37:08 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
 by mailnew.nyi.internal (Postfix) with ESMTP id 5A32D580230;
 Fri, 18 Sep 2020 16:36:44 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute7.internal (MEProxy); Fri, 18 Sep 2020 16:36:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm1; bh=V1J4f90bwo+Ef
 ZC3f/9mH/YsIrZrtwXG618pPmin5v0=; b=gEnKZsEz7M70LOuQdI4rdvRWS8Cfn
 ui7C7GP9KECfFMHlkMdWt/9Y8qwyibAfVZYhbzJ0p4LOPbxnlhkuxeWtDeK7mi8p
 YXgspgUQnKPZY3K7DFBKmICdv0tkEKcZf6CDTf0/dXckRqk1zSalQM5gRlnII4jK
 lu7+tomFgoCu+KERXIuK+A/7FN1GXYFachjR8Ygo4tsmgCcgqXbtRxulU0vxLPka
 Tpl+HvKsOTZSo4DToento5Re2MNiOIBhClfNL2QkUxQapC+BOhHrvbGBoIj735+N
 e53SiBrHVNVCWmaUcoax5L7obT0+p7H8Wpr6xh6LylPcOv4PurWRWu4MQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm3; bh=V1J4f90bwo+EfZC3f/9mH/YsIrZrtwXG618pPmin5v0=; b=bKZZljSA
 wyK+3X6vK8hxv8BTFLMzz/7v37AdbYbNiyFnQeO8x7ljFHA2L0dordzl9DATDJNa
 +zSQ0OXROk2JTHHpR73WIm2aj8g/agv0pKtWOENwr/3fqpyxcwMRZQfMs0y8JBfD
 BpQOd0ODsLhY06n1XVBcJ3Q1/wvuSuuDQRs9QQQLM26ddP1KdJVt3+P8FWC5ghAn
 rjrcJvO67ZgYJLvgR/MGLn7DN5h2vM/8bV/LBpmgGVUhViaZORNnH+6ouAQU//Ob
 HSF/De8MCSn2QnWUSISWKBWlSGwnyqqYdt7eR9QW2fsjYw7euL1W5qrZDDdeMUeq
 l80l3ZCODBSlKw==
X-ME-Sender: <xms:WhplX6WldmXSpIb5drdv1zZMt4nmKAydPtDq2UDmGTKvIudUS7dJsw>
 <xme:WhplX2nhaN5ox82syTEReYLlIwHldnaxLbvDLmRVuRRjZPttdOz7qdZyMQlLm0eGA
 Hnwd57ScxkRTmqtdMA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrtdeigdduhedvucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefmlhgruhhs
 ucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrghtth
 gvrhhnpeeltdetfeegkefguedvtdduffejiedvjeejudejieelveekhfekvdefleeludev
 ffenucffohhmrghinhepvddtudelqddtkedrohhrghenucfkphepkedtrdduieejrdelke
 drudeltdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhm
 pehithhssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:WxplX-anWL9EuNDsD-02A68TRWcqpz2thFbS4yxMxloSnXbMipVgWg>
 <xmx:WxplXxWNg6D2JEqZG8yHG-ODzH_Kjtr0dmA4vUNVEA6_8QAeWhVUGA>
 <xmx:WxplX0m0Ywp1NNtNfAw1C7jSsnTj1wrzS9t_3qUmg9XfTpZ8-S-Iqw>
 <xmx:WxplX-5VudKHcLD8BociKyX1bBlsRP1e7OU3Wnudvpglz57INd8oELo6688>
Received: from apples.local (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id 741A73064610;
 Fri, 18 Sep 2020 16:36:41 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 12/17] hw/block/nvme: add support for scatter gather lists
Date: Fri, 18 Sep 2020 22:36:16 +0200
Message-Id: <20200918203621.602915-13-its@irrelevant.dk>
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
 Klaus Jensen <its@irrelevant.dk>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <klaus.jensen@cnexlabs.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Klaus Jensen <k.jensen@samsung.com>

For now, support the Data Block, Segment and Last Segment descriptor
types.

See NVM Express 1.3d, Section 4.4 ("Scatter Gather List (SGL)").

Signed-off-by: Klaus Jensen <klaus.jensen@cnexlabs.com>
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
Acked-by: Keith Busch <kbusch@kernel.org>
---
 include/block/nvme.h  |   6 +-
 hw/block/nvme.c       | 329 ++++++++++++++++++++++++++++++++++--------
 hw/block/trace-events |   4 +
 3 files changed, 279 insertions(+), 60 deletions(-)

diff --git a/include/block/nvme.h b/include/block/nvme.h
index 65e68a82c897..58647bcdad0b 100644
--- a/include/block/nvme.h
+++ b/include/block/nvme.h
@@ -412,9 +412,9 @@ typedef union NvmeCmdDptr {
 } NvmeCmdDptr;
 
 enum NvmePsdt {
-    PSDT_PRP                 = 0x0,
-    PSDT_SGL_MPTR_CONTIGUOUS = 0x1,
-    PSDT_SGL_MPTR_SGL        = 0x2,
+    NVME_PSDT_PRP                 = 0x0,
+    NVME_PSDT_SGL_MPTR_CONTIGUOUS = 0x1,
+    NVME_PSDT_SGL_MPTR_SGL        = 0x2,
 };
 
 typedef struct QEMU_PACKED NvmeCmd {
diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index a440f6617f70..e01b4b22882e 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -413,13 +413,262 @@ static uint16_t nvme_map_prp(NvmeCtrl *n, uint64_t prp1, uint64_t prp2,
     return NVME_SUCCESS;
 }
 
-static uint16_t nvme_dma_prp(NvmeCtrl *n, uint8_t *ptr, uint32_t len,
-                             uint64_t prp1, uint64_t prp2, DMADirection dir,
+/*
+ * Map 'nsgld' data descriptors from 'segment'. The function will subtract the
+ * number of bytes mapped in len.
+ */
+static uint16_t nvme_map_sgl_data(NvmeCtrl *n, QEMUSGList *qsg,
+                                  QEMUIOVector *iov,
+                                  NvmeSglDescriptor *segment, uint64_t nsgld,
+                                  size_t *len, NvmeRequest *req)
+{
+    dma_addr_t addr, trans_len;
+    uint32_t dlen;
+    uint16_t status;
+
+    for (int i = 0; i < nsgld; i++) {
+        uint8_t type = NVME_SGL_TYPE(segment[i].type);
+
+        switch (type) {
+        case NVME_SGL_DESCR_TYPE_DATA_BLOCK:
+            break;
+        case NVME_SGL_DESCR_TYPE_SEGMENT:
+        case NVME_SGL_DESCR_TYPE_LAST_SEGMENT:
+            return NVME_INVALID_NUM_SGL_DESCRS | NVME_DNR;
+        default:
+            return NVME_SGL_DESCR_TYPE_INVALID | NVME_DNR;
+        }
+
+        dlen = le32_to_cpu(segment[i].len);
+        if (!dlen) {
+            continue;
+        }
+
+        if (*len == 0) {
+            /*
+             * All data has been mapped, but the SGL contains additional
+             * segments and/or descriptors. The controller might accept
+             * ignoring the rest of the SGL.
+             */
+            uint16_t sgls = le16_to_cpu(n->id_ctrl.sgls);
+            if (sgls & NVME_CTRL_SGLS_EXCESS_LENGTH) {
+                break;
+            }
+
+            trace_pci_nvme_err_invalid_sgl_excess_length(nvme_cid(req));
+            return NVME_DATA_SGL_LEN_INVALID | NVME_DNR;
+        }
+
+        trans_len = MIN(*len, dlen);
+        addr = le64_to_cpu(segment[i].addr);
+
+        if (UINT64_MAX - addr < dlen) {
+            return NVME_DATA_SGL_LEN_INVALID | NVME_DNR;
+        }
+
+        status = nvme_map_addr(n, qsg, iov, addr, trans_len);
+        if (status) {
+            return status;
+        }
+
+        *len -= trans_len;
+    }
+
+    return NVME_SUCCESS;
+}
+
+static uint16_t nvme_map_sgl(NvmeCtrl *n, QEMUSGList *qsg, QEMUIOVector *iov,
+                             NvmeSglDescriptor sgl, size_t len,
                              NvmeRequest *req)
+{
+    /*
+     * Read the segment in chunks of 256 descriptors (one 4k page) to avoid
+     * dynamically allocating a potentially huge SGL. The spec allows the SGL
+     * to be larger (as in number of bytes required to describe the SGL
+     * descriptors and segment chain) than the command transfer size, so it is
+     * not bounded by MDTS.
+     */
+    const int SEG_CHUNK_SIZE = 256;
+
+    NvmeSglDescriptor segment[SEG_CHUNK_SIZE], *sgld, *last_sgld;
+    uint64_t nsgld;
+    uint32_t seg_len;
+    uint16_t status;
+    bool sgl_in_cmb = false;
+    hwaddr addr;
+    int ret;
+
+    sgld = &sgl;
+    addr = le64_to_cpu(sgl.addr);
+
+    trace_pci_nvme_map_sgl(nvme_cid(req), NVME_SGL_TYPE(sgl.type), len);
+
+    /*
+     * If the entire transfer can be described with a single data block it can
+     * be mapped directly.
+     */
+    if (NVME_SGL_TYPE(sgl.type) == NVME_SGL_DESCR_TYPE_DATA_BLOCK) {
+        status = nvme_map_sgl_data(n, qsg, iov, sgld, 1, &len, req);
+        if (status) {
+            goto unmap;
+        }
+
+        goto out;
+    }
+
+    /*
+     * If the segment is located in the CMB, the submission queue of the
+     * request must also reside there.
+     */
+    if (nvme_addr_is_cmb(n, addr)) {
+        if (!nvme_addr_is_cmb(n, req->sq->dma_addr)) {
+            return NVME_INVALID_USE_OF_CMB | NVME_DNR;
+        }
+
+        sgl_in_cmb = true;
+    }
+
+    for (;;) {
+        switch (NVME_SGL_TYPE(sgld->type)) {
+        case NVME_SGL_DESCR_TYPE_SEGMENT:
+        case NVME_SGL_DESCR_TYPE_LAST_SEGMENT:
+            break;
+        default:
+            return NVME_INVALID_SGL_SEG_DESCR | NVME_DNR;
+        }
+
+        seg_len = le32_to_cpu(sgld->len);
+
+        /* check the length of the (Last) Segment descriptor */
+        if (!seg_len || seg_len & 0xf) {
+            return NVME_INVALID_SGL_SEG_DESCR | NVME_DNR;
+        }
+
+        if (UINT64_MAX - addr < seg_len) {
+            return NVME_DATA_SGL_LEN_INVALID | NVME_DNR;
+        }
+
+        nsgld = seg_len / sizeof(NvmeSglDescriptor);
+
+        while (nsgld > SEG_CHUNK_SIZE) {
+            if (nvme_addr_read(n, addr, segment, sizeof(segment))) {
+                trace_pci_nvme_err_addr_read(addr);
+                status = NVME_DATA_TRAS_ERROR;
+                goto unmap;
+            }
+
+            status = nvme_map_sgl_data(n, qsg, iov, segment, SEG_CHUNK_SIZE,
+                                       &len, req);
+            if (status) {
+                goto unmap;
+            }
+
+            nsgld -= SEG_CHUNK_SIZE;
+            addr += SEG_CHUNK_SIZE * sizeof(NvmeSglDescriptor);
+        }
+
+        ret = nvme_addr_read(n, addr, segment, nsgld *
+                             sizeof(NvmeSglDescriptor));
+        if (ret) {
+            trace_pci_nvme_err_addr_read(addr);
+            status = NVME_DATA_TRAS_ERROR;
+            goto unmap;
+        }
+
+        last_sgld = &segment[nsgld - 1];
+
+        /* if the segment ends with a Data Block, then we are done */
+        if (NVME_SGL_TYPE(last_sgld->type) == NVME_SGL_DESCR_TYPE_DATA_BLOCK) {
+            status = nvme_map_sgl_data(n, qsg, iov, segment, nsgld, &len, req);
+            if (status) {
+                goto unmap;
+            }
+
+            goto out;
+        }
+
+        /*
+         * If the last descriptor was not a Data Block, then the current
+         * segment must not be a Last Segment.
+         */
+        if (NVME_SGL_TYPE(sgld->type) == NVME_SGL_DESCR_TYPE_LAST_SEGMENT) {
+            status = NVME_INVALID_SGL_SEG_DESCR | NVME_DNR;
+            goto unmap;
+        }
+
+        sgld = last_sgld;
+        addr = le64_to_cpu(sgld->addr);
+
+        /*
+         * Do not map the last descriptor; it will be a Segment or Last Segment
+         * descriptor and is handled by the next iteration.
+         */
+        status = nvme_map_sgl_data(n, qsg, iov, segment, nsgld - 1, &len, req);
+        if (status) {
+            goto unmap;
+        }
+
+        /*
+         * If the next segment is in the CMB, make sure that the sgl was
+         * already located there.
+         */
+        if (sgl_in_cmb != nvme_addr_is_cmb(n, addr)) {
+            status = NVME_INVALID_USE_OF_CMB | NVME_DNR;
+            goto unmap;
+        }
+    }
+
+out:
+    /* if there is any residual left in len, the SGL was too short */
+    if (len) {
+        status = NVME_DATA_SGL_LEN_INVALID | NVME_DNR;
+        goto unmap;
+    }
+
+    return NVME_SUCCESS;
+
+unmap:
+    if (iov->iov) {
+        qemu_iovec_destroy(iov);
+    }
+
+    if (qsg->sg) {
+        qemu_sglist_destroy(qsg);
+    }
+
+    return status;
+}
+
+static uint16_t nvme_map_dptr(NvmeCtrl *n, size_t len, NvmeRequest *req)
+{
+    uint64_t prp1, prp2;
+
+    switch (NVME_CMD_FLAGS_PSDT(req->cmd.flags)) {
+    case NVME_PSDT_PRP:
+        prp1 = le64_to_cpu(req->cmd.dptr.prp1);
+        prp2 = le64_to_cpu(req->cmd.dptr.prp2);
+
+        return nvme_map_prp(n, prp1, prp2, len, req);
+    case NVME_PSDT_SGL_MPTR_CONTIGUOUS:
+    case NVME_PSDT_SGL_MPTR_SGL:
+        /* SGLs shall not be used for Admin commands in NVMe over PCIe */
+        if (!req->sq->sqid) {
+            return NVME_INVALID_FIELD | NVME_DNR;
+        }
+
+        return nvme_map_sgl(n, &req->qsg, &req->iov, req->cmd.dptr.sgl, len,
+                            req);
+    default:
+        return NVME_INVALID_FIELD;
+    }
+}
+
+static uint16_t nvme_dma(NvmeCtrl *n, uint8_t *ptr, uint32_t len,
+                         DMADirection dir, NvmeRequest *req)
 {
     uint16_t status = NVME_SUCCESS;
 
-    status = nvme_map_prp(n, prp1, prp2, len, req);
+    status = nvme_map_dptr(n, len, req);
     if (status) {
         return status;
     }
@@ -458,15 +707,6 @@ static uint16_t nvme_dma_prp(NvmeCtrl *n, uint8_t *ptr, uint32_t len,
     return status;
 }
 
-static uint16_t nvme_map_dptr(NvmeCtrl *n, size_t len, NvmeRequest *req)
-{
-    NvmeCmd *cmd = &req->cmd;
-    uint64_t prp1 = le64_to_cpu(cmd->dptr.prp1);
-    uint64_t prp2 = le64_to_cpu(cmd->dptr.prp2);
-
-    return nvme_map_prp(n, prp1, prp2, len, req);
-}
-
 static void nvme_post_cqes(void *opaque)
 {
     NvmeCQueue *cq = opaque;
@@ -927,10 +1167,7 @@ static uint16_t nvme_create_sq(NvmeCtrl *n, NvmeRequest *req)
 static uint16_t nvme_smart_info(NvmeCtrl *n, uint8_t rae, uint32_t buf_len,
                                 uint64_t off, NvmeRequest *req)
 {
-    NvmeCmd *cmd = &req->cmd;
-    uint64_t prp1 = le64_to_cpu(cmd->dptr.prp1);
-    uint64_t prp2 = le64_to_cpu(cmd->dptr.prp2);
-    uint32_t nsid = le32_to_cpu(cmd->nsid);
+    uint32_t nsid = le32_to_cpu(req->cmd.nsid);
 
     uint32_t trans_len;
     time_t current_ms;
@@ -979,17 +1216,14 @@ static uint16_t nvme_smart_info(NvmeCtrl *n, uint8_t rae, uint32_t buf_len,
         nvme_clear_events(n, NVME_AER_TYPE_SMART);
     }
 
-    return nvme_dma_prp(n, (uint8_t *) &smart + off, trans_len, prp1, prp2,
-                        DMA_DIRECTION_FROM_DEVICE, req);
+    return nvme_dma(n, (uint8_t *) &smart + off, trans_len,
+                    DMA_DIRECTION_FROM_DEVICE, req);
 }
 
 static uint16_t nvme_fw_log_info(NvmeCtrl *n, uint32_t buf_len, uint64_t off,
                                  NvmeRequest *req)
 {
     uint32_t trans_len;
-    NvmeCmd *cmd = &req->cmd;
-    uint64_t prp1 = le64_to_cpu(cmd->dptr.prp1);
-    uint64_t prp2 = le64_to_cpu(cmd->dptr.prp2);
     NvmeFwSlotInfoLog fw_log = {
         .afi = 0x1,
     };
@@ -1002,17 +1236,14 @@ static uint16_t nvme_fw_log_info(NvmeCtrl *n, uint32_t buf_len, uint64_t off,
 
     trans_len = MIN(sizeof(fw_log) - off, buf_len);
 
-    return nvme_dma_prp(n, (uint8_t *) &fw_log + off, trans_len, prp1, prp2,
-                        DMA_DIRECTION_FROM_DEVICE, req);
+    return nvme_dma(n, (uint8_t *) &fw_log + off, trans_len,
+                    DMA_DIRECTION_FROM_DEVICE, req);
 }
 
 static uint16_t nvme_error_info(NvmeCtrl *n, uint8_t rae, uint32_t buf_len,
                                 uint64_t off, NvmeRequest *req)
 {
     uint32_t trans_len;
-    NvmeCmd *cmd = &req->cmd;
-    uint64_t prp1 = le64_to_cpu(cmd->dptr.prp1);
-    uint64_t prp2 = le64_to_cpu(cmd->dptr.prp2);
     NvmeErrorLog errlog;
 
     if (!rae) {
@@ -1027,8 +1258,8 @@ static uint16_t nvme_error_info(NvmeCtrl *n, uint8_t rae, uint32_t buf_len,
 
     trans_len = MIN(sizeof(errlog) - off, buf_len);
 
-    return nvme_dma_prp(n, (uint8_t *)&errlog, trans_len, prp1, prp2,
-                        DMA_DIRECTION_FROM_DEVICE, req);
+    return nvme_dma(n, (uint8_t *)&errlog, trans_len,
+                    DMA_DIRECTION_FROM_DEVICE, req);
 }
 
 static uint16_t nvme_get_log(NvmeCtrl *n, NvmeRequest *req)
@@ -1188,14 +1419,10 @@ static uint16_t nvme_create_cq(NvmeCtrl *n, NvmeRequest *req)
 
 static uint16_t nvme_identify_ctrl(NvmeCtrl *n, NvmeRequest *req)
 {
-    NvmeIdentify *c = (NvmeIdentify *)&req->cmd;
-    uint64_t prp1 = le64_to_cpu(c->prp1);
-    uint64_t prp2 = le64_to_cpu(c->prp2);
-
     trace_pci_nvme_identify_ctrl();
 
-    return nvme_dma_prp(n, (uint8_t *)&n->id_ctrl, sizeof(n->id_ctrl), prp1,
-                        prp2, DMA_DIRECTION_FROM_DEVICE, req);
+    return nvme_dma(n, (uint8_t *)&n->id_ctrl, sizeof(n->id_ctrl),
+                    DMA_DIRECTION_FROM_DEVICE, req);
 }
 
 static uint16_t nvme_identify_ns(NvmeCtrl *n, NvmeRequest *req)
@@ -1203,8 +1430,6 @@ static uint16_t nvme_identify_ns(NvmeCtrl *n, NvmeRequest *req)
     NvmeNamespace *ns;
     NvmeIdentify *c = (NvmeIdentify *)&req->cmd;
     uint32_t nsid = le32_to_cpu(c->nsid);
-    uint64_t prp1 = le64_to_cpu(c->prp1);
-    uint64_t prp2 = le64_to_cpu(c->prp2);
 
     trace_pci_nvme_identify_ns(nsid);
 
@@ -1215,8 +1440,8 @@ static uint16_t nvme_identify_ns(NvmeCtrl *n, NvmeRequest *req)
 
     ns = &n->namespaces[nsid - 1];
 
-    return nvme_dma_prp(n, (uint8_t *)&ns->id_ns, sizeof(ns->id_ns), prp1,
-                        prp2, DMA_DIRECTION_FROM_DEVICE, req);
+    return nvme_dma(n, (uint8_t *)&ns->id_ns, sizeof(ns->id_ns),
+                    DMA_DIRECTION_FROM_DEVICE, req);
 }
 
 static uint16_t nvme_identify_nslist(NvmeCtrl *n, NvmeRequest *req)
@@ -1224,8 +1449,6 @@ static uint16_t nvme_identify_nslist(NvmeCtrl *n, NvmeRequest *req)
     NvmeIdentify *c = (NvmeIdentify *)&req->cmd;
     static const int data_len = NVME_IDENTIFY_DATA_SIZE;
     uint32_t min_nsid = le32_to_cpu(c->nsid);
-    uint64_t prp1 = le64_to_cpu(c->prp1);
-    uint64_t prp2 = le64_to_cpu(c->prp2);
     uint32_t *list;
     uint16_t ret;
     int i, j = 0;
@@ -1252,8 +1475,8 @@ static uint16_t nvme_identify_nslist(NvmeCtrl *n, NvmeRequest *req)
             break;
         }
     }
-    ret = nvme_dma_prp(n, (uint8_t *)list, data_len, prp1, prp2,
-                       DMA_DIRECTION_FROM_DEVICE, req);
+    ret = nvme_dma(n, (uint8_t *)list, data_len, DMA_DIRECTION_FROM_DEVICE,
+                   req);
     g_free(list);
     return ret;
 }
@@ -1262,8 +1485,6 @@ static uint16_t nvme_identify_ns_descr_list(NvmeCtrl *n, NvmeRequest *req)
 {
     NvmeIdentify *c = (NvmeIdentify *)&req->cmd;
     uint32_t nsid = le32_to_cpu(c->nsid);
-    uint64_t prp1 = le64_to_cpu(c->prp1);
-    uint64_t prp2 = le64_to_cpu(c->prp2);
 
     uint8_t list[NVME_IDENTIFY_DATA_SIZE];
 
@@ -1295,8 +1516,8 @@ static uint16_t nvme_identify_ns_descr_list(NvmeCtrl *n, NvmeRequest *req)
     ns_descrs->uuid.hdr.nidl = NVME_NIDT_UUID_LEN;
     stl_be_p(&ns_descrs->uuid.v, nsid);
 
-    return nvme_dma_prp(n, list, NVME_IDENTIFY_DATA_SIZE, prp1, prp2,
-                        DMA_DIRECTION_FROM_DEVICE, req);
+    return nvme_dma(n, list, NVME_IDENTIFY_DATA_SIZE,
+                    DMA_DIRECTION_FROM_DEVICE, req);
 }
 
 static uint16_t nvme_identify(NvmeCtrl *n, NvmeRequest *req)
@@ -1372,14 +1593,10 @@ static inline uint64_t nvme_get_timestamp(const NvmeCtrl *n)
 
 static uint16_t nvme_get_feature_timestamp(NvmeCtrl *n, NvmeRequest *req)
 {
-    NvmeCmd *cmd = &req->cmd;
-    uint64_t prp1 = le64_to_cpu(cmd->dptr.prp1);
-    uint64_t prp2 = le64_to_cpu(cmd->dptr.prp2);
-
     uint64_t timestamp = nvme_get_timestamp(n);
 
-    return nvme_dma_prp(n, (uint8_t *)&timestamp, sizeof(timestamp), prp1,
-                        prp2, DMA_DIRECTION_FROM_DEVICE, req);
+    return nvme_dma(n, (uint8_t *)&timestamp, sizeof(timestamp),
+                    DMA_DIRECTION_FROM_DEVICE, req);
 }
 
 static uint16_t nvme_get_feature(NvmeCtrl *n, NvmeRequest *req)
@@ -1508,12 +1725,9 @@ static uint16_t nvme_set_feature_timestamp(NvmeCtrl *n, NvmeRequest *req)
 {
     uint16_t ret;
     uint64_t timestamp;
-    NvmeCmd *cmd = &req->cmd;
-    uint64_t prp1 = le64_to_cpu(cmd->dptr.prp1);
-    uint64_t prp2 = le64_to_cpu(cmd->dptr.prp2);
 
-    ret = nvme_dma_prp(n, (uint8_t *)&timestamp, sizeof(timestamp), prp1,
-                       prp2, DMA_DIRECTION_TO_DEVICE, req);
+    ret = nvme_dma(n, (uint8_t *)&timestamp, sizeof(timestamp),
+                   DMA_DIRECTION_TO_DEVICE, req);
     if (ret != NVME_SUCCESS) {
         return ret;
     }
@@ -2440,6 +2654,7 @@ static void nvme_init_ctrl(NvmeCtrl *n, PCIDevice *pci_dev)
     id->nn = cpu_to_le32(n->num_namespaces);
     id->oncs = cpu_to_le16(NVME_ONCS_WRITE_ZEROES | NVME_ONCS_TIMESTAMP |
                            NVME_ONCS_FEATURES);
+    id->sgls = cpu_to_le32(NVME_CTRL_SGLS_SUPPORT_NO_ALIGN);
 
     subnqn = g_strdup_printf("nqn.2019-08.org.qemu:%s", n->params.serial);
     strpadcpy((char *)id->subnqn, sizeof(id->subnqn), subnqn, '\0');
diff --git a/hw/block/trace-events b/hw/block/trace-events
index 04a700c73f7d..b780993c3da5 100644
--- a/hw/block/trace-events
+++ b/hw/block/trace-events
@@ -36,6 +36,7 @@ pci_nvme_dma_read(uint64_t prp1, uint64_t prp2) "DMA read, prp1=0x%"PRIx64" prp2
 pci_nvme_map_addr(uint64_t addr, uint64_t len) "addr 0x%"PRIx64" len %"PRIu64""
 pci_nvme_map_addr_cmb(uint64_t addr, uint64_t len) "addr 0x%"PRIx64" len %"PRIu64""
 pci_nvme_map_prp(uint64_t trans_len, uint32_t len, uint64_t prp1, uint64_t prp2, int num_prps) "trans_len %"PRIu64" len %"PRIu32" prp1 0x%"PRIx64" prp2 0x%"PRIx64" num_prps %d"
+pci_nvme_map_sgl(uint16_t cid, uint8_t typ, uint64_t len) "cid %"PRIu16" type 0x%"PRIx8" len %"PRIu64""
 pci_nvme_io_cmd(uint16_t cid, uint32_t nsid, uint16_t sqid, uint8_t opcode, const char *opname) "cid %"PRIu16" nsid %"PRIu32" sqid %"PRIu16" opc 0x%"PRIx8" opname '%s'"
 pci_nvme_admin_cmd(uint16_t cid, uint16_t sqid, uint8_t opcode, const char *opname) "cid %"PRIu16" sqid %"PRIu16" opc 0x%"PRIx8" opname '%s'"
 pci_nvme_rw(uint16_t cid, const char *verb, uint32_t nlb, uint64_t count, uint64_t lba) "cid %"PRIu16" '%s' nlb %"PRIu32" count %"PRIu64" lba 0x%"PRIx64""
@@ -90,6 +91,9 @@ pci_nvme_err_mdts(uint16_t cid, size_t len) "cid %"PRIu16" len %zu"
 pci_nvme_err_addr_read(uint64_t addr) "addr 0x%"PRIx64""
 pci_nvme_err_addr_write(uint64_t addr) "addr 0x%"PRIx64""
 pci_nvme_err_aio(uint16_t cid, const char *errname, uint16_t status) "cid %"PRIu16" err '%s' status 0x%"PRIx16""
+pci_nvme_err_invalid_sgld(uint16_t cid, uint8_t typ) "cid %"PRIu16" type 0x%"PRIx8""
+pci_nvme_err_invalid_num_sgld(uint16_t cid, uint8_t typ) "cid %"PRIu16" type 0x%"PRIx8""
+pci_nvme_err_invalid_sgl_excess_length(uint16_t cid) "cid %"PRIu16""
 pci_nvme_err_invalid_dma(void) "PRP/SGL is too small for transfer size"
 pci_nvme_err_invalid_prplist_ent(uint64_t prplist) "PRP list entry is null or not page aligned: 0x%"PRIx64""
 pci_nvme_err_invalid_prp2_align(uint64_t prp2) "PRP2 is not page aligned: 0x%"PRIx64""
-- 
2.28.0


