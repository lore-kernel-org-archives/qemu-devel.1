Return-Path: <SRS0=5nOY=BY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E82B3C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 16:42:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B223D207DA
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 16:42:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e4/SGrC/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B223D207DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39788 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6cmU-00007C-V1
	for qemu-devel@archiver.kernel.org; Fri, 14 Aug 2020 12:42:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46588)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k6cju-0004Fe-Aa
 for qemu-devel@nongnu.org; Fri, 14 Aug 2020 12:39:34 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:39892)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k6cjs-0002Kg-S6
 for qemu-devel@nongnu.org; Fri, 14 Aug 2020 12:39:34 -0400
Received: by mail-wm1-x341.google.com with SMTP id g75so8436419wme.4
 for <qemu-devel@nongnu.org>; Fri, 14 Aug 2020 09:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=9pWOckZfWxmm5Cx0x7GbXw26/l3P0TjnIk9rBNWTYh0=;
 b=e4/SGrC/gjRY9eB+jKzpcw/ZKQVD3IvyoIvxku/1gSHImXI0ZQqdKoCcdvIyWizRdC
 Lwi19O6WIEXGtS27VsF1LeyU7qiHr3VUC0hR0jIVHoIaU7+POdHWi8RW3FigH3aNZ9Pt
 r0ds0lxTG4/0nDW3h91O4pD87AcuN2WWtlHbFB8ZLswwZTv98Dmb/epwTbAGkwD64Mkn
 jmDYveLIsGXE//6imTS880c0xtE8kviiSkR734ERlYzwA1+1wM1ZqRc4Yed5FH7SI42F
 lXc01GA2O67IEqrzsTinnYQq2KFuhG+S+9hrkivENRsrzcwuJDvptWOjMf5fycAEyjcu
 UGpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=9pWOckZfWxmm5Cx0x7GbXw26/l3P0TjnIk9rBNWTYh0=;
 b=E0diWdzDV3YMvlJKsSN4Kg5rBb90F9d92iOulvJq6wosHtJdfHYTw/GKnRWQnhKjQR
 zPUYehhKNuWpa0yPDT5yVt3A2hrRsm6aM+h/spg5SZ0Dex3oRb7jgbq3bom+ZH7IoqLp
 agMrQgGGIJlkWOthWYaP8DcR9s1STzZCe07Pg5VIMJM4NWr+/a5yg8tJJVT8SjRaY809
 iwhL6l6dnqSaOZ/TEOdTXgqZ99RpaiutAMp9kVwk9h0ZhfKoQRl9VUV5V7rgFwRhKWPJ
 wxfZpMv8mMecceokYmZ96tv4O4eQ8Gi7Z7mJaTDwjDsGWSZBdgf2qQeEimmefEZzI0OI
 9TiA==
X-Gm-Message-State: AOAM5303pABwowZkPtx92KCtegG/W1nCy7cK9FyqizKMyxKsBNv8wEfr
 d2Hko91WOaTMrpfa8v+VOD4RgYI8PbM=
X-Google-Smtp-Source: ABdhPJxi2ZNmSxqhoXZzRHX6u8ec9FSvomBl4hAHsxq7v0y9mv756RKGyzEPrT3d3Q+H8uJDL1Sr/w==
X-Received: by 2002:a7b:cb4d:: with SMTP id v13mr3466832wmj.56.1597423171284; 
 Fri, 14 Aug 2020 09:39:31 -0700 (PDT)
Received: from localhost.localdomain (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id p14sm18417178wrg.96.2020.08.14.09.39.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2020 09:39:30 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/5] hw/char/avr_usart: Restrict register definitions to source
Date: Fri, 14 Aug 2020 18:39:22 +0200
Message-Id: <20200814163924.11662-4-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200814163924.11662-1-f4bug@amsat.org>
References: <20200814163924.11662-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x341.google.com
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

