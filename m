Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B8B8C35247
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 18:10:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C52120838
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 18:10:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YIoNpmYc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C52120838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45495 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iygBR-00038r-5M
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 13:10:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44948)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groeck7@gmail.com>) id 1iyg9s-0001QX-Rb
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 13:09:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groeck7@gmail.com>) id 1iyg9r-0004Jc-QX
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 13:09:16 -0500
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:41725)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <groeck7@gmail.com>)
 id 1iyg9m-0003zp-SB; Mon, 03 Feb 2020 13:09:12 -0500
Received: by mail-pl1-x641.google.com with SMTP id t14so6155666plr.8;
 Mon, 03 Feb 2020 10:09:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=yq6eFFb6QlatLCP1XykFR99zBztSE9O3BlU2GJ/1iI0=;
 b=YIoNpmYcwsYHxKOK/UlD0vU6PTWdFWExXlL2JmdbzLh3oQk8fK66V6QL10L6w0ibtT
 A0wCYQI+1/Ah68mpRTr2DA/2BgTn8wWm4b0oY4Lw3CF/T0DDwhBI5r8aTjlMAaYbDXjH
 FXcIsD5GCXw9oG7uZcu1TY96k0BVyNpm27i412bAZv9GQFgyAzYlUWTyzBn5einmf3vB
 jMM3SQFiy5cUUW1A0oCUzOyqCrB2NZHdNr2ldXh97NTRavO36uH+j6A0u7ybqy5zjfJv
 ieor9NEYnd1bfnLqACFid750QI7pTfpUlFp/dJYM//RYEyiUi6DzEXvx6Re02X/0Pyxj
 cPcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=yq6eFFb6QlatLCP1XykFR99zBztSE9O3BlU2GJ/1iI0=;
 b=mp0g83B+CjFejlYU41TkxtEN3bQrIj6B0G/E2ZPtbbS6VZutnxjT6hEt5iSUkbDXxN
 iGyATluFYkSac8JbDPRL62N7nXys7JUpjgsLF89125fWl8ZdH1MH7V4ppNjyBiZpN+t6
 FsyGthWbsU63NF3gTxueh2XWi+bb34G/4cCLy2usnA2JUZb9n2dl0+FXVuYYAdJNafR9
 WKlAVgV+WvGOoc++kSYzRerBNcZ43Ku9rQM9w+9CGiHLwaa5wF8vAyEF5V5GY2X5LFlV
 KJK3v8tlYU9Ucii4g97zW6OEnBCjRqZlj8zhcRfyc1Iiaoo0hOdUO38m8oZXPcB8JyDl
 duLA==
X-Gm-Message-State: APjAAAVXOF1UBc2FIoDoOGtXwMooDHnZ17vXH18FXWiLqQP3ykjhABPL
 sU8/tSw8smtN0lhu03ShP+Q=
X-Google-Smtp-Source: APXvYqxNcoSiAvTbvVAXBjor2xFhCeHSF05GHapaTJvEuLnCDZn/C69tle6tRbIwACZlY1B0RqQNjw==
X-Received: by 2002:a17:902:a616:: with SMTP id
 u22mr24614170plq.173.1580753348008; 
 Mon, 03 Feb 2020 10:09:08 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id w128sm20324023pgb.53.2020.02.03.10.09.07
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 03 Feb 2020 10:09:07 -0800 (PST)
From: Guenter Roeck <linux@roeck-us.net>
To: Alistair Francis <alistair@alistair23.me>
Subject: [PATCH 2/3] m25p80: Improve command handling for Jedec and
 unsupported commands
Date: Mon,  3 Feb 2020 10:09:03 -0800
Message-Id: <20200203180904.2727-2-linux@roeck-us.net>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200203180904.2727-1-linux@roeck-us.net>
References: <20200203180904.2727-1-linux@roeck-us.net>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::641
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-block@nongnu.org, Andrew Jeffery <andrew@aj.id.au>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Guenter Roeck <linux@roeck-us.net>, Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Always report 6 bytes of JEDEC data. Fill remaining data with 0.

For unsupported commands, keep sending a value of 0 until the chip
is deselected.

Both changes avoid attempts to decode random commands. Up to now this
happened if the reported Jedec data was shorter than 6 bytes but the
host read 6 bytes, and with all unsupported commands.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 hw/block/m25p80.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
index 63e050d7d3..aca75edcc1 100644
--- a/hw/block/m25p80.c
+++ b/hw/block/m25p80.c
@@ -1040,8 +1040,11 @@ static void decode_new_cmd(Flash *s, uint32_t value)
         for (i = 0; i < s->pi->id_len; i++) {
             s->data[i] = s->pi->id[i];
         }
+        for (; i < SPI_NOR_MAX_ID_LEN; i++) {
+            s->data[i] = 0;
+        }
 
-        s->len = s->pi->id_len;
+        s->len = SPI_NOR_MAX_ID_LEN;
         s->pos = 0;
         s->state = STATE_READING_DATA;
         break;
@@ -1158,6 +1161,11 @@ static void decode_new_cmd(Flash *s, uint32_t value)
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


