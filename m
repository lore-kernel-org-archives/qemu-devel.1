Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59744C4CECE
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 16:41:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2762520663
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 16:41:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xO4ttzA7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2762520663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53518 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iK3PG-0000vL-Os
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 12:41:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37269)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iK2qY-0004uT-0c
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:05:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iK2qW-00080t-Nh
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:05:21 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329]:33072)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iK2qW-000809-HI
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:05:20 -0400
Received: by mail-wm1-x329.google.com with SMTP id r17so340906wme.0
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 09:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=iiDnWjAuL+q3SPrkybaKgqC44Xx0zFDKks4iQWMtalg=;
 b=xO4ttzA7Dr3Dv+PWdldoxbkUpecJaSCpesCDKa2f5T+/GirrrPCW0iSmH5xmky8c42
 WuiloviAKShgrcjdGq6ZVxWQiVyaIqwSV+G6/tYfrcMwP9kBZU9TQUIQt6RnvnbrHDAg
 Meyy4/EU08OKabKblwxjzIebi1c6pWe7QBlY3nwUwdW5ZoWFE4qIPUcJoo5lUkSU+z9j
 4s8ok7GxsOKmodDHY+MPiu7HaQEawHDF1R7EQW6Ddnu8kJcfISYgqh7UWua6iea1JgaX
 DPebTM4yZN8d9QoNF6OEBA5C89stoawVZxhl0EU1sEfnphIp4DSALSz99YYGcuPUZf44
 rbgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=iiDnWjAuL+q3SPrkybaKgqC44Xx0zFDKks4iQWMtalg=;
 b=rigBmkGmPEv/mosdxxllhxtBXEMLHeBKKqu0B5sME/MANZrKwl9BlWYN2MxZILgpqR
 I46iQEZW5Y13Y7b6WK7x8C2zwVFcFXVM+MqeKKPlc8zKBFG8qzGOBN7bKA7XTEnwvDOO
 pUe9iUUBn+PJBj6JDLbSHqs35lu3YmG+1JtTRPlO/gmQeYUoE3CjqIUOK34xMmI/f3hX
 8y4qoYKY7jqgOniV1YHQzg8ai0tnmX462u8OZ/gbpXTsN/N3iklwcMXqDENaAOnD2w5Z
 Uq37PrtINfqKeaFtnT2TeZWmdUfrtydSY4W/sW35QcOvBoGJaz9dRTKBfCpVDfJ1g8yt
 2Q7w==
X-Gm-Message-State: APjAAAVXTRmMUW/9gDC1LYNxmWn/Ks8PqH4N+h8386YBpRA3ZfFqFawZ
 /C+DIAO8no8K+5xztadoVxzywtRhXLdvWw==
X-Google-Smtp-Source: APXvYqw3KKSOd+0NjdPXamysiX6cSiOeqStJAXpJrn33YdNTEAdrn+Rm7RuSsaXOiXQpmBwOZC9StA==
X-Received: by 2002:a1c:8043:: with SMTP id b64mr15107626wmd.145.1571069119256; 
 Mon, 14 Oct 2019 09:05:19 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id 5sm18029779wrk.86.2019.10.14.09.05.18
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2019 09:05:18 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 44/68] aspeed/timer: Add support for control register 3
Date: Mon, 14 Oct 2019 17:03:40 +0100
Message-Id: <20191014160404.19553-45-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191014160404.19553-1-peter.maydell@linaro.org>
References: <20191014160404.19553-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::329
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

From: Cédric Le Goater <clg@kaod.org>

The AST2500 timer has a third control register that is used to
implement a set-to-clear feature for the main control register.

This models the behaviour expected by the AST2500 while maintaining
the same behaviour for the AST2400.

The vmstate version is not increased yet because the structure is
modified again in the following patches.

Based on previous work from Joel Stanley.

Signed-off-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Joel Stanley <joel@jms.id.au>
Message-id: 20190925143248.10000-6-clg@kaod.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/timer/aspeed_timer.h |  1 +
 hw/timer/aspeed_timer.c         | 19 +++++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/include/hw/timer/aspeed_timer.h b/include/hw/timer/aspeed_timer.h
index a791fee276f..1e0288ebc49 100644
--- a/include/hw/timer/aspeed_timer.h
+++ b/include/hw/timer/aspeed_timer.h
@@ -58,6 +58,7 @@ typedef struct AspeedTimerCtrlState {
 
     uint32_t ctrl;
     uint32_t ctrl2;
+    uint32_t ctrl3;
     AspeedTimer timers[ASPEED_TIMER_NR_TIMERS];
 
     AspeedSCUState *scu;
diff --git a/hw/timer/aspeed_timer.c b/hw/timer/aspeed_timer.c
index c78bc1bd2d2..d70e78a0293 100644
--- a/hw/timer/aspeed_timer.c
+++ b/hw/timer/aspeed_timer.c
@@ -498,6 +498,8 @@ static uint64_t aspeed_2500_timer_read(AspeedTimerCtrlState *s, hwaddr offset)
 
     switch (offset) {
     case 0x38:
+        value = s->ctrl3 & BIT(0);
+        break;
     case 0x3C:
     default:
         qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset 0x%" HWADDR_PRIx "\n",
@@ -511,9 +513,24 @@ static uint64_t aspeed_2500_timer_read(AspeedTimerCtrlState *s, hwaddr offset)
 static void aspeed_2500_timer_write(AspeedTimerCtrlState *s, hwaddr offset,
                                     uint64_t value)
 {
+    const uint32_t tv = (uint32_t)(value & 0xFFFFFFFF);
+    uint8_t command;
+
     switch (offset) {
     case 0x38:
+        command = (value >> 1) & 0xFF;
+        if (command == 0xAE) {
+            s->ctrl3 = 0x1;
+        } else if (command == 0xEA) {
+            s->ctrl3 = 0x0;
+        }
+        break;
     case 0x3C:
+        if (s->ctrl3 & BIT(0)) {
+            aspeed_timer_set_ctrl(s, s->ctrl & ~tv);
+        }
+        break;
+
     default:
         qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset 0x%" HWADDR_PRIx "\n",
                 __func__, offset);
@@ -574,6 +591,7 @@ static void aspeed_timer_reset(DeviceState *dev)
     }
     s->ctrl = 0;
     s->ctrl2 = 0;
+    s->ctrl3 = 0;
 }
 
 static const VMStateDescription vmstate_aspeed_timer = {
@@ -597,6 +615,7 @@ static const VMStateDescription vmstate_aspeed_timer_state = {
     .fields = (VMStateField[]) {
         VMSTATE_UINT32(ctrl, AspeedTimerCtrlState),
         VMSTATE_UINT32(ctrl2, AspeedTimerCtrlState),
+        VMSTATE_UINT32(ctrl3, AspeedTimerCtrlState),
         VMSTATE_STRUCT_ARRAY(timers, AspeedTimerCtrlState,
                              ASPEED_TIMER_NR_TIMERS, 1, vmstate_aspeed_timer,
                              AspeedTimer),
-- 
2.20.1


