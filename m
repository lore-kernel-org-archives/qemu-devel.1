Return-Path: <SRS0=z9mi=3N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFA1CC35240
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 00:52:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 719362071E
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 00:52:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fFYb3jFJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 719362071E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35946 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iunDG-0002cZ-GN
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 19:52:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44110)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iunCE-00016N-Hk
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 19:51:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iunCC-0004vR-Ox
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 19:51:38 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:36925)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iunCC-0004ta-GQ; Thu, 23 Jan 2020 19:51:36 -0500
Received: by mail-wr1-x442.google.com with SMTP id w15so76492wru.4;
 Thu, 23 Jan 2020 16:51:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=fNp5GtEf03ndoUx4nuSBsERa1kYKcNtCqtTjvzw4y98=;
 b=fFYb3jFJzs19+Mov9GYmXfwQzqgogqUUKThrJdiCldwekwvUvqvQsk0gYFHtZkWR1b
 y1VnmEkE6W7ETiU7VWwbD21b2FyIeVZhsZoP8cihB3py4bE2nF06SaXn+87HFFcXxuYi
 Un4LL4J+wWffBmTMd1Gdx1POYg+KtDA+2Ngb4/hcpcuk++sm/gQiDXcfpkq+ybV7IFOW
 doo1M+e4dPyJBX31bF87KCSswWHjdN15pAJP4yr9fvd1nnAT2GXqv/wejHGlJk+osTsz
 U+ESmMKf3w7Sll9pLKz9zwcvp+0gt6sz93ia/RVLzc0/pMJ6Grz+UoJVfueWv8YAmoqr
 MGzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=fNp5GtEf03ndoUx4nuSBsERa1kYKcNtCqtTjvzw4y98=;
 b=D8X5jr98dPr2BZT5xi97f3sooc46Dv1lXQOAp2gX0pkhMTXliiONZlBOAEmQFv5fMz
 bNSJOKltE+zCkmjJz78cTmYVIGDNoaT14/IBfYw88L1stCAgKNOw7vPYmDJDMO/71/yc
 av+n6SeTFKlMRwZXTkI/lZ04RxOTVHDuez0T1APt1iJ3CauKxH5ynNyJxPKuqqOos5Qs
 qZaQrd/8qMuzJAmFxjrkBSRtGgU4vDooWRafSffofsV/uRdWAgYeidHPuapV48F/Yu4l
 u+sosLi7zwZai9XAu2KsiHncUCKwOWXrLa0+rGajbXlj+wsu0b2HsYau53pKPbNwe1cA
 5SSA==
X-Gm-Message-State: APjAAAVIOV4p/lgLNBgBJeCuuhMEM/lyUKQ7p7ivrXnGJOIIk2o4xNvP
 b200jNvxstm44mDBcdwVi8LgeAd6
X-Google-Smtp-Source: APXvYqyV1UzjVLtqio8MEmWsQhfj4NULKrKo7hvJ/idT3kT7xzckAcCen7p7O/iwmJgQ/HO6bdbgcQ==
X-Received: by 2002:a5d:4f90:: with SMTP id d16mr803044wru.395.1579827094848; 
 Thu, 23 Jan 2020 16:51:34 -0800 (PST)
