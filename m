Return-Path: <SRS0=yvcL=DY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D436CC433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 14:30:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5665E20657
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 14:30:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ji2rC32Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5665E20657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57116 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTnE4-00048s-9U
	for qemu-devel@archiver.kernel.org; Sat, 17 Oct 2020 10:30:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37176)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kTmpU-0003eu-BQ
 for qemu-devel@nongnu.org; Sat, 17 Oct 2020 10:05:04 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:40945)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kTmpS-0003s9-PP
 for qemu-devel@nongnu.org; Sat, 17 Oct 2020 10:05:04 -0400
Received: by mail-wr1-x442.google.com with SMTP id h5so6578843wrv.7
 for <qemu-devel@nongnu.org>; Sat, 17 Oct 2020 07:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=MrdAokW/C4AyEAhV1+Tvr+zY4ZVMVcUDy6Uk4AJ14vA=;
 b=Ji2rC32Y2ZhtUQDPGgnqxT/A56h/CA+3sa7py4H/Hg2PojiWS/T569JE/dwXmnLis+
 p0fMGb0QWXM2huk0m6JAIlUSccFH+a3wX90S83DsQWNExFaH0X7n57a7pdVvY+Ac6nRk
 INjNWQGzyQYx0afrb3hZSbUnQX8gK5VsjmpBQ4LL94KIw4nNl26tI7qNCc2okaxJcptX
 rWfqJIm0Yvctm5PI0QMDS5L3Sh0pOu6L+vTAmLz4AFoV86KlnDoRejh5FqHm8guUlpR4
 wg67i4qzocBg2NOUAFhD8Aomo7pBB1l0zsKRYsGfOJAI++1KwD3BQoEl/zjqVwPCxOyH
 d15A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=MrdAokW/C4AyEAhV1+Tvr+zY4ZVMVcUDy6Uk4AJ14vA=;
 b=DfMIOwRVscLzcEn8RXG/7rhIqfYXGi5nH5bamxiCQFFC5812ExWi789bJhsG2pDibg
 4bb9nhymxExzcr/kU1dymexDcWXOccdhZYhNNKe2itwhyMfHueJUdUWybz6dzcXch+pQ
 wvKkK4DTaca4gDV2+E0S2pDmlLEsMRSLTMOZVA7L5fyNniMh4J6O9t4+dWUpJKoq2Xxp
 KLmj2g6LjI5zIzgcaf2NRIhzcDylCuuL/Q2tsFIP+0D/7i5kmuRDtlJhLIT2PuR/RlXT
 rPLy1cr9qsUS7flWAycrP/pu6kmod1x8eMEO/k9MuXIlEXMtobvjHWzIDyzuuGZ29ckv
 xI/w==
X-Gm-Message-State: AOAM533Esv4teVXvBs4mp/m9r5hs9GSZfQE7N5htstxf7efWLKUBhF4O
 K4JwUYJZuKaEQulYuax6Bpq469q/N+Q=
X-Google-Smtp-Source: ABdhPJyB10aovnv031nwtdowCH9lRTV13eAP3rPKsY/3S2axFbiCqtIBImIbjgg3GtbtSA4ksdZuRQ==
X-Received: by 2002:adf:fb8b:: with SMTP id a11mr10129084wrr.407.1602943501126; 
 Sat, 17 Oct 2020 07:05:01 -0700 (PDT)
Received: from localhost.localdomain
 (117.red-83-52-172.dynamicip.rima-tde.net. [83.52.172.117])
 by smtp.gmail.com with ESMTPSA id z6sm8889134wrm.33.2020.10.17.07.05.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Oct 2020 07:05:00 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PULL 29/44] hw/mips/cps: Do not allow use without input clock
Date: Sat, 17 Oct 2020 16:02:28 +0200
Message-Id: <20201017140243.1078718-30-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201017140243.1078718-1-f4bug@amsat.org>
References: <20201017140243.1078718-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Paul Burton <paulburton@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Huacai Chen <chenhc@lemote.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Now than all QOM users provides the input clock, do not allow
using a CPS without input clock connected.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <20201012095804.3335117-21-f4bug@amsat.org>
---
 hw/mips/cps.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/mips/cps.c b/hw/mips/cps.c
index af7b58c4bdd..c624821315a 100644
--- a/hw/mips/cps.c
+++ b/hw/mips/cps.c
@@ -74,6 +74,11 @@ static void mips_cps_realize(DeviceState *dev, Error **errp)
     bool itu_present = false;
     bool saar_present = false;
 
+    if (!clock_get(s->clock)) {
+        error_setg(errp, "CPS input clock is not connected to an output clock");
+        return;
+    }
+
     for (i = 0; i < s->num_vp; i++) {
         cpu = MIPS_CPU(object_new(s->cpu_type));
 
-- 
2.26.2


