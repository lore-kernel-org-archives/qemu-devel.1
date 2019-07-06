Return-Path: <SRS0=Pmsr=VD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 184B4C5B578
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jul 2019 04:11:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE67E216B7
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jul 2019 04:11:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pLUjFOCa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE67E216B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57644 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hjc39-0007Bt-2o
	for qemu-devel@archiver.kernel.org; Sat, 06 Jul 2019 00:11:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53263)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <skrtbhtngr@gmail.com>) id 1hjc1M-0006Ek-7n
 for qemu-devel@nongnu.org; Sat, 06 Jul 2019 00:09:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <skrtbhtngr@gmail.com>) id 1hjc1K-0000lr-C4
 for qemu-devel@nongnu.org; Sat, 06 Jul 2019 00:09:56 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:38840)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <skrtbhtngr@gmail.com>)
 id 1hjc1J-0000kp-6W
 for qemu-devel@nongnu.org; Sat, 06 Jul 2019 00:09:54 -0400
Received: by mail-pl1-x641.google.com with SMTP id 9so5450089ple.5
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2019 21:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=fPlaR/RqYJOcV/wH+fB4Exz5LrXEWktWATpatpBFvpM=;
 b=pLUjFOCahEbZMEf0vwt/aothmGLK+23E2hJVmP17C3SdOTaWvTv/DC3q6SXyLGGpra
 Ay9sgxz2LlU6PmAxkGe4ImDJL5RKl5ie0P9UKSZbQ9cmjaSdFPvr7DWw/lzZVJOuX5nN
 TbTYz50+a+zThAfhT9ZtdPzYn7TeCT5of+Ym4ZMlsUY9wwInZ9Kmncvz8LOpSCUnrra0
 c2ltJE7+6WUFkZwpbb6gL+eHzyb+asdFSI51a1tI68LyKbUYHOvxIDyDO7khFG6nRSFg
 D5BJQ9DsgDA70ucGaVi9JUM1upV8IL1s+VIi5FS+z0rncpMXXdu8ll9gejqDEF5bEh1F
 zEqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=fPlaR/RqYJOcV/wH+fB4Exz5LrXEWktWATpatpBFvpM=;
 b=ByCLKXD/pMC0q9BwNlT/cwFXZHrVwFXTtuQbXcNrebcd5kS0XTXzlSVLbyWnHUJQVL
 GqLoXWTsL8bTr+C+yW0rv9WNME9T3QQvo8Gh/gqhe0BgBQo3C3stfmXU3q8k+Ck9SsB3
 1udfshyNTJOsK+zC8gugykobZzfXNRVmJwjU0QCJu5perLGQy9yPlCTxr5ONF6njtz2/
 aHzDlIzlH1stJWKsi9WVsU9lOow/O1wiTsyEcATqwnN09044DZ5aTfiE5t5iIGgqek/4
 jYCWblWWMgIx44HmgbY1/xWjfPPREiHTD9S+W+7ZfmSpg+QDXdqqTv4VTjWYroZUG2Fp
 5XFw==
X-Gm-Message-State: APjAAAW6SD6+f6GmQUNQXU6KF36d65ClaU/qG7r3F1kCfNbjtWiNMKCK
 ib3S6ypTCuM+Wh74zvHswG/v2s1y
X-Google-Smtp-Source: APXvYqxS3JGDrFserN4A8HEly63a7Qgii+XdrUVXoXhdsgGWSjoazqnzu0SCue5o0nu5YAtpveuVyw==
X-Received: by 2002:a17:902:e282:: with SMTP id
 cf2mr9538885plb.301.1562386191851; 
 Fri, 05 Jul 2019 21:09:51 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:22f:6255:6f39:949d:5942:eaaf])
 by smtp.gmail.com with ESMTPSA id
 q126sm17330847pfq.123.2019.07.05.21.09.49
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 05 Jul 2019 21:09:51 -0700 (PDT)
From: Sukrit Bhatnagar <skrtbhtngr@gmail.com>
To: qemu-devel@nongnu.org
Date: Sat,  6 Jul 2019 09:39:40 +0530
Message-Id: <20190706040940.7884-3-skrtbhtngr@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190706040940.7884-1-skrtbhtngr@gmail.com>
References: <20190706040940.7884-1-skrtbhtngr@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::641
Subject: [Qemu-devel] [RFC v2 2/2] hw/pvrdma: add live migration support
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
Cc: Yuval Shaia <yuval.shaia@oracle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Use VMStateDescription for migrating device state. Currently,
'vmstate_pvrdma' describes the PCI and MSIX state for pvrdma and
'vmstate_pvrdma_dsr_dma' describes a temporary state containing
some values obtained only after mapping to dsr in the source.
Since the dsr will not be available on dest until we map to the
dma address we had on source, these values cannot be migrated
directly.

Add PVRDMAMigTmp to store this temporary state which consists of
dma addresses and ring page information. The 'parent' member is
used to refer to the device state (PVRDMADev) so that parent PCI
device object is accessible, which is needed to remap to DSR.

pvrdma_dsr_dma_pre_save() saves the dsr state into this temporary
representation and pvrdma_dsr_dma_post_load() loads it back.
This load function also remaps to the dsr and and calls
load_dsr() for further map and ring init operations.

Please note that this call to load_dsr() can be removed from the
migration flow and included in pvrdma_regs_write() to perform a
lazy load.
As of now, migration will fail if there in an error in load_dsr().
Also, there might be a considerable amount of pages in the rings,
which will have dma map operations when the init functions are
called.
If this takes noticeable time, it might be better to have lazy
load instead.

Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: Yuval Shaia <yuval.shaia@oracle.com>
Signed-off-by: Sukrit Bhatnagar <skrtbhtngr@gmail.com>
---
 hw/rdma/vmw/pvrdma_main.c | 87 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 87 insertions(+)

