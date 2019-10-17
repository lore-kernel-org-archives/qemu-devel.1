Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4C73ECE58E
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 14:06:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71AFA2054F
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 14:06:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lRqagTtB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71AFA2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48744 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL6Pm-0007mJ-Oo
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 10:06:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36115)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iL5q3-0006i3-81
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:29:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iL5q2-0002Ya-0Q
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:29:11 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:54153)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iL5q1-0002YN-Qr
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:29:09 -0400
Received: by mail-wm1-x343.google.com with SMTP id i16so2577612wmd.3
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 06:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=e2Ij4RQysVJcdo+i7dvWapjtIXrPIwRATrfBcMlAk+I=;
 b=lRqagTtBFoxIc0/CA2ni0W+tWpGc03zj4lnjzYXwmZIFfPoTGUm8FFp06jsLNojK/Q
 yRHK6ku3OZbhF6slx4KWmzBUfV6nCybuJja64uhSI08wFFgdGbgJfJUZgPQEcsKmoIVf
 va+rqB4fve1TjOL5F4rvMJIupVfof+hbCd8f+5e8AR+bTuxrTvEv40+PsCO6efrMuOXC
 x+mLy5PsTShOIsGL8Iadq67hq9eU2UtFFzMknfEmbnQnPgQTcYqqiauxd+3g1glptDTy
 tPSXH+S6WpqeY26qx0mtGlKS36raKvz1fRYoapdAcrC/Rz+CyklEVuvdsEqBBdIMF6R3
 daPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=e2Ij4RQysVJcdo+i7dvWapjtIXrPIwRATrfBcMlAk+I=;
 b=ulijadOVMq12mu1LOuW/eoUVkQpNKisIl1liKyosFk1MTR+g1tbPlQVJAYKZN3vijR
 AD6J42zhir+1PzrB9U/KRyyLR5/utWhUcQDaefssomWRn301L39wkYbDZ2hJr6HmmcVi
 QdBOJnavn4JcWK1Qv678DPvGDmLs408VE5p7dfoUb8spxYZ6UEoNgNqFkcjB1rzqHowL
 a8mhNJ5wxl0U/xDwS73YVp9GHlTtRwV6aXSFVd8+FSGNovRXhrZtYXAIO5IrpTp/jtmi
 FzspkJdtdh3gVFU68LZh5R5gPSuiATDhpYtgFQlLRGJmFTUgK+vch+fF4LNzjlB6YNBL
 kuSg==
X-Gm-Message-State: APjAAAUOydS7kyEqAXPVUwm03oHrkKlKdibg95cPH/a2nFStsK8rq3k+
 AYdQ88v7Ls88qh9lAJgM6LEqNS4dKsw0Gw==
X-Google-Smtp-Source: APXvYqxaiNtqgJ4gau3o63qLFSQ0iE4D9wukDchX0Z3Vp8GHDCOmECJfBTppXJX9jTp6YzlBWQeHjA==
X-Received: by 2002:a1c:5408:: with SMTP id i8mr2908630wmb.149.1571318948583; 
 Thu, 17 Oct 2019 06:29:08 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id n15sm2703392wrw.47.2019.10.17.06.29.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2019 06:29:08 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/8] hw/timer/puv3_ost.c: Switch to transaction-based ptimer
 API
Date: Thu, 17 Oct 2019 14:28:58 +0100
Message-Id: <20191017132905.5604-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191017132905.5604-1-peter.maydell@linaro.org>
References: <20191017132905.5604-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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
Cc: Thomas Huth <huth@tuxfamily.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Michael Walle <michael@walle.cc>, Guan Xuetao <gxt@mprc.pku.edu.cn>,
 Magnus Damm <magnus.damm@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Switch the puv3_ost code away from bottom-half based ptimers to the
new transaction-based ptimer API.  This just requires adding
begin/commit calls around the various places that modify the ptimer
state, and using the new ptimer_init() function to create the timer.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/timer/puv3_ost.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/hw/timer/puv3_ost.c b/hw/timer/puv3_ost.c
index 0898da5ce97..697519593bb 100644
--- a/hw/timer/puv3_ost.c
+++ b/hw/timer/puv3_ost.c
@@ -13,7 +13,6 @@
 #include "hw/sysbus.h"
 #include "hw/irq.h"
 #include "hw/ptimer.h"
-#include "qemu/main-loop.h"
 #include "qemu/module.h"
 
 #undef DEBUG_PUV3
@@ -27,7 +26,6 @@ typedef struct PUV3OSTState {
     SysBusDevice parent_obj;
 
     MemoryRegion iomem;
-    QEMUBH *bh;
     qemu_irq irq;
     ptimer_state *ptimer;
 
@@ -68,6 +66,7 @@ static void puv3_ost_write(void *opaque, hwaddr offset,
     DPRINTF("offset 0x%x, value 0x%x\n", offset, value);
     switch (offset) {
     case 0x00: /* Match Register 0 */
+        ptimer_transaction_begin(s->ptimer);
         s->reg_OSMR0 = value;
         if (s->reg_OSMR0 > s->reg_OSCR) {
             ptimer_set_count(s->ptimer, s->reg_OSMR0 - s->reg_OSCR);
@@ -76,6 +75,7 @@ static void puv3_ost_write(void *opaque, hwaddr offset,
                     (0xffffffff - s->reg_OSCR));
         }
         ptimer_run(s->ptimer, 2);
+        ptimer_transaction_commit(s->ptimer);
         break;
     case 0x14: /* Status Register */
         assert(value == 0);
@@ -128,9 +128,10 @@ static void puv3_ost_realize(DeviceState *dev, Error **errp)
 
     sysbus_init_irq(sbd, &s->irq);
 
-    s->bh = qemu_bh_new(puv3_ost_tick, s);
-    s->ptimer = ptimer_init_with_bh(s->bh, PTIMER_POLICY_DEFAULT);
+    s->ptimer = ptimer_init(puv3_ost_tick, s, PTIMER_POLICY_DEFAULT);
+    ptimer_transaction_begin(s->ptimer);
     ptimer_set_freq(s->ptimer, 50 * 1000 * 1000);
+    ptimer_transaction_commit(s->ptimer);
 
     memory_region_init_io(&s->iomem, OBJECT(s), &puv3_ost_ops, s, "puv3_ost",
             PUV3_REGS_OFFSET);
-- 
2.20.1


