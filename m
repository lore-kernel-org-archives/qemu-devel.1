Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4504C433E1
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 19:08:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0D472067B
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 19:08:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0D472067B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35672 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jijbX-0003HK-Qq
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 15:08:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44684)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1jijXf-0006OR-82; Tue, 09 Jun 2020 15:04:11 -0400
Received: from charlie.dont.surf ([128.199.63.193]:40286)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1jijXd-0006iU-TD; Tue, 09 Jun 2020 15:04:10 -0400
Received: from apples.local (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by charlie.dont.surf (Postfix) with ESMTPSA id 49AC3BF8E0;
 Tue,  9 Jun 2020 19:03:47 +0000 (UTC)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-block@nongnu.org
Subject: [PATCH v7 13/22] hw/block/nvme: add namespace helpers
Date: Tue,  9 Jun 2020 21:03:24 +0200
Message-Id: <20200609190333.59390-14-its@irrelevant.dk>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200609190333.59390-1-its@irrelevant.dk>
References: <20200609190333.59390-1-its@irrelevant.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=128.199.63.193; envelope-from=its@irrelevant.dk;
 helo=charlie.dont.surf
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 14:38:46
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, Klaus Jensen <k.jensen@samsung.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Klaus Jensen <its@irrelevant.dk>, Keith Busch <kbusch@kernel.org>,
 Javier Gonzalez <javier.gonz@samsung.com>,
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
Message-Id: <20200514044611.734782-15-its@irrelevant.dk>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 hw/block/nvme.c |  3 +--
 hw/block/nvme.h | 17 +++++++++++++++++
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 87f1f0d0d1a1..3f3db17231b3 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -1573,8 +1573,7 @@ static void nvme_realize(PCIDevice *pci_dev, Error **errp)
         id_ns->dps = 0;
         id_ns->lbaf[0].ds = BDRV_SECTOR_BITS;
         id_ns->ncap  = id_ns->nuse = id_ns->nsze =
-            cpu_to_le64(n->ns_size >>
-                id_ns->lbaf[NVME_ID_NS_FLBAS_INDEX(ns->id_ns.flbas)].ds);
+            cpu_to_le64(nvme_ns_nlbas(n, ns));
     }
 }
 
diff --git a/hw/block/nvme.h b/hw/block/nvme.h
index cedc8022dbb3..61dd9b23b81d 100644
--- a/hw/block/nvme.h
+++ b/hw/block/nvme.h
@@ -61,6 +61,17 @@ typedef struct NvmeNamespace {
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
@@ -97,4 +108,10 @@ typedef struct NvmeCtrl {
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
2.27.0


