Return-Path: <SRS0=wvJ7=YB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9692C4360C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 17:51:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6415206B6
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 17:51:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H8pXsMwd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6415206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59524 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHtdv-00032E-SN
	for qemu-devel@archiver.kernel.org; Tue, 08 Oct 2019 13:51:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49205)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iHt7k-0006vb-0e
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 13:18:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iHt7i-0002T0-QK
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 13:18:11 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:35831)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iHt7i-0002SZ-Jy
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 13:18:10 -0400
Received: by mail-wr1-x441.google.com with SMTP id v8so20345485wrt.2
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2019 10:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=meYD3iu+SqBh5zzbJLsZrb0S302wohjRCr6pGE0T3yQ=;
 b=H8pXsMwdnFTERlEMgNCj9E+kEDcEH9WKgDy1O27HZmsLslyMNGkegSx71gY5fnQ1Mu
 uNxAOlnihYFw1PJA5IaK2/AA+Mb1RdG6i9YfzbOUhpSj/x/LW+OPSeRtxo4TKb/gBvmV
 HoTcC6mVAMSpgIv5hWlt1M5LCOf8AqSmLoTI6VbTHzn+xfLvZ/gmL5BJIwhdpbrca29Q
 a1x8AB00i7ZJMu4XRWhhytllKZR8f7qttFnodKMqYMdWRT2hRvINqe2zoKr2eGwUJ2c0
 4h9N7NELr8/686UY6gvIEIz4gEQ3T+0pBG7YxIBEg/RDH21RU4PFECfbOwYpCchWpwrV
 F+BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=meYD3iu+SqBh5zzbJLsZrb0S302wohjRCr6pGE0T3yQ=;
 b=C52ntmC1fUqbzVgDdUDKHxMJlwZsiTF/sa+jjeNld+L7HYHzFOMZbEQ0tF1pNRlEQG
 IxC9sanE3bNxt3IxUy5bTMPzhAlDJ96WRsIDDx1+s+OZVgNKpN8y6oq8+19PE2fMGl49
 V7Bfk5IzAxLjTv1xhKgf5UNUserwuw+Q328vuvWHjvsvcaRlqqDh2YBBvO7XuO3MFa6e
 DNyRtiLsuV29yjwq2VU5wYagG1zGyyxklEIhNroBBrPhiqIM96HiYSmpBk0GgbGp4n/o
 CRLqoxqS0vPUMmZ2dBiBp6Xob1eM5kd/ei4VU8rX8f5wWXVkwJajRI1wScrKwgdMVYZQ
 ONHg==
X-Gm-Message-State: APjAAAWlLiJlyeihku9HZ1YQ/bZWD4yqIi6yfJL3XmklV4KQ61KkKgg3
 cyyT4HOowIzGF3npTAXaXmLKug==
X-Google-Smtp-Source: APXvYqzQo4uV3ZAGpZhIjum9TlMLdDZNun0ciWrlrbEZY3x83+LJuFP7R9AW1OMXp34IwY6LkZ5HcA==
X-Received: by 2002:adf:f684:: with SMTP id v4mr25276739wrp.155.1570555089730; 
 Tue, 08 Oct 2019 10:18:09 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id z9sm19135541wrl.35.2019.10.08.10.18.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Oct 2019 10:18:09 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 21/21] hw/net/lan9118.c: Switch to transaction-based ptimer
 API
Date: Tue,  8 Oct 2019 18:17:40 +0100
Message-Id: <20191008171740.9679-22-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191008171740.9679-1-peter.maydell@linaro.org>
References: <20191008171740.9679-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Switch the cmsdk-apb-watchdog code away from bottom-half based
ptimers to the new transaction-based ptimer API.  This just requires
adding begin/commit calls around the various places that modify the
ptimer state, and using the new ptimer_init() function to create the
timer.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/net/lan9118.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/hw/net/lan9118.c b/hw/net/lan9118.c
index 0ea51433dca..ed551f2178b 100644
--- a/hw/net/lan9118.c
+++ b/hw/net/lan9118.c
@@ -21,7 +21,6 @@
 #include "hw/ptimer.h"
 #include "hw/qdev-properties.h"
 #include "qemu/log.h"
-#include "qemu/main-loop.h"
 #include "qemu/module.h"
 /* For crc32 */
 #include <zlib.h>
@@ -450,8 +449,10 @@ static void lan9118_reset(DeviceState *d)
     s->e2p_data = 0;
     s->free_timer_start = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) / 40;
 
+    ptimer_transaction_begin(s->timer);
     ptimer_stop(s->timer);
     ptimer_set_count(s->timer, 0xffff);
+    ptimer_transaction_commit(s->timer);
     s->gpt_cfg = 0xffff;
 
     s->mac_cr = MAC_CR_PRMS;
@@ -1100,6 +1101,7 @@ static void lan9118_writel(void *opaque, hwaddr offset,
         break;
     case CSR_GPT_CFG:
         if ((s->gpt_cfg ^ val) & GPT_TIMER_EN) {
+            ptimer_transaction_begin(s->timer);
             if (val & GPT_TIMER_EN) {
                 ptimer_set_count(s->timer, val & 0xffff);
                 ptimer_run(s->timer, 0);
@@ -1107,6 +1109,7 @@ static void lan9118_writel(void *opaque, hwaddr offset,
                 ptimer_stop(s->timer);
                 ptimer_set_count(s->timer, 0xffff);
             }
+            ptimer_transaction_commit(s->timer);
         }
         s->gpt_cfg = val & (GPT_TIMER_EN | 0xffff);
         break;
@@ -1328,7 +1331,6 @@ static void lan9118_realize(DeviceState *dev, Error **errp)
 {
     SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
     lan9118_state *s = LAN9118(dev);
-    QEMUBH *bh;
     int i;
     const MemoryRegionOps *mem_ops =
             s->mode_16bit ? &lan9118_16bit_mem_ops : &lan9118_mem_ops;
@@ -1349,10 +1351,11 @@ static void lan9118_realize(DeviceState *dev, Error **errp)
     s->pmt_ctrl = 1;
     s->txp = &s->tx_packet;
 
-    bh = qemu_bh_new(lan9118_tick, s);
-    s->timer = ptimer_init_with_bh(bh, PTIMER_POLICY_DEFAULT);
+    s->timer = ptimer_init(lan9118_tick, s, PTIMER_POLICY_DEFAULT);
+    ptimer_transaction_begin(s->timer);
     ptimer_set_freq(s->timer, 10000);
     ptimer_set_limit(s->timer, 0xffff, 1);
+    ptimer_transaction_commit(s->timer);
 }
 
 static Property lan9118_properties[] = {
-- 
2.20.1


