Return-Path: <SRS0=9ZvH=C5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9792C43463
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Sep 2020 18:07:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D9C4207EA
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Sep 2020 18:07:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CAXA9PBD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D9C4207EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36776 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kK3k2-00024v-9T
	for qemu-devel@archiver.kernel.org; Sun, 20 Sep 2020 14:07:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51142)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kK3bh-0001wg-U4; Sun, 20 Sep 2020 13:58:38 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:40890)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kK3bg-000319-8S; Sun, 20 Sep 2020 13:58:37 -0400
Received: by mail-wm1-x344.google.com with SMTP id k18so10313356wmj.5;
 Sun, 20 Sep 2020 10:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ru9JeznwCHjcxiZ+MKIheuMQIUXnKfc2N76bXeVgo8I=;
 b=CAXA9PBD0O4/H3X4XbousjqKShB4hQxlmxM0CgMq6vbvyVoG9vgGrac5Z2GpmLIGxv
 jIK3tOr2pjmTw5uwDduyf9jY/4YTm8CXOMZAW1k9dgDRH2ZoSc28W2ZBxgWK5sFz+DHK
 H7qtCCY+LQZkFLIWsY74xXAIdfpB/f83q+3+ENrE1UBVnVp+Bz8LIzwqPh8krGUt/4D7
 WMtW+teFpC5ejBJP5II9B2Xe1DEoCEaCywhzqkN7+4MA5BqFc9T8BCr0p3iyIOxPe315
 504Amm7/uRd8pv02QjH0dtJOG0F5zRHHcxi2gLub5qpQ+QE51JAUzc4BIWvkne2hYRq2
 Ky3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=ru9JeznwCHjcxiZ+MKIheuMQIUXnKfc2N76bXeVgo8I=;
 b=FUztD31T9yI1ZiD3l1uleh7/BJGD7nYZ8wDLc8K8uwY5lL6Pe/2cTyW6mvugF3G0dF
 rHdvRjTxePSzhAUSrOvLrlN75KezaH+Fsi0aw7OKpxJAdpB14ZOjruItt4GR9cyAb+qw
 ItKhmZ/iEAU5Rsbks6SLG9UqHZIznfAmR3JiSKtQS0YZ3uoEVoF77ukyh3N001nZpK3g
 j6whcSJYUWUi340/giv16YkXEWy5MtYLzG0fYuF9+6ZzyM70Ww/crKT73npCO+cDRqWj
 pqmrm1SWiFMNhThtfv+UDsEaWipZCJ85lxRBAs8ebNjVh/Ng7DscRk/lFy8iWT1IIPu5
 P98w==
X-Gm-Message-State: AOAM5318JpUR87nOhyZeRBYXes20FClCBVTY2f+brxKKnxH9gYYlgefE
 yTHYyvy/G1NauwAp2l+Klk8y+hvmwr8=
X-Google-Smtp-Source: ABdhPJynMvcFSSVbqNfH0yiRC4QjH+hY1zu9hCQgvN5/is0BF6i7e8Yf12uOaMPR0FSpltAlTxGIYw==
X-Received: by 2002:a7b:c095:: with SMTP id r21mr27847340wmh.133.1600624714171; 
 Sun, 20 Sep 2020 10:58:34 -0700 (PDT)
Received: from localhost.localdomain (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id u66sm15675781wme.12.2020.09.20.10.58.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 20 Sep 2020 10:58:33 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 5/7] hw/timer/bcm2835: Rename variable holding CTRL_STATUS
 register
Date: Sun, 20 Sep 2020 19:58:23 +0200
Message-Id: <20200920175825.417680-6-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200920175825.417680-1-f4bug@amsat.org>
References: <20200920175825.417680-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x344.google.com
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

The variable holding the CTRL_STATUS register is misnamed
'status'. Rename it 'ctrl_status' to make it more obvious
this register is also used to control the peripheral.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/timer/bcm2835_systmr.h | 2 +-
 hw/timer/bcm2835_systmr.c         | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/hw/timer/bcm2835_systmr.h b/include/hw/timer/bcm2835_systmr.h
index 11272837a6b..e0db9e9e12b 100644
--- a/include/hw/timer/bcm2835_systmr.h
+++ b/include/hw/timer/bcm2835_systmr.h
@@ -29,7 +29,7 @@ struct BCM2835SystemTimerState {
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
2.26.2


