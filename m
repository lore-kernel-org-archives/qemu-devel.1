Return-Path: <SRS0=KIBN=2T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53A4EC2D0C0
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Dec 2019 22:03:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B1BB2071E
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Dec 2019 22:03:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KVDDdw8w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B1BB2071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55406 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ilgep-0002nm-Sm
	for qemu-devel@archiver.kernel.org; Sun, 29 Dec 2019 17:03:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33948)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mrolnik@gmail.com>) id 1ilgUx-0007jS-MC
 for qemu-devel@nongnu.org; Sun, 29 Dec 2019 16:53:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mrolnik@gmail.com>) id 1ilgUv-00044J-IH
 for qemu-devel@nongnu.org; Sun, 29 Dec 2019 16:53:19 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:42873)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mrolnik@gmail.com>) id 1ilgUv-00043X-AO
 for qemu-devel@nongnu.org; Sun, 29 Dec 2019 16:53:17 -0500
Received: by mail-wr1-x444.google.com with SMTP id q6so31132484wro.9
 for <qemu-devel@nongnu.org>; Sun, 29 Dec 2019 13:53:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=FlUSLH2uEvNEQP+btvkmtajQHzIok4pqbEhuKlNXr9w=;
 b=KVDDdw8wklBtTV/L/xbSc2wfLGTB8SdHQ6945vy4xrzZt89qISGcWOJoUTQU2jvX4R
 E3/IXv7Fk0fAmPVT//0l9xHjWD65LA9e9ACoOFNjLnyXGbb5TUgJc1VQdWJ4v2gYbzjD
 OtKyeDJ3fjUWtO2H/qlpk0rDjUzQrlCH3XV2W3DOZLUykv9dzmx6/pp7u5y5YL0vu7ld
 AGJ+fUaQI2UZKHI4MXGauN8OSEp2UzwoQkiP/Bm44OharoV7w4TTUQ0LYcUOa8MJLzYs
 Kg7HxuK6Z52wwng0vwuQzRPqq5ppVviWiFqt2Ss9cirKudXjOD1KdxPG1n97h7P9sqF7
 MBSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=FlUSLH2uEvNEQP+btvkmtajQHzIok4pqbEhuKlNXr9w=;
 b=A5FKvBSuKfRgD/6hy057rRZR8eIl5TIwkomdwyk/sBQvIhk3lBI7gb6j2L1JgLr+5t
 ZOgo/3S3kYWSDbkT7o2bKK4SaoHVoUa7OTfx3QfTAJc0BpwBgzfhpzGX8xb/jBsC8deD
 ft3qQDh08S+xK3ckbmowFmGtHSUAEeVKgneRYsAF8/mfcZDo9+1FrTj+VPiu7sKwZ6eX
 j5HtOewMUzqfUAv2wMXqQVjsIqha4V70QXa6k9BC1SczfPLrKisQIeDDmVkpBQah4rDK
 sppat7kJt1/GLE+iLowY3mC2AjRFkaUNalS7wQLnHtJWpyGc0ow3PXqpfbBle9iCik4P
 eKzg==
X-Gm-Message-State: APjAAAWHDkm9HJulzIFmasF+iECryCRIWDXgQhRvJNu8uEg6wYHAeBOZ
 fciKlhnBb5RnsL3wNP4V007/7JAgUbUM7w==
X-Google-Smtp-Source: APXvYqzonDYvnjJdrj4QuuZ3gPKQu20+F42P1+nvjasgyLE9PXDi60n1K/vSQmov9cIMY60oB9AYNw==
X-Received: by 2002:a5d:4ed0:: with SMTP id s16mr61208096wrv.144.1577656396110; 
 Sun, 29 Dec 2019 13:53:16 -0800 (PST)
Received: from 8c859074c0ff.ant.amazon.com.com
 (bzq-79-183-93-3.red.bezeqint.net. [79.183.93.3])
 by smtp.gmail.com with ESMTPSA id 25sm18182850wmi.32.2019.12.29.13.53.14
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Sun, 29 Dec 2019 13:53:15 -0800 (PST)
From: Michael Rolnik <mrolnik@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v40 15/21] target/avr: Add section about AVR into QEMU
 documentation
Date: Sun, 29 Dec 2019 23:51:52 +0200
Message-Id: <20191229215158.5788-16-mrolnik@gmail.com>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
In-Reply-To: <20191229215158.5788-1-mrolnik@gmail.com>
References: <20191229215158.5788-1-mrolnik@gmail.com>
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
Cc: thuth@redhat.com, Michael Rolnik <mrolnik@gmail.com>,
 me@xcancerberox.com.ar, richard.henderson@linaro.org, dovgaluk@ispras.ru,
 imammedo@redhat.com, philmd@redhat.com, aleksandar.m.mail@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
---
 qemu-doc.texi | 51 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/qemu-doc.texi b/qemu-doc.texi
index 39f950471f..515aacfae9 100644
--- a/qemu-doc.texi
+++ b/qemu-doc.texi
@@ -1741,6 +1741,7 @@ differences are mentioned in the following sections.
 * Microblaze System emulator::
 * SH4 System emulator::
 * Xtensa System emulator::
+* AVR System emulator::
 @end menu
 
 @node PowerPC System emulator
@@ -2514,6 +2515,56 @@ so should only be used with trusted guest OS.
 
 @c man end
 
+@node AVR System emulator
+@section AVR System emulator
+@cindex system emulation (AVR)
+
+Use the executable @file{qemu-system-avr} to emulates a AVR 8 bit based machine having one for the following cores: avr1, avr2, avr25, avr3, avr31, avr35, avr4, avr5, avr51, avr6, avrtiny, xmega2, xmega3, xmega4, xmega5, xmega6 and xmega7.
+
+As for now it does not support any real MCUs. However, it does support a "sample" board for educational and testing purposes. This "sample" board hosts USART & 16 bit timer devices and it's enought to run FreeRTOS based applicaton (like this @url{https://github.com/seharris/qemu-avr-tests/blob/master/free-rtos/Demo/AVR_ATMega2560_GCC/demo.elf,,demo})
+
+Following are examples of possible usages, assuming program.elf is compiled for AVR cpu
+@itemize
+
+@item Continious non interrupted execution
+@example
+qemu-system-avr -kernel program.elf
+@end example
+
+@item Continious non interrupted execution with serial output into telnet window
+@example
+qemu-system-avr -kernel program.elf -serial tcp::5678,server,nowait -nographic
+@end example
+and then in another shell
+@example
+telent localhost 5678
+@end example
+
+@item Continious non interrupted execution with serial output into stdout
+@example
+qemu-system-avr -kernel program.elf -serial stdio
+@end example
+
+@item Debugging wit GDB debugger
+@example
+qemu-system-avr -kernel program.elf -s -S
+@end example
+and then in another shell
+@example
+avr-gdb program.elf
+@end example
+and then within GDB shell
+@example
+target remote :1234
+@end example
+
+@item Print out executed instructions
+@example
+qemu-system-avr -kernel program.elf -d in_asm
+@end example
+
+@end itemize
+
 @node QEMU User space emulator
 @chapter QEMU User space emulator
 
-- 
2.17.2 (Apple Git-113)


