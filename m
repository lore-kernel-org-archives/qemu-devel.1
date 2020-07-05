Return-Path: <SRS0=SLMP=AQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 230F7C433DF
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2020 21:11:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2D1820739
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2020 21:11:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MdSgeYTo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2D1820739
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44512 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsBvT-0000rq-5X
	for qemu-devel@archiver.kernel.org; Sun, 05 Jul 2020 17:11:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54788)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jsBu3-0007Bu-TX
 for qemu-devel@nongnu.org; Sun, 05 Jul 2020 17:10:24 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:35824)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jsBu2-0004rI-J9
 for qemu-devel@nongnu.org; Sun, 05 Jul 2020 17:10:23 -0400
Received: by mail-wm1-x342.google.com with SMTP id l2so38123399wmf.0
 for <qemu-devel@nongnu.org>; Sun, 05 Jul 2020 14:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=JgXQcZX51V7t77DAFUY2XleRV/WzIO1Iw/ek8pGYzRQ=;
 b=MdSgeYToOdzmupULd48ervtyi0JgdjlRtmpaAtg+67QTTPKrQf1VAclJrOb1Aiub+3
 ZcNdJPeosWcPm5qa4sAm1NRMtXce5BoVJETFMMYpQohX9N9NXW5dojn1rL6qJcDV49Ep
 VdoTwpxcf0aDzF1HG26+YI3ks0Lqpt04J9Z5/N9jvd1RrjjkpeKduWXrY9iXADpPQa3Y
 zYz1gnUvP0tLQcU+MQVIsG0bcreakrIfPhmNAlSvB55nxqfmINddKamnfdM6isACPx+Q
 bPiozwSpSPgxCg9d1ptWwfaK8JGRSt/fK+h93C5X62tPJz2JNVcGOjL/WR/BVq87PaTx
 eEXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=JgXQcZX51V7t77DAFUY2XleRV/WzIO1Iw/ek8pGYzRQ=;
 b=N4UKv1XPmrPPGPtHFzEIpCCrVcx+lQHHhl269A7/2kM7ij1cH52Z/dp9uwuEuRJP6f
 8M8ocgK2v/Hh+ahDhkIhX/8XsFzrvfj/aQyVGqatuRWJv5IXpD8O/eiS9RLLiaTBSsgD
 h9Jt23q/cxhGkJIboYtBWuxmHvd1CxictXz0I8mtCZrJoRhH0Z0dFeBYXg64dOIIIbu3
 q8mhCw9PzgXhZI8NboLUqqjwUyTMXI6UEDJQngu7RAeWjELiOWyrOcgyds6slXOTR5aB
 5+dRi0WDVgYp63Q5FAoAwLplHzaSNrh8RyWQ7YDHfhzRJgvjfuwqiH0EeDSTkf1BdYnb
 4wvw==
X-Gm-Message-State: AOAM530DZdu8AYuqI5dqJ1rGxSsVkYVhWgmm/Zx1CoTmwKU70YOVSjmE
 /tv/gyObtA0gGomTbdJPz8AUBTfZjds=
X-Google-Smtp-Source: ABdhPJxCi8KLQ/YjESPFsV2YeEedkEfvEuKDVAe5cA3MfXUZLfDP1UkdPpFCUi0qCOJYkVSAyBfb1g==
X-Received: by 2002:a7b:c441:: with SMTP id l1mr44009680wmi.7.1593983421083;
 Sun, 05 Jul 2020 14:10:21 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id r8sm21102004wrp.40.2020.07.05.14.10.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Jul 2020 14:10:20 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/4] hw/lm32/milkymist: Comment to remember some IRQs lines
 are left unwired
Date: Sun,  5 Jul 2020 23:10:14 +0200
Message-Id: <20200705211016.15241-3-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200705211016.15241-1-f4bug@amsat.org>
References: <20200705211016.15241-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Michael Walle <michael@walle.cc>,
 Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The 'card is readonly' and 'card inserted' IRQs are not wired.
Add a comment in case someone know where to wire them.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/lm32/milkymist.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/lm32/milkymist.c b/hw/lm32/milkymist.c
index 469e3c4322..117973c967 100644
--- a/hw/lm32/milkymist.c
+++ b/hw/lm32/milkymist.c
@@ -87,6 +87,7 @@ static DeviceState *milkymist_memcard_create(hwaddr base)
     dev = qdev_new("milkymist-memcard");
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, base);
+    /* FIXME wire 'card is readonly' and 'card inserted' IRQs? */
 
     return dev;
 }
-- 
2.21.3


