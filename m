Return-Path: <SRS0=z9mi=3N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31747C2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 14:13:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD1832075D
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 14:13:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JS0UWD9X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD1832075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42910 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuzhy-0001O4-1Y
	for qemu-devel@archiver.kernel.org; Fri, 24 Jan 2020 09:13:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41062)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mrolnik@gmail.com>) id 1iuzhD-0000wR-LZ
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 09:12:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mrolnik@gmail.com>) id 1iuzhB-0002cb-2K
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 09:12:27 -0500
Received: from mail-qk1-x731.google.com ([2607:f8b0:4864:20::731]:34118)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mrolnik@gmail.com>)
 id 1iuzhA-0002a4-PF; Fri, 24 Jan 2020 09:12:25 -0500
Received: by mail-qk1-x731.google.com with SMTP id d10so2151278qke.1;
 Fri, 24 Jan 2020 06:12:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ZZmsyJbYB61rBQK6Q2NwHZ+S5tKVA2giRRE+T5/5hpM=;
 b=JS0UWD9XXJupEub1Joci9ba9PEyIiPvShdET1e4ZZhiKuXBhyNM44lltWhpgUV92f9
 U28YEsKFBpQfDhoNUAUXJaEiPT4EmvJh8dTkv/Z87PfnhwOjtdmNBpG4rKJ7dJubMr/G
 KFQD0S49zi8TEVkGcXnLRsHaPHoSx5g5eq023VrSk73kS0ZyqRnAlmll4gju9lZ5WQj8
 RxLwHjEU12v4mCzwSBCF1JXL/Fz3q/VaOhjv6qthgHLYr2E0FvJv6M9HmYJ06CIbpiPj
 HuM0l5OcoHiWTy0i6/ECy77p+JzUrS0Jp1kMyutokm3IUvA77Cvv20HQb2vWW308Kh5H
 tPZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ZZmsyJbYB61rBQK6Q2NwHZ+S5tKVA2giRRE+T5/5hpM=;
 b=j0gLBibMyjtbFPBR3B6WbD8LZGh1NmWq0ELi3phWdFNegUeboRZJ8sfEfjpmdCOEX0
 vxsQhl4xG4xAR6lJYmAOXdpcD/K4gP8iCr44+IBUAnarzRYUL6BXf19NWw9yHWxETmjN
 xLoPTM0X8VBYCLHGkE2lQXyFCkLJwBjZY1gScVMVl3/sGcWWUy3fZj73zu8nH4JfOSYJ
 w9T62o3AufxPsiI8SguU2H8aALbU/QkVDctKSR1g0GI4+B+m04Zh1IlV1fvMB0ZM4O7U
 vAbi2R2XIfieVU552et6Zl6E3YTLa9eTQPtYbT17JhnXwCMc5guJ16jDiIZex41nJPA1
 +2Hg==
X-Gm-Message-State: APjAAAUCrvLJ5+3heNwIpWJN90e4eUy0KKf0rhfEMdOff5XrLlNUGIl3
 E0Q2IDPwNP18IO5O2ZFjce/3Ks2TXxPorZDjcdk=
X-Google-Smtp-Source: APXvYqxb8P3GOW3xqHAbDgyPgVp5YBqWTJEawo69B8ueTnML9lApY25GWBbnQY+/Xow4gRPVZldkDO88zOkGLdTY63k=
X-Received: by 2002:a05:620a:672:: with SMTP id
 a18mr2750381qkh.378.1579875142694; 
 Fri, 24 Jan 2020 06:12:22 -0800 (PST)
MIME-Version: 1.0
References: <20200124005131.16276-1-f4bug@amsat.org>
 <CAK4993iG+t7fZS=cekXfJVpDQ_L7jLu8i2V4mHVLbS-r69=AVg@mail.gmail.com>
 <00c08b6d-6ca2-7fa6-3dab-b834aea5a8d3@redhat.com>
In-Reply-To: <00c08b6d-6ca2-7fa6-3dab-b834aea5a8d3@redhat.com>
From: Michael Rolnik <mrolnik@gmail.com>
Date: Fri, 24 Jan 2020 16:11:40 +0200
Message-ID: <CAK4993iFYQ24=u8NHopfb7o54hX4vzKH5-9Y_j17eytNGi7_8A@mail.gmail.com>
Subject: Re: [PATCH rc2 00/25] target/avr merger
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: multipart/mixed; boundary="000000000000ab9b01059ce358ae"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::731
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
Cc: Fam Zheng <fam@euphon.net>, Sarah Harris <S.E.Harris@kent.ac.uk>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Joaquin de Andres <me@xcancerberox.com.ar>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Markus Armbruster <armbru@redhat.com>, Pavel Dovgalyuk <dovgaluk@ispras.ru>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>,
 Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, qemu-riscv@nongnu.org,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000ab9b01059ce358ae
Content-Type: multipart/alternative; boundary="000000000000ab9b00059ce358ac"

--000000000000ab9b00059ce358ac
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Just one patch attached.
Thanks.

On Fri, Jan 24, 2020 at 2:49 PM Philippe Mathieu-Daud=C3=A9 <philmd@redhat.=
com>
wrote:

