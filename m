Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1153FC4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 16:09:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 622F221741
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 16:09:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CpazxWvv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 622F221741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37682 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUuCT-0003HH-3k
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 12:09:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37306)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kUu0i-0004LD-KV
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 11:57:16 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c]:44982)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kUu0g-0003rf-7o
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 11:57:16 -0400
Received: by mail-wr1-x42c.google.com with SMTP id t9so2774733wrq.11
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2020 08:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=Kd2iaAhnpbWYek8ibS9jm05FXtFf4HAgQQsgMjJ49rw=;
 b=CpazxWvvvC/iO2gMyFJIpuwwLI+yZXePTmIIpM/0lpoTdrUyGB3YKfJDRSPfNXO8Kq
 OKqxo6a6RhtzErj1Xm94jhfy2bamgG+wmiuX4znnD3oNqz2bMqIGj9m+ABIhP6TbnkSP
 3Q7nrD1K3iL3g9NvjRUnbJSua36R1cI8m8oTYuqqmrGtZKu944yd3SjfhR7iRfnE7ip7
 y395zrr8Z5vbvUJmBLNW23TBZc4iXvHFqUGaqoJBFjr/4eZhb+KQAzZrXo/Pj8jUVdqy
 d65+EVaIF1gG56FAjOzKSoHwdZi2PHF+36iOXnZZujkZlF7TAB7x8NQ6q5KmbsycutNd
 xx5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Kd2iaAhnpbWYek8ibS9jm05FXtFf4HAgQQsgMjJ49rw=;
 b=C5wMEDQmxq3SjfUcowodIUhl44RFsfcV736S1IIEDI/O1TszNOU5x5Fl9NqDWmYlM2
 Qc4QlfTxERvJZsPSCOL2kMh3eas6uTbQSMCEwpTXMtuuadqcxXaUUlctYC19XMgLLO6n
 tN0lp02jpOSmSKOrkH4LJAN8zt7Rs5maF8OvNySakqXpUCErzn2bmNDTUlMCBA57Jdpe
 MWL7jzNSjzQg/FCqlP47xwWkpHRwhEBN9b7oyEz8xi8MdOjvhlkiKUSjS4rx8nt3+WaI
 kdz7+/4gKqwO36E0gPcGEnFiUtPzouO2iO5VvhQ61N+eiXnFylyl+CNHKRn2KZxgkdUC
 w9fg==
X-Gm-Message-State: AOAM5330XsuBfnxIIQ/bE4HmlTPz+wJjsYFQ++qkDyvgU/98jmWqLPev
 zx5bUSBz3VimOvl8zzN8LHhm0+3hrEYRoQ==
X-Google-Smtp-Source: ABdhPJzVG9hlpZArWe2cjy7jxW3pu67HEKVVvdOXN3WviOQEJjXLxTgquu08i8+fulm5jUZZKe7nHw==
X-Received: by 2002:adf:fc83:: with SMTP id g3mr4267447wrr.200.1603209432518; 
 Tue, 20 Oct 2020 08:57:12 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id v6sm3780205wrp.69.2020.10.20.08.57.11
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2020 08:57:11 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 06/41] hw/timer/bcm2835: Rename variable holding CTRL_STATUS
 register
Date: Tue, 20 Oct 2020 16:56:21 +0100
Message-Id: <20201020155656.8045-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201020155656.8045-1-peter.maydell@linaro.org>
References: <20201020155656.8045-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42c.google.com
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

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

The variable holding the CTRL_STATUS register is misnamed
'status'. Rename it 'ctrl_status' to make it more obvious
this register is also used to control the peripheral.

Reviewed-by: Luc Michel <luc.michel@greensocs.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-id: 20201010203709.3116542-3-f4bug@amsat.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/timer/bcm2835_systmr.h | 2 +-
 hw/timer/bcm2835_systmr.c         | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/hw/timer/bcm2835_systmr.h b/include/hw/timer/bcm2835_systmr.h
index 43df7ee488c..f15788a78d8 100644
--- a/include/hw/timer/bcm2835_systmr.h
+++ b/include/hw/timer/bcm2835_systmr.h
@@ -27,7 +27,7 @@ struct BCM2835SystemTimerState {
     qemu_irq irq;
 
     struct {
-        uint32_t status;
+        uint32_t ctrl_status;
         uint32_t compare[BCM2835_SYSTIMER_COUNT];
     } reg;
 };
diff --git a/hw/timer/bcm2835_systmr.c b/hw/timer/bcm2835_systmr.c
index ff8c5536610..b234e83824f 100644
--- a/hw/timer/bcm2835_systmr.c
+++ b/hw/timer/bcm2835_systmr.c
@@ -30,7 +30,7 @@ REG32(COMPARE3,     0x18)
 
 static void bcm2835_systmr_update_irq(BCM2835SystemTimerState *s)
 {
-    bool enable = !!s->reg.status;
+    bool enable = !!s->reg.ctrl_status;
 
     trace_bcm2835_systmr_irq(enable);
     qemu_set_irq(s->irq, enable);
@@ -52,7 +52,7 @@ static uint64_t bcm2835_systmr_read(void *opaque, hwaddr offset,
 
     switch (offset) {
     case A_CTRL_STATUS:
-        r = s->reg.status;
+        r = s->reg.ctrl_status;
         break;
     case A_COMPARE0 ... A_COMPARE3:
         r = s->reg.compare[(offset - A_COMPARE0) >> 2];
@@ -82,7 +82,7 @@ static void bcm2835_systmr_write(void *opaque, hwaddr offset,
     trace_bcm2835_systmr_write(offset, value);
     switch (offset) {
     case A_CTRL_STATUS:
-        s->reg.status &= ~value; /* Ack */
+        s->reg.ctrl_status &= ~value; /* Ack */
         bcm2835_systmr_update_irq(s);
         break;
     case A_COMPARE0 ... A_COMPARE3:
@@ -133,7 +133,7 @@ static const VMStateDescription bcm2835_systmr_vmstate = {
     .version_id = 1,
     .minimum_version_id = 1,
     .fields = (VMStateField[]) {
-        VMSTATE_UINT32(reg.status, BCM2835SystemTimerState),
+        VMSTATE_UINT32(reg.ctrl_status, BCM2835SystemTimerState),
         VMSTATE_UINT32_ARRAY(reg.compare, BCM2835SystemTimerState,
                              BCM2835_SYSTIMER_COUNT),
         VMSTATE_END_OF_LIST()
-- 
2.20.1


