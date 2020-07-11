Return-Path: <SRS0=vx8y=AW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A35F2C433E1
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2020 09:06:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BC2D206F0
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2020 09:06:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HbUmCSHp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BC2D206F0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44358 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juBT0-0005Pp-JM
	for qemu-devel@archiver.kernel.org; Sat, 11 Jul 2020 05:06:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33328)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1juBSH-0004cV-9n
 for qemu-devel@nongnu.org; Sat, 11 Jul 2020 05:05:57 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a]:50894)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1juBSF-0000zT-CR
 for qemu-devel@nongnu.org; Sat, 11 Jul 2020 05:05:56 -0400
Received: by mail-wm1-x32a.google.com with SMTP id l17so8458026wmj.0
 for <qemu-devel@nongnu.org>; Sat, 11 Jul 2020 02:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=g3gbtvDzXZmMfsnHf9Cv5rRWMKZmjsqtQ5WH6GtIDLI=;
 b=HbUmCSHpUgVJPOF22kxXH67J9RQ6pboreFlrIqtvnih05Ft6/4pUxnO/bePJ4S5OmW
 zFZT+pF6AwD8jYntXrXmrZeZRn/e+8X3HoQeQBrocdloi+ub842ucmFJfRLOJXdwdlxL
 3x9HRcgz4TnszVwPG121vt1I7wuH5CizX6vMMR8QxLYtkHot18lYU1uCSqoEPHrpYypS
 abXTpqmagdEQgIJruvOnCpcj37z0kLoWY7UQoV7UC+maMHJI97kBdQmrpQ6D4vz7MNrn
 81XIYWY+idl9CQ6XVaYSF66JcErOHqDhhjJz2OG3kP1RL3cQ+Rpd5RQVKlwNLlPdjIAn
 p16Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=g3gbtvDzXZmMfsnHf9Cv5rRWMKZmjsqtQ5WH6GtIDLI=;
 b=fqfst4Qm5JwCzQIvmFXb6RHqJSSj614hordTNPhInLKcffEewkkwDYJ3Bb9aoKXd/6
 eUmL8b0b9vpbLCVYOcyJ1P74WXfx1VlKN20YaNMQX4yTW8QSUCyZ1Ccy8rly5f1QVru3
 ysIbrBUHv1LLtWJMuiBPPP9qYH28dQvVcpXt3RgEAl0kO6BRbTtFwntkSlwjuWM5/b27
 IpV/qbbi4sYZVrar0BnjlCLB2ZCei2h3QCqkQ/gEQyzmjtyd/1GfJbd2tGve/TY2Uh2b
 iYT0qRyrv80xm50jTT8lXM0xjN1g5hFPm9jcC+GqCWyWahuFh+ahYjrcFl+1xXGOEPze
 eTmw==
X-Gm-Message-State: AOAM530D6F+CF4WHhePMqH/m1gtqxeUbyyuTY74NY/em2xAZPR7V/rNl
 sCw5U4ZlQktOqh0GHENeK3hkkVuz4gw=
X-Google-Smtp-Source: ABdhPJx9+97w7NKLHApN/RGx0I56K+cfRoVDqPA10zaps/YLRgel/Px8K38/Yua2VvtuLvPtyIOUxg==
X-Received: by 2002:a1c:dfc5:: with SMTP id w188mr9474494wmg.182.1594458351989; 
 Sat, 11 Jul 2020 02:05:51 -0700 (PDT)
