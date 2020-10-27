Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0D07C388F9
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 13:10:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19AA620829
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 13:10:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nFGg98Y2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19AA620829
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41876 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXOkZ-0001wX-1P
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 09:10:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52380)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kXNPv-0001uv-1B
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 07:45:31 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430]:39963)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kXNPr-0004jF-NW
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 07:45:30 -0400
Received: by mail-wr1-x430.google.com with SMTP id h5so1522799wrv.7
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2020 04:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=j4VwEXftdzDLsFA/wC8/odHW3+fnrct2Yy6A8MCloEI=;
 b=nFGg98Y2XGz/lbLLaHKHpNjsf8PtcBfifVbGfiU0KxXdbpOD9QnRTmEYFLvvyA9+PT
 lMnszdggh8iGiE1EbjlwL8+h7rkAqV87CLjxYCFCst81aCVzwWEysMiwrhCKXAsm5/se
 2qNFyQUUt0Tr7STo/a0fl0ZFr5zeMohFdLjDC3APDdLQKDiMdr0ykR5ZcyBYO2Q43TwJ
 ZmcWnghoHAdzOsogE8Wuy4xp7ysL29jrtXuiEKgndON3V6E49ZcWCMenlQnVWbTudkxr
 xmXHmQFgScCEPi1Ds8YTCde2SEEf1XxgW/8NL97Koo43LAnYMD8veNp7xFpWqIh4mzYg
 jNRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=j4VwEXftdzDLsFA/wC8/odHW3+fnrct2Yy6A8MCloEI=;
 b=NtO7nv58OjiA7ajMDMtzUUvuRsYhyP8FotUyVqgfviXMsB81rvsEoTpCic9FXL4iIz
 vcTRQqgoEzIeYv0VWrKNwOvMG+GD66se6fbvkqtwTzRWpSGMf7IMWT85QAdIyddKarXt
 yUoUz7+Nj+UP7x5o+jrI1q4MaNV9WZC27FyiK6anaZLKjmw1knCa3zYUtsh0hkL8voId
 nm5+G65WpPWbb+i4mQqcM2EgyrKF0ID0fmxKzVo+uSVC3yU30mRZI6+Z9KWFRz8jXnmZ
 goHeC5x39RdJ6QABQe5aE0CNdAR3ctYJPQNRzzZq2QlsWaoTtD+7b1edko5IOsdV1HR0
 fFiQ==
X-Gm-Message-State: AOAM532yl7rgRTYSFLT0k+Jv21MilqOtNZzMPc4ZianpA1SVj7ig2apn
 DUDO6Kjvz/WCx2U1NzQm2H2OcF54gYjFBA==
X-Google-Smtp-Source: ABdhPJzYjo3JwuQZXr2o2vynUXtr5yZ1ilC6FYED55WTcInvRwFFcZew3cdHACUIWnvX/yYCZXJw3w==
X-Received: by 2002:a5d:4608:: with SMTP id t8mr2300813wrq.231.1603799125848; 
 Tue, 27 Oct 2020 04:45:25 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id 32sm1712203wro.31.2020.10.27.04.45.24
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2020 04:45:24 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 36/48] hw/misc/bcm2835_cprman: implement PLLs behaviour
Date: Tue, 27 Oct 2020 11:44:26 +0000
Message-Id: <20201027114438.17662-37-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201027114438.17662-1-peter.maydell@linaro.org>
References: <20201027114438.17662-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x430.google.com
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

From: Luc Michel <luc@lmichel.fr>

The CPRMAN PLLs generate a clock based on a prescaler, a multiplier and
a divider. The prescaler doubles the parent (xosc) frequency, then the
multiplier/divider are applied. The multiplier has an integer and a
fractional part.

This commit also implements the CPRMAN CM_LOCK register. This register
reports which PLL is currently locked. We consider a PLL has being
locked as soon as it is enabled (on real hardware, there is a delay
after turning a PLL on, for it to stabilize).

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Luc Michel <luc@lmichel.fr>
Tested-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/misc/bcm2835_cprman_internals.h |  8 +++
 hw/misc/bcm2835_cprman.c                   | 64 +++++++++++++++++++++-
 2 files changed, 71 insertions(+), 1 deletion(-)

diff --git a/include/hw/misc/bcm2835_cprman_internals.h b/include/hw/misc/bcm2835_cprman_internals.h
index 340ad623bb1..7aa46c6e188 100644
--- a/include/hw/misc/bcm2835_cprman_internals.h
+++ b/include/hw/misc/bcm2835_cprman_internals.h
@@ -100,6 +100,14 @@ REG32(A2W_PLLD_FRAC, 0x1240)
 REG32(A2W_PLLH_FRAC, 0x1260)
 REG32(A2W_PLLB_FRAC, 0x12e0)
 
