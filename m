Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DEBDC35247
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 02:01:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D61A0214AF
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 02:01:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D61A0214AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48936 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izsxJ-0007dw-VC
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 21:01:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59556)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1izsvW-0005q2-W2
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 20:59:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1izsvV-00017X-5G
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 20:59:26 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:49828 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
 id 1izsvU-00009f-Qw
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 20:59:25 -0500
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id 9B1401A1FE2;
 Fri,  7 Feb 2020 02:58:19 +0100 (CET)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
 [10.10.14.106])
 by mail.rt-rk.com (Postfix) with ESMTPSA id 7BE6E1A1E43;
 Fri,  7 Feb 2020 02:58:19 +0100 (CET)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org
Subject: [PATCH rc5 00/32] target/avr merger
Date: Fri,  7 Feb 2020 02:57:28 +0100
Message-Id: <1581040680-308-1-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
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

This is the AVR port from Michael, release (merge) candidate 5.

The series can be found also in this repository:

https://github.com/AMarkovic/qemu-avr-merger-rc5

History:

Since v4:

- Alex tracing improvements (the only functional difference from v4)
- Moving code between patches, and sometimes between files
- Several new patches were extracted from more complex ones
- Improved commit messages
- Other minor improvements
- I added my 8 "R-b:"s that I explained in rc4, plus some more
- Series now has 0 errors and 0 warnings (checkpatch)

Since v3:

- Removed a patch on load_elf() modification, since it has been merged
- Removed references to CONFIG_USER_ONLY and provided a guard against
  building lunux user mode for AVR
- Removed all references to 'Atmel' (including file renames)
- Rebased the code (there was common interface change regarding 'props')
- Various corrections of commit messages
- A bit field for AVRFeatures is nor 64 bit long
- Other minor fixes

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

Michael Rolnik (28):
  target/avr: Add basic parameters of the new platform
  target/avr: Introduce basic CPU class object
  target/avr: CPU class: Add interrupt handling support
  target/avr: CPU class: Add memory menagement support
  target/avr: CPU class: Add migration support
  target/avr: CPU class: Add GDB support
  target/avr: Introduce enumeration AVRFeature
  target/avr: Add defintions of AVR core types
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
  hw/char: avr: Add limited support for USART peripheral
  hw/timer: avr: Add limited support for 16-bit timer peripheral
  hw/misc: avr: Add limited support for power reduction device
  target/avr: Register AVR support with the rest of QEMU
  target/avr: Update build system
  tests/machine-none: Add AVR support
  tests/boot-serial: Test some Arduino boards (AVR based)
  tests/acceptance: Test the Arduino MEGA2560 board
  target/avr: Simplify sections in MAINTAINERS file
  target/avr: Add section into QEMU documentation

Philippe Mathieu-Daud=C3=A9 (4):
  hw/avr: Add support for loading ELF/raw binaries
  hw/avr: Add some ATmega microcontrollers
  hw/avr: Add limited support for some Arduino boards
  .travis.yml: Run the AVR acceptance tests

 qemu-doc.texi                    |   51 +
 configure                        |    7 +
 default-configs/avr-softmmu.mak  |    5 +
 qapi/machine.json                |    3 +-
 hw/avr/atmega.h                  |   48 +
 hw/avr/boot.h                    |   33 +
 include/disas/dis-asm.h          |   19 +
 include/elf.h                    |    4 +
 include/hw/char/avr_usart.h      |   93 ++
 include/hw/misc/avr_power.h      |   46 +
 include/hw/timer/avr_timer16.h   |   94 ++
 include/sysemu/arch_init.h       |    1 +
 target/avr/cpu-param.h           |   37 +
 target/avr/cpu-qom.h             |   54 +
 target/avr/cpu.h                 |  256 ++++
 target/avr/helper.h              |   29 +
 target/avr/insn.decode           |  187 +++
 arch_init.c                      |    2 +
 hw/avr/arduino.c                 |  151 ++
 hw/avr/atmega.c                  |  470 ++++++
 hw/avr/boot.c                    |  116 ++
 hw/char/avr_usart.c              |  320 ++++
 hw/misc/avr_power.c              |  113 ++
 hw/timer/avr_timer16.c           |  609 ++++++++
 target/avr/cpu.c                 |  777 ++++++++++
 target/avr/disas.c               |  246 +++
 target/avr/gdbstub.c             |   84 ++
 target/avr/helper.c              |  342 +++++
 target/avr/machine.c             |  121 ++
 target/avr/translate.c           | 3073 ++++++++++++++++++++++++++++++++=
++++++
 tests/qtest/boot-serial-test.c   |   11 +
 tests/qtest/machine-none-test.c  |    1 +
 .travis.yml                      |    2 +-
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
 49 files changed, 7611 insertions(+), 2 deletions(-)
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
2.7.4


