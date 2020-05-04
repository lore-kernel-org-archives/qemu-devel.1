Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 600BDC3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 07:32:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29D6420735
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 07:32:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cTflwZCz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29D6420735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47448 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVVac-0001iD-EE
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 03:32:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60260)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jVVWi-00065O-G7; Mon, 04 May 2020 03:28:32 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d]:40709)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jVVWh-00064H-RQ; Mon, 04 May 2020 03:28:32 -0400
Received: by mail-wm1-x32d.google.com with SMTP id u16so7760211wmc.5;
 Mon, 04 May 2020 00:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=lNnVPTok0KuGhI7WlF3rtisA4RGSH6dUX5yCMf1ZDmM=;
 b=cTflwZCzKRKiU4Lmyl6EZYrYM9DmjJJAK6cQfuTgXJHqKXTl8dhMrKemOtI2vvGpF0
 e6/8JvmmK7sD0+1y57LP12cNRtw6Cgg1jYv/eog6377XJuSwaiRicCs/RzjP6LZOkTda
 dvYYpHPEQhwdEBRrBg2w/7JeQsRWBL7d4+hcDHxVtVQNOgeppX12mKesAXiTa0qTnGup
 /VnyNOERebsAc5uKpmYXBs0wJ9cOElhc+BHZIwALplCy/WdVNWc7XlaNm5OdoidlgVQI
 jOIDW+dW2EiUzrrko66cwhTjK2XHUFilAEIGtP8jeOzjrkeDhyD9nKeEM64t9uA2lmTI
 qr8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=lNnVPTok0KuGhI7WlF3rtisA4RGSH6dUX5yCMf1ZDmM=;
 b=PCf22RDpYDi2WvjLHngUatfUrYrbSzbMl/5SsTNcJjBw4ug/Z1sdUCZnAzvOSdY+jS
 2VJogfldP5Z6ebekA6DCQcm8Oj9UyJPLWfONrR/0cIwVOow+6iGhR0qkoQn3JX1aw3Ba
 ZBaLwgk/9TuNc0V7uGHwXbbxHKQRc7kOXrzaf3dnurFzI7sAgYOuj8GoAhseVcG3U2Pz
 rxtWL2hulK5tSSNuwgK0sNuN7ST3AljSOnLAZDDgu6wcOt1rzd9GSdLJR4g4AYwHn5gY
 cQCzgdPOYqhYWJgAKE/sgyR9CThtkkMkMXodTrvByjg9vg9V18JzfQCUytcEuCx8ygYF
 lsWQ==
X-Gm-Message-State: AGi0PubRCzBT2AA0CFkmLJe330gxRuplOptjPGrBclONwT1EZDtJrvSN
 MoBQKJd6JCW1K/cQfCx7Xc5INoXM
X-Google-Smtp-Source: APiQypLEM+7UTXeD/OPUoPdHQsT0mWIOS3SNZwEIMtixgKg8xMPakLTwRJFF4fAwZXGdPoV4NfExTg==
X-Received: by 2002:a7b:c459:: with SMTP id l25mr12760238wmi.52.1588577310044; 
 Mon, 04 May 2020 00:28:30 -0700 (PDT)
Received: from x1w.redhat.com (26.red-88-21-207.staticip.rima-tde.net.
 [88.21.207.26])
 by smtp.gmail.com with ESMTPSA id w83sm12590159wmb.37.2020.05.04.00.28.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2020 00:28:29 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 4/4] hw/timer/nrf51_timer: Add trace event of counter value
 update
Date: Mon,  4 May 2020 09:28:22 +0200
Message-Id: <20200504072822.18799-5-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200504072822.18799-1-f4bug@amsat.org>
References: <20200504072822.18799-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x32d.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Steffen=20G=C3=B6rtz?= <contrib@steffen-goertz.de>,
 qemu-arm@nongnu.org, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add trace event to display timer's counter value updates.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/timer/nrf51_timer.c | 1 +
 hw/timer/trace-events  | 1 +
 2 files changed, 2 insertions(+)

diff --git a/hw/timer/nrf51_timer.c b/hw/timer/nrf51_timer.c
index 38cea0542e..42be79c736 100644
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
index 43b605cc75..80ea197594 100644
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
2.21.3


