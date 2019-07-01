Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A97EDC4646D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 00:55:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E86A20659
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 00:55:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t5zliwsZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E86A20659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46700 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hi75D-0000Qu-7x
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 20:55:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48855)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hi42m-0006kp-Rd
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 17:41:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hi42l-0004on-Pf
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 17:41:00 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43714)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hi42l-0004nU-Id
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 17:40:59 -0400
Received: by mail-wr1-f66.google.com with SMTP id p13so15363850wru.10
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2019 14:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=rnHrhKlg4rPjTPEn7YeLUI7OUdliTbLuOiEfOpcbWYc=;
 b=t5zliwsZ5Hwp0hVTa/zzs3QODp6L6rpRk23Kf6qKZb61KucKyX/GI43dj18RRcwGBx
 L3B69Gp87ycvZq9Uhi/5B6t6KXlfEhrCYPeN/B8xlUO6GWSdYjo7IRSCyITpPmVMBXcx
 s/2FMSY4zo8tAWNsLD9P5a6woiggfO2So2y/EOwzTp1N7FYL8W0quimlhiXJYFppqLbt
 B0yjGhmwCoRUJMVknYNctLYGMm0b1LxCeulJxcuMeQLxQ/Cq/AhEombVyN6w+dUy41/c
 bowumHeP7mDPT1gEyRg7N2pwn1qD/Eyjo0gUhrJjiSlTq7NORcnMO5gjfD3TeFh3tS9W
 I7fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=rnHrhKlg4rPjTPEn7YeLUI7OUdliTbLuOiEfOpcbWYc=;
 b=WkbYA1aCj2rwGOap46NWJmmTB3rbUarARw5AS7q2ZQ0BNedgQCoEmi9s6eUSQzSK5g
 ejQmiF2rJBmnW4g7c/+1nhD1m3Gd43OiixJJ/w7QPBjzkuB5wh19gbMS+q4HJxbl4zVq
 QXXDwiAD7ulrBh3DRiHkv/0+WXX7cjsJyPsgAtWgBhCn1GwyYNBJs/ZFN5p74pmwfDA4
 +SqRzpQ7yPFVMtP3EX8mS/1LmnFMQLsyYx6EMBzwp6ADmLq3TSGyFCEDbciLpvbWHUcM
 bEgjzski6eMfdoRZZBxSyAiLyVCrfrF0AxMhaaCFg0/sFTAvBwaiNJg7A6IzaOdHqeAJ
 C95A==
X-Gm-Message-State: APjAAAVDRG2+9XUIhzBq6SciFc59Zdo0U1HHYoxFu2pH6+977EkTVS77
 K0OptQCCh859tl/U1ao3kKD7v3X+NXj8xA==
X-Google-Smtp-Source: APXvYqzSnavuc+sA/3DP4G5/6vuE2nV96qOE/ItV/ZSfDLX8NXq0J5edWyx2UEhIis/aDfYkizou+w==
X-Received: by 2002:adf:f042:: with SMTP id t2mr6306647wro.299.1561999190855; 
 Mon, 01 Jul 2019 09:39:50 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id o6sm26573508wra.27.2019.07.01.09.39.50
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 01 Jul 2019 09:39:50 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon,  1 Jul 2019 17:39:03 +0100
Message-Id: <20190701163943.22313-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190701163943.22313-1-peter.maydell@linaro.org>
References: <20190701163943.22313-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.66
Subject: [Qemu-devel] [PULL 06/46] pci: designware: Update MSI mapping
 unconditionally
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

From: Andrey Smirnov <andrew.smirnov@gmail.com>

Expression to calculate update_msi_mapping in code handling writes to
DESIGNWARE_PCIE_MSI_INTR0_ENABLE is missing an ! operator and should
be:

    !!root->msi.intr[0].enable ^ !!val;

so that MSI mapping is updated when enabled transitions from either
"none" -> "any" or "any" -> "none". Since that register shouldn't be
written to very often, change the code to update MSI mapping
unconditionally instead of trying to fix the update_msi_mapping logic.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/pci-host/designware.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/hw/pci-host/designware.c b/hw/pci-host/designware.c
index 0fdfff57848..ec697c8f9df 100644
--- a/hw/pci-host/designware.c
+++ b/hw/pci-host/designware.c
@@ -297,16 +297,10 @@ static void designware_pcie_root_config_write(PCIDevice *d, uint32_t address,
         root->msi.base |= (uint64_t)val << 32;
         break;
 
-    case DESIGNWARE_PCIE_MSI_INTR0_ENABLE: {
-        const bool update_msi_mapping = !root->msi.intr[0].enable ^ !!val;
-
+    case DESIGNWARE_PCIE_MSI_INTR0_ENABLE:
         root->msi.intr[0].enable = val;
-
-        if (update_msi_mapping) {
-            designware_pcie_root_update_msi_mapping(root);
-        }
+        designware_pcie_root_update_msi_mapping(root);
         break;
-    }
 
     case DESIGNWARE_PCIE_MSI_INTR0_MASK:
         root->msi.intr[0].mask = val;
-- 
2.20.1


