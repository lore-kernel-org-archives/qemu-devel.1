Return-Path: <SRS0=wc0w=5G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3257CC4332D
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Mar 2020 19:14:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F39DE20724
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Mar 2020 19:14:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IdvXNVh/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F39DE20724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39878 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFjZR-0006MK-4p
	for qemu-devel@archiver.kernel.org; Sat, 21 Mar 2020 15:14:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39584)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcel.apfelbaum@gmail.com>) id 1jFjYh-0005Tc-Nl
 for qemu-devel@nongnu.org; Sat, 21 Mar 2020 15:13:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcel.apfelbaum@gmail.com>) id 1jFjYg-0005oH-HQ
 for qemu-devel@nongnu.org; Sat, 21 Mar 2020 15:13:23 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:33022)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
 id 1jFjYg-0005nn-BX
 for qemu-devel@nongnu.org; Sat, 21 Mar 2020 15:13:22 -0400
Received: by mail-wr1-x442.google.com with SMTP id a25so11630452wrd.0
 for <qemu-devel@nongnu.org>; Sat, 21 Mar 2020 12:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=LcthiP02YGDEpiJDziYu4vlQ7hb4BbGLQNZ9o3R4LnI=;
 b=IdvXNVh/1FSUd/L5HissVFsSnMHaeeX9rm1P4TMk3663o2p/hK4WFtRjvjmvi8c9V8
 rnocxkBaMyenwdKklqqBW3R5HMx6DOC4WL9JlfQMNyI+GOaJXlENDxkf/Njh4rGeZuVA
 yKCtsKuFFBm9i1yVf9Qb+OTFrIonwpnFN83qC9ZFzropmHjPhU0jehjFoixHU2UCMENg
 PAkrrUN0GASMtRsNyLE17b2IKoUySa5PvN1zoTcDRro6dBPIGixX9JrESYE2hJVp+RgE
 Tt7ZZcJagxFvFZ+/wJhMd0bC/1NEwP4LDSwFqctVOo5cSUYM0ZUhZ2Zy8fJTqaYkAN6V
 tbqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=LcthiP02YGDEpiJDziYu4vlQ7hb4BbGLQNZ9o3R4LnI=;
 b=FC6zKJ+iLxdcgYyo9dhBU6GFZKHqR84XaawZXBputPgI3j032/PzohOmblwBctdre8
 f/vqKy1WEDKT4skbf8fQw8Elex3de7tkcNnbEQg6VgR6JiCmb0S6U/eiecBo0ElSt/vt
 7h5HSC1QYzo52rt2DsMGcoGa2fng2DAfdevVIhpRPfFcwJTvge0mFNlfBPn0TnegeGAk
 /o7uYZzx/9LNjvIs2kK09K8ucEO/keMPYqk7OGUyxV0IVtZ/g1PBFy8ZOXDRCDC/HEZZ
 abLfTJk8C2KRiozEF7unA1kBX1rVxAULcKAfnKFHZ1RhemG7TWzvlOVCe8R8/zLkL7L+
 8jKg==
X-Gm-Message-State: ANhLgQ1rvKvEgVxJ71pOwzHnVImYbmnJzUlJyvSOV5YS6Bf1FqpO0iTX
 J1cPnTj5KAtu6vddXdYQmCQdtKTZ
X-Google-Smtp-Source: ADFU+vvOe8yGgDTXks5tjxBRCI5cKjOxw5ZdAeT/y8dqhmu/qMNjYzb+vEm0J2FciAfz6i4l1fBo7Q==
X-Received: by 2002:adf:9cca:: with SMTP id h10mr7338699wre.167.1584818001035; 
 Sat, 21 Mar 2020 12:13:21 -0700 (PDT)
Received: from localhost.localdomain ([37.142.144.12])
 by smtp.gmail.com with ESMTPSA id i1sm15226252wrs.18.2020.03.21.12.13.19
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sat, 21 Mar 2020 12:13:20 -0700 (PDT)
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Subject: [Qemu-devel] [PATCH PULL 3/4] hw/rdma: Skip data-path mr_id
 translation
Date: Sat, 21 Mar 2020 21:13:10 +0200
Message-Id: <20200321191311.31537-4-marcel.apfelbaum@gmail.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20200321191311.31537-1-marcel.apfelbaum@gmail.com>
References: <20200321191311.31537-1-marcel.apfelbaum@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
Cc: jusual@redhat.com, stefanha@redhat.com, yuval.shaia.ml@gmail.com,
 quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Yuval Shaia <yuval.shaia.ml@gmail.com>

With the change made in commit 68b89aee71 ("Utilize ibv_reg_mr_iova for
memory registration") the MR emulation is no longer needed in order to
translate the guest addresses into host addresses.
With that, the next obvious step is to skip entirely the processing in
data-path.
To accomplish this, return the backend's lkey to driver so we will not
need to do the emulated mr_id to backend mr_id translation in data-path.

The function build_host_sge_array is still called in data-path but only
for backward computability with statistics collection.

While there, as a cosmetic change to make the code cleaner - make one
copy of the function rdma_backend_create_mr and leave the redundant
guest_start argument in the legacy code.

Signed-off-by: Yuval Shaia <yuval.shaia.ml@gmail.com>
Reviewed-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Message-Id: <20200320143429.9490-3-yuval.shaia.ml@gmail.com>
Signed-off-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
---
 hw/rdma/rdma_backend.c | 21 ++++++++++++++-------
 hw/rdma/rdma_backend.h |  5 -----
 hw/rdma/rdma_rm.c      | 13 ++++++-------
 3 files changed, 20 insertions(+), 19 deletions(-)

diff --git a/hw/rdma/rdma_backend.c b/hw/rdma/rdma_backend.c
index b7ffbef9c0..3dd39fe1a7 100644
--- a/hw/rdma/rdma_backend.c
+++ b/hw/rdma/rdma_backend.c
@@ -377,6 +377,7 @@ static void ah_cache_init(void)
                                     destroy_ah_hash_key, destroy_ah_hast_data);
 }
 
