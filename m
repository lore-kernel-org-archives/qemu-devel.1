Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D542BC32771
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 22:03:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CAED22525
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 22:03:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bBOEg5KP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CAED22525
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44584 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itf8x-0003OE-Uz
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 17:03:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50937)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1itf6f-0001Vl-R3
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 17:01:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1itf6e-0005jZ-BB
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 17:01:13 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:38094)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1itf6e-0005hP-3E
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 17:01:12 -0500
Received: by mail-wm1-x342.google.com with SMTP id u2so926696wmc.3
 for <qemu-devel@nongnu.org>; Mon, 20 Jan 2020 14:01:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=o1/XihkHx3wDE3wzXaKMTD/LC02jiJyJ9sA9xN9KFMk=;
 b=bBOEg5KPbXn/bncb4h/L9CzVyAKM+AbvBWxHJW1GVDSGL57A2BNTprW/PdfbKRKQlR
 AfQyJdMMDbhnjycd19AAABzLc9u7Gh6klzcnJOiTTvLR63oWQ2h/wJrTssB5wcqHkCSH
 Eoxsxjl9qen3ES0vSk9/y2eZqTfXCBxxapLMxynDXGw6XDp/w36nb3PDT0v+ErwQOoZF
 Z9hKcNN3eoua3S7iScyIB5iLTQLrmft2HoZ0YeNFdq8lBF6Ujt1BRRBxfca3sZ6r23pO
 B/gSjt0H5XT5lGmdfbFg+TYSvX2QCSFOGxBlz5o6XDkbRIF0j2MZBDe4KxBtBdJ16jb5
 6a1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=o1/XihkHx3wDE3wzXaKMTD/LC02jiJyJ9sA9xN9KFMk=;
 b=S4ZKsMWZMGl7tQ8uM7M8qEZ3rhGO4mcg0/oTdsBM9nsCHLVHt8t2paOwVpCYp6+74j
 ChYerl8jJVXQ5SHFCpxaPVQuArZYXO7GNscu4jkTOzeAFeKaEyoR4Lb/i4qmK/omtRTu
 MoJJgKpS8tMCyurtDmghbWNra8/qlFjWroU//lMXkflp3AwrkraGplHX4MNcXvQ1hChg
 ow0kYm+HIIgPVIIiLnwF41UxIyuLBqybIEnWe4VnZYLzNsfkhBX/MNPgFDuokEL36PGC
 8S7wHobl9WgxGi/d7S4PuHa7KZfTxKLh/xitxZlgkhtC7p/I4flidA/dPHGjFO0wub2A
 rd8w==
X-Gm-Message-State: APjAAAUb9pA6vfmQ0aISvhiFqYFpSp4LtRfvbpFarVSQJI3inJjgECWD
 hX9vOXcmhuOZ3frJGQp+L2wo1CKV
X-Google-Smtp-Source: APXvYqzA3oa4HnfGsDMcKryyE7/K7KkfmR3BziJrfynSoWNAmc8WcVymY4JZcIHDExUWhKAPJ7TDGg==
X-Received: by 2002:a05:600c:2c0b:: with SMTP id
 q11mr862004wmg.2.1579557669518; 
 Mon, 20 Jan 2020 14:01:09 -0800 (PST)
Received: from x1w.redhat.com (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id f1sm904341wmc.45.2020.01.20.14.01.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jan 2020 14:01:08 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 00/18] hw/avr: Introduce few Arduino boards
Date: Mon, 20 Jan 2020 23:00:49 +0100
Message-Id: <20200120220107.17825-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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

Hi,

This series add the arduino boards, aiming at removing the
'sample' board that doesn't follow any specification.

