Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B50D5C5B578
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 02:50:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DCDE21479
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 02:50:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P9bqeS87"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DCDE21479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47202 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hi8RA-00008h-4y
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 22:22:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58204)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hi4We-0003GZ-Qi
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 18:11:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hi4Wb-00037o-Ig
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 18:11:51 -0400
Received: from mail-wm1-f46.google.com ([209.85.128.46]:52660)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hi4WY-00032R-H1
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 18:11:47 -0400
Received: by mail-wm1-f46.google.com with SMTP id s3so981094wms.2
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2019 15:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=xbk2+L8i1dH/Jdn/9lZBOUO8xsAaRhCxthSSE1bfYCw=;
 b=P9bqeS87YK3ujDL5fg/rcLxtJ0BE/g7M20Lz1gOn4ateb+R0lRC+ed4Qk0YHY0DRJU
 gmiNDyn+e/R6WapZ7RKivjCxJMZucK8loZr2CriToyNqsIntC9pm3TQ7A6vGqK3lFhFu
 5cBgIryhS62NdxIiHqefcR6gKmMae2Aqp0gvmgKyftMTjYfww7uVHYw1+L+T2/9SvDA4
 kuaTqsCX7D6aUl56MjkqeG5Jj4s3vaWc4dxtHf+gBTcrLOHctnnmoQTiwYNKKD4rf2Sl
 a0O8U6gVUr+zrf/6rZxYh05yee7vRyIFQqd39SRcGtEkMzq6aQauSrCnpalxJMaOftl+
 6dDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=xbk2+L8i1dH/Jdn/9lZBOUO8xsAaRhCxthSSE1bfYCw=;
 b=bDYlD2K15LT/8BwjAV/MadNOQR53Xuf1tcNOHFzpJyeWqmX/kaE1VWVTbtBy3eHaT3
 S4UPF3VzUHnol4twBE5fbAlAq4F4j1Dda4W7pl7dVQ2X29PCowl0RQxj3j9kqMmdBULs
 5m+hTtHKM8OkqeD7+li1XdSzz2WdyrL+ds3JKFiV82hv//dshAD3jK+Hel4PAOiRfEC0
 ZVRzzYfkHqok2LlsvjFUJsB2bZdpuOJZfZka6Abw8DXfe7QKuESjvbpc/eBufEY7cFuK
 eALNTKGQeHi4b1p07pfU5gZEWH3hBh6YncaK6AnhtdsCrERH8Mztw64l23AHZHw6qFv/
 MKLg==
X-Gm-Message-State: APjAAAV6DIjV2UDM9SciT7kzFPS39h4WZC52GL6TMeEqIt+D5ZSjFNtC
 Pxs2au/1/8+H3wPaecd1cQjvqHzqZQ+5pg==
X-Google-Smtp-Source: APXvYqymY/shN1UstWvOFuFKi9V+Li53LO2QxHj+AgiRps3PLmg/jCviO1xZ5EF1FfjY9wQQoELYcA==
X-Received: by 2002:a1c:c747:: with SMTP id x68mr131327wmf.138.1561999212006; 
 Mon, 01 Jul 2019 09:40:12 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id o6sm26573508wra.27.2019.07.01.09.40.11
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 01 Jul 2019 09:40:11 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon,  1 Jul 2019 17:39:22 +0100
Message-Id: <20190701163943.22313-26-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190701163943.22313-1-peter.maydell@linaro.org>
References: <20190701163943.22313-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.46
Subject: [Qemu-devel] [PULL 25/46] aspeed: Link SCU to the watchdog
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

The ast2500 uses the watchdog to reset the SDRAM controller. This
operation is usually performed by u-boot's memory training procedure,
and it is enabled by setting a bit in the SCU and then causing the
watchdog to expire. Therefore, we need the watchdog to be able to
access the SCU's register space.

This causes the watchdog to not perform a system reset when the bit is
set. In the future it could perform a reset of the SDMC model.