+#ifdef LEGACY_RDMA_REG_MR
 static int build_host_sge_array(RdmaDeviceResources *rdma_dev_res,
                                 struct ibv_sge *sge, uint8_t num_sge,
                                 uint64_t *total_length)
@@ -391,9 +392,7 @@ static int build_host_sge_array(RdmaDeviceResources *rdma_dev_res,
             return VENDOR_ERR_INVLKEY | sge[idx].lkey;
         }
 
-#ifdef LEGACY_RDMA_REG_MR
         sge[idx].addr = (uintptr_t)mr->virt + sge[idx].addr - mr->start;
-#endif
         sge[idx].lkey = rdma_backend_mr_lkey(&mr->backend_mr);
 
         *total_length += sge[idx].length;
@@ -401,6 +400,19 @@ static int build_host_sge_array(RdmaDeviceResources *rdma_dev_res,
 
     return 0;
 }
+#else
+static inline int build_host_sge_array(RdmaDeviceResources *rdma_dev_res,
+                                       struct ibv_sge *sge, uint8_t num_sge,
+                                       uint64_t *total_length)
+{
+    int idx;
+
+    for (idx = 0; idx < num_sge; idx++) {
+        *total_length += sge[idx].length;
+    }
+    return 0;
+}
+#endif
 
 static void trace_mad_message(const char *title, char *buf, int len)
 {
@@ -731,13 +743,8 @@ void rdma_backend_destroy_pd(RdmaBackendPD *pd)
     }
 }
 
-#ifdef LEGACY_RDMA_REG_MR
-int rdma_backend_create_mr(RdmaBackendMR *mr, RdmaBackendPD *pd, void *addr,
-                           size_t length, int access)
-#else
 int rdma_backend_create_mr(RdmaBackendMR *mr, RdmaBackendPD *pd, void *addr,
                            size_t length, uint64_t guest_start, int access)
-#endif
 {
 #ifdef LEGACY_RDMA_REG_MR
     mr->ibmr = ibv_reg_mr(pd->ibpd, addr, length, access);
diff --git a/hw/rdma/rdma_backend.h b/hw/rdma/rdma_backend.h
index 127f96e2d5..225af481e0 100644
--- a/hw/rdma/rdma_backend.h
+++ b/hw/rdma/rdma_backend.h
@@ -78,13 +78,8 @@ int rdma_backend_query_port(RdmaBackendDev *backend_dev,
 int rdma_backend_create_pd(RdmaBackendDev *backend_dev, RdmaBackendPD *pd);
 void rdma_backend_destroy_pd(RdmaBackendPD *pd);
 
-#ifdef LEGACY_RDMA_REG_MR
-int rdma_backend_create_mr(RdmaBackendMR *mr, RdmaBackendPD *pd, void *addr,
-                           size_t length, int access);
-#else
 int rdma_backend_create_mr(RdmaBackendMR *mr, RdmaBackendPD *pd, void *addr,
                            size_t length, uint64_t guest_start, int access);
-#endif
 void rdma_backend_destroy_mr(RdmaBackendMR *mr);
 
 int rdma_backend_create_cq(RdmaBackendDev *backend_dev, RdmaBackendCQ *cq,
diff --git a/hw/rdma/rdma_rm.c b/hw/rdma/rdma_rm.c
index 1524dfaeaa..7e9ea283c9 100644
--- a/hw/rdma/rdma_rm.c
+++ b/hw/rdma/rdma_rm.c
@@ -227,21 +227,20 @@ int rdma_rm_alloc_mr(RdmaDeviceResources *dev_res, uint32_t pd_handle,
         mr->length = guest_length;
         mr->virt += (mr->start & (TARGET_PAGE_SIZE - 1));
 
-#ifdef LEGACY_RDMA_REG_MR
-        ret = rdma_backend_create_mr(&mr->backend_mr, &pd->backend_pd, mr->virt,
-                                     mr->length, access_flags);
-#else
         ret = rdma_backend_create_mr(&mr->backend_mr, &pd->backend_pd, mr->virt,
                                      mr->length, guest_start, access_flags);
-#endif
         if (ret) {
             ret = -EIO;
             goto out_dealloc_mr;
         }
+#ifdef LEGACY_RDMA_REG_MR
+        /* We keep mr_handle in lkey so send and recv get get mr ptr */
+        *lkey = *mr_handle;
+#else
+        *lkey = rdma_backend_mr_lkey(&mr->backend_mr);
+#endif
     }
 
-    /* We keep mr_handle in lkey so send and recv get get mr ptr */
-    *lkey = *mr_handle;
     *rkey = -1;
 
     mr->pd_handle = pd_handle;
-- 
2.17.2