Since v3:
- Rebased on Michael's v41
- Drop 'extram' unused field (Igor)
- Renamed devices AVR -> Atmel (Aleksandar)
  (I haven't renamed structure names to ease review)

Since v2:
- rebased on Michael's v40

Since v1:
- Addressed Igor comments
- Addressed Aleksandar comments
- Fixed UART issue (was due to IRQ shifted by 2 in CPU)

Since Michael's work is not yet merged, Various of my patches
- which are trivials or simple renames - could be squashed
directly on his patches, if we ever care.
[I believe sending this patches is easier/quicker than keeping
asking Michael to respin his series infinitely].

Michael, do you mind testing it? The full series is available
here: https://gitlab.com/philmd/qemu/commits/arduino-v4

Regards,

Phil.

Obsoletes: <20191229224505.24466-1-f4bug@amsat.org>
Based-on: <20200118191416.19934-1-mrolnik@gmail.com>
https://www.mail-archive.com/qemu-devel@nongnu.org/msg671707.html

Philippe Mathieu-Daudé (18):
  MAINTAINERS: Move machine test to the machine section (not ARCH one)
  MAINTAINERS: Move the AVR machines in new section (not within ARM)
  tests/acceptance: Do not set the machine type manually
  tests/acceptance: Keep multilines comment consistent with other tests
  hw/char/avr: Reduce USART I/O size
  hw/timer/avr_timer16: Rename memory region debugging name
  hw/misc/avr_mask: Remove unused include
  hw/avr/Makefile: Use CONFIG_AVR_SAMPLE variable
  hw/char: Rename avr_usart -> atmel_usart
  hw/timer: Rename avr_timer16 -> atmel_timer16
  hw/misc: Rename avr_mask -> atmel_power
  hw/avr: Introduce ATMEL_ATMEGA_MCU config
  hw/avr: Add some ATmega microcontrollers
  hw/avr: Add some Arduino boards
  tests/boot-serial-test: Test some Arduino boards (AVR based)
  tests/acceptance: Test the Arduino MEGA2560 board
  hw/avr: Remove the unrealistic AVR 'sample' board
  .travis.yml: Run the AVR acceptance tests

 default-configs/avr-softmmu.mak               |   2 +-
 hw/avr/atmel_atmega.h                         |  48 ++
 .../hw/char/{avr_usart.h => atmel_usart.h}    |  10 +-
 include/hw/misc/{avr_mask.h => atmel_power.h} |  11 +-
 .../timer/{avr_timer16.h => atmel_timer16.h}  |  10 +-
 hw/avr/arduino.c                              | 175 +++++++
 hw/avr/atmel_atmega.c                         | 464 ++++++++++++++++++
 hw/avr/sample.c                               | 295 -----------
 hw/char/{avr_usart.c => atmel_usart.c}        |   6 +-
 hw/misc/{avr_mask.c => atmel_power.c}         |   4 +-
 hw/timer/{avr_timer16.c => atmel_timer16.c}   |  10 +-
 tests/qtest/boot-serial-test.c                |   3 +-
 .travis.yml                                   |   2 +-
 MAINTAINERS                                   |  29 +-
 hw/avr/Kconfig                                |  11 +-
 hw/avr/Makefile.objs                          |   3 +-
 hw/char/Kconfig                               |   2 +-
 hw/char/Makefile.objs                         |   2 +-
 hw/misc/Kconfig                               |   2 +-
 hw/misc/Makefile.objs                         |   2 +-
 hw/timer/Kconfig                              |   2 +-
 hw/timer/Makefile.objs                        |   2 +-
 tests/acceptance/machine_avr6.py              |  11 +-
 23 files changed, 751 insertions(+), 355 deletions(-)
 create mode 100644 hw/avr/atmel_atmega.h
 rename include/hw/char/{avr_usart.h => atmel_usart.h} (93%)
 rename include/hw/misc/{avr_mask.h => atmel_power.h} (89%)
 rename include/hw/timer/{avr_timer16.h => atmel_timer16.h} (92%)
 create mode 100644 hw/avr/arduino.c
 create mode 100644 hw/avr/atmel_atmega.c
 delete mode 100644 hw/avr/sample.c
 rename hw/char/{avr_usart.c => atmel_usart.c} (99%)
 rename hw/misc/{avr_mask.c => atmel_power.c} (97%)
 rename hw/timer/{avr_timer16.c => atmel_timer16.c} (98%)

-- 
2.21.1


