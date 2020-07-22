Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06134C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 08:30:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C881420578
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 08:30:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C881420578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60462 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyA9D-0007gu-1K
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 04:30:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41850)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guang.zeng@intel.com>)
 id 1jyA8c-0007E1-M6
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 04:30:06 -0400
Received: from mga04.intel.com ([192.55.52.120]:9930)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guang.zeng@intel.com>)
 id 1jyA8Z-00077X-TH
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 04:30:06 -0400
IronPort-SDR: p+KtaBWFkbrG0LJbggPHhHpbE8jstNLDgWbHJiuB0L6sc9mZ1YPGC+CkqTrbzFdjqnqw/aysk6
 wnPdtZkImz8A==
X-IronPort-AV: E=McAfee;i="6000,8403,9689"; a="147787773"
X-IronPort-AV: E=Sophos;i="5.75,381,1589266800"; d="scan'208";a="147787773"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jul 2020 01:29:55 -0700
IronPort-SDR: Ak6twXAZcc2jqrZXb6mPeQm8Y/5BDhVbXw2OzjgxMUP14iHblMYpp6IijVGrMHSX9r3cBaW9DK
 9D8XbTHMUBqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,381,1589266800"; d="scan'208";a="432302549"
Received: from arthur-vostro-3668.sh.intel.com ([10.239.159.135])
 by orsmga004.jf.intel.com with ESMTP; 22 Jul 2020 01:29:53 -0700
From: Zeng Guang <guang.zeng@intel.com>
To: jslaby@suse.cz, david@redhat.com, quintela@redhat.com,
 qemu-devel@nongnu.org
Subject: [PATCH] hw/misc/edu: support pci device state migration
Date: Wed, 22 Jul 2020 16:13:23 +0800
Message-Id: <20200722081323.9893-1-guang.zeng@intel.com>
X-Mailer: git-send-email 2.17.1
Received-SPF: pass client-ip=192.55.52.120; envelope-from=guang.zeng@intel.com;
 helo=mga04.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/22 04:29:56
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Zeng Guang <guang.zeng@intel.com>, wei.w.wang@intel.com, chao.gao@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Currently edu device doesn't support live migration. Part of PCI
configuration information would be lost after migration.

PCI device state in source VM:
     Bus  0, device   3, function 0:
     Class 0255: PCI device 1234:11e8
     PCI subsystem 1af4:1100
     IRQ 11, pin A
     BAR0: 32 bit memory at 0xfea00000 [0xfeafffff].
     id ""

PCI device state in destination VM:
     Bus  0, device   3, function 0:
     Class 0255: PCI device 1234:11e8
     PCI subsystem 1af4:1100
     IRQ 0, pin A
     BAR0: 32 bit memory at 0xffffffffffffffff [0x000ffffe].
     id ""

Add VMState for edu device to support migration.

Signed-off-by: Gao Chao <chao.gao@intel.com>
Signed-off-by: Zeng Guang <guang.zeng@intel.com>
Reviewed-by: Wei Wang <wei.w.wang@intel.com>
---
 hw/misc/edu.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/hw/misc/edu.c b/hw/misc/edu.c
index ec617e63f3..3ff2759ee1 100644
--- a/hw/misc/edu.c
+++ b/hw/misc/edu.c
@@ -27,6 +27,7 @@
 #include "hw/pci/pci.h"
 #include "hw/hw.h"
 #include "hw/pci/msi.h"
+#include "migration/vmstate.h"
 #include "qemu/timer.h"
 #include "qemu/main-loop.h" /* iothread mutex */
 #include "qemu/module.h"
@@ -405,6 +406,16 @@ static void edu_instance_init(Object *obj)
                                    &edu->dma_mask, OBJ_PROP_FLAG_READWRITE);
 }
 
+static const VMStateDescription vmstate_edu = {
+    .name = "edu",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_PCI_DEVICE(pdev, EduState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 static void edu_class_init(ObjectClass *class, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(class);
@@ -415,6 +426,7 @@ static void edu_class_init(ObjectClass *class, void *data)
     k->vendor_id = PCI_VENDOR_ID_QEMU;
     k->device_id = 0x11e8;
     k->revision = 0x10;
+    dc->vmsd = &vmstate_edu;
     k->class_id = PCI_CLASS_OTHERS;
     set_bit(DEVICE_CATEGORY_MISC, dc->categories);
 }
-- 
2.17.1