Received: from localhost.localdomain
 (138.red-83-57-170.dynamicip.rima-tde.net. [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id c20sm17253929wrb.65.2020.07.11.02.05.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Jul 2020 02:05:51 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PULL v3 00/32] AVR port
Date: Sat, 11 Jul 2020 11:05:43 +0200
Message-Id: <20200711090544.29302-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x32a.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
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
Cc: Thomas Huth <huth@tuxfamily.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Since v2:

  Removed incorrect cpu_to_le32() call.

Since v1:

  Fixed issue on big-endian host reported by Peter Maydell.

Possible false-positives from checkpatch:

  WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?

The following changes since commit f2a1cf9180f63e88bb38ff21c169da97c3f2bad5:

  Merge remote-tracking branch 'remotes/armbru/tags/pull-error-2020-07-07-v2'=
 into staging (2020-07-10 14:41:23 +0100)

are available in the Git repository at:

  https://gitlab.com/philmd/qemu.git tags/avr-port-20200711

for you to fetch changes up to 19b293472f1514b5424ef4d9b092e02bd9b106c2:

  target/avr/disas: Fix store instructions display order (2020-07-11 11:02:05=
 +0200)

----------------------------------------------------------------
8bit AVR port from Michael Rolnik.

Michael started to work on the AVR port few years ago [*] and kept
improving the code over various series.

List of people who help him (in chronological order):
- Richard Henderson
- Sarah Harris and Edward Robbins
- Philippe Mathieu-Daud=C3=A9 and Aleksandar Markovic
- Pavel Dovgalyuk
- Thomas Huth

[*] The oldest contribution I could find on the list is from 2016:
https://lists.nongnu.org/archive/html/qemu-devel/2016-06/msg02985.html

----------------------------------------------------------------

Michael Rolnik (25):
  target/avr: Add basic parameters of the new platform
  target/avr: Introduce basic CPU class object
  target/avr: CPU class: Add interrupt handling support
  target/avr: CPU class: Add memory management support
  target/avr: CPU class: Add migration support
  target/avr: CPU class: Add GDB support
  target/avr: Introduce enumeration AVRFeature
  target/avr: Add definitions of AVR core types
  target/avr: Add instruction helpers
  target/avr: Add instruction translation - Register definitions
  target/avr: Add instruction translation - Arithmetic and Logic
    Instructions
  target/avr: Add instruction translation - Branch Instructions
  target/avr: Add instruction translation - Data Transfer Instructions
  target/avr: Add instruction translation - Bit and Bit-test
    Instructions
  target/avr: Add instruction translation - MCU Control Instructions
  target/avr: Add instruction translation - CPU main translation
    function
  target/avr: Initialize TCG register variables
  target/avr: Add support for disassembling via option '-d in_asm'
  target/avr: Register AVR support with the rest of QEMU
  tests/machine-none: Add AVR support
  hw/char: avr: Add limited support for USART peripheral
  hw/timer: avr: Add limited support for 16-bit timer peripheral
  hw/misc: avr: Add limited support for power reduction device
  tests/boot-serial: Test some Arduino boards (AVR based)
  tests/acceptance: Test the Arduino MEGA2560 board

Philippe Mathieu-Daud=C3=A9 (6):
  hw/avr: Add support for loading ELF/raw binaries
  hw/avr: Add some ATmega microcontrollers
  hw/avr: Add limited support for some Arduino boards
  target/avr/cpu: Drop tlb_flush() in avr_cpu_reset()
  target/avr/cpu: Fix $PC displayed address
  target/avr/disas: Fix store instructions display order

Thomas Huth (1):
  target/avr: Add section into QEMU documentation

 docs/system/target-avr.rst       |   37 +
 docs/system/targets.rst          |    1 +
 configure                        |    7 +
 default-configs/avr-softmmu.mak  |    5 +
 qapi/machine.json                |    3 +-
 hw/avr/atmega.h                  |   48 +
 hw/avr/boot.h                    |   33 +
 include/disas/dis-asm.h          |   19 +
 include/elf.h                    |    4 +
 include/hw/char/avr_usart.h      |   93 +
 include/hw/misc/avr_power.h      |   46 +
 include/hw/timer/avr_timer16.h   |   94 +
 include/sysemu/arch_init.h       |    1 +
 target/avr/cpu-param.h           |   36 +
 target/avr/cpu-qom.h             |   53 +
 target/avr/cpu.h                 |  256 +++
 target/avr/helper.h              |   29 +
 target/avr/insn.decode           |  187 ++
 arch_init.c                      |    2 +
 hw/avr/arduino.c                 |  149 ++
 hw/avr/atmega.c                  |  458 +++++
 hw/avr/boot.c                    |  115 ++
 hw/char/avr_usart.c              |  320 ++++
 hw/misc/avr_power.c              |  113 ++
 hw/timer/avr_timer16.c           |  621 ++++++
 target/avr/cpu.c                 |  366 ++++
 target/avr/disas.c               |  245 +++
 target/avr/gdbstub.c             |   84 +
 target/avr/helper.c              |  348 ++++
 target/avr/machine.c             |  119 ++
 target/avr/translate.c           | 3061 ++++++++++++++++++++++++++++++
 tests/qtest/boot-serial-test.c   |   11 +
 tests/qtest/machine-none-test.c  |    1 +
 MAINTAINERS                      |   30 +
 gdb-xml/avr-cpu.xml              |   49 +
 hw/Kconfig                       |    1 +
 hw/avr/Kconfig                   |    9 +
 hw/avr/Makefile.objs             |    3 +
 hw/char/Kconfig                  |    3 +
 hw/char/Makefile.objs            |    1 +
 hw/misc/Kconfig                  |    3 +
 hw/misc/Makefile.objs            |    2 +
 hw/misc/trace-events             |    4 +
 hw/timer/Kconfig                 |    3 +
 hw/timer/Makefile.objs           |    2 +
 hw/timer/trace-events            |   12 +
 target/avr/Makefile.objs         |   34 +
 tests/acceptance/machine_avr6.py |   50 +
 tests/qtest/Makefile.include     |    2 +
 49 files changed, 7172 insertions(+), 1 deletion(-)
 create mode 100644 docs/system/target-avr.rst
 create mode 100644 default-configs/avr-softmmu.mak
 create mode 100644 hw/avr/atmega.h
 create mode 100644 hw/avr/boot.h
 create mode 100644 include/hw/char/avr_usart.h
 create mode 100644 include/hw/misc/avr_power.h
 create mode 100644 include/hw/timer/avr_timer16.h
 create mode 100644 target/avr/cpu-param.h
 create mode 100644 target/avr/cpu-qom.h
 create mode 100644 target/avr/cpu.h
 create mode 100644 target/avr/helper.h
 create mode 100644 target/avr/insn.decode
 create mode 100644 hw/avr/arduino.c
 create mode 100644 hw/avr/atmega.c
 create mode 100644 hw/avr/boot.c
 create mode 100644 hw/char/avr_usart.c
 create mode 100644 hw/misc/avr_power.c
 create mode 100644 hw/timer/avr_timer16.c
 create mode 100644 target/avr/cpu.c
 create mode 100644 target/avr/disas.c
 create mode 100644 target/avr/gdbstub.c
 create mode 100644 target/avr/helper.c
 create mode 100644 target/avr/machine.c
 create mode 100644 target/avr/translate.c
 create mode 100644 gdb-xml/avr-cpu.xml
 create mode 100644 hw/avr/Kconfig
 create mode 100644 hw/avr/Makefile.objs
 create mode 100644 target/avr/Makefile.objs
 create mode 100644 tests/acceptance/machine_avr6.py

--=20
2.21.3


