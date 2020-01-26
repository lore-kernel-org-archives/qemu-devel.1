Return-Path: <SRS0=sDSq=3P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4715AC2D0DB
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jan 2020 22:57:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AE1C206F0
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jan 2020 22:57:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AE1C206F0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37918 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ivqqs-0007HM-8A
	for qemu-devel@archiver.kernel.org; Sun, 26 Jan 2020 17:57:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33312)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1ivqpk-0005UF-4V
 for qemu-devel@nongnu.org; Sun, 26 Jan 2020 17:56:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1ivqpi-0000LA-9N
 for qemu-devel@nongnu.org; Sun, 26 Jan 2020 17:56:47 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:37669 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
 id 1ivqph-0007zK-UJ
 for qemu-devel@nongnu.org; Sun, 26 Jan 2020 17:56:46 -0500
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id A18DE1A1526;
 Sun, 26 Jan 2020 23:55:40 +0100 (CET)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
 [10.10.14.106])
 by mail.rt-rk.com (Postfix) with ESMTPSA id 83C761A0F00;
 Sun, 26 Jan 2020 23:55:40 +0100 (CET)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org
Subject: [PATCH rc3 00/30] target/avr merger
Date: Sun, 26 Jan 2020 23:54:41 +0100
Message-Id: <1580079311-20447-1-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 89.216.37.149
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
Cc: Aleksandar Markovic <amarkovic@wavecomp.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Aleksandar Markovic <amarkovic@wavecomp.com>

This is the AVR port from Michael release (merge) candidate 3.

The series can be found also in this repository:

https://github.com/AMarkovic/qemu-avr-merger-rc3

History:

Since v2:

- First patch is split into six smaller logical units (net result
  remains the same)
- Patch "hw/core/loader: Let load_elf populate the processor-specific
  flags" was redone to reflect the original intent that was lost in
  transalation between multiple autors
- Patch "hw/avr: Add helper to load raw/ELF firmware binaries" was
  corrected only in one line to rectify type of "e_flags"
- Patch "target/avr: Add section about AVR into QEMU documentation"
- Spurious <message-Id:> elements were removed
- The series was rebased to the latest code

Since v1:

- Addressed Thomas comments
- Fixed a non-critical bug in ATmega (incorrect SRAM base address)
- Added ELF parsing requested by Aleksandar
- Dropped default machine (as with the ARM port)

Michael Rolnik (25):
  target/avr: Add basic parameters for new AVR platform
  target/avr: Introduce AVR CPU class object
  target/avr: Add migration support
  target/avr: Add GDB support
  target/avr: Introduce AVR features
  target/avr: Add defintions of AVR core types
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

