Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F569C4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 18:25:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC17520BED
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 18:25:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tVXKYBrl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC17520BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35816 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUwKW-0005Qh-P5
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 14:25:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50072)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kUwFa-0001LY-Ur
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 14:20:47 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:41806)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kUwFZ-00072j-J3
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 14:20:46 -0400
Received: by mail-wr1-x444.google.com with SMTP id s9so3347588wro.8
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2020 11:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=LQrTFKXWCLSqqSOpapSwwXPnnslLjbgCl2fGT7u9jw0=;
 b=tVXKYBrlySX4y89GL32QgH7h5/3ZT9bsnd/8LCsCuEa8Cb4pPlFcMQJSjmpA/MsNQc
 wxypXE0dJVIdGSWW53+36BdL8pI661IhgCCJVYkfsOabz8/OMyv+mdo6bKSb7AHyq1I8
 VKfP0y+f+mSZLomDqSOaCT+0Ax6EixynAzkbyuQgO2UWNFLqG6QMmPXIA0NxV+Ps0hGF
 OX2359yqMIhxs3gYfaSRBZz+c1LiD2cYYWKaWXrpdglfIbLYDkNNnp+5uodI9PXVsRHG
 n7BUOPUkqCDFVXwekyshYr7NzO4Ri+VVpnyNg8eupncxipwkQNZjR+LFLCLkA6ig/4RL
 v2Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=LQrTFKXWCLSqqSOpapSwwXPnnslLjbgCl2fGT7u9jw0=;
 b=ujfx/8WzfACKBlM+odvt8yESX5YE825CHs5VlGkdVuFMBR3JaBtKeLdvEnMkXeu7a5
 g878lyzlflAWlq9HQwy/9s4Q+7H+WRK9MMS0L2bUiQWoImUyJg0nGCrfS52vUv10cUnS
 nodgNjrPJbO7reh3zT+DHD0m0i5V4JJ/zJELBjQlKRfhSxq4d8U4TI2zi5MoaYrMjCKD
 ETS4qpCwEl7kZGfB0cd5bAPg3fbPWHOCuIGLEYWy1Yfyq7qLI+EmyzWJmkM66uW6gRSc
 TmZzIq7rWNj2McRFrqmUtKgYG3mOPI38cz021Epc45tjF9dYrkZKGM81F68oCKQ3+yy7
 RCwA==
X-Gm-Message-State: AOAM532dilJSsp29KFR1oLkw+vS9rHUj017h0mpdFiY69YdrsdaJYRhN
 +94M+XmHN+D3QZ7En4pE1FOiq+RCcW4=
X-Google-Smtp-Source: ABdhPJxGeMKf57nyBJuXqB3UpANGvvvS7jEECJvnzXo3B1NVbkxk7AvTodWQv/i/AJo2TU9Jn7dApw==
X-Received: by 2002:adf:a553:: with SMTP id j19mr4875776wrb.349.1603218029290; 
 Tue, 20 Oct 2020 11:20:29 -0700 (PDT)
Received: from x1w.redhat.com (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id p11sm4139024wrm.44.2020.10.20.11.20.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2020 11:20:28 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 4/4] hw/clock: Inline and remove CLOCK_PERIOD_TO_NS()
Date: Tue, 20 Oct 2020 20:20:08 +0200
Message-Id: <20201020182008.2240590-5-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201020182008.2240590-1-f4bug@amsat.org>
References: <20201020182008.2240590-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
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
Cc: Damien Hedde <damien.hedde@greensocs.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Luc Michel <luc.michel@greensocs.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This macro is only used once. Inline caring about 64-bit
multiplication, and remove it.

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/clock.h | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/include/hw/clock.h b/include/hw/clock.h
index b58038f1e7d..f329fcf0ea5 100644
--- a/include/hw/clock.h
+++ b/include/hw/clock.h
@@ -16,6 +16,7 @@
 
 #include "qom/object.h"
 #include "qemu/queue.h"
+#include "qemu/host-utils.h"
 
 #define TYPE_CLOCK "clock"
 OBJECT_DECLARE_SIMPLE_TYPE(Clock, CLOCK)
@@ -38,7 +39,6 @@ typedef void ClockCallback(void *opaque);
  * macro helpers to convert to hertz / nanosecond
  */
 #define CLOCK_PERIOD_FROM_NS(ns) ((ns) * (CLOCK_PERIOD_1SEC / 1000000000llu))
-#define CLOCK_PERIOD_TO_NS(per) ((per) / (CLOCK_PERIOD_1SEC / 1000000000llu))
 #define CLOCK_PERIOD_FROM_HZ(hz) (((hz) != 0) ? CLOCK_PERIOD_1SEC / (hz) : 0u)
 
 /**
@@ -210,9 +210,14 @@ static inline uint64_t clock_get_hz(Clock *clk)
     return CLOCK_PERIOD_1SEC / clk->period;
 }
 
-static inline unsigned clock_get_ns(Clock *clk)
+static inline uint64_t clock_get_ns(Clock *clk)
 {
-    return CLOCK_PERIOD_TO_NS(clock_get(clk));
+    uint64_t lo, hi;
+
+    mulu64(&lo, &hi, clock_get(clk), 1000000000llu);
+    divu128(&lo, &hi, CLOCK_PERIOD_1SEC);
+
+    return lo;
 }
 
 /**
-- 
2.26.2