diff --git a/hw/rdma/vmw/pvrdma_main.c b/hw/rdma/vmw/pvrdma_main.c
index 6c90db96f9..4a10bd2fc7 100644
--- a/hw/rdma/vmw/pvrdma_main.c
+++ b/hw/rdma/vmw/pvrdma_main.c
@@ -28,6 +28,7 @@
 #include "sysemu/sysemu.h"
 #include "monitor/monitor.h"
 #include "hw/rdma/rdma.h"
+#include "migration/register.h"
 
 #include "../rdma_rm.h"
 #include "../rdma_backend.h"
@@ -593,6 +594,91 @@ static void pvrdma_shutdown_notifier(Notifier *n, void *opaque)
     pvrdma_fini(pci_dev);
 }
 
+struct PVRDMAMigTmp {
+    PVRDMADev *parent;
+    uint64_t dma;
+    uint64_t cmd_slot_dma;
+    uint64_t resp_slot_dma;
+    uint32_t cq_ring_pages_num_pages;
+    uint64_t cq_ring_pages_pdir_dma;
+    uint32_t async_ring_pages_num_pages;
+    uint64_t async_ring_pages_pdir_dma;
+};
+
+static int pvrdma_dsr_dma_pre_save(void *opaque)
+{
+    struct PVRDMAMigTmp *tmp = opaque;
+    DSRInfo *dsr_info = &tmp->parent->dsr_info;
+    struct pvrdma_device_shared_region *dsr = dsr_info->dsr;
+
+    tmp->dma = dsr_info->dma;
+    tmp->cmd_slot_dma = dsr->cmd_slot_dma;
+    tmp->resp_slot_dma = dsr->resp_slot_dma;
+    tmp->cq_ring_pages_num_pages = dsr->cq_ring_pages.num_pages;
+    tmp->cq_ring_pages_pdir_dma = dsr->cq_ring_pages.pdir_dma;
+    tmp->async_ring_pages_num_pages = dsr->async_ring_pages.num_pages;
+    tmp->async_ring_pages_pdir_dma = dsr->async_ring_pages.pdir_dma;
+
+    return 0;
+}
+
+static int pvrdma_dsr_dma_post_load(void *opaque, int version_id)
+{
+    struct PVRDMAMigTmp *tmp = opaque;
+    PVRDMADev *dev = tmp->parent;
+    PCIDevice *pci_dev = PCI_DEVICE(dev);
+    DSRInfo *dsr_info = &dev->dsr_info;
+    struct pvrdma_device_shared_region *dsr;
+
+    dsr_info->dma = tmp->dma;
+    dsr_info->dsr = rdma_pci_dma_map(pci_dev, dsr_info->dma,
+                                sizeof(struct pvrdma_device_shared_region));
+    if (!dsr_info->dsr) {
+        rdma_error_report("Failed to map to DSR");
+        return -ENOMEM;
+    }
+
+    dsr = dsr_info->dsr;
+    dsr->cmd_slot_dma = tmp->cmd_slot_dma;
+    dsr->resp_slot_dma = tmp->resp_slot_dma;
+    dsr->cq_ring_pages.num_pages = tmp->cq_ring_pages_num_pages;
+    dsr->cq_ring_pages.pdir_dma = tmp->cq_ring_pages_pdir_dma;
+    dsr->async_ring_pages.num_pages = tmp->async_ring_pages_num_pages;
+    dsr->async_ring_pages.pdir_dma = tmp->async_ring_pages_pdir_dma;
+
+    return load_dsr(dev);
+}
+
+static const VMStateDescription vmstate_pvrdma_dsr_dma = {
+    .name = "pvrdma-dsr-dma",
+    .pre_save = pvrdma_dsr_dma_pre_save,
+    .post_load = pvrdma_dsr_dma_post_load,
+    .fields = (VMStateField[]) {
+            VMSTATE_UINT64(dma, struct PVRDMAMigTmp),
+            VMSTATE_UINT64(cmd_slot_dma, struct PVRDMAMigTmp),
+            VMSTATE_UINT64(resp_slot_dma, struct PVRDMAMigTmp),
+            VMSTATE_UINT32(async_ring_pages_num_pages, struct PVRDMAMigTmp),
+            VMSTATE_UINT64(async_ring_pages_pdir_dma, struct PVRDMAMigTmp),
+            VMSTATE_UINT32(cq_ring_pages_num_pages, struct PVRDMAMigTmp),
+            VMSTATE_UINT64(cq_ring_pages_pdir_dma, struct PVRDMAMigTmp),
+            VMSTATE_END_OF_LIST()
+    }
+};
+
+static const VMStateDescription vmstate_pvrdma = {
+    .name = "pvrdma",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+            VMSTATE_PCI_DEVICE(parent_obj, PVRDMADev),
+            VMSTATE_MSIX(parent_obj, PVRDMADev),
+            VMSTATE_WITH_TMP(PVRDMADev,
+                             struct PVRDMAMigTmp,
+                             vmstate_pvrdma_dsr_dma),
+            VMSTATE_END_OF_LIST()
+    }
+};
+
 static void pvrdma_realize(PCIDevice *pdev, Error **errp)
 {
     int rc = 0;
@@ -688,6 +774,7 @@ static void pvrdma_class_init(ObjectClass *klass, void *data)
 
     dc->desc = "RDMA Device";
     dc->props = pvrdma_dev_properties;
+    dc->vmsd = &vmstate_pvrdma;
     set_bit(DEVICE_CATEGORY_NETWORK, dc->categories);
 
     ir->print_statistics = pvrdma_print_statistics;
-- 
2.21.0


