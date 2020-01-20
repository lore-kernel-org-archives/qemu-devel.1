Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6701BC32771
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 22:07:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30783217F4
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 22:07:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BOSFdgzT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30783217F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44638 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itfCJ-00083d-0Q
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 17:07:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51034)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1itf6q-0001ax-JA
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 17:01:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1itf6o-0005sA-UT
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 17:01:24 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:42364)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1itf6o-0005q1-Lf
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 17:01:22 -0500
Received: by mail-wr1-x442.google.com with SMTP id q6so1071008wro.9
 for <qemu-devel@nongnu.org>; Mon, 20 Jan 2020 14:01:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=gRzGJF9eMfXheMVh+xvWRJn0J+YdP96rKAOtrxTRUN8=;
 b=BOSFdgzT3tXY8nl3rEcwu6O/AWUieNpiw2FJPLTPyZ0KxF6gaxW9PMN2tGzMZSu596
 g30PNK/z+79I1L7L9dyBrxCtpXARYksyOW2ReFBicfHJZUIDQN7lIQwTZ002Nw/K8O1a
 yJ4iRWwqEJqfoBzLgPOElmDTczl0E+b3YNirZy2PGTPC3MaQBQ5Bpp9YJm8AQhSJesn1
 bHg/vasPw+jvoB6d5W2TCpaDq3j9PDUNxXg2c06uYT8Ceowk9meVrZf1cQ2ZAW+TxCeX
 9l//r9W602F3j87pZAm/fHuc7NrDKkSdMlLQFjultoc4BO3r3F84h6liyLLeuQJKaaQz
 +lQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=gRzGJF9eMfXheMVh+xvWRJn0J+YdP96rKAOtrxTRUN8=;
 b=RjeFENpQOopoWbq+RNDFKNfw09bI5Cgsi4356FKX6z+toP1HJAcayucV00iWxPCthR
 UbUBD/i4UdCRdUiJcCBOL2/VOpddNvzkxf1oU6SBwZP5/KHnY3l7zdf+Zr+kRm96Iu/W
 wcbo9uOd0Diw8ZkIjTBKwcoZv6tO36NTm2muo8PiTdotvungwM4vjVHISIrqMo7BEP52
 CHSHX0q3HRsJmkcF9mJjmGk+lcKvuqwsx9naALvi589G/jbyAqawiCWxoG4WacGJCn8w
 q6o3i8Ec0Ktcjm/hc337i4FM8beHz7DLHVvy3Bk0nIJTQoKWJcfF4aObuTTj2YI0z+Tq
 xX+g==
X-Gm-Message-State: APjAAAWPYhCWts+A8T5EVe3WvhfI8ht4IXa4sRilH1R+fetkG4WJ5hni
 dWD0lRBGJgT0L95lm78WyHBOtmda
X-Google-Smtp-Source: APXvYqw2GQKGwn0IPZfdfWwG2DOq7tzbKjmNcmOH77Mr3rsWOg2TNL6UfnstVhB7+cplVWOT0N/qbg==
X-Received: by 2002:a5d:4d4a:: with SMTP id a10mr1589154wru.220.1579557680498; 
 Mon, 20 Jan 2020 14:01:20 -0800 (PST)
Received: from x1w.redhat.com (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id f1sm904341wmc.45.2020.01.20.14.01.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jan 2020 14:01:19 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 08/18] hw/avr/Makefile: Use CONFIG_AVR_SAMPLE variable
Date: Mon, 20 Jan 2020 23:00:57 +0100
Message-Id: <20200120220107.17825-9-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200120220107.17825-1-f4bug@amsat.org>
References: <20200120220107.17825-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
Cc: Sarah Harris <S.E.Harris@kent.ac.uk>, Michael Rolnik <mrolnik@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/avr/Makefile.objs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/avr/Makefile.objs b/hw/avr/Makefile.objs
index 626b7064b3..1eb4b53be6 100644
--- a/hw/avr/Makefile.objs
+++ b/hw/avr/Makefile.objs
@@ -1 +1 @@
-obj-y += sample.o
+obj-$(CONFIG_AVR_SAMPLE) += sample.o
-- 
2.21.1


