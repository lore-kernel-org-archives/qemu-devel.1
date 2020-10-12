Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE9B7C433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 15:45:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F15920714
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 15:45:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oopoGJUo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F15920714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35820 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kS01B-0004Ps-51
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 11:45:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56700)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kRzqF-0006nO-NE
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 11:34:27 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:37132)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kRzqD-0007Hw-LR
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 11:34:27 -0400
Received: by mail-wr1-x441.google.com with SMTP id h7so19713016wre.4
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2020 08:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ZKtxYGps5VFXsStAbHuqacbKwp4q81OIlKsuS5wAl+8=;
 b=oopoGJUogC2SBAD0Fi+W7FkzqzSSo9fjMTFE3Li6I97azXcT8zr1SrPfoks+jqXoDX
 PF7vTkXgH/A7LTBYszojVWbJWKSGXNsDGV/e+9rB2GhfFBUA+xalI/o8zaGpzADwayyN
 lIVHQX3i5Os+2V6G/xiR5ka8Fa37X81BTjpTSRhYjPM72YxFepUGUKEcLXVPcjxAO1i2
 l+TxgbU7Jso+jWrn1NjOh97E7ebywvQ06MSCVbIsIjpvZt+hfrrPa5Xq/EwLvXzNoPia
 S9lXmIzztY3Ah0B8SnxRriHyzxpAYBZ2G4ER4LZ3QPOD768Iypn4eAIx508fhJfBX0wB
 GHRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ZKtxYGps5VFXsStAbHuqacbKwp4q81OIlKsuS5wAl+8=;
 b=LMVbRjbW2Cjk7m+y49lG1PpPowJdNM8TIrxR+pxJ9+XVl3GoamI7v65ExKevoXLWww
 pcsEICs9VJipp8FyPls0vVKpB6TgMhueXHKYjhgCFXplOog1GjvC8ko0dSwRaLtG1O1E
 xhhu3Wr/zIda5lop/MsJqIepn5HxQgJ/n3TK8ULJv45AjvIK3gSPIJcVBok1wldfUWsM
 tsXzx3Mk7y4EWGBRVWgBZhqqNrBbQcD64rBUBp5+oD5IHO3/MawOM4+SCaMIs851GCmx
 juDP+Lj0b+qsLE9NBZzBEPy4ik7u0MOBtZd3KW/pWe1tscyondcE3I3V6WLfKmFkdbQC
 GqOw==
X-Gm-Message-State: AOAM532Tb1q5VWMBPnXfaZDs/4w1naiS3UtB58pdkmvJj5jvg1DgNbus
 oY5idJnI1917LlcINUgowMLyFg==
X-Google-Smtp-Source: ABdhPJzw2FwStK+RZVyRtbPSabQMAXiLF4P+rmpyd+6Cyb6eLU3hIfIvx0qISb8DtHc2EfJjTsolHA==
X-Received: by 2002:adf:82e5:: with SMTP id 92mr29435427wrc.192.1602516864360; 
 Mon, 12 Oct 2020 08:34:24 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id y10sm19675284wrq.73.2020.10.12.08.34.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2020 08:34:23 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH for-5.1] hw/arm/netduino2,
 netduinoplus2: Set system_clock_scale
Date: Mon, 12 Oct 2020 16:33:35 +0100
Message-Id: <20201012153408.9747-13-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201012153408.9747-1-peter.maydell@linaro.org>
References: <20201012153408.9747-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The netduino2 and netduinoplus2 boards forgot to set the system_clock_scale
global, which meant that if guest code used the systick timer in "use
the processor clock" mode it would hang because time never advances.

Set the global to match the documented CPU clock speed of these boards.
Judging by the data sheet this is slightly simplistic because the
SoC allows configuration of the SYSCLK source and frequency via the
RCC (reset and clock control) module, but we don't model that.

Fixes: https://bugs.launchpad.net/qemu/+bug/1876187
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
NB: tested with "make check" only...

 hw/arm/netduino2.c     | 10 ++++++++++
 hw/arm/netduinoplus2.c | 10 ++++++++++
 2 files changed, 20 insertions(+)

diff --git a/hw/arm/netduino2.c b/hw/arm/netduino2.c
index 79e19392b56..8f103341443 100644
--- a/hw/arm/netduino2.c
+++ b/hw/arm/netduino2.c
@@ -30,10 +30,20 @@
 #include "hw/arm/stm32f205_soc.h"
 #include "hw/arm/boot.h"
 
+/* Main SYSCLK frequency in Hz (120MHz) */
+#define SYSCLK_FRQ 120000000ULL
+
 static void netduino2_init(MachineState *machine)
 {
     DeviceState *dev;
 
+    /*
+     * TODO: ideally we would model the SoC RCC and let it handle
+     * system_clock_scale, including its ability to define different
+     * possible SYSCLK sources.
+     */
+    system_clock_scale = NANOSECONDS_PER_SECOND / SYSCLK_FRQ;
+
     dev = qdev_new(TYPE_STM32F205_SOC);
     qdev_prop_set_string(dev, "cpu-type", ARM_CPU_TYPE_NAME("cortex-m3"));
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
diff --git a/hw/arm/netduinoplus2.c b/hw/arm/netduinoplus2.c
index 958d21dd9f9..68abd3ec69d 100644
--- a/hw/arm/netduinoplus2.c
+++ b/hw/arm/netduinoplus2.c
@@ -30,10 +30,20 @@
 #include "hw/arm/stm32f405_soc.h"
 #include "hw/arm/boot.h"
 
+/* Main SYSCLK frequency in Hz (168MHz) */
+#define SYSCLK_FRQ 168000000ULL
+
 static void netduinoplus2_init(MachineState *machine)
 {
     DeviceState *dev;
 
+    /*
+     * TODO: ideally we would model the SoC RCC and let it handle
+     * system_clock_scale, including its ability to define different
+     * possible SYSCLK sources.
+     */
+    system_clock_scale = NANOSECONDS_PER_SECOND / SYSCLK_FRQ;
+
     dev = qdev_new(TYPE_STM32F405_SOC);
     qdev_prop_set_string(dev, "cpu-type", ARM_CPU_TYPE_NAME("cortex-m4"));
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
-- 
2.20.1


