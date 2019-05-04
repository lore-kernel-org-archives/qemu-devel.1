Return-Path: <SRS0=Uyhh=TE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BEADC43219
	for <qemu-devel@archiver.kernel.org>; Sat,  4 May 2019 13:47:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0632E20651
	for <qemu-devel@archiver.kernel.org>; Sat,  4 May 2019 13:47:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CLg0hyef"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0632E20651
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:56957 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMv0e-00031n-4O
	for qemu-devel@archiver.kernel.org; Sat, 04 May 2019 09:47:24 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43984)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1hMuyw-00021H-01
	for qemu-devel@nongnu.org; Sat, 04 May 2019 09:45:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1hMuyu-0002Ju-8w
	for qemu-devel@nongnu.org; Sat, 04 May 2019 09:45:37 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:35323)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
	id 1hMuyu-0002J1-08
	for qemu-devel@nongnu.org; Sat, 04 May 2019 09:45:36 -0400
Received: by mail-wr1-x442.google.com with SMTP id h15so5611098wrb.2
	for <qemu-devel@nongnu.org>; Sat, 04 May 2019 06:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=2693G5zlF0KPjpGu8OLoWU8DoCSHGNg7d6xJXxwQddg=;
	b=CLg0hyefSf5BibpnWaV2iEZyDZ3xy+QTcLkrad2YF5Jc+U4lQldIPGqGBW8SyWGtbq
	WZe2qFmFPaYJpCDkgvwBe7MmhdrKpSmEO5Va/bCgSdJXVTETLlOZqoe/xM7Oh3eqKAnZ
	CLi68PJVI7ySJs+Y0UCAvyMII5FCqyoBGo9sclGeUWErdq6gjFOF5kQqF6ztVgVUqH6F
	V1kviBOPj4V1KDOeK8BVzQaip6QTchN8YojBOHM8QPwFEBhss2aciI6VkNBL7LgXn3o2
	jzrKQsOlYcQNZ0gstFxs11z1mRvVHxnwC0LtGq/Q2N1eUtSVfwHaIQAJGTr1Q1n/xLER
	QDFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=2693G5zlF0KPjpGu8OLoWU8DoCSHGNg7d6xJXxwQddg=;
	b=hjR57KjKJk+GB8m+ooJdr0AGxgiHl8NJBi3fV8ugqBZbr7ZrJf/Tj5/C+LhBxoBxzk
	1bEcvX+lbUCYv5r3t52Qu2pquhlQXWv8CBJAB1GUQwW+pnoJ5Y6vrOYmnMjDNhu78tkt
	3FFAeAeQk1OBIEPMgB8BijIy8gczihBKK/qKceCwqpCLKVUIqcQiGWKl3r+BrjafHfDQ
	5rDLj5+lD/9+9euRpMhQ0SvfL7dPFKL7if7AO5o/kthBV/W70iMn3+DgPJ9sxzYltBBA
	3S25gHkGnpOJ4PbGPLrmImC4Klde+yb1cqcv4wJoZtIU5NgDq4B4Xq1smN6Cp0gZ2mWC
	TiRA==
X-Gm-Message-State: APjAAAXAZW5OhzaVAe4lPXdJxGyZVqGrHs1qC3U83hup9PmY3y/AMCv8
	umlx5dsfvPskgdKZ0OAE2fJfo5ve
X-Google-Smtp-Source: APXvYqzfkAuH0Rrz3oXOALc7e/ojtGsdLGh33U5Snu+7uDmm4p/pjPRUEVvpGbqbDx2/vmJZi1OHLw==
X-Received: by 2002:adf:9cc7:: with SMTP id h7mr10556055wre.259.1556977534537; 
	Sat, 04 May 2019 06:45:34 -0700 (PDT)
Received: from localhost.localdomain ([37.142.144.27])
	by smtp.gmail.com with ESMTPSA id t1sm5095610wro.34.2019.05.04.06.45.33
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Sat, 04 May 2019 06:45:33 -0700 (PDT)
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Date: Sat,  4 May 2019 16:45:26 +0300
Message-Id: <20190504134529.4755-2-marcel.apfelbaum@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190504134529.4755-1-marcel.apfelbaum@gmail.com>
References: <20190504134529.4755-1-marcel.apfelbaum@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: [Qemu-devel] [PATCH PULL 1/4] hw/rdma: Add SRQ support to backend
 layer
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
Message-ID: <20190504134526.MOtmmi5JuqsOHseTrso_1KIDBbeWv4fis9YEOeBom4A@z>

