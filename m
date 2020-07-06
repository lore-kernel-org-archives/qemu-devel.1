Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48F0CC433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 06:18:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C4E020708
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 06:18:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C4E020708
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47820 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsKSV-0001H8-DR
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 02:18:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60522)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1jsKNY-0000hu-6U; Mon, 06 Jul 2020 02:13:24 -0400
Received: from charlie.dont.surf ([128.199.63.193]:58088)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1jsKNU-0000vf-P7; Mon, 06 Jul 2020 02:13:23 -0400
Received: from apples.local (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by charlie.dont.surf (Postfix) with ESMTPSA id 5384DBF84E;
 Mon,  6 Jul 2020 06:13:14 +0000 (UTC)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-block@nongnu.org
Subject: [PATCH v3 06/18] hw/block/nvme: mark fw slot 1 as read-only
Date: Mon,  6 Jul 2020 08:12:51 +0200
Message-Id: <20200706061303.246057-7-its@irrelevant.dk>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200706061303.246057-1-its@irrelevant.dk>
References: <20200706061303.246057-1-its@irrelevant.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=128.199.63.193; envelope-from=its@irrelevant.dk;
 helo=charlie.dont.surf
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/06 02:13:11
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Dmitry Fomichev <dmitry.fomichev@wdc.com>,
 Klaus Jensen <k.jensen@samsung.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Klaus Jensen <its@irrelevant.dk>,
 Keith Busch <kbusch@kernel.org>, Javier Gonzalez <javier.gonz@samsung.com>,
 Maxim Levitsky <mlevitsk@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Klaus Jensen <k.jensen@samsung.com>

Mark firmware slot 1 as read-only and only support that slot.

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
Reviewed-by: Dmitry Fomichev <dmitry.fomichev@wdc.com>
---
 hw/block/nvme.c      | 3 ++-
 include/block/nvme.h | 4 ++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index a330ccf91620..b6bc75eb61a2 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -62,6 +62,7 @@
 #define NVME_TEMPERATURE 0x143
 #define NVME_TEMPERATURE_WARNING 0x157
 #define NVME_TEMPERATURE_CRITICAL 0x175
+#define NVME_NUM_FW_SLOTS 1
 
 #define NVME_GUEST_ERR(trace, fmt, ...) \
     do { \
@@ -1666,7 +1667,7 @@ static void nvme_init_ctrl(NvmeCtrl *n, PCIDevice *pci_dev)
      * inconsequential.
      */
     id->acl = 3;
-    id->frmw = 7 << 1;
+    id->frmw = (NVME_NUM_FW_SLOTS << 1) | NVME_FRMW_SLOT1_RO;
     id->lpa = 1 << 0;
 
     /* recommended default value (~70 C) */
diff --git a/include/block/nvme.h b/include/block/nvme.h
index d2c457695b38..d639e8bbee92 100644
--- a/include/block/nvme.h
+++ b/include/block/nvme.h
@@ -842,6 +842,10 @@ enum NvmeIdCtrlOncs {
     NVME_ONCS_TIMESTAMP     = 1 << 6,
 };
 
+enum NvmeIdCtrlFrmw {
+    NVME_FRMW_SLOT1_RO = 1 << 0,
+};
+
 #define NVME_CTRL_SQES_MIN(sqes) ((sqes) & 0xf)
 #define NVME_CTRL_SQES_MAX(sqes) (((sqes) >> 4) & 0xf)
 #define NVME_CTRL_CQES_MIN(cqes) ((cqes) & 0xf)
-- 
2.27.0


