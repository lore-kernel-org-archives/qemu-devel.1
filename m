Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 851FEC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 15:16:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FC0720702
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 15:16:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="viX4ROki"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FC0720702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48608 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joq5F-00047R-Er
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 11:16:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35540)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1joq3z-00026R-Ue
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 11:14:47 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e]:37170)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1joq3w-0006IN-Pi
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 11:14:47 -0400
Received: by mail-wr1-x42e.google.com with SMTP id a6so9868289wrm.4
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2020 08:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=KiwKMAfLqBpV0Mc8jDI36+MCGtlMsxICaCbL8Ck1LtA=;
 b=viX4ROki9khXvURFoFHvwAW4qmRvNI1j3aTat0WLzRFeDUVmfut10SBSAlLI6Y5YgO
 YeTzj71kRWt6VRRCf1nAdSfa9+3qve8wb4BJfW64q7nXtMf0ekGQvBhlVwCiih6+nfOo
 UTl33igRbfRbct1kvr2rKLlgE0Ndnh2DC3zQ3JNCIxweioR4ftvns6Y0GIV0GD+J4Bmc
 gAXYYD0lgvp0Ex7HIVrFV8b1Tr2FFe5+nDFeQCPTU3IAiwL3upKxJiPTX+SeMmjazYD8
 eIEPGd8Bw5ClPhPf9V3x1ROldFy0mxAJ0JR1KWh9/VIb1TQuuUubucLqcpDxz5KymI/Q
 Jk6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=KiwKMAfLqBpV0Mc8jDI36+MCGtlMsxICaCbL8Ck1LtA=;
 b=PbizvoJqeZm1c/Gp97Lu/6IdioZSHQRHFdCTCD/bw7h3/brDxsJE1gKDJOFhaxg9Fe
 WHZojbpOVCEkZI7TDiPIwcLnANgfrBkgrAmS8xorKh7hQhDTzx4rm62KHAHHfQc/wKeB
 h3UY//avu8haoYAGmD2fffKJTBu3006Saj7P30SYSYFtFTqfoI6EkTXv1GZuHC6b58uc
 k4kJAQPXpl5uBCMU/hPJQrt0qBhct+buYNAog+aubiIYG9P2zY2DbC11BKzVyeOcAL+n
 MHRrOL4LjaKSrR81h5LdB0hgJbfpnCsNdyahItWm51xfvmruhDPdxN2MFYaSdmC4/Nzv
 tyow==
X-Gm-Message-State: AOAM531sPnNUL/U38BgX6aULOQzVA9ggmI/FnkAIOdb1ZIv1AivBh7dT
 WlRSheMhrxAL3JV630TKMhNEW2balTeI+w==
X-Google-Smtp-Source: ABdhPJwbpdXvjx3kn9wB+AxaIeKP6qi5gG0T0KAzQvBznRZ3fFEVjzKaKColgahPcVH6h1u3UcJAwQ==
X-Received: by 2002:adf:de01:: with SMTP id b1mr4160836wrm.305.1593184480108; 
 Fri, 26 Jun 2020 08:14:40 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id w13sm37838852wrr.67.2020.06.26.08.14.38
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2020 08:14:39 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 12/57] hw/misc/pca9552: Model qdev output GPIOs
Date: Fri, 26 Jun 2020 16:13:39 +0100
Message-Id: <20200626151424.30117-13-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200626151424.30117-1-peter.maydell@linaro.org>
References: <20200626151424.30117-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42e.google.com
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

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

The PCA9552 has 16 GPIOs which can be used as input,
output or PWM mode. QEMU models the output GPIO with
the qemu_irq type. Let the device expose the 16 GPIOs
to allow us to later connect LEDs to these outputs.

Reviewed-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Cédric Le Goater <clg@kaod.org>
Message-id: 20200623072723.6324-10-f4bug@amsat.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/misc/pca9552.h | 1 +
 hw/misc/pca9552.c         | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/include/hw/misc/pca9552.h b/include/hw/misc/pca9552.h
index bf1a5891378..600356fbf90 100644
--- a/include/hw/misc/pca9552.h
+++ b/include/hw/misc/pca9552.h
@@ -27,6 +27,7 @@ typedef struct PCA955xState {
     uint8_t pointer;
 
     uint8_t regs[PCA955X_NR_REGS];
+    qemu_irq gpio[PCA955X_PIN_COUNT_MAX];
     char *description; /* For debugging purpose only */
 } PCA955xState;
 
diff --git a/hw/misc/pca9552.c b/hw/misc/pca9552.c
index 1c3ad57432a..80caa9ec8fc 100644
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
2.20.1


