Return-Path: <SRS0=KIBN=2T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90463C2D0DB
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Dec 2019 22:47:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E98B208C4
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Dec 2019 22:47:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VYxeIYO0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E98B208C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55716 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ilhLi-0004Bg-3l
	for qemu-devel@archiver.kernel.org; Sun, 29 Dec 2019 17:47:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52645)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ilhJA-0002Lj-8P
 for qemu-devel@nongnu.org; Sun, 29 Dec 2019 17:45:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ilhJ9-0001Wc-1d
 for qemu-devel@nongnu.org; Sun, 29 Dec 2019 17:45:12 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f]:50542)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ilhJ8-0001P3-Rx
 for qemu-devel@nongnu.org; Sun, 29 Dec 2019 17:45:10 -0500
Received: by mail-wm1-x32f.google.com with SMTP id a5so12711234wmb.0
 for <qemu-devel@nongnu.org>; Sun, 29 Dec 2019 14:45:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=mEdP9m2W4ttcct2sgh3O6TXnCX9lL0+dGhsgdYIrgNg=;
 b=VYxeIYO0ykQy46VRXZk/WcAxmpbyudjATSzdvDYkX5u/AEd74C4crWLfAQPyrhHNON
 0bPcii0w3UB2VY2pBmWkeRV+oeKov7Ra3xD07vXar3XSbfMQmCwXNzCZuJZUcuzuNunZ
 +sSWTIMiI85zwWmnrkp9BJv0RR+iKP1Vu3WWnBCaBA62cl+pEibEcTLAwFPT5VeuaAfS
 w7rHF/VWOrC2g2mcXQ0P8bS0I0n649OMp5+/wKVYmlaLr2euB+KBHKSKM4XJzeg9Nmur
 PdrZfPAz3pvoyrj+FVKCkrUzHOxEh2OiJLA7Hbma4yO9sdxDz/5WNkxwH1rgpKkLKp4b
 DT2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=mEdP9m2W4ttcct2sgh3O6TXnCX9lL0+dGhsgdYIrgNg=;
 b=h9yJorvMdVYic+NcKXr/jSI62NdudFp68HUChtNqrqArX/9WaOrK8gQ8y9uOltFXAH
 BZ639FpyxUCa15nl5U0IEl30jW/00kFCYFccRUMFo3bUfpaEQfjrguhp/FrnVp8ubp0i
 /CVYwqI1VptoXK/9Me6gDSBXywaORFiuEQNE2CDIjncdGjxgFPuhmg2NttJT3ihydVDu
 zHzihbe2iAAxHU8W/UV0Av7BbR6MNLljJHK7xmWIOm+u7qNyG32zYaKTOsdqV5O0flwb
 hH924wiASE1CLqxmpKwntqkyRCqAFTk9LyPYR6Y7lllW+POEKIFEvBukV5e167WEtBDz
 txKw==
X-Gm-Message-State: APjAAAVRyYnqCe9cYooQC6NtIY9ZQxbXIGP08wBL5wKeLZLwEW97cdM+
 hrThBVSm3EEL++/oBbXRJNkrk3sb8xw=
X-Google-Smtp-Source: APXvYqzcbBDS7HXiMA3KL5e4Jlpm7hJ2nK+/r+yesCkKoWPLmsmOlfinOYKYeRyxHMFqyHCw92nH0A==
X-Received: by 2002:a05:600c:22c8:: with SMTP id
 8mr29535640wmg.178.1577659508083; 
 Sun, 29 Dec 2019 14:45:08 -0800 (PST)
Received: from x1w.home ([2a01:cb18:8372:6b00:691b:aac5:8837:d4da])
 by smtp.gmail.com with ESMTPSA id x1sm42709188wru.50.2019.12.29.14.45.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 29 Dec 2019 14:45:07 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 0/8] hw/avr: Introduce the Arduino boards
Date: Sun, 29 Dec 2019 23:44:57 +0100
Message-Id: <20191229224505.24466-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32f
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Sarah Harris <S.E.Harris@kent.ac.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Michael Rolnik <mrolnik@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

This series add the arduino boards, aiming at removing the
'sample' board that doesn't follow any specification.

Since v2:
- rebased on Michael's v40

Since v1:
- Addressed Igor comments
- Addressed Aleksandar comments
- Fixed UART issue (was due to IRQ shifted by 2 in CPU)

TODO after merge is:
- Extract Timer8 common parts from Timer16
- Add GPIOs
- Connect LED to GPIO on Arduino
- Plug to Scratch (See http://s4a.cat/).
  (I plan to purpose that as a GSoC idea).

Michael, thank you for having insisted with this port during so long!

Regards,

Phil.

Series available at https://gitlab.com/philmd/qemu/commits/arduino-v3

Regards,

Phil.

Based-on: <20191229215158.5788-1-mrolnik@gmail.com>
https://lists.gnu.org/archive/html/qemu-devel/2019-12/msg05309.html

Philippe Mathieu-Daudé (8):
  hw/char/avr: Reduce USART I/O size
  hw/timer/avr_timer16: Rename memory region debugging name
  hw/avr: Add some ATmega microcontrollers
  hw/avr: Add some Arduino boards
  tests/boot-serial-test: Test some Arduino boards (AVR based)
  tests/acceptance: Do not set the machine type manually
  tests/acceptance: Keep multilines comment consistent with other tests
  tests/acceptance: Test the Arduino MEGA2560 board

 hw/avr/atmega.h                  |  48 ++++
 hw/avr/arduino.c                 | 177 ++++++++++++
 hw/avr/atmega.c                  | 464 +++++++++++++++++++++++++++++++
 hw/char/avr_usart.c              |   2 +-
 hw/timer/avr_timer16.c           |   6 +-
 tests/boot-serial-test.c         |   2 +
 hw/avr/Makefile.objs             |   2 +
 tests/acceptance/machine_avr6.py |  11 +-
 8 files changed, 701 insertions(+), 11 deletions(-)
 create mode 100644 hw/avr/atmega.h
 create mode 100644 hw/avr/arduino.c
 create mode 100644 hw/avr/atmega.c

-- 
2.21.0