Philippe Mathieu-Daud=C3=A9 (5):
  hw/core/loader: Let load_elf populate the processor-specific flags
  hw/avr: Add helper to load raw/ELF firmware binaries
  hw/avr: Add some ATmega microcontrollers
  hw/avr: Add some Arduino boards
  .travis.yml: Run the AVR acceptance tests

 .travis.yml                      |    2 +-
 MAINTAINERS                      |   30 +
 arch_init.c                      |    2 +
 configure                        |    7 +
 default-configs/avr-softmmu.mak  |    5 +
 gdb-xml/avr-cpu.xml              |   49 +
 hw/alpha/dp264.c                 |    4 +-
 hw/arm/armv7m.c                  |    2 +-
 hw/arm/boot.c                    |    2 +-
 hw/avr/Kconfig                   |    9 +
 hw/avr/Makefile.objs             |    3 +
 hw/avr/arduino.c                 |  151 ++
 hw/avr/atmel_atmega.c            |  470 ++++++
 hw/avr/atmel_atmega.h            |   48 +
 hw/avr/boot.c                    |   74 +
 hw/avr/boot.h                    |   33 +
 hw/char/Kconfig                  |    3 +
 hw/char/Makefile.objs            |    1 +
 hw/char/atmel_usart.c            |  320 ++++
 hw/core/generic-loader.c         |    2 +-
 hw/core/loader.c                 |   37 +-
 hw/cris/boot.c                   |    2 +-
 hw/hppa/machine.c                |    4 +-
 hw/i386/multiboot.c              |    2 +-
 hw/i386/x86.c                    |    2 +-
 hw/lm32/lm32_boards.c            |    4 +-
 hw/lm32/milkymist.c              |    2 +-
 hw/m68k/an5206.c                 |    2 +-
 hw/m68k/mcf5208.c                |    2 +-
 hw/m68k/q800.c                   |    2 +-
 hw/microblaze/boot.c             |    4 +-
 hw/mips/mips_fulong2e.c          |    2 +-
 hw/mips/mips_malta.c             |    3 +-
 hw/mips/mips_mipssim.c           |    2 +-
 hw/mips/mips_r4k.c               |    2 +-
 hw/misc/Kconfig                  |    3 +
 hw/misc/Makefile.objs            |    2 +
 hw/misc/atmel_power.c            |  112 ++
 hw/moxie/moxiesim.c              |    2 +-
 hw/nios2/boot.c                  |    4 +-
 hw/openrisc/openrisc_sim.c       |    2 +-
 hw/pci-host/prep.c               |    3 +-
 hw/ppc/e500.c                    |    2 +-
 hw/ppc/mac_newworld.c            |    4 +-
 hw/ppc/mac_oldworld.c            |    4 +-
 hw/ppc/ppc440_bamboo.c           |    2 +-
 hw/ppc/sam460ex.c                |    3 +-
 hw/ppc/spapr.c                   |    6 +-
 hw/ppc/virtex_ml507.c            |    2 +-
 hw/riscv/boot.c                  |    4 +-
 hw/s390x/ipl.c                   |    7 +-
 hw/sparc/leon3.c                 |    2 +-
 hw/sparc/sun4m.c                 |    4 +-
 hw/sparc64/sun4u.c               |    5 +-
 hw/timer/Kconfig                 |    3 +
 hw/timer/Makefile.objs           |    2 +
 hw/timer/atmel_timer16.c         |  605 ++++++++
 hw/tricore/tricore_testboard.c   |    2 +-
 hw/xtensa/sim.c                  |    2 +-
 hw/xtensa/xtfpga.c               |    2 +-
 include/disas/dis-asm.h          |   19 +
 include/elf.h                    |    2 +
 include/hw/char/atmel_usart.h    |   93 ++
 include/hw/elf_ops.h             |    6 +-
 include/hw/loader.h              |   21 +-
 include/hw/misc/atmel_power.h    |   46 +
 include/hw/timer/atmel_timer16.h |   94 ++
 include/sysemu/arch_init.h       |    1 +
 qapi/machine.json                |    3 +-
 qemu-doc.texi                    |   51 +
 target/avr/Makefile.objs         |   34 +
 target/avr/cpu-param.h           |   37 +
 target/avr/cpu-qom.h             |   54 +
 target/avr/cpu.c                 |  826 +++++++++++
 target/avr/cpu.h                 |  259 ++++
 target/avr/disas.c               |  246 ++++
 target/avr/gdbstub.c             |   84 ++
 target/avr/helper.c              |  347 +++++
 target/avr/helper.h              |   29 +
 target/avr/insn.decode           |  182 +++
 target/avr/machine.c             |  121 ++
 target/avr/translate.c           | 2997 ++++++++++++++++++++++++++++++++=
++++++
 tests/acceptance/machine_avr6.py |   50 +
 tests/qtest/Makefile.include     |    2 +
 tests/qtest/boot-serial-test.c   |   11 +
 tests/qtest/machine-none-test.c  |    1 +
 86 files changed, 7613 insertions(+), 81 deletions(-)
 create mode 100644 default-configs/avr-softmmu.mak
 create mode 100644 gdb-xml/avr-cpu.xml
 create mode 100644 hw/avr/Kconfig
 create mode 100644 hw/avr/Makefile.objs
 create mode 100644 hw/avr/arduino.c
 create mode 100644 hw/avr/atmel_atmega.c
 create mode 100644 hw/avr/atmel_atmega.h
 create mode 100644 hw/avr/boot.c
 create mode 100644 hw/avr/boot.h
 create mode 100644 hw/char/atmel_usart.c
 create mode 100644 hw/misc/atmel_power.c
 create mode 100644 hw/timer/atmel_timer16.c
 create mode 100644 include/hw/char/atmel_usart.h
 create mode 100644 include/hw/misc/atmel_power.h
 create mode 100644 include/hw/timer/atmel_timer16.h
 create mode 100644 target/avr/Makefile.objs
 create mode 100644 target/avr/cpu-param.h
 create mode 100644 target/avr/cpu-qom.h
 create mode 100644 target/avr/cpu.c
 create mode 100644 target/avr/cpu.h
 create mode 100644 target/avr/disas.c
 create mode 100644 target/avr/gdbstub.c
 create mode 100644 target/avr/helper.c
 create mode 100644 target/avr/helper.h
 create mode 100644 target/avr/insn.decode
 create mode 100644 target/avr/machine.c
 create mode 100644 target/avr/translate.c
 create mode 100644 tests/acceptance/machine_avr6.py

--=20
2.7.4