From: Kamal Heib <kamalheib1@gmail.com>

Add the required functions and definitions to support shared receive
queues (SRQs) in the backend layer.

Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
Message-Id: <20190403113343.26384-2-kamalheib1@gmail.com>
Reviewed-by: Yuval Shaia <yuval.shaia@oracle.com>
Signed-off-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
---
 hw/rdma/rdma_backend.c      | 116 +++++++++++++++++++++++++++++++++++-
 hw/rdma/rdma_backend.h      |  12 ++++
 hw/rdma/rdma_backend_defs.h |   5 ++
 hw/rdma/rdma_rm.c           |   2 +
 hw/rdma/rdma_rm_defs.h      |   1 +
 5 files changed, 134 insertions(+), 2 deletions(-)

diff --git a/hw/rdma/rdma_backend.c b/hw/rdma/rdma_backend.c
index d1660b6474..04dfd63a57 100644
--- a/hw/rdma/rdma_backend.c
+++ b/hw/rdma/rdma_backend.c
@@ -40,6 +40,7 @@ typedef struct BackendCtx {
     void *up_ctx;
     struct ibv_sge sge; /* Used to save MAD recv buffer */
     RdmaBackendQP *backend_qp; /* To maintain recv buffers */
+    RdmaBackendSRQ *backend_srq;
 } BackendCtx;
 
 struct backend_umad {
@@ -99,6 +100,7 @@ static int rdma_poll_cq(RdmaDeviceResources *rdma_dev_res, struct ibv_cq *ibcq)
     int i, ne, total_ne = 0;
     BackendCtx *bctx;
     struct ibv_wc wc[2];
+    RdmaProtectedGSList *cqe_ctx_list;
 
     qemu_mutex_lock(&rdma_dev_res->lock);
     do {
@@ -116,8 +118,13 @@ static int rdma_poll_cq(RdmaDeviceResources *rdma_dev_res, struct ibv_cq *ibcq)
 
             comp_handler(bctx->up_ctx, &wc[i]);
 
-            rdma_protected_gslist_remove_int32(&bctx->backend_qp->cqe_ctx_list,
-                                               wc[i].wr_id);
+            if (bctx->backend_qp) {
+                cqe_ctx_list = &bctx->backend_qp->cqe_ctx_list;
+            } else {
+                cqe_ctx_list = &bctx->backend_srq->cqe_ctx_list;
+            }
+
+            rdma_protected_gslist_remove_int32(cqe_ctx_list, wc[i].wr_id);
             rdma_rm_dealloc_cqe_ctx(rdma_dev_res, wc[i].wr_id);
             g_free(bctx);
         }
@@ -662,6 +669,60 @@ err_free_bctx:
     g_free(bctx);
 }
 
