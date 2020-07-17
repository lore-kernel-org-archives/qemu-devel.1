Return-Path: <SRS0=LOIU=A4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4426CC433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 07:48:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0AE132071A
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 07:48:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KcPwEcTD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AE132071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38320 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwL6s-0004kp-8M
	for qemu-devel@archiver.kernel.org; Fri, 17 Jul 2020 03:48:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54188)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jwL62-0004EI-Vb; Fri, 17 Jul 2020 03:47:55 -0400
Received: from mail-ej1-x641.google.com ([2a00:1450:4864:20::641]:37689)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jwL61-0002WT-DF; Fri, 17 Jul 2020 03:47:54 -0400
Received: by mail-ej1-x641.google.com with SMTP id lx13so9801639ejb.4;
 Fri, 17 Jul 2020 00:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=skCwKeZ+Ncg2xvtkxIFApeepGtPcjDo6Fl40jBauH7g=;
 b=KcPwEcTDR9Ao+QY/V2swjbCA0q14ZPjkBZmaWXHvAsc+wotdxJ7CYhT7yWaAhJTD1t
 zFZg0Zz98gIyQiDxsVdfAdFCtGo+GkIhblqlaoPpjLuCJwKmHcN4hmDJv0v1/5T1PEtW
 wVxSDu7QVbOiIyPMHoMMEfBkces7l4YamBJVK5hyHafCUxT1AMcOSPhIBIHca8k+vu+R
 a+SavAkWc0Y5rF8XIraFkr2tNHnGrcYIguDeioC+p5SN26dH6f2FXc+aeY8rCxrkSwvY
 FwDKCcmYv/lbjHBSPHRdTOmUBtLGsSpF7ldE25RsOEI5QU1sWDZv4ELqk5UNYhGY9s6m
 t0kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=skCwKeZ+Ncg2xvtkxIFApeepGtPcjDo6Fl40jBauH7g=;
 b=hl+7VA5gY4W0UPDX9EVThCnzhWH4vhIZTwN61r+YTb2XcRrrEz2Aan3LnDrZofPxeP
 EFbqOdwTC5cUJ/tqE4YJbY9WM3CApDLehQWaiuclzyOL6+M8zvFMp7UmYxGu33BbQVEN
 sMx5/LFqX/msXX7UREItG73esDOa8ed0HTVsK6kp+bctS4E7Taa2jXVFP/GpHOtfi1WX
 RyRAJBwkh3c+PKi03tVjFv449v4moB/6Ghyhy/WUZcqVXKEZ+PoZsbSeBuOmVIk049wP
 MP5iEduirIZqfMuAXGVk4y6FUdtOvv/l764d+BdKDmfteUyuun4Z/ICAujPpVM3XfA//
 6nRQ==
X-Gm-Message-State: AOAM530iYw6KnaAGtNmYIklJ8gAlI7fvYRF0SpnyJCJB/yvPKDD+F7OY
 xGOen7rHdI1PXCCR4wTJs5ituDfmcr8=
X-Google-Smtp-Source: ABdhPJzWKe1XPkKLnSX/V9YdtPeAawcxBPktS+WaXcie9HTFpMTQIxQ+mun4xwApaM5A9mW8osIdSg==
X-Received: by 2002:a17:906:f202:: with SMTP id
 gt2mr7336087ejb.70.1594972070932; 
 Fri, 17 Jul 2020 00:47:50 -0700 (PDT)
Received: from x1w.redhat.com (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id c10sm7634322edt.22.2020.07.17.00.47.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jul 2020 00:47:50 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH-for-5.1] hw/ide: Cancel pending DMA requests before
 setting as inactive
Date: Fri, 17 Jul 2020 09:47:48 +0200
Message-Id: <20200717074748.2528-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::641;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ej1-x641.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Alexander Bulekov <alxndr@bu.edu>, John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

libFuzzer found a case where requests are queued for later in the
AIO context, but a command set the bus inactive, then when finally
the requests are processed by the DMA it aborts because it is
inactive:

 include/hw/ide/pci.h:59: IDEState *bmdma_active_if(BMDMAState *): Assertion `bmdma->bus->retry_unit != (uint8_t)-1' failed.

Reproducer available on the BugLink.

Fix by draining the pending DMA requests before inactivating the bus.

BugLink: https://bugs.launchpad.net/qemu/+bug/1887303
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
RFC because I don't have much clue about block drive and IDE,
so block-team please be very careful while reviewing this bug.
---
 hw/ide/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/ide/core.c b/hw/ide/core.c
index d997a78e47..b21d28f99c 100644
--- a/hw/ide/core.c
+++ b/hw/ide/core.c
@@ -804,11 +804,11 @@ void dma_buf_commit(IDEState *s, uint32_t tx_bytes)
 
 void ide_set_inactive(IDEState *s, bool more)
 {
-    s->bus->dma->aiocb = NULL;
-    ide_clear_retry(s);
     if (s->bus->dma->ops->set_inactive) {
         s->bus->dma->ops->set_inactive(s->bus->dma, more);
     }
+    ide_cancel_dma_sync(s);
+    ide_clear_retry(s);
     ide_cmd_done(s);
 }
 
-- 
2.21.3


