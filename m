Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDB12C5518A
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 07:20:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2372206E9
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 07:20:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2372206E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45378 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jR9fu-0006rK-TA
	for qemu-devel@archiver.kernel.org; Wed, 22 Apr 2020 03:20:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39834)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <its@irrelevant.dk>) id 1jR9WE-0001NL-QC
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 03:10:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <its@irrelevant.dk>) id 1jR9WE-0007zY-Br
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 03:10:02 -0400
Received: from charlie.dont.surf ([128.199.63.193]:60308)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1jR9WB-0007GQ-U9; Wed, 22 Apr 2020 03:10:00 -0400
Received: from apples.local (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by charlie.dont.surf (Postfix) with ESMTPSA id 3B639BFD5F;
 Wed, 22 Apr 2020 07:09:38 +0000 (UTC)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-block@nongnu.org
Subject: [PATCH v3 12/16] nvme: add namespace helpers
Date: Wed, 22 Apr 2020 09:09:23 +0200
Message-Id: <20200422070927.373048-13-its@irrelevant.dk>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200422070927.373048-1-its@irrelevant.dk>
References: <20200422070927.373048-1-its@irrelevant.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=128.199.63.193; envelope-from=its@irrelevant.dk;
 helo=charlie.dont.surf
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/22 02:19:11
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Received-From: 128.199.63.193
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
Cc: Kevin Wolf <kwolf@redhat.com>, Beata Michalska <beata.michalska@linaro.org>,
 Klaus Jensen <k.jensen@samsung.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Klaus Jensen <its@irrelevant.dk>,
 Keith Busch <kbusch@kernel.org>, Javier Gonzalez <javier.gonz@samsung.com>,
 Maxim Levitsky <mlevitsk@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Klaus Jensen <k.jensen@samsung.com>

Introduce some small helpers to make the next patches easier on the eye.

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
Reviewed-by: Keith Busch <kbusch@kernel.org>
---
 hw/block/nvme.c |  3 +--
 hw/block/nvme.h | 17 +++++++++++++++++
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index a036cfed68e3..e3a08c6fb0d1 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -1571,8 +1571,7 @@ static void nvme_realize(PCIDevice *pci_dev, Error **errp)
         id_ns->dps = 0;
         id_ns->lbaf[0].ds = BDRV_SECTOR_BITS;
         id_ns->ncap  = id_ns->nuse = id_ns->nsze =
-            cpu_to_le64(n->ns_size >>
-                id_ns->lbaf[NVME_ID_NS_FLBAS_INDEX(ns->id_ns.flbas)].ds);
+            cpu_to_le64(nvme_ns_nlbas(n, ns));
     }
 }
 
diff --git a/hw/block/nvme.h b/hw/block/nvme.h
index c1bb2a4994b6..f9f2b637bbd0 100644
--- a/hw/block/nvme.h
+++ b/hw/block/nvme.h
@@ -69,6 +69,17 @@ typedef struct NvmeNamespace {
     NvmeIdNs        id_ns;
 } NvmeNamespace;
 
+static inline NvmeLBAF *nvme_ns_lbaf(NvmeNamespace *ns)
+{
+    NvmeIdNs *id_ns = &ns->id_ns;
+    return &id_ns->lbaf[NVME_ID_NS_FLBAS_INDEX(id_ns->flbas)];
+}
+
+static inline uint8_t nvme_ns_lbads(NvmeNamespace *ns)
+{
+    return nvme_ns_lbaf(ns)->ds;
+}
+
 #define TYPE_NVME "nvme"
 #define NVME(obj) \
         OBJECT_CHECK(NvmeCtrl, (obj), TYPE_NVME)
@@ -105,4 +116,10 @@ typedef struct NvmeCtrl {
     NvmeIdCtrl      id_ctrl;
 } NvmeCtrl;
 
+/* calculate the number of LBAs that the namespace can accomodate */
+static inline uint64_t nvme_ns_nlbas(NvmeCtrl *n, NvmeNamespace *ns)
+{
+    return n->ns_size >> nvme_ns_lbads(ns);
+}
+
 #endif /* HW_NVME_H */
-- 
2.26.2


