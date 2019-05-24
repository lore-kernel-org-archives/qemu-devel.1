Return-Path: <SRS0=oHhb=TY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6CA0C072B5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 12:44:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77DAF20851
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 12:44:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MRsWERed"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77DAF20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54122 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hU9Yb-00088P-PQ
	for qemu-devel@archiver.kernel.org; Fri, 24 May 2019 08:44:21 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52679)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hU9XD-0007Iw-Dd
	for qemu-devel@nongnu.org; Fri, 24 May 2019 08:42:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hU9XC-0006MF-EK
	for qemu-devel@nongnu.org; Fri, 24 May 2019 08:42:55 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:41693)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hU9XC-0006LQ-7m
	for qemu-devel@nongnu.org; Fri, 24 May 2019 08:42:54 -0400
Received: by mail-wr1-x442.google.com with SMTP id u16so5987965wrn.8
	for <qemu-devel@nongnu.org>; Fri, 24 May 2019 05:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=FTfH2Bmgd6/uhQsHPCYg8B8J/1/AvPfs4Sq0ZaLk7QE=;
	b=MRsWERedJmlAtH7x9EnKJlj24vxFVZ4aWLWYqrZf39ujjK9k+NR56LU5Gde2Ti/pXi
	8Z8mWzrKhrd7ZPeWEriV/cA9v2wUGvzu5OYMFe0UkNMYVLEcN8eaZZ4svNKBJyVTeUE8
	eQmZgEeH7gp6+ld6It/4mSjT83JNJuH434UOEAoEBnK5PNJ24JSWrJ+SQ0JBXfB58Zna
	B4aClMXCJcw2ffkxpiJunqUPhLilOtBxqZ8SepEume1s0soSmvG6AbTlHI9nC58szNZR
	gZZ+Z3PzrkbvMEL+hPyL7PCB/6c2GspGbzvX+woktX+hXEbYqCaMPgz/hRDCayVhjTSP
	8IHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=FTfH2Bmgd6/uhQsHPCYg8B8J/1/AvPfs4Sq0ZaLk7QE=;
	b=NAoida1Gp8wD3N90AjIx901s9OgzyOlV1je9PZ+2B2Az55QGMsN5n+Netndp6Y0lqb
	OWpY4xIV3O0FCehg8GA0Pm+b77aF36mHtlG3YnVsa0PBRupdAXW8h1X43xhJEbBJa4bt
	bRmotfiEj0voUR8zbo7ePU/G2nm40/jia1n0zLgpz+9vutglFgZSUmiilgPGfMG5Mo9E
	uUZ9LNVzCRSeb2ly6KgKOXXMSXwVm/Br6ZFkpFeTxkgTf6IuIMiVLt+NarHfowf3ky2o
	6WKFW1QXeXNXyC8TQXEuQ7UrUiHmy3gkgUE0ulp0neaI4TXf3sVDuPdBSVCmQOQyz+EX
	1tgQ==
X-Gm-Message-State: APjAAAVIbTsuznQXMzGDc0XTAR+iQ7hx1tQAtFx8ius462/MIcjbDaEu
	irVnTjKvmGFfkWMdSlVWixi4vA==
X-Google-Smtp-Source: APXvYqxvGqiqXw29BUqTbkswqQN4wZChO/PbQV5RP8kKI299Cb2ap+htnTOqjjOhGlsXNgCDOA00WA==
X-Received: by 2002:a5d:4d92:: with SMTP id b18mr63645779wru.212.1558701773214;
	Fri, 24 May 2019 05:42:53 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id t12sm2969854wro.2.2019.05.24.05.42.52
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 24 May 2019 05:42:52 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Date: Fri, 24 May 2019 13:42:48 +0100
Message-Id: <20190524124248.28394-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190524124248.28394-1-peter.maydell@linaro.org>
References: <20190524124248.28394-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: [Qemu-devel] [PATCH v2 2/2] hw/intc/arm_gicv3:
 GICD_TYPER.SecurityExtn is RAZ if GICD_CTLR.DS == 1
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
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
index e6fe4905fd3..b65f56f9035 100644
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


