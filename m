Return-Path: <SRS0=WNoQ=AJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48702C433E0
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jun 2020 14:34:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1232D206F1
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jun 2020 14:34:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ke3gNQQE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1232D206F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54072 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpYOC-0005cO-C6
	for qemu-devel@archiver.kernel.org; Sun, 28 Jun 2020 10:34:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38554)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jpYEl-0006WE-Ry
 for qemu-devel@nongnu.org; Sun, 28 Jun 2020 10:24:51 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:37590)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jpYEk-0004m7-2r
 for qemu-devel@nongnu.org; Sun, 28 Jun 2020 10:24:51 -0400
Received: by mail-wm1-x344.google.com with SMTP id o2so13694914wmh.2
 for <qemu-devel@nongnu.org>; Sun, 28 Jun 2020 07:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=dJ0W5rRE5YZi83vxM8j/ufJhgS7qKl+8QXLVWJzvwUI=;
 b=ke3gNQQEkRbYWHL25HPVR/Gxz/sTkvZlVuaag2J9HEa5p+Me4nBuqzNQBWi8kIHC0T
 Lmc05XIEn/Vo/pNeeg6kk+Wo3Lqv6SEvrpUMiecDV2TMsksGBScIwlIWLd8NsYCvxpf8
 ebNJ6uBdxnxRDHnG8GKaW989MJHQUDHI3ylSCocu+fz8PKo2TuOplQeyxyv/QulI9E0Y
 EmXg621ntzEOCAEazxoCfSnS1qRvzL/Y7ILo1IuWFK7pzq4M4SrXIaBGbih+bX7MkrpN
 Pm9liknWWevRNEfOGy0P0qTrNhhQjICagu4MUmiiIBWVlhlC15Gm8WWruM8l0TMLlduz
 8WBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=dJ0W5rRE5YZi83vxM8j/ufJhgS7qKl+8QXLVWJzvwUI=;
 b=KLfBqehf013mbW3oumViCqq98sW7gi3BI1tR5hI1FhIpCS3sG/DhHqQjNmtwbcEoqp
 aEmPyicILcsWii8SODtvpLnZYbQNHsd/pZ1Nxp5YAek4yHiijnFylq83WPNZAnqayrX0
 y7V1tz0z3U0dOUVhO+ezjvBLhPcvqqIRjGKs3SrFNBUN0mrKYYYh27WpBmDip8ib2OvJ
 +Cy4v+DVlQDzI6a9o+Rl6s9xCzieOhsQtqxS4w58b2f190dVr365S1KdqEUL2KmoyXo6
 3pDGREVmLRZBAb6rInnsZrRRm8EnNN+sgDCzLJ3Xvg6QytNviwjnRtbtlXjgM4aOzeKB
 8/Fg==
X-Gm-Message-State: AOAM532g6qnAhvuEO0dZBs9qqlKPm32qpPzaDC+IdCDSqjlB/RCLJXq5
 qqle23iY1fxG/d04nUJkChXXYw==
X-Google-Smtp-Source: ABdhPJzCUX7M/b2eS8hPnxqgz58CYwq0qGbkB8fZH2U269vXE3sGMJn9XIv+pcbNtf3aJy3fnG7odg==
X-Received: by 2002:a7b:c44d:: with SMTP id l13mr13183989wmi.66.1593354288842; 
 Sun, 28 Jun 2020 07:24:48 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id h13sm5321555wml.42.2020.06.28.07.24.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Jun 2020 07:24:48 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 14/17] hw/arm/spitz: Use LOG_GUEST_ERROR for bad guest
 register accesses
Date: Sun, 28 Jun 2020 15:24:26 +0100
Message-Id: <20200628142429.17111-15-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200628142429.17111-1-peter.maydell@linaro.org>
References: <20200628142429.17111-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Alistair Francis <alistair@alistair23.me>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Instead of logging guest accesses to invalid register offsets in the
Spitz flash device with zaurus_printf() (which just prints to stderr),
use the usual qemu_log_mask(LOG_GUEST_ERROR,...).

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/spitz.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/hw/arm/spitz.c b/hw/arm/spitz.c
index 6eb46869157..49eae3fce4e 100644
--- a/hw/arm/spitz.c
+++ b/hw/arm/spitz.c
@@ -23,6 +23,7 @@
 #include "hw/ssi/ssi.h"
 #include "hw/block/flash.h"
 #include "qemu/timer.h"
+#include "qemu/log.h"
 #include "hw/arm/sharpsl.h"
 #include "ui/console.h"
 #include "hw/audio/wm8750.h"
@@ -65,9 +66,6 @@ typedef struct {
 #define zaurus_printf(format, ...)                              \
     fprintf(stderr, "%s: " format, __func__, ##__VA_ARGS__)
 
-#undef REG_FMT
-#define REG_FMT                         "0x%02lx"
-
 /* Spitz Flash */
 #define FLASH_BASE              0x0c000000
 #define FLASH_ECCLPLB           0x00    /* Line parity 7 - 0 bit */
@@ -137,7 +135,9 @@ static uint64_t sl_read(void *opaque, hwaddr addr, unsigned size)
         return ecc_digest(&s->ecc, nand_getio(s->nand));
 
     default:
-        zaurus_printf("Bad register offset " REG_FMT "\n", (unsigned long)addr);
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "sl_read: bad register offset 0x%02" HWADDR_PRIx "\n",
+                      addr);
     }
     return 0;
 }
@@ -168,7 +168,9 @@ static void sl_write(void *opaque, hwaddr addr,
         break;
 
     default:
-        zaurus_printf("Bad register offset " REG_FMT "\n", (unsigned long)addr);
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "sl_write: bad register offset 0x%02" HWADDR_PRIx "\n",
+                      addr);
     }
 }
 
-- 
2.20.1


