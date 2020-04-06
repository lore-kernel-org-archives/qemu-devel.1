Return-Path: <SRS0=By5p=5W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 963C9C2BA19
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 10:14:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E0CA2051A
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 10:14:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="n8489t6r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E0CA2051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58044 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLOm9-000286-H3
	for qemu-devel@archiver.kernel.org; Mon, 06 Apr 2020 06:14:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50131)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jLOjp-0006kX-Va
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 06:12:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jLOjp-0002rh-2v
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 06:12:17 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336]:55398)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jLOjo-0002q5-Sr
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 06:12:17 -0400
Received: by mail-wm1-x336.google.com with SMTP id r16so14045012wmg.5
 for <qemu-devel@nongnu.org>; Mon, 06 Apr 2020 03:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=WGk0JhktO1LmmcqBkiisXztczdE5FcLoayAA+KbaRqU=;
 b=n8489t6rTifoqv28F8kszo5RbV9peFZKJIrT25zK1vQqjDEtBLdVtxKYejSPD9wLBh
 xj406121Sc7/0tld8CNUAK0ikZDa8ppHGyCKxANbbF/vB+xwXqLL1DOuHW/EunWF+Qyv
 rufRmkqkNZAOwY7y9T+j0f5jnZazptvd2rmhm4MC4sRqfQrwmgYCZpASUU6dfgjmCTNR
 NNKVrcIcPBt+8RXyz5O48upjTBp5OUjY//HxXmJNaGayDWFilvgZjY77L/3mn0XvfKaN
 yombsRFyj8Mv+UbDGmv26gGX/tqS4qPopO2xndyiC7DodC02V+SQZOPU+bKBsFAU8ooW
 B8cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=WGk0JhktO1LmmcqBkiisXztczdE5FcLoayAA+KbaRqU=;
 b=MDCuPGGdBppVRhobn1jVB8I4KO54EOebpZqmqXUWurnfNnnRGvPvRQmYSukp5qN56x
 1QfZlcRacuLNxdySeK0JWtPIExbilxLF8zgYvXnw4IWEBoGMwS93UM3SUIpBSxPHK+Yd
 bDU/eafcbJbQygDKATBRDIFpLW+r9b/ThnLuDumEhiI/sFLk5uOHGQuMv39pphu9XzWI
 eZRxyUDMWWrqVyA6vTVPBTyjlHPGc31J+QHBZ55etYFuAmp+KUThpUK+yFgvAOi1fvsd
 4aIf9NHldGGL/ApB4tkK5AOM0DaWD8W4JUclhSPU92VpBcpTks9JABbsNCP166xWLUXs
 Lx2Q==
X-Gm-Message-State: AGi0PuZ0KyZHM1CQ/6hrF4p++cQvl0h8EkUjzlDCJdkz37UWW9mMLrtl
 craXUAplNaz8pvIprK5s5wQ4fLUvuPifkg==
X-Google-Smtp-Source: APiQypJtKD7/UgTCW48KV5cm05PB3xgGmMb5c91KpttFcWGtDPkONKf/92wkOKL8EsJb12KyWCTiLA==
X-Received: by 2002:a1c:6605:: with SMTP id a5mr21961062wmc.32.1586167935642; 
 Mon, 06 Apr 2020 03:12:15 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id f187sm25163765wme.9.2020.04.06.03.12.14
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2020 03:12:15 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 08/11] dma/xlnx-zdma: Populate DBG0.CMN_BUF_FREE
Date: Mon,  6 Apr 2020 11:12:02 +0100
Message-Id: <20200406101205.23027-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200406101205.23027-1-peter.maydell@linaro.org>
References: <20200406101205.23027-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::336
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

Populate DBG0.CMN_BUF_FREE so that SW can see some free space.

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Francisco Iglesias <frasse.iglesias@gmail.com>
Message-id: 20200402134721.27863-3-edgar.iglesias@gmail.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/dma/xlnx-zdma.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/dma/xlnx-zdma.c b/hw/dma/xlnx-zdma.c
index a6c5b2304a8..6a4699757af 100644
--- a/hw/dma/xlnx-zdma.c
+++ b/hw/dma/xlnx-zdma.c
@@ -680,6 +680,12 @@ static RegisterAccessInfo zdma_regs_info[] = {
     },{ .name = "ZDMA_CH_DBG0",  .addr = A_ZDMA_CH_DBG0,
         .rsvd = 0xfffffe00,
         .ro = 0x1ff,
+
+        /*
+         * There's SW out there that will check the debug regs for free space.
+         * Claim that we always have 0x100 free.
+         */
+        .reset = 0x100
     },{ .name = "ZDMA_CH_DBG1",  .addr = A_ZDMA_CH_DBG1,
         .rsvd = 0xfffffe00,
         .ro = 0x1ff,
-- 
2.20.1


