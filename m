Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90BE4C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 17:11:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BCDE20708
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 17:11:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Pe1O1Pat"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BCDE20708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33126 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrPDu-0007xP-JN
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 13:11:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50398)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jrOxY-0005dT-69
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 12:54:44 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:50494)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jrOxW-0005oA-DF
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 12:54:43 -0400
Received: by mail-wm1-x343.google.com with SMTP id l17so32637829wmj.0
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2020 09:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=ojDJUB2Dp/Uy9824bM0ku4i9qeSH5AqC6BZl5G2EuJg=;
 b=Pe1O1PattLH7Gsauc4CIpc9YMymi1HxniEKAnfmTlLgOOAsR2uj9/3hOlGVpw9YNkt
 bLLVr4H9AEAbkGNer19+fFJxZHanVVlWZaQwAKyhbldAa/kikktt4xjx+MGTuh1CGqh0
 Drku7oHN4fD4LQgXLzD77wvWTJYg76676ZjQLhixACqLq2biUrKDcHmtNwVX/XrmxfpO
 auJ8ikOWumfoW0vmqI9JeLzusKon+OHLOLLcvyAllV6KMgUHlS5Z2INmfJUeawEnkS46
 9T7GMVXpDGXG1a9drLaEDZ7iZmpViuIwEbAbTEe9TPr+JrPqnuX5bt2BJmOmeYt5F78x
 wNBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ojDJUB2Dp/Uy9824bM0ku4i9qeSH5AqC6BZl5G2EuJg=;
 b=FvDAF55vaIRMMx2nbdhKCifc5GUnn9yZGBrck3gW3xJR6l4JEjHvuA4WlVrXzE1qxK
 k6ig6LjkBqYImxuc6LUMUH3qKGL97vkd0n4y9m4m0pGPfYI9U/5VsCsEgXrzT8FBnXeQ
 bGzX1XV9L4UvMwtDv62sEI0EsXKAEka6ZKNzxt+/7JgN8uSSATwLjnEnMcR7BnD8rFgE
 y4ktdmbclHRx7ounR5pQhV+fM/q3L4iZtosMqJ4AsXluwReaBlve7mt9kAKjTL6Mj5W6
 NVVWpES1YSTuR8Y6WGAsYE7nqDCBlpChB3EKv/nxvqHAAX6+TopAKr+nfS1ELTHbp6zK
 KgJQ==
X-Gm-Message-State: AOAM533uM4zGO6PNcIRzv7zZGBLN8JYSqNTY176/zRW8/XVjg6INLveR
 oXPp8j2us9JXQABMR1v+9FWRXSNtEKfkDg==
X-Google-Smtp-Source: ABdhPJy/3bWipqrhdeDOVQpAhcpzgF8sysuSJGfHe7ly+cQvhsgJqahnoE2FAp0/llLoG5pGR8Zkkg==
X-Received: by 2002:a7b:cc92:: with SMTP id p18mr38826182wma.4.1593795280747; 
 Fri, 03 Jul 2020 09:54:40 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id j15sm5574224wrx.69.2020.07.03.09.54.39
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2020 09:54:39 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 29/34] hw/gpio/zaurus.c: Use LOG_GUEST_ERROR for bad guest
 register accesses
Date: Fri,  3 Jul 2020 17:54:00 +0100
Message-Id: <20200703165405.17672-30-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200703165405.17672-1-peter.maydell@linaro.org>
References: <20200703165405.17672-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x343.google.com
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
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-id: 20200628142429.17111-14-peter.maydell@linaro.org
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


