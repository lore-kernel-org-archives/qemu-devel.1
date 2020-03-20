Return-Path: <SRS0=cIHa=5F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55FD6C4332D
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 14:37:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2339E20709
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 14:37:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nKbMEjXG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2339E20709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53658 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFImQ-0005qh-7n
	for qemu-devel@archiver.kernel.org; Fri, 20 Mar 2020 10:37:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49673)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yuval.shaia.ml@gmail.com>) id 1jFIjQ-0001E6-6R
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 10:34:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yuval.shaia.ml@gmail.com>) id 1jFIjO-00071T-T9
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 10:34:40 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:52791)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <yuval.shaia.ml@gmail.com>)
 id 1jFIjO-000713-MO
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 10:34:38 -0400
Received: by mail-wm1-x343.google.com with SMTP id 11so6768320wmo.2
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2020 07:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=WLRGw4TSyydbZUMf9i34H/3aemcOZ131iJAvNdj19K4=;
 b=nKbMEjXGyV8iMZUq+EK3PWV1ztetGErh4sfJi/xGAbTLdvdqZ5WPVOq2SzewfEIQbF
 miEckaPOg76xvKJ4rFd1wwuWjVmEjRokzsptzrE7k5wDPB3497dOdAMznRWu11mytGTD
 JjW7PFiRcn8OS84U0iCNKBNzJ9GbAp+N2YAi+cqJJYqK8ZM6ZmZoDPuptTsW+yOMtnvm
 KYnARP/JY8nkyUT2U3bp+tCKvJMb+sTKZAifxuxlNvY2bWuaSNM2kyxa1KKv+cbTuRlc
 P0TXRwDMaCF+z+t0kGrZsHcQ2KZBmc2CmEBNkTY+06S1h0b2f84EnmPRzyOGvSS07TP1
 yFuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=WLRGw4TSyydbZUMf9i34H/3aemcOZ131iJAvNdj19K4=;
 b=snQIpaHb/VYa+kk0qKwFGXZuXeRByefE7r3w/V+RHUplMw80qJWFxcfw2vcR+oGC11
 lDIVLlwTfHSfF/VwGKvu17EwD2Wc/uDC2apePvAWaSI9Em6aa3RxFNINR7awh1fOeYKB
 vgHS3YNfkCIatvnnetP5VYjZKYZUPMOh4N2f3FO42gb1nkkIL8jaV6sZtlrB+sRiCwaM
 c4H+jAuEQDkYVasxxb4ce1/TnJkjbgfkjYCPS3uKVpc+buQtBQPcuXodO93fLQYMvZWq
 vUzOEkiN4rkN3kj1X5UzgEFQUst0wNwKbUWs2FKlDvTU2ifeQ0vW7pWUO2AkJgvZgv3/
 T/QQ==
X-Gm-Message-State: ANhLgQ2kpgmb5htDXwiM7iYpy8UZaauOy6mMebteD4V1ms8V1n8tT5bK
 wWPUTkLf6N2OGnWw7mQqHQbtkDJA
X-Google-Smtp-Source: ADFU+vvZmSxcF+dvFo1sy+d9FdbkiOKpG3CLOPhQIyLqcytS4uL8zrsPwwFadPVNFLKTqRcvMf+xhQ==
X-Received: by 2002:a7b:c0c7:: with SMTP id s7mr10316393wmh.187.1584714877341; 
 Fri, 20 Mar 2020 07:34:37 -0700 (PDT)
Received: from localhost.localdomain ([2a00:a040:186:a1ad:5254:ff:fe84:1be0])
 by smtp.gmail.com with ESMTPSA id
 s22sm7336694wmc.16.2020.03.20.07.34.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Mar 2020 07:34:36 -0700 (PDT)
From: Yuval Shaia <yuval.shaia.ml@gmail.com>
To: qemu-devel@nongnu.org, yuval.shaia.ml@gmail.com, marcel.apfelbaum@gmail.com
Subject: [PATCH v1 2/2] hw/rdma: Skip data-path mr_id translation
Date: Fri, 20 Mar 2020 16:34:29 +0200
Message-Id: <20200320143429.9490-3-yuval.shaia.ml@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200320143429.9490-1-yuval.shaia.ml@gmail.com>
References: <20200320143429.9490-1-yuval.shaia.ml@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

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
2.20.1


