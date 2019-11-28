Return-Path: <SRS0=bTwh=ZU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54F80C432C3
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 01:52:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22E7021569
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 01:52:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ezb+txGe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22E7021569
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44648 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ia8yr-0007cY-UD
	for qemu-devel@archiver.kernel.org; Wed, 27 Nov 2019 20:52:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51908)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ia8x4-0005zm-9Y
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 20:50:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ia8x2-00047t-Tv
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 20:50:38 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:36366)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ia8x2-000433-K0
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 20:50:36 -0500
Received: by mail-wm1-x343.google.com with SMTP id p17so4056272wma.1
 for <qemu-devel@nongnu.org>; Wed, 27 Nov 2019 17:50:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=aUgVeH27R35pwY41F87tdQ2FgVzHC+Qd4AbTg6PJLdg=;
 b=Ezb+txGeDQkYTKNGMJLvfaI5vIOdDh0vb+zray8vhieXBGxhlQHlAIoNDJtlZ25pEW
 Mu0hhp1xsVvYRbOuT1RjG0yd3BAM86IseSW9Ch64r/dQQtVlNOpKdvnVfzydevGRpDxG
 rpmj+jQ+yv217Tw//d+WDGq17FsXuMYHhY9vyAE8P+s/77lp22Ic3zksHqV4YYutlFGk
 gehCmoDI3qYgX5UCiHPONDlNhi0nNxKNqWKgCgbW5Ac8Wer73T0ZQskTWXGi7pybgDxy
 ONu9f77nfyREdVjvpJ8AaWP7FFpIXOy7xzOQetYSDtHAxkAVR1nSLk425ejrXbfEEalt
 MWug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=aUgVeH27R35pwY41F87tdQ2FgVzHC+Qd4AbTg6PJLdg=;
 b=tCkQx5KxxNFvVwvP2z+uQEhuzgarWSFpUDghg88fe5Yb80KKBX3j2kqxRUEPT37lZi
 ICbiD1wsnWqX+RYawc9+2OzepOLcd8HBLDS9FRfuRpVaW98wXDrzFPXEuH6M0Q3QC8L6
 y2aFGHtbZy9X0p+OoF9JQBY+UMVq/tNrifKOdiS58NyZ+U3umHdTMeOvhqTaRooXAtzZ
 1XeHRkiTqFvvWvh9RpUgzjcLVwdzFb9GvMCYbE930GIvA7EwjtBRr6jLC6KZfELbXWt/
 TvCwkHxXXUm7afV3RaKY5tczoWgLJpC+tnFdjxi4ikT0xvYkttNyfS2qv/W9QF0lUtl3
 ZQlg==
X-Gm-Message-State: APjAAAWSVQt9Ve4IdghaEjue4BmDCvb5cMTbJUEnkMaWyh7tkcE8cCMN
 /cSiUtHjJWlGvZPPg+sIe525VCpr
X-Google-Smtp-Source: APXvYqy34Xu4euaYhv6+9CS40DK2aYjlCFJ43KxOkMuh5TxvXwD3uRjmfd6esNEiyP8CJ9neeILKCA==
X-Received: by 2002:a7b:c7d3:: with SMTP id z19mr7227406wmk.98.1574905833487; 
 Wed, 27 Nov 2019 17:50:33 -0800 (PST)
Received: from x1w.redhat.com (182.red-88-21-103.staticip.rima-tde.net.
 [88.21.103.182])
 by smtp.gmail.com with ESMTPSA id k16sm8738061wru.0.2019.11.27.17.50.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Nov 2019 17:50:31 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org,
	Michael Rolnik <mrolnik@gmail.com>
Subject: [RFC PATCH 00/10] hw/avr: Introduce the Arduino board
Date: Thu, 28 Nov 2019 02:50:20 +0100
Message-Id: <20191128015030.27543-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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
Cc: Sarah Harris <S.E.Harris@kent.ac.uk>, Igor Mammedov <imammedo@redhat.com>,
 Thomas Huth <huth@tuxfamily.org>, Joaquin de Andres <me@xcancerberox.com.ar>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Pavel Dovgalyuk <dovgaluk@ispras.ru>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Michael,

I complained I'd rather have QEMU model real hardware, with
documentation (schematics).
Since your series is almost ready to get merged, I prefered to
spend some time now to write down what I wanted. This is mostly
a rewrite of your board, but matching the Arduino boards.

Some bug slipped in (uart interrupt not raised) but I'm too tired
to find it, and since I won't have time to look at it the next
days, I prefer to send this now.

The first part of the series are quick review notes, which you
should squash in your previous patches.

I still have in my TODO before merge:
- Fix the USART IRQ bug
- Split "Add limited support for USART and 16 bit timer peripherals"
  in 3 patches: USART/Timer16/INTC

And TODO after merge is:
- Extract Timer8 common parts from Timer16
- Add GPIOs
- Connect LED to GPIO on Arduino

Thank you for having insisted with this during so long!

Regards,

Phil.

Based-on: <20191127175257.23480-1-mrolnik@gmail.com>
https://www.mail-archive.com/qemu-devel@nongnu.org/msg661553.html

Philippe Mathieu-Daudé (10):
  hw/avr: Kludge to fix build failure
  target/avr: Remove unused include
  target/avr: Add missing definitions
  target/avr: Fix IRQ count
  hw/char/avr: Reduce USART I/O size
  hw/avr: Add ATmega microcontrollers
  hw/avr: Add few Arduino boards
  tests/acceptance: Keep multilines comment consistent with other tests
  tests/acceptance: Use the ATmega2560 board
  hw/avr: Remove the 'sample' board

 hw/avr/atmega.h                  |  58 +++++
 include/hw/char/avr_usart.h      |   2 +
 target/avr/cpu.h                 |   2 +
 hw/avr/arduino.c                 | 173 ++++++++++++++
 hw/avr/atmega.c                  | 379 +++++++++++++++++++++++++++++++
 hw/avr/sample.c                  | 282 -----------------------
 hw/char/avr_usart.c              |   2 +-
 target/avr/cpu.c                 |   2 +-
 target/avr/helper.c              |   1 -
 hw/avr/Makefile.objs             |   3 +-
 tests/acceptance/machine_avr6.py |  10 +-
 11 files changed, 623 insertions(+), 291 deletions(-)
 create mode 100644 hw/avr/atmega.h
 create mode 100644 hw/avr/arduino.c
 create mode 100644 hw/avr/atmega.c
 delete mode 100644 hw/avr/sample.c

-- 
2.21.0


