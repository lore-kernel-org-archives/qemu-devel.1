Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F346FC32771
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 00:07:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B05FC24125
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 00:07:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FOjfTECD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B05FC24125
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48656 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuQ1c-00041v-G3
	for qemu-devel@archiver.kernel.org; Wed, 22 Jan 2020 19:07:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54451)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iuPz2-0001t8-8Z
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 19:04:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iuPyo-0001qd-SX
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 19:04:22 -0500
Received: from mail-pj1-f49.google.com ([209.85.216.49]:36526)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iuPyo-0001od-LB
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 19:04:14 -0500
Received: by mail-pj1-f49.google.com with SMTP id n59so339078pjb.1
 for <qemu-devel@nongnu.org>; Wed, 22 Jan 2020 16:04:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=g2Z20Hv6TxABg5GIqiEXxQSNPqSmonTBmAo1tMC53SY=;
 b=FOjfTECDbHxM6asbgMfA5PZjkdHXtne5dsQ0Oj5xbjW5fTYaOpBpYmqukOMDjsUGp0
 S+8zlhmbLIuSY7M4+d8cQqbfM+G8AgVZ4q2AezVS6ke87DskgWstCTt+x8z0itXCIiS6
 wFk61ronAIqe39oHxzMd2/S9H4Kh997+QVqpB+U8WcYlJ1Padwt3c0SpHtq5ZzXa1AqQ
 Vms5Si0SMiHmgtywCKmRui2Q2W/terwoAH0sWXz+rmhKQISN0mnXxCYxwO3PqRQFLgXa
 Lia9R9CXyZiLBXn5HaChJfAgX3X0y8VCgPrVs8wjjyJwd3GE+zgcUfUSFl4zaCRvI5n6
 Vsdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=g2Z20Hv6TxABg5GIqiEXxQSNPqSmonTBmAo1tMC53SY=;
 b=A8yqphw9A+QGeeenwvDrJ/KjmIQ3wZ0N93nb/z0XqUMf144LqXkxBYjbgjJNl+IP2K
 MJ2HqdsthLtTZR6+hPozPdhsjyoysKj76pE4upCavJXtn6phMpJwyoNJuXfn2p5JvDZt
 ZO8m32pwv/XqP7e9KCGd91GZms3vyFz+pwoyjAWEyUEj0J5Stge37rMYt/8YwvR2V1O5
 mhVXBZHc/C0z9f2xMz0+uq8tb5jBpjRxQz0YVRPu1JISZ7oK3f+qC0YyQVE20774v1N9
 Eb2txH8lZGRGp0GZ6gbhcEhg23xQQoLVbtZsIPzw+5Vm+3ks+wBup80DH85BcDD4dbym
 O4iQ==
X-Gm-Message-State: APjAAAWGZaa+1OM7mfovoqj7SFbY4Ii1r1ZgDgvneT9OQipPvT86yZuF
 UUOCeCaKYJ3EiKcJJNN1vkXuZavEhmo=
X-Google-Smtp-Source: APXvYqyDeSLEcz00GNBUBMyqdP6fjjcurtuKMlZgR3wIKhhOXY8JeaCMaVaCFEptNMI7mb+NEGEmIQ==
X-Received: by 2002:a17:902:d915:: with SMTP id
 c21mr13504432plz.295.1579737790873; 
 Wed, 22 Jan 2020 16:03:10 -0800 (PST)
Received: from localhost.localdomain (rrcs-173-198-77-92.west.biz.rr.com.
 [173.198.77.92])
 by smtp.gmail.com with ESMTPSA id b21sm84521pfp.0.2020.01.22.16.03.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jan 2020 16:03:10 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH rc1 00/24] target/avr merger
Date: Wed, 22 Jan 2020 14:02:43 -1000
Message-Id: <20200123000307.11541-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.216.49
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
Cc: thuth@redhat.com, me@xcancerberox.com.ar, S.E.Harris@kent.ac.uk,
 dovgaluk@ispras.ru, imammedo@redhat.com, mrolnik@gmail.com,
 aleksandar.m.mail@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is a merger of Michael's v41 of the base avr architecture,
and v4 of Phil's arduino target boards.  Call this release, or
merge, candidate 1.

Has all commentary been addressed?  How much more, if anything,
does anyone require before allowing normal development in tree?


r~


