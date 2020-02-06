Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51A28C33CAC
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 18:33:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20E7420659
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 18:33:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LFNVvlMm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20E7420659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44398 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izlyL-0001Uk-A4
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 13:33:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33821)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groeck7@gmail.com>) id 1izlx0-0000H9-C4
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 13:32:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groeck7@gmail.com>) id 1izlwz-0002nH-Cw
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 13:32:30 -0500
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:39398)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <groeck7@gmail.com>)
 id 1izlwx-0002Tv-1U; Thu, 06 Feb 2020 13:32:27 -0500
Received: by mail-pg1-x542.google.com with SMTP id j15so3167053pgm.6;
 Thu, 06 Feb 2020 10:32:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=KHa/YBhZFNQ20KTVw/CmGFo4SlMalxgAEPAvIgaPvrc=;
 b=LFNVvlMmrLf25rNwrNDR82Bs347osXagmjsWDE84qnVj8iGW9+k4doSQhtsqymM7Rt
 lZ501LnnDaOxSX4aVyu+LrdQYg94ZO8b1WmlRQvKjU9mCbJrEmxC8LgKrJUrGXid6BCu
 wdiJuKQwdYisJl66WezpTkUUpcqwAE6UFaoVfCSVxwwwWZKxRQ+2ekSPuTiu/3rkQzpD
 Us9IJYTlJ5i0Ha3ELkJfIvNNTOeKxuezooJ/X6dGk4kGhgGH+kUiU/5PpT4KSL0LhtL0
 H0NaBdrfYzloxDzcb8aJrX0Xh4XhieWLA+tOJIY4/l0qRkUIPJMXXfrIBD6yY5XozU0k
 3BrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=KHa/YBhZFNQ20KTVw/CmGFo4SlMalxgAEPAvIgaPvrc=;
 b=dDQjF9ZPwuP+vznup3sivIUEthyMYXYra0X0YEZ1CI/eFQI/uLuFBWbMtR3+oEmqEL
 pEQGVDtckMv0UI4S8jYY+YPHvYTwPWHu+qPFrHR6eXpzrNBb3+q9t1xIlIp22L1RSVAt
 iy+ORmwI9AVGsorRkkcOtQix6kUBmsa+eEBUvV0vIWGoWuK3F+5GjObWhXvGdX6wDHEq
 PMBTeP2L8NWlDaeY4DLJVElnBOC+zuFwhMu0ixntivolrAHSUW0yOLAiGKC5entp4o9e
 d3i8P1UkLcfq2n8XYCU09D2vxigl5Q2/NjcJbuNOZKd/kASpI0BlENF3gGo3Kzgdl1cT
 f2nA==
X-Gm-Message-State: APjAAAUSxlIOmq4JjO/VA2wCqOdgl2iIwfgQv6OWb0PQZbw/AF6XPHbW
 iovv7IWbv3dwolmSGCy6lTU=
X-Google-Smtp-Source: APXvYqx8M66S523j0CAc3jx1Q/n5M3NlplkIwuiYGTznrlVl16ZcwJURe829H/RkxXb1ZBR4dwUAqw==
X-Received: by 2002:a63:8dc4:: with SMTP id z187mr5255950pgd.68.1581013946160; 
 Thu, 06 Feb 2020 10:32:26 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id i66sm106167pfg.85.2020.02.06.10.32.25
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 06 Feb 2020 10:32:25 -0800 (PST)
From: Guenter Roeck <linux@roeck-us.net>
To: Alistair Francis <alistair@alistair23.me>,
	Kevin Wolf <kwolf@redhat.com>
Subject: [PATCH v2 2/4] m25p80: Improve command handling for Jedec commands
Date: Thu,  6 Feb 2020 10:32:17 -0800
Message-Id: <20200206183219.3756-2-linux@roeck-us.net>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200206183219.3756-1-linux@roeck-us.net>
References: <20200206183219.3756-1-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::542
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

When requesting JEDEC data using the JEDEC_READ command, the Linux kernel
always requests 6 bytes. The current implementation only returns three
bytes, and interprets the remaining three bytes as new commands.
While this does not matter most of the time, it is at the very least
confusing. To avoid the problem, always report up to 6 bytes of JEDEC
data. Fill remaining data with 0.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: Split patch into two parts; improved decription

 hw/block/m25p80.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
index 5ff8d270c4..53bf63856f 100644
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
-- 
2.17.1


