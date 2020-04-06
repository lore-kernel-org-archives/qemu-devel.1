Return-Path: <SRS0=By5p=5W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF1CBC2BA19
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 10:17:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2680F2054F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 10:17:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y3bcytVC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2680F2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58118 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLOoO-0005fa-0o
	for qemu-devel@archiver.kernel.org; Mon, 06 Apr 2020 06:17:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50175)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jLOjt-0006pm-7i
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 06:12:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jLOjo-0002q8-9V
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 06:12:21 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432]:46628)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jLOjo-0002oZ-3V
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 06:12:16 -0400
Received: by mail-wr1-x432.google.com with SMTP id j17so16628369wru.13
 for <qemu-devel@nongnu.org>; Mon, 06 Apr 2020 03:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=qxOK+Eo/Etx7ayjTtq9TRrRBbpvwnNBBT4MlN6HQPlU=;
 b=y3bcytVC/174eOXONPV+l9m74EB/h9dWnq+RcP5Gq4svgEa4yvZENRNu/CCTyHpqjh
 DiPQFYwtHNRvAgcmw7o9sgLhhfmJmQxuIEETimfx8liCuH4yU0l0S9Zlwa4vW3W5BDL7
 9ANCztwfeqlL928mCq5tvufzYFBOfTb2mTxRmnCVZD7kXF5O6Chjvfo7QCpM56Anpb8A
 +Iy9iSqxRUh5WYZjd35ygReCbfObXcSnruPD+zn39jZly7bHy5n1OhxT62VsbxJfkvw+
 J4f5cAVmKCiZkSBrA7JS6QfXIhvMO7raOCuz4DuwCXTNbkjlKIXdTFrQWMbk2fFKo6ru
 hu0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=qxOK+Eo/Etx7ayjTtq9TRrRBbpvwnNBBT4MlN6HQPlU=;
 b=YUHpwmNYpt5gksw2n50it224oAYnfrX4uCZ1yXAdJ8gPd76ydvxVqZ7TXGhdHPCxM7
 Zk6p5rM3zF6d9OO74xyGusWDRpYlBZiZP/BRC0MgmamPUa9RcP8DCl2EFJvmJ3jm+v7B
 nd39IMKfCBqAKp/EXNP6WFJ7fR8CGx9AmqIKQuAcwHvq/TGv6PcPu4YNB/ijR9JPtJI7
 +a+vnKywSL0Qa1TRxm1eknjDZtdARUNtBfIKoZUD+UJ4LzKnfo3lAKlPGy6ttLH5yrtI
 UR0rBsyMuoMukSwLC8SM5rgoOI/bPRghUGDheUPvYNb+ZfZh5lyipMImz3aCXAon5S2+
 Wijw==
X-Gm-Message-State: AGi0PuZZk5sdIafqoWJzvNavKgETApVD2XmRlMIQTQW68yTvu9fPHItK
 id/JMfx4O+RWwgpY+pegNTE5acECUdnOGA==
X-Google-Smtp-Source: APiQypIC51+H3M0n9O6MAvRH1hvVxsz2mG+J+8e2J5pS4EhvfrGoffyIE6ZavMjDPf0VJD12nhE0oQ==
X-Received: by 2002:a5d:5141:: with SMTP id u1mr22116282wrt.146.1586167934779; 
 Mon, 06 Apr 2020 03:12:14 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id f187sm25163765wme.9.2020.04.06.03.12.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2020 03:12:14 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 07/11] dma/xlnx-zdma: Remove comment
Date: Mon,  6 Apr 2020 11:12:01 +0100
Message-Id: <20200406101205.23027-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200406101205.23027-1-peter.maydell@linaro.org>
References: <20200406101205.23027-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::432
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

Remove comment.

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Francisco Iglesias <frasse.iglesias@gmail.com>
Message-id: 20200402134721.27863-2-edgar.iglesias@gmail.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/dma/xlnx-zdma.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/dma/xlnx-zdma.c b/hw/dma/xlnx-zdma.c
index 2d9c0a0d5e1..a6c5b2304a8 100644
--- a/hw/dma/xlnx-zdma.c
+++ b/hw/dma/xlnx-zdma.c
@@ -511,7 +511,6 @@ static void zdma_process_descr(XlnxZDMA *s)
         zdma_src_done(s);
     }
 
-    /* Load next descriptor.  */
     if (ptype == PT_REG || src_cmd == CMD_STOP) {
         ARRAY_FIELD_DP32(s->regs, ZDMA_CH_CTRL2, EN, 0);
         zdma_set_state(s, DISABLED);
-- 
2.20.1


