Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6B63C43461
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 07:24:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E9D42078B
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 07:24:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lySK3Ik4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E9D42078B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36878 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGGwb-0008TE-HW
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 03:24:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36056)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kGGvc-0006j5-N1; Thu, 10 Sep 2020 03:23:32 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:35609)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kGGvb-0004J1-B1; Thu, 10 Sep 2020 03:23:32 -0400
Received: by mail-wm1-x343.google.com with SMTP id y15so4709014wmi.0;
 Thu, 10 Sep 2020 00:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=t4kTfpWibJLcPX1miKAIAIqMzQ2vkU3n7DRrDkK4dk8=;
 b=lySK3Ik4aggs5kzMHlWai0SL7UyMLQETZqBZ9/AR6fbrgiyzPaDgLX7nfVkJe0f5sD
 sBv3Zcb1XUmFMJuuFPzyjindOu/U6x5BqLlK9DnwqqO3yNe9/380TUYWG2Ledaw9qTTF
 +2XilGatQhxBOHk77IS8nR/bvoo4rnuuA7OHBBrU1NTHK0ek4dpBoviMoRKa8CggXS66
 j0fAbf/ldAD9tmWAvQYBPu0iqZP945BPeNhopgx0UyWiTsgLa+u8jjknnkdznB+EIotQ
 wtsF7bKNW5SKE8u2/XertEDI/8JDINVn5tAhfkVUwROznnq6CTTans8YOt1m6H6f4SHt
 dOsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=t4kTfpWibJLcPX1miKAIAIqMzQ2vkU3n7DRrDkK4dk8=;
 b=BPQI8wetsUGFfq8ngUix8XjJZeFfZMb6TAwPtjGrZ4koxuR9AkHs7jkfWFQtaS7qlH
 Qcba6Y3yr0itQROEbW96xeIiGMIJ/WO2SASkhjNEu+sINS8AE+T1pcv1OSMu+4anHmGC
 vjm7qB9skN1/EGjhdVpIwmnTtdVeP06ef3XeavHzapsEGsgId4nQq5YhICPWpozXeyvh
 wF6FdwI7RaICUhglJfhCiGWftFmKoub2DXbz4fQAnrEfvjGvIB/fF4qDJSAb1valda8v
 qP9fZ188w8+kRiXlEABmwL0IcJ8xVdsAeTQiii6YVPXLXyfejrXdwt+b8B06KFFc0/1l
 7H5A==
X-Gm-Message-State: AOAM532cWuZatj4DtUqKWDwuOSDCxSFn/V3gDWj+r1i863466tc8zftR
 6MNCNvDeDMoz2+eyjdS+j/bc8nZMXB8=
X-Google-Smtp-Source: ABdhPJwi9hutOnXWrSLkvEs0WvrNZlVwpMeuo2oy3RykGWLrUsYEOGp2i1exvAKIPspRd0wPK1HDgw==
X-Received: by 2002:a7b:c84a:: with SMTP id c10mr7019905wml.139.1599722608717; 
 Thu, 10 Sep 2020 00:23:28 -0700 (PDT)
Received: from x1w.redhat.com (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id x2sm6783804wrl.13.2020.09.10.00.23.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2020 00:23:27 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 1/2] hw/gpio/max7310: Remove impossible check
Date: Thu, 10 Sep 2020 09:23:24 +0200
Message-Id: <20200910072325.439344-2-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200910072325.439344-1-f4bug@amsat.org>
References: <20200910072325.439344-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x343.google.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-trivial@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The max7310_gpio_set() handler is static and only used by
qdev_init_gpio_in, initialized with 8 IRQs. The 'line'
argument can not be out of the [0-8[ range.
Replace the dead code by an assertion.

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/gpio/max7310.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/hw/gpio/max7310.c b/hw/gpio/max7310.c
index 4f78774dc8f..158b0a074e5 100644
--- a/hw/gpio/max7310.c
+++ b/hw/gpio/max7310.c
@@ -8,9 +8,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/hw.h"
 #include "hw/i2c/i2c.h"
-#include "hw/hw.h"
 #include "hw/irq.h"
 #include "migration/vmstate.h"
 #include "qemu/module.h"
@@ -173,8 +171,7 @@ static const VMStateDescription vmstate_max7310 = {
 static void max7310_gpio_set(void *opaque, int line, int level)
 {
     MAX7310State *s = (MAX7310State *) opaque;
-    if (line >= ARRAY_SIZE(s->handler) || line  < 0)
-        hw_error("bad GPIO line");
+    assert(line >= 0 && line < ARRAY_SIZE(s->handler));
 
     if (level)
         s->level |= s->direction & (1 << line);
-- 
2.26.2