Nothing out of our model implementation is supposed to access its
registers. Keep the definitions local.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/char/avr_usart.h | 30 ------------------------------
 hw/char/avr_usart.c         | 30 ++++++++++++++++++++++++++++++
 2 files changed, 30 insertions(+), 30 deletions(-)

diff --git a/include/hw/char/avr_usart.h b/include/hw/char/avr_usart.h
index 5739aaf26f..46d6c76e50 100644
--- a/include/hw/char/avr_usart.h
+++ b/include/hw/char/avr_usart.h
@@ -26,36 +26,6 @@
 #include "chardev/char-fe.h"
 #include "hw/hw.h"
 
-/* Offsets of registers. */
-#define USART_DR   0x06
-#define USART_CSRA  0x00
-#define USART_CSRB  0x01
-#define USART_CSRC  0x02
-#define USART_BRRH 0x05
-#define USART_BRRL 0x04
-
-/* Relevant bits in regiters. */
-#define USART_CSRA_RXC    (1 << 7)
-#define USART_CSRA_TXC    (1 << 6)
-#define USART_CSRA_DRE    (1 << 5)
-#define USART_CSRA_MPCM   (1 << 0)
-
-#define USART_CSRB_RXCIE  (1 << 7)
-#define USART_CSRB_TXCIE  (1 << 6)
-#define USART_CSRB_DREIE  (1 << 5)
-#define USART_CSRB_RXEN   (1 << 4)
-#define USART_CSRB_TXEN   (1 << 3)
-#define USART_CSRB_CSZ2   (1 << 2)
-#define USART_CSRB_RXB8   (1 << 1)
-#define USART_CSRB_TXB8   (1 << 0)
-
-#define USART_CSRC_MSEL1  (1 << 7)
-#define USART_CSRC_MSEL0  (1 << 6)
-#define USART_CSRC_PM1    (1 << 5)
-#define USART_CSRC_PM0    (1 << 4)
-#define USART_CSRC_CSZ1   (1 << 2)
-#define USART_CSRC_CSZ0   (1 << 1)
-
 #define TYPE_AVR_USART "avr-usart"
 #define AVR_USART(obj) \
     OBJECT_CHECK(AVRUsartState, (obj), TYPE_AVR_USART)
diff --git a/hw/char/avr_usart.c b/hw/char/avr_usart.c
index fbe2a112b7..fd0b488ef9 100644
--- a/hw/char/avr_usart.c
+++ b/hw/char/avr_usart.c
@@ -25,6 +25,36 @@
 #include "hw/irq.h"
 #include "hw/qdev-properties.h"
 
+/* Offsets of registers. */
+#define USART_DR   0x06
+#define USART_CSRA  0x00
+#define USART_CSRB  0x01
+#define USART_CSRC  0x02
+#define USART_BRRH 0x05
+#define USART_BRRL 0x04
+
+/* Relevant bits in regiters. */
+#define USART_CSRA_RXC    (1 << 7)
+#define USART_CSRA_TXC    (1 << 6)
+#define USART_CSRA_DRE    (1 << 5)
+#define USART_CSRA_MPCM   (1 << 0)
+
+#define USART_CSRB_RXCIE  (1 << 7)
+#define USART_CSRB_TXCIE  (1 << 6)
+#define USART_CSRB_DREIE  (1 << 5)
+#define USART_CSRB_RXEN   (1 << 4)
+#define USART_CSRB_TXEN   (1 << 3)
+#define USART_CSRB_CSZ2   (1 << 2)
+#define USART_CSRB_RXB8   (1 << 1)
+#define USART_CSRB_TXB8   (1 << 0)
+
+#define USART_CSRC_MSEL1  (1 << 7)
+#define USART_CSRC_MSEL0  (1 << 6)
+#define USART_CSRC_PM1    (1 << 5)
+#define USART_CSRC_PM0    (1 << 4)
+#define USART_CSRC_CSZ1   (1 << 2)
+#define USART_CSRC_CSZ0   (1 << 1)
+
 static int avr_usart_can_receive(void *opaque)
 {
     AVRUsartState *usart = opaque;
-- 
2.21.3


