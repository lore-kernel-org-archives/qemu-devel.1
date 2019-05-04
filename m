Return-Path: <SRS0=Uyhh=TE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 353ECC43219
	for <qemu-devel@archiver.kernel.org>; Sat,  4 May 2019 13:47:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E386020651
	for <qemu-devel@archiver.kernel.org>; Sat,  4 May 2019 13:47:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G6Oss63n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E386020651
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:56959 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMv0h-00033k-7j
	for qemu-devel@archiver.kernel.org; Sat, 04 May 2019 09:47:27 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44007)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1hMuyy-000226-M3
	for qemu-devel@nongnu.org; Sat, 04 May 2019 09:45:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1hMuyx-0002M7-2f
	for qemu-devel@nongnu.org; Sat, 04 May 2019 09:45:40 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:35887)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
	id 1hMuyw-0002Lk-QF
	for qemu-devel@nongnu.org; Sat, 04 May 2019 09:45:39 -0400
Received: by mail-wr1-x441.google.com with SMTP id o4so11331130wra.3
	for <qemu-devel@nongnu.org>; Sat, 04 May 2019 06:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=/QV3bKWmdEB50/rH15uuq3cqW0QRXb1M7/j8cW2cPSY=;
	b=G6Oss63nBX+LYBKv3FPrWJt6wEduifcSZ4eMFELCnY8lqGt/+/YPn1dalm9HhZRXyV
	Rq19N30kF3YzchXId/43q1EFCfcM+UCj19FqVBI4DZRplMVsSXh97nb7IL6woJ8ZD4Bt
	SdpWKpNJtZ2iOSj5hxH2kdJWO/qvmCUyphajf45ngpBvOoBjOWI7lGDG4W+w7A8B/q65
	q0OojlZoktBhePcuRM2tgZlxe8gC4ry6uEeqfwBfi4Tbr62//NcE9jU/VDXn1bnJSyeJ
	uq+6FgwXnokgZUqIeuAvFrSG/WBfEJ6rNV9yb8Ca79KLK00iDU0tKIrUXT41GnnxPGp1
	vxWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=/QV3bKWmdEB50/rH15uuq3cqW0QRXb1M7/j8cW2cPSY=;
	b=D2UBaYiGW0SHv0gwVq1v7EQ+T/5vXhep4v9BNWtJDbtc83ZFvd+/TUE04NQZIZxGgG
	Sk4bHzSpWLc/o/UjW13ZQx8lYuwrsUdMqmxPbp+4wKEaAuWgEa02vKp+2ikr/qqdngoT
	hZFre4OuQeyTLVIobNVtmDnap0mMHCB7liFIC1gnEh1p5VC+7roU7HBeeMUkkEIlXGEY
	BDZwYxmtG/YaMmxIdS6H3G2RgOd889mGUhB7WKqMhPmZEgafB+JDeJn2xb59LvXviAGp
	6N8hC3+LxZX7ahPmDOmcvrK93V2kab+r1Ws/ls9U/blS6IOE2m3ApkI8q8Bh2hITWO1d
	7VgQ==
X-Gm-Message-State: APjAAAUYbpV0bRv1+Q0FU2PmWDNEXpryv97h559d00sQ0NNT64JKIMnE
	2N0ddwWtpphl7ARsoP2okXsN/jT4
X-Google-Smtp-Source: APXvYqzOiA1xzgfpOuAR6MM5/N3rDlNcz5EC7drdPZa6rtgID9p7XSCfZQjRPnbxYy6yk4rqfNJDSw==
X-Received: by 2002:a05:6000:ca:: with SMTP id
	q10mr3550948wrx.148.1556977537461; 
	Sat, 04 May 2019 06:45:37 -0700 (PDT)
Received: from localhost.localdomain ([37.142.144.27])
	by smtp.gmail.com with ESMTPSA id t1sm5095610wro.34.2019.05.04.06.45.35
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Sat, 04 May 2019 06:45:36 -0700 (PDT)
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Date: Sat,  4 May 2019 16:45:28 +0300
Message-Id: <20190504134529.4755-4-marcel.apfelbaum@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190504134529.4755-1-marcel.apfelbaum@gmail.com>
References: <20190504134529.4755-1-marcel.apfelbaum@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: [Qemu-devel] [PATCH PULL 3/4] hw/rdma: Modify create/destroy QP to
 support SRQ
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: kamalheib1@gmail.com, yuval.shaia@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190504134528.wRO6_5TcKxG9gg1YSDkAO5wC9jr_PvYkVWU2hHAC1fU@z>

From: Kamal Heib <kamalheib1@gmail.com>