Received: from x1w.redhat.com (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id s139sm4598271wme.35.2020.01.23.16.51.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jan 2020 16:51:34 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org, mrolnik@gmail.com, richard.henderson@linaro.org,
 me@xcancerberox.com.ar
Subject: [PATCH rc2 00/25] target/avr merger
Date: Fri, 24 Jan 2020 01:51:06 +0100
Message-Id: <20200124005131.16276-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
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

This is the AVR port from Michael release (merge) candidate 2.

Since v1 [1]:
- Addressed Thomas comments
- Fixed a non-critical bug in ATmega (incorrect SRAM base address)
- Added ELF parsing requested by Aleksandar
- Dropped default machine (as with the ARM port)

Change since rc1:

$ git backport-diff -u avr-rc1 -r origin/master..
Key:
[----] : patches are identical
[####] : number of functional differences between upstream/downstream patch
[down] : patch is downstream-only
The flags [FC] indicate (F)unctional and (C)ontextual differences, respectively

001/25:[----] [--] 'target/avr: Add outward facing interfaces and core CPU logic'
002/25:[----] [--] 'target/avr: Add instruction helpers'
003/25:[----] [--] 'target/avr: Add instruction translation - Registers definition'
004/25:[----] [--] 'target/avr: Add instruction translation - Arithmetic and Logic Instructions'
005/25:[----] [--] 'target/avr: Add instruction translation - Branch Instructions'
006/25:[----] [--] 'target/avr: Add instruction translation - Data Transfer Instructions'
007/25:[----] [--] 'target/avr: Add instruction translation - Bit and Bit-test Instructions'
008/25:[----] [--] 'target/avr: Add instruction translation - MCU Control Instructions'
009/25:[----] [--] 'target/avr: Add instruction translation - CPU main translation function'
010/25:[----] [--] 'target/avr: Add instruction disassembly function'
011/25:[----] [--] 'hw/char: Add limited support for Atmel USART peripheral'
012/25:[0045] [FC] 'hw/timer: Add limited support for Atmel 16 bit timer peripheral'
013/25:[----] [--] 'hw/misc: Add Atmel power device'
014/25:[0024] [FC] 'target/avr: Add section about AVR into QEMU documentation'
015/25:[----] [--] 'target/avr: Register AVR support with the rest of QEMU'
016/25:[----] [--] 'target/avr: Add machine none test'
017/25:[0002] [FC] 'target/avr: Update MAINTAINERS file'
018/25:[down]      'hw/core/loader: Let load_elf populate the processor-specific flags'
019/25:[down]      'hw/avr: Add helper to load raw/ELF firmware binaries'
020/25:[0015] [FC] 'hw/avr: Add some ATmega microcontrollers'
021/25:[0040] [FC] 'hw/avr: Add some Arduino boards'
022/25:[----] [--] 'target/avr: Update build system'
023/25:[----] [--] 'tests/boot-serial-test: Test some Arduino boards (AVR based)'
024/25:[----] [--] 'tests/acceptance: Test the Arduino MEGA2560 board'
025/25:[----] [--] '.travis.yml: Run the AVR acceptance tests'

Repo: https://gitlab.com/philmd/qemu/commits/avr-rc2

[1] https://www.mail-archive.com/qemu-devel@nongnu.org/msg672926.html
Supersedes: <20200123000307.11541-1-richard.henderson@linaro.org>

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

Philippe Mathieu-Daudé (5):
  hw/core/loader: Let load_elf populate the processor-specific flags
  hw/avr: Add helper to load raw/ELF firmware binaries
  hw/avr: Add some ATmega microcontrollers
  hw/avr: Add some Arduino boards
  .travis.yml: Run the AVR acceptance tests

 qemu-doc.texi                    |   51 +
 configure                        |    7 +
 default-configs/avr-softmmu.mak  |    5 +
 qapi/machine.json                |    3 +-
 hw/avr/atmel_atmega.h            |   48 +
 hw/avr/boot.h                    |   33 +
 include/disas/dis-asm.h          |   19 +
 include/elf.h                    |    2 +
 include/hw/char/atmel_usart.h    |   93 +
 include/hw/elf_ops.h             |    6 +-
 include/hw/loader.h              |    6 +-
 include/hw/misc/atmel_power.h    |   46 +
 include/hw/timer/atmel_timer16.h |   94 +
 include/sysemu/arch_init.h       |    1 +
 target/avr/cpu-param.h           |   37 +
 target/avr/cpu-qom.h             |   54 +
 target/avr/cpu.h                 |  259 +++
 target/avr/helper.h              |   29 +
 arch_init.c                      |    2 +
 hw/avr/arduino.c                 |  151 ++
 hw/avr/atmel_atmega.c            |  470 +++++
 hw/avr/boot.c                    |   74 +
 hw/char/atmel_usart.c            |  320 ++++
 hw/core/loader.c                 |   15 +-
 hw/misc/atmel_power.c            |  112 ++
 hw/riscv/boot.c                  |    2 +-
 hw/timer/atmel_timer16.c         |  605 ++++++
 target/avr/cpu.c                 |  826 ++++++++
 target/avr/disas.c               |  246 +++
 target/avr/gdbstub.c             |   84 +
 target/avr/helper.c              |  347 ++++
 target/avr/machine.c             |  121 ++
 target/avr/translate.c           | 2997 ++++++++++++++++++++++++++++++
 tests/qtest/boot-serial-test.c   |   11 +
 tests/qtest/machine-none-test.c  |    1 +
 .travis.yml                      |    2 +-
 MAINTAINERS                      |   30 +
 gdb-xml/avr-cpu.xml              |   49 +
 hw/avr/Kconfig                   |    9 +
 hw/avr/Makefile.objs             |    3 +
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
 50 files changed, 7539 insertions(+), 13 deletions(-)
 create mode 100644 default-configs/avr-softmmu.mak
 create mode 100644 hw/avr/atmel_atmega.h
 create mode 100644 hw/avr/boot.h
 create mode 100644 include/hw/char/atmel_usart.h
 create mode 100644 include/hw/misc/atmel_power.h
 create mode 100644 include/hw/timer/atmel_timer16.h
 create mode 100644 target/avr/cpu-param.h
 create mode 100644 target/avr/cpu-qom.h
 create mode 100644 target/avr/cpu.h
 create mode 100644 target/avr/helper.h
 create mode 100644 hw/avr/arduino.c
 create mode 100644 hw/avr/atmel_atmega.c
 create mode 100644 hw/avr/boot.c
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
2.21.1


