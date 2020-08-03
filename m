Return-Path: <SRS0=TdIk=BN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDB27C433E1
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 19:35:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6755520656
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 19:35:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QuQN4YZ5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6755520656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42134 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2gEu-0002HT-HE
	for qemu-devel@archiver.kernel.org; Mon, 03 Aug 2020 15:35:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39522)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k2gDq-0001Oe-PX
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 15:34:10 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d]:55871)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k2gDm-0003Z8-JE
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 15:34:10 -0400
Received: by mail-wm1-x32d.google.com with SMTP id 9so594600wmj.5
 for <qemu-devel@nongnu.org>; Mon, 03 Aug 2020 12:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=u2p6IyQ9jI8fq1z/3i+bly/o4Cwa7bYMinoZHh/imvg=;
 b=QuQN4YZ5aI45iJpZLOpXQRYzBsZbInYXUWnprGAR5T+WX4t3xfc+92QD9b87EGy7vD
 P1eZwCfZu8UH4DZmcH+r0OE2grJ7DdkvL9eLjdjllb0LOLry3ezpBM04wwN1nERSwL7E
 ILJuV+Balnji9JWjLFOwcKooGyFR/MbkqqUtc6Eluk79EH9IDk0oH6mj91Ko+tRHCRIn
 BPbxEOvmjwW3CuQiqWONsz6pzd+N2n/qFFo0Kw5hZSI8d99WuEgEpLZf5wEZTX/ZD9KT
 AbJL4hJYyyI65KNOC4Ri4aIEoCsV59WRTWhm3kMbQE5DiurUu+3QHzrpIsJI2ljf7v7M
 8O5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=u2p6IyQ9jI8fq1z/3i+bly/o4Cwa7bYMinoZHh/imvg=;
 b=XrNQbXhn6rEADMTZuaXRNbub+a1rzjxunqG1QN5Mmos5W5APmv3D13rKKtklJOnbG5
 kV3SZAjlU7lh1gPRArFY+TCijVMRA9mOXlQDJ6i9QhHa659K7eb7d96SRcdWZJgVL5Xn
 WBFZRTKvd64aGxw9q33H/xH8NIgk0Gn4TosgnGGo1wCryAdrOxEMYMcrcz0AhMs+eXa8
 OVNxp6d4wxgqH4InkwCe+wwPk6wwoeUeqcCm0dpgh82mchECX1Jcv8V82hUAbY37vs/b
 VTTYKuhYQ1+mqd3QNbl68Fc4gM8QAyQtAaV4N9JWCgUEn/YKrN/mVwcXTK1yJHwnZxna
 CUdA==
X-Gm-Message-State: AOAM531ge+0PZ4EocoGNn1GEuDNBabcBO1FcqXpahP1u+CtstS7Z9Kdd
 ec0da7f5X7DEQC332KdkgpBA5S/7XmqsNw==
X-Google-Smtp-Source: ABdhPJzqjNxjLcBY4qTkrR5ZiEEMhuB23EaX6PdOyiFSYLDF/7xnUmFTXiZadlCMo6irUeHUxZX3Wg==
X-Received: by 2002:a7b:c3d2:: with SMTP id t18mr660693wmj.92.1596483244402;
 Mon, 03 Aug 2020 12:34:04 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id r206sm985565wma.6.2020.08.03.12.34.03
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2020 12:34:03 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 1/8] hw/arm/netduino2, netduinoplus2: Set system_clock_scale
Date: Mon,  3 Aug 2020 20:33:52 +0100
Message-Id: <20200803193359.12936-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200803193359.12936-1-peter.maydell@linaro.org>
References: <20200803193359.12936-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
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
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-id: 20200727162617.26227-1-peter.maydell@linaro.org
---
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


