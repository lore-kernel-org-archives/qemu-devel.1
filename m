Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A92B4C43603
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 11:26:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77448206D3
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 11:26:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WwfSYe0c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77448206D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51654 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igoVq-0003im-1X
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 06:26:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50921)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1igoFe-0007eR-P8
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 06:09:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1igoFd-0007nk-FN
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 06:09:22 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332]:38048)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1igoFd-0007mJ-8e
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 06:09:21 -0500
Received: by mail-wm1-x332.google.com with SMTP id u2so6222449wmc.3
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2019 03:09:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=sAVMne6xljKCCSIVb7x6KZ8Mn9NcByWXcsU8hgdMM68=;
 b=WwfSYe0cSD00519Wyt9qNSAu33BrF9M48OKjPfbRL9ViueU1Wd2oodfaPrWamhrkEs
 LI9pYFQicD4Wl2g2+z0w9wAp0iK1EzIbyD6dThF3PS6L/Ls7o/A9LyYe6raUQQnE/1/m
 EO9rbI4tKH8se8jdyGzd8hRH8ZPkeDNj/miP1Y+7B5KBqAPd/GdGafIH2Q9WnIy5j1SX
 FRXMfUPBfif7hLeatJjg3+ogOhDoPCizY2bcOJKWOtlPUPYWYKTyPMxJuG8xqsxrB4Ow
 /ntKa5Q33x7/LF08KumrAirG72o8d9usdiqDV7gLF+MveI3EpHQpiFCWSJivXYQz1Zvj
 rlEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=sAVMne6xljKCCSIVb7x6KZ8Mn9NcByWXcsU8hgdMM68=;
 b=kQYlSrXUwlup72+sU24zOZZuywdCYwB8ftrIAMXQbnQzUjoczFIu8nkjEyGpvQCJpS
 YvFx9Hg1N55RiDqQhjrgLLxIVJxbcKtRENdvO/9n+jqiyj2YZpwuORUgGBUB37BSwSZ3
 pfgTp7VmPy2aaDeLg6tGGOTS6AZOxRAI2KMc3F6vcnHiKg9MyViJETHsRBeC05rQQos4
 gzhsZ/rdsybebPkyGEhb3BJQpapM4tFEROTuMPZpSnTzpRGbQpgCPfPjRCUB36zt6tCH
 yL63mtkqI2Ao+a9qnT04UuZbCKWUxBpPvJmWDf+D8xGW6Tgl2/Gy69jYKPstwbAzX5Wf
 syIA==
X-Gm-Message-State: APjAAAUa6/CYMK0Sb5NeePRcM8br0NeD9vBlHJWciyqwlYcvsZ/9MZQ8
 ADMN93ysI5aV7clQwxVIavvhjN63zq2/yw==
X-Google-Smtp-Source: APXvYqyaa/8pKVOirIxs8nvRTa/dlnmdXdHRmYO82nafmH/x48MXYQEFeYy0Ej14v8RM7hB6H5OXGg==
X-Received: by 2002:a1c:4e03:: with SMTP id g3mr30847251wmh.22.1576494559675; 
 Mon, 16 Dec 2019 03:09:19 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id x10sm20976131wrp.58.2019.12.16.03.09.18
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Dec 2019 03:09:19 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 11/34] watchdog/aspeed: Fix AST2600 frequency behaviour
Date: Mon, 16 Dec 2019 11:08:41 +0000
Message-Id: <20191216110904.30815-12-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191216110904.30815-1-peter.maydell@linaro.org>
References: <20191216110904.30815-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::332
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

From: Joel Stanley <joel@jms.id.au>

The AST2600 control register sneakily changed the meaning of bit 4
without anyone noticing. It no longer controls the 1MHz vs APB clock
select, and instead always runs at 1MHz.

The AST2500 was always 1MHz too, but it retained bit 4, making it read
only. We can model both using the same fixed 1MHz calculation.

Fixes: 6b2b2a703cad ("hw: wdt_aspeed: Add AST2600 support")
Reviewed-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Joel Stanley <joel@jms.id.au>
Signed-off-by: Cédric Le Goater <clg@kaod.org>
Message-id: 20191119141211.25716-10-clg@kaod.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/watchdog/wdt_aspeed.h |  1 +
 hw/watchdog/wdt_aspeed.c         | 21 +++++++++++++++++----
 2 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/include/hw/watchdog/wdt_aspeed.h b/include/hw/watchdog/wdt_aspeed.h
