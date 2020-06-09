Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D2F7C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 19:15:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 660A0206D5
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 19:15:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 660A0206D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34292 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jijj1-00067D-5U
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 15:15:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44630)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1jijXK-00063R-Cp; Tue, 09 Jun 2020 15:03:50 -0400
Received: from charlie.dont.surf ([128.199.63.193]:40256)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1jijXI-0006hy-1D; Tue, 09 Jun 2020 15:03:49 -0400
Received: from apples.local (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by charlie.dont.surf (Postfix) with ESMTPSA id 5F2E1BF7E0;
 Tue,  9 Jun 2020 19:03:45 +0000 (UTC)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-block@nongnu.org
Subject: [PATCH v7 09/22] hw/block/nvme: remove redundant cmbloc/cmbsz members
Date: Tue,  9 Jun 2020 21:03:20 +0200
Message-Id: <20200609190333.59390-10-its@irrelevant.dk>
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

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
Reviewed-by: Keith Busch <kbusch@kernel.org>
Message-Id: <20200514044611.734782-11-its@irrelevant.dk>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 hw/block/nvme.c | 7 ++-----
 hw/block/nvme.h | 2 --
 2 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 1c1d2f8b7768..61447220a873 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -76,7 +76,7 @@ static bool nvme_addr_is_cmb(NvmeCtrl *n, hwaddr addr)
 
 static void nvme_addr_read(NvmeCtrl *n, hwaddr addr, void *buf, int size)
 {
-    if (n->cmbsz && nvme_addr_is_cmb(n, addr)) {
+    if (n->bar.cmbsz && nvme_addr_is_cmb(n, addr)) {
         memcpy(buf, (void *)&n->cmbuf[addr - n->ctrl_mem.addr], size);
         return;
     }
@@ -170,7 +170,7 @@ static uint16_t nvme_map_prp(QEMUSGList *qsg, QEMUIOVector *iov, uint64_t prp1,
     if (unlikely(!prp1)) {
         trace_pci_nvme_err_invalid_prp();
         return NVME_INVALID_FIELD | NVME_DNR;
-    } else if (n->cmbsz && prp1 >= n->ctrl_mem.addr &&
+    } else if (n->bar.cmbsz && prp1 >= n->ctrl_mem.addr &&
                prp1 < n->ctrl_mem.addr + int128_get64(n->ctrl_mem.size)) {
         qsg->nsg = 0;
         qemu_iovec_init(iov, num_prps);
@@ -1485,9 +1485,6 @@ static void nvme_realize(PCIDevice *pci_dev, Error **errp)
         NVME_CMBSZ_SET_SZU(n->bar.cmbsz, 2); /* MBs */
         NVME_CMBSZ_SET_SZ(n->bar.cmbsz, n->params.cmb_size_mb);
 
-        n->cmbloc = n->bar.cmbloc;
-        n->cmbsz = n->bar.cmbsz;
-
         n->cmbuf = g_malloc0(NVME_CMBSZ_GETSIZE(n->bar.cmbsz));
         memory_region_init_io(&n->ctrl_mem, OBJECT(n), &nvme_cmb_ops, n,
                               "nvme-cmb", NVME_CMBSZ_GETSIZE(n->bar.cmbsz));
diff --git a/hw/block/nvme.h b/hw/block/nvme.h
index 26c38bd913be..cedc8022dbb3 100644
--- a/hw/block/nvme.h
+++ b/hw/block/nvme.h
@@ -82,8 +82,6 @@ typedef struct NvmeCtrl {
     uint32_t    num_namespaces;
     uint32_t    max_q_ents;
     uint64_t    ns_size;
-    uint32_t    cmbsz;
-    uint32_t    cmbloc;
     uint8_t     *cmbuf;
     uint32_t    irq_status;
     uint64_t    host_timestamp;                 /* Timestamp sent by the host */
-- 
2.27.0