> On 1/24/20 12:41 PM, Michael Rolnik wrote:
> > Tested-by: Michael Rolnik <mrolnik@gmail.com <mailto:mrolnik@gmail.com>=
>
>
> Thanks a lot!
>
> > The only thing I want to change is instead of -kernel put -bios in
> > qemu-doc.texi file. Should I send a new series?
>
> Please do NOT :)
>
> Richard can do the trivial fixup directly.
>
> > On Fri, Jan 24, 2020 at 2:51 AM Philippe Mathieu-Daud=C3=A9 <f4bug@amsa=
t.org
> > <mailto:f4bug@amsat.org>> wrote:
> >
> >     This is the AVR port from Michael release (merge) candidate 2.
> >
> >     Since v1 [1]:
> >     - Addressed Thomas comments
> >     - Fixed a non-critical bug in ATmega (incorrect SRAM base address)
> >     - Added ELF parsing requested by Aleksandar
> >     - Dropped default machine (as with the ARM port)
> >
> >     Change since rc1:
> >
> >     $ git backport-diff -u avr-rc1 -r origin/master..
> >     Key:
> >     [----] : patches are identical
> >     [####] : number of functional differences between
> >     upstream/downstream patch
> >     [down] : patch is downstream-only
> >     The flags [FC] indicate (F)unctional and (C)ontextual differences,
> >     respectively
> >
> >     001/25:[----] [--] 'target/avr: Add outward facing interfaces and
> >     core CPU logic'
> >     002/25:[----] [--] 'target/avr: Add instruction helpers'
> >     003/25:[----] [--] 'target/avr: Add instruction translation -
> >     Registers definition'
> >     004/25:[----] [--] 'target/avr: Add instruction translation -
> >     Arithmetic and Logic Instructions'
> >     005/25:[----] [--] 'target/avr: Add instruction translation - Branc=
h
> >     Instructions'
> >     006/25:[----] [--] 'target/avr: Add instruction translation - Data
> >     Transfer Instructions'
> >     007/25:[----] [--] 'target/avr: Add instruction translation - Bit
> >     and Bit-test Instructions'
> >     008/25:[----] [--] 'target/avr: Add instruction translation - MCU
> >     Control Instructions'
> >     009/25:[----] [--] 'target/avr: Add instruction translation - CPU
> >     main translation function'
> >     010/25:[----] [--] 'target/avr: Add instruction disassembly functio=
n'
> >     011/25:[----] [--] 'hw/char: Add limited support for Atmel USART
> >     peripheral'
> >     012/25:[0045] [FC] 'hw/timer: Add limited support for Atmel 16 bit
> >     timer peripheral'
> >     013/25:[----] [--] 'hw/misc: Add Atmel power device'
> >     014/25:[0024] [FC] 'target/avr: Add section about AVR into QEMU
> >     documentation'
> >     015/25:[----] [--] 'target/avr: Register AVR support with the rest
> >     of QEMU'
> >     016/25:[----] [--] 'target/avr: Add machine none test'
> >     017/25:[0002] [FC] 'target/avr: Update MAINTAINERS file'
> >     018/25:[down]      'hw/core/loader: Let load_elf populate the
> >     processor-specific flags'
> >     019/25:[down]      'hw/avr: Add helper to load raw/ELF firmware
> >     binaries'
> >     020/25:[0015] [FC] 'hw/avr: Add some ATmega microcontrollers'
> >     021/25:[0040] [FC] 'hw/avr: Add some Arduino boards'
> >     022/25:[----] [--] 'target/avr: Update build system'
> >     023/25:[----] [--] 'tests/boot-serial-test: Test some Arduino board=
s
> >     (AVR based)'
> >     024/25:[----] [--] 'tests/acceptance: Test the Arduino MEGA2560
> board'
> >     025/25:[----] [--] '.travis.yml: Run the AVR acceptance tests'
> >
> >     Repo: https://gitlab.com/philmd/qemu/commits/avr-rc2
> >
> >     [1]
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg672926.html
> >     Supersedes: <20200123000307.11541-1-richard.henderson@linaro.org
> >     <mailto:20200123000307.11541-1-richard.henderson@linaro.org>>
> >
> >     Michael Rolnik (20):
> >        target/avr: Add outward facing interfaces and core CPU logic
> >        target/avr: Add instruction helpers
> >        target/avr: Add instruction translation - Registers definition
> >        target/avr: Add instruction translation - Arithmetic and Logic
> >          Instructions
> >        target/avr: Add instruction translation - Branch Instructions
> >        target/avr: Add instruction translation - Data Transfer
> Instructions
> >        target/avr: Add instruction translation - Bit and Bit-test
> >          Instructions
> >        target/avr: Add instruction translation - MCU Control Instructio=
ns
> >        target/avr: Add instruction translation - CPU main translation
> >          function
> >        target/avr: Add instruction disassembly function
> >        hw/char: Add limited support for Atmel USART peripheral
> >        hw/timer: Add limited support for Atmel 16 bit timer peripheral
> >        hw/misc: Add Atmel power device
> >        target/avr: Add section about AVR into QEMU documentation
> >        target/avr: Register AVR support with the rest of QEMU
> >        target/avr: Add machine none test
> >        target/avr: Update MAINTAINERS file
> >        target/avr: Update build system
> >        tests/boot-serial-test: Test some Arduino boards (AVR based)
> >        tests/acceptance: Test the Arduino MEGA2560 board
> >
> >     Philippe Mathieu-Daud=C3=A9 (5):
> >        hw/core/loader: Let load_elf populate the processor-specific fla=
gs
> >        hw/avr: Add helper to load raw/ELF firmware binaries
> >        hw/avr: Add some ATmega microcontrollers
> >        hw/avr: Add some Arduino boards
> >        .travis.yml: Run the AVR acceptance tests
> >
> >       qemu-doc.texi                    |   51 +
> >       configure                        |    7 +
> >       default-configs/avr-softmmu.mak  |    5 +
> >       qapi/machine.json                |    3 +-
> >       hw/avr/atmel_atmega.h            |   48 +
> >       hw/avr/boot.h                    |   33 +
> >       include/disas/dis-asm.h          |   19 +
> >       include/elf.h                    |    2 +
> >       include/hw/char/atmel_usart.h    |   93 +
> >       include/hw/elf_ops.h             |    6 +-
> >       include/hw/loader.h              |    6 +-
> >       include/hw/misc/atmel_power.h    |   46 +
> >       include/hw/timer/atmel_timer16.h |   94 +
> >       include/sysemu/arch_init.h       |    1 +
> >       target/avr/cpu-param.h           |   37 +
> >       target/avr/cpu-qom.h             |   54 +
> >       target/avr/cpu.h                 |  259 +++
> >       target/avr/helper.h              |   29 +
> >       arch_init.c                      |    2 +
> >       hw/avr/arduino.c                 |  151 ++
> >       hw/avr/atmel_atmega.c            |  470 +++++
> >       hw/avr/boot.c                    |   74 +
> >       hw/char/atmel_usart.c            |  320 ++++
> >       hw/core/loader.c                 |   15 +-
> >       hw/misc/atmel_power.c            |  112 ++
> >       hw/riscv/boot.c                  |    2 +-
> >       hw/timer/atmel_timer16.c         |  605 ++++++
> >       target/avr/cpu.c                 |  826 ++++++++
> >       target/avr/disas.c               |  246 +++
> >       target/avr/gdbstub.c             |   84 +
> >       target/avr/helper.c              |  347 ++++
> >       target/avr/machine.c             |  121 ++
> >       target/avr/translate.c           | 2997
> ++++++++++++++++++++++++++++++
> >       tests/qtest/boot-serial-test.c   |   11 +
> >       tests/qtest/machine-none-test.c  |    1 +
> >       .travis.yml                      |    2 +-
> >       MAINTAINERS                      |   30 +
> >       gdb-xml/avr-cpu.xml              |   49 +
> >       hw/avr/Kconfig                   |    9 +
> >       hw/avr/Makefile.objs             |    3 +
> >       hw/char/Kconfig                  |    3 +
> >       hw/char/Makefile.objs            |    1 +
> >       hw/misc/Kconfig                  |    3 +
> >       hw/misc/Makefile.objs            |    2 +
> >       hw/timer/Kconfig                 |    3 +
> >       hw/timer/Makefile.objs           |    2 +
> >       target/avr/Makefile.objs         |   34 +
> >       target/avr/insn.decode           |  182 ++
> >       tests/acceptance/machine_avr6.py |   50 +
> >       tests/qtest/Makefile.include     |    2 +
> >       50 files changed, 7539 insertions(+), 13 deletions(-)
> >       create mode 100644 default-configs/avr-softmmu.mak
> >       create mode 100644 hw/avr/atmel_atmega.h
> >       create mode 100644 hw/avr/boot.h
> >       create mode 100644 include/hw/char/atmel_usart.h
> >       create mode 100644 include/hw/misc/atmel_power.h
> >       create mode 100644 include/hw/timer/atmel_timer16.h
> >       create mode 100644 target/avr/cpu-param.h
> >       create mode 100644 target/avr/cpu-qom.h
> >       create mode 100644 target/avr/cpu.h
> >       create mode 100644 target/avr/helper.h
> >       create mode 100644 hw/avr/arduino.c
> >       create mode 100644 hw/avr/atmel_atmega.c
> >       create mode 100644 hw/avr/boot.c
> >       create mode 100644 hw/char/atmel_usart.c
> >       create mode 100644 hw/misc/atmel_power.c
> >       create mode 100644 hw/timer/atmel_timer16.c
> >       create mode 100644 target/avr/cpu.c
> >       create mode 100644 target/avr/disas.c
> >       create mode 100644 target/avr/gdbstub.c
> >       create mode 100644 target/avr/helper.c
> >       create mode 100644 target/avr/machine.c
> >       create mode 100644 target/avr/translate.c
> >       create mode 100644 gdb-xml/avr-cpu.xml
> >       create mode 100644 hw/avr/Kconfig
> >       create mode 100644 hw/avr/Makefile.objs
> >       create mode 100644 target/avr/Makefile.objs
> >       create mode 100644 target/avr/insn.decode
> >       create mode 100644 tests/acceptance/machine_avr6.py
> >
> >     --
> >     2.21.1
> >
> >
> >
> > --
> > Best Regards,
> > Michael Rolnik
>
>

--=20
Best Regards,
Michael Rolnik

--000000000000ab9b00059ce358ac
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Just one patch attached.</div><div>Thanks.</div></div=
><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Fr=
i, Jan 24, 2020 at 2:49 PM Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailt=
o:philmd@redhat.com">philmd@redhat.com</a>&gt; wrote:<br></div><blockquote =
class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px sol=
id rgb(204,204,204);padding-left:1ex">On 1/24/20 12:41 PM, Michael Rolnik w=
rote:<br>
&gt; Tested-by: Michael Rolnik &lt;<a href=3D"mailto:mrolnik@gmail.com" tar=
get=3D"_blank">mrolnik@gmail.com</a> &lt;mailto:<a href=3D"mailto:mrolnik@g=
mail.com" target=3D"_blank">mrolnik@gmail.com</a>&gt;&gt;<br>
<br>
Thanks a lot!<br>
<br>
&gt; The only thing I want to change is instead of -kernel put -bios in <br=
>
&gt; qemu-doc.texi file. Should I send a new series?<br>
<br>
Please do NOT :)<br>
<br>
Richard can do the trivial fixup directly.<br>
<br>
&gt; On Fri, Jan 24, 2020 at 2:51 AM Philippe Mathieu-Daud=C3=A9 &lt;<a hre=
f=3D"mailto:f4bug@amsat.org" target=3D"_blank">f4bug@amsat.org</a> <br>
&gt; &lt;mailto:<a href=3D"mailto:f4bug@amsat.org" target=3D"_blank">f4bug@=
amsat.org</a>&gt;&gt; wrote:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0This is the AVR port from Michael release (merge) c=
andidate 2.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Since v1 [1]:<br>
&gt;=C2=A0 =C2=A0 =C2=A0- Addressed Thomas comments<br>
&gt;=C2=A0 =C2=A0 =C2=A0- Fixed a non-critical bug in ATmega (incorrect SRA=
M base address)<br>
&gt;=C2=A0 =C2=A0 =C2=A0- Added ELF parsing requested by Aleksandar<br>
&gt;=C2=A0 =C2=A0 =C2=A0- Dropped default machine (as with the ARM port)<br=
>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Change since rc1:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0$ git backport-diff -u avr-rc1 -r origin/master..<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0Key:<br>
&gt;=C2=A0 =C2=A0 =C2=A0[----] : patches are identical<br>
&gt;=C2=A0 =C2=A0 =C2=A0[####] : number of functional differences between<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0upstream/downstream patch<br>
&gt;=C2=A0 =C2=A0 =C2=A0[down] : patch is downstream-only<br>
&gt;=C2=A0 =C2=A0 =C2=A0The flags [FC] indicate (F)unctional and (C)ontextu=
al differences,<br>
&gt;=C2=A0 =C2=A0 =C2=A0respectively<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0001/25:[----] [--] &#39;target/avr: Add outward fac=
ing interfaces and<br>
&gt;=C2=A0 =C2=A0 =C2=A0core CPU logic&#39;<br>
&gt;=C2=A0 =C2=A0 =C2=A0002/25:[----] [--] &#39;target/avr: Add instruction=
 helpers&#39;<br>
&gt;=C2=A0 =C2=A0 =C2=A0003/25:[----] [--] &#39;target/avr: Add instruction=
 translation -<br>
&gt;=C2=A0 =C2=A0 =C2=A0Registers definition&#39;<br>
&gt;=C2=A0 =C2=A0 =C2=A0004/25:[----] [--] &#39;target/avr: Add instruction=
 translation -<br>
&gt;=C2=A0 =C2=A0 =C2=A0Arithmetic and Logic Instructions&#39;<br>
&gt;=C2=A0 =C2=A0 =C2=A0005/25:[----] [--] &#39;target/avr: Add instruction=
 translation - Branch<br>
&gt;=C2=A0 =C2=A0 =C2=A0Instructions&#39;<br>
&gt;=C2=A0 =C2=A0 =C2=A0006/25:[----] [--] &#39;target/avr: Add instruction=
 translation - Data<br>
&gt;=C2=A0 =C2=A0 =C2=A0Transfer Instructions&#39;<br>
&gt;=C2=A0 =C2=A0 =C2=A0007/25:[----] [--] &#39;target/avr: Add instruction=
 translation - Bit<br>
&gt;=C2=A0 =C2=A0 =C2=A0and Bit-test Instructions&#39;<br>
&gt;=C2=A0 =C2=A0 =C2=A0008/25:[----] [--] &#39;target/avr: Add instruction=
 translation - MCU<br>
&gt;=C2=A0 =C2=A0 =C2=A0Control Instructions&#39;<br>
&gt;=C2=A0 =C2=A0 =C2=A0009/25:[----] [--] &#39;target/avr: Add instruction=
 translation - CPU<br>
&gt;=C2=A0 =C2=A0 =C2=A0main translation function&#39;<br>
&gt;=C2=A0 =C2=A0 =C2=A0010/25:[----] [--] &#39;target/avr: Add instruction=
 disassembly function&#39;<br>
&gt;=C2=A0 =C2=A0 =C2=A0011/25:[----] [--] &#39;hw/char: Add limited suppor=
t for Atmel USART<br>
&gt;=C2=A0 =C2=A0 =C2=A0peripheral&#39;<br>
&gt;=C2=A0 =C2=A0 =C2=A0012/25:[0045] [FC] &#39;hw/timer: Add limited suppo=
rt for Atmel 16 bit<br>
&gt;=C2=A0 =C2=A0 =C2=A0timer peripheral&#39;<br>
&gt;=C2=A0 =C2=A0 =C2=A0013/25:[----] [--] &#39;hw/misc: Add Atmel power de=
vice&#39;<br>
&gt;=C2=A0 =C2=A0 =C2=A0014/25:[0024] [FC] &#39;target/avr: Add section abo=
ut AVR into QEMU<br>
&gt;=C2=A0 =C2=A0 =C2=A0documentation&#39;<br>
&gt;=C2=A0 =C2=A0 =C2=A0015/25:[----] [--] &#39;target/avr: Register AVR su=
pport with the rest<br>
&gt;=C2=A0 =C2=A0 =C2=A0of QEMU&#39;<br>
&gt;=C2=A0 =C2=A0 =C2=A0016/25:[----] [--] &#39;target/avr: Add machine non=
e test&#39;<br>
&gt;=C2=A0 =C2=A0 =C2=A0017/25:[0002] [FC] &#39;target/avr: Update MAINTAIN=
ERS file&#39;<br>
&gt;=C2=A0 =C2=A0 =C2=A0018/25:[down]=C2=A0 =C2=A0 =C2=A0 &#39;hw/core/load=
er: Let load_elf populate the<br>
&gt;=C2=A0 =C2=A0 =C2=A0processor-specific flags&#39;<br>
&gt;=C2=A0 =C2=A0 =C2=A0019/25:[down]=C2=A0 =C2=A0 =C2=A0 &#39;hw/avr: Add =
helper to load raw/ELF firmware<br>
&gt;=C2=A0 =C2=A0 =C2=A0binaries&#39;<br>
&gt;=C2=A0 =C2=A0 =C2=A0020/25:[0015] [FC] &#39;hw/avr: Add some ATmega mic=
rocontrollers&#39;<br>
&gt;=C2=A0 =C2=A0 =C2=A0021/25:[0040] [FC] &#39;hw/avr: Add some Arduino bo=
ards&#39;<br>
&gt;=C2=A0 =C2=A0 =C2=A0022/25:[----] [--] &#39;target/avr: Update build sy=
stem&#39;<br>
&gt;=C2=A0 =C2=A0 =C2=A0023/25:[----] [--] &#39;tests/boot-serial-test: Tes=
t some Arduino boards<br>
&gt;=C2=A0 =C2=A0 =C2=A0(AVR based)&#39;<br>
&gt;=C2=A0 =C2=A0 =C2=A0024/25:[----] [--] &#39;tests/acceptance: Test the =
Arduino MEGA2560 board&#39;<br>
&gt;=C2=A0 =C2=A0 =C2=A0025/25:[----] [--] &#39;.travis.yml: Run the AVR ac=
ceptance tests&#39;<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Repo: <a href=3D"https://gitlab.com/philmd/qemu/com=
mits/avr-rc2" rel=3D"noreferrer" target=3D"_blank">https://gitlab.com/philm=
d/qemu/commits/avr-rc2</a><br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0[1] <a href=3D"https://www.mail-archive.com/qemu-de=
vel@nongnu.org/msg672926.html" rel=3D"noreferrer" target=3D"_blank">https:/=
/www.mail-archive.com/qemu-devel@nongnu.org/msg672926.html</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0Supersedes: &lt;<a href=3D"mailto:20200123000307.11=
541-1-richard.henderson@linaro.org" target=3D"_blank">20200123000307.11541-=
1-richard.henderson@linaro.org</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:20200123000307.11541-1=
-richard.henderson@linaro.org" target=3D"_blank">20200123000307.11541-1-ric=
hard.henderson@linaro.org</a>&gt;&gt;<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Michael Rolnik (20):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 target/avr: Add outward facing interfaces a=
nd core CPU logic<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 target/avr: Add instruction helpers<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 target/avr: Add instruction translation - R=
egisters definition<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 target/avr: Add instruction translation - A=
rithmetic and Logic<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Instructions<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 target/avr: Add instruction translation - B=
ranch Instructions<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 target/avr: Add instruction translation - D=
ata Transfer Instructions<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 target/avr: Add instruction translation - B=
it and Bit-test<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Instructions<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 target/avr: Add instruction translation - M=
CU Control Instructions<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 target/avr: Add instruction translation - C=
PU main translation<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 function<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 target/avr: Add instruction disassembly fun=
ction<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 hw/char: Add limited support for Atmel USAR=
T peripheral<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 hw/timer: Add limited support for Atmel 16 =
bit timer peripheral<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 hw/misc: Add Atmel power device<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 target/avr: Add section about AVR into QEMU=
 documentation<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 target/avr: Register AVR support with the r=
est of QEMU<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 target/avr: Add machine none test<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 target/avr: Update MAINTAINERS file<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 target/avr: Update build system<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 tests/boot-serial-test: Test some Arduino b=
oards (AVR based)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 tests/acceptance: Test the Arduino MEGA2560=
 board<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Philippe Mathieu-Daud=C3=A9 (5):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 hw/core/loader: Let load_elf populate the p=
rocessor-specific flags<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 hw/avr: Add helper to load raw/ELF firmware=
 binaries<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 hw/avr: Add some ATmega microcontrollers<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 hw/avr: Add some Arduino boards<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 .travis.yml: Run the AVR acceptance tests<b=
r>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0qemu-doc.texi=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A051 +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0configure=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 7 +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0default-configs/avr-softmmu.mak=C2=A0 |=C2=
=A0 =C2=A0 5 +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0qapi/machine.json=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 3 +-<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0hw/avr/atmel_atmega.h=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A048 +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0hw/avr/boot.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A033 +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0include/disas/dis-asm.h=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 |=C2=A0 =C2=A019 +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0include/elf.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 2 +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0include/hw/char/atmel_usart.h=C2=A0 =C2=A0 |=
=C2=A0 =C2=A093 +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0include/hw/elf_ops.h=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 6 +-<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0include/hw/loader.h=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 6 +-<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0include/hw/misc/atmel_power.h=C2=A0 =C2=A0 |=
=C2=A0 =C2=A046 +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0include/hw/timer/atmel_timer16.h |=C2=A0 =C2=
=A094 +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0include/sysemu/arch_init.h=C2=A0 =C2=A0 =C2=
=A0 =C2=A0|=C2=A0 =C2=A0 1 +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0target/avr/cpu-param.h=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A037 +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0target/avr/cpu-qom.h=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A054 +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0target/avr/cpu.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 259 +++<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0target/avr/helper.h=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A029 +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0arch_init.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 2 +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0hw/avr/arduino.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 151 ++<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0hw/avr/atmel_atmega.c=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 |=C2=A0 470 +++++<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0hw/avr/boot.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A074 +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0hw/char/atmel_usart.c=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 |=C2=A0 320 ++++<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0hw/core/loader.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A015 +-<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0hw/misc/atmel_power.c=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 |=C2=A0 112 ++<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0hw/riscv/boot.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 2 +-<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0hw/timer/atmel_timer16.c=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0|=C2=A0 605 ++++++<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0target/avr/cpu.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 826 ++++++++<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0target/avr/disas.c=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 246 +++<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0target/avr/gdbstub.c=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A084 +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0target/avr/helper.c=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 347 ++++<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0target/avr/machine.c=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 121 ++<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0target/avr/translate.c=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0| 2997 ++++++++++++++++++++++++++++++<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0tests/qtest/boot-serial-test.c=C2=A0 =C2=A0|=
=C2=A0 =C2=A011 +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0tests/qtest/machine-none-test.c=C2=A0 |=C2=
=A0 =C2=A0 1 +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0.travis.yml=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 2 +-<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0MAINTAINERS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A030 +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0gdb-xml/avr-cpu.xml=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A049 +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0hw/avr/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 9 +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0hw/avr/Makefile.objs=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 3 +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0hw/char/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 3 +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0hw/char/Makefile.objs=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 1 +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0hw/misc/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 3 +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0hw/misc/Makefile.objs=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 2 +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0hw/timer/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 3 +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0hw/timer/Makefile.objs=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 2 +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0target/avr/Makefile.objs=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0|=C2=A0 =C2=A034 +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0target/avr/insn.decode=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0|=C2=A0 182 ++<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0tests/acceptance/machine_avr6.py |=C2=A0 =C2=
=A050 +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0tests/qtest/Makefile.include=C2=A0 =C2=A0 =
=C2=A0|=C2=A0 =C2=A0 2 +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A050 files changed, 7539 insertions(+), 13 del=
etions(-)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0create mode 100644 default-configs/avr-softm=
mu.mak<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0create mode 100644 hw/avr/atmel_atmega.h<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0create mode 100644 hw/avr/boot.h<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0create mode 100644 include/hw/char/atmel_usa=
rt.h<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0create mode 100644 include/hw/misc/atmel_pow=
er.h<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0create mode 100644 include/hw/timer/atmel_ti=
mer16.h<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0create mode 100644 target/avr/cpu-param.h<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0create mode 100644 target/avr/cpu-qom.h<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0create mode 100644 target/avr/cpu.h<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0create mode 100644 target/avr/helper.h<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0create mode 100644 hw/avr/arduino.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0create mode 100644 hw/avr/atmel_atmega.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0create mode 100644 hw/avr/boot.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0create mode 100644 hw/char/atmel_usart.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0create mode 100644 hw/misc/atmel_power.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0create mode 100644 hw/timer/atmel_timer16.c<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0create mode 100644 target/avr/cpu.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0create mode 100644 target/avr/disas.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0create mode 100644 target/avr/gdbstub.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0create mode 100644 target/avr/helper.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0create mode 100644 target/avr/machine.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0create mode 100644 target/avr/translate.c<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0create mode 100644 gdb-xml/avr-cpu.xml<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0create mode 100644 hw/avr/Kconfig<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0create mode 100644 hw/avr/Makefile.objs<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0create mode 100644 target/avr/Makefile.objs<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0create mode 100644 target/avr/insn.decode<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0create mode 100644 tests/acceptance/machine_=
avr6.py<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0-- <br>
&gt;=C2=A0 =C2=A0 =C2=A02.21.1<br>
&gt; <br>
&gt; <br>
&gt; <br>
&gt; -- <br>
&gt; Best Regards,<br>
&gt; Michael Rolnik<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature">Best Regards,<br>Michael Rolnik</div>

--000000000000ab9b00059ce358ac--

--000000000000ab9b01059ce358ae
Content-Type: application/octet-stream; 
	name="0001-target-avr-Add-section-about-AVR-into-QEMU-documenta.patch"
Content-Disposition: attachment; 
	filename="0001-target-avr-Add-section-about-AVR-into-QEMU-documenta.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_k5s8tb2p0>
X-Attachment-Id: f_k5s8tb2p0

RnJvbSA3YTAzODcyZTg5MmIwZWQ5NWJiZjZhMzRiOGRhMmE2N2Y2NWFlZDA3IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBNaWNoYWVsIFJvbG5payA8bXJvbG5pa0BnbWFpbC5jb20+CkRh
dGU6IEZyaSwgMjQgSmFuIDIwMjAgMDE6NTE6MjAgKzAxMDAKU3ViamVjdDogW1BBVENIXSB0YXJn
ZXQvYXZyOiBBZGQgc2VjdGlvbiBhYm91dCBBVlIgaW50byBRRU1VIGRvY3VtZW50YXRpb24KTUlN
RS1WZXJzaW9uOiAxLjAKQ29udGVudC1UeXBlOiB0ZXh0L3BsYWluOyBjaGFyc2V0PVVURi04CkNv
bnRlbnQtVHJhbnNmZXItRW5jb2Rpbmc6IDhiaXQKClNpZ25lZC1vZmYtYnk6IE1pY2hhZWwgUm9s
bmlrIDxtcm9sbmlrQGdtYWlsLmNvbT4KTWVzc2FnZS1JZDogPDIwMjAwMTE4MTkxNDE2LjE5OTM0
LTE2LW1yb2xuaWtAZ21haWwuY29tPgpTaWduZWQtb2ZmLWJ5OiBSaWNoYXJkIEhlbmRlcnNvbiA8
cmljaGFyZC5oZW5kZXJzb25AbGluYXJvLm9yZz4KW1BNRDogRml4ZWQgdHlwb3NdClNpZ25lZC1v
ZmYtYnk6IFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIDxmNGJ1Z0BhbXNhdC5vcmc+Ci0tLQogcWVt
dS1kb2MudGV4aSB8IDUxICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKwogMSBmaWxlIGNoYW5nZWQsIDUxIGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQg
YS9xZW11LWRvYy50ZXhpIGIvcWVtdS1kb2MudGV4aQppbmRleCAyMzI4ZTdlYTQ3Li5hYWY0ZTU0
NzhlIDEwMDY0NAotLS0gYS9xZW11LWRvYy50ZXhpCisrKyBiL3FlbXUtZG9jLnRleGkKQEAgLTE3
MjMsNiArMTcyMyw3IEBAIGRpZmZlcmVuY2VzIGFyZSBtZW50aW9uZWQgaW4gdGhlIGZvbGxvd2lu
ZyBzZWN0aW9ucy4KICogTWljcm9ibGF6ZSBTeXN0ZW0gZW11bGF0b3I6OgogKiBTSDQgU3lzdGVt
IGVtdWxhdG9yOjoKICogWHRlbnNhIFN5c3RlbSBlbXVsYXRvcjo6CisqIEFWUiBTeXN0ZW0gZW11
bGF0b3I6OgogQGVuZCBtZW51CiAKIEBub2RlIFBvd2VyUEMgU3lzdGVtIGVtdWxhdG9yCkBAIC0y
NDk2LDYgKzI0OTcsNTYgQEAgc28gc2hvdWxkIG9ubHkgYmUgdXNlZCB3aXRoIHRydXN0ZWQgZ3Vl
c3QgT1MuCiAKIEBjIG1hbiBlbmQKIAorQG5vZGUgQVZSIFN5c3RlbSBlbXVsYXRvcgorQHNlY3Rp
b24gQVZSIFN5c3RlbSBlbXVsYXRvcgorQGNpbmRleCBzeXN0ZW0gZW11bGF0aW9uIChBVlIpCisK
K1VzZSB0aGUgZXhlY3V0YWJsZSBAZmlsZXtxZW11LXN5c3RlbS1hdnJ9IHRvIGVtdWxhdGVzIGEg
QVZSIDggYml0IGJhc2VkIG1hY2hpbmUKK2hhdmluZyBvbmUgZm9yIHRoZSBmb2xsb3dpbmcgY29y
ZXM6IGF2cjEsIGF2cjIsIGF2cjI1LCBhdnIzLCBhdnIzMSwgYXZyMzUsIGF2cjQsCithdnI1LCBh
dnI1MSwgYXZyNiwgYXZydGlueSwgeG1lZ2EyLCB4bWVnYTMsIHhtZWdhNCwgeG1lZ2E1LCB4bWVn
YTYgYW5kIHhtZWdhNy4KKworQXMgZm9yIG5vdyBpdCBzdXBwb3J0cyBmZXcgQXJkdWlubyBib2Fy
ZHMgZm9yIGVkdWNhdGlvbmFsIGFuZCB0ZXN0aW5nIHB1cnBvc2VzLgorVGhlc2UgYm9hcmRzIHVz
ZSBhIEFUbWVnYSBjb250cm9sbGVyLCB3aGljaCBtb2RlbCBpcyBsaW1pdGVkIHRvIFVTQVJUICYg
MTYgYml0Cit0aW1lciBkZXZpY2VzLCBlbm91Z2h0IHRvIHJ1biBGcmVlUlRPUyBiYXNlZCBhcHBs
aWNhdGlvbnMgKGxpa2UgdGhpcyBAdXJse2h0dHBzOi8vZ2l0aHViLmNvbS9zZWhhcnJpcy9xZW11
LWF2ci10ZXN0cy9ibG9iL21hc3Rlci9mcmVlLXJ0b3MvRGVtby9BVlJfQVRNZWdhMjU2MF9HQ0Mv
ZGVtby5lbGYsLGRlbW99KQorCitGb2xsb3dpbmcgYXJlIGV4YW1wbGVzIG9mIHBvc3NpYmxlIHVz
YWdlcywgYXNzdW1pbmcgZGVtby5lbGYgaXMgY29tcGlsZWQgZm9yCitBVlIgY3B1CitAaXRlbWl6
ZQorCitAaXRlbSBDb250aW51b3VzIG5vbiBpbnRlcnJ1cHRlZCBleGVjdXRpb24KK0BleGFtcGxl
CitxZW11LXN5c3RlbS1hdnIgLW1hY2hpbmUgbWVnYTI1NjAgLWJpb3MgZGVtby5lbGYKK0BlbmQg
ZXhhbXBsZQorCitAaXRlbSBDb250aW51b3VzIG5vbiBpbnRlcnJ1cHRlZCBleGVjdXRpb24gd2l0
aCBzZXJpYWwgb3V0cHV0IGludG8gdGVsbmV0IHdpbmRvdworQGV4YW1wbGUKK3FlbXUtc3lzdGVt
LWF2ciAtbWFjaGluZSBtZWdhMjU2MCAtYmlvcyBkZW1vLmVsZiAtc2VyaWFsIHRjcDo6NTY3OCxz
ZXJ2ZXIsbm93YWl0IC1ub2dyYXBoaWMKK0BlbmQgZXhhbXBsZQorYW5kIHRoZW4gaW4gYW5vdGhl
ciBzaGVsbAorQGV4YW1wbGUKK3RlbG5ldCBsb2NhbGhvc3QgNTY3OAorQGVuZCBleGFtcGxlCisK
K0BpdGVtIERlYnVnZ2luZyB3aXQgR0RCIGRlYnVnZ2VyCitAZXhhbXBsZQorcWVtdS1zeXN0ZW0t
YXZyIC1tYWNoaW5lIG1lZ2EyNTYwIC1iaW9zIGRlbW8uZWxmIC1zIC1TCitAZW5kIGV4YW1wbGUK
K2FuZCB0aGVuIGluIGFub3RoZXIgc2hlbGwKK0BleGFtcGxlCithdnItZ2RiIGRlbW8uZWxmCitA
ZW5kIGV4YW1wbGUKK2FuZCB0aGVuIHdpdGhpbiBHREIgc2hlbGwKK0BleGFtcGxlCit0YXJnZXQg
cmVtb3RlIDoxMjM0CitAZW5kIGV4YW1wbGUKKworQGl0ZW0gUHJpbnQgb3V0IGV4ZWN1dGVkIGlu
c3RydWN0aW9ucworQGV4YW1wbGUKK3FlbXUtc3lzdGVtLWF2ciAtbWFjaGluZSBtZWdhMjU2MCAt
YmlvcyBkZW1vLmVsZiAtZCBpbl9hc20KK0BlbmQgZXhhbXBsZQorCitAZW5kIGl0ZW1pemUKKwog
QG5vZGUgUUVNVSBVc2VyIHNwYWNlIGVtdWxhdG9yCiBAY2hhcHRlciBRRU1VIFVzZXIgc3BhY2Ug
ZW11bGF0b3IKIAotLSAKMi4xNy4yIChBcHBsZSBHaXQtMTEzKQoK
--000000000000ab9b01059ce358ae--