index dfedd7662dd..819c22993a6 100644
--- a/include/hw/watchdog/wdt_aspeed.h
+++ b/include/hw/watchdog/wdt_aspeed.h
@@ -47,6 +47,7 @@ typedef struct AspeedWDTClass {
     uint32_t ext_pulse_width_mask;
     uint32_t reset_ctrl_reg;
     void (*reset_pulse)(AspeedWDTState *s, uint32_t property);
+    void (*wdt_reload)(AspeedWDTState *s);
 }  AspeedWDTClass;
 
 #endif /* WDT_ASPEED_H */
diff --git a/hw/watchdog/wdt_aspeed.c b/hw/watchdog/wdt_aspeed.c
index d283d07d654..122aa8daaad 100644
--- a/hw/watchdog/wdt_aspeed.c
+++ b/hw/watchdog/wdt_aspeed.c
@@ -93,11 +93,11 @@ static uint64_t aspeed_wdt_read(void *opaque, hwaddr offset, unsigned size)
 
 }
 
-static void aspeed_wdt_reload(AspeedWDTState *s, bool pclk)
+static void aspeed_wdt_reload(AspeedWDTState *s)
 {
     uint64_t reload;
 
-    if (pclk) {
+    if (!(s->regs[WDT_CTRL] & WDT_CTRL_1MHZ_CLK)) {
         reload = muldiv64(s->regs[WDT_RELOAD_VALUE], NANOSECONDS_PER_SECOND,
                           s->pclk_freq);
     } else {
@@ -109,6 +109,16 @@ static void aspeed_wdt_reload(AspeedWDTState *s, bool pclk)
     }
 }
 
+static void aspeed_wdt_reload_1mhz(AspeedWDTState *s)
+{
+    uint64_t reload = s->regs[WDT_RELOAD_VALUE] * 1000ULL;
+
+    if (aspeed_wdt_is_enabled(s)) {
+        timer_mod(s->timer, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + reload);
+    }
+}
+
+
 static void aspeed_wdt_write(void *opaque, hwaddr offset, uint64_t data,
                              unsigned size)
 {
@@ -130,13 +140,13 @@ static void aspeed_wdt_write(void *opaque, hwaddr offset, uint64_t data,
     case WDT_RESTART:
         if ((data & 0xFFFF) == WDT_RESTART_MAGIC) {
             s->regs[WDT_STATUS] = s->regs[WDT_RELOAD_VALUE];
-            aspeed_wdt_reload(s, !(s->regs[WDT_CTRL] & WDT_CTRL_1MHZ_CLK));
+            awc->wdt_reload(s);
         }
         break;
     case WDT_CTRL:
         if (enable && !aspeed_wdt_is_enabled(s)) {
             s->regs[WDT_CTRL] = data;
-            aspeed_wdt_reload(s, !(data & WDT_CTRL_1MHZ_CLK));
+            awc->wdt_reload(s);
         } else if (!enable && aspeed_wdt_is_enabled(s)) {
             s->regs[WDT_CTRL] = data;
             timer_del(s->timer);
@@ -283,6 +293,7 @@ static void aspeed_2400_wdt_class_init(ObjectClass *klass, void *data)
     awc->offset = 0x20;
     awc->ext_pulse_width_mask = 0xff;
     awc->reset_ctrl_reg = SCU_RESET_CONTROL1;
+    awc->wdt_reload = aspeed_wdt_reload;
 }
 
 static const TypeInfo aspeed_2400_wdt_info = {
@@ -317,6 +328,7 @@ static void aspeed_2500_wdt_class_init(ObjectClass *klass, void *data)
     awc->ext_pulse_width_mask = 0xfffff;
     awc->reset_ctrl_reg = SCU_RESET_CONTROL1;
     awc->reset_pulse = aspeed_2500_wdt_reset_pulse;
+    awc->wdt_reload = aspeed_wdt_reload_1mhz;
 }
 
 static const TypeInfo aspeed_2500_wdt_info = {
@@ -336,6 +348,7 @@ static void aspeed_2600_wdt_class_init(ObjectClass *klass, void *data)
     awc->ext_pulse_width_mask = 0xfffff; /* TODO */
     awc->reset_ctrl_reg = AST2600_SCU_RESET_CONTROL1;
     awc->reset_pulse = aspeed_2500_wdt_reset_pulse;
+    awc->wdt_reload = aspeed_wdt_reload_1mhz;
 }
 
 static const TypeInfo aspeed_2600_wdt_info = {
-- 
2.20.1


