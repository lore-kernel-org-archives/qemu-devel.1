Return-Path: <SRS0=z9mi=3N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81472C35240
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 00:57:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44B0E2071E
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 00:57:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p2O27mzl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44B0E2071E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36078 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iunHa-0005Bd-GV
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 19:57:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44403)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iunCk-0002EK-Ak
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 19:52:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iunCi-0005MK-V2
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 19:52:10 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:38253)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iunCi-0005Kz-Nz; Thu, 23 Jan 2020 19:52:08 -0500
Received: by mail-wm1-x341.google.com with SMTP id u2so137585wmc.3;
 Thu, 23 Jan 2020 16:52:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=fA5rgQGS54xFWPpk3GrHrv/0dS1AA+Mxe8B0VggOsAw=;
 b=p2O27mzlsMk6bNhx8wzqb0ybxdWxeM39uoI0p5YD6ndKsdNNygoS1gLaeCehHKEQqQ
 +s07dzQJ2qAvNtF31dqWzGcEBHrCqkE3fkJkXVPCvNUrx56uCayMkvZWOJcCQ8G4sDLh
 MgfxlYCULkG3R0wZESjR42c3bdV3drrxkCTCPyrpzslFsPwaFSmIS1KIvdYftts0g5NP
 68byu/GJb1teptGZaUj9PJY7LOaxgcC32mMA+JvyuwczoJkAek2B7nttPgdD0msVkstG
 V1iWNlI0Uc9aIPoO233EqfMvTb12Iz5H7DUdYVt2g5RG4z1G4xIYMZJUehJ+5LSaEzh+
 gmIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=fA5rgQGS54xFWPpk3GrHrv/0dS1AA+Mxe8B0VggOsAw=;
 b=lRziYZtG+ozjZCmLCdxPVYxTHERuRMZr6ptbpuMx4BJRaepPSLQIpdKlqUg/GTlZpe
 v4op/salnrJUvTNTQ3CE2dClX+XBXHTQC+/65m6KHBh+oVcOiInze9xX/HBQ7cInPN6c
 TkBKvgRhzILfplVKRWGseMuYi3Ck40Mv/p5qMazQ5DunV8FEUzC9YgSZ5/sF29obopSm
 dQcvdQt4ouy8vl9Zhq3s4AZcPaD3P+QZHNqZwCXsy324dBxkqe9mT9Ci++BqaCUuJNw9
 4Abl0KoNbMuVZPuTQWBqaR+RXfC+tWkhQ5XwEhfLYTB43ArVdKIObge8dW01dGBWbZwQ
 BRyA==
X-Gm-Message-State: APjAAAUE5zamIxl7O1LOGDUtnXQ6X4h4y+bmUvQ0rVxWFoXr91fXlYvS
 p92WSfA5dxj1eto6Sf8pJ63mFBcM
X-Google-Smtp-Source: APXvYqwUeGdiYo+vlpIgHnaG0oY4EiOtnDLyxRyHFf32QyVGy9TmN9T22bn74ODBDTKBDm1FyfL1iA==
X-Received: by 2002:a05:600c:20e:: with SMTP id
 14mr576524wmi.104.1579827127586; 
 Thu, 23 Jan 2020 16:52:07 -0800 (PST)
Received: from x1w.redhat.com (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id s139sm4598271wme.35.2020.01.23.16.52.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jan 2020 16:52:06 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org, mrolnik@gmail.com, richard.henderson@linaro.org,
 me@xcancerberox.com.ar
Subject: [PATCH rc2 14/25] target/avr: Add section about AVR into QEMU
 documentation
Date: Fri, 24 Jan 2020 01:51:20 +0100
Message-Id: <20200124005131.16276-15-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200124005131.16276-1-f4bug@amsat.org>
References: <20200124005131.16276-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
Cc: Laurent Vivier <lvivier@redhat.com>, Fam Zheng <fam@euphon.net>,
 S.E.Harris@kent.ac.uk, qemu-riscv@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, dovgaluk@ispras.ru,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, thuth@redhat.com,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, imammedo@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, aleksandar.m.mail@gmail.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Michael Rolnik <mrolnik@gmail.com>

Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
Message-Id: <20200118191416.19934-16-mrolnik@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
[PMD: Fixed typos]
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
rc2: Fixed typos, s/sample/Arduino/, removed -serial section (thuth)
---
 qemu-doc.texi | 51 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/qemu-doc.texi b/qemu-doc.texi
index 39f950471f..89df1d325e 100644
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
+Use the executable @file{qemu-system-avr} to emulates a AVR 8 bit based machine
+having one for the following cores: avr1, avr2, avr25, avr3, avr31, avr35, avr4,
+avr5, avr51, avr6, avrtiny, xmega2, xmega3, xmega4, xmega5, xmega6 and xmega7.
+
+As for now it supports few Arduino boards for educational and testing purposes.
+These boards use a ATmega controller, which model is limited to USART & 16 bit
+timer devices, enought to run FreeRTOS based applications (like this @url{https://github.com/seharris/qemu-avr-tests/blob/master/free-rtos/Demo/AVR_ATMega2560_GCC/demo.elf,,demo})
+
+Following are examples of possible usages, assuming program.elf is compiled for
+AVR cpu
+@itemize
+
+@item Continuous non interrupted execution
+@example
+qemu-system-avr -kernel program.elf
+@end example
+
+@item Continuous non interrupted execution with serial output into telnet window
+@example
+qemu-system-avr -kernel program.elf -serial tcp::5678,server,nowait -nographic
+@end example
+and then in another shell
+@example
+telnet localhost 5678
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
2.21.1