Signed-off-by: Joel Stanley <joel@jms.id.au>
Signed-off-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-id: 20190621065242.32535-1-joel@jms.id.au
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/watchdog/wdt_aspeed.h |  1 +
 hw/arm/aspeed_soc.c              |  2 ++
 hw/watchdog/wdt_aspeed.c         | 20 ++++++++++++++++++++
 3 files changed, 23 insertions(+)

diff --git a/include/hw/watchdog/wdt_aspeed.h b/include/hw/watchdog/wdt_aspeed.h
index 88d8be4f78d..daef0c0e230 100644
--- a/include/hw/watchdog/wdt_aspeed.h
+++ b/include/hw/watchdog/wdt_aspeed.h
@@ -27,6 +27,7 @@ typedef struct AspeedWDTState {
     MemoryRegion iomem;
     uint32_t regs[ASPEED_WDT_REGS_MAX];
 
+    AspeedSCUState *scu;
     uint32_t pclk_freq;
     uint32_t silicon_rev;
     uint32_t ext_pulse_width_mask;
diff --git a/hw/arm/aspeed_soc.c b/hw/arm/aspeed_soc.c
index 443e4c49f21..c6fb3700f27 100644
--- a/hw/arm/aspeed_soc.c
+++ b/hw/arm/aspeed_soc.c
@@ -235,6 +235,8 @@ static void aspeed_soc_init(Object *obj)
                               sizeof(s->wdt[i]), TYPE_ASPEED_WDT);
         qdev_prop_set_uint32(DEVICE(&s->wdt[i]), "silicon-rev",
                                     sc->info->silicon_rev);
+        object_property_add_const_link(OBJECT(&s->wdt[i]), "scu",
+                                       OBJECT(&s->scu), &error_abort);
     }
 
     for (i = 0; i < ASPEED_MACS_NUM; i++) {
diff --git a/hw/watchdog/wdt_aspeed.c b/hw/watchdog/wdt_aspeed.c
index 4a8409f0daf..57fe24ae6b1 100644
--- a/hw/watchdog/wdt_aspeed.c
+++ b/hw/watchdog/wdt_aspeed.c
@@ -44,6 +44,9 @@
 
 #define WDT_RESTART_MAGIC               0x4755
 
+#define SCU_RESET_CONTROL1              (0x04 / 4)
+#define    SCU_RESET_SDRAM              BIT(0)
+
 static bool aspeed_wdt_is_enabled(const AspeedWDTState *s)
 {
     return s->regs[WDT_CTRL] & WDT_CTRL_ENABLE;
@@ -222,6 +225,13 @@ static void aspeed_wdt_timer_expired(void *dev)
 {
     AspeedWDTState *s = ASPEED_WDT(dev);
 
+    /* Do not reset on SDRAM controller reset */
+    if (s->scu->regs[SCU_RESET_CONTROL1] & SCU_RESET_SDRAM) {
+        timer_del(s->timer);
+        s->regs[WDT_CTRL] = 0;
+        return;
+    }
+
     qemu_log_mask(CPU_LOG_RESET, "Watchdog timer expired.\n");
     watchdog_perform_action();
     timer_del(s->timer);
@@ -233,6 +243,16 @@ static void aspeed_wdt_realize(DeviceState *dev, Error **errp)
 {
     SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
     AspeedWDTState *s = ASPEED_WDT(dev);
+    Error *err = NULL;
+    Object *obj;
+
+    obj = object_property_get_link(OBJECT(dev), "scu", &err);
+    if (!obj) {
+        error_propagate(errp, err);
+        error_prepend(errp, "required link 'scu' not found: ");
+        return;
+    }
+    s->scu = ASPEED_SCU(obj);
 
     if (!is_supported_silicon_rev(s->silicon_rev)) {
         error_setg(errp, "Unknown silicon revision: 0x%" PRIx32,
-- 
2.20.1


