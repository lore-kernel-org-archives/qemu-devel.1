Return-Path: <SRS0=bgql=3H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F850C32771
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jan 2020 19:37:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B47B206E6
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jan 2020 19:37:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jw4bSh4m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B47B206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44246 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1istu8-0007Wv-Lq
	for qemu-devel@archiver.kernel.org; Sat, 18 Jan 2020 14:37:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50056)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mrolnik@gmail.com>) id 1istew-0005tR-QJ
 for qemu-devel@nongnu.org; Sat, 18 Jan 2020 14:21:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mrolnik@gmail.com>) id 1isteu-0007NK-KL
 for qemu-devel@nongnu.org; Sat, 18 Jan 2020 14:21:26 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:43740)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mrolnik@gmail.com>) id 1isteu-0007Lo-E6
 for qemu-devel@nongnu.org; Sat, 18 Jan 2020 14:21:24 -0500
Received: by mail-wr1-x444.google.com with SMTP id d16so25737973wre.10
 for <qemu-devel@nongnu.org>; Sat, 18 Jan 2020 11:21:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=FlUSLH2uEvNEQP+btvkmtajQHzIok4pqbEhuKlNXr9w=;
 b=jw4bSh4m8O03y1OtPK65fJ5UEHgDvLgOZgnTGfZm+wfw+uvaVpM+EHIGL0jts+uVvW
 iEZgZGZpg5wgVXp1lM681bs5A3z7W5P4bilbhTpYKfrUvkWovgXvGP+6ci0qxXB7EaNN
 xDrwOhuY/aQH7MmVAoXXdIq5mDaSigzOLe7ZurUmJpMuovstQZKb4RUE2tcOh+ZkN466
 Mi3TBlaXAWi1WKwO2xn1d/2awDCDuQfqvgyqYyNTLKbC4OeyZ/e/6kcWUnSvBNq8vqeQ
 YdvOhj5NodnEKhTlqsL8/QWh8VS2tlZ1EJE5HiDlZ52t8s3X3CmF/JKIHPXh0HMJ0rGm
 7Vmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=FlUSLH2uEvNEQP+btvkmtajQHzIok4pqbEhuKlNXr9w=;
 b=Kz8AGudIzYQTwybX+3OSsQGCSJdPLx2v9PHiw+AYu6qJt8PL/eVCottnKzQ6RM6Wus
 uqtk+abT9VRP1AfqbX3YVs69POd112sjBbtkoNVzG+a+Zzwl2OVAQO9h4ZB8V2Gh4LKc
 en82qS7n3lunYkiPnuk+EZ6XpwhTWMHflj/9bcgb4UZnm90QV93UncEYMwiUE4vL+3z9
 E3mO9netp7VjojCWgOPR2eKZii+Tg6BEvcQ70jytwfSOCgW5xvrSJaFr/3cxDMT9+Tt+
 upUiPRlWAiYICq2dUDdsChShDR4Pr+eySO1fA7b3jTR0zHatQ6XhhEhi4ov472mFVdez
 Q+9w==
X-Gm-Message-State: APjAAAXaAJE7+A7HF2fUaODgG2Noxs4g2Eua+k0Kx9d4nHlGkzCSXo6s
 m3fQS6eOm+6tJv3VdVtqsJRZ9gfMHpOj4eO7
X-Google-Smtp-Source: APXvYqyeGRmZFg7VVTsMuE1v0eCCHgYhs7WVFV/jmJp5Jpx4KvX/XL8gQ/k8oGd8uZfrhYAxArNyOw==
X-Received: by 2002:a5d:6ac3:: with SMTP id u3mr10276142wrw.25.1579375282213; 
 Sat, 18 Jan 2020 11:21:22 -0800 (PST)
Received: from 8c859074c0ff.ant.amazon.com.com
 (bzq-109-65-108-13.red.bezeqint.net. [109.65.108.13])
 by smtp.gmail.com with ESMTPSA id o16sm2875468wmc.18.2020.01.18.11.21.13
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Sat, 18 Jan 2020 11:21:21 -0800 (PST)
From: Michael Rolnik <mrolnik@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v41 15/21] target/avr: Add section about AVR into QEMU
 documentation
Date: Sat, 18 Jan 2020 21:14:10 +0200
Message-Id: <20200118191416.19934-16-mrolnik@gmail.com>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
In-Reply-To: <20200118191416.19934-1-mrolnik@gmail.com>
References: <20200118191416.19934-1-mrolnik@gmail.com>
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


