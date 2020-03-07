Return-Path: <SRS0=oVW3=4Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66895C10F26
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2020 12:57:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 338022073C
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2020 12:57:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BJX/fMaA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 338022073C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48138 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jAZ1B-00056Y-Ek
	for qemu-devel@archiver.kernel.org; Sat, 07 Mar 2020 07:57:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50846)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yuval.shaia.ml@gmail.com>) id 1jAZ06-0003sp-GF
 for qemu-devel@nongnu.org; Sat, 07 Mar 2020 07:56:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yuval.shaia.ml@gmail.com>) id 1jAZ05-0008Bk-7a
 for qemu-devel@nongnu.org; Sat, 07 Mar 2020 07:56:18 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:34571)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <yuval.shaia.ml@gmail.com>)
 id 1jAZ05-00088Z-1Y
 for qemu-devel@nongnu.org; Sat, 07 Mar 2020 07:56:17 -0500
Received: by mail-wm1-x343.google.com with SMTP id x3so6163324wmj.1
 for <qemu-devel@nongnu.org>; Sat, 07 Mar 2020 04:56:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=0OgmZormDluZklSb/xIZswLUCmLwN6gTYoM8bKeN8Qk=;
 b=BJX/fMaAqZBa83frPRywGuAaAw7QaC83+mBkX3KxIVwzG7eCHy/aDcV9oYklcCbYuV
 86AIBc+b1nLfwM0Ctngz1dS6TeBfPJkunEH+9GohaWxR8VSt+e6zd9Xww2/19q5quqco
 W8+QJckt00CAGLNwS8LVLrQYo8SC0UGJ9Of4jTeLF4t62840QmbcH0O2/UuZGVvb+kqz
 BYSwKlWa0x7O+fhz5shSwT62//zIH7ARUXluV3atQ/04liB4SiCiUkHiFwdoq1s/Wi5J
 0pjNCBTvLIiZQtjfUPyg9nXgkwQRu91MY1tWrcvBlXzhI9uCQgv+oP88LD+IgUrjhtnX
 qw8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=0OgmZormDluZklSb/xIZswLUCmLwN6gTYoM8bKeN8Qk=;
 b=WIMn61qhY30WAgnStYGs5CivJx/gEpJCYczfCbcKYIUDNso9ankB0YNNZSKU9Otsyv
 PuzwtYStb7SsGC1ZIZOPPze1p8pVHvKiP1mIPjTgpU77y5/zH01xV+gA0dKegc9nc6ET
 oVCrJRAAwkqydxb3oWAQ6boMlkzENEDaQrYLHluBluEdff9cjzkA10baQkt6hy7zFi+8
 yN7vRioyksyKHuiTP27CovaGSICtBeQ8++ltvkn7bZIYdMFa1z3dWmo2fYyTZ12ef+kz
 QVZXtGP+5CfU6ZIohMNaAnbLyPedXBSQEKg1FfkF71Qf/ybfpCEgdHFvhnNeopnwU17+
 jCIQ==
X-Gm-Message-State: ANhLgQ2JmEVWshXH+VyN0Te1OYD6Yq8oDM+VreQRY0WxQxb05PDgNMD+
 WxMxG/MOyrkD1qNxFhitUhQ4r2Jm
X-Google-Smtp-Source: ADFU+vsa7tpcVy/uTt9epwdBdCJduw3HrmuPx8AnoEmpfyUHCyvNeqYUkzhtNddkJ+VEqIbOF89kgA==
X-Received: by 2002:a1c:ba42:: with SMTP id k63mr10015383wmf.71.1583585775862; 
 Sat, 07 Mar 2020 04:56:15 -0800 (PST)
Received: from localhost.localdomain ([2a00:a040:186:a1ad:5254:ff:fe84:1be0])
 by smtp.gmail.com with ESMTPSA id
 19sm19690289wma.3.2020.03.07.04.56.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Mar 2020 04:56:15 -0800 (PST)
From: Yuval Shaia <yuval.shaia.ml@gmail.com>
To: qemu-devel@nongnu.org, yuval.shaia.ml@gmail.com, marcel.apfelbaum@gmail.com
Subject: [PATCH 2/2] hw/rdma: Skip data-path mr_id translation
Date: Sat,  7 Mar 2020 14:56:08 +0200
Message-Id: <20200307125608.2476-3-yuval.shaia.ml@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200307125608.2476-1-yuval.shaia.ml@gmail.com>
References: <20200307125608.2476-1-yuval.shaia.ml@gmail.com>
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
 hw/rdma/rdma_backend.c | 23 ++++++++++++++---------
 hw/rdma/rdma_backend.h |  5 -----
 hw/rdma/rdma_rm.c      | 13 ++++++-------
 3 files changed, 20 insertions(+), 21 deletions(-)

diff --git a/hw/rdma/rdma_backend.c b/hw/rdma/rdma_backend.c
index 79b9cfb487..3dd39fe1a7 100644
--- a/hw/rdma/rdma_backend.c
+++ b/hw/rdma/rdma_backend.c
@@ -377,6 +377,7 @@ static void ah_cache_init(void)
                                     destroy_ah_hash_key, destroy_ah_hast_data);
 }
 
+#ifdef LEGACY_RDMA_REG_MR
 static int build_host_sge_array(RdmaDeviceResources *rdma_dev_res,
                                 struct ibv_sge *sge, uint8_t num_sge,
                                 uint64_t *total_length)
@@ -391,11 +392,7 @@ static int build_host_sge_array(RdmaDeviceResources *rdma_dev_res,
             return VENDOR_ERR_INVLKEY | sge[idx].lkey;
         }
 
-#ifdef LEGACY_RDMA_REG_MR
         sge[idx].addr = (uintptr_t)mr->virt + sge[idx].addr - mr->start;
-#else
-        sge[idx].addr = sge[idx].addr;
-#endif
         sge[idx].lkey = rdma_backend_mr_lkey(&mr->backend_mr);
 
         *total_length += sge[idx].length;
@@ -403,6 +400,19 @@ static int build_host_sge_array(RdmaDeviceResources *rdma_dev_res,
 
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
@@ -733,13 +743,8 @@ void rdma_backend_destroy_pd(RdmaBackendPD *pd)
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