+void rdma_backend_post_srq_recv(RdmaBackendDev *backend_dev,
+                                RdmaBackendSRQ *srq, struct ibv_sge *sge,
+                                uint32_t num_sge, void *ctx)
+{
+    BackendCtx *bctx;
+    struct ibv_sge new_sge[MAX_SGE];
+    uint32_t bctx_id;
+    int rc;
+    struct ibv_recv_wr wr = {}, *bad_wr;
+
+    bctx = g_malloc0(sizeof(*bctx));
+    bctx->up_ctx = ctx;
+    bctx->backend_srq = srq;
+
+    rc = rdma_rm_alloc_cqe_ctx(backend_dev->rdma_dev_res, &bctx_id, bctx);
+    if (unlikely(rc)) {
+        complete_work(IBV_WC_GENERAL_ERR, VENDOR_ERR_NOMEM, ctx);
+        goto err_free_bctx;
+    }
+
+    rdma_protected_gslist_append_int32(&srq->cqe_ctx_list, bctx_id);
+
+    rc = build_host_sge_array(backend_dev->rdma_dev_res, new_sge, sge, num_sge,
+                              &backend_dev->rdma_dev_res->stats.rx_bufs_len);
+    if (rc) {
+        complete_work(IBV_WC_GENERAL_ERR, rc, ctx);
+        goto err_dealloc_cqe_ctx;
+    }
+
+    wr.num_sge = num_sge;
+    wr.sg_list = new_sge;
+    wr.wr_id = bctx_id;
+    rc = ibv_post_srq_recv(srq->ibsrq, &wr, &bad_wr);
+    if (rc) {
+        rdma_error_report("ibv_post_srq_recv fail, srqn=0x%x, rc=%d, errno=%d",
+                          srq->ibsrq->handle, rc, errno);
+        complete_work(IBV_WC_GENERAL_ERR, VENDOR_ERR_FAIL_BACKEND, ctx);
+        goto err_dealloc_cqe_ctx;
+    }
+
+    atomic_inc(&backend_dev->rdma_dev_res->stats.missing_cqe);
+    backend_dev->rdma_dev_res->stats.rx_bufs++;
+    backend_dev->rdma_dev_res->stats.rx_srq++;
+
+    return;
+
+err_dealloc_cqe_ctx:
+    backend_dev->rdma_dev_res->stats.rx_bufs_err++;
+    rdma_rm_dealloc_cqe_ctx(backend_dev->rdma_dev_res, bctx_id);
+
+err_free_bctx:
+    g_free(bctx);
+}
+
 int rdma_backend_create_pd(RdmaBackendDev *backend_dev, RdmaBackendPD *pd)
 {
     pd->ibpd = ibv_alloc_pd(backend_dev->context);
@@ -938,6 +999,55 @@ void rdma_backend_destroy_qp(RdmaBackendQP *qp, RdmaDeviceResources *dev_res)
     rdma_protected_gslist_destroy(&qp->cqe_ctx_list);
 }
 
