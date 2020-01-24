Return-Path: <SRS0=z9mi=3N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02961C35240
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 01:04:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAE942071E
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 01:04:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAE942071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36238 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iunOx-0002IZ-24
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 20:04:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45895)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iunNI-00085G-5G
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 20:03:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iunNF-00052W-U3
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 20:03:04 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:38822)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iunNF-000526-Nu; Thu, 23 Jan 2020 20:03:01 -0500
Received: by mail-yw1-f66.google.com with SMTP id 10so141200ywv.5;
 Thu, 23 Jan 2020 17:03:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=ysquuZehZ4DPpSnCP77axJlHaML3RSGdHHMCEMv0Kh4=;
 b=DiQQeHZdaIYHMABKCKjsVyh7lCOFIL0Pt8DbHdTaZlvdlm1T0niVBf2u5H0iOQyaGe
 t1o2px2bOg1+bmF6zi4g9nh8AgLxfR0rtPXYQRCg+s6s/hkT24qwu0ySfvirpsra6yU8
 4KNEuLI1RuteR/jWUu9aO2YoFGDE5NSMrej6ik2x1o6ZzteJtR4ieE55BdWDUmOjpFHM
 ODezKN8N+SMuB4CScEgoCz/t3xgLKcPNqaHvzHMEUY9k1/0wc7b2TfWdfCuMcmPA3iMG
 S5ifs0Tll+ni0npIhmhs41GFTTgtwexuT/S/jZQhkT9QCciPQjfNL6iW8zucLffY0YV4
 kC8Q==
X-Gm-Message-State: APjAAAU51Yg9HuVLVQW3HwZGt5BS3cvXErBvL8AHeC+732rex4cli8e8
 lTGET/+AeCMKIy3VE08X1T8DXZaSDl3xTJmKJbxmIw==
X-Google-Smtp-Source: APXvYqwxwRitLqcVpV9pOujfcfzK6dUUZ6IcCyzXhjHPEGym99sE+S3ohmX2q4T69hFSDjBSedLNUiFLPe1mmHB8Vnc=
X-Received: by 2002:a0d:e890:: with SMTP id r138mr313231ywe.315.1579827780728; 
 Thu, 23 Jan 2020 17:03:00 -0800 (PST)
MIME-Version: 1.0
References: <20200124005131.16276-1-f4bug@amsat.org>
In-Reply-To: <20200124005131.16276-1-f4bug@amsat.org>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Fri, 24 Jan 2020 02:02:49 +0100
Message-ID: <CAAdtpL7y1Nsv_ivDcUHXgLn_FFOYVczmb5aPtvKhbaq8wbkXcg@mail.gmail.com>
Subject: Re: [PATCH rc2 00/25] target/avr merger
To: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Michael Rolnik <mrolnik@gmail.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Joaquin de Andres <me@xcancerberox.com.ar>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.161.66
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
 Sarah Harris <S.E.Harris@kent.ac.uk>, qemu-riscv@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Pavel Dovgalyuk <dovgaluk@ispras.ru>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jan 24, 2020 at 1:51 AM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g> wrote:
