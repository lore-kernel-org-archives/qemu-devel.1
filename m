Return-Path: <SRS0=Uyhh=TE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3343C43219
	for <qemu-devel@archiver.kernel.org>; Sat,  4 May 2019 13:49:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 901B2206DF
	for <qemu-devel@archiver.kernel.org>; Sat,  4 May 2019 13:49:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iaJ+iwBu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 901B2206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:56976 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMv2q-0004X1-Tb
	for qemu-devel@archiver.kernel.org; Sat, 04 May 2019 09:49:40 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43990)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1hMuyw-00021I-Ny
	for qemu-devel@nongnu.org; Sat, 04 May 2019 09:45:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1hMuyv-0002LT-GO
	for qemu-devel@nongnu.org; Sat, 04 May 2019 09:45:38 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:46369)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
	id 1hMuyv-0002KT-9U
	for qemu-devel@nongnu.org; Sat, 04 May 2019 09:45:37 -0400
Received: by mail-wr1-x443.google.com with SMTP id r7so11264015wrr.13
	for <qemu-devel@nongnu.org>; Sat, 04 May 2019 06:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=ZzPqjXcVVs2xit2QjD3jgD4GNNyHuMQK4jtT3UL3/9E=;
	b=iaJ+iwBu4GLxmqzP7VrCAO5rwzW45wK/sqfbV6CmLIZOWTH6k/KcIk8Xli32JoxEew
	2PuACDF4vr1I7prtwAwA9pmRbpF+SXrtvmyxOFK9sKvDpYvcm0KEQqjv5L3xKiUlzyWo
	8F4brWk7J4yMS8RCgR7UKZ7YeIAuO3JdktyEl7S2KfPMTK/f+4BQ0vvC6upaGTS//0iS
	IzmaM5DfIVodDAf00+yWBWeGhM5MXc//WV+lcNDJ/pqobzM9qNXdbwl1cdF8m8PPvTc0
	grFGe08WX8NteeKa96l2CPNgyvscv7klTq0Oqd4CiQVKAyG20jSecoIINKEPN8ZLPR+g
	kI6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=ZzPqjXcVVs2xit2QjD3jgD4GNNyHuMQK4jtT3UL3/9E=;
	b=nwO6m2GbmQbW7jz6aD0IueNQsyRW2h0en4PI4j3GWROKdFt/lmfULbW39ccw4eWSw1
	wR4KVTO2q3qx1P79FI3eJMYZPezotrLA/IvqtkGkEHGXUIgjQy6yf0A+LB2qDTUvB7tO
	lQOe0J3i5KfKZuGml8iEB2f+E/cQtH1bnnv+sNTMHaTMeIhURMl2dgxw7JSQSFW4+SGf
	CibuF+Pp+lbNKpYZkSZePybD0eNFOkd0shVUXJrTY6xg4CrMc0Iy35/UWVbwE5idDXUM
	oR+I4j/cn2o/Mbw6STtE/HB73wfpxmg437cj/28525KOba+S23XffQw/iViv4eeA87+d
	PBPw==
X-Gm-Message-State: APjAAAVwy+3WtNmf8rAMc7e6m3Asx3606Zbeg+l8gfMGSMlBMQjsRDe+
	LPM4S+UP6TAkhHksIIWGyf4BRQ+S
X-Google-Smtp-Source: APXvYqxgJf9rcG8LhrGs//UWa4I9mEtDZWSWi/vD/UlwIyRSHsro2Hsq34+dtv7/Nbh/+OTaTatbPw==
X-Received: by 2002:a5d:67cb:: with SMTP id n11mr11032873wrw.3.1556977535854; 
	Sat, 04 May 2019 06:45:35 -0700 (PDT)
Received: from localhost.localdomain ([37.142.144.27])
	by smtp.gmail.com with ESMTPSA id t1sm5095610wro.34.2019.05.04.06.45.34
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Sat, 04 May 2019 06:45:35 -0700 (PDT)
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Date: Sat,  4 May 2019 16:45:27 +0300
Message-Id: <20190504134529.4755-3-marcel.apfelbaum@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190504134529.4755-1-marcel.apfelbaum@gmail.com>
References: <20190504134529.4755-1-marcel.apfelbaum@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: [Qemu-devel] [PATCH PULL 2/4] hw/rdma: Add support for managing SRQ
 resource
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
Message-ID: <20190504134527.wEQtlAaSU3yjV9STiMF4yL1U3zTYYKJj-LUbM5EKPAQ@z>

