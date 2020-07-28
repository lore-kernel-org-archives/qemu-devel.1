Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1AB7C433E5
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 10:39:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CB4320786
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 10:39:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NCKujaZQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CB4320786
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42484 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0N0g-0006XN-NH
	for qemu-devel@archiver.kernel.org; Tue, 28 Jul 2020 06:39:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53600)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k0MzZ-0004lJ-AA
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 06:37:53 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:40082)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k0MzW-0002li-CY
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 06:37:52 -0400
Received: by mail-wm1-x342.google.com with SMTP id k20so10012212wmi.5
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2020 03:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=XbJ9UAfX7dDvtE5SupCSFkHZ/YbhwBKaqHRF+zT2hfU=;
 b=NCKujaZQvmyQR/EzTwUvPBiaCCB0J8m7PeLNfnCj4QYlpooKQUiLjZrpBCfRuYuQ+z
 wSiUr/YyXhZEK2OmejxJuxNkmeQ9asQ39ElJI64hNHHEwpAPbCYxiUmMcF32kQwzp9SV
 HhrYxm19W0sOaT6rWRX8B9w99HPxIQpFuWXvna2ioxZCTuLiTKc0zs9wkP1nO47u5C/r
 YQ55UV0SWVhDOqupeQe0RlfJmt8l18lF01ZkOcGecXnTvHj7kdoztyX9rljHX2Y5L7vR
 C7Jvxpcl9BY2bM6eRMNhVadRatPifP6KaD4uBzKIzrAmFTx7IQq5OVUV/BDu8ib8VxhB
 cHbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=XbJ9UAfX7dDvtE5SupCSFkHZ/YbhwBKaqHRF+zT2hfU=;
 b=ESF4iQlnHJsHjBWf4GvDXq82ur9GBj/owkIzg7YzxoerMMzIXV9TT1O/Wj4IRSOviN
 dGoo/Sz/0r6hxoD3yh/Bvc/dkEM3FjFoV3OKTO1sXufpKOIA/ZBAQ0WbiigMAMV0vUkc
 3gcpSojE0qrI06ZawmvnTI3uq+lCUg25wbBgB+a7W0DY8QSu3fo4jsYuqyz+mNuW5r6M
 BPmuRr7JyKGCSmBmEbWbBoshe9MyiRQwG/fBxrIHFSSIuS9uXLWmw+6yBvyAf4ZIN3fo
 t8G6oEfntjWn2x/33cyRMoL+LnGxreq/eAKn3dvi5arg6BTxFjDlGoi9icK+L7mfLj+/
 s35w==
X-Gm-Message-State: AOAM531D9m6UZ8bM1CN3eHQox5/uAhgQzEgtnUbLGLD8Lpno4c5rs7B7
 7+9p0Esi9PEg22Lk4zDWwbJ8oQ==
X-Google-Smtp-Source: ABdhPJy4oyfGbG8LjgNliZ5ZHgSoMHeawfxIy5Smt+9Cf95aVCNguuyU/lUUJcw54C1zpPKaBOXvIQ==
X-Received: by 2002:a7b:cf2b:: with SMTP id m11mr3458709wmg.110.1595932669003; 
 Tue, 28 Jul 2020 03:37:49 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id w16sm18634657wrg.95.2020.07.28.03.37.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2020 03:37:48 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH for-5.1? 2/3] hw/intc/armv7m_nvic: Provide default "reset the
 system" behaviour for SYSRESETREQ
Date: Tue, 28 Jul 2020 11:37:43 +0100
Message-Id: <20200728103744.6909-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200728103744.6909-1-peter.maydell@linaro.org>
References: <20200728103744.6909-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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

The NVIC provides an outbound qemu_irq "SYSRESETREQ" which it signals
when the guest sets the SYSRESETREQ bit in the AIRCR register.  This
matches the hardware design (where the CPU has a signal of this name
and it is up to the SoC to connect that up to an actual reset
mechanism), but in QEMU it mostly results in duplicated code in SoC
objects and bugs where SoC model implementors forget to wire up the
SYSRESETREQ line.

Provide a default behaviour for the case where SYSRESETREQ is not
actually connected to anything: use qemu_system_reset_request() to
perform a system reset.  This will allow us to remove the
implementations of SYSRESETREQ handling from the boards where that's
exactly what it does, and also fixes the bugs in the board models
which forgot to wire up the signal:

 * microbit
 * mps2-an385
 * mps2-an505
 * mps2-an511
 * mps2-an521
 * musca-a
 * musca-b1
 * netduino
 * netduinoplus2

We still allow the board to wire up the signal if it needs to, in case
we need to model more complicated reset controller logic or to model
buggy SoC hardware which forgot to wire up the line itself. But
defaulting to "reset the system" is more often going to be correct
than defaulting to "do nothing".

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/armv7m.h |  4 +++-
 hw/intc/armv7m_nvic.c   | 17 ++++++++++++++++-
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/include/hw/arm/armv7m.h b/include/hw/arm/armv7m.h
index d2c74d3872a..a30e3c64715 100644
--- a/include/hw/arm/armv7m.h
+++ b/include/hw/arm/armv7m.h
@@ -35,7 +35,9 @@ typedef struct {
 
 /* ARMv7M container object.
  * + Unnamed GPIO input lines: external IRQ lines for the NVIC
- * + Named GPIO output SYSRESETREQ: signalled for guest AIRCR.SYSRESETREQ
+ * + Named GPIO output SYSRESETREQ: signalled for guest AIRCR.SYSRESETREQ.
+ *   If this GPIO is not wired up then the NVIC will default to performing
+ *   a qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET).
  * + Property "cpu-type": CPU type to instantiate
  * + Property "num-irq": number of external IRQ lines
  * + Property "memory": MemoryRegion defining the physical address space
diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
index 3c4b6e6d701..277a98b87b9 100644
--- a/hw/intc/armv7m_nvic.c
+++ b/hw/intc/armv7m_nvic.c
@@ -19,6 +19,7 @@
 #include "hw/intc/armv7m_nvic.h"
 #include "hw/irq.h"
 #include "hw/qdev-properties.h"
+#include "sysemu/runstate.h"
 #include "target/arm/cpu.h"
 #include "exec/exec-all.h"
 #include "exec/memop.h"
@@ -64,6 +65,20 @@ static const uint8_t nvic_id[] = {
     0x00, 0xb0, 0x1b, 0x00, 0x0d, 0xe0, 0x05, 0xb1
 };
 
+static void signal_sysresetreq(NVICState *s)
+{
+    if (qemu_irq_is_connected(s->sysresetreq)) {
+        qemu_irq_pulse(s->sysresetreq);
+    } else {
+        /*
+         * Default behaviour if the SoC doesn't need to wire up
+         * SYSRESETREQ (eg to a system reset controller of some kind):
+         * perform a system reset via the usual QEMU API.
+         */
+        qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
+    }
+}
+
 static int nvic_pending_prio(NVICState *s)
 {
     /* return the group priority of the current pending interrupt,
@@ -1524,7 +1539,7 @@ static void nvic_writel(NVICState *s, uint32_t offset, uint32_t value,
             if (value & R_V7M_AIRCR_SYSRESETREQ_MASK) {
                 if (attrs.secure ||
                     !(cpu->env.v7m.aircr & R_V7M_AIRCR_SYSRESETREQS_MASK)) {
-                    qemu_irq_pulse(s->sysresetreq);
+                    signal_sysresetreq(s);
                 }
             }
             if (value & R_V7M_AIRCR_VECTCLRACTIVE_MASK) {
-- 
2.20.1


