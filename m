Return-Path: <SRS0=WNoQ=AJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01305C433E0
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jun 2020 14:35:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C15B220672
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jun 2020 14:35:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rg7325tu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C15B220672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55960 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpYOq-0006OO-4A
	for qemu-devel@archiver.kernel.org; Sun, 28 Jun 2020 10:35:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38524)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jpYEk-0006Sg-MW
 for qemu-devel@nongnu.org; Sun, 28 Jun 2020 10:24:50 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:39600)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jpYEi-0004lT-VF
 for qemu-devel@nongnu.org; Sun, 28 Jun 2020 10:24:50 -0400
Received: by mail-wr1-x444.google.com with SMTP id q5so14033636wru.6
 for <qemu-devel@nongnu.org>; Sun, 28 Jun 2020 07:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=fwBSY0MsI6h8FbtVujLNC6mJpu8V4peKWaK9z7XDiI0=;
 b=rg7325tuDYm4hUluuyLxFpyBeffHXylA4vO7YVE+nBUruGnnIL7GDbNPBPROrBMHDq
 SZwkDsEWqsPO0Nh8foIzHvMmvUEt5rXLSW/C1FOkdXGoxJILdMd3gXAtuH068iC3vvOT
 w8wbeCN1qWkFmSWVzrcTAN0xgOYcZRIt0TmS4OaGwTW3Z7x0p+GdLzfHJ+ileI1FJuOy
 JeQKmiW0uC1KKQadVkcMS5tVticI3PDxrrjUz17cHupg05Ri8nPN37aI6dgoUW8GVXrG
 PFBxUNdrf5YRB7wd1O3kOJhTY3Qko9ODCBsnBMeA7MWKjHROYUzcww7omiMmCipT3ie4
 SIRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=fwBSY0MsI6h8FbtVujLNC6mJpu8V4peKWaK9z7XDiI0=;
 b=ikR0TvklwayWeeLhJpk/aSzcT4Ry0HRHghdh7C5EDADdWrkwjHldx3PcZeY9mbw7ir
 uc93yDKwqJVn37/gJ4vdWk9AaZA0EjyHM1btgbGsdNCR44y/kiqdpEHktRL0FxV1e+s9
 89O56CCSIFOJczteKfVXzqCf5l16aCxFn7b266Nda15J0zp7Mb+fpIL/EbAOEaeqmBDe
 t/TTm+9k/rnnCUdkaUzqGyCRrG+siUl/KYQjzWvEfMw9vX9yxFQW2f8Y7uzMI/re/7fZ
 r6DUcK3/yI5472Dkf75+1LxqaxtUs0ZPjK/5dxLub7EezqXQy4vg5yEsSzTBs562J6Vd
 Jw4Q==
X-Gm-Message-State: AOAM531zdO9aBcCXAjAXOWZoDwfhv5NjJetMip4HQCHu5vDiwX2mmrDs
 CnMfriwrPM/9TXsbPcu6vOTeMQ==
X-Google-Smtp-Source: ABdhPJwhM4e1FHu1qABUUYYOoeoVdZ6CLLE50UksqTTxQ/3xgvKTs6NaY7NEV/mWgNOfJ3mkEsyRVg==
X-Received: by 2002:a5d:6912:: with SMTP id t18mr12770328wru.411.1593354287667; 
 Sun, 28 Jun 2020 07:24:47 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id h13sm5321555wml.42.2020.06.28.07.24.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Jun 2020 07:24:47 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 13/17] hw/gpio/zaurus.c: Use LOG_GUEST_ERROR for bad guest
 register accesses
Date: Sun, 28 Jun 2020 15:24:25 +0100
Message-Id: <20200628142429.17111-14-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200628142429.17111-1-peter.maydell@linaro.org>
References: <20200628142429.17111-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x444.google.com
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

Instead of logging guest accesses to invalid register offsets in this
device using zaurus_printf() (which just prints to stderr), use the
usual qemu_log_mask(LOG_GUEST_ERROR,...).

Since this was the only use of the zaurus_printf() macro outside
spitz.c, we can move the definition of that macro from sharpsl.h
to spitz.c.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/sharpsl.h |  3 ---
 hw/arm/spitz.c           |  3 +++
 hw/gpio/zaurus.c         | 12 +++++++-----
 3 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/include/hw/arm/sharpsl.h b/include/hw/arm/sharpsl.h
index 89e168fbff3..e986b28c527 100644
--- a/include/hw/arm/sharpsl.h
+++ b/include/hw/arm/sharpsl.h
@@ -9,9 +9,6 @@
 
 #include "exec/hwaddr.h"
 
-#define zaurus_printf(format, ...)	\
-    fprintf(stderr, "%s: " format, __func__, ##__VA_ARGS__)
-
 /* zaurus.c */
 
 #define SL_PXA_PARAM_BASE	0xa0000a00
diff --git a/hw/arm/spitz.c b/hw/arm/spitz.c
index bab9968ccee..6eb46869157 100644
--- a/hw/arm/spitz.c
+++ b/hw/arm/spitz.c
@@ -62,6 +62,9 @@ typedef struct {
 #define SPITZ_MACHINE_CLASS(klass) \
     OBJECT_CLASS_CHECK(SpitzMachineClass, klass, TYPE_SPITZ_MACHINE)
 
+#define zaurus_printf(format, ...)                              \
+    fprintf(stderr, "%s: " format, __func__, ##__VA_ARGS__)
+
 #undef REG_FMT
 #define REG_FMT                         "0x%02lx"
 
diff --git a/hw/gpio/zaurus.c b/hw/gpio/zaurus.c
index 9a12c683420..258e9264930 100644
--- a/hw/gpio/zaurus.c
+++ b/hw/gpio/zaurus.c
@@ -22,9 +22,7 @@
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
 #include "qemu/module.h"
-
-#undef REG_FMT
-#define REG_FMT			"0x%02lx"
+#include "qemu/log.h"
 
 /* SCOOP devices */
 
@@ -104,7 +102,9 @@ static uint64_t scoop_read(void *opaque, hwaddr addr,
     case SCOOP_GPRR:
         return s->gpio_level;
     default:
-        zaurus_printf("Bad register offset " REG_FMT "\n", (unsigned long)addr);
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "scoop_read: bad register offset 0x%02" HWADDR_PRIx "\n",
+                      addr);
     }
 
     return 0;
@@ -150,7 +150,9 @@ static void scoop_write(void *opaque, hwaddr addr,
         scoop_gpio_handler_update(s);
         break;
     default:
-        zaurus_printf("Bad register offset " REG_FMT "\n", (unsigned long)addr);
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "scoop_write: bad register offset 0x%02" HWADDR_PRIx "\n",
+                      addr);
     }
 }
 
-- 
2.20.1