Modify create/destroy QP to support shared receive queue and rearrange
the destroy_qp() code to avoid touching the QP after calling
rdma_rm_dealloc_qp().

Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
Message-Id: <20190403113343.26384-4-kamalheib1@gmail.com>
Reviewed-by: Yuval Shaia <yuval.shaia@oracle.com>
Signed-off-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
---
 hw/rdma/rdma_backend.c   |  9 ++++--
 hw/rdma/rdma_backend.h   |  6 ++--
 hw/rdma/rdma_rm.c        | 22 +++++++++++++--
 hw/rdma/rdma_rm.h        |  3 +-
 hw/rdma/rdma_rm_defs.h   |  1 +
 hw/rdma/vmw/pvrdma_cmd.c | 59 ++++++++++++++++++++++++----------------
 6 files changed, 67 insertions(+), 33 deletions(-)

diff --git a/hw/rdma/rdma_backend.c b/hw/rdma/rdma_backend.c
index 04dfd63a57..cf34874e9d 100644
--- a/hw/rdma/rdma_backend.c
+++ b/hw/rdma/rdma_backend.c
@@ -794,9 +794,9 @@ void rdma_backend_destroy_cq(RdmaBackendCQ *cq)
 
 int rdma_backend_create_qp(RdmaBackendQP *qp, uint8_t qp_type,
                            RdmaBackendPD *pd, RdmaBackendCQ *scq,
-                           RdmaBackendCQ *rcq, uint32_t max_send_wr,
-                           uint32_t max_recv_wr, uint32_t max_send_sge,
-                           uint32_t max_recv_sge)
+                           RdmaBackendCQ *rcq, RdmaBackendSRQ *srq,
+                           uint32_t max_send_wr, uint32_t max_recv_wr,
+                           uint32_t max_send_sge, uint32_t max_recv_sge)
 {
     struct ibv_qp_init_attr attr = {};
 
@@ -824,6 +824,9 @@ int rdma_backend_create_qp(RdmaBackendQP *qp, uint8_t qp_type,
     attr.cap.max_recv_wr = max_recv_wr;
     attr.cap.max_send_sge = max_send_sge;
     attr.cap.max_recv_sge = max_recv_sge;
+    if (srq) {
+        attr.srq = srq->ibsrq;
+    }
 
     qp->ibqp = ibv_create_qp(pd->ibpd, &attr);
     if (!qp->ibqp) {
diff --git a/hw/rdma/rdma_backend.h b/hw/rdma/rdma_backend.h
index cad7956d98..7c1a19a2b5 100644
--- a/hw/rdma/rdma_backend.h
+++ b/hw/rdma/rdma_backend.h
@@ -89,9 +89,9 @@ void rdma_backend_poll_cq(RdmaDeviceResources *rdma_dev_res, RdmaBackendCQ *cq);
 
 int rdma_backend_create_qp(RdmaBackendQP *qp, uint8_t qp_type,
                            RdmaBackendPD *pd, RdmaBackendCQ *scq,
-                           RdmaBackendCQ *rcq, uint32_t max_send_wr,
-                           uint32_t max_recv_wr, uint32_t max_send_sge,
-                           uint32_t max_recv_sge);
+                           RdmaBackendCQ *rcq, RdmaBackendSRQ *srq,
+                           uint32_t max_send_wr, uint32_t max_recv_wr,
+                           uint32_t max_send_sge, uint32_t max_recv_sge);
 int rdma_backend_qp_state_init(RdmaBackendDev *backend_dev, RdmaBackendQP *qp,
                                uint8_t qp_type, uint32_t qkey);
 int rdma_backend_qp_state_rtr(RdmaBackendDev *backend_dev, RdmaBackendQP *qp,
diff --git a/hw/rdma/rdma_rm.c b/hw/rdma/rdma_rm.c
index c4fb140dcd..1927f85472 100644
--- a/hw/rdma/rdma_rm.c
+++ b/hw/rdma/rdma_rm.c
@@ -386,12 +386,14 @@ int rdma_rm_alloc_qp(RdmaDeviceResources *dev_res, uint32_t pd_handle,
                      uint8_t qp_type, uint32_t max_send_wr,
                      uint32_t max_send_sge, uint32_t send_cq_handle,
                      uint32_t max_recv_wr, uint32_t max_recv_sge,
-                     uint32_t recv_cq_handle, void *opaque, uint32_t *qpn)
+                     uint32_t recv_cq_handle, void *opaque, uint32_t *qpn,
+                     uint8_t is_srq, uint32_t srq_handle)
 {
     int rc;
     RdmaRmQP *qp;
     RdmaRmCQ *scq, *rcq;
     RdmaRmPD *pd;
+    RdmaRmSRQ *srq = NULL;
     uint32_t rm_qpn;
 
     pd = rdma_rm_get_pd(dev_res, pd_handle);
@@ -408,6 +410,16 @@ int rdma_rm_alloc_qp(RdmaDeviceResources *dev_res, uint32_t pd_handle,
         return -EINVAL;
     }
 
+    if (is_srq) {
+        srq = rdma_rm_get_srq(dev_res, srq_handle);
+        if (!srq) {
+            rdma_error_report("Invalid srqn %d", srq_handle);
+            return -EINVAL;
+        }
+
+        srq->recv_cq_handle = recv_cq_handle;
+    }
+
     if (qp_type == IBV_QPT_GSI) {
         scq->notify = CNT_SET;
         rcq->notify = CNT_SET;
@@ -424,10 +436,14 @@ int rdma_rm_alloc_qp(RdmaDeviceResources *dev_res, uint32_t pd_handle,
     qp->send_cq_handle = send_cq_handle;
     qp->recv_cq_handle = recv_cq_handle;
     qp->opaque = opaque;
+    qp->is_srq = is_srq;
 
     rc = rdma_backend_create_qp(&qp->backend_qp, qp_type, &pd->backend_pd,
-                                &scq->backend_cq, &rcq->backend_cq, max_send_wr,
-                                max_recv_wr, max_send_sge, max_recv_sge);
+                                &scq->backend_cq, &rcq->backend_cq,
+                                is_srq ? &srq->backend_srq : NULL,
+                                max_send_wr, max_recv_wr, max_send_sge,
+                                max_recv_sge);
+
     if (rc) {
         rc = -EIO;
         goto out_dealloc_qp;
diff --git a/hw/rdma/rdma_rm.h b/hw/rdma/rdma_rm.h
index e88ab95e26..e8639909cd 100644
--- a/hw/rdma/rdma_rm.h
+++ b/hw/rdma/rdma_rm.h
@@ -53,7 +53,8 @@ int rdma_rm_alloc_qp(RdmaDeviceResources *dev_res, uint32_t pd_handle,
                      uint8_t qp_type, uint32_t max_send_wr,
                      uint32_t max_send_sge, uint32_t send_cq_handle,
                      uint32_t max_recv_wr, uint32_t max_recv_sge,
-                     uint32_t recv_cq_handle, void *opaque, uint32_t *qpn);
+                     uint32_t recv_cq_handle, void *opaque, uint32_t *qpn,
+                     uint8_t is_srq, uint32_t srq_handle);
 RdmaRmQP *rdma_rm_get_qp(RdmaDeviceResources *dev_res, uint32_t qpn);
 int rdma_rm_modify_qp(RdmaDeviceResources *dev_res, RdmaBackendDev *backend_dev,
                       uint32_t qp_handle, uint32_t attr_mask, uint8_t sgid_idx,
diff --git a/hw/rdma/rdma_rm_defs.h b/hw/rdma/rdma_rm_defs.h
index 7bdd9f291f..534f2f74d3 100644
--- a/hw/rdma/rdma_rm_defs.h
+++ b/hw/rdma/rdma_rm_defs.h
@@ -88,6 +88,7 @@ typedef struct RdmaRmQP {
     uint32_t send_cq_handle;
     uint32_t recv_cq_handle;
     enum ibv_qp_state qp_state;
+    uint8_t is_srq;
 } RdmaRmQP;
 
 typedef struct RdmaRmSRQ {
diff --git a/hw/rdma/vmw/pvrdma_cmd.c b/hw/rdma/vmw/pvrdma_cmd.c
index 4afcd2037d..b931bb6dc9 100644
--- a/hw/rdma/vmw/pvrdma_cmd.c
+++ b/hw/rdma/vmw/pvrdma_cmd.c
@@ -357,7 +357,7 @@ static int destroy_cq(PVRDMADev *dev, union pvrdma_cmd_req *req,
 static int create_qp_rings(PCIDevice *pci_dev, uint64_t pdir_dma,
                            PvrdmaRing **rings, uint32_t scqe, uint32_t smax_sge,
                            uint32_t spages, uint32_t rcqe, uint32_t rmax_sge,
-                           uint32_t rpages)
+                           uint32_t rpages, uint8_t is_srq)
 {
     uint64_t *dir = NULL, *tbl = NULL;
     PvrdmaRing *sr, *rr;
@@ -365,9 +365,14 @@ static int create_qp_rings(PCIDevice *pci_dev, uint64_t pdir_dma,
     char ring_name[MAX_RING_NAME_SZ];
     uint32_t wqe_sz;
 
-    if (!spages || spages > PVRDMA_MAX_FAST_REG_PAGES
-        || !rpages || rpages > PVRDMA_MAX_FAST_REG_PAGES) {
-        rdma_error_report("Got invalid page count for QP ring: %d, %d", spages,
+    if (!spages || spages > PVRDMA_MAX_FAST_REG_PAGES) {
+        rdma_error_report("Got invalid send page count for QP ring: %d",
+                          spages);
+        return rc;
+    }
+
+    if (!is_srq && (!rpages || rpages > PVRDMA_MAX_FAST_REG_PAGES)) {
+        rdma_error_report("Got invalid recv page count for QP ring: %d",
                           rpages);
         return rc;
     }
@@ -384,8 +389,12 @@ static int create_qp_rings(PCIDevice *pci_dev, uint64_t pdir_dma,
         goto out;
     }
 
-    sr = g_malloc(2 * sizeof(*rr));
-    rr = &sr[1];
+    if (!is_srq) {
+        sr = g_malloc(2 * sizeof(*rr));
+        rr = &sr[1];
+    } else {
+        sr = g_malloc(sizeof(*sr));
+    }
 
     *rings = sr;
 
@@ -407,15 +416,18 @@ static int create_qp_rings(PCIDevice *pci_dev, uint64_t pdir_dma,
         goto out_unmap_ring_state;
     }
 
-    /* Create recv ring */
-    rr->ring_state = &sr->ring_state[1];
-    wqe_sz = pow2ceil(sizeof(struct pvrdma_rq_wqe_hdr) +
-                      sizeof(struct pvrdma_sge) * rmax_sge - 1);
-    sprintf(ring_name, "qp_rring_%" PRIx64, pdir_dma);
-    rc = pvrdma_ring_init(rr, ring_name, pci_dev, rr->ring_state,
-                          rcqe, wqe_sz, (dma_addr_t *)&tbl[1 + spages], rpages);
-    if (rc) {
-        goto out_free_sr;
+    if (!is_srq) {
+        /* Create recv ring */
+        rr->ring_state = &sr->ring_state[1];
+        wqe_sz = pow2ceil(sizeof(struct pvrdma_rq_wqe_hdr) +
+                          sizeof(struct pvrdma_sge) * rmax_sge - 1);
+        sprintf(ring_name, "qp_rring_%" PRIx64, pdir_dma);
+        rc = pvrdma_ring_init(rr, ring_name, pci_dev, rr->ring_state,
+                              rcqe, wqe_sz, (dma_addr_t *)&tbl[1 + spages],
+                              rpages);
+        if (rc) {
+            goto out_free_sr;
+        }
     }
 
     goto out;
@@ -436,10 +448,12 @@ out:
     return rc;
 }
 
-static void destroy_qp_rings(PvrdmaRing *ring)
+static void destroy_qp_rings(PvrdmaRing *ring, uint8_t is_srq)
 {
     pvrdma_ring_free(&ring[0]);
-    pvrdma_ring_free(&ring[1]);
+    if (!is_srq) {
+        pvrdma_ring_free(&ring[1]);
+    }
 
     rdma_pci_dma_unmap(ring->dev, ring->ring_state, TARGET_PAGE_SIZE);
     g_free(ring);
@@ -458,7 +472,7 @@ static int create_qp(PVRDMADev *dev, union pvrdma_cmd_req *req,
     rc = create_qp_rings(PCI_DEVICE(dev), cmd->pdir_dma, &rings,
                          cmd->max_send_wr, cmd->max_send_sge, cmd->send_chunks,
                          cmd->max_recv_wr, cmd->max_recv_sge,
-                         cmd->total_chunks - cmd->send_chunks - 1);
+                         cmd->total_chunks - cmd->send_chunks - 1, cmd->is_srq);
     if (rc) {
         return rc;
     }
@@ -467,9 +481,9 @@ static int create_qp(PVRDMADev *dev, union pvrdma_cmd_req *req,
                           cmd->max_send_wr, cmd->max_send_sge,
                           cmd->send_cq_handle, cmd->max_recv_wr,
                           cmd->max_recv_sge, cmd->recv_cq_handle, rings,
-                          &resp->qpn);
+                          &resp->qpn, cmd->is_srq, cmd->srq_handle);
     if (rc) {
-        destroy_qp_rings(rings);
+        destroy_qp_rings(rings, cmd->is_srq);
         return rc;
     }
 
@@ -531,10 +545,9 @@ static int destroy_qp(PVRDMADev *dev, union pvrdma_cmd_req *req,
         return -EINVAL;
     }
 
-    rdma_rm_dealloc_qp(&dev->rdma_dev_res, cmd->qp_handle);
-
     ring = (PvrdmaRing *)qp->opaque;
-    destroy_qp_rings(ring);
+    destroy_qp_rings(ring, qp->is_srq);
+    rdma_rm_dealloc_qp(&dev->rdma_dev_res, cmd->qp_handle);
 
     return 0;
 }
-- 
2.17.1


