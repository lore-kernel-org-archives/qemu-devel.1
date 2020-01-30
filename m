Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46B3DC2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 16:24:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1520F206D5
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 16:24:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F+unshtH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1520F206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35374 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixCbn-0001r1-7Q
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 11:23:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43289)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1ixCU8-0005nJ-0h
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 11:16:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1ixCU6-00038A-CF
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 11:16:03 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:36101)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1ixCU6-00037D-5Q
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 11:16:02 -0500
Received: by mail-wr1-x443.google.com with SMTP id z3so4816357wru.3
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2020 08:16:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=FudFrPLs/FW28wgW4YGWYEJ4ys1uBPtYGVZ/qV1IY/0=;
 b=F+unshtH700rv40WL/rt6Kk1EVMPrfMuA2LZV+2W3UYilLAG7Oc4xZkOXSB1HmvxQz
 QEXu6gqBaSZ4cp0Z5l2tPHrE2Tkhtv/qqzpowWZTeWdpbrcROtz9KM/WBdaqBW09nB+K
 Xg8fHXWKpWxqLJXZtUcmPE+IJfIm8voLaguOGvTxe49jP2EMmcqpERCzrIWw9YyG6JMU
 crXD5qmBC/URL4kO7UPQu/ZnGB/PoScPjQuc8//Vf2JiorKJb977AOrDJFp5pwkR5VZ3
 A3Vvn6Qv1CLY6a3/XBir/RRFp/3PNYcafWHDpQNnI6UNEoOVfvOeTtxWl5DV3hbxQxrz
 4VkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=FudFrPLs/FW28wgW4YGWYEJ4ys1uBPtYGVZ/qV1IY/0=;
 b=YgX/esXk8zx42FvF6DrWhin/kkWy1HBHtpPW70sjFDVAEkvSJCBXWbm9Y9OepzYrwm
 BHZKW1XDAfAm+RS/FiWEUETiQwrNYKm2GjPY6PcwYRAuAfSnHAydAS5YYvis7dU+FF4w
 J5UWYi+OkOnuOM3WUg5v8F5QnrjBMz7FA2nQ2OoW5xh0sA2T+eajaWyuuVxefqUa5/D+
 W/+vyBmd9zhb0jo5bb3lyhe4lvAWF9EkAvvVBoMqk4sU24Fgu6iJkJ314LmdcnQmJH53
 /SmQi2RZsjP0p077rAxIe2FIh0JPHUK9j6rkteknihv+YDgxvwJFk+EnZkmOHYZpm5Sy
 3zAw==
X-Gm-Message-State: APjAAAWEpy0oalTT7Y4T5G1+fXKsBsQ6FqSAriT+zVxBpDnfPmDdZBzw
 Fgz632uN1V+PUXFgiPy14V7z88k5g2RFlA==
X-Google-Smtp-Source: APXvYqyILcGWB3J8Izj0T7GaH0f4bzA9t1BC7YsWMz1Eeabpk/ttdMjuhkuq0csvcrmZBQT8Aa0f/Q==
X-Received: by 2002:adf:f484:: with SMTP id l4mr6759498wro.207.1580400960970; 
 Thu, 30 Jan 2020 08:16:00 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id a22sm6994442wmd.20.2020.01.30.08.16.00
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jan 2020 08:16:00 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 20/26] hw/intc/arm_gicv3_kvm: Stop wrongly programming
 GICR_PENDBASER.PTZ bit
Date: Thu, 30 Jan 2020 16:15:27 +0000
Message-Id: <20200130161533.8180-21-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200130161533.8180-1-peter.maydell@linaro.org>
References: <20200130161533.8180-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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

From: Zenghui Yu <yuzenghui@huawei.com>

If LPIs are disabled, KVM will just ignore the GICR_PENDBASER.PTZ bit when
restoring GICR_CTLR.  Setting PTZ here makes littlt sense in "reduce GIC
initialization time".

And what's worse, PTZ is generally programmed by guest to indicate to the
Redistributor whether the LPI Pending table is zero when enabling LPIs.
If migration is triggered when the PTZ has just been cleared by guest (and
before enabling LPIs), we will see PTZ==1 on the destination side, which
is not as expected.  Let's just drop this hackish userspace behavior.

Also take this chance to refine the comment a bit.

Fixes: 367b9f527bec ("hw/intc/arm_gicv3_kvm: Implement get/put functions")
Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
Message-id: 20200119133051.642-1-yuzenghui@huawei.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/intc/arm_gicv3_kvm.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/hw/intc/arm_gicv3_kvm.c b/hw/intc/arm_gicv3_kvm.c
index 9c7f4ab8711..49304ca589d 100644
--- a/hw/intc/arm_gicv3_kvm.c
+++ b/hw/intc/arm_gicv3_kvm.c
@@ -336,7 +336,10 @@ static void kvm_arm_gicv3_put(GICv3State *s)
     kvm_gicd_access(s, GICD_CTLR, &reg, true);
 
     if (redist_typer & GICR_TYPER_PLPIS) {
-        /* Set base addresses before LPIs are enabled by GICR_CTLR write */
+        /*
+         * Restore base addresses before LPIs are potentially enabled by
+         * GICR_CTLR write
+         */
         for (ncpu = 0; ncpu < s->num_cpu; ncpu++) {
             GICv3CPUState *c = &s->cpu[ncpu];
 
@@ -347,12 +350,6 @@ static void kvm_arm_gicv3_put(GICv3State *s)
             kvm_gicr_access(s, GICR_PROPBASER + 4, ncpu, &regh, true);
 
             reg64 = c->gicr_pendbaser;
-            if (!(c->gicr_ctlr & GICR_CTLR_ENABLE_LPIS)) {
-                /* Setting PTZ is advised if LPIs are disabled, to reduce
-                 * GIC initialization time.
-                 */
-                reg64 |= GICR_PENDBASER_PTZ;
-            }
             regl = (uint32_t)reg64;
             kvm_gicr_access(s, GICR_PENDBASER, ncpu, &regl, true);
             regh = (uint32_t)(reg64 >> 32);
-- 
2.20.1


