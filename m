Return-Path: <SRS0=S/IU=TU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3E5CC04AAC
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 16:43:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A7BB2171F
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 16:43:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eE858BT9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A7BB2171F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38454 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSlOC-0007Fy-Ou
	for qemu-devel@archiver.kernel.org; Mon, 20 May 2019 12:43:52 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42709)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hSl9B-00031Y-KO
	for qemu-devel@nongnu.org; Mon, 20 May 2019 12:28:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hSl98-0001Fr-2K
	for qemu-devel@nongnu.org; Mon, 20 May 2019 12:28:19 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:51087)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hSl95-0001Em-TV
	for qemu-devel@nongnu.org; Mon, 20 May 2019 12:28:17 -0400
Received: by mail-wm1-x341.google.com with SMTP id f204so15202wme.0
	for <qemu-devel@nongnu.org>; Mon, 20 May 2019 09:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=TQvN/mWAlK741QKpEKQhjF7DDPH0rKnlVOvBsAJinxg=;
	b=eE858BT9oM4qVPLyFxNriaIXSVdrnnIC54UhLvK6faBWTZWEzMUoFiT/poR81eWyS1
	2qpzy4F0kw0P5T8vl+FniHqUywhjV10HmSXj9XdOJUKPWzOjCVbrcDUQmcBAjPvDNA1D
	5SkSTki1k3qBeIxZORGAF5d9j6zOnjdjXyPx4KEzvkBDu+Q5UfnjqYz+Dyk2MjMDP7vw
	tBCEZKgyvS9yEML1uWVG7ANz9kbAYl2dLKepWkwqVrBtAPL5aqI3pwDfIkZEf9Wktr0a
	bvgna8UcEnrj4vzicr7S5pIEuwsqdLcbDCQCwMt7o0XbHRQBR13+KAE92GowwTFK2EpD
	N8QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=TQvN/mWAlK741QKpEKQhjF7DDPH0rKnlVOvBsAJinxg=;
	b=tL2IDb72irExIhKWHVuvdJ1L0eznKIw/j/dzv2HRWeW+NWuKZlcusEQo10TGtbXSJD
	Y2qKuPvwFb5CGSC5ZfmqKBWgVwrCdSZWIZH+eMZyyz45Ya/PEB4omhpj8ibmojyKPxcA
	yYj1CgqDoYZe91BGYYnDwOcLiNNe8e/hWBYRX735k2XwR/49TNeKt5DJ49C1fvmGELjb
	A/J7bdAMhqy8zsCoC0fIsXIPjj6gks7sdtmeVtHXRB1CFbTAOtfyZaxjusDOdosfOLXq
	f2mQAxDSE2Y6NUB8mNxcKtDOYptV4t5PzuazrAGXksZH6pOUfP3H6BKpQDlXHbT0a6EE
	cIVA==
X-Gm-Message-State: APjAAAWA6AO4gJ7KVNsjpCFofrEYbyEqWrOovQ6IHHKTLKb4L+LaYkK5
	JfyPIbyp4dTi9yGU29HmAzTis1ix61c=
X-Google-Smtp-Source: APXvYqxNz0WTaNx/jS6t6EQ7UmhDm2Qf3qYpG3gcnQ2zLevMm4+MWeA6yWlH3PQldKFRuXk2WpjmsA==
X-Received: by 2002:a7b:c549:: with SMTP id j9mr4712wmk.114.1558369694777;
	Mon, 20 May 2019 09:28:14 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id x2sm5830394wrs.39.2019.05.20.09.28.13
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 20 May 2019 09:28:14 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Date: Mon, 20 May 2019 17:28:07 +0100
Message-Id: <20190520162809.2677-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190520162809.2677-1-peter.maydell@linaro.org>
References: <20190520162809.2677-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::341
Subject: [Qemu-devel] [PATCH 2/4] hw/intc/arm_gicv3: GICD_TYPER.SecurityExtn
 is RAZ if GICD_CTLR.DS == 1
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The GICv3 specification says that the GICD_TYPER.SecurityExtn bit
is RAZ if GICD_CTLR.DS is 1. We were incorrectly making it RAZ
if the security extension is unsupported. "Security extension
unsupported" always implies GICD_CTLR.DS == 1, but the guest can
also set DS on a GIC which does support the security extension.
Fix the condition to correctly check the GICD_CTLR.DS bit.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/intc/arm_gicv3_dist.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/hw/intc/arm_gicv3_dist.c b/hw/intc/arm_gicv3_dist.c
index 335386ff3ac..d6ae576110d 100644
--- a/hw/intc/arm_gicv3_dist.c
+++ b/hw/intc/arm_gicv3_dist.c
@@ -378,8 +378,14 @@ static MemTxResult gicd_readl(GICv3State *s, hwaddr offset,
          * ITLinesNumber == (num external irqs / 32) - 1
          */
         int itlinesnumber = ((s->num_irq - GIC_INTERNAL) / 32) - 1;
+        /*
+         * SecurityExtn must be RAZ if GICD_CTLR.DS == 1, and
+         * "security extensions not supported" always implies DS == 1,
+         * so we only need to check the DS bit.
+         */
+        bool sec_extn = !(s->gicd_ctlr & GICD_CTLR_DS);
 
-        *data = (1 << 25) | (1 << 24) | (s->security_extn << 10) |
+        *data = (1 << 25) | (1 << 24) | (sec_extn << 10) |
             (0xf << 19) | itlinesnumber;
         return MEMTX_OK;
     }
-- 
2.20.1


