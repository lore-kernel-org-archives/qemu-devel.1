Return-Path: <SRS0=xv8e=AB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77861C433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jun 2020 23:04:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4607A2474C
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jun 2020 23:04:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pi9PbIh6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4607A2474C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50168 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmmWr-0001CG-GZ
	for qemu-devel@archiver.kernel.org; Sat, 20 Jun 2020 19:04:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40550)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jmmS1-0000ld-Bv; Sat, 20 Jun 2020 18:59:05 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:37078)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jmmRz-0000y6-Qc; Sat, 20 Jun 2020 18:59:05 -0400
Received: by mail-wm1-x341.google.com with SMTP id y20so12420985wmi.2;
 Sat, 20 Jun 2020 15:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=4OYkK7pZcEGj/z1TIOBnhmEqslagD9t8wPtYXi/tj/c=;
 b=Pi9PbIh6E4nFqOoTfgdyi+6JN7/3fKl+0V+6jm3FKn81rPyvK/lHqt9d+T4jOODEB1
 hNkgOw0xCt3dncnwfJO/vaQFJEULc4fmnz87sEAj6qnYhLgiXTiT6hf7x0YC3HZvrIwd
 goTvEtGU0rBYwBuh5ekbIzqyJDmi01bNm+IH0DKQVA8k2NMWGxvglVF4jZLQ9Sr1piK1
 KUILrg2HY7q+/+lnMUna3T9m2ZE6NdafvSFrkZTY+fd02TsGgDKmIXtgIBMehAReQpSL
 jjaUj9qSGoTFcSzaMikXvNdmDZlXD87/B5+khMTle+g/Zmjf8UjySlLDwBsGKdUaURDy
 yV4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=4OYkK7pZcEGj/z1TIOBnhmEqslagD9t8wPtYXi/tj/c=;
 b=NHjmLxE0s2UkWsM+JNbh2iA4pVQwjti8e2KqrKscO7ga5iZvZFE6RSi5W2aHQQnDAJ
 IKmZNwzeLrSQhQ57yHP9uv+ZEVZbyLR4E3oaZhFdEN8IlYF/OancDeUiSORcvdf70Z9m
 cA+AWuycSNmdkWFv0PDwtkHf87gaq2LLydAGUufDOsAYLNiNz+OPMCbubt1v6p7OeaEA
 sTliON/Dnk9sbSCb9BaF09VEMlUjqPEKEHptVHAv4+px08JfUC/joZ+qgf43vegMFxcs
 d9whev8+odrS1i7VXVJ6LuBUb6FNFSuFlnmTAXE4rlWf1x2kePFVw1pXxIUXAyBEytOa
 P/gA==
X-Gm-Message-State: AOAM5320EPBZbSE2wv5bOZFyZjzNVAf2/bYS6/r/vGFQqT9tfnt8hsa2
 BRm5JB9glbXdO6Y5Yrdhz0Oaknbz
X-Google-Smtp-Source: ABdhPJxs+wU+NvaYI4mOVAiRNUXK6ctBsQQBmjS/elXRHjxCnw+3Mt9+aCxj/LEOXcrWm6e5N6Ffcw==
X-Received: by 2002:a1c:6102:: with SMTP id v2mr8712545wmb.6.1592693941984;
 Sat, 20 Jun 2020 15:59:01 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id x18sm11147127wmi.35.2020.06.20.15.59.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Jun 2020 15:59:01 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 4/8] hw/misc/pca9552: Add a 'description' property for
 debugging purpose
Date: Sun, 21 Jun 2020 00:58:50 +0200
Message-Id: <20200620225854.31160-5-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200620225854.31160-1-f4bug@amsat.org>
References: <20200620225854.31160-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x341.google.com
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
Cc: Corey Minyard <cminyard@mvista.com>,
 Peter Maydell <peter.maydell@linaro.org>, Andrew Jeffery <andrew@aj.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 qemu-arm@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add a description field to distinguish between multiple devices.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/misc/pca9552.h |  1 +
 hw/misc/pca9552.c         | 10 ++++++++++
 2 files changed, 11 insertions(+)

diff --git a/include/hw/misc/pca9552.h b/include/hw/misc/pca9552.h
index ef6da4988f..c5be7f1c5e 100644
--- a/include/hw/misc/pca9552.h
+++ b/include/hw/misc/pca9552.h
@@ -27,6 +27,7 @@ typedef struct PCA9552State {
 
     uint8_t regs[PCA9552_NR_REGS];
     uint8_t max_reg;
+    char *description; /* For debugging purpose only */
     uint8_t nr_leds;
 } PCA9552State;
 
diff --git a/hw/misc/pca9552.c b/hw/misc/pca9552.c
index b97fc2893c..54ccdcf6d4 100644
--- a/hw/misc/pca9552.c
+++ b/hw/misc/pca9552.c
@@ -12,6 +12,7 @@
 #include "qemu/osdep.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
+#include "hw/qdev-properties.h"
 #include "hw/misc/pca9552.h"
 #include "hw/misc/pca9552_regs.h"
 #include "migration/vmstate.h"
@@ -312,8 +313,16 @@ static void pca9552_realize(DeviceState *dev, Error **errp)
                    __func__, s->nr_leds, PCA9552_PIN_COUNT);
         return;
     }
+    if (!s->description) {
+        s->description = g_strdup("pca-unspecified");
+    }
 }
 
+static Property pca9552_properties[] = {
+    DEFINE_PROP_STRING("description", PCA9552State, description),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
 static void pca9552_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -325,6 +334,7 @@ static void pca9552_class_init(ObjectClass *klass, void *data)
     dc->realize = pca9552_realize;
     dc->reset = pca9552_reset;
     dc->vmsd = &pca9552_vmstate;
+    device_class_set_props(dc, pca9552_properties);
 }
 
 static const TypeInfo pca9552_info = {
-- 
2.21.3