>
> This is the AVR port from Michael release (merge) candidate 2.
>
> Since v1 [1]:
> - Addressed Thomas comments
> - Fixed a non-critical bug in ATmega (incorrect SRAM base address)
> - Added ELF parsing requested by Aleksandar
> - Dropped default machine (as with the ARM port)
>
> Change since rc1:
>
> $ git backport-diff -u avr-rc1 -r origin/master..
> Key:
> [----] : patches are identical
> [####] : number of functional differences between upstream/downstream pat=
ch
> [down] : patch is downstream-only
> The flags [FC] indicate (F)unctional and (C)ontextual differences, respec=
tively
>
> 001/25:[----] [--] 'target/avr: Add outward facing interfaces and core CP=
U logic'
> 002/25:[----] [--] 'target/avr: Add instruction helpers'
> 003/25:[----] [--] 'target/avr: Add instruction translation - Registers d=
efinition'
> 004/25:[----] [--] 'target/avr: Add instruction translation - Arithmetic =
and Logic Instructions'
> 005/25:[----] [--] 'target/avr: Add instruction translation - Branch Inst=
ructions'
> 006/25:[----] [--] 'target/avr: Add instruction translation - Data Transf=
er Instructions'
> 007/25:[----] [--] 'target/avr: Add instruction translation - Bit and Bit=
-test Instructions'
> 008/25:[----] [--] 'target/avr: Add instruction translation - MCU Control=
 Instructions'
> 009/25:[----] [--] 'target/avr: Add instruction translation - CPU main tr=
anslation function'
> 010/25:[----] [--] 'target/avr: Add instruction disassembly function'
> 011/25:[----] [--] 'hw/char: Add limited support for Atmel USART peripher=
al'
> 012/25:[0045] [FC] 'hw/timer: Add limited support for Atmel 16 bit timer =
peripheral'
> 013/25:[----] [--] 'hw/misc: Add Atmel power device'
> 014/25:[0024] [FC] 'target/avr: Add section about AVR into QEMU documenta=
tion'
> 015/25:[----] [--] 'target/avr: Register AVR support with the rest of QEM=
U'
> 016/25:[----] [--] 'target/avr: Add machine none test'
> 017/25:[0002] [FC] 'target/avr: Update MAINTAINERS file'
> 018/25:[down]      'hw/core/loader: Let load_elf populate the processor-s=
pecific flags'
> 019/25:[down]      'hw/avr: Add helper to load raw/ELF firmware binaries'
> 020/25:[0015] [FC] 'hw/avr: Add some ATmega microcontrollers'
> 021/25:[0040] [FC] 'hw/avr: Add some Arduino boards'

Patchew can be used to quickly visualize the few changes:
https://patchew.org/QEMU/20200123000307.11541-1-richard.henderson@linaro.or=
g/diff/20200124005131.16276-1-f4bug@amsat.org/

> 022/25:[----] [--] 'target/avr: Update build system'
> 023/25:[----] [--] 'tests/boot-serial-test: Test some Arduino boards (AVR=
 based)'
