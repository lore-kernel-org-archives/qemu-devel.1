Return-Path: <SRS0=u80H=ZS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FC91C432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 14:14:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3DCC20727
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 14:14:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KLs7laL0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3DCC20727
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55620 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZbbT-0008RU-RX
	for qemu-devel@archiver.kernel.org; Tue, 26 Nov 2019 09:14:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47121)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iZbaB-00078z-Of
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 09:12:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iZbaA-0005lh-BA
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 09:12:47 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e]:38315)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iZbaA-0005lD-5M
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 09:12:46 -0500
Received: by mail-wm1-x32e.google.com with SMTP id z19so3494017wmk.3
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2019 06:12:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=MI8rgCF2zRK6V6XHR4h853R4A2OJBzAcqupbIenPjRs=;
 b=KLs7laL0I+25LPU9dOr7wyMZRU0PxmdkHEJA0wN4PEzwn4FPb960EtFGi0RTlOcIxW
 BUrQRTtgE4//88FrR1JjUey98PFaXxPXplZDxYpWqrai6xQMGhv1A4CoXfs7Xlx2ShMh
 9Txh9M5KE3EcQwp0/qR77wE1mhnmXbMrr3ggm6voB3VOyfZWK/Ba/eVlygLMmr36Y54B
 GonteMGBRsz3Yxn0mX3y4rhMeV5bG2w+yEx1CJDjzIg3ow7B//4TDMo2neaZvbehVvNz
 DyBcKJDMJmqgEqU2vRY4PuxaHsDjrxk5/bAxSKykLsw42zAm/FzpC5TVaWQhICtIXHa8
 WHeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=MI8rgCF2zRK6V6XHR4h853R4A2OJBzAcqupbIenPjRs=;
 b=qeX+7PX9c4RC06lSg4F5A6q2GPcwgs9iMC3/bqNVFWeOuBzfqwAZ0jNWyzhXkZfPi+
 udMByi1oGASguLHiV3AvnOEohjDbsGanSVQAu7vFT88XpTtCE0smQr26aM9Jpn9CLVwf
 MFdtPDZBFTVLAH9w+QNQP+CGeLCklk4wfqIPUHGytimJ5wuuCkpZoKJGVtnP1tlyAmcF
 6RQiC9hW5RxeauuTpxAHXqPBIswIBE46V83xIJduZelMDIifo0vad8bI7gXdqxV0Moqd
 dKEmqACEevenBGKMRI+KusweAc7ohbSiVOMYhNGH5SPRQAkzImTXB7hxIOAu1hIlFzrO
 vIFw==
X-Gm-Message-State: APjAAAV139NUdSQJ1hFk3TVehyhc3kxjIznhtf0OZ4F+qwcYzOwA7/vE
 GF/jdr7loBTz2GBzEmCm/7cNOkl4CFs=
X-Google-Smtp-Source: APXvYqyb7bGiS9bbKZUYZyQ+KdQlzqC989ybsinI6Wt6WVyKY9zgH7fQxVCAgN4Un/0J7Ij9mwT46A==
X-Received: by 2002:a1c:7e82:: with SMTP id z124mr4157000wmc.136.1574777564714; 
 Tue, 26 Nov 2019 06:12:44 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id i127sm3364581wma.35.2019.11.26.06.12.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Nov 2019 06:12:43 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 2/4] hw/arm: versal: Add the CRP as unimplemented
Date: Tue, 26 Nov 2019 14:12:37 +0000
Message-Id: <20191126141239.8219-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191126141239.8219-1-peter.maydell@linaro.org>
References: <20191126141239.8219-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32e
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

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

Add the CRP as unimplemented thus avoiding bus errors when
guests access these registers.

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Luc Michel <luc.michel@greensocs.com>
Message-id: 20191115154734.26449-2-edgar.iglesias@gmail.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/xlnx-versal.h | 3 +++
 hw/arm/xlnx-versal.c         | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/include/hw/arm/xlnx-versal.h b/include/hw/arm/xlnx-versal.h
index 14405c1465d..d844c4ffe47 100644
--- a/include/hw/arm/xlnx-versal.h
+++ b/include/hw/arm/xlnx-versal.h
@@ -119,4 +119,7 @@ typedef struct Versal {
 #define MM_IOU_SCNTRS_SIZE          0x10000
 #define MM_FPD_CRF                  0xfd1a0000U
 #define MM_FPD_CRF_SIZE             0x140000
+
+#define MM_PMC_CRP                  0xf1260000U
+#define MM_PMC_CRP_SIZE             0x10000
 #endif
diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
index 98163eb1aad..8b3d8d85b86 100644
--- a/hw/arm/xlnx-versal.c
+++ b/hw/arm/xlnx-versal.c
@@ -257,6 +257,8 @@ static void versal_unimp(Versal *s)
                         MM_CRL, MM_CRL_SIZE);
     versal_unimp_area(s, "crf", &s->mr_ps,
                         MM_FPD_CRF, MM_FPD_CRF_SIZE);
+    versal_unimp_area(s, "crp", &s->mr_ps,
+                        MM_PMC_CRP, MM_PMC_CRP_SIZE);
     versal_unimp_area(s, "iou-scntr", &s->mr_ps,
                         MM_IOU_SCNTR, MM_IOU_SCNTR_SIZE);
     versal_unimp_area(s, "iou-scntr-seucre", &s->mr_ps,
-- 
2.20.1


