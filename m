Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7773CC54E4A
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 13:37:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 466A5206F9
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 13:37:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vS+1zXsq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 466A5206F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52620 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jY8cc-0007Oi-DF
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 09:37:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48922)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jY8ZW-0001pO-36
 for qemu-devel@nongnu.org; Mon, 11 May 2020 09:34:22 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433]:38147)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jY8ZV-00070e-8R
 for qemu-devel@nongnu.org; Mon, 11 May 2020 09:34:17 -0400
Received: by mail-wr1-x433.google.com with SMTP id x17so11009876wrt.5
 for <qemu-devel@nongnu.org>; Mon, 11 May 2020 06:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=HrUC6cR46kql6q+CIiU3E4k07J5wqDy/mLv107e44a0=;
 b=vS+1zXsqdRaCbSbH4/Exr56iPVokExB0A12osZyDV4G2LOGQeOJd5E+KtCQI61dmli
 zK/5FQOettW6yozRD3XbPR+kwXLgSY6ZDwNc5iUbLXOvkGVgkRbhSzkZ5ZsRSiz7+5W2
 Aa8f6JOqYsXFYcx2XiLpK7yHdOqXVlhI617j9bbNbPrlqH1vRXzxkokP5+bE8x8rgeq6
 aVyJL/B/utMLtNZy5KqcAliriGMdLzYyl4ns9QcZWiOHnjY70Y6DBbNWwVhSv4ahpFFN
 Y4ObHRFoFF3JrubttngwXwC58gpEOqktLmd/pdIJJoMXVIGHtEGHhD0ajMGhowNj/xaE
 tP6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=HrUC6cR46kql6q+CIiU3E4k07J5wqDy/mLv107e44a0=;
 b=pLGjiYmd3YI049J9qzqIpyCj+eptAQWZxQPef7regFWWQ/5O6BJUT/0T9V/r0uMBI9
 uwCFZIHQFvLsj+R4wCf75Nhc2Xyemb+vsyApPEGAnoxmPvztyLOpHjVG1y1cglGxMSif
 /g8BV/S8Y+GVk+0NIoni/GQxK4w4Cr4oXEkIpr7VsjVpf1g0cp/Ie4S+UINHM+YeGw0O
 QhBumusa6WbuZAU26c1Lwxb92eoeX4DeF96yMnZ+CMlDS1fDbWhDhkJNa9zoDHEQjRe5
 hhJ2hN0LdLKiI2Q3Jlyw9YogQD6h0JUeyJjudVCYbeZR9B/TpSLM4HnzyiCCkLmeg2A8
 AZPA==
X-Gm-Message-State: AGi0PubSG/0IKtS7lPCl0sA7LIu9tszcliLleCKvDhu7FnjlhCIyUS+8
 Y2xGUf6ntcKdHzzK+Eemp9fwzLS6xBhDEA==
X-Google-Smtp-Source: APiQypIGSqwF8ilm+W7jtQNd1bOY3idC/JEaAGxBiUrxJvgNZwh17MNaQ+KNrX1uYT0bGCxdqYh+8w==
X-Received: by 2002:adf:f3cc:: with SMTP id g12mr7908730wrp.427.1589204055443; 
 Mon, 11 May 2020 06:34:15 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id m3sm2154818wrn.96.2020.05.11.06.34.14
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2020 06:34:14 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 07/34] hw/timer/nrf51_timer: Add trace event of counter value
 update
Date: Mon, 11 May 2020 14:33:38 +0100
Message-Id: <20200511133405.5275-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200511133405.5275-1-peter.maydell@linaro.org>
References: <20200511133405.5275-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x433.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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

Add trace event to display timer's counter value updates.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200504072822.18799-5-f4bug@amsat.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/timer/nrf51_timer.c | 1 +
 hw/timer/trace-events  | 1 +
 2 files changed, 2 insertions(+)

diff --git a/hw/timer/nrf51_timer.c b/hw/timer/nrf51_timer.c
index 38cea0542e1..42be79c7363 100644
--- a/hw/timer/nrf51_timer.c
+++ b/hw/timer/nrf51_timer.c
@@ -240,6 +240,7 @@ static void nrf51_timer_write(void *opaque, hwaddr offset,
 
             idx = (offset - NRF51_TIMER_TASK_CAPTURE_0) / 4;
             s->cc[idx] = s->counter;
+            trace_nrf51_timer_set_count(s->id, idx, s->counter);
         }
         break;
     case NRF51_TIMER_EVENT_COMPARE_0 ... NRF51_TIMER_EVENT_COMPARE_3:
diff --git a/hw/timer/trace-events b/hw/timer/trace-events
index 43b605cc759..80ea197594e 100644
--- a/hw/timer/trace-events
+++ b/hw/timer/trace-events
@@ -69,6 +69,7 @@ cmsdk_apb_dualtimer_reset(void) "CMSDK APB dualtimer: reset"
 # nrf51_timer.c
 nrf51_timer_read(uint8_t timer_id, uint64_t addr, uint32_t value, unsigned size) "timer %u read addr 0x%" PRIx64 " data 0x%" PRIx32 " size %u"
 nrf51_timer_write(uint8_t timer_id, uint64_t addr, uint32_t value, unsigned size) "timer %u write addr 0x%" PRIx64 " data 0x%" PRIx32 " size %u"
+nrf51_timer_set_count(uint8_t timer_id, uint8_t counter_id, uint32_t value) "timer %u counter %u count 0x%" PRIx32
 
 # bcm2835_systmr.c
 bcm2835_systmr_irq(bool enable) "timer irq state %u"
-- 
2.20.1


