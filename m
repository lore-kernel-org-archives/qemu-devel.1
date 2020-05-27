Return-Path: <SRS0=ACoC=7J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D2C0C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 15:56:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B5ED20776
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 15:56:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OuuMLXtI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B5ED20776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57460 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdyQE-0005XA-9e
	for qemu-devel@archiver.kernel.org; Wed, 27 May 2020 11:56:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54284)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jdyPV-0004oB-1E
 for qemu-devel@nongnu.org; Wed, 27 May 2020 11:56:05 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:38343
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jdyPU-0007hc-51
 for qemu-devel@nongnu.org; Wed, 27 May 2020 11:56:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590594962;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=YdePEd4ybfyY7U2+FqOlke5L5yf8ZLMowP5ujKzP0WI=;
 b=OuuMLXtIwg+TwUMlTcMWQo08hiGbJ403CBHGWE02Mtun/dBwNQs8wfOGUIuzpkdXK1tVd7
 QugRpwHJXhvD6U2IePrcNihQ4c7XrnTZketb6yph+yBaFQqnRBchZWWBNabs9TL9+JCBpo
 MIHcnj/LjtpfiQL7v46VKRBZBPvSxAU=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-400-5xwhgR-sNKGL3gD5kg-rcA-1; Wed, 27 May 2020 11:55:59 -0400
X-MC-Unique: 5xwhgR-sNKGL3gD5kg-rcA-1
Received: by mail-ej1-f71.google.com with SMTP id t26so9112202ejs.19
 for <qemu-devel@nongnu.org>; Wed, 27 May 2020 08:55:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=YdePEd4ybfyY7U2+FqOlke5L5yf8ZLMowP5ujKzP0WI=;
 b=etnyY3C/nsmTsZH9hwnabbSOQcmISGLtQhTQuHtBsH/RieoSlmFpWSZGIRTsI2144c
 KJxHdrr90vOcj/OWCam1T85Nfqay1f26UHJk1ktg2DSi4YNzUtSm2V/gBB83oO/0JYoY
 ZPzfd1j1L4lLt4tT39nqfSQuIPP4OufsMH3wPb60tUP1wIf0prj7IXyxJ4814aOD8ZJv
 SW1qFCPvWC7/RBLGgvQB36gesbswK2ACxhvjLGBJIrtVaBTy/7+vHP08nzQj8DULTm0u
 Yzo91IBod9lwwUTc1tUbe8qkqYSq0T+rGCudtwDTKl0aVylLvCqXJ5Rwovzv87YaiJsv
 sjqQ==
X-Gm-Message-State: AOAM530Av7Pv+KH6+ToAVRZeB1zaL8yRfFS+GkflDeYUkj5Jq5WEKky+
 aJHqgiUSiNBjLoAYvYEMVqFVU30f4wZXAfEQyuLfRSRvU4pK4eXlqSSLrBNmnQT4t6okHniFeiT
 dtZlQovCjPTbx+to=
X-Received: by 2002:a17:906:410a:: with SMTP id
 j10mr6530649ejk.378.1590594957876; 
 Wed, 27 May 2020 08:55:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwBGdK4EJtBkeOhyS+VANinAUc/7ASWpLH8aEoWX0wolUEL5Btx8kwCDOLQc3uLP64e48b8Xg==
X-Received: by 2002:a17:906:410a:: with SMTP id
 j10mr6530632ejk.378.1590594957632; 
 Wed, 27 May 2020 08:55:57 -0700 (PDT)
Received: from x1w.redhat.com (71.red-88-21-204.staticip.rima-tde.net.
 [88.21.204.71])
 by smtp.gmail.com with ESMTPSA id y19sm2194116edq.54.2020.05.27.08.55.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 May 2020 08:55:57 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2] hw/vfio/common: Trace in which mode an IOMMU is opened
Date: Wed, 27 May 2020 17:55:55 +0200
Message-Id: <20200527155555.6833-1-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/27 00:49:35
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: qemu-trivial@nongnu.org, Cornelia Huck <cohuck@redhat.com>,
 Peter Xu <peterx@redhat.com>, Eric Auger <eric.auger@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

One might want to check which IOMMU version the host kernel
provide. Add a trace event to see in which mode we opened
our container.

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
v2: Only display string description (Eric)

Supersedes: <20200526173542.28710-1-philmd@redhat.com>
---
 hw/vfio/common.c     | 19 ++++++++++++++-----
 hw/vfio/trace-events |  1 +
 2 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 0b3593b3c0..f24450472e 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -1157,15 +1157,24 @@ static void vfio_put_address_space(VFIOAddressSpace *space)
 static int vfio_get_iommu_type(VFIOContainer *container,
                                Error **errp)
 {
-    int iommu_types[] = { VFIO_TYPE1v2_IOMMU, VFIO_TYPE1_IOMMU,
-                          VFIO_SPAPR_TCE_v2_IOMMU, VFIO_SPAPR_TCE_IOMMU };
+    static const struct {
+        int type;
+        const char *name;
+    } iommu[] = {
+        {VFIO_TYPE1v2_IOMMU, "Type1 (v2)"},
+        {VFIO_TYPE1_IOMMU, "Type1 (v1)"},
+        {VFIO_SPAPR_TCE_v2_IOMMU, "sPAPR TCE (v2)"},
+        {VFIO_SPAPR_TCE_IOMMU, "sPAPR TCE (v1)"}
+    };
     int i;
 
-    for (i = 0; i < ARRAY_SIZE(iommu_types); i++) {
-        if (ioctl(container->fd, VFIO_CHECK_EXTENSION, iommu_types[i])) {
-            return iommu_types[i];
+    for (i = 0; i < ARRAY_SIZE(iommu); i++) {
+        if (ioctl(container->fd, VFIO_CHECK_EXTENSION, iommu[i].type)) {
+            trace_vfio_get_iommu_type(iommu[i].name);
+            return iommu[i].type;
         }
     }
+    trace_vfio_get_iommu_type("Not available or not supported");
     error_setg(errp, "No available IOMMU models");
     return -EINVAL;
 }
diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
index b1ef55a33f..d3f1e48618 100644
--- a/hw/vfio/trace-events
+++ b/hw/vfio/trace-events
@@ -115,6 +115,7 @@ vfio_region_sparse_mmap_header(const char *name, int index, int nr_areas) "Devic
 vfio_region_sparse_mmap_entry(int i, unsigned long start, unsigned long end) "sparse entry %d [0x%lx - 0x%lx]"
 vfio_get_dev_region(const char *name, int index, uint32_t type, uint32_t subtype) "%s index %d, %08x/%0x8"
 vfio_dma_unmap_overflow_workaround(void) ""
+vfio_get_iommu_type(const char *type) "IOMMU type: %s"
 
 # platform.c
 vfio_platform_base_device_init(char *name, int groupid) "%s belongs to group #%d"
-- 
2.21.3