+/* misc registers */
+REG32(CM_LOCK, 0x114)
+    FIELD(CM_LOCK, FLOCKH, 12, 1)
+    FIELD(CM_LOCK, FLOCKD, 11, 1)
+    FIELD(CM_LOCK, FLOCKC, 10, 1)
+    FIELD(CM_LOCK, FLOCKB, 9, 1)
+    FIELD(CM_LOCK, FLOCKA, 8, 1)
+
 /*
  * This field is common to all registers. Each register write value must match
  * the CPRMAN_PASSWORD magic value in its 8 MSB.
diff --git a/hw/misc/bcm2835_cprman.c b/hw/misc/bcm2835_cprman.c
index b86f5901b88..144bcc289d6 100644
--- a/hw/misc/bcm2835_cprman.c
+++ b/hw/misc/bcm2835_cprman.c
@@ -50,9 +50,47 @@
 
 /* PLL */
 
+static bool pll_is_locked(const CprmanPllState *pll)
+{
+    return !FIELD_EX32(*pll->reg_a2w_ctrl, A2W_PLLx_CTRL, PWRDN)
+        && !FIELD_EX32(*pll->reg_cm, CM_PLLx, ANARST);
+}
+
 static void pll_update(CprmanPllState *pll)
 {
-    clock_update(pll->out, 0);
+    uint64_t freq, ndiv, fdiv, pdiv;
+
+    if (!pll_is_locked(pll)) {
+        clock_update(pll->out, 0);
+        return;
+    }
+
+    pdiv = FIELD_EX32(*pll->reg_a2w_ctrl, A2W_PLLx_CTRL, PDIV);
+
+    if (!pdiv) {
+        clock_update(pll->out, 0);
+        return;
+    }
+
+    ndiv = FIELD_EX32(*pll->reg_a2w_ctrl, A2W_PLLx_CTRL, NDIV);
+    fdiv = FIELD_EX32(*pll->reg_a2w_frac, A2W_PLLx_FRAC, FRAC);
+
+    if (pll->reg_a2w_ana[1] & pll->prediv_mask) {
+        /* The prescaler doubles the parent frequency */
+        ndiv *= 2;
+        fdiv *= 2;
+    }
+
+    /*
+     * We have a multiplier with an integer part (ndiv) and a fractional part
+     * (fdiv), and a divider (pdiv).
+     */
+    freq = clock_get_hz(pll->xosc_in) *
+        ((ndiv << R_A2W_PLLx_FRAC_FRAC_LENGTH) + fdiv);
+    freq /= pdiv;
+    freq >>= R_A2W_PLLx_FRAC_FRAC_LENGTH;
+
+    clock_update_hz(pll->out, freq);
 }
 
 static void pll_xosc_update(void *opaque)
@@ -96,6 +134,26 @@ static const TypeInfo cprman_pll_info = {
 
 /* CPRMAN "top level" model */
 
+static uint32_t get_cm_lock(const BCM2835CprmanState *s)
+{
+    static const int CM_LOCK_MAPPING[CPRMAN_NUM_PLL] = {
+        [CPRMAN_PLLA] = R_CM_LOCK_FLOCKA_SHIFT,
+        [CPRMAN_PLLC] = R_CM_LOCK_FLOCKC_SHIFT,
+        [CPRMAN_PLLD] = R_CM_LOCK_FLOCKD_SHIFT,
+        [CPRMAN_PLLH] = R_CM_LOCK_FLOCKH_SHIFT,
+        [CPRMAN_PLLB] = R_CM_LOCK_FLOCKB_SHIFT,
+    };
+
+    uint32_t r = 0;
+    size_t i;
+
+    for (i = 0; i < CPRMAN_NUM_PLL; i++) {
+        r |= pll_is_locked(&s->plls[i]) << CM_LOCK_MAPPING[i];
+    }
+
+    return r;
+}
+
 static uint64_t cprman_read(void *opaque, hwaddr offset,
                             unsigned size)
 {
@@ -104,6 +162,10 @@ static uint64_t cprman_read(void *opaque, hwaddr offset,
     size_t idx = offset / sizeof(uint32_t);
 
     switch (idx) {
+    case R_CM_LOCK:
+        r = get_cm_lock(s);
+        break;
+
     default:
         r = s->regs[idx];
     }
-- 
2.20.1