+int rdma_backend_create_srq(RdmaBackendSRQ *srq, RdmaBackendPD *pd,
+                            uint32_t max_wr, uint32_t max_sge,
+                            uint32_t srq_limit)
+{
+    struct ibv_srq_init_attr srq_init_attr = {};
+
+    srq_init_attr.attr.max_wr = max_wr;
+    srq_init_attr.attr.max_sge = max_sge;
+    srq_init_attr.attr.srq_limit = srq_limit;
+
+    srq->ibsrq = ibv_create_srq(pd->ibpd, &srq_init_attr);
+    if (!srq->ibsrq) {
+        rdma_error_report("ibv_create_srq failed, errno=%d", errno);
+        return -EIO;
+    }
+
+    rdma_protected_gslist_init(&srq->cqe_ctx_list);
+
+    return 0;
+}
+
+int rdma_backend_query_srq(RdmaBackendSRQ *srq, struct ibv_srq_attr *srq_attr)
+{
+    if (!srq->ibsrq) {
+        return -EINVAL;
+    }
+
+    return ibv_query_srq(srq->ibsrq, srq_attr);
+}
+
+int rdma_backend_modify_srq(RdmaBackendSRQ *srq, struct ibv_srq_attr *srq_attr,
+                int srq_attr_mask)
+{
+    if (!srq->ibsrq) {
+        return -EINVAL;
+    }
+
+    return ibv_modify_srq(srq->ibsrq, srq_attr, srq_attr_mask);
+}
+
+void rdma_backend_destroy_srq(RdmaBackendSRQ *srq, RdmaDeviceResources *dev_res)
+{
+    if (srq->ibsrq) {
+        ibv_destroy_srq(srq->ibsrq);
+    }
+    g_slist_foreach(srq->cqe_ctx_list.list, free_cqe_ctx, dev_res);
+    rdma_protected_gslist_destroy(&srq->cqe_ctx_list);
+}
+
 #define CHK_ATTR(req, dev, member, fmt) ({ \
     trace_rdma_check_dev_attr(#member, dev.member, req->member); \
     if (req->member > dev.member) { \
@@ -960,6 +1070,7 @@ static int init_device_caps(RdmaBackendDev *backend_dev,
     }
 
     dev_attr->max_sge = MAX_SGE;
+    dev_attr->max_srq_sge = MAX_SGE;
 
     CHK_ATTR(dev_attr, bk_dev_attr, max_mr_size, "%" PRId64);
     CHK_ATTR(dev_attr, bk_dev_attr, max_qp, "%d");
@@ -970,6 +1081,7 @@ static int init_device_caps(RdmaBackendDev *backend_dev,
     CHK_ATTR(dev_attr, bk_dev_attr, max_qp_rd_atom, "%d");
     CHK_ATTR(dev_attr, bk_dev_attr, max_qp_init_rd_atom, "%d");
     CHK_ATTR(dev_attr, bk_dev_attr, max_ah, "%d");
+    CHK_ATTR(dev_attr, bk_dev_attr, max_srq, "%d");
 
     return 0;
 }
diff --git a/hw/rdma/rdma_backend.h b/hw/rdma/rdma_backend.h
index 38056d97c7..cad7956d98 100644
--- a/hw/rdma/rdma_backend.h
+++ b/hw/rdma/rdma_backend.h
@@ -114,4 +114,16 @@ void rdma_backend_post_recv(RdmaBackendDev *backend_dev,
                             RdmaBackendQP *qp, uint8_t qp_type,
                             struct ibv_sge *sge, uint32_t num_sge, void *ctx);
 
+int rdma_backend_create_srq(RdmaBackendSRQ *srq, RdmaBackendPD *pd,
+                            uint32_t max_wr, uint32_t max_sge,
+                            uint32_t srq_limit);
+int rdma_backend_query_srq(RdmaBackendSRQ *srq, struct ibv_srq_attr *srq_attr);
+int rdma_backend_modify_srq(RdmaBackendSRQ *srq, struct ibv_srq_attr *srq_attr,
+                            int srq_attr_mask);
+void rdma_backend_destroy_srq(RdmaBackendSRQ *srq,
+                              RdmaDeviceResources *dev_res);
+void rdma_backend_post_srq_recv(RdmaBackendDev *backend_dev,
+                                RdmaBackendSRQ *srq, struct ibv_sge *sge,
+                                uint32_t num_sge, void *ctx);
+
 #endif
diff --git a/hw/rdma/rdma_backend_defs.h b/hw/rdma/rdma_backend_defs.h
index 817153dc8c..0b55be3503 100644
--- a/hw/rdma/rdma_backend_defs.h
+++ b/hw/rdma/rdma_backend_defs.h
@@ -68,4 +68,9 @@ typedef struct RdmaBackendQP {
     RdmaProtectedGSList cqe_ctx_list;
 } RdmaBackendQP;
 
+typedef struct RdmaBackendSRQ {
+    struct ibv_srq *ibsrq;
+    RdmaProtectedGSList cqe_ctx_list;
+} RdmaBackendSRQ;
+
 #endif
diff --git a/hw/rdma/rdma_rm.c b/hw/rdma/rdma_rm.c
index bac3b2f4a6..b683506b86 100644
--- a/hw/rdma/rdma_rm.c
+++ b/hw/rdma/rdma_rm.c
@@ -37,6 +37,8 @@ void rdma_dump_device_counters(Monitor *mon, RdmaDeviceResources *dev_res)
                    dev_res->stats.tx_err);
     monitor_printf(mon, "\trx_bufs          : %" PRId64 "\n",
                    dev_res->stats.rx_bufs);
+    monitor_printf(mon, "\trx_srq           : %" PRId64 "\n",
+                   dev_res->stats.rx_srq);
     monitor_printf(mon, "\trx_bufs_len      : %" PRId64 "\n",
                    dev_res->stats.rx_bufs_len);
     monitor_printf(mon, "\trx_bufs_err      : %" PRId64 "\n",
diff --git a/hw/rdma/rdma_rm_defs.h b/hw/rdma/rdma_rm_defs.h
index c200d311de..e774af5280 100644
--- a/hw/rdma/rdma_rm_defs.h
+++ b/hw/rdma/rdma_rm_defs.h
@@ -106,6 +106,7 @@ typedef struct RdmaRmStats {
     uint64_t rx_bufs;
     uint64_t rx_bufs_len;
     uint64_t rx_bufs_err;
+    uint64_t rx_srq;
     uint64_t completions;
     uint64_t mad_tx;
     uint64_t mad_tx_err;
-- 
2.17.1