From: Kamal Heib <kamalheib1@gmail.com>

Adding the required functions and definitions for support managing the
shared receive queues (SRQs).

Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
Message-Id: <20190403113343.26384-3-kamalheib1@gmail.com>
Reviewed-by: Yuval Shaia <yuval.shaia@oracle.com>
Signed-off-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
---
 hw/rdma/rdma_rm.c      | 93 ++++++++++++++++++++++++++++++++++++++++++
 hw/rdma/rdma_rm.h      | 10 +++++
 hw/rdma/rdma_rm_defs.h |  8 ++++
 3 files changed, 111 insertions(+)

diff --git a/hw/rdma/rdma_rm.c b/hw/rdma/rdma_rm.c
index b683506b86..c4fb140dcd 100644
--- a/hw/rdma/rdma_rm.c
+++ b/hw/rdma/rdma_rm.c
@@ -544,6 +544,96 @@ void rdma_rm_dealloc_qp(RdmaDeviceResources *dev_res, uint32_t qp_handle)
     rdma_res_tbl_dealloc(&dev_res->qp_tbl, qp->qpn);
 }
 
+RdmaRmSRQ *rdma_rm_get_srq(RdmaDeviceResources *dev_res, uint32_t srq_handle)
+{
+    return rdma_res_tbl_get(&dev_res->srq_tbl, srq_handle);
+}
+
+int rdma_rm_alloc_srq(RdmaDeviceResources *dev_res, uint32_t pd_handle,
+                      uint32_t max_wr, uint32_t max_sge, uint32_t srq_limit,
+                      uint32_t *srq_handle, void *opaque)
+{
+    RdmaRmSRQ *srq;
+    RdmaRmPD *pd;
+    int rc;
+
+    pd = rdma_rm_get_pd(dev_res, pd_handle);
+    if (!pd) {
+        return -EINVAL;
+    }
+
+    srq = rdma_res_tbl_alloc(&dev_res->srq_tbl, srq_handle);
+    if (!srq) {
+        return -ENOMEM;
+    }
+
+    rc = rdma_backend_create_srq(&srq->backend_srq, &pd->backend_pd,
+                                 max_wr, max_sge, srq_limit);
+    if (rc) {
+        rc = -EIO;
+        goto out_dealloc_srq;
+    }
+
+    srq->opaque = opaque;
+
+    return 0;
+
+out_dealloc_srq:
+    rdma_res_tbl_dealloc(&dev_res->srq_tbl, *srq_handle);
+
+    return rc;
+}
+
+int rdma_rm_query_srq(RdmaDeviceResources *dev_res, uint32_t srq_handle,
+                      struct ibv_srq_attr *srq_attr)
+{
+    RdmaRmSRQ *srq;
+
+    srq = rdma_rm_get_srq(dev_res, srq_handle);
+    if (!srq) {
+        return -EINVAL;
+    }
+
+    return rdma_backend_query_srq(&srq->backend_srq, srq_attr);
+}
+
+int rdma_rm_modify_srq(RdmaDeviceResources *dev_res, uint32_t srq_handle,
+                       struct ibv_srq_attr *srq_attr, int srq_attr_mask)
+{
+    RdmaRmSRQ *srq;
+
+    srq = rdma_rm_get_srq(dev_res, srq_handle);
+    if (!srq) {
+        return -EINVAL;
+    }
+
+    if ((srq_attr_mask & IBV_SRQ_LIMIT) &&
+        (srq_attr->srq_limit == 0)) {
+        return -EINVAL;
+    }
+
+    if ((srq_attr_mask & IBV_SRQ_MAX_WR) &&
+        (srq_attr->max_wr == 0)) {
+        return -EINVAL;
+    }
+
+    return rdma_backend_modify_srq(&srq->backend_srq, srq_attr,
+                                   srq_attr_mask);
+}
+
+void rdma_rm_dealloc_srq(RdmaDeviceResources *dev_res, uint32_t srq_handle)
+{
+    RdmaRmSRQ *srq;
+
+    srq = rdma_rm_get_srq(dev_res, srq_handle);
+    if (!srq) {
+        return;
+    }
+
+    rdma_backend_destroy_srq(&srq->backend_srq, dev_res);
+    rdma_res_tbl_dealloc(&dev_res->srq_tbl, srq_handle);
+}
+
 void *rdma_rm_get_cqe_ctx(RdmaDeviceResources *dev_res, uint32_t cqe_ctx_id)
 {
     void **cqe_ctx;
@@ -673,6 +763,8 @@ int rdma_rm_init(RdmaDeviceResources *dev_res, struct ibv_device_attr *dev_attr)
     res_tbl_init("CQE_CTX", &dev_res->cqe_ctx_tbl, dev_attr->max_qp *
                        dev_attr->max_qp_wr, sizeof(void *));
     res_tbl_init("UC", &dev_res->uc_tbl, MAX_UCS, sizeof(RdmaRmUC));
+    res_tbl_init("SRQ", &dev_res->srq_tbl, dev_attr->max_srq,
+                 sizeof(RdmaRmSRQ));
 
     init_ports(dev_res);
 
@@ -691,6 +783,7 @@ void rdma_rm_fini(RdmaDeviceResources *dev_res, RdmaBackendDev *backend_dev,
 
     fini_ports(dev_res, backend_dev, ifname);
 
+    res_tbl_free(&dev_res->srq_tbl);
     res_tbl_free(&dev_res->uc_tbl);
     res_tbl_free(&dev_res->cqe_ctx_tbl);
     res_tbl_free(&dev_res->qp_tbl);
diff --git a/hw/rdma/rdma_rm.h b/hw/rdma/rdma_rm.h
index 4f03f9b8c5..e88ab95e26 100644
--- a/hw/rdma/rdma_rm.h
+++ b/hw/rdma/rdma_rm.h
@@ -65,6 +65,16 @@ int rdma_rm_query_qp(RdmaDeviceResources *dev_res, RdmaBackendDev *backend_dev,
                      int attr_mask, struct ibv_qp_init_attr *init_attr);
 void rdma_rm_dealloc_qp(RdmaDeviceResources *dev_res, uint32_t qp_handle);
 
+RdmaRmSRQ *rdma_rm_get_srq(RdmaDeviceResources *dev_res, uint32_t srq_handle);
+int rdma_rm_alloc_srq(RdmaDeviceResources *dev_res, uint32_t pd_handle,
+                      uint32_t max_wr, uint32_t max_sge, uint32_t srq_limit,
+                      uint32_t *srq_handle, void *opaque);
+int rdma_rm_query_srq(RdmaDeviceResources *dev_res, uint32_t srq_handle,
+                      struct ibv_srq_attr *srq_attr);
+int rdma_rm_modify_srq(RdmaDeviceResources *dev_res, uint32_t srq_handle,
+                       struct ibv_srq_attr *srq_attr, int srq_attr_mask);
+void rdma_rm_dealloc_srq(RdmaDeviceResources *dev_res, uint32_t srq_handle);
+
 int rdma_rm_alloc_cqe_ctx(RdmaDeviceResources *dev_res, uint32_t *cqe_ctx_id,
                           void *ctx);
 void *rdma_rm_get_cqe_ctx(RdmaDeviceResources *dev_res, uint32_t cqe_ctx_id);
diff --git a/hw/rdma/rdma_rm_defs.h b/hw/rdma/rdma_rm_defs.h
index e774af5280..7bdd9f291f 100644
--- a/hw/rdma/rdma_rm_defs.h
+++ b/hw/rdma/rdma_rm_defs.h
@@ -33,6 +33,7 @@
 #define MAX_QP_RD_ATOM        16
 #define MAX_QP_INIT_RD_ATOM   16
 #define MAX_AH                64
+#define MAX_SRQ               512
 
 #define MAX_RM_TBL_NAME             16
 #define MAX_CONSEQ_EMPTY_POLL_CQ    4096 /* considered as error above this */
@@ -89,6 +90,12 @@ typedef struct RdmaRmQP {
     enum ibv_qp_state qp_state;
 } RdmaRmQP;
 
+typedef struct RdmaRmSRQ {
+    RdmaBackendSRQ backend_srq;
+    uint32_t recv_cq_handle;
+    void *opaque;
+} RdmaRmSRQ;
+
 typedef struct RdmaRmGid {
     union ibv_gid gid;
     int backend_gid_index;
@@ -129,6 +136,7 @@ struct RdmaDeviceResources {
     RdmaRmResTbl qp_tbl;
     RdmaRmResTbl cq_tbl;
     RdmaRmResTbl cqe_ctx_tbl;
+    RdmaRmResTbl srq_tbl;
     GHashTable *qp_hash; /* Keeps mapping between real and emulated */
     QemuMutex lock;
     RdmaRmStats stats;
-- 
2.17.1