> 024/25:[----] [--] 'tests/acceptance: Test the Arduino MEGA2560 board'
> 025/25:[----] [--] '.travis.yml: Run the AVR acceptance tests'
>
> Repo: https://gitlab.com/philmd/qemu/commits/avr-rc2
>
> [1] https://www.mail-archive.com/qemu-devel@nongnu.org/msg672926.html
> Supersedes: <20200123000307.11541-1-richard.henderson@linaro.org>
>
> Michael Rolnik (20):
>   target/avr: Add outward facing interfaces and core CPU logic
>   target/avr: Add instruction helpers
>   target/avr: Add instruction translation - Registers definition
>   target/avr: Add instruction translation - Arithmetic and Logic
>     Instructions
>   target/avr: Add instruction translation - Branch Instructions
>   target/avr: Add instruction translation - Data Transfer Instructions
>   target/avr: Add instruction translation - Bit and Bit-test
>     Instructions
>   target/avr: Add instruction translation - MCU Control Instructions
>   target/avr: Add instruction translation - CPU main translation
>     function
>   target/avr: Add instruction disassembly function
>   hw/char: Add limited support for Atmel USART peripheral
>   hw/timer: Add limited support for Atmel 16 bit timer peripheral
>   hw/misc: Add Atmel power device
>   target/avr: Add section about AVR into QEMU documentation
>   target/avr: Register AVR support with the rest of QEMU
>   target/avr: Add machine none test
>   target/avr: Update MAINTAINERS file
>   target/avr: Update build system
>   tests/boot-serial-test: Test some Arduino boards (AVR based)
>   tests/acceptance: Test the Arduino MEGA2560 board
>
> Philippe Mathieu-Daud=C3=A9 (5):
>   hw/core/loader: Let load_elf populate the processor-specific flags
>   hw/avr: Add helper to load raw/ELF firmware binaries
>   hw/avr: Add some ATmega microcontrollers
>   hw/avr: Add some Arduino boards
>   .travis.yml: Run the AVR acceptance tests
>
>  qemu-doc.texi                    |   51 +
>  configure                        |    7 +
>  default-configs/avr-softmmu.mak  |    5 +
>  qapi/machine.json                |    3 +-
>  hw/avr/atmel_atmega.h            |   48 +
>  hw/avr/boot.h                    |   33 +
>  include/disas/dis-asm.h          |   19 +
>  include/elf.h                    |    2 +
>  include/hw/char/atmel_usart.h    |   93 +
>  include/hw/elf_ops.h             |    6 +-
>  include/hw/loader.h              |    6 +-
>  include/hw/misc/atmel_power.h    |   46 +
>  include/hw/timer/atmel_timer16.h |   94 +
>  include/sysemu/arch_init.h       |    1 +
>  target/avr/cpu-param.h           |   37 +
>  target/avr/cpu-qom.h             |   54 +
>  target/avr/cpu.h                 |  259 +++
>  target/avr/helper.h              |   29 +
>  arch_init.c                      |    2 +
>  hw/avr/arduino.c                 |  151 ++
>  hw/avr/atmel_atmega.c            |  470 +++++
>  hw/avr/boot.c                    |   74 +
>  hw/char/atmel_usart.c            |  320 ++++
>  hw/core/loader.c                 |   15 +-
>  hw/misc/atmel_power.c            |  112 ++
>  hw/riscv/boot.c                  |    2 +-
>  hw/timer/atmel_timer16.c         |  605 ++++++
>  target/avr/cpu.c                 |  826 ++++++++
>  target/avr/disas.c               |  246 +++
>  target/avr/gdbstub.c             |   84 +
>  target/avr/helper.c              |  347 ++++
>  target/avr/machine.c             |  121 ++
>  target/avr/translate.c           | 2997 ++++++++++++++++++++++++++++++
>  tests/qtest/boot-serial-test.c   |   11 +
>  tests/qtest/machine-none-test.c  |    1 +
>  .travis.yml                      |    2 +-
>  MAINTAINERS                      |   30 +
>  gdb-xml/avr-cpu.xml              |   49 +
>  hw/avr/Kconfig                   |    9 +
>  hw/avr/Makefile.objs             |    3 +
>  hw/char/Kconfig                  |    3 +
>  hw/char/Makefile.objs            |    1 +
>  hw/misc/Kconfig                  |    3 +
>  hw/misc/Makefile.objs            |    2 +
>  hw/timer/Kconfig                 |    3 +
>  hw/timer/Makefile.objs           |    2 +
>  target/avr/Makefile.objs         |   34 +
>  target/avr/insn.decode           |  182 ++
>  tests/acceptance/machine_avr6.py |   50 +
>  tests/qtest/Makefile.include     |    2 +
>  50 files changed, 7539 insertions(+), 13 deletions(-)
>  create mode 100644 default-configs/avr-softmmu.mak
>  create mode 100644 hw/avr/atmel_atmega.h
>  create mode 100644 hw/avr/boot.h
>  create mode 100644 include/hw/char/atmel_usart.h
>  create mode 100644 include/hw/misc/atmel_power.h
>  create mode 100644 include/hw/timer/atmel_timer16.h
>  create mode 100644 target/avr/cpu-param.h
>  create mode 100644 target/avr/cpu-qom.h
>  create mode 100644 target/avr/cpu.h
>  create mode 100644 target/avr/helper.h
>  create mode 100644 hw/avr/arduino.c
>  create mode 100644 hw/avr/atmel_atmega.c
>  create mode 100644 hw/avr/boot.c
>  create mode 100644 hw/char/atmel_usart.c
>  create mode 100644 hw/misc/atmel_power.c
>  create mode 100644 hw/timer/atmel_timer16.c
>  create mode 100644 target/avr/cpu.c
>  create mode 100644 target/avr/disas.c
>  create mode 100644 target/avr/gdbstub.c
>  create mode 100644 target/avr/helper.c
>  create mode 100644 target/avr/machine.c
>  create mode 100644 target/avr/translate.c
>  create mode 100644 gdb-xml/avr-cpu.xml
>  create mode 100644 hw/avr/Kconfig
>  create mode 100644 hw/avr/Makefile.objs
>  create mode 100644 target/avr/Makefile.objs
>  create mode 100644 target/avr/insn.decode
>  create mode 100644 tests/acceptance/machine_avr6.py
>
> --
> 2.21.1
>

