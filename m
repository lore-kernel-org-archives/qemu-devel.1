Return-Path: <SRS0=5nOY=BY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A30CC433E3
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 16:40:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35B87204EA
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 16:40:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bWkRrO9f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35B87204EA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60744 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6ckw-0005QI-FP
	for qemu-devel@archiver.kernel.org; Fri, 14 Aug 2020 12:40:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46560)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k6cjr-0004CL-Lr
 for qemu-devel@nongnu.org; Fri, 14 Aug 2020 12:39:31 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:36645)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k6cjp-0002KH-Q0
 for qemu-devel@nongnu.org; Fri, 14 Aug 2020 12:39:31 -0400
Received: by mail-wr1-x442.google.com with SMTP id 88so8910733wrh.3
 for <qemu-devel@nongnu.org>; Fri, 14 Aug 2020 09:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=+vZKMxDAk/vtC5bjb2De5DWR9pVCk7ac3nopYj/xQZQ=;
 b=bWkRrO9fkbz+xIXQnkj7lKtLTDatmyFCxnl36tMgE4/cQKBlGyO21nPKBLnYfMUVw1
 MOSiyhuLp+y+hCPTfkpVo086Y3czlnHq+83gfbOaRsAHHcRm4cnJ3yW/FFFmI0tXZYft
 mw+zVbNkM99mO1/4gUvSgAXxKD4vazy8q9e4ZE8QQyYUV4Rx+c2/mmj7keZsWUocscS6
 RX4glLOiEXnCFiEMFltHObkuTX1XqEQ0zmcVVnGMeFiMQFFk/9iPLJ6c+5Qkv9FE6vMQ
 3jwb3G077h+F8qOl6n/qnSbLWHyshS++UWzX6FgQjaHeRCTh/HlRsq8q+LXHtHhM1xDG
 u5tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=+vZKMxDAk/vtC5bjb2De5DWR9pVCk7ac3nopYj/xQZQ=;
 b=pcsqCN/I67Z0pAjq/8L4nGPv2U3YamzHBJKTL9jV0YZRRgFOyGsX1a64N24tWJQf9h
 xV1gbwJr/9ZIos8LzNzfnGXKELbe0qvT4HpDuws8BsmUJBUM7ZFoyyQna0QsJPW1AlJq
 /lXLD37k/+v44oY4KD3rBEN2tXUPTJ+bSYsvoEf2caltXxEC0xbw951D2ItF+3pRQ53A
 Z+gkYhltlFUlDgV8W8V3HJaN7IorRUDufxwkG0vekleovnTjrNkujCv7enHdwT2VK0gj
 5vj0XfK9qcdCXu7nijMOCQRqTi8Wfcb8yXx3t5Tyfnh1l+jlXao+oBtT6F171WF4FKSk
 iwIA==
X-Gm-Message-State: AOAM532xft8N+K40syKl11+VJX5I0dcTlRaFWn0Bp125+mfSCEAGKjbh
 nmBkvoGnObHSehjG3vEHneNYzo2N8lo=
X-Google-Smtp-Source: ABdhPJyrg9H8J6ymKpOmZ85sTdvxJWOvdKByTux6BmHVIIBM9jYb54drThGHhVHuK92X+DgjgO/G5g==
X-Received: by 2002:adf:edd0:: with SMTP id v16mr3710820wro.271.1597423168411; 
 Fri, 14 Aug 2020 09:39:28 -0700 (PDT)
Received: from localhost.localdomain (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id p14sm18417178wrg.96.2020.08.14.09.39.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2020 09:39:27 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/5] hw/avr/atmega: Introduce the I/O clock
Date: Fri, 14 Aug 2020 18:39:20 +0200
Message-Id: <20200814163924.11662-2-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200814163924.11662-1-f4bug@amsat.org>
References: <20200814163924.11662-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Sarah Harris <S.E.Harris@kent.ac.uk>, Thomas Huth <huth@tuxfamily.org>,
 Joaquin de Andres <me@xcancerberox.com.ar>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Michael Rolnik <mrolnik@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Use the Clock API to model the I/O clock. As we don't model
the Clock Control Unit, the XTAL is its unique clock source.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/avr/atmega.h | 2 ++
 hw/avr/atmega.c | 4 ++++
 2 files changed, 6 insertions(+)

diff --git a/hw/avr/atmega.h b/hw/avr/atmega.h
index 0928cb0ce6..c91317107f 100644
--- a/hw/avr/atmega.h
+++ b/hw/avr/atmega.h
@@ -14,6 +14,7 @@
 #include "hw/char/avr_usart.h"
 #include "hw/timer/avr_timer16.h"
 #include "hw/misc/avr_power.h"
+#include "hw/clock.h"
 #include "target/avr/cpu.h"
 
 #define TYPE_ATMEGA_MCU     "ATmega"
@@ -35,6 +36,7 @@ typedef struct AtmegaMcuState {
     /*< public >*/
 
     AVRCPU cpu;
+    Clock *ioclk;
     MemoryRegion flash;
     MemoryRegion eeprom;
     MemoryRegion sram;
diff --git a/hw/avr/atmega.c b/hw/avr/atmega.c
index 7131224431..9d814de499 100644
--- a/hw/avr/atmega.c
+++ b/hw/avr/atmega.c
@@ -15,6 +15,7 @@
 #include "exec/memory.h"
 #include "exec/address-spaces.h"
 #include "sysemu/sysemu.h"
+#include "hw/qdev-clock.h"
 #include "hw/qdev-properties.h"
 #include "hw/sysbus.h"
 #include "hw/boards.h" /* FIXME memory_region_allocate_system_memory for sram */
@@ -231,6 +232,9 @@ static void atmega_realize(DeviceState *dev, Error **errp)
         error_setg(errp, "\"xtal-frequency-hz\" property must be provided.");
         return;
     }
+    s->ioclk = qdev_init_clock_out(dev, "ioclk");
+    /* Clock Control Unit not implemented: directly distribute from xtal */
+    clock_set_hz(s->ioclk, s->xtal_freq_hz);
 
     /* CPU */
     object_initialize_child(OBJECT(dev), "cpu", &s->cpu, mc->cpu_type);
-- 
2.21.3


