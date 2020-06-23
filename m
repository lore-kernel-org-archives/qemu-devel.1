Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8028BC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 07:29:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4AD1B20771
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 07:29:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B4Urszc0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AD1B20771
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46492 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jndN3-00022B-Hf
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 03:29:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34698)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jndLI-0007VI-Gr; Tue, 23 Jun 2020 03:27:40 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:40911)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jndLH-00054S-0V; Tue, 23 Jun 2020 03:27:40 -0400
Received: by mail-wm1-x342.google.com with SMTP id f139so649936wmf.5;
 Tue, 23 Jun 2020 00:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=EfIWMq/jwSu0ov0fWyq/TXv7CGF0k6WKQfwq7MURXHw=;
 b=B4Urszc06LkH/dpR6ZPVZt7rmvQRjUMcQuaUfflRnSwlLwHiwkv43i9tp2mtYr6C6f
 NETNSUmeI3ORJGFM/ccHYCgI3kPEH81mTCFZ8z9bJ5zrczn8zZF3VCqdxIYCPOccwtp/
 eUytKZNLmwd1kJrrRciX99PHtH3JaRrow0bShiyNY8LYoXswCfHkUi1Ms+oMwwjHlDWN
 EJEro4jP3+c1lKJaVeuxs5XTkiuscGh/mfBRE7+cPYlobx8LbnZzc7J157+qEmITxWxv
 IvAa/RUB5kUwusOkAOz0RMt982rIbFTkiizc91414dK3FuOaXgfWXm+0CWjuB84DGL4X
 KdpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=EfIWMq/jwSu0ov0fWyq/TXv7CGF0k6WKQfwq7MURXHw=;
 b=KY02Si5vfbN2waHpA/fzAeWSD6UTLAvn7KOOUD8eiPjcv0GuJsSSSmkcq0SFhTFKRT
 8s0WMF7ZdBhsZQoiW6yJnxTtGUtkgVieiCSKdVidoICiPv1qIZAAW9hatH3mhzoSB1ya
 ZYEr65dW5p0B4wr0R993cv1byrVT0LC7K23BLtUC1jy+4k13wOQJvP/u2oTeIblTAj6o
 1gRyUvdJtBYM00/gLLmkdMtXGY1ucymiB0L9/DnwIAYn+mv+9AvjmOnqL53CmJBntZwi
 t/mGtO7mH1yr8pH2dz8MhXjn0npBkzxK2lLv9xs2PA6QNLWvMgAubN9ImLGrhcocVlDq
 zSVA==
X-Gm-Message-State: AOAM531z3qznxLjebuti5Tzit+UM4R2hwgKKFET+9bZxI22y0WCw7Yjt
 7GcBhibgacqnVZt/1vt7L75At4Cm
X-Google-Smtp-Source: ABdhPJzF7S8vi5iMUGKP9tzFedNLcoRtP4phIubzu8YB395WF0gi8OiXxe99c+Ux7Dq2U9Mdb0uD5g==
X-Received: by 2002:a7b:c043:: with SMTP id u3mr23777494wmc.185.1592897257247; 
 Tue, 23 Jun 2020 00:27:37 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id l14sm4200059wrn.18.2020.06.23.00.27.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2020 00:27:36 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 9/9] hw/misc/pca9552: Model qdev output GPIOs
Date: Tue, 23 Jun 2020 09:27:23 +0200
Message-Id: <20200623072723.6324-10-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200623072723.6324-1-f4bug@amsat.org>
References: <20200623072723.6324-1-f4bug@amsat.org>
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Corey Minyard <cminyard@mvista.com>, Andrew Jeffery <andrew@aj.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 qemu-arm@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The PCA9552 has 16 GPIOs which can be used as input,
output or PWM mode. QEMU models the output GPIO with
the qemu_irq type. Let the device expose the 16 GPIOs
to allow us to later connect LEDs to these outputs.

Reviewed-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/misc/pca9552.h | 1 +
 hw/misc/pca9552.c         | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/include/hw/misc/pca9552.h b/include/hw/misc/pca9552.h
index bf1a589137..600356fbf9 100644
--- a/include/hw/misc/pca9552.h
+++ b/include/hw/misc/pca9552.h
@@ -27,6 +27,7 @@ typedef struct PCA955xState {
     uint8_t pointer;
 
     uint8_t regs[PCA955X_NR_REGS];
+    qemu_irq gpio[PCA955X_PIN_COUNT_MAX];
     char *description; /* For debugging purpose only */
 } PCA955xState;
 
diff --git a/hw/misc/pca9552.c b/hw/misc/pca9552.c
index 1c3ad57432..80caa9ec8f 100644
--- a/hw/misc/pca9552.c
+++ b/hw/misc/pca9552.c
@@ -17,6 +17,7 @@
 #include "hw/qdev-properties.h"
 #include "hw/misc/pca9552.h"
 #include "hw/misc/pca9552_regs.h"
+#include "hw/irq.h"
 #include "migration/vmstate.h"
 #include "qapi/error.h"
 #include "qapi/visitor.h"
@@ -111,9 +112,11 @@ static void pca955x_update_pin_input(PCA955xState *s)
 
         switch (config) {
         case PCA9552_LED_ON:
+            qemu_set_irq(s->gpio[i], 1);
             s->regs[input_reg] |= 1 << input_shift;
             break;
         case PCA9552_LED_OFF:
+            qemu_set_irq(s->gpio[i], 0);
             s->regs[input_reg] &= ~(1 << input_shift);
             break;
         case PCA9552_LED_PWM0:
@@ -374,11 +377,14 @@ static void pca955x_initfn(Object *obj)
 
 static void pca955x_realize(DeviceState *dev, Error **errp)
 {
+    PCA955xClass *k = PCA955X_GET_CLASS(dev);
     PCA955xState *s = PCA955X(dev);
 
     if (!s->description) {
         s->description = g_strdup("pca-unspecified");
     }
+
+    qdev_init_gpio_out(dev, s->gpio, k->pin_count);
 }
 
 static Property pca955x_properties[] = {
-- 
2.21.3


