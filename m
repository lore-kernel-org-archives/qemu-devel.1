Return-Path: <SRS0=9ZvH=C5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 510BCC43466
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Sep 2020 18:04:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A51CE2078D
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Sep 2020 18:04:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ljsR5+zE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A51CE2078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60040 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kK3hd-0008M7-Oe
	for qemu-devel@archiver.kernel.org; Sun, 20 Sep 2020 14:04:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51116)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kK3bg-0001ul-7U; Sun, 20 Sep 2020 13:58:36 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:38258)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kK3be-00030s-Pn; Sun, 20 Sep 2020 13:58:35 -0400
Received: by mail-wr1-x441.google.com with SMTP id g4so10430451wrs.5;
 Sun, 20 Sep 2020 10:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=3AjXG5w656FN23Be/Hsok/QAzJiXXjNLyOG7YnfgnNo=;
 b=ljsR5+zEPNjJbO27y7Q7qhZ1LQUsrhg4fL7Z606vSZcSpwnH+4mnfuev6facTO8M3+
 J0LwcDklENnTTm/vJe4s5kwsh1bJyQWS+LWBfFLyggsstbrZ4d++rlFl+hh6lqKszud1
 2n3uwkFXyzbdEVgUG/E2FrkZUp+6xyBuYrKQ6UHbYlcoqW0nIkssZHgulwkzMOiDSCax
 v4hWWFyHhEmM8ZQ6stYFKc/14DmoltbNZQZZCQIyPEI8ghHgCg1dxsQkK4BcpgmLSAQx
 9SwEXl3bXYIgSC6W3UXF1tUSYy4sQF7TOBF8T4knZo+pWDg0KG3f4wfdF2C2kVo3c2os
 RUCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=3AjXG5w656FN23Be/Hsok/QAzJiXXjNLyOG7YnfgnNo=;
 b=lRv2mZNvDIkmzsKzDpJt0XNEOGbTgqzTyd2T4xQF0B5wZiAcCz9j+7d0+w79TwTFP4
 pB/6Kdv/07iVaq28gZ36KYyDemJps6WBEqG88YU54FKyCf+yXFYQTfpTps6rF3CXXm1w
 PhbMtfndMGgI8WulV//wAq4fuBf2QMKR7iipSu6e7S7fSsUE45f8Ihlc2GzM0+Vdxi+J
 YwyftQkJG4lOEB0s+zJ2NYYsjxQJ0Jfd8cohO3TpbwSnzgBW7Sf9CRjOalSTTVpmlGfY
 NztOf+Rm/qDuY3QHu9CVPnuHNGa5SCbmIyPD4yFBPel7r6xPH/EgLKNply50x4rQ351w
 mhxw==
X-Gm-Message-State: AOAM531wZBiLMY7bFVciXQYPPeK4pJQH90m02NPdsqVqyRpsAAh4xrUX
 EZ48NwkdOP+sG5jasxpxAYyN+NeL144=
X-Google-Smtp-Source: ABdhPJxKhDQPvWju88ruAaJaIPIVeSToQmeSh3ct0XSYEFOEu2z6vT6mI9tByBE0otRLL0ebMuY1ig==
X-Received: by 2002:adf:eb8f:: with SMTP id t15mr24945019wrn.417.1600624712806; 
 Sun, 20 Sep 2020 10:58:32 -0700 (PDT)
Received: from localhost.localdomain (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id u66sm15675781wme.12.2020.09.20.10.58.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 20 Sep 2020 10:58:32 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 4/7] hw/timer/bcm2835: Introduce BCM2835_SYSTIMER_COUNT
 definition
Date: Sun, 20 Sep 2020 19:58:22 +0200
Message-Id: <20200920175825.417680-5-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200920175825.417680-1-f4bug@amsat.org>
References: <20200920175825.417680-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Paul Zimmerman <pauldzim@gmail.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-arm@nongnu.org,
 Luc Michel <luc.michel@greensocs.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Use the BCM2835_SYSTIMER_COUNT definition instead of the
magic '4' value.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/timer/bcm2835_systmr.h | 4 +++-
 hw/timer/bcm2835_systmr.c         | 3 ++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/include/hw/timer/bcm2835_systmr.h b/include/hw/timer/bcm2835_systmr.h
index 64166bd7120..11272837a6b 100644
--- a/include/hw/timer/bcm2835_systmr.h
+++ b/include/hw/timer/bcm2835_systmr.h
@@ -18,6 +18,8 @@ typedef struct BCM2835SystemTimerState BCM2835SystemTimerState;
 DECLARE_INSTANCE_CHECKER(BCM2835SystemTimerState, BCM2835_SYSTIMER,
                          TYPE_BCM2835_SYSTIMER)
 
+#define BCM2835_SYSTIMER_COUNT 4
+
 struct BCM2835SystemTimerState {
     /*< private >*/
     SysBusDevice parent_obj;
@@ -28,7 +30,7 @@ struct BCM2835SystemTimerState {
 
     struct {
         uint32_t status;
-        uint32_t compare[4];
+        uint32_t compare[BCM2835_SYSTIMER_COUNT];
     } reg;
 };
 
diff --git a/hw/timer/bcm2835_systmr.c b/hw/timer/bcm2835_systmr.c
index 3387a6214a2..ff8c5536610 100644
--- a/hw/timer/bcm2835_systmr.c
+++ b/hw/timer/bcm2835_systmr.c
@@ -134,7 +134,8 @@ static const VMStateDescription bcm2835_systmr_vmstate = {
     .minimum_version_id = 1,
     .fields = (VMStateField[]) {
         VMSTATE_UINT32(reg.status, BCM2835SystemTimerState),
-        VMSTATE_UINT32_ARRAY(reg.compare, BCM2835SystemTimerState, 4),
+        VMSTATE_UINT32_ARRAY(reg.compare, BCM2835SystemTimerState,
+                             BCM2835_SYSTIMER_COUNT),
         VMSTATE_END_OF_LIST()
     }
 };
-- 
2.26.2


