Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6B89C433E1
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 16:51:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83323206DB
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 16:51:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WtvTFL1K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83323206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49232 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhFYn-0002yP-O1
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 12:51:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40438)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jhFXp-000180-LM
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 12:50:13 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430]:32967)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jhFXo-0001dT-E6
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 12:50:13 -0400
Received: by mail-wr1-x430.google.com with SMTP id l11so10469826wru.0
 for <qemu-devel@nongnu.org>; Fri, 05 Jun 2020 09:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=SsjpCPPutYD8HFqBNI+vGzX6m++b/a/qj8ptKWmovV8=;
 b=WtvTFL1KSdhSSHb9NBS2mSFjIGN89CUxsVCh22r+UJ11C/NkjqqHvn6dug11+ksZPR
 7D2UPzg50XPbEA/8VMwDtfbgXcVctkub4PTa4WQU+nVKqqlo7iOmssRBvWsTnFmeXPI2
 L2k3ofa71PKW//RjB7Kx/K5fj1r1TEMnpmeLUWNDu6mB481IAj0uKSdvx6s9DEjcYBJ3
 lN4JfEubyGFOn3DNaHWpiWVTaaA5RFApUBHBY181ta4H2ETU09GK4FQY6QyjKkndRWGe
 EryzvqQzIh3fjhhhA1vqmzb5rxpHGGSSlcvyiZfEyqDRo2EOo/6sgKeOAN7yof9F442i
 Jfog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=SsjpCPPutYD8HFqBNI+vGzX6m++b/a/qj8ptKWmovV8=;
 b=mRv237nUuS4NiU/rzAvgQ+9bi/2mFBID78G4H1+096diGWtyTWHL6QPTtdE548xmF/
 QfdHJySGgqCTiu5b/nOA+MAHCl6u7i4kRCzaOtDFL0aSqQnndwhhr08ENguj7rNCSdYq
 IN7Te9YeuaX86WYay9N0mE2dQSXfnPOulN6a5FGfQGvt538IViYoNLIHP/soH3o0iEr2
 yFamgH7IjIO7TXrD15i6MDCfS7zz5i7KTPQSOOMFukDAcQF7TUdDNn/gqP4ALU+sZO/J
 5kJUY4KWH62wtDV7peNKvtIf4BlLA4+qMIZLhrysliU4qrQ4znTxic+KC8Jg1nQE0QqK
 eRRA==
X-Gm-Message-State: AOAM530RYSoBzpshmnUN0dFbnl88PlWi0pVRC1VJxaf4BxuVqYbn852i
 KI8wbgqMXR0img4C2qIQ5AKrQkCraSsEAg==
X-Google-Smtp-Source: ABdhPJzJ7tu9NzDvuKxHPXTQDvjy11J0eVf91mGkAOegTog1sYRJt/lYFvig/E3BWvLb0m/4nIpR8A==
X-Received: by 2002:adf:e3c4:: with SMTP id k4mr10328414wrm.262.1591375810906; 
 Fri, 05 Jun 2020 09:50:10 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id c140sm12272724wmd.18.2020.06.05.09.50.10
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jun 2020 09:50:10 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 01/29] hw/ssi/imx_spi: changed while statement to prevent
 underflow
Date: Fri,  5 Jun 2020 17:49:39 +0100
Message-Id: <20200605165007.12095-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200605165007.12095-1-peter.maydell@linaro.org>
References: <20200605165007.12095-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x430.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Eden Mikitas <e.mikitas@gmail.com>

The while statement in question only checked if tx_burst is not 0.
tx_burst is a signed int, which is assigned the value put by the
guest driver in ECSPI_CONREG. The burst length can be anywhere
between 1 and 4096, and since tx_burst is always decremented by 8
it could possibly underflow, causing an infinite loop.

Signed-off-by: Eden Mikitas <e.mikitas@gmail.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/ssi/imx_spi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/ssi/imx_spi.c b/hw/ssi/imx_spi.c
index 2dd9a631e12..6fef5c79588 100644
--- a/hw/ssi/imx_spi.c
+++ b/hw/ssi/imx_spi.c
@@ -182,7 +182,7 @@ static void imx_spi_flush_txfifo(IMXSPIState *s)
 
         rx = 0;
 
-        while (tx_burst) {
+        while (tx_burst > 0) {
             uint8_t byte = tx & 0xff;
 
             DPRINTF("writing 0x%02x\n", (uint32_t)byte);
-- 
2.20.1


