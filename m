Return-Path: <SRS0=IrLN=YF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9DAFC10F14
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Oct 2019 09:49:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 802B2206A1
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Oct 2019 09:49:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 802B2206A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59884 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJE1H-00017m-NC
	for qemu-devel@archiver.kernel.org; Sat, 12 Oct 2019 05:49:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33043)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maozhongyi@cmss.chinamobile.com>) id 1iJDwY-0005VX-RM
 for qemu-devel@nongnu.org; Sat, 12 Oct 2019 05:44:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <maozhongyi@cmss.chinamobile.com>) id 1iJDwX-0003ZK-OH
 for qemu-devel@nongnu.org; Sat, 12 Oct 2019 05:44:10 -0400
Received: from cmccmta2.chinamobile.com ([221.176.66.80]:3533)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <maozhongyi@cmss.chinamobile.com>)
 id 1iJDwX-0003Xy-48; Sat, 12 Oct 2019 05:44:09 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.13]) by
 rmmx-syy-dmz-app05-12005 (RichMail) with SMTP id 2ee55da1a04ed9c-4edaa;
 Sat, 12 Oct 2019 17:43:42 +0800 (CST)
X-RM-TRANSID: 2ee55da1a04ed9c-4edaa
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[112.25.154.149])
 by rmsmtp-syy-appsvr07-12007 (RichMail) with SMTP id 2ee75da1a0478f4-669b4;
 Sat, 12 Oct 2019 17:43:42 +0800 (CST)
X-RM-TRANSID: 2ee75da1a0478f4-669b4
From: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	qemu-ppc@nongnu.org
Subject: [PATCH 1/2] arm/smmuv3: use helper to be more easier to understand
 when using abstract QOM parent functions.
Date: Sat, 12 Oct 2019 17:43:22 +0800
Message-Id: <20191012094323.234788-2-maozhongyi@cmss.chinamobile.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191012094323.234788-1-maozhongyi@cmss.chinamobile.com>
References: <20191012094323.234788-1-maozhongyi@cmss.chinamobile.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 221.176.66.80
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
Cc: eric.auger@redhat.com, f4bug@amsat.org,
 Mao Zhongyi <maozhongyi@cmss.chinamobile.com>, peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Philippe introduced a series of helpers to make the
device class_init() easier to understand when a
device class change the parent hooks, device smmuv3
missed helper, so convert it.

Cc: eric.auger@redhat.com
Cc: peter.maydell@linaro.org
Cc: f4bug@amsat.org
Signed-off-by: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
---
 hw/arm/smmuv3.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index e2fbb8357e..65b6b158e5 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -1465,8 +1465,7 @@ static void smmuv3_class_init(ObjectClass *klass, void *data)
 
     dc->vmsd = &vmstate_smmuv3;
     device_class_set_parent_reset(dc, smmu_reset, &c->parent_reset);
-    c->parent_realize = dc->realize;
-    dc->realize = smmu_realize;
+    device_class_set_parent_realize(dc, smmu_realize, &c->parent_realize);
 }
 
 static int smmuv3_notify_flag_changed(IOMMUMemoryRegion *iommu,
-- 
2.17.1