Michael Rolnik (20):
  target/avr: Add outward facing interfaces and core CPU logic
  target/avr: Add instruction helpers
  target/avr: Add instruction translation - Registers definition
  target/avr: Add instruction translation - Arithmetic and Logic
    Instructions
  target/avr: Add instruction translation - Branch Instructions
  target/avr: Add instruction translation - Data Transfer Instructions
  target/avr: Add instruction translation - Bit and Bit-test
    Instructions
  target/avr: Add instruction translation - MCU Control Instructions
  target/avr: Add instruction translation - CPU main translation
    function
  target/avr: Add instruction disassembly function
  hw/char: Add limited support for Atmel USART peripheral
  hw/timer: Add limited support for Atmel 16 bit timer peripheral
  hw/misc: Add Atmel power device
  target/avr: Add section about AVR into QEMU documentation
  target/avr: Register AVR support with the rest of QEMU
  target/avr: Add machine none test
  target/avr: Update MAINTAINERS file
  target/avr: Update build system
  tests/boot-serial-test: Test some Arduino boards (AVR based)
  tests/acceptance: Test the Arduino MEGA2560 board

Philippe Mathieu-Daudé (4):
  hw/avr: Introduce ATMEL_ATMEGA_MCU config
  hw/avr: Add some ATmega microcontrollers
  hw/avr: Add some Arduino boards
  .travis.yml: Run the AVR acceptance tests

 qemu-doc.texi                    |   51 +
 configure                        |    7 +
 default-configs/avr-softmmu.mak  |    5 +
 qapi/machine.json                |    3 +-
 hw/avr/atmel_atmega.h            |   48 +
 include/disas/dis-asm.h          |   19 +
 include/hw/char/atmel_usart.h    |   93 +
 include/hw/misc/atmel_power.h    |   46 +
 include/hw/timer/atmel_timer16.h |   94 +
 include/sysemu/arch_init.h       |    1 +
 target/avr/cpu-param.h           |   37 +
 target/avr/cpu-qom.h             |   54 +
 target/avr/cpu.h                 |  259 +++
 target/avr/helper.h              |   29 +
 arch_init.c                      |    2 +
 hw/avr/arduino.c                 |  175 ++
 hw/avr/atmel_atmega.c            |  464 +++++
 hw/char/atmel_usart.c            |  320 ++++
 hw/misc/atmel_power.c            |  112 ++
 hw/timer/atmel_timer16.c         |  602 ++++++
 target/avr/cpu.c                 |  826 ++++++++
 target/avr/disas.c               |  246 +++
 target/avr/gdbstub.c             |   84 +
 target/avr/helper.c              |  347 ++++
 target/avr/machine.c             |  121 ++
 target/avr/translate.c           | 2997 ++++++++++++++++++++++++++++++
 tests/qtest/boot-serial-test.c   |   11 +
 tests/qtest/machine-none-test.c  |    1 +
 .travis.yml                      |    2 +-
 MAINTAINERS                      |   26 +
 gdb-xml/avr-cpu.xml              |   49 +
 hw/avr/Kconfig                   |    9 +
 hw/avr/Makefile.objs             |    2 +
 hw/char/Kconfig                  |    3 +
 hw/char/Makefile.objs            |    1 +
 hw/misc/Kconfig                  |    3 +
 hw/misc/Makefile.objs            |    2 +
 hw/timer/Kconfig                 |    3 +
 hw/timer/Makefile.objs           |    2 +
 target/avr/Makefile.objs         |   34 +
 target/avr/insn.decode           |  182 ++
 tests/acceptance/machine_avr6.py |   50 +
 tests/qtest/Makefile.include     |    2 +
 43 files changed, 7422 insertions(+), 2 deletions(-)
 create mode 100644 default-configs/avr-softmmu.mak
 create mode 100644 hw/avr/atmel_atmega.h
 create mode 100644 include/hw/char/atmel_usart.h
 create mode 100644 include/hw/misc/atmel_power.h
 create mode 100644 include/hw/timer/atmel_timer16.h
 create mode 100644 target/avr/cpu-param.h
 create mode 100644 target/avr/cpu-qom.h
 create mode 100644 target/avr/cpu.h
 create mode 100644 target/avr/helper.h
 create mode 100644 hw/avr/arduino.c
 create mode 100644 hw/avr/atmel_atmega.c
 create mode 100644 hw/char/atmel_usart.c
 create mode 100644 hw/misc/atmel_power.c
 create mode 100644 hw/timer/atmel_timer16.c
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
 create mode 100644 target/avr/insn.decode
 create mode 100644 tests/acceptance/machine_avr6.py

-- 
2.20.1


