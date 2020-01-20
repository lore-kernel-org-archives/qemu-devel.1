Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F0B0C32771
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 22:03:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 291CA22525
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 22:03:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PFK9VGsr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 291CA22525
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44590 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itf93-0003Sv-El
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 17:03:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50961)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1itf6h-0001Vr-NF
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 17:01:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1itf6f-0005m6-Tp
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 17:01:15 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:35663)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1itf6f-0005ji-NT
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 17:01:13 -0500
Received: by mail-wr1-x444.google.com with SMTP id g17so1132047wro.2
 for <qemu-devel@nongnu.org>; Mon, 20 Jan 2020 14:01:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=/1VSe/7St+k6/MQRetjcnD35mCiVVbYYdodJto6H7yU=;
 b=PFK9VGsrdI27BvomgI27b7fqRGifADuRdpF67qcU07bomcuWDsOLRrBoIQHPSgnCxZ
 NqZCcPnTbFTFD8x84k3rR2d1feCthc0O65J8wil0C4cO0MqWwf7WgxihwZg38mRO8K4X
 6t2BZqvmSN4a3OumZ10521OW5Iwcs867RPtvKty44ndJxmYFO4Dr4Gtg1bzQyhrq7392
 xEMIVNAolpT9+iTRMEUuHbYEOsoY84vSQEHbIfhI7QFJYuP+CL5QC5B0rjG5craxvUXp
 7jKmSdFU98t4Zy/srOvqSIi0162ma0CkR4Vxg7Q7R8L2jlje0ZJs4MVQsU62L/22K3cY
 h0Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=/1VSe/7St+k6/MQRetjcnD35mCiVVbYYdodJto6H7yU=;
 b=eb8spv2upe7106WNCk24gXgNaWQEyOvpIKJ6krTHRkFzsQ/HpwM5qTxJBnsPGYCugB
 rw00G97q5Ss4qY3NmYBPKuHx/9iTRr4OuWITnPOXsgPqR++PL8O/SEWwXSs/O5/vJpo0
 2ulN7vupjiZ1ARevdPam8vHWAUaAJV3ujLDDUIBcHf18wu4y/H/RWNIxn5IuErdBFgu2
 t1CfdNZQVgRdDxwCtEUU6Jg66ObO5m8NpMFWcH/3ZuFtukwxRTmOsF5PlpFyOFhQC1zv
 tq1a2bb7n0ZAhdYOUs7dYljfqLXRie3TNKWgyz3fhe2EdPeXzPwFW7PGBlbZSfrN5ygM
 kuZA==
X-Gm-Message-State: APjAAAW5uTacMN8OPBw4yVUaeePNQ4rPLAunh9rGGNleAxjvfngmQlZQ
 RAgaX0xA+4TSs9ScRQk9xG1TvRCP
X-Google-Smtp-Source: APXvYqzAZO9Yyo2A4fnf315HSdCx+8IbysAoJa1DEg9hfxoj5Xf4dS4Wjwnr4aOoE6hkbypfcHs/RQ==
X-Received: by 2002:a5d:43c7:: with SMTP id v7mr1493442wrr.32.1579557671802;
 Mon, 20 Jan 2020 14:01:11 -0800 (PST)
Received: from x1w.redhat.com (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id f1sm904341wmc.45.2020.01.20.14.01.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jan 2020 14:01:11 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 02/18] MAINTAINERS: Move the AVR machines in new section
 (not within ARM)
Date: Mon, 20 Jan 2020 23:00:51 +0100
Message-Id: <20200120220107.17825-3-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200120220107.17825-1-f4bug@amsat.org>
References: <20200120220107.17825-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
!squash
---
 MAINTAINERS | 29 ++++++++++++++++-------------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3fbac64b31..4998fee99a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -489,19 +489,6 @@ F: hw/*/allwinner*
 F: include/hw/*/allwinner*
 F: hw/arm/cubieboard.c
 
-AVR Machines
-M: Michael Rolnik <mrolnik@gmail.com>
-R: Sarah Harris <S.E.Harris@kent.ac.uk>
-S: Maintained
-F: hw/avr/
-F: hw/char/avr_usart.c
-F: include/hw/char/avr_usart.h
-F: hw/timer/avr_timer16.c
-F: include/hw/timer/avr_timer16.h
-F: hw/misc/avr_mask.c
-F: include/hw/misc/avr_mask.h
-F: tests/acceptance/machine_avr6.py
-
 ARM PrimeCell and CMSDK devices
 M: Peter Maydell <peter.maydell@linaro.org>
 L: qemu-arm@nongnu.org
@@ -901,6 +888,22 @@ F: include/hw/*/nrf51*.h
 F: include/hw/*/microbit*.h
 F: tests/qtest/microbit-test.c
 
+AVR Machines
+-------------
+
+Atmel MCU
+M: Michael Rolnik <mrolnik@gmail.com>
+R: Sarah Harris <S.E.Harris@kent.ac.uk>
+S: Maintained
+F: hw/avr/
+F: hw/char/avr_usart.c
+F: include/hw/char/avr_usart.h
+F: hw/timer/avr_timer16.c
+F: include/hw/timer/avr_timer16.h
+F: hw/misc/avr_mask.c
+F: include/hw/misc/avr_mask.h
+F: tests/acceptance/machine_avr6.py
+
 CRIS Machines
 -------------
 Axis Dev88
-- 
2.21.1


