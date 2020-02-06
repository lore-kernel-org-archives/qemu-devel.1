Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7602AC33CAC
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 18:36:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4886921741
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 18:36:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BKXJ+pHA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4886921741
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44450 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izm0a-00051D-FU
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 13:36:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33862)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groeck7@gmail.com>) id 1izlx5-0000IX-St
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 13:32:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groeck7@gmail.com>) id 1izlx1-00031R-0T
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 13:32:35 -0500
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044]:36309)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <groeck7@gmail.com>)
 id 1izlwy-0002eB-N9; Thu, 06 Feb 2020 13:32:28 -0500
Received: by mail-pj1-x1044.google.com with SMTP id gv17so347657pjb.1;
 Thu, 06 Feb 2020 10:32:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=TFJ5p1ThS0hsrxJYRVO5wCKqO07TvtEvWzLC69usUMo=;
 b=BKXJ+pHAIy34MxF73NSkOCFiML1oW02DGqYmirQl8r8f4l6ltSd1vvRctwdh0mOmwh
 z/F2l1ONMl2EJfbZcozrOor8F4x1MwzIdyIa/iJp1dNAKfZteZnsgDlU4oRzL7+W4jKS
 L8lj0N+O8xHlLyf8g+E71KuTr1V6DxuX/+KdGEK/jXbwCnmbQ7Xvg6cCvEXJPmiz+IQM
 XOZ+42oMOxoNpygjAS2qp9MpwdBu/gmjb8a+pMq/ZJbJ8amEkruSB5SiajGMke7xB1xI
 Ebcv8p+G6E7JYivxIbowUcaoeJfaDa8kEbMr1fgTDCqUp9FxsES983Ug0SofvHCIsHbc
 MMbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=TFJ5p1ThS0hsrxJYRVO5wCKqO07TvtEvWzLC69usUMo=;
 b=GjpFGRTwX31Z/gwsCjoePzhPM2VF3hMnonQXCwMOXe9eoiQnZLtsB1R2oG+v5S/NnZ
 wOmQ6fP3KYgEeShO11Kfsr7BRDs8c4J+6UN0GuY7EvLR0pS+oTQ+5gTjA3O9/krUQELl
 7htVIjn0lPE/VmVkchkCxi2C2GcuBpdJHdpmLedF/hjUJhHlBuY0EcQap0/6dxQ6zqQX
 V8P0FcMqSTfoXpvWkkOpTQM15c44riDjenP/39Fk40+8WT0w4pU4lbaKR9WMDKyLXqeY
 Jfm2Q5272tAJgU63bAGM/PENCHL6lyVMkD5cu+OPYX2T11flyCh5UaX0UqTWq48nzzJk
 hPDQ==
X-Gm-Message-State: APjAAAUm8wKwTb1SNjvt3EU0rUTVDfFrhs4895vioz3um9OJKoaxQMrL
 GVeTW8i4e3JB4uZK4YQS/vk=
X-Google-Smtp-Source: APXvYqxRfEApRG5pO/lESYf/dZoerR3vB53boCqOGWMuE4ZNihRkP5cC2aezSIGGoRDahk5gLSEOdA==
X-Received: by 2002:a17:90a:5285:: with SMTP id
 w5mr6200743pjh.77.1581013947718; 
 Thu, 06 Feb 2020 10:32:27 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id 144sm115035pfc.45.2020.02.06.10.32.26
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 06 Feb 2020 10:32:27 -0800 (PST)
From: Guenter Roeck <linux@roeck-us.net>
To: Alistair Francis <alistair@alistair23.me>,
	Kevin Wolf <kwolf@redhat.com>
Subject: [PATCH v2 3/4] m25p80: Improve command handling for unsupported
 commands
Date: Thu,  6 Feb 2020 10:32:18 -0800
Message-Id: <20200206183219.3756-3-linux@roeck-us.net>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200206183219.3756-1-linux@roeck-us.net>
References: <20200206183219.3756-1-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1044
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-block@nongnu.org,
 Andrew Jeffery <andrew@aj.id.au>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, qemu-arm@nongnu.org,
 Joel Stanley <joel@jms.id.au>, Guenter Roeck <linux@roeck-us.net>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Whenever an unsupported command is encountered, the current code
interprets each transferred byte as new command. Most of the time, those
'commands' are interpreted as new unknown commands. However, in rare
cases, it may be that for example address or length information
passed with the original command is by itself a valid command.
If that happens, the state machine may get completely confused and,
worst case, start writing data into the flash or even erase it.

To avoid the problem, transition into STATE_READING_DATA and keep
sending a value of 0 until the chip is deselected after encountering
an unsupported command.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: Split patch into two parts; improved description.

 hw/block/m25p80.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
index 53bf63856f..8227088441 100644
--- a/hw/block/m25p80.c
+++ b/hw/block/m25p80.c
@@ -1161,6 +1161,11 @@ static void decode_new_cmd(Flash *s, uint32_t value)
         s->quad_enable = false;
         break;
     default:
+        s->pos = 0;
+        s->len = 1;
+        s->state = STATE_READING_DATA;
+        s->data_read_loop = true;
+        s->data[0] = 0;
         qemu_log_mask(LOG_GUEST_ERROR, "M25P80: Unknown cmd %x\n", value);
         break;
     }
-- 
2.17.1


