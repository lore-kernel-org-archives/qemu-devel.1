Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C3DAC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 16:27:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66D6320719
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 16:27:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VL2us8VM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66D6320719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52320 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k05yL-0005gf-MR
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 12:27:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59718)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k05xH-0004tF-17
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 12:26:23 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:55364)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k05xF-0003XT-4x
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 12:26:22 -0400
Received: by mail-wm1-x341.google.com with SMTP id 9so14692373wmj.5
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2020 09:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ZKtxYGps5VFXsStAbHuqacbKwp4q81OIlKsuS5wAl+8=;
 b=VL2us8VMejHzZOFPHGi4LXD2WIw+WIvRsYOcjemVjYX+S5Qwedyw0b7MpSdx4vA5aE
 Z7o35QMusBvPTCHMmM0YXNWfmPj/7xpqKuS/xQK1o0B75emfHYxS3hp19n0ai9DT/jmy
 UbGOCIz3edOQ7VCjf7Gc5+D17eGY37wH4lBPZGlvtxIzuv3Oz8XouuSCfAtFc5B//r9o
 tEe/FEKg0MBLuZ5sl4OwDnwXFICG3wNTTqTFpikyasetlcf591ioqzKf43YRypR4wfV1
 llZeyK2r8zGdvczO9PAOJ1RROd/aCBMdUtTYP+Y5+fI7CkTT3GDZjsz9rHxyeY76PTfs
 Yhzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ZKtxYGps5VFXsStAbHuqacbKwp4q81OIlKsuS5wAl+8=;
 b=Pk4fZUjlMMKrQ4ipDQYyhaM5+SBPuehYAxUKf+wp5xJKqgz2WGspg6OZJMU8tLYsI4
 2h7NMeFIgm6F9d/Npym6LtPdbzaqcGsKlwm2E3L8GiMFvqDB8KIo9+xiK4BLSgHd7oED
 Lddg1arCcH2XdNcanjDGSpn5i0/+BrZYtZKU7rbSrwWDVE58fzgC4yp7f0ysKbmzV1H0
 16Rgd+EpcCjAbyEUoiEaSUMFqSAW0B33yU5xgUYqS5SkNRqgtU8xcvY1xMhDzmTbaKMS
 cUXOSQ+1aNXKa3Fcfj9+J6zH4fHUhpGIpHKwWo67WBVHF+bfubJRfzK8sNjUF123qKv1
 o/Bw==
X-Gm-Message-State: AOAM531c+bAB4RiZmB7zsG7U0HwLmOnZuP4cbA2OkydiITn5BZXPRk68
 AQ9HJPGNAbyVlifqcsu4rosOgJJJ6W9Q7w==
X-Google-Smtp-Source: ABdhPJwdvcGztkaQ0D5FIuH7Qr2rxjrxQv4QWrkJV4oEmC+HvdLrAjz7/xh5RuhabUHXGjnAiEbrtg==
X-Received: by 2002:a1c:7fd3:: with SMTP id a202mr79168wmd.67.1595867179573;
 Mon, 27 Jul 2020 09:26:19 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id g16sm12875278wrs.88.2020.07.27.09.26.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2020 09:26:18 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH for-5.1] hw/arm/netduino2,
 netduinoplus2: Set system_clock_scale
Date: Mon, 27 Jul 2020 17:26:17 +0100
Message-Id: <20200727162617.26227-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x341.google.com
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
Cc: Alistair Francis <alistair@alistair23.me>
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


