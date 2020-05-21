Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2D6EC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 19:27:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A67A3207D3
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 19:27:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DovtG7yB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A67A3207D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57446 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbqr6-0001Sj-To
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 15:27:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38132)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jbqgN-0002sA-4p
 for qemu-devel@nongnu.org; Thu, 21 May 2020 15:16:43 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:46513)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jbqgL-0000Sv-Je
 for qemu-devel@nongnu.org; Thu, 21 May 2020 15:16:42 -0400
Received: by mail-wr1-x442.google.com with SMTP id w7so7718362wre.13
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 12:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=sYpEGSBz8UzRlzjELlw5FyhD7AkAmPGjMh/mhZ4E1dI=;
 b=DovtG7yBxn4W4qb6J6Wrj9T10wH+P/ajnU26i6A5rE1g4U6TL3URs29SF75SUSZkRB
 KqD7YM9ot89UJi5HcCfXnDTs+OlZzddGl8jPulNstWhm8BbDPyu3BuLxn5Hv68qNda4y
 p8UTRvSszHcdMIWtwAvdDLOIpmgSoEu0wRpGN41pjQeY5oariTBxNo61jYkpTvmNIj+6
 yI1V9+VSue65UI+VRii2e6tozYWsJBTU3rny8lzgRB0vc070c3qMgvYtsPECQSbE0ixA
 S6ORUJ9jyEr2SanR2ixfN65P91T/BSU3A091o1cdQY8QQKYCKPJpb4sPxwx03pgjbDmM
 vsYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=sYpEGSBz8UzRlzjELlw5FyhD7AkAmPGjMh/mhZ4E1dI=;
 b=JCbi4S+bbbP6ZD0yAzYuzxp/jCYjXM7eB1RNrgy6vyLuCqgi+maJScUycgSgcRYYkk
 geKZ5mfTeCDMgReS5vcmQ/udggVSEXwH//TS1N4OwtPzpw70Vzb/U2LjUj9MJ9qCCOGp
 F2eI7vVcL845F/JNhM7yyJLax8rdDM0PL5tVfLSh0nLutIMHQhCKNLYQT9QFIWHo7uOO
 bi5u9yzJmhnteuUcNbX/qyK8LWPYQWh4kmGfqx26Upe2Kgx1pVFZ88YIDAJJbtkG9uAu
 PykPVAZmxXFt06hEvL4ohbp5AvgTr1Q38n/jI9HLPaTty+GiOfm2Pj57JEZJAr1utisT
 hFAQ==
X-Gm-Message-State: AOAM530PPRVpvbHIdbILJ0Eo74tLzJwc1Ey32tj7zy1nNpwvqyjNppvq
 DwNbxCc4Fz3rp1DdsBbK66vg7dIK6d5JdQ==
X-Google-Smtp-Source: ABdhPJx4RrSs/HeybZKBGC2DID4YrXcOuSTcs0KOHOBZVNOL4Th/+1smodWnoJqy118gMkAbl4dz+Q==
X-Received: by 2002:adf:f601:: with SMTP id t1mr88382wrp.207.1590088599828;
 Thu, 21 May 2020 12:16:39 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id z124sm7335100wmg.20.2020.05.21.12.16.38
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2020 12:16:39 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 23/29] hw/timer/exynos4210_mct: Replace hw_error() by
 qemu_log_mask()
Date: Thu, 21 May 2020 20:16:04 +0100
Message-Id: <20200521191610.10941-24-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200521191610.10941-1-peter.maydell@linaro.org>
References: <20200521191610.10941-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x442.google.com
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

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

hw_error() calls exit(). This a bit overkill when we can log
the accesses as unimplemented or guest error.

When fuzzing the devices, we don't want the whole process to
exit. Replace some hw_error() calls by qemu_log_mask().

Per the datasheet "Exynos 4412 RISC Microprocessor Rev 1.00"
Chapter 25 "Multi Core Timer (MCT)" figure 1 and table 4,
the default value on the APB bus is 0.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-id: 20200518140309.5220-5-f4bug@amsat.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/timer/exynos4210_mct.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/hw/timer/exynos4210_mct.c b/hw/timer/exynos4210_mct.c
index 570cf7075bc..29a4b10676a 100644
--- a/hw/timer/exynos4210_mct.c
+++ b/hw/timer/exynos4210_mct.c
@@ -54,7 +54,6 @@
 
 #include "qemu/osdep.h"
 #include "qemu/log.h"
-#include "hw/hw.h"
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
 #include "qemu/timer.h"
@@ -62,7 +61,6 @@
 #include "hw/ptimer.h"
 
 #include "hw/arm/exynos4210.h"
-#include "hw/hw.h"
 #include "hw/irq.h"
 
 //#define DEBUG_MCT
@@ -1062,7 +1060,7 @@ static uint64_t exynos4210_mct_read(void *opaque, hwaddr offset,
     int index;
     int shift;
     uint64_t count;
-    uint32_t value;
+    uint32_t value = 0;
     int lt_i;
 
     switch (offset) {
@@ -1158,8 +1156,8 @@ static uint64_t exynos4210_mct_read(void *opaque, hwaddr offset,
         break;
 
     default:
-        hw_error("exynos4210.mct: bad read offset "
-                TARGET_FMT_plx "\n", offset);
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset 0x%" HWADDR_PRIX "\n",
+                      __func__, offset);
         break;
     }
     return value;
@@ -1484,8 +1482,8 @@ static void exynos4210_mct_write(void *opaque, hwaddr offset,
         break;
 
     default:
-        hw_error("exynos4210.mct: bad write offset "
-                TARGET_FMT_plx "\n", offset);
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset 0x%" HWADDR_PRIX "\n",
+                      __func__, offset);
         break;
     }
 }
-- 
2.20.1


