Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 034A1C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 18:39:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C757720738
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 18:39:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WZeeyFf2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C757720738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55394 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnRLi-0005ge-1n
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 14:39:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43370)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jnRHJ-0005cN-Qs; Mon, 22 Jun 2020 14:34:45 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:33389)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jnRHI-00082N-94; Mon, 22 Jun 2020 14:34:45 -0400
Received: by mail-wm1-x341.google.com with SMTP id a6so576466wmm.0;
 Mon, 22 Jun 2020 11:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=2ixgx95fnOdvGl5LE4YjxXF8tARef+K7gPstTccWoAA=;
 b=WZeeyFf2MH+aChgwu/H9gOEDqBPYPRspHorcMG/X2d8iUL4q0etQ9oCTymVFTWjz+C
 IDJqT5JI7x2hdLezRYrMfC8tKmCWrdfoi1G1tO+o4qGMirA9h9oGacx2Wr+r+AxJyj/Z
 i6jgZlIxCAvL3u3mREiHt7N56hxDIYdnLoSNXgjHbUBrMYu5R+Dgzw2GFEPeKzg0/JAa
 DcYWFxBEmZKSLQjhX8qtfpsAXnQC4ocS+sVSsoEpXekQSmMgCJ+Ov4hlAXJPGkFBSQ4r
 NRhZEVovfW37hd40DzjJRSaUv5OmwoJZo3f9Mg0q5CSil7A4rDVmh0f0qn/Hc5QWUxjl
 fcpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=2ixgx95fnOdvGl5LE4YjxXF8tARef+K7gPstTccWoAA=;
 b=EvBgZjSW+GNInajRo7PulT+ILdxEt/pRm1X0431w+bZCK8OzLX9yzAe+K8YWhk2bHz
 ry83hpZdjnoJ/FTT1PtjL2BtaxqAwWXPgoj055oThk4tF3VKb6+ryhUDy7zL3hUJ5ZDy
 3oG/Xda4erSbVI2gAmpTY9ixeSyN0ebVC3LKMj8Ne92xUKaL55PuWJ5aDqpelc/FKrO+
 BmjdyGizQqbHWnbzqV9uVtRXMwYYhJNTN3vGWmlhrthZvJr24QWgYvxCPW74Ap8h6zvn
 5nNP9AxY7yCsS83CSr0evw9Bh5z0HUYrdb0vHegZyq7f0qFAGaq9gz5jPCZq7/njar2U
 5lPw==
X-Gm-Message-State: AOAM532P1TwD/z81778U1xEckR6hCwvFkS9o/rnEzPBqzCG9nEGDTC2N
 n67LsasmtXwuzC2FenKfVAeqBtL+
X-Google-Smtp-Source: ABdhPJy6fQG1B6XFuO9SOMdqc3N3Bcx8AWRS+lORlgoX8Uqb1EoVubl5OjB0kuT7pKoMf60ZK0HdNg==
X-Received: by 2002:a1c:7414:: with SMTP id p20mr19560732wmc.124.1592850882298; 
 Mon, 22 Jun 2020 11:34:42 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id h29sm20286161wrc.78.2020.06.22.11.34.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2020 11:34:41 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 9/9] hw/misc/pca9552: Model qdev output GPIOs
Date: Mon, 22 Jun 2020 20:34:28 +0200
Message-Id: <20200622183428.12255-10-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200622183428.12255-1-f4bug@amsat.org>
References: <20200622183428.12255-1-f4bug@amsat.org>
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Corey Minyard <cminyard@mvista.com>, Andrew Jeffery <andrew@aj.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 qemu-arm@nongnu.org, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
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
 hw/misc/pca9552.c         | 5 +++++
 2 files changed, 6 insertions(+)

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
index 5997eef8b2..38c04c54dc 100644
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
@@ -377,6 +380,8 @@ static void pca955x_realize(DeviceState *dev, Error **errp)
     PCA955xState *s = PCA955X(dev);
 
     assert(k->pin_count <= PCA955X_PIN_COUNT_MAX);
+    qdev_init_gpio_out(dev, s->gpio, k->pin_count);
+
     if (!s->description) {
         s->description = g_strdup("pca-unspecified");
     }
-- 
2.21.3


